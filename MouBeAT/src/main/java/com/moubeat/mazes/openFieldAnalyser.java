
package com.moubeat.mazes;

import java.awt.Frame;
import java.awt.Polygon;
import java.util.ArrayList;

import ij.IJ;
import ij.ImageJ;
import ij.ImagePlus;
import ij.WindowManager;
import ij.gui.PointRoi;
import ij.gui.Roi;
import ij.measure.Measurements;
import ij.plugin.ImageCalculator;
import ij.plugin.PlugIn;
import ij.plugin.ZProjector;
import ij.plugin.filter.ParticleAnalyzer;
import ij.plugin.frame.RoiManager;
import ij.process.AutoThresholder;
import ij.process.ImageProcessor;

/**
 * @author haduarte
 *
 */




public class openFieldAnalyser implements PlugIn, Listener {
	
	//Get the image in focus from ImageJ
	protected ImagePlus img = IJ.getImage();
	
	
	@Override
	public void run(String arg0) {
		
		//Check to see if it is a stack if not return
		final int n = img.getNSlices();
		if (n <= 1) {
			IJ.error("This plugin requires a stack!");
			return;
		}
		
		//Add a listener to call SuperGui and stop this process
		InitiaterListener.getInstance().addListener(this);
		new SuperGUI();

	}
	
