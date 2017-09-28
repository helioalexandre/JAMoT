/*
Toolbox for mouse behavioural analysis of several maize types:
Open Field; Elevated Plus Maze; Morris Water Maze; Novel Object Recognition; Y Maze; Fear Conditioning
 
MIT License

Copyright (c) 2017 Helio Roque

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/
 
 
requires("1.50a");
 
 var filemenu = newMenu("Mouse trial Macros Menu Tool", newArray("Batch Process Video Files", "Process Video", "Open Field","Elevated Plus Maze", "Morris Water Maze", "Novel Object Recognition", "Y Maze","Fear Conditioning", "Open Previous Analysis File", "Preferences","-"));
 var delFile = "Previous analysis file exists. Overwrite? Cancel will stop the macro.";
 var setThr = "Please set the threshold carefully and press OK (Image>Adjust>Threshold).";
 //General
 var units = call("ij.Prefs.get", "JAMoT_Prefs.gen.units", "0");
 var gauVal = call("ij.Prefs.get", "JAMoT_Prefs.gen.gauval", "0");
 var dispVal = call("ij.Prefs.get", "JAMoT_Prefs.gen.dispVal", "0");
 //Open Field
 var solidity = call("ij.Prefs.get", "JAMoT_Prefs.cube.soli", "0");
 var wCube = call("ij.Prefs.get", "JAMoT_Prefs.cube.width", "0");
 var mCubeArea = call("ij.Prefs.get", "JAMoT_Prefs.cube.marea","0");
 //Elevated Maize
 var wElevated = call("ij.Prefs.get", "JAMoT_Prefs.elev.width", "0");
 var lElevated = call("ij.Prefs.get", "JAMoT_Prefs.elev.length", "0");
 var mElevatedArea = call("ij.Prefs.get", "JAMoT_Prefs.elev.marea", "0");
 var sElevated = call("ij.Prefs.get", "JAMoT_Prefs.elev.smooth", "0");
 //Swimming Maize
 var dSwimming = call("ij.Prefs.get", "JAMoT_Prefs.swim.dia", "0");
 var mSwimmingArea = call("ij.Prefs.get", "JAMoT_Prefs.swim.marea", "0");
 var poolWD = call("ij.Prefs.get", "JAMoT_Prefs.swim.poolWD", "0");
 //T/Y Maize
 var wTY = call("ij.Prefs.get", "JAMoT_Prefs.ty.width", "0");
 var mTYArea = call("ij.Prefs.get", "JAMoT_Prefs.ty.marea", "0");
 var sTY = call("ij.Prefs.get", "JAMoT_Prefs.ty.smooth", "0");
 //Freezing test
 var mFreezeArea = call("ij.Prefs.get", "JAMoT_Prefs.fre.marea", "0");
 var sFreeze = call("ij.Prefs.get", "JAMoT_Prefs.fre.smooth", "0");
 
 
macro "Mouse trial Macros Menu Tool - C000C111D98C111D88C111D89C111D86D99C111D87C111D85C111D8aD97C111D9aC222D79D8bC222D7aC222D96C222D84C222D78C222D7bC222D76D9bC222D95C222D77C333Da9C333D75C333D74C333D73Da8C333DaaC333D8cC333C444D83C444D7cDa7C444D6aC444D69C444D94C444C555D9cC555DabC555Da6C555D68C555D6bC555D66C555D72C555C666D67C666D65C666D64D7dDa5Db9C666D63C666D8dDb8C666DbaC666D82D93C666DacC666C777D6cC777D7eC777Da4Db7C777D9dDbbC777D59D7fC777D5aD62D6dDb6C777D6fC777D8eC777C888D6eD92DbcC888Da3DadDcaC888D57D58Db5Dc9C888D56Dc7C888D5bD8fDc8C888D9eDc6DcbC888D9fDaeDb4DbdDc5C888D53D55D71D91DccC888D81Da1Da2Dc1Dd8C888D54D5cDafDb1Db2Db3Dc0Dc2Dd0Dd1Dd6DdaDdbDdfDe0De8De9DeaC888D52D5fDc3Dd2Dd5Dd7Dd9C888D5dD90Da0Db0DbeDc4Dd3DdcDdeDefDf2C888D5eDbfDcdDcfDd4De1DebDfaC888D4aD61DddDe2Df0Df1Df5Df8C999D80DceDe3DeeDf3Df4Df9DfbDfdDfeC999D41D47D49De7DecDedDf6Df7DfcDffC999D40D42D46D4bD4cD4dD51De4C999D43D44D48D4eD4fD50D70De5De6C999D10D20D30D31D36D3cD45D60C999D17D32D3bD3fC999D21D22D26D2eD2fD34D37D39D3aD3dD3eC999D15D16D23D29D33C999D07D11D12D14D18D19D1eD1fD25D27D2aD2dD35D38C999D00D05D06D0fD1aD24D2bD2cC999D01D04D09D0cD13D1bD1cD1dD28C999D02D0aD0bD0eC999D08D0dC999D03"{
 	choice = getArgument();
 	
 	if(units == 0 && choice != "Preferences"){
 			showMessage("It appears this is the first time you run JAMoT.\n Please run Preferences from the menu before starting.");
 		exit();
 	}else{
	 	if(choice != "-"){
	 		if(choice == "Process Video") {ProcessVideo(); }
	 		else if(choice == "Batch Process Video Files") {BatchProcessVideoFiles();}
	 		else if(choice == "Open Field") {MouseCubeTracker(); }
	 		else if(choice == "Elevated Plus Maze") {MiceElevatedPuzzleTracker(); }
	 		else if(choice == "Morris Water Maze") {MouseSwimTracker(); }
	 		else if(choice == "Novel Object Recognition") {MouseRegionsTracker(); }
	 		else if(choice == "Y Maze") {MiceYTTracker(); }
	 		else if(choice == "Open Previous Analysis File") {openPreviousAnalysis(); }
	 		else if(choice == "Preferences") {Preferences(); }
	 		else if(choice == "Fear Conditioning"){fearConditioning();}
	 	}
 	}
 		
 }
 
 /*Batch mode for processing AVI files that Fiji can´t open into AVI files that it can open
 opening then and saving them as tif files. this requires space and time as each frame becomes a
 tiff image so a 100Mb AVi file turns into a 3.5Gb Tiff stack
 It requires FFMPEG.EXE in the toolset folder
 */
 function BatchProcessVideoFiles(){
		
	showMessage("Batch AVI processing tool","<html>"+"<font size=2><center>This macro assumes that the file <br>"+"<font size=+2><center>ffmpeg.exe<br>"+"<font size=2><center>is in the directory of the files being processed!<br>" + "<font size=2><center>If you do not have ffmpeg installed please download it at<br>" + "<font size=2><font color=blue>https://ffmpeg.org/download.html<br><br>"+"<font size=2><font color=black> Also note that this macro does not support <b>SPACES</b> in the files/directories names!<br>");
	
	dir = getDirectory("Choose a Directory ");
	
	ffmpegPath = getDirectory("macros") + File.separator + "toolsets" + File.separator + "ffmpeg.exe";
	
	setBatchMode(true);
	list = getFileList(dir);
		
	for(i=0; i < list.length; i++){
		showProgress(i, list.length);
		if(endsWith(list[i], "avi")){

			/*create string to run the ffmpeg command to convert the avi file to an uncompressed 
			avi file that can be open in ImageJ*/
			string = ffmpegPath + " -loglevel quiet -i "+ dir + list[i] + " -f avi -vcodec mjpeg "+ dir + list[i] + ".converted.avi && echo off";
			
			os = getInfo("os.name");

			//run the command on the command prompt to convert the avi file
			if(startsWith(os, "Windows")){
				exec("cmd /c "+ string);
				print(string);
			}
			else
				exec("sh -c "+ string);

			//Open the new AVI file convert it to 8bit and use virtual stack
			run("AVI...", "open=" + dir + list[i] + ".converted.avi convert use");

			title = getTitle();
			id = getImageID();
			//Save a Tiff stack of the new AVI file
			saveAs("tiff", dir+list[i] +".converted.tif");
			
			//Delete intermediate AVI file
			File.delete(dir + list[i] + ".converted.avi");	
			print("Converted " + list[i]);
			close();	
		
		}

	
	}

	setBatchMode(false);
	exit("Processing terminated.");
	
}
 
 /*Convert AVI file that Fiji can´t open into AVI files that it can open
 opening then and saving it as tif files. This requires space and time as each frame becomes a
 tiff image so a 100Mb AVi file turns into a 3.5Gb Tiff stack
 It requires FFMPEG.EXE in the toolset folder
 */
function ProcessVideo(){
	//Explain the needs of the function
	showMessage("AVI processing tool","<html>"+"<font size=2><center>This step requires <br>"+"<font size=+2><center>ffmpeg.exe<br>"+"<font size=2><center>in the directory of ImageJ/macros/toolset!<br>" + "<font size=2><center>If you do not have ffmpeg installed please download it at<br>" + "<font size=2><font color=blue>https://ffmpeg.org/download.html<br><br>"+"<font size=2><font color=black> Also note that this macro does not support <b>SPACES</b> in the files/directories names!<br>");
	
	//Get the ffmpeg.exe path and check if file is present
	pathFFmpeg = getDirectory("macros") + File.separator + "toolsets" + File.separator + "ffmpeg.exe";
	if(!File.exists(pathFFmepg))
		exit("ffmpeg.exe file not present in the macros/toolset folder!"); 
	
	//Get target file and check if converted already exists and asks to delete it
	path = File.openDialog("Select the AVI file to convert.");
	if(File.exists(path + ".converted.avi")){
		showMessageWithCancel(delFile);
		File.delete(path + ".converted.avi");		
	}
	
	//Make string to run ffmepg command and run it on system dependent manner
	string = pathFFmpeg + " -loglevel quiet -i "+ path +" -f avi -vcodec mjpeg "+ path + ".converted.avi && echo off";
	
	os = getInfo("os.name");
	
	if(startsWith(os, "Windows")){
		exec("cmd /c "+ string);
		
	}
	else
		exec("sh -c " + string);
	
	//check the memory available to ImageJ and decide to open in virtual or not
	if(parseInt(IJ.maxMemory()) >= 4194304000)					//Memory in bytes!!
		run("AVI...", "open=" + path + ".converted.avi convert");
	else
		run("AVI...", "open=" + path + ".converted.avi convert use");

	//confirm that you have a stack
	if (nSlices==1) exit("Stack required");
	
	
	id = getImageID;
	name = getTitle();
	//Trim stack down if necessary
	waitForUser("Please have a look at the stack to check for 1st and last slice and then press OK");
	Dialog.create("Slice numbers");
	Dialog.addNumber("First Slice", 1);
	Dialog.addNumber("Last Slice", nSlices)
	Dialog.show();
	first = Dialog.getNumber();
	last = Dialog.getNumber();
	//Get directory to save image to 
	dir = getDirectory("Choose Destination for image.");
	
	//If needed remove slices from the beginning and the end
	setBatchMode("hide");
	if(first > 1)
		run("Slice Remover", "first=1 last="+first+" increment=1");
	
	if(last < nSlices)
		run("Slice Remover", "first="+last+" last="+nSlices+" increment=1");
	
	//Save tiff stack		
	saveAs("tiff", dir+name +".converted.tif");
	//Show and close
	setBatchMode("show");
	close();
	
	exit("Processing finished!");
		
}




/*
 Function for Open Field analysis. Its main job its to determine if the mouse is in the center
 of the cube or in the walls region. It also outputs several parameters related to displacement, velocity, etc.
 including direction of head and if its rearing or not. These are trial parameters.
 */
function MouseCubeTracker(){

	checkAndSort();

	//Select the directory of the open image to be analysed
	dir = getDirectory("image");
	imTitle = getTitle();
	rectCoord = newArray(4);
	//Clear measurements selection and limit them to threshold
	run("Set Measurements...", "limit redirect=None decimal=3");

	//Parameters from Dialog1
	temp = dialog1(1);
	blaWhi = temp[0];
	fps = temp[1];
	boxW = temp[2];
	boxH = temp[3];
	darkR = temp[5];
	gaus = temp[6];
	stagger = temp[7];
	
	/* Takes care of cases where an analysis file exists already
	asks if you want to delete it or not */
	if(File.exists(dir + imTitle + ".cube.trac")){
		showMessageWithCancel(delFile);
		File.delete(dir + imTitle + ".cube.trac");		
	}
	
	/*Create a new Analysis file. It is very important not to change the order that
	instructions get writen to this file as that will screw up the function
	to redo previous analysis*/
	f = File.open(dir + imTitle + ".cube.trac");
	print(f, dir + "\t" + getWidth() + "\t" +  getHeight() + "\t" + nSlices() +"\t"+ gaus); 
	print(f, imTitle);
	print(f, "FPS\t" + fps);
	
	//Run guassian blur if so selected in Dialog1
	if(gaus > 0){
		setBatchMode("hide");
		run("Gaussian Blur...", "sigma="+gaus+" stack");
		
	}
	setBatchMode("show");
	
	//Draw a rectangle for the user to adujst to the base of the box
	getDimensions(width, height, channels, slices, frames);
	makeRectangle(width/5, height/5,width/2,height/2);
	waitForUser("Please adjust the rectangule to match the bottom of the box");

	//Gets the dimensions of the rectangle and prints them to a file
	getSelectionBounds(rectCoord[0], rectCoord[1], rectCoord[2], rectCoord[3]);
	print(f,"BoxDimensions\t"+rectCoord[0]+"\t"+rectCoord[1]+"\t"+ rectCoord[2]+"\t"+rectCoord[3]);	

	//Determines the central regions and saves them to the file
	boundx = rectCoord[0] + (rectCoord[2]/5);
	boundy = rectCoord[1] + (rectCoord[3]/5);
	boundx2 = (rectCoord[2]/5)*3;
	boundy2 = (rectCoord[3]/5)*3;
	print(f,"Region\t"+boundx+"\t"+boundy+"\t"+boundx2+"\t"+boundy2);	

	//clears the outside of the box and 
	//smooths the edges
	setBatchMode("hide");
	getPixelSize(unit, pw, ph);
	
	/*Removed this VS reference to make my life easier*/
	/*if(is("Virtual Stack")){
		close();
		sortVirtual(dir, rectCoord, 1, blaWhi);
	}else{*/
		
	//Changes the backgrnd color to match black or white mice
	if(!blaWhi)
		setBackgroundColor(255, 255, 255);
	else
		setBackgroundColor(0, 0, 0);
		
	//Clear outside the stack 
	run("Enlarge...", "enlarge=15 pixel");
	run("Clear Outside", "stack");
	
	/*Reduce intensity of the cage wall
	Taking in consideration the pixel size*/
	run("Enlarge...", "enlarge=-15 pixel");
	if(pw == 1 && ph == 1)
		run("Make Band...", "band=25");
	else
		run("Make Band...", "band=" + 25*pw);
		
	
	run("Gaussian Blur...", "sigma=10 stack");

	setBatchMode("show");
	
	/*Checks if the pixel size is set and if not sets it from the 
	//dimensions of the cube*/
	if(pw == 1 && ph == 1){
		//Get pixel size from the width and heigth of cube
		px = boxW/rectCoord[2]; py = boxH/rectCoord[3];
		print(f, "Pixel size\t"+px+"\t"+py);
		run("Properties...", "channels=1 slices="+nSlices+" frames=1 unit="+units+" pixel_width="+px+" pixel_height="+py+" voxel_depth=1");	
	}else
		print(f, "Pixel size\t"+pw+"\t"+ph);

	
	//Remove dark regions if so selected
	if(darkR)
		darkA = removeDarkR(imTitle);
	

	/*Set autothreshold method with Minum and get the input from the user
	regarding it. Also save the threshold to file*/
	setAutoThreshold("Minimum");  
	waitForUser(setThr);
	getThreshold(minth, maxth);
	print(f, "Threshold\t"+minth+"\t"+maxth);
	
	/*If remove dark regions was selected save the parameters to file
	This is here to maintain the order of the file to enable previous analysis to function*/
	if(darkR)
		print(f, "DarkR\t" + darkA[0] +"\t"+ darkA[1]);
	else 
		print(f, "DarkR\t" + 0 +"\t"+ 0);
	
	//Actually set threshold
	setThreshold(minth,maxth);
		
	roiManager("Show All without labels");
	roiManager("Show None");
	
	//analyse particles function	
	totalslices = makeAnalysis(stagger, fps, mCubeArea, 1);
	
	//Save ROIs to a file in the folder of the image
	roiManager("Show All without labels");
	roiManager("Show None");
	roiManager("Save", dir + imTitle + "ROIs.zip");
	
	//Write preferences to the file of the analysis
	writePreferences(f);
	File.close(f);

	//File operations done!
	run("Select None");

	//Get data of the dectetions
	oriID=getImageID();
	getParameters(fps, dir, imTitle, totalslices);
	dialog2(oriID, dir, imTitle, 1);

}

