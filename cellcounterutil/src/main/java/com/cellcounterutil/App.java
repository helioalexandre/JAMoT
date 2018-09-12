package com.cellcounterutil;

import java.io.IOException;
import java.util.ArrayList;
import org.scijava.util.XML;
import org.w3c.dom.Element;
import org.xml.sax.SAXException;

import javax.swing.JFileChooser;
import javax.xml.parsers.ParserConfigurationException;

import ij.*;
import ij.plugin.PlugIn;
import ij.process.ImageProcessor;
import ij.gui.GenericDialog;
import ij.gui.OvalRoi;


public class App implements PlugIn 
{	
	private String[] colors = {"red", "green", "blue", "yellow", "pink", "white"};
	private String[] colorSet = new String[9];
	boolean[] flg = new boolean[9];
	
	@Override
	public void run(String args){
		
		ImagePlus img = IJ.getImage();
		int w = img.getWidth();
		int h = img.getHeight();
		
		ImagePlus img2 = IJ.createImage(img.getTitle()+"_points", "RGB black", w, h, 1);
		

		JFileChooser fc = new JFileChooser();
        fc.setFileSelectionMode(JFileChooser.FILES_ONLY); 
        fc.showDialog(fc, "Select XML file");
		
        
		XML f = null;
		try {
			f = new XML(fc.getSelectedFile());
		} catch (ParserConfigurationException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (SAXException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		
		//System.out.println(f.getPath());
		int[] count = new int[9];
		for(int i = 1; i < 9; i++) {
			count[i] = f.elements("/CellCounter_Marker_File/Marker_Data/Marker_Type[Type='"+i+"']/Marker").size();
			//System.out.println(count[i]);
		}
		
		
		Generic_Dialog_Example(count);
		
		for(int i = 1; i < flg.length; i++) {
			if(flg[i]) {
				int[] temp = setColors(i);
				IJ.setForegroundColor(temp[0], temp[1], temp[2]);
				ArrayList<Element> nodesx = f.elements("/CellCounter_Marker_File/Marker_Data/Marker_Type[Type='"+i+"']/Marker/MarkerX");
				ArrayList<Element> nodesy = f.elements("/CellCounter_Marker_File/Marker_Data/Marker_Type[Type='"+i+"']/Marker/MarkerY");
				for(int j = 0; j < nodesx.size(); j++) {
					IJ.showProgress(j, nodesx.size());
					img2.setRoi(new OvalRoi(Integer.parseInt(nodesx.get(j).getTextContent())-4, Integer.parseInt(nodesy.get(j).getTextContent())-4, 8, 8));
					IJ.run(img2, "Fill", "slice");
				}
			}
		}

		IJ.run(img2, "Select None", "");
	
		img2.show();

	}

	public void Generic_Dialog_Example(int[] c) {
		
		GenericDialog gd = new GenericDialog("Choose which points to draw...");
		for (int i = 1; i < 9; i++) {
			if (c[i] > 0) {
				gd.addCheckbox("Draw " + c[i] + " from label " + i, true);
				gd.addChoice("Color for this points", colors, colors[0]);
			}
		}
		gd.showDialog();
		if (gd.wasCanceled())
			return;
		
		for (int i = 1; i < 9; i++) {
			if (c[i] > 0) {
				flg[i] = gd.getNextBoolean();
				colorSet[i] = gd.getNextChoice();
			}
		}
		
	}
	
	public int[] setColors(int i) {
		
		int[] rgb = new int[3];

		if(colorSet[i]=="red") {
			rgb[0] = 255; rgb[1] = 0; rgb[2] = 0;
		}else if(colorSet[i] == "green") {
			rgb[0] = 0; rgb[1] = 255; rgb[2] = 0;
		}else if(colorSet[i] == "blue") {
			rgb[0] = 0; rgb[1] = 0; rgb[2] = 255;
		}else if(colorSet[i] == "yellow") {
			rgb[0] = 255; rgb[1] = 255; rgb[2] = 0;
		}else if(colorSet[i] == "pink") {
			rgb[0] = 255; rgb[1] = 0; rgb[2] = 255;
		}else if(colorSet[i] == "white") {
			rgb[0] = 255; rgb[1] = 255; rgb[2] = 255;
		}
		
		return rgb;
	}

	 

	/**
	 * Main method for debugging.
	 *
	 * For debugging, it is convenient to have a method that starts ImageJ, loads
	 * an image and calls the plugin, e.g. after setting breakpoints.
	 *
	 */
	public static void main(String[] args) {
		// set the plugins.dir property to make the plugin appear in the Plugins menu
		Class<?> clazz = App.class;
		String url = clazz.getResource("/" + clazz.getName().replace('.', '/') + ".class").toString();
		String pluginsDir = url.substring("file:".length(), url.length() - clazz.getName().length() - ".class".length());
		System.setProperty("plugins.dir", pluginsDir);

		// start ImageJ
		new ImageJ();

		// open the Clown sample
		IJ.open();
		

		// run the plugin
		IJ.runPlugIn(clazz.getName(), "");
		new App();
		
		//Process_Pixels test = new Process_Pixels();
		//test.run(null);
	}


	
}