	/*
	 * Main process of this class 
	 */
	public void mainProcess() {
		
		/*convert to 8 bit of not the case */
		if (img.getBitDepth() > 8)
			IJ.run("8-bit");
		
		//Get the size of the cube base from parameT
		Roi rect = parameT.getInstance().getRect();
		
		//Print out some of the parameters of the image
		/*System.out.println("test");
		System.out.println("Width=" + (parameT.getInstance().getW()));
		System.out.println("Height=" + (parameT.getInstance().getH()));
		System.out.println("Px = " + (parameT.getInstance().getW() / rect.getFloatWidth()));
		System.out.println("Py= " + (parameT.getInstance().getH() / rect.getFloatHeight()));*/
		
		//Adjust bckgr color depending to user choice from parameT
		int colorBack;
		if (parameT.getInstance().getChoice().equals("WOB"))
			colorBack = 0;
		else
			colorBack = 255;
		IJ.setBackgroundColor(colorBack, colorBack, colorBack);
		
		//ImagePlus tempImg = img;
		//Set cube base roi in the image to clear outside
		img.setRoi((int) parameT.getInstance().getRect().getXBase() - 15,
				(int) parameT.getInstance().getRect().getYBase() - 15,
				(int) parameT.getInstance().getRect().getFloatWidth() + 30,
				(int) parameT.getInstance().getRect().getFloatHeight() + 30);
		
		
		//and clear outside
		IJ.run(img, "Clear Outside", "stack");
		img.updateAndDraw();
		
		//Do a guassian blur if so selected
		if (parameT.getInstance().getSigma() > 0)
			IJ.run(img, "Gaussian Blur...", "sigma=" + parameT.getInstance().getSigma() + " stack");
		img.updateAndDraw();
		
		//Create a new image container
		ImagePlus img3;
		
		//Perfom the dark vader function is so selected
		if (parameT.getInstance().getVader()) {

			int[] ilVader = parameT.getInstance().getStagCoor();

			// do the median projection
			ZProjector zp = new ZProjector();
			zp.setImage(img);
			zp.setMethod(ZProjector.MEDIAN_METHOD);
			zp.setStartSlice(ilVader[0]);
			zp.setStopSlice(ilVader[1]);
			zp.doProjection();
			ImagePlus img2 = zp.getProjection();

			// img2.show();
			
			ImageCalculator ic = new ImageCalculator();
			ic.run("Difference stack", img, img2);

			IJ.run(img, "Gaussian Blur...", "sigma=2 stack");
			img.updateAndDraw();

		} else {
			img3 = img;
			// img3.show();
		}
		
		//Adjust for analyze start and end coordinates	
		int iStg, lStg;
		if (parameT.getInstance().getStagger()) {
			int[] ilStg = parameT.getInstance().getStagCoor();
			iStg = ilStg[0];
			lStg = ilStg[1];

		} else {
			iStg = 1;
			lStg = img.getNSlices();
		}
		//System.out.println(iStg + lStg);
		
		//getinstance of the roiLists
		roiLists rl = roiLists.getInstance();
		
		//Create and fill up the list of ROIs of the 
		//ArrayList<Roi> roiList = new ArrayList<Roi>();
		//ArrayList<Roi> roiList2 = new ArrayList<Roi>();
		Roi temp, temp2;
		
		//Create the roiManagers to hold your selections
		RoiManager rm = new RoiManager();
		//RoiManager rm2 = new RoiManager();
		rm.setVisible(false);
		//rm2.setVisible(false);
		
		//Create an image processor
		ImageProcessor ip = img.getProcessor();
	
		//ThresholdToSelection tts = new ThresholdToSelection();
		//Create the particle analyzer
		ParticleAnalyzer pa = new ParticleAnalyzer(ParticleAnalyzer.ADD_TO_MANAGER | ParticleAnalyzer.INCLUDE_HOLES | ParticleAnalyzer.LIMIT,
				Measurements.AREA, null, 500, 1000000);
		pa.setRoiManager(rm);
		
		
		//analyse frame by frame movie to find the mice
		for (int i = iStg; i <= lStg; i++) {
			IJ.showProgress(i, lStg);
			img.setSlice(i);
			//Set threshold to detect the body of the mouse and its center
			ip.setAutoThreshold(AutoThresholder.Method.Minimum, true);
			pa.analyze(img, ip);
			temp = rm.getRoi(rm.getCount()-1);
			if (temp != null) {
				temp.setPosition(0, i, i);
				rl.addRoi(temp, true);
			}
			//Same as above but to include a bit of the tail also
			ip.setAutoThreshold(AutoThresholder.Method.MaxEntropy, true);
			pa.analyze(img, ip);
			temp2 = rm.getRoi(rm.getCount()-1);
			if (temp2 != null) {
				temp2.setPosition(0, i, i);
				rl.addRoi(temp2, false);
			}
		}
		
		//hide the summary table that appears from the particle analyzer...
		Frame sum = WindowManager.getFrame("Summary of " + img.getTitle());
		sum.setVisible(false);
		
		//Create an arrayList of points to hold the center, head and tail of the mouse
		ArrayList<PointRoi> pointList = new ArrayList<PointRoi>();
		
		//Create an array of frame positions for each of the multipoints
		int[] sList = new int[rl.getSize(0)];
		
		//Arrays to temp hold the coordinates
		double[] coordt;
		float[] coordh = new float[2];
		float[] coordx = new float[2];
		float[] coordy = new float[2];
		
		//Main loop to find the center, head and tail of the mouse
		//Calls getHead function to get the head and the tail
		for (int j = 0; j < rl.getSize(0); j++) {
			IJ.showProgress(j, rl.getSize(0));
			temp = rl.getRoi(j, true);					//get selection
			sList[j] = temp.getTPosition();			//get frame of selection
			coordt = temp.getContourCentroid();		//get center of selection
			coordx[0] = (float) coordt[0];			//add center coord to temp float array
			coordy[0] = (float) coordt[1];
			//if(j==0)
				coordh = getHead(temp, coordt);			//get head coord
//			else
//				coordh = getHead(temp, coordt, pointList.get(j-1), 0);
			coordx[1] = coordh[0];					//get head coord to array
			coordy[1] = coordh[1];
//			degrees.add((double) coordh[2]);
			temp = rl.getRoi(j, false);					//get selection with tail
//			if(j==0)
//				coordh = getHead(temp, coordt, null, 1);			//get tail coord
//			else
//				coordh = getHead(temp, coordt, pointList.get(j-1), 1);
//			coordx[2] = coordh[0];					//add tail point to float arrays
//			coordy[2] = coordh[1];
			rl.addPoint(new PointRoi(coordx, coordy));	//add new multipoints to the list
//			img.setSlice(j + 1);							//move forward n the slices
			// rm1.add(img3, new PointRoi(coord3, coord1), j);
		}
		
		rm.runCommand(img, "Show None");
		ip.resetThreshold();
		new SuperGUI(sList);
		

	}

	
	private float[] getHead(Roi contor, double[] center) {

		Polygon temp = contor.getPolygon();
		int[] xc = temp.xpoints;
		int[] yc = temp.ypoints;
		//int[] xcold = null, ycold = null;
//		if(point != null) {
//			xcold = point.getXCoordinates();
//			ycold = point.getYCoordinates();
//		}
		float[] index = new float[2];
		double max = 0;
		int p = 0;
		double dis = 0;

		for (int i = 0; i < xc.length; i++) {
			dis = Math.sqrt((xc[i] - center[0]) * (xc[i] - center[0]) + (yc[i] - center[1]) * (yc[i] - center[1]));
			if (dis > max) {
					max = dis;
					p = i;
				}
				
			}


		index[0] = (float) xc[p];
		index[1] = (float) yc[p];

		return index;

	}

/*	private double angleBetween(int newheadx, int newheady, double centerx, double centery, int oldheadx, int oldheady) {

//		  double temp =  Math.toDegrees(Math.atan2(oldheadx - centerx,oldheady - centery)-
//		                        Math.atan2(newheadx- centerx,newheady- centery));
//		  if(temp < 0)
//			  temp += 360;
		  
		double temp = Math.sqrt(Math.pow((oldheadx-newheadx), 2) + Math.pow((oldheady-newheady), 2));
		  return temp;
	}
	*/
	
	/**
	 * Main method for debugging.
	 *
	 * For debugging, it is convenient to have a method that starts ImageJ, loads
	 * an image and calls the plugin, e.g. after setting breakpoints.
	 *
	 * @param args unused
	 */
	public static void main(String[] args) {
		Class<?> clazz = openFieldAnalyser.class;
		String url = clazz.getResource("/" + clazz.getName().replace('.', '/') + ".class").toString();
		String pluginsDir = url.substring("file:".length(),
				url.length() - clazz.getName().length() - ".class".length());
		System.setProperty("plugins.dir", pluginsDir);

		new ImageJ();

		ImagePlus image = IJ.openImage("P:\\Mice\\Cube\\cubemaize.tif");

		image.show();
		
		IJ.runPlugIn(clazz.getName(), "");

		new openFieldAnalyser();

	}
	
	//Listener gets signal to continue this process at mainProcess
	@Override
	public void changeeFlag() {
		System.out.println("Hello...");
		mainProcess();

	}

}