/*This function goes through the ROIs, creates and fills arrays with the
result of the ROI analysis and then prints them to 2 files with the individual
results and a summary of the results*/
function getParameters(fps,dir, imTitle, totalSlices){
	//Determine the delay between ROIs
	if(fps != 25){
		delay = 1/fps;
	}else
		delay = 1/25;
	

	run("Set Measurements...", "centroid redirect=None decimal=3");
	
	/*Create arrays to hold the individual parameters of each ROI*/
	arrayX = newArray(roiManager("Count"));
	arrayY = newArray(roiManager("Count"));
	displacement = newArray(roiManager("Count"));
	velocity = newArray(roiManager("Count"));
	direction = newArray(roiManager("Count"));
	turndir = newArray(roiManager("Count"));
	estado = newArray(roiManager("Count"));
	lookup = newArray(roiManager("Count"));
	inRegion = newArray(roiManager("Count"));
	
	/*count and sum variables for the individual parameters*/
	displa = 0; moving = 0;
	displaCenter = 0; centerTime=0; entriesCenter = 0; freezeCenter = 0; wallsTime=0;
	roiManager("Deselect");
	setBatchMode("hide");
	
	/*Main loop to go trough all the ROIs and get the stats*/
	for(i=0; i<roiManager("count");i++){
		showProgress(i  , roiManager("count"));
		showStatus("Analysing Detections...");
		roiManager("Select", i);
		List.setMeasurements();
		arrayX[i] = List.getValue("X");
		arrayY[i] = List.getValue("Y");
		
		//Get result from magic function
		angle = getDirection(dir, imTitle);	
		/*Determine where the mouse is looking  by determining the angle from the head to the center of mass*/		
		if((angle[0] >= 0 && angle[0] < 22.5) || (angle[0] < 0 && angle[0] >= -22.5))
			direction[i] = "Rigth";
		else if(angle[0] >= 22.5 && angle[0] < 67.5)
			direction[i] = "Rigth up";
		else if(angle[0] >= 67.5 && angle[0] < 112.5)
			direction[i] = "Up";
		else if(angle[0] >= 112.5 && angle[0] < 157.5)
			direction[i] = "Left up";
		else if((angle[0] >= 157.5 && angle[0] <= 180) || (angle[0] < -157.5 && angle[0] >= -180))
			direction[i] = "Left";
		else if(angle[0] >= -157.5 && angle[0] < -112.5)
			direction[i] = "Left down";
		else if(angle[0] >= -112.5 && angle[0] < -67.5)
			direction[i] = "Down";
		else 
			direction[i] = "Down rigth";
		
		//Rearing - attempet
		if(angle[1])
			lookup[i] = "Yes";
		else
			lookup[i] = "No";
		
		//In central region or not
		if(angle[2] == 1){
			inRegion[i] = "In";
			centerTime = centerTime + delay;
		}else if(angle[2] == 2){
			inRegion[i] = "Out";
			wallsTime = wallsTime + delay;
		}else
			inRegion[i] = "Border";
		
		/*Displacement / Velocity / Entries in center / Stopped*/	
		if(i==0){
			displacement[i] = 0;
			velocity[i] = 0;
			
			turndir[i] = "No";
			estado[i] = "NAN";
		}else{
			displacement[i] = calculateDistance(arrayX[i-1], arrayY[i-1], arrayX[i], arrayY[i]);
			velocity[i] = displacement[i]/delay;

			if(angle[2] == 1 && inRegion[i-1] == "Out")
				entriesCenter++;
			
			if(direction[i] == direction[i-1])
				turndir[i] = "No";
			else
				turndir[i] = "Yes";
 
			if(displacement[i] > dispVal){
				estado[i] = "Moving";
				displa = displa + displacement[i];
				moving = moving + delay;
				if(angle[2] == 1){
					displaCenter = displaCenter + displacement[i];
				}
				
			}else{
				estado[i] = "Stopped";
				if(angle[2] == 1){
					freezeCenter = freezeCenter + delay;
				}
			}
			
		}

	}
	run("Select None");
	
	setBatchMode("show");
	
	/*Write results to tables both to single spots as the summary*/
	run("Clear Results");
	for(i=0; i<roiManager("count"); i++){
		showProgress(i, roiManager("count"));
		showStatus("Writing results...");
		setResult("X Center",i, arrayX[i]);
		setResult("Y Center",i, arrayY[i]);
		setResult("Displacement (cm)",i, displacement[i]);
		setResult("Velocity (cm/s)",i, velocity[i]);
		setResult("Direction of head",i, direction[i]);
		setResult("Changed direction?", i, turndir[i]);
		setResult("State", i, estado[i]);
		setResult("Looking up", i, lookup[i]);
		setResult("In center", i, inRegion[i]);
		
	}
	updateResults();

	selectWindow("Results");
	saveAs("text", dir+imTitle+".Spots.xls");
	run("Clear Results"); 
	
	i = 0;
	setResult("Label", i, "Total displacement"); 
	setResult("Value", i, displa);
	i = i + 1;
	setResult("Label", i, "Displacement in Center"); 
	setResult("Value", i, displaCenter);
	i = i + 1;
	setResult("Label", i, "Displacement Outer+Border Regions"); 
	setResult("Value", i,(displa - displaCenter));
	i = i + 1;
	setResult("Label", i,"Total time"); 
	setResult("Value", i, totalSlices * delay);
	i = i + 1;
	setResult("Label", i, "Time in center"); 
	setResult("Value", i, centerTime);
	i = i + 1;
	setResult("Label", i, "N. entries in center"); 
	setResult("Value", i, entriesCenter);
	i = i + 1;
	setResult("Label", i, "Time around walls"); 
	setResult("Value", i, wallsTime);
	i = i + 1;
	setResult("Label", i, "Time at borders"); 
	setResult("Value", i, ((totalSlices * delay) - wallsTime - centerTime));
	i = i + 1;
	setResult("Label", i, "Time freezed/not moving"); 
	setResult("Value", i,((totalSlices * delay) - moving));
	i = i + 1;
	setResult("Label", i, "Time freezed/not moving in center"); 
	setResult("Value", i,freezeCenter);
	i = i + 1;
	setResult("Label", i, "Time freezed/not moving in outer region"); 
	setResult("Value", i,((totalSlices * delay) - moving) - freezeCenter);
	i = i + 1;
	setResult("Label", i, "Average displacement");
	Array.getStatistics(displacement, min,max,mean,dev);
	setResult("Value", i, mean);
	i = i + 1;
	setResult("Label", i, "Average velocity");
	Array.getStatistics(velocity, min,max,mean,dev);
	setResult("Value", i, mean);

	updateResults();
	selectWindow("Results");
	saveAs("text", dir+imTitle+".Track.xls");
	run("Close");


}

/*Get individual parameters for the ROI of mice in OpenField*/
function getDirection(dir, imTitle){
		
		//Results array
		angle = newArray(3);
		Array.fill(angle, 0);
		//Get box region from file
		tempArray = getFileData(3, dir, imTitle, 1);
		//Get center region from file
		tempArray2 = getFileData(4, dir, imTitle, 1);
		
		//Get the coordinate arrays of the selection
		getSelectionCoordinates(xp, yp);
		List.setMeasurements();
		
		//Center mass of the selection
		xc = List.getValue("X");
		yc = List.getValue("Y");
		toUnscaled(xc, yc);
		//New array for the distances of center to the perimeter of the selection
		length = newArray(xp.length);
		//Fill the array with the distances
		for(i = 0; i < xp.length; i++){
			length[i]= calculateDistance(xc,yc,xp[i],yp[i]);
		}

		/*Get the maxs and mins of the length array
		Max distance should be head (in most cases) minimal distances are curves of behind*/
		nInter = 10;
		do{
			maxlengths = Array.findMaxima(length, nInter);
			minlengths = Array.findMinima(length, nInter);
			nInter = round(nInter - (nInter/3));
		}while(lengthOf(maxlengths)==0)

		//Calculate the angle of the center to the head (max length)
		angle[0] = calculateAngle2(xc, yc, xp[maxlengths[0]],yp[maxlengths[0]]);

		//Tentative of finding out if the rat is rearing
		if(List.getValue("Solidity")< solidity && ((xp[maxlengths[0]] < tempArray[0] || xp[maxlengths[0]] > tempArray[0]+tempArray[2]) && (yp[maxlengths[0]] < tempArray[1] || yp[maxlengths[0]]> tempArray[1]+tempArray[3])))
			angle[1] = 1;
		
		//find out if the rat is in the center or not
		count = false; in= 0; out = 0;
		for(i = 0; i < xp.length; i++){
			
			//Check if its the head that is out			
			if(xp[maxlengths[0]] >= tempArray2[0] && xp[maxlengths[0]] <= (tempArray2[0] + tempArray2[2]) && yp[maxlengths[0]] >= tempArray2[1] && yp[maxlengths[0]] <= (tempArray2[1]+tempArray2[3]))
				count = true;			
			
			
			//Check if the coordinates are in the center or not
			if(xp[i] >= tempArray2[0] && xp[i] <= (tempArray2[0] + tempArray2[2]) && yp[i] >= tempArray2[1] && yp[i] <= (tempArray2[1]+tempArray2[3]))
				in++;
				
			else
				out++;
		}
		
		/*Fill in if the rat is in the center or in the outer regions
		or at the borders*/
		if(in >= (lengthOf(xp)*0.8) && count)
			angle[2] = 1;
		else 
			angle[2] = 2;

		return angle;
	 
}


/*Function to evaluate the Elevated Maize mice proof
It will be track the mouse in the maize and
calculate the time spent in the closed arms vs open arms
it will also try to verify if the mouse was looking outside the
edge in the open arms (exploring)*/
function MiceElevatedPuzzleTracker(){

	checkAndSort();
	
	//First clean up and setup the function actions
	dir = getDirectory("image");
	imTitle = getTitle();
	rectRegions = newArray(4);
	run("Set Measurements...", "limit redirect=None decimal=3");
	
	//Get the parameters of the Dialog1
	temp = dialog1(2);
	blaWhi = temp[0];
	fps = temp[1];
	armsW = temp[2];
	armsL = temp[3];
	darkR = temp[5];
	gaus = temp[6];
	stagger = temp[7];
	
	 /* Takes care of cases where an analysis file exists already
	asks if you want to delete it or not */
	if(File.exists(dir + imTitle + ".cross.trac")){
		showMessageWithCancel(delFile);
		File.delete(dir + imTitle + ".cross.trac");		
	}
	
	/*Create a new Analysis file. It is very important not to change the order that
	instructions get writen to this file as that will screw up the function
	to redo previous analysis*/
	f = File.open(dir + imTitle + ".cross.trac");
	print(f, dir + "\t" + getWidth() + "\t" + getHeight() + "\t" + nSlices() + "\t" + gaus);
	print(f, imTitle);
	print(f, "FPS\t" + fps);
	
	//Run guassian blur if so selected in Dialog1
	if(gaus > 0){
		setBatchMode("hide");
		run("Gaussian Blur...", "sigma="+gaus+" stack");
		setBatchMode("show");
	}
	
	//get dimensions of the image in px
	getDimensions(width, height, channels, slices, frames);
	makeRectangle(width/2.5, height/2.5,width/10,height/10);
	waitForUser("Please adjust the rectangule to match the center of the maize.");
	
	/*get the dimensions of the square in the center of the cross
	This limits the lower bounds of the cross*/
	getSelectionBounds(rectRegions[0], rectRegions[1], rectRegions[2], rectRegions[3]);
	print(f,"BoxDimensions\t"+rectRegions[0]+"\t"+rectRegions[1]+"\t"+ rectRegions[2]+"\t"+rectRegions[3]);	

	/*Checks if the pixel size is set and if not sets it from the 
	dimensions of the width of the arms (gotten from cross center*/
	getPixelSize(unit, pw, ph);
	if(pw == 1 && ph == 1){
		pixx = armsW/rectRegions[2]; pixy = armsW/rectRegions[3];
		print(f, "Pixel size\t"+pw+"\t"+ph +"\t" + armsL);	
		run("Properties...", "channels=1 slices="+nSlices+" frames=1 unit="+units+" pixel_width="+pixx+" pixel_height="+pixy+" voxel_depth=1");
	}else 
		print(f, "Pixel size\t"+pw+"\t"+ph +"\t" + armsL);	


	//Asks the user to draw the polygon that the cross forms to clear outside ot if
	run("Select None");
	setTool("polygon");
	waitForUser("Please make a polygon to match the maize base.");
	getSelectionCoordinates(px, py);
	stringx = "";
	stringy = "";
	//Writes polygon coordinates to the analysis file
	for(i = 0; i < px.length; i++){
		stringx = stringx + toString(px[i]) + "\t";
		stringy = stringy + toString(py[i]) + "\t";
	}
	print(f, "CrossRegionX" + "\t"+stringx);	
	print(f, "CrossRegionY" + "\t"+stringy);	
	

	/*Removed this VS reference to make my life easier*/
	setBatchMode("hide");
	/*if(is("Virtual Stack")){
		roiManager("Add");
		close();
		sortVirtual(dir, 0, 3, blaWhi);
		roiManager("Reset");*/
	
	//Changes the backgrnd color to match black or white mice
	if(!blaWhi)
		setBackgroundColor(255, 255, 255);
	else
		setBackgroundColor(0, 0, 0);
	
	//Clear outside 30 pixels away from the polygon
	run("Enlarge...", "enlarge=30 pixel");
	run("Clear Outside", "stack");

	//Remove dark regions if so selected
	if(darkR)
		darKA = removeDarkR(imTitle);

	setBatchMode("show");
	/*Set autothreshold method with Minum and get the input from the user
	regarding it. Also save the threshold to file*/
	setAutoThreshold("Minimum");
	waitForUser(setThr);
	getThreshold(minth, maxth);
	setThreshold(minth,maxth);
	print(f, "Threshold\t" + minth + "\t" + maxth);
	
	/*If remove dark regions was selected save the parameters to file
	This is here to maintain the order of the file to enable previous analysis to function*/
	if(darkR)
		print(f, "DarkR\t" + darKA[0] + "\t" + darKA[1]);
	else
		print(f, "DarkR\t" + 0 + "\t" + 0);
	
	//analyse particles function
	totalSlices = makeAnalysis(stagger, fps, mElevatedArea, 2);


	roiManager("Show All without labels");
	roiManager("Show None");


	//Save ROIs to a file in the folder of the image
	roiManager("Save", dir + imTitle + "ROIs.zip");
	
	//Write preferences to the file of the analysis
	writePreferences(f);
	
	//File operations done!
	File.close(f);
	run("Select None");
	
	//Get data of the detections
	oriID=getImageID();
	getParametersET(fps, dir, imTitle, armsL);
	dialog2(oriID, dir, imTitle, 2);
	
}


/*This function goes through the ROIs, creates and fills arrays with the
result of the ROI analysis and then prints them to 2 files with the individual
results and a summary of the results*/
function getParametersET(fps, dir, imTitle, armsL, totalSlices){
	//Determine the delay between ROIs
	if(fps != 25){
		delay = 1/fps;
	}else
		delay = 1/25;

	run("Set Measurements...", "area centroid redirect=None decimal=3");
	
	/*Create arrays to hold the individual parameters of each ROI*/
	arrayX = newArray(roiManager("Count"));
	arrayY = newArray(roiManager("Count"));
	displacement = newArray(roiManager("Count"));
	velocity = newArray(roiManager("Count"));
	closeArmsPosition = newArray(roiManager("Count"));
	openArmsPosition = newArray(roiManager("Count"));
	mouseArea = newArray(roiManager("Count"));
	angles = newArray(roiManager("Count"));
	anglesA = newArray(roiManager("Count"));
	explo = newArray(roiManager("Count"));
	
	/*count and sum variables for the individual parameters*/
	displa = 0; 
	openTime = 0; closedTime=0; 
	entriesOpen = 0; entriesClose = 0;
	closedAreaAve = 0; closeAreaCount=0;
	check=0;
	roiManager("Deselect");
	setBatchMode("hide");
	/*Main loop to go trough all the ROIs and get the stats*/
	for(i=0; i<roiManager("count");i++){
		showProgress(i, roiManager("count"));
		showStatus("Analyzing detections...");
		roiManager("Select", i);
		//smooth a bit the selection to eliminate tails and small bits on walls
		//keeping the head - due to problems in the ilumination
		run("Enlarge...", "enlarge=-"+sElevated+" pixel");
		run("Enlarge...", "enlarge="+sElevated+" pixel");
		List.setMeasurements();

		//Center coordinates of mouse
		arrayX[i] = List.getValue("X");
		arrayY[i] = List.getValue("Y");
		mouseArea[i] = List.getValue("Area");

		/*angle is an array which provides several properties to setup
		information.*/ 
		angle = getDirectionET(armsL);		
		angles[i] = angle[0];

		if(angle[0]==0){
			closeArmsPosition[i] = "Out";
			openArmsPosition[i] = "Out";
			
		}else if(angle[0] == 1){
			closeArmsPosition[i] = "In";
			closedAreaAve = closedAreaAve + mouseArea[i];
			closeAreaCount++;

			
			if(i>0)
				closedTime = closedTime + delay;
				
			openArmsPosition[i] = "Out";
			
		}else{
			closeArmsPosition[i] = "Out";
			if(i>0)
				openTime = openTime + delay;
			
			openArmsPosition[i] = "In";
		}

				
		if(i==0){
			displacement[i] = 0;
			velocity[i] = 0;

		}else{
			displacement[i] = calculateDistance(arrayX[i-1], arrayY[i-1], arrayX[i], arrayY[i]);
			velocity[i] = displacement[i]/delay;
			if(displacement[i] > dispVal)
				displa = displa + displacement[i];
					
		}
		
		if(angle[1] == 1 && i >= 1)
			explo[i] = "Yes";
		else
			explo[i] = "No";
			
	}
	
	//smoothing the entries in arms by a moving average of window 7
	r = 7;
	for(j=r; j<lengthOf(angles)-r;j++){
		count0 = 0; count1 = 0; count2=0;
		for(m = j-round(r/2); m <= j+round(r/2); m++){
			if(angles[m] == 0)
				count0++;
			else if(angles[m] == 1)
				count1++;
			else 
				count2++;
	
		}
		
		if(count0 >= count1 && count0 >= count2)
			anglesA[j]=0;
		else if(count1 > count0 && count1 > count2)
			anglesA[j]=1;
		else
			anglesA[j]=2;
	}
	

	for(j = r; j<anglesA.length-r;j++){
		if(anglesA[j] == 1 && anglesA[j-1] != 1)
			entriesClose++;
		else if(anglesA[j] == 2 && anglesA[j-1] != 2)
			entriesOpen++;
		else
			;
	}
	
	setBatchMode("show");
	run("Select None");
	closedAreaAve = closedAreaAve/closeAreaCount;
	nExplo = 0; count = 0;

	run("Clear Results");
	/*Write results to tables both to single spots as the summary*/
	for(i=0; i<roiManager("count"); i++){
		showProgress(i, roiManager("count"));
		showStatus("Writing results...");
		setResult("X Center",i, arrayX[i]);
		setResult("Y Center",i, arrayY[i]);
		setResult("Displacement (cm)",i, displacement[i]);
		setResult("Velocity (cm/s)",i, velocity[i]);
		setResult("In Closed region",i, closeArmsPosition[i]);
		setResult("In Open region", i, openArmsPosition[i]);
		setResult("Exploring", i, explo[i]);
		if(explo[i] == "Yes"){
			count++;
			if(count == 5){
				nExplo++;
			}		 
		}else if(explo[i] == "No" && count > 0)
			count = 0;
				
				
	}
	updateResults();

	selectWindow("Results");
	saveAs("text", dir+imTitle+".Spots.xls");
	run("Clear Results"); 

	setResult("Label", 0, "Total displacement"); 
	setResult("Value", 0, displa);
	setResult("Label", 1, "Time spent in closed region"); 
	setResult("Value", 1, closedTime);
	setResult("Label", 2, "N. entries in closed region"); 
	setResult("Value", 2, entriesClose);
	setResult("Label", 3, "Time spent in open region"); 
	setResult("Value", 3,  openTime);
	setResult("Label", 4, "N. entries in open region"); 
	setResult("Value", 4, entriesOpen);
	setResult("Label", 5, "Average displacement");
	Array.getStatistics(displacement, min,max,mean,dev);
	setResult("Value", 5, mean);
	setResult("Label", 6, "Average velocity");
	Array.getStatistics(velocity, min,max,mean,dev);
	setResult("Value", 6, mean);
	setResult("Label", 7, "Times of over the edge exploration"); 
	setResult("Value", 7, nExplo);
	setResult("Label", 8, "Time in central area");
	setResult("Value", 8, (totalSlices*delay)-closedTime-openTime);
	
	updateResults();
	selectWindow("Results");
	saveAs("text", dir+imTitle+".Track.xls");
	run("Close");

}


