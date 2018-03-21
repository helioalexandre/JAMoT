/*
 * To the extent possible under law, the ImageJ developers have waived
 * all copyright and related or neighboring rights to this tutorial code.
 *
 * See the CC0 1.0 Universal license for details:
 *     http://creativecommons.org/publicdomain/zero/1.0/
 */

package com.opt3dstitching;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.stream.Collectors;
import javax.swing.JFileChooser;

import ij.IJ;
import ij.ImageJ;
import ij.ImagePlus;
import ij.plugin.PlugIn;

/**
 * A template for processing each pixel of either
 * GRAY8, GRAY16, GRAY32 or COLOR_RGB images.
 *
 * @author Helio Roque
 */
public class Opt3d_Stitch implements PlugIn{
	
	//ImagePlus imp;
	
	@Override
	public void run(String args){
		
	
		JFileChooser fc = new JFileChooser();
        fc.setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY); 
        fc.showDialog(fc, "Select Directory");
		
		File f = fc.getSelectedFile();
		
		
		System.out.println(f.getPath());
		ArrayList<String> list = new ArrayList<String>(Arrays.asList(f.list()));
		
		ArrayList<String> zlist = new ArrayList<String>(0);
		
		String temp = null;
		Float tempx = null;
		Float tempy = null;
		
		Float px = (float) 1.0;
		int line = 0;
		
		//Pattern pattern = Pattern.compile("_Z([0-9]{1})\\.([0-9]{3})_");
		
		//Comparator<String> comparator = Comparator.<String, Boolean>comparing(s -> s.contains(part));
		
		for (String s:list){
			if(!s.startsWith("Background") && s.startsWith(f.getName()) && s.endsWith(".tif")){
				
				temp = s.substring(s.indexOf("_Z")+2, s.indexOf("_Z")+7);
				if(!zlist.contains(temp)) {
					zlist.add(temp);
				}
				
			}else if(s.startsWith(f.getName()) && s.endsWith(".txt")) {
				
				try {
					BufferedReader tempf = Files.newBufferedReader(Paths.get(f.getPath()+File.separator+s));
					ArrayList<String> templist = new ArrayList<String>(tempf.lines().collect(Collectors.toList()));
					for(String tempfs:templist) {
						if(tempfs.startsWith("# X-Pixelsize (mm/pixell):"))
							line = templist.indexOf(tempfs);
					}
					
					px = Float.parseFloat(templist.get(line+1));
				} catch (FileNotFoundException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					System.exit(0);
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			}
		}
		
		
		for(String s:zlist) {
			String filename = f.getPath() + File.separator + "TileConfiguration" + s + ".txt";
			System.out.println(filename);
			try {
				PrintWriter fstream = new PrintWriter(filename, "UTF-8");
				fstream.println("#Dimensions working with:");
				fstream.println("dim = 2");
				fstream.println("#Image for tile");
				for(String ss:list) {
					if(!ss.startsWith("Background") && ss.endsWith(".tif") && ss.contains("_Z"+s)) {
						tempx = (float) (Float.parseFloat(ss.substring(ss.indexOf("_X")+2, ss.indexOf("_X")+7))/px);
						tempy = (float) (Float.parseFloat(temp = ss.substring(ss.indexOf("_Y")+2, ss.indexOf("_Y")+7))/px);
						fstream.println(ss + "; ;(" + tempx.toString() + ","+ tempy.toString() +")");
					}
				}
				fstream.close();
				
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
			
	
		
		
		for(String s:zlist) {
			IJ.run("Grid/Collection stitching", "type=[Positions from file] order=[Defined by TileConfiguration] directory="+f.getPath()+" layout_file=TileConfiguration"+s+".txt fusion_method=[Linear Blending] regression_threshold=0.30 max/avg_displacement_threshold=2.50 absolute_displacement_threshold=3.50 computation_parameters=[Save memory (but be slower)] image_output=[Fuse and display]");
			ImagePlus imp = IJ.getImage();
			IJ.saveAs(imp, "Tiff", f.getPath()+File.separator+"Fused"+s+".tif");
			imp.close();
		}
		
		IJ.run("Image Sequence...", "open="+f.getPath()+File.separator+"Fused"+zlist.get(0)+".tif number="+zlist.size()+" file=Fused sort");
		ImagePlus imp = IJ.getImage();
		IJ.saveAs(imp, "Tiff", f.getPath()+File.separator+f.getName()+"Fusion.tif");
		
		for(File fs:f.listFiles()) {
			if(fs.getName().startsWith("Fused"))
				fs.delete();
			
		}
	}



	/**
	 * Main method for debugging.
	 *
	 * For debugging, it is convenient to have a method that starts ImageJ, loads
	 * an image and calls the plugin, e.g. after setting breakpoints.
	 *
	 * @param args unused
	 */
	public static void main(String[] args) {
		// set the plugins.dir property to make the plugin appear in the Plugins menu
		Class<?> clazz = Opt3d_Stitch.class;
		String url = clazz.getResource("/" + clazz.getName().replace('.', '/') + ".class").toString();
		String pluginsDir = url.substring("file:".length(), url.length() - clazz.getName().length() - ".class".length());
		System.setProperty("plugins.dir", pluginsDir);

		// start ImageJ
		new ImageJ();

		// open the Clown sample
		//ImagePlus image = IJ.openImage("http://imagej.net/images/clown.jpg");
		//image.show();

		// run the plugin
		IJ.runPlugIn(clazz.getName(), "");
		
		//Process_Pixels test = new Process_Pixels();
		//test.run(null);
	}


	
}
