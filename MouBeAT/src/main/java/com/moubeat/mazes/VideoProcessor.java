

package com.moubeat.mazes;

/*
 * Process avi files to open in imageJ
 * Requires AVI_Reader plugin
 * @author Helio Roque
 * 
 */


import java.io.File;

import javax.swing.JFileChooser;
import javax.swing.filechooser.FileFilter;
import javax.swing.filechooser.FileNameExtensionFilter;

import org.scijava.ItemVisibility;
import org.scijava.app.StatusService;
import org.scijava.log.LogService;
import org.scijava.plugin.Parameter;
import ij.IJ;
import ij.ImageJ;
import ij.ImagePlus;
import ij.gui.YesNoCancelDialog;
import ij.plugin.AVI_Reader;
import ij.plugin.PlugIn;



public class VideoProcessor implements PlugIn {
	
	@Parameter
	private IJ ij;
	
	@Parameter
	private LogService log;
	
	@Parameter
	private StatusService statusService;
	
	@Parameter(visibility = ItemVisibility.MESSAGE)
	private final String header1 = "Warning: this plugin requires ffmpeg.exe to be in the system path";
	
	@Parameter(visibility = ItemVisibility.MESSAGE)
	private final String header2 = "or in the folder of the current image or in the ImageJ macro folder.";
	
	/*@Parameter(label = "File to open:")
	private File file;*/
	
	@Override
	public void run(String arg){
		IJ.showStatus("Running MouBeAT Video Processor...");
		//Try to free memory to load video afterwards
		//IJ.freeMemory();
		
		JFileChooser fc = new JFileChooser();
        fc.setFileSelectionMode(JFileChooser.FILES_ONLY); 
        FileFilter filter = new FileNameExtensionFilter("Movie files", "avi", "mp4", "mpeg", "mov");
        fc.setFileFilter(filter);
        fc.showDialog(fc, "Select file to convert");
		
		File f = fc.getSelectedFile();
		
		
		System.out.println(f.getPath());
		
		//Create file string to check if converted file already exists
		File checkFile = new File(f.getPath()+".converted.avi");
		String commands;
		
		//Look for ffmpeg.exe
		File macrosFF = new File(IJ.getDirectory("macros")+ File.separator + "toolsets"+ File.separator +"ffmpeg.exe");
		System.out.println(macrosFF);
		String path = System.getenv("PATH");
		System.out.println(path);
		File imageFF = new File(f.getParent()+ File.separator+"ffmpeg.exe");
		System.out.println(imageFF);
		
		//Create commands str for ffmpeg.exe conversion from avi
		if(path.toLowerCase().contains("ffmpeg.exe"))
			commands = "ffmpeg.exe -loglevel quiet -i " + f.getPath() + " -f avi -vcodec mjpeg " + checkFile.getPath();
		else if(macrosFF.exists())
			commands = macrosFF.getAbsolutePath()+ " -loglevel quiet -i " + f.getPath() + " -f avi -vcodec mjpeg " + checkFile.getPath();
		else if(imageFF.exists())
			commands = imageFF.getAbsolutePath() + " -loglevel quiet -i " + f.getPath() + " -f avi -vcodec mjpeg " 
					+ checkFile.getPath();
		else{
			IJ.showMessage("ffmepg.exe not detected in system! Exiting...");
			return;
		}
		
		//If ffmpeg.exe is present decide what to do if cenverted file is also present
		if(checkFile.exists()){
			final YesNoCancelDialog whatToDo = new YesNoCancelDialog(null,"File exists...", "What do u wanna do? Yes - replace it, No - use that file, Cancel - stop the plugin!");
			if(whatToDo.yesPressed()){
					checkFile.delete();
					
					//Try to run the ffmpeg.exe process
					try{
						Runtime rt = Runtime.getRuntime();
						System.out.println(commands);
						IJ.showStatus("Converting file...");
						Process proc = rt.exec(commands);
						int exitVal = proc.waitFor();
						System.out.println("Process exitValue: " + exitVal);
					
					}catch (Throwable t){
						t.printStackTrace();
						IJ.log("Conversion failed for unkown reason...");
					}
			}else if(whatToDo.cancelPressed()){
				return;
			}else{
				
			}
		
			//Go straight to trying to run ffmpeg.exe if converted file does not exist
		}else{
			try{
				Runtime rt = Runtime.getRuntime();
				System.out.println(commands);
				IJ.showStatus("Converting file...");
				Process proc = rt.exec(commands);
				int exitVal = proc.waitFor();
				System.out.println("Process exitValue: " + exitVal);
				
			
			}catch (Throwable t){
				t.printStackTrace();
				IJ.log("Conversion failed for unkown reason...");
			}
		}
		
		
		//Create an imgPlus from the AVI_Reader plugin and open it
		final ImagePlus img = new ImagePlus(checkFile.getPath(),new AVI_Reader().makeStack(checkFile.getPath(), 1, 0, false, true, false));
		IJ.showProgress(0.01);
		IJ.showStatus("Opening file...");
		img.show();
		
		//Show the file
		IJ.saveAsTiff(img,f.getParent()+ File.separator + f.getName()+".tif");
		IJ.showProgress(0.01);

		
		System.out.println("Finished");
	}
		
	
	public static void main( final String[] args ) throws Exception
	{
		new ImageJ();
		 
		
		VideoProcessor vp =  new VideoProcessor();
		vp.run(null);
		
	}


}