/*Get individual parameters for the ROI of mice in EM*/
function getDirectionET(armsL){
	//Results array
	angle = newArray(2);
	Array.fill(angle, 0);
	//Get the coordinates of the selection
	getSelectionCoordinates(xp, yp);
	List.setMeasurements();

	//Get central box parameters from file
	rectRegions = getFileData(3, dir, imTitle, 2);
		
	//Center mass of the selection
	xc = List.getValue("X");
	yc = List.getValue("Y");
	toUnscaled(xc, yc);

				
	//find out if the rat is closed or open arms
	flag = true; countOpen = 0; countClose= 0;
	for(i = 0; i < xp.length; i++){
		if(yc <= rectRegions[1] - rectRegions[3] || yc >= rectRegions[1] + (rectRegions[2]*2)){
			angle[0] = 1;
			flag = false;
		}else if(flag && (xp[i] >= rectRegions[0] && xp[i] <= (rectRegions[0] + rectRegions[2])) && ( yp[i] <= rectRegions[1] || yp[i] > (rectRegions[1] + rectRegions[3])))
			countClose++;
		else if(xc <= rectRegions[0]-rectRegions[2] || xc >= (rectRegions[0] + (rectRegions[2]*2))){
			angle[0] = 2;
			flag = false;
		}
		else if(flag && (xp[i] <= rectRegions[0] || xp[i] >= (rectRegions[0] + rectRegions[2])))
			countOpen++;
		else
			;
	}


	if(flag && countClose >= lengthOf(xp)*0.8)
		angle[0] = 1;
	else if(flag && countOpen >= lengthOf(xp)*0.8)
		angle[0] = 2;
	else if(flag)
		angle[0] = 0;
		
		
	//New array for the lengths of center to the perimeter of the selection
	length = newArray(xp.length);
	//Fill the array with the distances
	for(i = 0; i < xp.length; i++){
		length[i]= calculateDistance(xc,yc,xp[i],yp[i]);
	}

	/*Get the maxs and mins of the length array
		Max distance should be head (in most cases) minimal distances are curves of behind*/
	nInter = 10;
	do{
		maxlengths = Array.findMaxima(length, nInter);
		minlengths = Array.findMinima(length, nInter);
		nInter = round(nInter - (nInter/3));
	}while(lengthOf(maxlengths)==0)

	armL = armsL;
	toUnscaled(armL);
	
	//Check if the head of the mouse is out of the open arms fronteirs
	count = false;
	if(xp[maxlengths[0]] < rectRegions[0] || xp[maxlengths[0]] > rectRegions[0] + rectRegions[2])
		if((yp[maxlengths[0]] < rectRegions[1] || yp[maxlengths[0]] > (rectRegions[1]+rectRegions[3]) || xp[maxlengths[0]] < (rectRegions[0] - armL) || xp[maxlengths[0]] > (rectRegions[0] + rectRegions[1] + armL)))	
			count = true;
	
	//find out if the rat exploring or not
	in= 0;
	if(count){
	
		for(i = 0; i < xp.length; i++){
			if(angle[0] != 1 && (yp[i]< rectRegions[1] || yp[i] > (rectRegions[1]+rectRegions[3]) || xp[i] < (rectRegions[0] - armL) || xp[i] > (rectRegions[0] + rectRegions[2] + armL)))
				in++;
			}
	}
	if(in >= 10 && count)
		angle[1] = 1;

	
	return angle;
	 
}


/*
 Function for WaterMaize analysis. Its main job its to determine in which quadrant the
 is, if its at the walss or not and if it finds the platform. It also outputs velocity and 
 displacement.
 */
function MouseSwimTracker(){
	
	checkAndSort();

	//Get the directory of the open image to be analysed
	dir = getDirectory("image");
	imTitle = getTitle();
	rectCoord = newArray(4);
	platCoord = newArray(4);
	
	run("Set Measurements...", "limit redirect=None decimal=3");

	//Get the parameters of the Dialog1
	temp = dialog1(3);
	blaWhi = temp[0];
	fps = temp[1];
	diameter = temp[2];
	rRegions = temp[4];
	darkR = temp[5];	
	gaus = temp[6];
	stagger = temp[7];
	
	 /* Takes care of cases where an analysis file exists already
	asks if you want to delete it or not */
	if(File.exists(dir + imTitle + ".swim.trac")){
		showMessageWithCancel(delFile);
		File.delete(dir + imTitle + ".swim.trac");		
	}
	
	/*Create a new Analysis file. It is very important not to change the order that
	instructions get writen to this file as that will screw up the function
	to redo previous analysis*/
	f = File.open(dir + imTitle + ".swim.trac");
	print(f, dir + "\t" + getWidth() + "\t" + getHeight() + "\t" + nSlices + "\t" + gaus);
	print(f, imTitle);
	print(f, "FPS\t" + fps);
	
	//Run guassian blur if so selected in Dialog1
	if(gaus > 0){
		setBatchMode("hide");
		run("Gaussian Blur...", "sigma="+gaus+" stack");
		setBatchMode("show");
	}
	
	//Draw an oval for the user to adujst to the base of the pool
	getDimensions(width, height, channels, slices, frames);
	makeOval(50, 50,width/1.3,height/1.1);
	waitForUser("Please adjust the oval to match the circunference of the pool.");
	//Gets the dimensions of the oval and prints them to a file
	getSelectionBounds(rectCoord[0], rectCoord[1], rectCoord[2], rectCoord[3]);
	print(f,"OvalDimensions\t"+rectCoord[0]+"\t"+rectCoord[1]+"\t"+ rectCoord[2]+"\t"+rectCoord[3]);	

	boundx = rectCoord[0] + (rectCoord[2]/2);
	boundy = rectCoord[1] + (rectCoord[3]/2);
	print(f,"Center Coordinates\t"+boundx+"\t"+boundy);
	
	/*Draw an oval for the user to adujst to the platform 
	gets the dimensions and prints then to a file*/
	makeOval(50, 50,width/10,height/10);
	waitForUser("Please adjust the oval to match the platform");
	getSelectionBounds(platCoord[0], platCoord[1], platCoord[2], platCoord[3]);
	print(f,"PlatformDimensions\t"+platCoord[0]+"\t"+platCoord[1]+"\t"+ platCoord[2]+"\t"+platCoord[3]);	
	
	/*Checks if the pixel size is set and if not sets it from the 
	dimensions of the cube*/	
	getPixelSize(unit, pw, ph);
	if(pw == 1 && ph ==1){
		px = diameter/rectCoord[2]; py = diameter/rectCoord[3];
		print(f, "Pixel size\t"+px+"\t"+py);	
		run("Properties...", "channels=1 slices="+nSlices+" frames=1 unit="+units+" pixel_width="+px+" pixel_height="+py+" voxel_depth=1");
	}
	else
		print(f, "Pixel size\t"+pw+"\t"+ph);
		
		
	setBatchMode("hide");
	makeOval(rectCoord[0], rectCoord[1], rectCoord[2], rectCoord[3]);
	/*Removed this VS reference to make my life easier*/
	/*if(is("Virtual Stack")){
		close();
		sortVirtual(dir, rectCoord, 3);
	}else{*/
		
	//Changes the backgrnd color to match black or white mice
	if(!blaWhi)
		setBackgroundColor(255, 255, 255);
	else
		setBackgroundColor(0, 0, 0);

	run("Clear Outside", "stack");

	setBatchMode("show");
	
	/*This removes regions of the pool that can lead to problems in 
	detecting the mouse. Its an option in Dialog1*/
	if(rRegions){
		for(i = 0; i < rRegions; i++){
			waitForUser("Please select region "+i+1+" to clear");
			roiManager("Add");
			run("Make Band...", "band=2");
			getStatistics(area, mean);
			setBackgroundColor(mean, mean, mean);
			roiManager("Select", 0);
			run("Clear", "stack");
			roiManager("Reset");
		}
		
	}

	
	/*Set autothreshold method with Minimum and get the input from the user
regarding it. Also save the threshold to file*/
	setAutoThreshold("Minimum");
	waitForUser(setThr);
	getThreshold(minth, maxth);
	setThreshold(minth,maxth);
	
	print(f, "Threshold\t" + minth + "\t" + maxth);
	print(f, "Diameter of pool!\t" + diameter);
	
	roiManager("Show All without labels");
	roiManager("Show None");
	
	//analyse particles function (here totalSlices is the first slice analysed)
	totalSlices = makeAnalysis(stagger, fps, mSwimmingArea, 3);

	roiManager("Show All without labels");
	roiManager("Show None");
	
	//Save ROIs to a file in the folder of the image
	roiManager("Save", dir + imTitle + "ROIs.zip");
	
	//Write preferences to the file of the analysis
	writePreferences(f);
	//File operations done!
	File.close(f);
	run("Select None");

	oriID=getImageID();
	getParametersSM(fps,dir, imTitle, diameter, totalSlices);
	dialog2(oriID, dir, imTitle, 3);
	
	
}


/*This function goes through the ROIs, creates and fills arrays with the
result of the ROI analysis and then prints them to 2 files with the individual
results and a summary of the results*/
function getParametersSM(fps,dir, imTitle, diameter, totalSlices){
	//Get delay between frames analyzed
	if(fps != 25){
		delay = 1/fps;
	}else
		delay = 1/25;
	
	run("Set Measurements...", "centroid redirect=None decimal=3");
	
	/*Create arrays to hold the individual parameters of each ROI*/
	arrayX = newArray(roiManager("Count"));
	arrayY = newArray(roiManager("Count"));
	displacement = newArray(roiManager("Count"));
	velocity = newArray(roiManager("Count"));
	quadrant = newArray(roiManager("Count"));
	border = newArray(roiManager("Count"));
	flag = true;
	
	/*count and sum variables for the individual parameters*/
	displa = 0; t2Plat = 0;
	qTime1 = 0; qTime2 = 0; qTime3 = 0; qTime4 = 0;
	qDis1 = 0; qDis2 = 0; qDis3 = 0; qDis4 = 0;
	bTime = 0;
	roiManager("Deselect");
	
	setBatchMode("hide");
	/*Main loop to go trough all the ROIs and get the stats*/
	for(i=0; i<roiManager("count");i++){
		showProgress(i, roiManager("count"));
		showStatus("Analysing detections...");
		roiManager("Select", i);
		List.setMeasurements();
		arrayX[i] = List.getValue("X");
		arrayY[i] = List.getValue("Y");
		
		//Get result from magic function
		angle = getQuadAndPlat(dir, imTitle, diameter);		
		
		//Which quadrant is the mouse
		quadrant[i] = angle[0];

		if(i==0){
			displacement[i] = 0;
			velocity[i] = 0;
			if(angle[2] == 1){
				bTime = bTime + delay;
				border[i] = "Wall";
			}else
				border[i] = "Away";
						
		}else{
			/*Displacement / Velocity / Quadrants / Platform*/	
			displacement[i] = calculateDistance(arrayX[i-1], arrayY[i-1], arrayX[i], arrayY[i]);
			velocity[i] = displacement[i]/delay;

			if(angle[0] == 1 && quadrant[i-1] == 1){
				qTime1 = qTime1 + delay;
				qDis1 = qDis1 + displacement[i];
			}else if(angle[0] == 2 && quadrant[i-1] == 2){
				qTime2 = qTime2 + delay;
				qDis2 = qDis2 + displacement[i];
			}else if(angle[0] == 3 && quadrant[i-1] == 3){
				qTime3 = qTime3 + delay;
				qDis3 = qDis3 + displacement[i];
			}else if(angle[0] == 4 && quadrant[i-1] == 4){
				qTime4 = qTime4 + delay;
				qDis4 = qDis4 + displacement[i];
			}else;

			if(angle[1] && flag){
				t2Plat = (getSliceNumber() - totalSlices)*delay;
				flag = 0;
			}
			
			if(angle[2] == 1){
				bTime = bTime + delay;
				border[i] = "Wall";
			}else
				border[i] = "Away";
			

			if(displacement[i] > dispVal)				//--> Check this number to see when it is stopped!
				displa = displa + displacement[i];

		}
			
	}
	
	setBatchMode("show");
	run("Select None");
	
	/*Write results to tables both to single spots as the summary*/
	run("Clear Results");
	for(i=0; i<roiManager("count"); i++){
		showProgress(i, roiManager("count"));
		showStatus("Writing results...");
		setResult("X Center ("+units+")",i, arrayX[i]);
		setResult("Y Center ("+units+")",i, arrayY[i]);
		setResult("Displacement ("+units+")",i, displacement[i]);
		setResult("Velocity ("+units+"/s)",i, velocity[i]);
		setResult("Quadrant position",i, quadrant[i]);
		setResult("Close to border wall", i, border[i]);
	}
	updateResults();

	selectWindow("Results");
	saveAs("text", dir+imTitle+".Spots.xls");
	run("Clear Results"); 

	setResult("Label", 0, "Total displacement ("+units+")"); 
	setResult("Value", 0, displa);
	setResult("Label", 1, "Displacement ("+units+") in R1"); 
	setResult("Value", 1, qDis1);
	setResult("Label", 2, "Time (s) in R1"); 
	setResult("Value", 2, qTime1);
	setResult("Label", 3, "Displacement ("+units+") in R2"); 
	setResult("Value",3, qDis2);
	setResult("Label", 4, "Time (s) in R2"); 
	setResult("Value",4, qTime2);
	setResult("Label", 5, "Displacement ("+units+") in R3"); 
	setResult("Value", 5, qDis3);
	setResult("Label", 6, "Time (s) in R3"); 
	setResult("Value", 6, qTime3);
	setResult("Label", 7, "Displacement ("+units+") in R4"); 
	setResult("Value", 7, qDis4);
	setResult("Label", 8, "Time (s) in R4"); 
	setResult("Value", 8, qTime4);
	setResult("Label", 9, "Time close to poll wall");
	setResult("Value", 9, bTime);
	setResult("Label", 10, "Average displacement ("+units+")");
	Array.getStatistics(displacement, min,max,mean,dev);
	setResult("Value", 10, mean);
	setResult("Label", 11, "Average velocity ("+units+"/s)");
	Array.getStatistics(velocity, min,max,mean,dev);
	setResult("Value", 11, mean);
	setResult("Label",12, "Time to find platform (s)");
	if(t2Plat > 0)
		setResult("Value",12, t2Plat);
	else
		setResult("Value",12, "Did not find Platform");

	updateResults();
	selectWindow("Results");
	saveAs("text", dir+imTitle+".Track.xls");
	run("Close");

}

/*Get individual parameters for the ROIs of mice in WaterMaize*/
function getQuadAndPlat(dir, imTitle, diameter){
	//Results array
	angle = newArray(3);
	Array.fill(angle, 0);
	//Get pool bounding box from file
	tempArray = getFileData(4, dir, imTitle, 3);
	//Get platform bounding box from file
	tempArray2 = getFileData(5, dir, imTitle, 3);
	//Get pixel size from file
	tempArray3 = getFileData(6, dir, imTitle, 3);
	
	//Get the coordinates of the selection
	getSelectionCoordinates(xp, yp);
	List.setMeasurements();
	
	//Center mass of the selection in pixels
	xc = List.getValue("X");
	yc = List.getValue("Y");
	toUnscaled(xc, yc);
	
	//Quadrant determination
	if(xc <= tempArray[0] && yc <= tempArray[1])
		angle[0] = 1;
	else if(xc <= tempArray[0] && yc > tempArray[1])
		angle[0] = 2;
	else if(xc > tempArray[0] && yc <= tempArray[1])
		angle[0] = 3;
	else
		angle[0] = 4;
	
	//find out if the rat is in the platform or not
	platDist = calculateDistance(xc, yc, tempArray2[0]+(tempArray2[2]/2), tempArray2[1]+(tempArray2[3]/2));	
	if(platDist <= ((tempArray2[2] + tempArray2[3])/4))
		angle[1] = 1;
	
	//Check if the mouse is less then 10units from the wall	
	borderDist = calculateDistance(xc, yc, tempArray[0], tempArray[1]);
	toScaled(borderDist);
	if(borderDist >= ((diameter/2) - poolWD))
		angle[2] = 1;
		return angle;
 
}

/*
 Function for NovelObject analysis. Its main job its to determine when/howmuch the mouse approaches
 each region. It also outputs several parameters related to displacement, velocity, etc.
 including direction of head. These are trial parameters.
 */
function MouseRegionsTracker(){

	checkAndSort();
	
	//Select the directory of the open image to be analysed
	dir = getDirectory("image");
	imTitle = getTitle();
	rectCoord = newArray(4);
	 //Clear measurements selection and limit them to threshold
	run("Set Measurements...", "limit redirect=None decimal=3");

	//Get the parameters of the Dialog1
	choiceArray = dialog1(4);
	blaWhi = choiceArray[0];
	fps = choiceArray[1];
	cubeW = choiceArray[2];
	cubeH = choiceArray[3];
	nRegions = choiceArray[4];
	darkR = choiceArray[5];
	gaus = choiceArray[6];
	stagger = choiceArray[7];

	 /* Takes care of cases where an analysis file exists already
	asks if you want to delete it or not */
	if(File.exists(dir + imTitle + ".objects.trac")){
		showMessageWithCancel(delFile);
		File.delete(dir + imTitle + ".objects.trac");		
	}
	
	/*Create a new Analysis file. It is very important not to change the order that
	instructions get writen to this file as that will screw up the function
	to redo previous analysis*/
	f = File.open(dir + imTitle + ".objects.trac");
	print(f, dir + "\t" + getWidth + "\t" + getHeight + "\t" + nSlices + "\t" + gaus);
	print(f, imTitle);
	print(f, "FPS\t" + fps);

	//Run guassian blur if so selected in Dialog1
	if(gaus > 0){
		setBatchMode("hide");
		run("Gaussian Blur...", "sigma="+gaus+" stack");
	}
	setBatchMode("show");

	//Draw a rectangle for the user to adjust to the base of the box
	getDimensions(width, height, channels, slices, frames);
	makeRectangle(width/5, height/5,width/2,height/2);
	waitForUser("Please adjust the rectangule to match the bottom of the box");
	
	//Gets the dimensions of the rectangle and prints them to a file
	getSelectionBounds(rectCoord[0], rectCoord[1], rectCoord[2], rectCoord[3]);
	print(f,"BoxDimensions\t"+rectCoord[0]+"\t"+rectCoord[1]+"\t"+ rectCoord[2]+"\t"+rectCoord[3]);	

	//Determines the center region and prints it to file
	boundx = rectCoord[0] + (rectCoord[2]/5);
	boundy = rectCoord[1] + (rectCoord[3]/5);
	boundx2 = (rectCoord[2]/5)*3;
	boundy2 = (rectCoord[3]/5)*3;
	print(f,"Region\t"+boundx+"\t"+boundy+"\t"+boundx2+"\t"+boundy2);	

	setBatchMode("hide");	
	getPixelSize(unit, pw, ph);
	/*Removed this VS reference to make my life easier*/
	/*if(is("Virtual Stack")){
		close();
		sortVirtual(dir, rectCoord, 1);
	}else{*/
		
	//Changes the backgrnd color to match black or white mice
	if(!blaWhi)
		setBackgroundColor(255, 255, 255);
	else
		setBackgroundColor(0, 0, 0);

	run("Enlarge...", "enlarge=15 pixel");
	run("Clear Outside", "stack");
	
	//Changes the backgrnd color to match black or white mice
	run("Enlarge...", "enlarge=-15 pixel");
	run("Make Band...", "band="+ 25*pw);
	run("Gaussian Blur...", "sigma=10 stack");	
 
	setBatchMode("show");
	/*Checks if the pixel size is set and if not sets it from the 
dimensions of the cube*/
	if(pw == 1 && ph == 1){
		px = cubeW/rectCoord[2]; py = cubeH/rectCoord[3];
		print(f, "Pixel size\t"+px+"\t"+py);	
		run("Properties...", "channels=1 slices="+nSlices+" frames=1 unit="+units+" pixel_width="+px+" pixel_height="+py+" voxel_depth=1");
	}
	else
		print(f, "Pixel size\t"+pw+"\t"+ph);	

	/*Asks the user to adjust ovals to the regions, gets their location and dimensions
	and prints them to file*/	
	Array.fill(rectCoord, 0);
	if(nRegions>0){
		for(i=0; i < nRegions; i++){
			makeOval(width/2, height/2,width/10,height/10);
			waitForUser("Please set region n." + (i + 1));
			getSelectionBounds(rectCoord[0], rectCoord[1], rectCoord[2], rectCoord[3]);
			print(f,"Object"+(i+1)+"\t"+rectCoord[0]+"\t"+rectCoord[1]+"\t"+ rectCoord[2]+"\t"+rectCoord[3]);
		}
	}

	
	//Remove dark regions if so selected
	if(darkR)
		darKA = removeDarkR(imTitle);
	
	/*Set autothreshold method with Minum and get the input from the user
regarding it. Also save the threshold to file*/
	run("Select None");
	setAutoThreshold("Minimum");
	waitForUser(setThr);
	getThreshold(minth, maxth);
	setThreshold(minth,maxth);
	print(f, "Threshold\t" + minth + "\t" + maxth);
	
	/*If remove dark regions was selected save the parameters to file
	This is here to maintain the order of the file to enable previous analysis to function*/
	if(darkR)
		print(f, "DarkR\t" + darKA[0] + "\t" + darKA[1]);
	else
		print(f, "DarkR\t" + 0 + "\t" + 0);
	
	roiManager("Show All without labels");
	roiManager("Show None");

	//analyse particles function
	totalSlices = makeAnalysis(stagger, fps, mCubeArea, 4);

	roiManager("Show All without labels");
	roiManager("Show None");
	//Save ROIs to a file in the folder of the image
	roiManager("Save", dir + imTitle + "ROIs.zip");
	
	//Write preferences to the file of the analysis
	writePreferences(f);
	//File operations done!
	File.close(f);
	run("Select None");

	oriID=getImageID();
	getParametersRT(fps, dir, imTitle, nRegions, totalSlices);
	dialog2(oriID, dir, imTitle, 4);
	
}

/*This function goes through the ROIs, creates and fills arrays with the
result of the ROI analysis and then prints them to 2 files with the individual
results and a summary of the results*/
function getParametersRT(fps,dir, imTitle, n, totalSlices){
	//Determine the delay between ROIs
	if(fps != 25){
		delay = 1/fps;
	}else
		delay = 1/25;
	

	run("Set Measurements...", "centroid redirect=None decimal=3");
	
	/*Create arrays to hold the individual parameters of each ROI*/
	arrayX = newArray(roiManager("Count"));
	arrayY = newArray(roiManager("Count"));
	displacement = newArray(roiManager("Count"));
	velocity = newArray(roiManager("Count"));
	nearRegions = newArray(roiManager("Count") * n * 2);
	timeRegions = newArray(n * 2);
	timeRegionsF = newArray(n);
	ncountRegions = newArray(n);
	flags = newArray(n);
	Array.fill(timeRegions, 0);
	Array.fill(flags, 1);

	displa = 0;
	roiManager("Deselect");
	
	setBatchMode("hide");
	/*Main loop to go trough all the ROIs and get the stats*/
	for(i=0, j = 0; i<roiManager("count");i++){
		showProgress(i, roiManager("count"));
		showStatus("Analysing detections...");
		
		roiManager("Select", i);
		List.setMeasurements();
		//Get center of mass of ROI
		arrayX[i] = List.getValue("X");
		arrayY[i] = List.getValue("Y");

		//Get result from magic function
		angle = getDirectionRT(dir, imTitle, n);	
				
		//Fill in if the mouse head is near any of the regions
		for(k = 0, m=0; k < n; k++, m++){
			if(angle[m]){
				nearRegions[j] = "Yes";
				timeRegions[m] = timeRegions[m] + delay;
				if((nearRegions[j] == "Yes" && i == 0))
					ncountRegions[k] = ncountRegions[k] + 1;
			
				if(nearRegions[j] == "Yes" && i > 0)
					if(nearRegions[j-(n*2)] == "No")
						ncountRegions[k] = ncountRegions[k] + 1;
				if(flags[k]){
					timeRegionsF[k] = delay * i;
					flags[k] = 0;
				}	
			}else
				nearRegions[j] = "No";
			m++;
			if(angle[m]){
				nearRegions[j+1] = "Yes";
				timeRegions[m] = timeRegions[m] + delay;
			}else
				nearRegions[j+1] = "No";
			

			j = j + 2;
		}
		
		/*Displacement / Velocity /  Stopped*/	
		if(i==0){
			displacement[i] = 0;
			velocity[i] = 0;

		}else{
			displacement[i] = calculateDistance(arrayX[i-1], arrayY[i-1], arrayX[i], arrayY[i]);
			velocity[i] = displacement[i]/delay;
			displa = displa + displacement[i];
			
		}

	}
	
	setBatchMode("show");
	run("Select None");
	
	/*Write results to tables both to single spots as the summary*/
	run("Clear Results");
	for(i=0, j=0; i<roiManager("count"); i++){
		showProgress(i, roiManager("count"));
		showStatus("Writing results...");
		setResult("X Center",i, arrayX[i]);
		setResult("Y Center",i, arrayY[i]);
		setResult("Displacement (cm)",i, displacement[i]);
		setResult("Velocity (cm/s)",i, velocity[i]);
		for(k = 0; k < n; k++){
			str = "Head near Region " + k + 1;
			setResult(str, i, nearRegions[j]);

					
			str = "Body near region " + k + 1;
			setResult(str, i, nearRegions[j+1]);
			j = j + 2; 
		}
		
	}
	updateResults();


	selectWindow("Results");
	saveAs("text", dir+imTitle+".Spots.xls");
	run("Clear Results"); 

	setResult("Label", 0, "Total displacement"); 
	setResult("Value", 0, displa);
	setResult("Label", 1,"Total time"); 
	setResult("Value",1, totalSlices * delay);
	setResult("Label", 2, "Average displacement");
	Array.getStatistics(displacement, min,max,mean,dev);
	setResult("Value", 2, mean);
	setResult("Label", 3, "Average velocity");
	Array.getStatistics(velocity, min,max,mean,dev);
	setResult("Value", 3, mean);
	line = 3;
	for(k = 0, m=0; k < n; k++, m++){
		str = "Time head near Region " + k + 1;
		setResult("Label", line, str);
		setResult("Value", line, timeRegions[m]);
		line++;
		m++;
		str = "Time body near Region " + k + 1;
		setResult("Label", line, str);
		setResult("Value", line, timeRegions[m]);
		line++;
	}

	for(k = 0; k < timeRegionsF.length; k++){
		str = "First time head near Region " + k + 1;
		setResult("Label", line, str);
		setResult("Value", line, timeRegionsF[k]);
		line++;
		str = "Number of times at Region " + k +1;
		setResult("Label", line, str);
		setResult("Value", line, ncountRegions[k]); 
		line++;
	}

	updateResults();
	selectWindow("Results");
	saveAs("text", dir+imTitle+".Track.xls");
	run("Close");

}

/*Get individual parameters for the ROI of mice in NR*/
function getDirectionRT(dir, imTitle, n){
	//Results array
	angle = newArray((n*2));
	Array.fill(angle, 0);
		
		
	//Get the coordinates of the selection
	getSelectionCoordinates(xp, yp);
	List.setMeasurements();
		
	//Center mass of the selection
	xc = List.getValue("X");
	yc = List.getValue("Y");
	toUnscaled(xc, yc);
		
	//New array for the lengths of center to the perimeter of the selection
	length = newArray(xp.length);
	//Fill the array with the distances
	for(i = 0; i < xp.length; i++){
		length[i]= calculateDistance(xc,yc,xp[i],yp[i]);
	}

	/*Get the maxs and mins of the length array
	Max distance should be head (in most cases) minimal distances are curves of behind*/
	nInter = 10;
	do{
		maxlengths = Array.findMaxima(length, nInter);
		minlengths = Array.findMinima(length, nInter);
		nInter = round(nInter - (nInter/3));
	}while(lengthOf(maxlengths)==0)
		
	/*Loop trough regions to see if mouse is close to them or not*/
	for(i = 0, j = 0 ; i < n; i++, j++){
		regAprox = sortRegions(xp, yp, xc, yc, maxlengths[0], dir, imTitle,  i);
		angle[j] = regAprox[0];
		j++;
		angle[j] = regAprox[1];
	}

	return angle;
 
}

/*Function to see if the mouse is near a region of interest or not
Inputs: xp, yp - ROI coordinates
xc, yc - mouse center of mass
headC - array position of mouse head
n - number of regions*/
function sortRegions(xp, yp, xc, yc, headC, dir, imTitle, n){
	//Results array
	temp = newArray(2);
	Array.fill(temp, 0);
	//get the region from file
	regArray = getFileData(6+n, dir, imTitle, 4);
	
	//calculate center of oval and ratio
	radius = (regArray[2] + regArray[3])/4;
	centerX = regArray[0] + (regArray[2]/2);
	centerY = regArray[1] + (regArray[3]/2);
	
	//Calculate distance from center of region to center of mass of mouse
	dist = calculateDistance(centerX, centerY, xc, yc);
	
	/*check if the mouse is close to the regions
	If the center of mouse is further away then 6 radius donºt bother*/
	if(dist < radius * 6){
		/*Calculate the distance of the head to the regions*/
		dist = calculateDistance(centerX,centerY,xp[headC],yp[headC]);
		if(dist <= radius * 2){
			temp[0] = 1;
		/*Calculate the distance of all the other regions of the mouse to 
		see if they are near the region or not*/
		}else{
			for(i = 0; i < xp.length; i++){
				dist = calculateDistance(centerX,centerY,xp[i],yp[i]);
				if(dist <= radius * 2){
					temp[1] = 1;
					i = lengthOf(xp);
				}
			}
		}
	}
	

	return temp;
	
	
}


/*Function to evaluate the TY Maize. Its main job is to track the mouse in the 
cross like puzzle and calculate the time spent in each arm and the 
first time it goes in each arm*/
function MiceYTTracker(){
	
	//Select the directory of the open image to be analysed	
	checkAndSort();

	//First clean up and setup the macro actions
	dir = getDirectory("image");
	imTitle = getTitle();
	rectRegions = newArray(4);
	run("Set Measurements...", "limit redirect=None decimal=3");
	
	//Run guassian blur if so selected in Dialog1
	temp = dialog1(5);
	blaWhi = temp[0];
	fps = temp[1];
	armsD = temp[2];
	darkR = temp[5];
	gaus = temp[6];
	stagger = temp[7];
	
	 /* Takes care of cases where an analysis file exists already
	asks if you want to delete it or not */
	if(File.exists(dir + imTitle + ".TY.trac")){
		showMessageWithCancel(delFile);
		File.delete(dir + imTitle + ".TY.trac");		
	}
	
	/*Create a new Analysis file. It is very important not to change the order that
	instructions get writen to this file as that will screw up the function
	to redo previous analysis*/
	f = File.open(dir + imTitle + ".TY.trac");
	print(f, dir + "\t" + getWidth + "\t" + getHeight + "\t" + nSlices + "\t" + gaus);
	print(f, imTitle);
	print(f, "FPS\t" + fps);

	//Draw a triangle for the user to adujst to the triangle of the TY
	getDimensions(width, height, channels, slices, frames);
	makePolygon(width/2, height/2,width/2 + 40, height/2,width/2 + 20, height/2+40);
	waitForUser("Please adjust the vertices of the triangle to match the vertices of the arms");

	//get the dimensions of the triangle in the center of the T/Y and print it to file
	getSelectionCoordinates(px, py);
	stringx = "";
	stringy = "";
	for(i = 0; i < px.length; i++){
		stringx = stringx + toString(px[i]) + "\t";
		stringy = stringy + toString(py[i]) + "\t";
	}
	print(f, "TYtriangleX" + "\t"+stringx);	
	print(f, "TYtriangleY" + "\t"+stringy);	
	
	dist = 0;
	dist = dist + calculateDistance(px[0], py[0], px[1], py[1]);
	dist = dist + calculateDistance(px[0], py[0], px[2], py[2]);
	dist = dist + calculateDistance(px[1], py[1], px[2], py[2]);
	dist = dist /3;
	
	/*Checks if the pixel size is set and if not sets it from the 
dimensions of the triangle*/
	getPixelSize(unit, pw, ph);
	if(pw == 1 && ph == 1){
		pixx = armsD/dist; pixy = armsD/dist;
		print(f, "Pixel size\t"+pixx+"\t"+pixy);	
		//Set the pizel size 
		run("Properties...", "channels=1 slices="+nSlices+" frames=1 unit="+units+" pixel_width="+pixx+" pixel_height="+pixy+" voxel_depth=1");
	}
	else 
		print(f, "Pixel size\t"+pw+"\t"+ph);	


	/*Asks the user to draw the polygon that the cross forms to clear outside ot if
	and prints the coordinates to file*/
	run("Select None");
	setTool("polygon");
	waitForUser("Please make a polygon to match the bottom of the T/Y erasing all dark regions.");
	getSelectionCoordinates(px, py);
	stringx = "";
	stringy = "";
	for(i = 0; i < px.length; i++){
		stringx = stringx + toString(px[i]) + "\t";
		stringy = stringy + toString(py[i]) + "\t";
	}
	print(f, "TYregionX" + "\t"+stringx);	
	print(f, "TYregionY" + "\t"+stringy);	
	

	/*Removed this VS reference to make my life easier*/
	setBatchMode("hide");
	/*if(is("Virtual Stack")){
		roiManager("Add");
		close();
		sortVirtual(dir, 0, 3);
		roiManager("Reset");
	}else{*/
	
	//Changes the backgrnd color to match black or white mice
	if(!blaWhi)
		setBackgroundColor(255, 255, 255);
	else
		setBackgroundColor(0, 0, 0);
			
		run("Clear Outside", "stack");
		
	setBatchMode("show");

	if(darkR)
		darKA = removeDarkR(imTitle);
		
	setBatchMode("show");
	/*Set autothreshold method with Minimum and get the input from the user
	regarding it. Also save the threshold to file*/
	setAutoThreshold("Minimum");
	waitForUser(setThr);
	getThreshold(minth, maxth);
	setThreshold(minth,maxth);
	print(f, "Threshold\t" + minth + "\t" + maxth);
	if(darkR)
		print(f, "DarkR\t" + darKA[0] + "\t" + darKA[1]);
	else
		print(f, "DarkR\t" + 0 + "\t" + 0 );

	//analyse particles function (here totalSlices is first slice)
	totalSlices = makeAnalysis(stagger, fps, mTYArea, 5);
	
	roiManager("Show All without labels");
	roiManager("Show None");

	//Save ROIs to a file in the folder of the image
	roiManager("Save", dir + imTitle + "ROIs.zip");
	
	//Write preferences to the file of the analysis	
	writePreferences(f);
	//File operations done!
	File.close(f);
	run("Select None");

	oriID=getImageID();
	getParametersTY(fps, dir, imTitle, totalSlices);
	dialog2(oriID, dir, imTitle, 5);
	
}


/*This function goes through the ROIs, creates and fills arrays with the
result of the ROI analysis and then prints them to 2 files with the individual
results and a summary of the results*/
function getParametersTY(fps, dir, imTitle, sStart){
	//Determine the delay between ROIs
	if(fps != 25){
		delay = 1/fps;
	}else
		delay = 1/25;

	run("Set Measurements...", "area centroid redirect=None decimal=3");
	
	/*Create arrays to hold the individual parameters of each ROI*/
	arrayX = newArray(roiManager("Count"));
	arrayY = newArray(roiManager("Count"));
	displacement = newArray(roiManager("Count"));
	velocity = newArray(roiManager("Count"));
	armsPosition = newArray(roiManager("Count"));
	armsPositionA = newArray(roiManager("Count"));
	slices = newArray(roiManager("Count"));
	
	/*count and sum variables for the individual parameters*/
	displa = 0; visit1 = 0; visit2=0; visit3 = 0; 
	time1 = 0; time2 = 0; time3=0;
	order1 = 0; order2 = 0; order3=0;
	ordem = "";
	
	roiManager("Deselect");
	setBatchMode("hide");
	/*Main loop to go trough all the ROIs and get the stats*/
	for(i=0; i<roiManager("count");i++){
		showProgress(i, roiManager("count"));
		showStatus("Analysing detections...");
		roiManager("Select", i);
		//smooth a bit the selection to eliminate tails and small bits on walls
		//keeping the head - due to problems in the ilumination
		run("Enlarge...", "enlarge=-"+sTY+" pixel");
		run("Enlarge...", "enlarge="+sTY+" pixel");
		List.setMeasurements();
 
		//Center coordinates of mouse
		arrayX[i] = List.getValue("X");
		arrayY[i] = List.getValue("Y");
		

		//armsPosition is an array which provides several properties to setup
		//information. 
		armsPosition[i] = getDirectionTY();			
		slices[i] = (getSliceNumber() - sStart);


				
		if(i==0){
			displacement[i] = 0;
			velocity[i] = 0;

		}else{
			/*Displacement / Velocity */	
			displacement[i] = calculateDistance(arrayX[i-1], arrayY[i-1], arrayX[i], arrayY[i]);
			velocity[i] = displacement[i]/delay;
			if(displacement[i] > dispVal)
				displa = displa + displacement[i];

					
		}
			
	}

	r = 7; //window length
	for(j=r; j<lengthOf(armsPosition)-r;j++){
		count0 = 0; count1 = 0; count2=0; count3=0;
		for(m = j - r/2; m <= j + r/2; m++){
			if(armsPosition[m] == 0)
				count0++;
			else if(armsPosition[m] == 1)
				count1++;
			else if(armsPosition[m] == 2)
				count2++;
			else
				count3++;
	
		}
		
		if(count0 >= count1 && count0 >= count2 && count0 >= count3)
			armsPositionA[j]=0;
		else if(count1 > count0 && count1 > count2 && count1 > count3)
			armsPositionA[j]=1;
		else if(count2 > count0 && count2 > count1 && count2 > count3)
			armsPositionA[j]=2;
		else 
			armsPositionA[j]=3;
	}

	
	/*Positions in the arms*/
	ordem = toString(armsPosition[0]);
	
	for(i = 1; i< armsPositionA.length; i++){
		if(armsPositionA[i]==1){
			time1 = time1 + delay;
			if(armsPositionA[i-1] != 1){
				visit1++;
				ordem = ordem + ",1";
				if(order1 == 0){
					roiManager("Select", i);
					order1 = delay * (getSliceNumber()-sStart);
				}
					
			}
				
		}else if(armsPosition[i]==2){
			time2 = time2 + delay;
			if(armsPosition[i-1] != 2){
				visit2++;
				ordem = ordem + ",2";
				if(order2 == 0){
					roiManager("Select", i);
					order2 = delay * (getSliceNumber()-sStart);
				}
					
			}
		}else if(armsPosition[i]==3){
			time3 = time3 + delay;
			if(armsPosition[i-1] != 3){
				visit3++;
				ordem = ordem + ",3";
				if(order3 == 0){
					roiManager("Select", i);
					order3 = delay * (getSliceNumber()-sStart);
				}
					
			}
		}else ;

	}

	

	
	setBatchMode("show");
	run("Select None");

	tripletStory = getTripletStat(ordem);

	run("Clear Results");
	/*Write results to tables both to single spots as the summary*/
	for(i=0; i<roiManager("count"); i++){
		showProgress(i, roiManager("count"));
		showStatus("Writing results...");
		setResult("Slice", i, slices[i]);
		setResult("X Center",i, arrayX[i]);
		setResult("Y Center",i, arrayY[i]);
		setResult("Displacement (cm)",i, displacement[i]);
		setResult("Velocity (cm/s)",i, velocity[i]);
		setResult("In Arm (1-Center, 2-Left, 3-Right",i, armsPosition[i]);
		
	}
	updateResults();

	selectWindow("Results");
	saveAs("text", dir+imTitle+".SpotsTY.xls");
	run("Clear Results"); 


	setResult("Label", 0, "Total displacement"); 
	setResult("Value", 0, displa);
	setResult("Label", 1, "Number of visits to center arm"); 
	setResult("Value", 1, visit1);
	setResult("Label", 2, "Number of visits to left arm"); 
	setResult("Value", 2, visit2);
	setResult("Label", 3, "Number of visits to right arm"); 
	setResult("Value", 3,  visit3);
	setResult("Label", 4, "Time spent in center arm"); 
	setResult("Value", 4, time1);
	setResult("Label", 5, "Time spent in left arm"); 
	setResult("Value", 5, time2);
	setResult("Label", 6, "Time spent in right arm"); 
	setResult("Value", 6, time3);
	setResult("Label", 7, "Time to first visit to center arm"); 
	setResult("Value", 7, order1);
	setResult("Label", 8, "Time to first visit to left arm"); 
	setResult("Value", 8, order2);
	setResult("Label", 9, "Time to first visit to right arm"); 
	setResult("Value", 9, order3);
	setResult("Label", 10, "Average displacement");
	Array.getStatistics(displacement, min,max,mean,dev);
	setResult("Value", 10, mean);
	setResult("Label", 11, "Average velocity");
	Array.getStatistics(velocity, min,max,mean,dev);
	setResult("Value", 11, mean);
	setResult("Label", 12, "Order of arms entry");
	setResult("Value", 12, ordem);
	setResult("Label", 13, "Different triplets");
	setResult("Value", 13, tripletStory[0]);
	/*TODO remove double comment*/
	setResult("Label", 14, "Total triplets"); 
	setResult("Value", 14, tripletStory[1]);

	
	updateResults();
	selectWindow("Results");
	saveAs("text", dir+imTitle+".TrackTY.xls");
	run("Close");

}


/*Get individual parameters for the ROI of mice in OpenField*/
function getDirectionTY(){

		//Get the coordinates of the selection
		getSelectionCoordinates(xp, yp);

		center = 0; left = 0; rigth = 0;

		//Get central box parameters
		triangleX = getFileData(3, dir, imTitle, 5);
		triangleY = getFileData(4, dir, imTitle, 5);

		y = (triangleY[0] + triangleY[1])/2;
		xl = triangleX[0] + (abs(triangleX[0] - triangleX[2])/2);
		xr = triangleX[1] - (abs(triangleX[1] - triangleX[2])/2);


		
		for(i = 0; i < xp.length; i++){
			//Check where the coordinates are
			if(yp[i] <= y && triangleY[0] < triangleY[2])
				center++;
			else if(yp[i] > y && triangleY[0] > triangleY[2])
				center++;
			else if(xp[i] <= xl)
				left++;
			else if(xp[i] > xr)
				rigth++;
			else ;
		}
		
		
		if(center >= lengthOf(xp)*0.9)
			angle = 1;
		else if(left >= lengthOf(xp)*0.9)
			angle = 2;
		else if(rigth >= lengthOf(xp)*0.9)
			angle = 3;
		else
			angle = 0;

		
		return angle;
	 
}

/*
 Function for Fear Conditioning analysis. Its main job its to determine
  if the mouse freezes or not
 */
function fearConditioning(){

	checkAndSort();

	//Select the directory of the open image to be analysed
	dir = getDirectory("image");
	imTitle = getTitle();
	rectCoord = newArray(4);

	run("Set Measurements...", "limit redirect=None decimal=3");

	 //Get the parameters of the Dialog1
	temp = dialog1(6);
	blaWhi = temp[0];
	fps = temp[1];
	boxW = temp[2];
	boxH = temp[3];
	darkR = temp[5];
	gaus = temp[6];
	stagger = temp[7];
	
	/* Takes care of cases where an analysis file exists already
	asks if you want to delete it or not */
	if(File.exists(dir + imTitle + ".free.trac")){
		showMessageWithCancel(delFile);
		File.delete(dir + imTitle + ".free.trac");		
	}
	
	/*Create a new Analysis file. It is very important not to change the order that
	instructions get writen to this file as that will screw up the function
	to redo previous analysis*/
	f = File.open(dir + imTitle + ".free.trac");
	print(f, dir + "\t" + getWidth() + "\t" +  getHeight() + "\t" + nSlices() +"\t"+ gaus);
	print(f, imTitle);
	print(f, "FPS\t" + fps);
	
	//Run guassian blur if so selected in Dialog1
	if(gaus > 0){
		setBatchMode("hide");
		run("Gaussian Blur...", "sigma="+gaus+" stack");
		
	}
	setBatchMode("show");
	//Asks the user to draw the polygon that the box form, writes it to file and clears outside
	run("Select None");
	setTool("polygon");
	waitForUser("Please make a polygon to match the cage bottom.");
	getSelectionCoordinates(px, py);
	stringx = "";
	stringy = "";
	for(i = 0; i < px.length; i++){
		stringx = stringx + toString(px[i]) + "\t";
		stringy = stringy + toString(py[i]) + "\t";
	}
	print(f, "BoxBottomX" + "\t"+stringx);	
	print(f, "BoxBottomY" + "\t"+stringy);	
	
	setBatchMode("hide");
	/*Removed this VS reference to make my life easier*/
	/*if(is("Virtual Stack")){
		roiManager("Add");
		close();
		sortVirtual(dir, 0, 3);
		roiManager("Reset");
	}else{*/
	//Changes the backgrnd color to match black or white mice	
	if(!blaWhi)
		setBackgroundColor(255, 255, 255);
	else
		setBackgroundColor(0, 0, 0);
		
	run("Clear Outside", "stack");

	setBatchMode("show");
	
	//Remove dark regions if so selected
	if(darkR)
		darkA = removeDarkR(imTitle);
	
	/*Another gaussian blur in the diference stack to try and reduce the 
	wave patterns of the images*/
	run("Gaussian Blur...", "sigma="+gaus+" stack");
	
	/*Set autothreshold method with Minum and get the input from the user
regarding it. Also save the threshold to file*/
	setAutoThreshold("Minimum");  
	waitForUser(setThr);
	getThreshold(minth, maxth);
	print(f, "Threshold\t"+minth+"\t"+maxth);
	
	/*If remove dark regions was selected save the parameters to file
	This is here to maintain the order of the file to enable previous analysis to function*/
	if(darkR)
		print(f, "DarkR\t" + darkA[0] +"\t"+ darkA[1]);
	else 
		print(f, "DarkR\t" + 0 +"\t"+ 0);
	
	//Actually set threshold
	setThreshold(minth,maxth);
		
	roiManager("Show All without labels");
	roiManager("Show None");
	
	//analyse particles function
	totalSlices = makeAnalysis(stagger, fps, mFreezeArea, 6);
	
	//Save ROIs to a file in the folder of the image
	roiManager("Show All without labels");
	roiManager("Show None");
	roiManager("Save", dir + imTitle + "ROIs.zip");
	//Write preferences to the file of the analysis
	writePreferences(f);
	//File operations done!
	File.close(f);

	
	run("Select None");

	//Get data of the dectetions
	oriID=getImageID();
	freezeCheck(fps, dir, imTitle);
	dialog2(oriID, dir, imTitle, 6);

}

/*This function goes through the ROIs, creates and fills arrays with the
result of the ROI analysis and then prints them to 2 files with the individual
results and a summary of the results*/
function freezeCheck(fps, dir, imTitle, sStart){
	//Determine the delay between ROIs
	delay = 1/fps;
	run("Select None");
	
	fre = newArray(roiManager("count")-1);
	Array.fill(fre, 0);
	freezeT = 0;
	count = 0;
	
	sA = newArray(2);
	setBatchMode("hide");
	
	/*Main loop to go trough all the ROIs and get the stats*/
	for(i = 0, j = 0; i < roiManager("Count")-1; i++){
		showProgress(i,roiManager("Count"));
		showStatus("Analysing detections...");
		//Create array to select 2 ROIs
		sA[0] = i; sA[1] = i+1;
		roiManager("Select", sA);
		//Mare XOR selection
		roiManager("XOR");
		//Get area of XOr selection
		getStatistics(area);
		fre[i] = area; 
		//Count frames that mouse is freezed
		if(area <= 500){
			count++;
		}else{
			/*If freeze frames are more then half then print to results start and ending frames
			of freeze section*/
			if(count > fps/2){
				setResult("Still start frame", j, (getSliceNumber()- sStart) - count);
				setResult("Still finished frame", j, (getSliceNumber()- sStart));
				setResult("Time Still", j , delay * count);
				freezeT = freezeT + (count*delay);
				count = 0;	
				j++;
			}else
				count = 0;
		}
		 		 	
	}
		

	setBatchMode("show");

	updateResults();

	selectWindow("Results");
	saveAs("text", dir+imTitle+".Spots.xls");
	run("Close");

	
	print("Total freezing time: " + freezeT + "s.");

}


/*Dialog function for setting the preferences for all main functions*/
function Preferences(){
	
	Dialog.create("JAMoT Preferences");
	//General preferences
	Dialog.addMessage("General preferences");
	Dialog.addChoice("Units of work", newArray("m", "cm", "mm","microns"), units);
	Dialog.addNumber("Guassian blur to apply", gauVal);
	Dialog.addNumber("Minimum displacement to consider a moving mouse (units)", dispVal);
	//Cube and Objects Maizes
	Dialog.addMessage("Open Field Preferences");
	Dialog.addNumber("Rearing - Solidity (Cube only)", solidity);
	Dialog.addNumber("Default width of box", wCube);
	Dialog.addNumber("Mouse minimal area (pixels)", mCubeArea);
	//Elevated Maize
	Dialog.addMessage("Elevated Maize Preferences");
	Dialog.addNumber("Width of arms", wElevated);
	Dialog.addNumber("Length of arms", lElevated);
	Dialog.addNumber("Mouse minimal area (pixels)", mElevatedArea);
	Dialog.addNumber("Selection smoothing value (pixels)", sElevated);
	//Swimming Maize
	Dialog.addMessage("Swimming pool maize Preferences");
	Dialog.addNumber("Pool diameter", dSwimming);
	Dialog.addNumber("Mouse minimal area (pixels)", mSwimmingArea);
	Dialog.addNumber("Distance to pool wall to count as at wall (units)", poolWD);
	//T/Y Maize
	Dialog.addMessage("T/Y Maize Preferences");
	Dialog.addNumber("Arms width", wTY);
	Dialog.addNumber("Mouse minimal area (pixels)", mTYArea);
	Dialog.addNumber("Selection smoothing value (pixels)", sTY);
	//Freeze test
	Dialog.addMessage("Freezing Maize Parameters");
	Dialog.addNumber("Mouse minimal area (pixels)", mFreezeArea);
	Dialog.addNumber("Selection smoothing value (pixels)", sFreeze);
	//Defaults
	Dialog.addMessage("To use default parameters, check the box below.\n Above values will be ignored");
	Dialog.addCheckbox("Revert to default settings", false);
	Dialog.show();
	
	//General
	unitsL = Dialog.getChoice();
	gauValL = Dialog.getNumber();
	dispValL = Dialog.getNumber();
	//Cube Maize
	solidityL = Dialog.getNumber();
	wCubeL = Dialog.getNumber();
	mCubeAreaL = Dialog.getNumber();
	//Elevated Maize
	wElevatedL = Dialog.getNumber();
	lElevatedL = Dialog.getNumber();
	mElevatedAreaL = Dialog.getNumber();
	sElevatedL = Dialog.getNumber();
	//Swimming Maize
	dSwimmingL = Dialog.getNumber();
	mSwimmingAreaL = Dialog.getNumber();
	poolWDL = Dialog.getNumber();
	//T/Y Maize
	wTYL = Dialog.getNumber();
	mTYAreaL = Dialog.getNumber();
	sTYL = Dialog.getNumber();
	//Freeze test
	mFreezeAreaL = Dialog.getNumber();
	sFreezeL = Dialog.getNumber();
	//Default
	default = Dialog.getCheckbox();
	
	if(!default){
		//General
		call("ij.Prefs.set", "JAMoT_Prefs.gen.units", unitsL);
		call("ij.Prefs.set", "JAMoT_Prefs.gen.gauval", gauValL);
		call("ij.Prefs.set", "JAMoT_Prefs.gen.dispVal", dispValL);
		//Cube Maize
		call("ij.Prefs.set", "JAMoT_Prefs.cube.soli", solidityL);
		call("ij.Prefs.set", "JAMoT_Prefs.cube.width", wCubeL);
		call("ij.Prefs.set", "JAMoT_Prefs.cube.marea", mCubeAreaL);
		//Elevated Maize
		call("ij.Prefs.set", "JAMoT_Prefs.elev.width", wElevatedL);
		call("ij.Prefs.set", "JAMoT_Prefs.elev.length", lElevatedL);
		call("ij.Prefs.set", "JAMoT_Prefs.elev.marea", mElevatedAreaL);
		call("ij.Prefs.set", "JAMoT_Prefs.elev.smooth", sElevatedL);
		//Swimming Maize
		call("ij.Prefs.set", "JAMoT_Prefs.swim.dia", dSwimmingL);
		call("ij.Prefs.set", "JAMoT_Prefs.swim.marea", mSwimmingAreaL);
		call("ij.Prefs.set", "JAMoT_Prefs.swim.poolWD", poolWDL);
		//T/Y Maize
		call("ij.Prefs.set", "JAMoT_Prefs.ty.width", wTYL);
		call("ij.Prefs.set", "JAMoT_Prefs.ty.marea", mTYAreaL);
		call("ij.Prefs.set", "JAMoT_Prefs.ty.smooth", sTYL);
		//Freeze Maize
		call("ij.Prefs.set", "JAMoT_Prefs.fre.marea", mFreezeAreaL);
		call("ij.Prefs.set", "JAMoT_Prefs.fre.smooth", sFreezeL);
	}else{
		//General
		call("ij.Prefs.set", "JAMoT_Prefs.gen.units", "cm");
		call("ij.Prefs.set", "JAMoT_Prefs.gen.gauval", 2);
		call("ij.Prefs.set", "JAMoT_Prefs.gen.dispVal", 0.1);
		//Cube Maize
		call("ij.Prefs.set", "JAMoT_Prefs.cube.soli", 0.8);
		call("ij.Prefs.set", "JAMoT_Prefs.cube.width", 38);
		call("ij.Prefs.set", "JAMoT_Prefs.cube.marea", 500);
		//Elevated Maize
		call("ij.Prefs.set", "JAMoT_Prefs.elev.width", 7);
		call("ij.Prefs.set", "JAMoT_Prefs.elev.length", 25);
		call("ij.Prefs.set", "JAMoT_Prefs.elev.marea", 1000);
		call("ij.Prefs.set", "JAMoT_Prefs.elev.smooth", 3);
		//Swimming Maize
		call("ij.Prefs.set", "JAMoT_Prefs.swim.dia", 125);
		call("ij.Prefs.set", "JAMoT_Prefs.swim.marea", 50);
		call("ij.Prefs.set", "JAMoT_Prefs.swim.poolWD",10); 
		//T/Y Maize
		call("ij.Prefs.set", "JAMoT_Prefs.ty.width", 7);
		call("ij.Prefs.set", "JAMoT_Prefs.ty.marea", 15);
		call("ij.Prefs.set", "JAMoT_Prefs.ty.smooth", 3);
		//Freeze maize
		call("ij.Prefs.set", "JAMoT_Prefs.fre.marea", 5000);
		call("ij.Prefs.set", "JAMoT_Prefs.fre.smooth", 10);
	}
	
	exit("Please restart Fiji/ImageJ for changes to take effect.");
}

/*Fucntion to make checks that images are ni the right format
and if not make them so*/
function checkAndSort(){
	if (nSlices==1) exit("Stack required");
	resetThreshold();
	if(!is("grayscale")){
		string = "Image is not grayscale (8-bit). Convert?";
		showMessageWithCancel(string);
		run("8-bit");
	}
	roiManager("Reset");
}


/*First Dialog for all main functions that allows setting up of parameters and choices
for the function*/
function dialog1(option){
	/* 0 - Black/White mice - all
	 * 1-fps
	 * 2-width of box or diamter of pool or arms of Y
	 * 3 - heigth of box
	 * 4 remove regions in pool - regions to analyze in box
	 * 5 - Difference to average projection
	 * 6 - Gaussian blur to apply to stack
	 * 7 - Stagger analysis of ROIs defined by user
	 */
	temp = newArray(8); 
	Array.fill(temp, 0);
	stringA = newArray("OpenField Test", "Elevated Plus Puzzled", "Watermaize Test", "Novel Object Recognition Test", "Y/T Maize", "Fear Conditioning");
	array1 = newArray("Black mice in white bckgrnd", "White mice in black bkgrnd");
	array2 = newArray("25", "20", "15", "5");
	array3 = newArray("Center Region", "Objects");

	str = "JAMouT (Just Another Mouse Tracker) -- " + stringA[option-1];
	Dialog.create(str);
	Dialog.addRadioButtonGroup("Mice color", array1, 1, 2, "Black mice in white bckgrnd");
	
	Dialog.addMessage("Do you want to reduce the tracking resolution to increase speed?");
	Dialog.addRadioButtonGroup("Frames per second (25 is all)", array2, 1, 4, "25");
	
	//Specific dialog options for each macro
	if(option == 1 || option == 4){
		Dialog.addMessage("Measurements of box base:");
		Dialog.addNumber("Width (in " + units+")", wCube);
		Dialog.addNumber("Height (in " + units+")", wCube);
	}
	
	if(option == 2){
		Dialog.addMessage("Measurements of central area/arms of cross:");
		Dialog.addNumber("Width - Height of arms (in " + units+")", wElevated);
		Dialog.addNumber("Length of arms (in " + units+")", lElevated);
	}			

	if(option == 3){
		Dialog.addNumber("Diameter of the pool (in (" + units+"):", dSwimming);
		Dialog.addMessage("Do you want to remove any region(s)? Leave zero if not.");
		Dialog.addNumber("How many", 0);
	}
		
	if(option == 4){
		Dialog.addSlider("Regions to analyze", 1, 5, 2);
	}

	if(option == 5){
		Dialog.addNumber("Width of arms (in " + units+"):", wTY);
	}

	if(option != 3){
		Dialog.addMessage("Dark/White regions processing?");
		Dialog.addCheckbox("Create difference to average projection?", false);
	}

	Dialog.addMessage(" ");
	Dialog.addNumber("Guassian blur to apply to image (0 for not)", gauVal);
	Dialog.addMessage(" ");
	Dialog.addCheckbox("Define start and end for ROI analysis?", false);


	Dialog.show();
	//dark-white
	if(Dialog.getRadioButton() == "White mice in black bkgrnd")
		temp[0] = 1;
	//fps	
	temp[1] = parseInt(Dialog.getRadioButton());

	//Boxes and cross
	if(option == 1 || option == 2 || option == 4){
		temp[2] = Dialog.getNumber();
		temp[3] = Dialog.getNumber();
	}
	//Pool
	if(option==3){
		temp[2] = Dialog.getNumber();
		temp[4] = Dialog.getNumber();
	}
	//Regions
	if(option==4){
		temp[4] = Dialog.getNumber();
	}
	//T/Y
	if(option==5)
		temp[2] = Dialog.getNumber();
	//all but pool - Difference
	if(option!=3){
		if(Dialog.getCheckbox)
		temp[5] = 1;
	}	
	//Gaus blur level
	temp[6] = Dialog.getNumber();
	//Define ROI analysis
	if(Dialog.getCheckbox)
		temp[7] = 1;
	else
		temp[7] = 0;
		
	return temp;

}

/*Dialog to ask what other images (line track or heatmap) you want to take*/
function dialog2(imageID, dir, imTitle, option){
	Dialog.create("Coordinates");
	Dialog.addMessage("What other images to you want?");
	Dialog.addCheckbox("Heatmap", true);
	Dialog.addCheckbox("Line track",true);
	Dialog.show();
	
	heat = Dialog.getCheckbox();
	line = Dialog.getCheckbox();
	
	//Calls respective functions
	if(heat)
		heatMap(imageID, dir, imTitle, option);
		
	if(line)
		lineTrack(imageID, dir, imTitle, option);
	
}

/*Function to sort out the analysis of the stacks to create ROIS
taking into consideration starting and ending points if the user selects stagger
and increase in delay between ROIs (fps)*/
function makeAnalysis(flag, fps, area, option){
	
	totalSlices = 0;
	if(flag == 0){
		setBatchMode("hide");
		if(fps == 25){
			if(option != 3 && option != 5)
				totalSlices = nSlices;
			else
				totalSlices = 1;
			run("Analyze Particles...", "size="+area+"-Infinity pixel include add stack");
		}else{
			for(i = 1; i < nSlices; i = i + 100/fps){
				totalSlices++;
				setSlice(i);
				run("Analyze Particles...", "size="+area+"-Infinity pixel include add slice");
			}
			if(option == 3 || option == 5)
				totalSlices = 1;
		}
		setBatchMode("show");
	}else{
		waitForUser("Please select starting frame for ROI analysis");
		s = getSliceNumber();
		waitForUser("Please select ending frame for ROI analysis");
		e = getSliceNumber();
			
		setBatchMode("hide");
		if(fps == 25){
			if(option != 3 && option != 5)
				totalSlices = e - s;
			else
				totalSlices = s;
			
			for(i = s; i < e; i++){
				setSlice(i);
				run("Analyze Particles...", "size="+area+"-Infinity pixel include add slice");
			}
		
		}else{
			for(i = s; i < e; i = i + 100/fps){
				totalSlices++;
				setSlice(i);
				run("Analyze Particles...", "size="+area+"-Infinity pixel include add slice");
			}
			if(option == 3 || option == 5)
				totalSlices = s;
		}
		setBatchMode("show");
	}
	
	
	return totalSlices;
	
}


/*this function has been removed due to complications in supporting Virtual Stacks 
for analysis. Left it here for future.
//Function to sort the virtual stack and clear outside
function sortVirtual(dir, rectCoord, option, colorM){
	showStatus("Sorting out virtual stack");
	setBatchMode(true);
	list = getFileList(dir);
	if(nSlices < list.length)
		showMessageWithCancel("The virtual stack files do not appear to exist!\nThis virtual stack was not created with Process Video Tool.\nPress ok to continue as normal stack or cancel to stop macro");
	
	else{
		name = getTitle();
		for(i=0;i<list.length;i++){
			showProgress(i/list.length);
	        if (endsWith(list[i], "tif")){
	        	open(dir+list[i]);
	        	if(!colorM)
	        		setBackgroundColor(255,255,255);
	        	else
	        		setBackgroundColor(0,0,0);
	        	
	        	if(option == 1){
	        		makeRectangle(rectCoord[0], rectCoord[1], rectCoord[2], rectCoord[3]);
	        		run("Enlarge...", "enlarge=15 pixel");
	        		run("Clear Outside", "slice");
	        		run("Enlarge...", "enlarge=-15 pixel");
	        		//Reduce intensity of the cage wall
					run("Enlarge...", "enlarge=-15 pixel");
					run("Make Band...", "band=25");
					run("Gaussian Blur...", "sigma=10 stack");		
	        	}
	        	else if(option == 3){
	        		makeOval(rectCoord[0], rectCoord[1], rectCoord[2], rectCoord[3]);
	        		run("Clear Outside", "slice");
	        	}
	        	//From Dialog1
	        	else if(option == 10){
	        		run("Invert", "slice");
	        	}
	        	else{
	        		roiManager("Select", rectCoord[0]);
	        		run("Clear Outside", "slice");
	        	}
	        	
	        	save(dir+list[i]);
	        }
	
		}
	}
	
	setBatchMode(false);
	close();	
	run("Image Sequence...", "open="+dir+".tif file=tif sort use");
	
}*/


/*Function to draw the path of the mouse along time using a line
It also draws the maize and other parameters of the maizes*/
function lineTrack(imageID, dir, imTitle, option){
		
	selectImage(imageID);
	getDimensions(width, height, channels, slices, frames);
	newImage("lineTrack", "8-bit black", width, height, 1);
	setBatchMode("show");
	
	if(option == 1) //Empty box
		choice = promptandgetChoice(0, 1, 0, 0, 0, 0);
	else if(option == 2 || option == 5)//Cross and TY regions
		choice = promptandgetChoice(0, 0, 0, 1, 0, 0);
	else if(option == 3) //Swimming
		choice = promptandgetChoice(0, 0, 1, 0, 0, 0);
	else if(option == 4) //Regions
		choice = promptandgetChoice(0, 0, 0, 0, 1, 0);
	else if(option== 6) //Fear 
		choice = promptandgetChoice(0, 0, 0, 0, 0, 1);


	if(choice[1]){
		setForegroundColor(255,255,255);
		//Empty box and regions box
		if(option == 1 || option == 4){
			array = getFileData(3, dir, imTitle, option);
			drawRect(array[0], array[1], array[2], array[3]);
		}
		//Swimming option
		else if(option == 3){								
			array = getFileData(3, dir, imTitle, option);
			drawOval(array[0], array[1], array[2], array[3]);
		}
		//Cross option
		else{
			if(option == 2)
				n = 5;
			else if(option == 6)
				n = 3;
			else if(option == 4)
				n = 6;
															
			arrayx = getFileData(n, dir, imTitle, option);
			arrayy = getFileData(n+1, dir, imTitle, option);
			moveTo(arrayx[0], arrayy[0]);
	     	for (i=1; i<arrayx.length; i++)
	         	lineTo(arrayx[i], arrayy[i]);
	
	        lineTo(arrayx[0], arrayy[0]);
		}
		
	}

	if(choice[2]){
		setForegroundColor(255,255,255);
		//Empty box
		if(option == 1){
			array = getFileData(4, dir, imTitle, option);
			drawRect(array[0], array[1], array[2], array[3]);
		}
		//Swimming option
		else if(option == 3){								
			array = getFileData(5, dir, imTitle, option);
			drawOval(array[0], array[1], array[2], array[3]);
		}

		//Regions option
		else if(option == 4){
			count = countLinesStartingWith(dir, imTitle, option, "Object");
			for(k = 6, j = 1; k < (6+count); k++,j++){
				array = getFileData(k, dir, imTitle, option);
				drawOval(array[0], array[1], array[2], array[3]);
				drawString(toString(j), (array[0]+array[2]/2)-3, array[1]+array[3]/2);
			}
		}
		
	}
	
	if(choice[3]){
		setForegroundColor(255,255,255);
		//Swimming option
		if(option == 3){
			setLineWidth(2);
			array = getFileData(4, dir, imTitle, option);
			drawLine(array[0]- 5, array[1], array[0] + 5, array[1]);
			drawLine(array[0], array[1] - 5, array[0], array[1] + 5);
			drawString("1", array[0] - 8, array[1]);
			drawString("2", array[0] - 8, array[1] + 15);
			drawString("3", array[0] + 2, array[1]);
			drawString("4", array[0] + 2, array[1] + 15);
			poolWDL = poolWD;
			toUnscaled(poolWDL);
			setLineWidth(1);
			array = getFileData(3, dir, imTitle, option);
			xc = array[0] + array[2]/2;
			yc = array[1] + array[3]/2;
			r = (array[2] + array[3])/4;
			makeOval(array[0] + poolWDL, array[1] + poolWDL, array[2] - (poolWDL*2), array[3] - (poolWDL*2));
			run("Area to Line");
			getSelectionCoordinates(xp, yp);
			for(i = 0; i < xp.length; i = i + 5){
				makePoint(xp[i], yp[i]);
				run("Draw", "slice");
			}
			run("Select None");	
		}
	}
	
	//Actually draw the path of the mouse
	run("Set Measurements...", "centroid redirect=None decimal=3");
	setLineWidth(2);
	setForegroundColor(255, 255, 255); 
	setBatchMode("hide");
	for(i=0;i<roiManager("count")-1;i++){
		showStatus("Creating line track...");
		roiManager("Select", i);
		List.setMeasurements();
		x1 = List.getValue("X");
		y1 = List.getValue("Y");
		roiManager("Select", i+1);
		List.setMeasurements();
		x2 = List.getValue("X");
		y2 = List.getValue("Y");
		drawLine(x1,y1,x2,y2);
	}
	setBatchMode("show");
}


//Create a heatmap of the mice movement
function heatMap(imageID, dir, imTitle, option){
		
		
	if(option == 1) 								//Empty box
		choice = promptandgetChoice(1, 1, 0, 0, 0, 0);
	else if(option == 2 || option == 5)				//Elevated/TY region
		choice = promptandgetChoice(1, 0, 0, 1, 0, 0);
	else if(option == 3)							//Swimming
		choice = promptandgetChoice(1, 0, 1, 0, 0, 0);
	else if(option == 4)
		choice = promptandgetChoice(1, 0, 0, 0, 1, 0);
	else if(option == 6)							//Fear
		choice = promptandgetChoice(1, 0, 0, 0, 0, 1);
		
	x = choice[0];

	selectImage(imageID);
	getDimensions(width, height, channels, slices, frames);
	newImage("HeatMap", "16-bit black", width, height, 1);
	heat = getImageID();
	
	run("Set Measurements...", "centroid redirect=None decimal=3");

	/*Actually draw the heatmap of the ROIs using 
	either the selection or points of 1/4/8 bits*/
	if(x==0){
		selectImage(heat);
		setBatchMode("hide");
		for(i=0; i<roiManager("count");i++){
			showStatus("Creating HeatMap...");
			roiManager("Select", i);
			run("Add...", "value=1 slice");
		}
		setBatchMode("show");
		
	}else{
		selectImage(heat);
		setBatchMode("hide");
		for(i=0; i<roiManager("count");i++){
			showStatus("Creating HeatMap...");
			roiManager("Select", i);
			List.setMeasurements();
			xc = List.getValue("X");
			yc = List.getValue("Y");
			for(j=xc-x;j<xc+x;j++){
				for(k=yc-x;k<yc+x;k++){
					setPixel(j, k, getPixel(j,k)+1);   
				}
			}
			
		}
		setBatchMode("show");
	}
	run("Select None");
	run("Fire");
	
	//convert to 8-bit taking into account the max of the image
	getStatistics(a, b, c, max);
	if(max < 255)
		setMinAndMax(0, 255);
	else if(max < 1023)
		setMinAndMax(0, 1023);
	else
		setMinAndMax(0, 4025);
	
	run("8-bit");
	resetMinAndMax();

	/*Draws the maizes and other regions of the maizes*/
	if(choice[1]){
		setForegroundColor(255,255,255);
		if(option == 1 || option == 4){ //Empty box
			array = getFileData(3, dir, imTitle, option);
			drawRect(array[0], array[1], array[2], array[3]);
		}
		else if(option == 3){	//Swimming
			array = getFileData(3, dir, imTitle, option);
			drawOval(array[0], array[1], array[2], array[3]);
		}
		else{
			if(option == 5)
				n = 6;
			else if(option == 6)
				n = 3;
			else
				n = 5;
			arrayx = getFileData(n, dir, imTitle, option);
			arrayy = getFileData(n+1, dir, imTitle, option);
			
			moveTo(arrayx[0], arrayy[0]);
	     	for (i=1; i<arrayx.length; i++)
	         	lineTo(arrayx[i], arrayy[i]);
	
	        lineTo(arrayx[0], arrayy[0]);
		}
	}

	if(choice[2]){
		setForegroundColor(255,255,255);
		if(option == 1){	//Empty box
			array = getFileData(4, dir, imTitle, option);
			drawRect(array[0], array[1], array[2], array[3]);
		}	
		
		else if(option == 3){	//Swimming pool
			array = getFileData(5, dir, imTitle, option);
			drawOval(array[0], array[1], array[2], array[3]);
		}
		//Regions option
		else if(option == 4){
			count = countLinesStartingWith(dir, imTitle, option, "Object");
			for(k = 6, j = 1; k < (6+count); k++, j++){
				array = getFileData(k, dir, imTitle, option);
				drawOval(array[0], array[1], array[2], array[3]);
				drawString(toString(j), (array[0]+array[2]/2)-3, array[1]+array[3]/2);
			}
		}

	}
	
	if(choice[3]){
		setForegroundColor(255,255,255);
		//Swimming option
		if(option == 3){
			setLineWidth(2);
			array = getFileData(4, dir, imTitle, option);
			drawLine(array[0]- 5, array[1], array[0] + 5, array[1]);
			drawLine(array[0], array[1] - 5, array[0], array[1] + 5);
			drawString("1", array[0] - 8, array[1]);
			drawString("2", array[0] - 8, array[1] + 15);
			drawString("3", array[0] + 2, array[1]);
			drawString("4", array[0] + 2, array[1] + 15);
			poolWDL = poolWD;
			toUnscaled(poolWDL);
			setLineWidth(1);
			array = getFileData(3, dir, imTitle, option);
			xc = array[0] + array[2]/2;
			yc = array[1] + array[3]/2;
			r = (array[2] + array[3])/4;
			makeOval(array[0] + poolWDL, array[1] + poolWDL, array[2] - (poolWDL*2), array[3] - (poolWDL*2));
			run("Area to Line");
			getSelectionCoordinates(xp, yp);
			for(i = 0; i < xp.length; i = i + 5){
				makePoint(xp[i], yp[i]);
				run("Draw", "slice");
			}
			run("Select None");	
		}
	}		
}




/*Dialog that provides options of drawing regions in the heatmap and 
line track map*/
function promptandgetChoice(c1, c2, c3, c4, c5, c6){
	temp = newArray(4);
	Array.fill(temp, 0);
	
	Dialog.create("Options for line/heatmap");
	if(c1){
		strings = newArray("Selection", "1-point", "4-points", "8-points");
		Dialog.addChoice("HeatMap marker", strings);
	}

	//case of boxes
	if(c2){
		Dialog.addCheckbox("Draw box region?", true);
		Dialog.addCheckbox("Draw center region?", true);
	}

	//Case of swimming pools
	if(c3){
		Dialog.addCheckbox("Draw pool region?", true);
		Dialog.addCheckbox("Draw platform region?", true);
		Dialog.addCheckbox("Number quadrants and draw border?", true);
	}

	//Case of cross puzzles
	if(c4)
		Dialog.addCheckbox("Draw cross region?", true);

	//case of regions
	if(c5){
		Dialog.addCheckbox("Draw box region?", true);
		Dialog.addCheckbox("Draw regions?", true);
	}
	
	if(c6)
		Dialog.addCheckbox("Draw cube region", true);

	Dialog.show();

	
	if(c1){
		tempStr = Dialog.getChoice();
		if(tempStr == "1-point")
			temp[0] = 1;
		else if(tempStr == "4-points")
			temp[0] = 4;
		else if(tempStr == "8-points")
			temp[0] = 8;
		else 
			temp[0] = 0;
	}
	
	temp[1] = Dialog.getCheckbox();

	if(c2 || c3 || c5)
		temp[2] = Dialog.getCheckbox();
	
	if(c3)
		temp[3] = Dialog.getCheckbox();

	
	return temp; 
}

/*Function to retrieve data from a specific line from a file in dir with the name imTitle*/
function getFileData(line, dir, imTitle, option){

	strTer = newArray(".cube.trac", ".cross.trac", ".swim.trac", ".objects.trac", ".TY.trac", ".free.trac");
	str = dir + imTitle + strTer[option-1];
		
	filestring = File.openAsString(str);
	rows = split(filestring, "\n");
	columns = split(rows[line], "\t");
	temp = newArray(columns.length-1);
	for(i = 1; i < columns.length; i++){
		temp[i-1] = parseFloat(columns[i]);
	}
	
	return temp;
	
}


/*simple function to calculate the distance between two points
by the Pitagoras formula*/
function calculateDistance(x1, y1, x2, y2){
	temp = sqrt(pow((x2-x1), 2) + pow((y2-y1),2));
	return temp;
}


/*Function to clear a region from the Water Maize*/
function clearRegion(){
	Dialog.create("Region clear");
	Dialog.addMessage("Do you want to clear a region?");
	Dialog.addCheckbox("Yes", true);
	Dialog.show();
	if(Dialog.getCheckbox()){
		waitForUser("Please select a region that you want to remove");
		roiManager("Add");
		run("Make Band...", "band=30");
		getStatistics(area, mean);
		setBackgroundColor(floor(mean),floor(mean),floor(mean));
		roiManager("Select", 0);
		run("Clear", "stack");
		roiManager("Reset");
	}
	
}

/*Function to count the lines of a txt file separated by "\n" */
function countLinesStartingWith(dir, imTitle, option, strBegin){
	strTer = newArray(".cube.trac", ".cross.trac", ".swim.trac", ".objects.trac", ".TY.trac", ".free.trac");
	str = dir + imTitle + strTer[option-1];
	filestring = File.openAsString(str);
	rows = split(filestring, "\n");
	count = 0;
	for(i=0; i< rows.length; i++){
		if(startsWith(rows[i], strBegin))
			count++;
	}
	
	return count;
	
}


/*First dialog to ask for first and last frame to create an average projection
to create the difference stack*/
function removeDarkR(imTitle){
	temp = newArray(2);
	run("Select None");
	setBatchMode("show");
	showMessage("Remove Dark regions","<html>"+"<font size=2><center>Please select the starting and end point<br>"+"<font size=2><center>of the stack to create a shading correction.<br>" + "<font size=2><center>Ideally you want frames where the mouse isn´t present yet (minimum 50 frames)<br>" + "<font size=2><center>If you have to use frames with mice in use as many as possible (>1000)<br><br>");
	waitForUser("Please select the inital frame to start the averaging");
	temp[0] = getSliceNumber();
	waitForUser("Please select the final frame to start the averaging");
	temp[1] = getSliceNumber();
	darkRPorjection(imTitle, temp[0], temp[1]);

	
	return temp;
}

/*Actual function to create the average projection and difference stack*/
function darkRPorjection(imTitle, min, max) {
	setBatchMode("hide");
	run("Z Project...", "start="+min+" stop="+max+" projection=[Average Intensity]");
	projTile = getTitle();
	imageCalculator("Difference create stack", imTitle, projTile);
	close("\\Others");
	run("Invert", "stack");
	run("Gamma...", "value=5 stack");
	setBatchMode("show");
}



/*function to calculate the angle between two points (using atan2)*/
function calculateAngle2(x1,y1, x2,y2){
	xdi = x2 - x1;
	ydi = y2 - y1;

	//uses atan2 to get negative values for different quadrants
	return (-atan2(ydi, xdi) * (180/PI));
}

//sort a string separated by commas to get total of number and 
//total of triplets changes
function getTripletStat(ordem){
	numbers = split(ordem, ",");
	count = 0;
	temp = newArray(2);
	for(i=0;i<numbers.length - 2; i++){
		if(numbers[i] != numbers[i+1] && numbers[i] != numbers[i+2] && numbers[i+1] != numbers[i+2])
			count++;	
	}
	
	temp[0] = count;
	temp[1] = numbers.length - 2;
	
	return temp;
	
}



/////////////////////////////////////////////////////
////////////////////////////////////////////////////////
/////////////////////////////////////////////////////
/*Everything related with redoing analysis 
is from here downwards!!*/

/*Function to open previous analysis file. It checks that the file is valid
and launches the correct function, or complains that it isn't valid*/
function openPreviousAnalysis(){

	strTer = newArray(".cube.trac", ".cross.trac", ".swim.trac", ".objects.trac", ".TY.trac");
	file = File.openDialog("Please select the output file of the previous analysis.");
	roiManager("Reset");
	
	filename = File.name;
	dir = File.directory;
	sep = File.separator;
	
	//Open file as a string
	filestring = File.openAsString(dir + sep + filename);
	temp = getFileDataRedo(filestring);
	
	if(endsWith(filename,".trac")){
		if(endsWith(filename, ".cube.trac")){
			option = repeatAnalysisDialog();
			cubeRedo(temp, option);
		}else if(endsWith(filename, ".cross.trac")){
			option = repeatAnalysisDialog();
			crossRedo(temp, option);
		}else if(endsWith(filename, ".objects.trac")){
			option = repeatAnalysisDialog();
			objectsRedo(temp, option);
		}else if(endsWith(filename, ".swim.trac")){
			option = repeatAnalysisDialog();
			swimRedo(temp, option);
		}else if(endsWith(filename, ".TY.trac")){
			option = repeatAnalysisDialog();
			tyRedo(temp, option);
		}else if(endsWith(filename, ".free.trac")){
			option = repeatAnalysisDialog();
			fearRedo(temp, option);
		}else
			exit("Could not identify the type of analysis of this trac file");
	}else
		print("This file " + file + " does not appear to be a valid JAMoT file.");

}

/*Fucntion to redo a previous analysis of the FC*/
function fearRedo(temp, option){
	//Get the data from the file		
	dir = temp[0];
	iw = parseInt(temp[1]); ih = parseInt(temp[2]); inS = parseInt(temp[3]); 
	gaus = parseInt(temp[4]);
	imName = temp[5];
	fps = parseInt(temp[7]);
	count = 9;
	while(temp[count]!= "BoxBottomY")
		count++;
	xp = newArray(count-9);
	yp = newArray(count-9);
	for(i = 0; i < count-9; i++){
		xp[i] = temp[9+i];
		yp[i] = temp[count+1+i];
	}
	jump = 9 + ((count-9)*2) + 1;
	thrMin = parseInt(temp[jump+1]); thrMax = parseInt(temp[jump+2]);
	drkMin = parseInt(temp[jump+4]); drkMax = parseInt(temp[jump+5]);
	temp2 = Array.slice(temp, jump+6, 100);
	checkPreferences(temp2);
	
	if(option == 0){
		//Open image
		ignore = openFile(dir+imName, option);
		
		//Check for guassian blur
		gausCheckRun(gaus);
		
		//set bckgrd color
		setBackgrdCo(thrMin);
			
		if(drkMin != drkMax)
			darkRPorjection(imName, drkMin,drkMax);

		//setThreshold and Analyse
		setThrandAna(thrMin, thrMax, fps,6);
		
		//gets image ID
		oriID=getImageID();
		freezeCheck(fps, dir, imName);
		dialog2(oriID, dir, imName, 6);
		
	}else{
		//Open image file or create an empty one
		if(!openFile(dir+imName, 1))
			newImage("New "+imName, "8-bit black", iw, ih, inS);
		
		
		//Open ROis or see if they exist!
		if(File.exists(dir + imName + "ROIs.zip"))
			roiManager("Open", dir + imName + "ROIs.zip");
		else
			exit("Roi´s file appears to not exist!");
		if(option == 1){
			//Get data of the dectetions
			freezeCheck(fps, dir, imName);
		}
		if(option == 2){
			oriID = getImageID();
			dialog2(oriID, dir, imName, 6);
		}	
		
			
			
	}
	
}

/*Fucntion to redo a previous analysis of the TY*/
function tyRedo(temp, option){
	//Get the data from the file		
	triX = newArray(4);
	triY = newArray(3);
	dir = temp[0];
	iw = parseInt(temp[1]); ih = parseInt(temp[2]); inS = parseInt(temp[3]); 
	gaus = parseInt(temp[4]);
	imName = temp[5];
	fps = parseInt(temp[7]);
	triX[0] = parseInt(temp[9]); triX[1] = parseInt(temp[10]); triX[2] = parseInt(temp[11]);
	triY[0] = parseInt(temp[13]); triY[1] = parseInt(temp[14]); triY[2] = parseInt(temp[15]);
	pw = parseFloat(temp[17]); py = parseFloat(temp[18]);
	count = 20;
	while(temp[count]!= "TYregionY")
		count++;
	xp = newArray(count-20);
	yp = newArray(count-20);
	for(i = 0; i < count-20; i++){
		xp[i] = temp[20+i];
		yp[i] = temp[count+1+i];
	}
	jump = 20 + ((count-20)*2) + 1;
	thrMin = parseInt(temp[jump+1]); thrMax = parseInt(temp[jump+2]);
	drkMin = parseInt(temp[jump+4]); drkMax = parseInt(temp[jump+5]);
	temp2 = Array.slice(temp, jump+6, 100);
	checkPreferences(temp2);
	
	if(option == 0){
		//Open image
		ignore = openFile(dir+imName, option);
		
		//Check for guassian blur
		gausCheckRun(gaus);
				
		//set image parameters - pixel
		run("Properties...", "channels=1 slices="+nSlices+" frames=1 unit=cm pixel_width="+pw+" pixel_height="+py+" voxel_depth=1");	
		
		//set bckgrd color
		setBackgrdCo(thrMin);
		//Make the bottom of the box and clear outside
		makeSelection("polygon", xp, yp);
		run("Clear Outside", "stack");
		//Reduce intensity of the cage wall
			
		if(drkMin != drkMax)
			darkRPorjection(imName, drkMin,drkMax);

		//setThreshold and Analyse
		setThrandAna(thrMin, thrMax, fps,5);
		
		//gets image ID
		oriID=getImageID();
		getParametersTY(fps, dir, imName);
		dialog2(oriID, dir, imName, 5);
		
	}else{
		//Open image file or create an empty one
		if(!openFile(dir+imName, 1))
			newImage("New "+imName, "8-bit black", iw, ih, inS);
		
		//set image parameters - pixel
		run("Properties...", "channels=1 slices="+nSlices+" frames=1 unit=cm pixel_width="+pw+" pixel_height="+py+" voxel_depth=1");	
		
		//Open ROis or see if they exist!
		if(File.exists(dir + imName + "ROIs.zip"))
			roiManager("Open", dir + imName + "ROIs.zip");
		else
			exit("Roi´s file appears to not exist!");
		if(option == 1){
			//Get data of the dectetions
			getParametersTY(fps, dir, imName);
		}
		if(option == 2){
			oriID = getImageID();
			dialog2(oriID, dir, imName, 5);
		}	
		
			
			
	}
	
}
	
/*Function to redo a previous analysis of the NO*/
function objectsRedo(temp, option){
	//Get the data from the file		
	box = newArray(4);
	dir = temp[0];
	iw = parseInt(temp[1]); ih = parseInt(temp[2]); inS = parseInt(temp[3]); 
	gaus = parseInt(temp[4]);
	imName = temp[5];
	fps = parseInt(temp[7]);
	box[0] = parseInt(temp[9]); box[1] = parseInt(temp[10]); box[2] = parseInt(temp[11]); box[3] = parseInt(temp[12]);
	pw = parseFloat(temp[19]); py = parseFloat(temp[20]);
	count = 0;
	nRegions = 0;
	while(temp[21 + count] != "Threshold"){
		if(startsWith(temp[21 + count], "Object"))
			nRegions++;
		
		count++;
	}
		
	thrMin = parseInt(temp[21 + count + 1]); thrMax = parseInt(temp[21 + count + 2]);
	drkMin = parseInt(temp[21 + count + 4]); drkMax = parseInt(temp[21 + count + 5]);
	temp2 = Array.slice(temp, 21+count+6, 100);
	checkPreferences(temp2);
	
	if(option == 0){
		//Open image
		ignore = openFile(dir+imName, option);
		
		//Check for guassian blur
		gausCheckRun(gaus);
				
		//set image parameters - pixel
		run("Properties...", "channels=1 slices="+nSlices+" frames=1 unit=cm pixel_width="+pw+" pixel_height="+py+" voxel_depth=1");	
		
		//set bckgrd color
		setBackgrdCo(thrMin);
		//Make the bottom of the box and clear outside
		makeRectangle(box[0], box[1], box[2], box[3]);
		run("Enlarge...", "enlarge=15 pixel");
		run("Clear Outside", "stack");
		//Reduce intensity of the cage wall
		run("Enlarge...", "enlarge=-15 pixel");
		if(pw == 1 && py == 1)
			run("Make Band...", "band=25");
		else
			run("Make Band...", "band=" + 25*pw);
			
		run("Gaussian Blur...", "sigma=10 stack");
		
		if(drkMin != drkMax)
			darkRPorjection(imName, drkMin,drkMax);

		//setThreshold and Analyse
		setThrandAna(thrMin, thrMax, fps, 4);
		
		//Get data of the dectetions
		oriID=getImageID();
		getParametersRT(fps, dir, imName, nRegions);
		dialog2(oriID, dir, imName, 4);
		
	}else{
		//Open image file or create an empty one
		if(!openFile(dir+imName, 1))
			newImage("New "+imName, "8-bit black", iw, ih, inS);
		
		//set image parameters - pixel
		run("Properties...", "channels=1 slices="+nSlices+" frames=1 unit=cm pixel_width="+pw+" pixel_height="+py+" voxel_depth=1");	
		
		//Open ROis or see if they exist!
		if(File.exists(dir + imName + "ROIs.zip"))
			roiManager("Open", dir + imName + "ROIs.zip");
		else
			exit("Roi´s file appears to not exist!");
		if(option == 1){
			//Get data of the dectetions
			getParametersRT(fps, dir, imName, nRegions);
		}
		if(option == 2){
			oriID = getImageID();
			dialog2(oriID, dir, imName, 4);
		}	
		
			
			
	}
	
}

/*Function to redo a previous analysis of the WM*/
function swimRedo(temp, option){
	//Get the data from the file		
	box = newArray(4);
	dir = temp[0];
	iw = parseInt(temp[1]); ih = parseInt(temp[2]); inS = parseInt(temp[3]); 
	gaus = parseInt(temp[4]);
	imName = temp[5];
	fps = parseInt(temp[7]);
	box[0] = parseInt(temp[9]); box[1] = parseInt(temp[10]); box[2] = parseInt(temp[11]); box[3] = parseInt(temp[12]);
	pw = parseFloat(temp[22]); py = parseFloat(temp[23]);
	thrMin = parseInt(temp[25]); thrMax = parseInt(temp[26]);
	diameter = parseInt(temp[28]);
	temp2 = Array.slice(temp, 29, 100);
	checkPreferences(temp2);
	
	if(option == 0){
		//open image
		ignore = openFile(dir+imName, option);
		
		//Check for guassian blur
		gausCheckRun(gaus);
		
		//set image parameters - pixel
		run("Properties...", "channels=1 slices="+nSlices+" frames=1 unit=cm pixel_width="+pw+" pixel_height="+py+" voxel_depth=1");	
		
		//set bckgrd color
		setBackgrdCo(thrMin);
		
		makeOval(box[0],box[1],box[2],box[3]);
		run("Clear Outside", "stack");
		
		//setThreshold and Analyse
		setThrandAna(thrMin, thrMax, fps, 3);
		
		//Get data of the dectetions
		oriID = getImageID;
		getParametersSM(fps,dir, imName, diameter);
		dialog2(oriID, dir, imName, 3);
		
	}else{
		//Open image file or create an empty one
		if(!openFile(dir+imName, 1))
			newImage("New "+imName, "8-bit black", iw, ih, inS);
		
		//set image parameters - pixel
		run("Properties...", "channels=1 slices="+nSlices+" frames=1 unit=cm pixel_width="+pw+" pixel_height="+py+" voxel_depth=1");	
		
		//Open ROis or see if they exist!
		if(File.exists(dir + imName + "ROIs.zip"))
			roiManager("Open", dir + imName + "ROIs.zip");
		else
			exit("Roi´s file appears to not exist!");
		if(option == 1){
			//Get data of the dectetions
			getParametersSM(fps,dir, imName);
		}
		if(option == 2){
			oriID = getImageID();
			dialog2(oriID, dir, imName, 3);
		}	
	}
}


/*Function to redo a previous analysis of the EM*/
function crossRedo(temp, option){
	
	//Get the data from the file		
	box = newArray(4);
	dir = temp[0];
	iw = parseInt(temp[1]); ih = parseInt(temp[2]); inS = parseInt(temp[3]); 
	gaus = parseInt(temp[4]);
	imName = temp[5];
	fps = parseInt(temp[7]);
	box[0] = parseInt(temp[9]); box[1] = parseInt(temp[10]); box[2] = parseInt(temp[11]); box[3] = parseInt(temp[12]);
	pw = parseFloat(temp[14]); py = parseFloat(temp[15]); armsL = parseFloat(temp[16]);
	count = 18;
	while(temp[count]!= "CrossRegionY")
		count++;
	xp = newArray(count-18);
	yp = newArray(count-18);
	for(i = 0; i < count-18; i++){
		xp[i] = temp[18+i];
		yp[i] = temp[count+1+i];
	}
	jump = 18 + ((count-18)*2) + 1;
	thrMin = parseInt(temp[jump+1]); thrMax = parseInt(temp[jump+2]);
	drkMin = parseInt(temp[jump+4]); drkMax = parseInt(temp[jump+5]);
	
	temp2 = Array.slice(temp, jump+6, 100);
	checkPreferences(temp2);
	
	if(option == 0){
		//open image
		ignore = openFile(dir+imName, option);
		
		//Check for guassian blur
		gausCheckRun(gaus);
		
		//set image parameters - pixel
		run("Properties...", "channels=1 slices="+nSlices+" frames=1 unit=cm pixel_width="+pw+" pixel_height="+py+" voxel_depth=1");	
		
		//set bckgrd color
		setBackgrdCo(thrMin);
		
		makeSelection("polygon", xp, yp);
		run("Clear Outside", "stack");
		
		if(drkMin != drkMax)
			darkRPorjection(imName, drkMin,drkMax);
		
		//setThreshold and Analyse
		setThrandAna(thrMin, thrMax, fps, 2);
		
		//Get data of the dectetions
		oriID = getImageID;
		toUnscaled(armsL);
		getParametersET(fps, dir, imName, armsL);
		dialog2(oriID, dir, imName, 2);
	}else{
		//Open image file or create an empty one
		if(!openFile(dir+imName, 1))
			newImage("New "+imName, "8-bit black", iw, ih, inS);
		
		//set image parameters - pixel
		run("Properties...", "channels=1 slices="+nSlices+" frames=1 unit=cm pixel_width="+pw+" pixel_height="+py+" voxel_depth=1");	
		
		//Open ROis or see if they exist!
		if(File.exists(dir + imName + "ROIs.zip"))
			roiManager("Open", dir + imName + "ROIs.zip");
		else
			exit("Roi´s file appears to not exist!");
		if(option == 1){
			//Get data of the dectetions
			toUnscaled(armsL);
			getParametersET(fps, dir, imName, armsL );
		}
		if(option == 2){
			oriID = getImageID();
			dialog2(oriID, dir, imName, 2); 
		}	
	}
}


/*Function to redo a previous analysis of the OF*/
function cubeRedo(temp, option){
	
	//Get the data from the file
	box = newArray(4);
	dir = temp[0];
	iw = parseInt(temp[1]); ih = parseInt(temp[2]); inS = parseInt(temp[3]);
	gaus = parseInt(temp[4]);
	imName = temp[5];
	fps = parseInt(temp[7]);
	box[0] = parseInt(temp[9]); box[1] = parseInt(temp[10]); box[2] = parseInt(temp[11]); box[3] = parseInt(temp[12]);
	pw = parseFloat(temp[19]); py = parseFloat(temp[20]);
	thrMin = parseInt(temp[22]); thrMax = parseInt(temp[23]);
	drkMin = parseInt(temp[25]); drkMax = parseInt(temp[26]);
	temp2 = Array.slice(temp,27,100);
	checkPreferences(temp2);
	
	if(option == 0){
		//Open image
		ignore = openFile(dir+imName, option);
		
		//Check for guassian blur
		gausCheckRun(gaus);
				
		//set image parameters - pixel
		run("Properties...", "channels=1 slices="+nSlices+" frames=1 unit="+units+" pixel_width="+pw+" pixel_height="+py+" voxel_depth=1");	
		
		//set bckgrd color
		setBackgrdCo(thrMin);
		//Make the bottom of the box and clear outside
		makeRectangle(box[0], box[1], box[2], box[3]);
		run("Enlarge...", "enlarge=15 pixel");
		run("Clear Outside", "stack");
		//Reduce intensity of the cage wall
		run("Enlarge...", "enlarge=-15 pixel");
		if(pw == 1 && py == 1)
			run("Make Band...", "band=25");
		else
			run("Make Band...", "band=" + 25*pw);
			
		run("Gaussian Blur...", "sigma=10 stack");
		
		if(drkMin!= drkMax)
			darkRPorjection(imName, drkMin,drkMax);

		//setThreshold and Analyse
		setThrandAna(thrMin, thrMax, fps, 1);
		
		//Get data of the dectetions
		getParameters(fps, dir, imName);
		oriID = getImageID();
		dialog2(oriID, dir, imName, 1);
		
	}else{
		//Open image file or create an empty one
		if(!openFile(dir+imName, 1))
			newImage("New "+imName, "8-bit black", iw, ih, inS);
		
		//set image parameters - pixel
		run("Properties...", "channels=1 slices="+nSlices+" frames=1 unit="+units+" pixel_width="+pw+" pixel_height="+py+" voxel_depth=1");	
		
		//Open ROis or see if they exist!
		if(File.exists(dir + imName + "ROIs.zip"))
			roiManager("Open", dir + imName + "ROIs.zip");
		else
			exit("Roi´s file appears to not exist!");
		if(option == 1){
			//Get data of the dectetions
			getParameters(fps, dir, imName);
		}
		if(option == 2){
			oriID = getImageID();
			dialog2(oriID, dir, imName, 1);
		}	
		
			
			
	}
}


/*Function to set the threshold and analysis the 
image stack in redo analysis*/
function setThrandAna(thrMin, thrMax, fps, option){

		setThreshold(thrMin,thrMax);
	
		roiManager("Show All without labels");
		roiManager("Show None");
		if(option == 1 || option == 4)
			n = mCubeArea;
		else if(option == 2)
			n = mElevatedArea;
		else if(option == 3)
			n = mSwimmingArea;
		else if(option == 5)
			n = mTYArea;
		else if(option == 6)
			n = mFreezeArea;
		setBatchMode("hide");
		//analyse particles taking in consideration the reduction in fps if selected
		if(fps == 25)
			run("Analyze Particles...", "size="+n+"-Infinity pixel include add stack");
		else{
			
			for(i = 1; i < nSlices; i = i + 100/fps){
				setSlice(i);
				run("Analyze Particles...", "size="+n+"-Infinity pixel include add slice");
			}
		}
		setBatchMode("show");
}

/*Function to set the bckgrnd color depending on the threshold used 
in the analysis (used with redo previous analysis)*/
function setBackgrdCo(thr){
		if(thr < 50)
			setBackgroundColor(255, 255, 255);
		else
			setBackgroundColor(0, 0, 0);
			
}


/*Small function to run a guassian blur if so selected*/
function gausCheckRun(n){
	if(n > 0)
			run("Gaussian Blur...", "sigma="+n+" stack");
}

/*Function to open an image file if it exists and complain if it doesn't*/
function openFile(str, option){
	if(File.exists(str))
		open(str);
	else
		if(option == 0)
			exit("Image file "+str+" does not exist...");
		else 
			return 0;
	
	return 1;		
}
	
/*Small dialog function to ask what do you want 
to do when loading a previous analysis file*/
function repeatAnalysisDialog(){

	array1 = newArray("Repeat full analysis", "Repeat selection analysis only", "Redraw HeatMap and Line Track", "Just Load image and ROIs");
	Dialog.create("Load previous analysis.");
	Dialog.addMessage("What do you want to do?");
	Dialog.addRadioButtonGroup("Please choose one", array1, 4, 1, "Repeat full analysis");
	Dialog.show();
	string = Dialog.getRadioButton();
	count = 0;
	while(string != array1[count])
		count++;
	
	
	return count;
}

/*Special get data from file function
to put all data of a file into a array separting the file
by tab*/
function getFileDataRedo(filestring){

	rows = split(filestring, "\n");
	temp = newArray(100);
	Array.fill(temp, 0);
	count = 0;
	for(i = 0; i < rows.length; i++){
		columns = split(rows[i], "\t");
		for(j = 0; j < columns.length;j++){
			temp[count] = columns[j];
			count++;
		}

	}
			

	return temp;
	
}


/*Function to write all the preferences at that time to the analysis file*/
function writePreferences(file){
	//General
	print(file, "Preferences");
	print(file, "Units of work\t" + units);
	print(file, "Guassian blur to apply\t"+ gauVal);
	print(file, "Minimum Displacement value (units)\t"+ dispVal);
	//Cube and Objects Maizes
	print(file, "Rearing - Solidity (Cube/Region only)\t"+ solidity);
	print(file, "Default width of box\t"+ wCube);
	print(file, "Mouse minimal area (pixels)\t"+ mCubeArea);
	//Elevated Maize
	print(file, "Width of arms\t"+ wElevated);
	print(file, "Length of arms\t"+ lElevated);
	print(file, "Mouse minimal area (pixels)\t"+ mElevatedArea);
	print(file, "Selection smoothing value (pixels)\t"+ sElevated);
	//Swimming Maize
	print(file, "Pool diameter\t"+ dSwimming);
	print(file, "Mouse minimal area (pixels)\t"+ mSwimmingArea);
	print(file, "Distance to pool Wall to consider at wall (units)\t"+ poolWD);
	//T/Y Maize
	print(file, "Arms width\t"+ wTY);
	print(file, "Mouse minimal area (pixels)\t"+ mTYArea);
	print(file, "Selection smoothing value (pixels)\t"+ sTY);
	//Fear Conditioning
	print(file, "Mouse minimal area (pixels)\t"+ mFreezeArea);
	print(file, "Selection smoothing value (pixels)\t"+ sFreeze);
	
}

/*Function to check all the Preferences that were saved in the analysis file
and compared them to the preferences in current use*/
function checkPreferences(array){
	print("Checking current vs. selected run preferences...");
	//General
	i = 1;
	print(array[i] + ": current is "+ units + ". Saved is: " + array[i+1]);
	if(units!=array[i+1]){print("DIFFERENT!!Consider changing settings for reanalysis.");}
	i = i + 2;
	print(array[i] + ": current is "+ gauVal + ". Saved is: " + array[i+1]);
	if(gauVal!=array[i+1]){print("DIFFERENT!!Consider changing settings for reanalysis.");}
	i = i + 2;
	print(array[i] + ": current is "+ dispVal + ". Saved is: " + array[i+1]);
	if(dispVal!=array[i+1]){print("DIFFERENT!!Consider changing settings for reanalysis.");}
	//Open/NOR
	i = i + 2;
	print(array[i] + ": current is "+ solidity + ". Saved is: " + array[i+1]);
	if(solidity!=array[i+1]){print("DIFFERENT!!Consider changing settings for reanalysis of OpenField/NOR.");}
	i = i + 2;
	print(array[i] + ": current is "+ wCube + ". Saved is: " + array[i+1]);
	if(wCube!=array[i+1]){print("DIFFERENT!!Consider changing settings for reanalysis of OpenField/NOR.");}
	i = i + 2;
	print(array[i] + ": current is "+ mCubeArea + ". Saved is: " + array[i+1]);
	if(mCubeArea!=array[i+1]){print("DIFFERENT!!Consider changing settings for reanalysis of OpenField/NOR.");}
	//elevated
	i = i + 2;
	print(array[i] + ": current is "+ wElevated + ". Saved is: " + array[i+1]);
	if(wElevated!=array[i+1]){print("DIFFERENT!!Consider changing settings for reanalysis of Elevated Plus Maize.");}
	i = i + 2;
	print(array[i] + ": current is "+ lElevated + ". Saved is: " + array[i+1]);
	if(lElevated!=array[i+1]){print("DIFFERENT!!Consider changing settings for reanalysis of Elevated Plus Maize.");}
	i = i + 2;
	print(array[i] + ": current is "+ mElevatedArea + ". Saved is: " + array[i+1]);
	if(mElevatedArea!=array[i+1]){print("DIFFERENT!!Consider changing settings for reanalysis of Elevated Plus Maize.");}
	i = i + 2;
	print(array[i] + ": current is "+ sElevated + ". Saved is: " + array[i+1]);
	if(sElevated!=array[i+1]){print("DIFFERENT!!Consider changing settings for reanalysis of Elevated Plus Maize.");}
	//Watermaize
	i = i + 2;
	print(array[i] + ": current is "+ dSwimming + ". Saved is: " + array[i+1]);
	if(dSwimming!=array[i+1]){print("DIFFERENT!!Consider changing settings for reanalysis of WaterMaize.");}
	i = i + 2;
	print(array[i] + ": current is "+ mSwimmingArea + ". Saved is: " + array[i+1]);
	if(mSwimmingArea!=array[i+1]){print("DIFFERENT!!Consider changing settings for reanalysis of WaterMaize.");}
	i = i + 2;
	print(array[i] + ": current is "+ poolWD + ". Saved is: " + array[i+1]);
	if(poolWD!=array[i+1]){print("DIFFERENT!!Consider changing settings for reanalysis of WaterMaize.");}
	//TY Maize
	i = i + 2;
	print(array[i] + ": current is "+  wTY + ". Saved is: " + array[i+1]);
	if( wTY!=array[i+1]){print("DIFFERENT!!Consider changing settings for reanalysis of T/Y Maize.");}
	i = i + 2;
	print(array[i] + ": current is "+  mTYArea + ". Saved is: " + array[i+1]);
	if( mTYArea!=array[i+1]){print("DIFFERENT!!Consider changing settings for reanalysis of T/Y Maize.");}
	i = i + 2;
	print(array[i] + ": current is "+  sTY + ". Saved is: " + array[i+1]);
	if( sTY!=array[i+1]){print("DIFFERENT!!Consider changing settings for reanalysis of T/Y Maize.");}
	//Fear Conditioning
	i = i + 2;
	print(array[i] + ": current is "+  mFreezeArea + ". Saved is: " + array[i+1]);
	if( mFreezeArea!=array[i+1]){print("DIFFERENT!!Consider changing settings for reanalysis of Fear Conditioning.");}
	i = i + 2;
	print(array[i] + ": current is "+  sFreeze + ". Saved is: " + array[i+1]);
	if( sFreeze!=array[i+1]){print("DIFFERENT!!Consider changing settings for reanalysis of Fear Conditioning.");}
			
}

