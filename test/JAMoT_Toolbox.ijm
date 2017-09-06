/*
 * //////////////////Author - H lio Roque - Centro Nacional Investigaciones CardioVasculares, Madrid, Spain/////////////
 * /////////////////Contact - helio.alexandreduarte at cnic.es///////////////////////////////////////////////////////////////
 * 
 * 06/09/2017 - Added the hability of redoing previous analysis using a analysis from a previous analysis
 * 05/09/2017 - Made changes to the get in line with the upcoming function of redoing an analysis by loading a preivous trac file
 *				Also transformed it to a dropdown menu liek BioVoxxel Toolbox (REFERENCE)			
 * 06/06/2017 - Added a function to be run by the T/Y where it determines the number triplet entries into all different arms - NEED REFERENCE
 * 06/06/2017 - Changed removeDarkR to recieve input from the user to start and end of average projection. Added warning messages to the effect
 * 01/06/2017 - Added extra number entries and options to dialog1 whose appearance depends on the macro calling it. This allows
 * 				to size of the arenas to be inputted by the user so that these are not fixed values. Some bug elimination.
 * 				Also changed the way the macros deal with white mice in dark background. Now instead of inverting they just
 * 				clear the outisde region in the adequete color for the bkgrnd.
 * 30/05/2017 - Started to changed the sortVirtual() function to work better with all the macros and function to all cases
 * 				or put warnings when this is not the case. SO that in the future I can change all of it to work in any case.
 * 29/05/2017 - Added removeDarkR(); to try and work with the dark regions due to uneven illumination.
 * 				This is only in effect to the cube, cube with objects and the T/Y puzzles.
 * 26/05/2017 - Fixed an array comparison error in getParametersRT that was leading to huge counts of heads at the regions
 * 				Maybe this will mean no need to smooth this array
 * 26/05/2017 - v0.5 - Added the TY puzzle macro. this is mostly the cross region macro modified so it calculates the 
 * 				arms positions and times. Already implemented the smoothing alrothim counting algorithm 
 * 25/05/2017 - Changed the method of calculation of the ET puzzle to make a moving average (interval of 9) across the 
 * 				whole array of 0,1,2 values to eliminate entries of single frames. This needs to be applied to all 
 * 				macros.
 * 23/05/2017 - v0.4 - Added the macro to track the mouse in a cube where there are objects that it might recognize or not. 
 * 				It is mainly based in the cube track macro but there is a new function to sort out if the mouse has its
 * 				head or body close to the object. Works with up to 5 objects. Should work with more. Other fucntions were adapted
 * 				linTrack, heatmap, promptandgetchoice, getFileData, dialog1, to adjust to another option of display.
 * 				Also added a new common function, countLinesStartWith, to count the lines of a text file separated by "\n"
 * 22/05/2017 - Fixed the calculus of the pixel size to work properly in all macros! Also added the safe guard 
 * 				to not do this calculus if the image pixel is different from 1 in both X and Y. Mofified the 
 * 				dialog1 function to take an option as argument to provide different options for the different macros
 * 				and be ready to insert the Regions macro.
 * 19/05/2017 - Changed the getDirection function to not mixed px and units - all in px now. this does not affect the
 * 				displa and vel calculations.
 * 15-18/05/2017 - General changes to organization of the macros, mainly so that all share the small functions to reduce code.
 * 				Mostly changing the getFileData and lineTrack and heatMap to work with the different macros. 
 * 11/05/2017 - Made line and heatmap end up with 8-bit images, scaling the heatmap accordingly to the max value 
 * 				of the map and not regions (8-bit, 10-bit or 12-bit) * 				
 * 11/05/2017 - IMPORTANT - Changed the getDirections method to work in metric units and not mix pixels and metric units!
 * 				This was screwing up some calculatinos I believe! Also made getDirections of EP to get coordinates from file.
 * 11/05/2017 - Fix the conversion of string to float instead of int in getFileData
 * 10/05/2017 - Added a warning message to PVAT about spaces and ffmpeg.exe
 * 				Also converted PVAT to a batch processing tool
 * 09/05/2017 - Added the possibility of using ffmpeg direclty from the converter macro - only tested in Windows.
 * 				Assumes ffmpeg.exe is in the macro\toolset folder
 * 				Also deals with virtual stacks taking into consideration the memory used by ImageJ
 * 08/05/2017 - Mouse looking over the edge in EPM by area comparicion between open and close regions
 */
 
 requires("1.50a");
 
 var filemenu = newMenu("Mouse trial Macros Menu Tool", newArray("Process Video", "Cube Tracker","Elevated Puzzle Tracker", "Swimming Pool Tracker", "Regions Tracker", "Y/T Tracker","Open Previous Analysis File", "-"));
 
 
 macro "Mouse trial Macros Menu Tool - C005D21D23D32D3eD3fD41D43D4dD4eD5cD5dD6cD6dD71D73D7dD7eD82D8eD8fD91D93CfffD00D01D02D03D04D05D06D07D08D09D0aD0bD0cD0dD0eD0fD10D11D12D13D1cD1dD1eD1fD20D22D2cD2dD2eD2fD30D31D33D3cD3dD40D42D4cD4fD50D51D52D53D5eD5fD60D61D62D63D6eD6fD70D72D7cD7fD80D81D83D8cD8dD90D92D9cD9dD9eD9fDa0Da1Da2Da3DacDadDaeDafDb0Db1Db2Db3DbcDbdDbeDbfDc0Dc1Dc2Dc3Dc4Dc5DcaDcbDccDcdDceDcfDd0Dd1Dd2Dd3Dd4DdbDdcDddDdeDdfDe0De1De2De3DecDedDeeDefDf0Df1Df2Df3DfcDfdDfeDffC00fD14D15D16D17D18D19D1aD1bD24D25D26D27D28D29D2aD2bD34D35D36D37D38D39D3aD3bD44D45D46D47D48D49D4aD4bD54D55D56D57D58D59D5aD5bD64D65D66D67D68D69D6aD6bD74D75D76D77D78D79D7aD7bD84D85D86D87D88D89D8aD8bD94D95D96D97D98D99D9aD9bDa4Da5Da6Da7Da8Da9DaaDabDb4Db5Db6Db7Db8Db9DbaDbbDc6Dc7Dc8Dc9Dd5Dd6Dd7Dd8Dd9DdaDe4De5De6De7De8De9DeaDebDf4Df5Df6Df7Df8Df9DfaDfb"{
 	choice = getArgument();
 	if(choice != "-"){
 		if(choice == "Process Video") {ProcessVideo(); }
 		else if(choice == "Cube Tracker") {MouseCubeTracker(); }
 		else if(choice == "Elevated Puzzle Tracker") {MiceElevatedPuzzleTracker(); }
 		else if(choice == "Swimming Pool Tracker") {MouseSwimTracker(); }
 		else if(choice == "Regions Tracker") {MouseRegionsTracker(); }
 		else if(choice == "Y/T Tracker") {MiceYTTracker(); }
 		else if(choice == "Open Previous Analysis File") {exit("Not yet..."); }
 	}
 		
 }
 
 
 
 
//This macro processess an decompressed or mjpeg avi 
//open as a virtual stack and saves it as a sequence of images 
//that it after opens as a virtual stack
function ProcessVideo(){
	
	Dialog.create("Avi converter");
	Dialog.addMessage("Convert the movie to an avi file ImageJ can open.\n It assumes ffmpeg.exe is in the ImageJ Macro\\toolsets folder.");
	Dialog.addCheckbox("Do you want/need to convert this file?", true);
	Dialog.show();

	if(Dialog.getCheckbox()){
		showMessage("AVI processing tool","<html>"+"<font size=2><center>This step requires <br>"+"<font size=+2><center>ffmpeg.exe<br>"+"<font size=2><center>in the directory of ImageJ/macros/toolset!<br>" + "<font size=2><center>If you do not have ffmpeg installed please download it at<br>" + "<font size=2><font color=blue>https://ffmpeg.org/download.html<br><br>"+"<font size=2><font color=black> Also note that this macro does not support <b>SPACES</b> in the files/directories names!<br>");
		
		pathFFmpeg = getDirectory("macros") + File.separator + "toolsets" + File.separator + "ffmpeg.exe";
		
		path = File.openDialog("Select the AVI file to convert.");
		if(File.exists(path + ".converted.avi")){
			string = "File exists. Do you want to overwrite it? Cancel will stop the macro.";
			showMessageWithCancel(string);
			File.delete(path + ".converted.avi");		
		}
		
		string = pathFFmpeg + " -loglevel quiet -i "+ path +" -f avi -vcodec mjpeg "+ path + ".converted.avi && echo off";
		
		os = getInfo("os.name");
		
		if(startsWith(os, "Windows")){
			exec("cmd /c "+ string);
			
		}
		else
			exec("sh -c " + string);
		
		if(parseInt(IJ.maxMemory()) >= 4194304000)					//Memory in bytes!!
			run("AVI...", "open=" + path + ".converted.avi convert");
		else
			run("AVI...", "open=" + path + ".converted.avi convert use");
	}
	
	if (nSlices==1) exit("Stack required");
	
	id = getImageID;
	name = getTitle();
	if(is("Virtual Stack")){
		waitForUser("Please have a look at the stack to check for 1st and last slice and then press OK");
		dir = getDirectory("Choose Destination Directory for images.");
		Dialog.create("Slice numbers");
		Dialog.addNumber("First Slice", 1);
		Dialog.addNumber("Last Slice", nSlices)
		Dialog.show();
		first = Dialog.getNumber();
		last = Dialog.getNumber();
		setBatchMode(true);
		for (i=first; i<= last; i++) {
		  showProgress(i, last);
		  selectImage(id);
		  setSlice(i);
		  run("Duplicate...", "title=temp");
		  if(!is("grayscale"))
		  	run("8-bit");
		  	
		  run("Gaussian Blur...", "sigma=2 stack");
		  saveAs("tif", dir+name+pad(i-1));
		  close();
		}
		setBatchMode(false);
			
		close();
		run("Image Sequence...", "open=["+dir+name+pad(first)+".tif] sort use");
		
	}else{
		if(!is("grayscale"))
			run("8-bit");
		  	
		run("Gaussian Blur...", "sigma=2 stack");
	}
		
}

//Pad a number by n ammounts of zeros!
function pad(n) {
	str = toString(n);
	while (lengthOf(str)<5)
	  str = "0" + str;
	return str;
}



//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*
 * Macro to track the mice in an open cube of 38 cm by 38 cm
 * It will output several parameters related to displacement, velocity, etc.
 */
function MouseCubeTracker(){

	


	checkAndSort();

	//Select the directory of the open image to be analysed
	dir = getDirectory("image");
	imTitle = getTitle();
	rectCoord = newArray(4);

	run("Set Measurements...", "limit redirect=None decimal=3");

	//Reduce the fps of acquisition
	temp = dialog1(1);
	blaWhi = temp[0];
	fps = temp[1];
	boxW = temp[2];
	boxH = temp[3];
	darkR = temp[5];
	gaus = temp[6];
	
	//Takes care of cases where tracking has been done already
	//asks if you want to delete it or not
	//This is for the future!
	if(File.exists(dir + imTitle + ".cube.trac")){
		string = "File exists. Do you want to overwrite it? Cancel will stop the macro.";
		showMessageWithCancel(string);
		File.delete(dir + imTitle + ".cube.trac");		
	}
	
	//Save file to open later on
	f = File.open(dir + imTitle + ".cube.trac");
	print(f, dir + "\t" + getWidth() + "\t" +  getHeight() + "\t" + nSlices() +"\t"+ gaus);
	print(f, imTitle);
	print(f, "FPS\t" + fps);

	if(gaus > 0)
		run("Gaussian Blur...", "sigma="+gaus+" stack");

	//Draw a rectangle for the user to adujst to the base of the cube
	getDimensions(width, height, channels, slices, frames);
	makeRectangle(width/5, height/5,width/2,height/2);
	waitForUser("Please adjust the rectangule to match the bottom of the box");

	//Gets the dimensions and prints them to a file
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
	getPixelSize(unit, pw, ph);
	if(is("Virtual Stack")){
		close();
		sortVirtual(dir, rectCoord, 1, blaWhi);
	}else{
		//Accounts for white or black mice
		if(!blaWhi)
			setBackgroundColor(255, 255, 255);
		else
			setBackgroundColor(0, 0, 0);
			
		run("Enlarge...", "enlarge=15 pixel");
		run("Clear Outside", "stack");
		//Reduce intensity of the cage wall
		run("Enlarge...", "enlarge=-15 pixel");
		if(pw == 1 && ph == 1)
			run("Make Band...", "band=25");
		else
			run("Make Band...", "band=" + 25*pw);
			
		run("Gaussian Blur...", "sigma=10 stack");
	}
	
	//Checks if the pixel size is set and if not sets it from the 
	//dimensions of the cube
	if(pw == 1 && ph == 1){
		//Get pixel size from the width and heigth of cube
		px = boxW/rectCoord[2]; py = boxH/rectCoord[3];
		print(f, "Pixel size\t"+px+"\t"+py);
		run("Properties...", "channels=1 slices="+nSlices+" frames=1 unit=cm pixel_width="+px+" pixel_height="+py+" voxel_depth=1");	
	}else
	{
		print(f, "Pixel size\t"+pw+"\t"+ph);
	}

	
	

	//Remove dark regions if so selected
	if(darkR)
		darkA = removeDarkR(imTitle);

	//Get the threshold for getting the mouse spots
	setAutoThreshold("Triangle");  
	waitForUser("Please set the threshold carefully and press OK (Image>Adjust>Threshold).");
	getThreshold(minth, maxth);
	print(f, "Threshold\t"+minth+"\t"+maxth);
	
	if(darkR)
		print(f, "DarkR\t" + darkA[0] +"\t"+ darkA[1]); 
		
	File.close(f);
	setThreshold(minth,maxth);
		
	roiManager("Show All without labels");
	roiManager("Show None");
	//analyse particles taking in consideration the reduction in fps if selected
	setBatchMode("hide");
	if(fps == 25)
		run("Analyze Particles...", "size=15-Infinity include add stack");
	else{
		
		for(i = 1; i < nSlices; i = i + 100/fps){
			setSlice(i);
			run("Analyze Particles...", "size=15-Infinity include add slice");
		}
			
	}
	setBatchMode("show");
	roiManager("Show All without labels");
	roiManager("Show None");

	roiManager("Save", dir + imTitle + "ROIs.zip");
	

	//File operations done!

	run("Select None");

	oriID=getImageID();

	//Get data of the dectetions
	getParameters(fps, dir, imTitle);

	dialog2(oriID, dir, imTitle, 1);

	
	
}

function getParameters(fps,dir, imTitle){
	if(fps != 25){
		delay = 1/fps;
	}else
		delay = 1/25;
	
	//delay = 0.04;
	run("Set Measurements...", "centroid redirect=None decimal=3");
	
	arrayX = newArray(roiManager("Count"));
	arrayY = newArray(roiManager("Count"));
	displacement = newArray(roiManager("Count"));
	velocity = newArray(roiManager("Count"));
	direction = newArray(roiManager("Count"));
	turndir = newArray(roiManager("Count"));
	estado = newArray(roiManager("Count"));
	lookup = newArray(roiManager("Count"));
	inRegion = newArray(roiManager("Count"));

	displa = 0; moving = 0;
	displaCenter = 0; centerTime=0; entriesCenter = 0; freezeCenter = 0; 
	roiManager("Deselect");
	setBatchMode("hide");
	for(i=0; i<roiManager("count");i++){
		roiManager("Select", i);
		List.setMeasurements();
		arrayX[i] = List.getValue("X");
		arrayY[i] = List.getValue("Y");

		angle = getDirection(dir, imTitle);			
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

		if(angle[1])
			lookup[i] = "Yes";
		else
			lookup[i] = "No";

		if(angle[2]){
			inRegion[i] = "In";
			centerTime = centerTime + delay;
		}
		else
			inRegion[i] = "Out";
		
		if(i==0){
			displacement[i] = 0;
			velocity[i] = 0;
			
			turndir[i] = "No";
			estado[i] = "NAN";
		}else{
			displacement[i] = calculateDistance(arrayX[i-1], arrayY[i-1], arrayX[i], arrayY[i]);
			velocity[i] = displacement[i]/delay;

			if(angle[2] && inRegion[i-1] == "Out")
				entriesCenter++;
			
			if(direction[i] == direction[i-1])
				turndir[i] = "No";
			else
				turndir[i] = "Yes";

			if(displacement[i] > 0.1){
				estado[i] = "Moving";
				displa = displa + displacement[i];
				moving = moving + delay;
				if(angle[2]){
					displaCenter = displaCenter + displacement[i];
				}
				
			}else{
				estado[i] = "Stopped";
				if(angle[2]){
					freezeCenter = freezeCenter + delay;
				}
			}
			
		}

	}
	run("Select None");
	setBatchMode("show");
	
	run("Clear Results");
	for(i=0; i<roiManager("count"); i++){
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

	setResult("Label", 0, "Total displacement"); 
	setResult("Value", 0, displa);
	setResult("Label", 1, "Displacement in Center"); 
	setResult("Value", 1, displaCenter);
	setResult("Label", 2, "Displacement Outer Region"); 
	setResult("Value", 2,(displa - displaCenter));
	setResult("Label", 3,"Total time"); 
	setResult("Value",3, nSlices * delay);
	setResult("Label", 4, "Time in center"); 
	setResult("Value",4, centerTime);
	setResult("Label", 5, "N. entries in center"); 
	setResult("Value", 5, entriesCenter);
	setResult("Label", 6, "Time freezed/not moving"); 
	setResult("Value", 6,((nSlices * delay) - moving));
	setResult("Label", 7, "Time freezed/not moving in center"); 
	setResult("Value", 7,freezeCenter);
	setResult("Label", 8, "Time freezed/not moving in outer region"); 
	setResult("Value", 8,((nSlices * delay) - moving) - freezeCenter);
	setResult("Label", 9, "Average displacement");
	Array.getStatistics(displacement, min,max,mean,dev);
	setResult("Value", 9, mean);
	setResult("Label", 10, "Average velocity");
	Array.getStatistics(velocity, min,max,mean,dev);
	setResult("Value", 10, mean);

	updateResults();
	selectWindow("Results");
	saveAs("text", dir+imTitle+".Track.xls");
	run("Close");

}

function getDirection(dir, imTitle){
	
		angle = newArray(3);
		Array.fill(angle, 0);
		//Box region
		tempArray = getFileData(3, dir, imTitle, 1);
		//Center region
		tempArray2 = getFileData(4, dir, imTitle, 1);
		
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

		//Get the maxs and mins of the length array
		nInter = 10;
		do{
			maxlengths = Array.findMaxima(length, nInter);
			minlengths = Array.findMinima(length, nInter);
			nInter = round(nInter - (nInter/3));
		}while(lengthOf(maxlengths)==0)



		
		//Calculate the angle of the center to the head (max length)
		angle[0] = calculateAngle2(xc, yc, xp[maxlengths[0]],yp[maxlengths[0]]);

		//Tentative of finding out if the rat is rearing
		if(List.getValue("Solidity")< 0.8 && ((xp[maxlengths[0]] < tempArray[0] || xp[maxlengths[0]] > tempArray[0]+tempArray[2]) && (yp[maxlengths[0]] < tempArray[1] || yp[maxlengths[0]]> tempArray[1]+tempArray[3])))
			angle[1] = 1;
		
		//find out if the rat is in the center or not
		count = 0; in= 0;
		for(i = 0; i < xp.length; i++){
			//Count the points of the head out
			if(length[i]>= (length[maxlengths[0]]-5))
				count++;
			//Check if the coordinates are in the center or not
			if(xp[i] >= tempArray2[0] && xp[i] <= (tempArray2[0] + tempArray2[2]) && yp[i] >= tempArray2[1] && yp[i] <= (tempArray2[1]+tempArray2[3]))
				in++;
		}

		if(in >= lengthOf(xp) - count)
			angle[2] = 1;

		return angle;
	 
}


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////+
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


//Macro to evaluate the Elevated Puzzle mice proof
//It will be track the mouse in the cross like puzzle and
//calculate the time spent in the closed arms vs open arms
//it will also try to verify if the mouse was looking outside the
//edge in the open arms
function MiceElevatedPuzzleTracker(){

	checkAndSort();
	
	//First clean up and setup the macro actions
	dir = getDirectory("image");
	imTitle = getTitle();
	rectRegions = newArray(4);
	run("Set Measurements...", "limit redirect=None decimal=3");


	
	//Reduce the fps of acquisition
	temp = dialog1(2);
	blaWhi = temp[0];
	fps = temp[1];
	armsW = temp[2];
	armsH = temp[3];
	darkR = temp[5];
	gaus = temp[6];
	
	//Takes care of cases where tracking has been done already
	//asks if you want to delete it or not
	//This is for the future!
	if(File.exists(dir + imTitle + ".cross.trac")){
		string = "File exists. Do you want to overwrite it? Cancel will stop the macro.";
		showMessageWithCancel(string);
		File.delete(dir + imTitle + ".cross.trac");		
	}
	
	//Save file to open later on
	f = File.open(dir + imTitle + ".cross.trac");
	print(f, dir + "\t" + getWidth() + "\t" + getHeight() + "\t" + nSlices() + "\t" + gaus);
	print(f, imTitle);
	print(f, "FPS\t" + fps);
	
	if(gaus > 0)
		run("Gaussian Blur...", "sigma="+gaus+" stack");

	//get dimensions of the image in px
	getDimensions(width, height, channels, slices, frames);
	makeRectangle(width/2.5, height/2.5,width/10,height/10);
	waitForUser("Please adjust the rectangule to match the center of the box");
	
	

	//get the dimensions of the square in the center of the cross
	//this limits the lower bounds of the cross
	getSelectionBounds(rectRegions[0], rectRegions[1], rectRegions[2], rectRegions[3]);
	print(f,"BoxDimensions\t"+rectRegions[0]+"\t"+rectRegions[1]+"\t"+ rectRegions[2]+"\t"+rectRegions[3]);	



	//Calculate the pixel size of the image for x and y
	//And will later on put it in the image once I have the dimensions that 
	//it represents in reality
	getPixelSize(unit, pw, ph);
	if(pw == 1 && ph == 1){
		pixx = armsW/rectRegions[2]; pixy = armsH/rectRegions[3];
		print(f, "Pixel size\t"+pixx+"\t"+pixy);	
		//Set the pizel size once I figure out what value to give it!
		run("Properties...", "channels=1 slices="+nSlices+" frames=1 unit=cm pixel_width="+pixx+" pixel_height="+pixy+" voxel_depth=1");
	}
	else 
		print(f, "Pixel size\t"+pw+"\t"+ph);	


	//Asks the user to draw the polygon that the cross forms to clear outside ot if
	run("Select None");
	setTool("polygon");
	waitForUser("Please make a polygon to match the cross");
	getSelectionCoordinates(px, py);
	stringx = "";
	stringy = "";
	for(i = 0; i < px.length; i++){
		stringx = stringx + toString(px[i]) + "\t";
		stringy = stringy + toString(py[i]) + "\t";
	}
	print(f, "CrossRegionX" + "\t"+stringx);	
	print(f, "CrossRegionY" + "\t"+stringy);	
	

	//Deals with the virtual stack if it is one
	//This is necessary since several operations do not work on virtual stacks
	if(is("Virtual Stack")){
		roiManager("Add");
		close();
		sortVirtual(dir, 0, 3, blaWhi);
		roiManager("Reset");
	}else{
		if(!blaWhi)
			setBackgroundColor(255, 255, 255);
		else
			setBackgroundColor(0, 0, 0);
		
		run("Clear Outside", "stack");
	}

	if(darkR)
		darKA = removeDarkR(imTitle);


	//Asks for threshold to be set to be able to detect the mouse
	//run("Threshold...");
	setAutoThreshold("Yen");
	waitForUser("Set the threshold carefully. Open threshold window by Image>Adjust>Threshold");
	getThreshold(minth, maxth);
	setThreshold(minth,maxth);
	print(f, "Threshold\t" + minth + "\t" + maxth);
	print(f, "DarkR\t" + darKA[0] + "\t" + darKA[1]);
	
	//Try to speed up things with batch mode but not sure it actually helps
	setBatchMode(true);

	//deals with reduction of frame acquisition
	setBatchMode("hide");
	if(fps == 25)
		run("Analyze Particles...", "size=15-Infinity include add stack");
	else{
		
		for(i = 1; i < nSlices; i = i + 100/fps){
			setSlice(i);
			run("Analyze Particles...", "size=15-Infinity include add slice");
		}
			
	}
	setBatchMode("show");
	roiManager("Show All without labels");
	roiManager("Show None");
	setBatchMode(false);

	//Save the selection results
	roiManager("Save", dir + imTitle + "ROIs.zip");
	//print(f, dir + imTitle + "ROIs.zip");

	//File operations done!
	File.close(f);
	run("Select None");

	//gets image ID
	oriID=getImageID();
	
	getParametersET(fps, dir, imTitle);

	dialog2(oriID, dir, imTitle, 2);
	
}


//Main calculus function. Gets the selections for each slice and 
//pumps out the details relevant to the test
function getParametersET(fps, dir, imTitle){
	if(fps != 25){
		delay = 1/fps;
	}else
		delay = 1/25;

	run("Set Measurements...", "area centroid redirect=None decimal=3");
	
	arrayX = newArray(roiManager("Count"));
	arrayY = newArray(roiManager("Count"));
	displacement = newArray(roiManager("Count"));
	velocity = newArray(roiManager("Count"));
	closeArmsPosition = newArray(roiManager("Count"));
	openArmsPosition = newArray(roiManager("Count"));
	mouseArea = newArray(roiManager("Count"));
	angles = newArray(roiManager("Count"));
	anglesA = newArray(roiManager("Count"));

	displa = 0; 
	openTime = 0; closedTime=0; 
	entriesOpen = 0; entriesClose = 0;
	closedAreaAve = 0; closeAreaCount=0;
	check=0;
	roiManager("Deselect");
	setBatchMode("hide");
	for(i=0; i<roiManager("count");i++){
		roiManager("Select", i);
		//smooth a bit the selection to eliminate tails and small bits on walls
		//keeping the head - due to problems in the ilumination
		run("Enlarge...", "enlarge=-3 pixel");
		run("Enlarge...", "enlarge=3 pixel");
		List.setMeasurements();

		//Center coordinates of mouse
		arrayX[i] = List.getValue("X");
		arrayY[i] = List.getValue("Y");
		mouseArea[i] = List.getValue("Area");

		//angle is an array which provides several properties to setup
		//information. 
		angle = getDirectionET();		
		angles[i] = angle;

		if(angle==0){
			closeArmsPosition[i] = "Out";
			openArmsPosition[i] = "Out";

			
		}else if(angle == 1){
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
			if(displacement[i] > 0.1)
				displa = displa + displacement[i];
					
		}
			
	}

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
	nExplo = 0;

	run("Clear Results");
	//Write the Spot statistics file
	for(i=0; i<roiManager("count"); i++){
		setResult("X Center",i, arrayX[i]);
		setResult("Y Center",i, arrayY[i]);
		setResult("Displacement (cm)",i, displacement[i]);
		setResult("Velocity (cm/s)",i, velocity[i]);
		setResult("In Closed region",i, closeArmsPosition[i]);
		setResult("In Open region", i, openArmsPosition[i]);
		if(i > 0 && openArmsPosition[i] == "In" && mouseArea[i] <= (closedAreaAve * 0.85)){
			setResult("Looking over the edge", i, "True");
			if(getResultString("Looking over the edge", i-1) == "NAN")
				nExplo++;
		}else 
			setResult("Looking over the edge", i, "NAN");
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
	
	updateResults();
	selectWindow("Results");
	saveAs("text", dir+imTitle+".Track.xls");
	run("Close");

}




//This function works in pixels only
//that doesn t matter for this case as it only matters 
//where it is or not!
function getDirectionET(){

		//Get the coordinates of the selection
		getSelectionCoordinates(xp, yp);


		//Get central box parameters
		rectRegions = getFileData(3, dir, imTitle, 2);

		//Get pixel size
		tempArray = getFileData(4, dir, imTitle, 2);

				
		//find out if the rat is closed or open arms
		countOpen = 0; countClose= 0;
		for(i = 0; i < xp.length; i++){
			if(yp[i] <= rectRegions[1] || yp[i] > (rectRegions[1] + rectRegions[3]))
				countClose++;
			else if(xp[i] <= rectRegions[0] || xp[i] > (rectRegions[0] + rectRegions[2]))
				countOpen++;
			else
				;
		}


		if(countClose >= lengthOf(xp)*0.9)
			angle = 1;
		else if(countOpen >= lengthOf(xp)*0.9)
			angle = 2;
		else
			angle = 0;

	
		return angle;
	 
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*
 * Macro to track the mice in an open swim of 125cm diameter
 * It will output several parameters related to displacement, velocity, etc.
 */
function MouseSwimTracker(){
	
	checkAndSort();

	//Select the directory of the open image to be analysed
	dir = getDirectory("image");
	imTitle = getTitle();
	rectCoord = newArray(4);
	platCoord = newArray(4);
	
	run("Set Measurements...", "limit redirect=None decimal=3");

	//Reduce the fps of acquisition
	temp = dialog1(3);
	blaWhi = temp[0];
	fps = temp[1];
	diameter = temp[2];
	rRegions = temp[4];
	darkR = temp[5];	
	gaus = temp[6];
	
	//Takes care of cases where tracking has been done already
	//asks if you want to delete it or not
	//This is for the future!
	if(File.exists(dir + imTitle + ".swim.trac")){
		string = "File exists. Do you want to overwrite it? Cancel will stop the macro.";
		showMessageWithCancel(string);
		File.delete(dir + imTitle + ".swim.trac");		
	}
	
	//Save file to open later on
	f = File.open(dir + imTitle + ".swim.trac");
	print(f, dir + "\t" + getWidth() + "\t" + getHeight() + "\t" + nSlices + "\t" + gaus);
	print(f, imTitle);
	print(f, "FPS\t" + fps);
	
	if(gaus > 0)
		run("Gaussian Blur...", "sigma="+gaus+" stack");

	
	getDimensions(width, height, channels, slices, frames);
	makeOval(50, 50,width/1.3,height/1.1);
	waitForUser("Please adjust the oval to match the circunference of the pool.");

	getSelectionBounds(rectCoord[0], rectCoord[1], rectCoord[2], rectCoord[3]);
	print(f,"OvalDimensions\t"+rectCoord[0]+"\t"+rectCoord[1]+"\t"+ rectCoord[2]+"\t"+rectCoord[3]);	

	boundx = rectCoord[0] + (rectCoord[2]/2);
	boundy = rectCoord[1] + (rectCoord[3]/2);
	print(f,"Diameter\t"+boundx+"\t"+boundy);

	makeOval(50, 50,width/10,height/10);
	waitForUser("Please adjust the oval to match the platform");
	getSelectionBounds(platCoord[0], platCoord[1], platCoord[2], platCoord[3]);
	print(f,"PlatformDimensions\t"+platCoord[0]+"\t"+platCoord[1]+"\t"+ platCoord[2]+"\t"+platCoord[3]);	

	getPixelSize(unit, pw, ph);
	if(pw == 1 && ph ==1){
		px = diameter/rectCoord[2]; py = diameter/rectCoord[3];
		print(f, "Pixel size\t"+px+"\t"+py);	
		run("Properties...", "channels=1 slices="+nSlices+" frames=1 unit=cm pixel_width="+px+" pixel_height="+py+" voxel_depth=1");
	}
	else
		print(f, "Pixel size\t"+pw+"\t"+ph);
		
	
	
	makeOval(rectCoord[0], rectCoord[1], rectCoord[2], rectCoord[3]);
	
	
	if(is("Virtual Stack")){
		close();
		sortVirtual(dir, rectCoord, 3);
	}else{
		if(!blaWhi)
			setBackgroundColor(255, 255, 255);
		else
			setBackgroundColor(0, 0, 0);

		run("Clear Outside", "stack");
	}

	
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

	
	//run("Threshold...");
	setAutoThreshold("Triangle");
	waitForUser("Please set the threshold carefully and press OK");
	getThreshold(minth, maxth);
	setThreshold(minth,maxth);
	
	print(f, "Threshold\t" + minth + "\t" + maxth);
	
	roiManager("Show All without labels");
	roiManager("Show None");
	setBatchMode("hide");
	if(fps == 25)
		run("Analyze Particles...", "size=7-Infinity include add stack");
	else{
		
		for(i = 1; i < nSlices; i = i + 100/fps){
			setSlice(i);
			run("Analyze Particles...", "size=7-Infinity include add slice");
		}
			
	}
	setBatchMode("show");
	roiManager("Show All without labels");
	roiManager("Show None");

	roiManager("Save", dir + imTitle + "ROIs.zip");
	

	//File operations done!
	File.close(f);
	run("Select None");

	oriID=getImageID();

	getParametersSM(fps,dir, imTitle);

	dialog2(oriID, dir, imTitle, 3);
	
	
}
function getParametersSM(fps,dir, imTitle){
	//Get dealy between frames analyzed
	if(fps != 25){
		delay = 1/fps;
	}else
		delay = 1/25;
	
	run("Set Measurements...", "centroid redirect=None decimal=3");
	
	arrayX = newArray(roiManager("Count"));
	arrayY = newArray(roiManager("Count"));
	displacement = newArray(roiManager("Count"));
	velocity = newArray(roiManager("Count"));
	quadrant = newArray(roiManager("Count"));

	flag = true;
	
	displa = 0; t2Plat = 0;
	qTime1 = 0; qTime2 = 0; qTime3 = 0; qTime4 = 0;
	qDis1 = 0; qDis2 = 0; qDis3 = 0; qDis4 = 0;
	
	roiManager("Deselect");
	
	setBatchMode("hide");
	for(i=0; i<roiManager("count");i++){
		roiManager("Select", i);
		List.setMeasurements();
		arrayX[i] = List.getValue("X");
		arrayY[i] = List.getValue("Y");

		angle = getQuadAndPlat(dir, imTitle);		

		quadrant[i] = angle[0];

		if(i==0){
			displacement[i] = 0;
			velocity[i] = 0;
			
						
		}else{
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
				t2Plat = getSliceNumber()*delay;
				flag = 0;
			}
			

			if(displacement[i] > 0.1)				//--> Check this number to see when it is stopped!
				displa = displa + displacement[i];

		}
			
	}
	
	setBatchMode("show");
	run("Select None");

	run("Clear Results");
	for(i=0; i<roiManager("count"); i++){
		setResult("X Center (cm)",i, arrayX[i]);
		setResult("Y Center (cm)",i, arrayY[i]);
		setResult("Displacement (cm)",i, displacement[i]);
		setResult("Velocity (cm/s)",i, velocity[i]);
		setResult("Quadrant position",i, quadrant[i]);
	}
	updateResults();

	selectWindow("Results");
	saveAs("text", dir+imTitle+".Spots.xls");
	run("Clear Results"); 

	setResult("Label", 0, "Total displacement (cm)"); 
	setResult("Value", 0, displa);
	setResult("Label", 1, "Displacement (cm) in R1"); 
	setResult("Value", 1, qDis1);
	setResult("Label", 2, "Time (s) in R1"); 
	setResult("Value", 2, qTime1);
	setResult("Label", 3, "Displacement (cm) in R2"); 
	setResult("Value",3, qDis2);
	setResult("Label", 4, "Time (s) in R2"); 
	setResult("Value",4, qTime2);
	setResult("Label", 5, "Displacement (cm) in R3"); 
	setResult("Value", 5, qDis3);
	setResult("Label", 6, "Time (s) in R3"); 
	setResult("Value", 6, qTime3);
	setResult("Label", 7, "Displacement (cm) in R4"); 
	setResult("Value", 7, qDis4);
	setResult("Label", 8, "Time (s) in R4"); 
	setResult("Value", 8, qTime4);
	setResult("Label", 9, "Average displacement (cm)");
	Array.getStatistics(displacement, min,max,mean,dev);
	setResult("Value", 9, mean);
	setResult("Label", 10, "Average velocity (cm/s)");
	Array.getStatistics(velocity, min,max,mean,dev);
	setResult("Value", 10, mean);
	setResult("Label",11, "Time to find platform (s)");
	if(t2Plat > 0)
		setResult("Value",11, t2Plat);
	else
		setResult("Value",11, "Did not find Platform");

	updateResults();
	selectWindow("Results");
	saveAs("text", dir+imTitle+".Track.xls");
	run("Close");

}

function getQuadAndPlat(dir, imTitle){
	
		angle = newArray(2);
		Array.fill(angle, 0);
		//Pool bounding box
		tempArray = getFileData(4, dir, imTitle, 3);
		//Platform bounding box
		tempArray2 = getFileData(5, dir, imTitle, 3);
		//Pixel size
		tempArray3 = getFileData(6, dir, imTitle, 3);
		
		//Get the coordinates of the selection
		getSelectionCoordinates(xp, yp);
		List.setMeasurements();
		
		//Center mass of the selection in pixels
		xc = List.getValue("X");
		yc = List.getValue("Y");
		toUnscaled(xc, yc);
		
		//Qudrant determination
		if(xc <= tempArray[0] && yc <= tempArray[1])
			angle[0] = 1;
		else if(xc <= tempArray[0] && yc > tempArray[1])
			angle[0] = 2;
		else if(xc > tempArray[0] && yc <= tempArray[1])
			angle[0] = 3;
		else
			angle[0] = 4;
		
		
		platDist = calculateDistance(xc, yc, tempArray2[0]+(tempArray2[2]/2), tempArray2[1]+(tempArray2[3]/2));
		
		//find out if the rat is in the platform or not
		if(platDist <= ((tempArray2[2] + tempArray2[3])/4))
			angle[1] = 1;

		return angle;
	 
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*
 * Macro to track the mice in an open cube of 38 cm by 38 cm
 * It will output several parameters related to displacement, velocity, etc.
 */
function MouseRegionsTracker(){

	checkAndSort();
	
	//Select the directory of the open image to be analysed
	dir = getDirectory("image");
	imTitle = getTitle();
	rectCoord = newArray(4);
	
	run("Set Measurements...", "limit redirect=None decimal=3");

	//Reduce the fps of acquisition
	choiceArray = dialog1(4);
	blaWhi = choiceArray[0];
	fps = choiceArray[1];
	cubeW = choiceArray[2];
	cubeH = choiceArray[3];
	nRegions = choiceArray[4];
	darkR = choiceArray[5];
	gaus = choiceArray[6];

	//Takes care of cases where tracking has been done already
	//asks if you want to delete it or not
	//This is for the future!
	if(File.exists(dir + imTitle + ".objects.trac")){
		string = "File exists. Do you want to overwrite it? Cancel will stop the macro.";
		showMessageWithCancel(string);
		File.delete(dir + imTitle + ".objects.trac");		
	}
	//Save file to open later on
	f = File.open(dir + imTitle + ".objects.trac");
	print(f, dir + "\t" + getWidth + "\t" + getHeight + "\t" + nSlices + "\t" + gaus);
	print(f, imTitle);
	print(f, "FPS\t" + fps);

	if(gaus > 0)
		run("Gaussian Blur...", "sigma="+gaus+" stack");

	getDimensions(width, height, channels, slices, frames);
	makeRectangle(width/5, height/5,width/2,height/2);
	waitForUser("Please adjust the rectangule to match the bottom of the box");

	getSelectionBounds(rectCoord[0], rectCoord[1], rectCoord[2], rectCoord[3]);
	print(f,"BoxDimensions\t"+rectCoord[0]+"\t"+rectCoord[1]+"\t"+ rectCoord[2]+"\t"+rectCoord[3]);	

	
	boundx = rectCoord[0] + (rectCoord[2]/5);
	boundy = rectCoord[1] + (rectCoord[3]/5);
	boundx2 = (rectCoord[2]/5)*3;
	boundy2 = (rectCoord[3]/5)*3;
	print(f,"Region\t"+boundx+"\t"+boundy+"\t"+boundx2+"\t"+boundy2);	

		
	getPixelSize(unit, pw, ph);
	if(is("Virtual Stack")){
		close();
		sortVirtual(dir, rectCoord, 1);
	}else{
		if(!blaWhi)
			setBackgroundColor(255, 255, 255);
		else
			setBackgroundColor(0, 0, 0);
	
		run("Enlarge...", "enlarge=15 pixel");
		run("Clear Outside", "stack");
		//Reduce the dark regions frontier
		run("Enlarge...", "enlarge=-15 pixel");
		run("Make Band...", "band="+ 25*pw);
		run("Gaussian Blur...", "sigma=10 stack");	
	}
 
	
	//Get pixel size from the width and heigth of cube
	
	if(pw == 1 && ph == 1){
		px = cubeW/rectCoord[2]; py = cubeH/rectCoord[3];
		print(f, "Pixel size\t"+px+"\t"+py);	
		run("Properties...", "channels=1 slices="+nSlices+" frames=1 unit=cm pixel_width="+px+" pixel_height="+py+" voxel_depth=1");
	}
	else
		print(f, "Pixel size\t"+pw+"\t"+ph);	

		
	Array.fill(rectCoord, 0);
	if(nRegions>0){
		for(i=0; i < nRegions; i++){
			makeOval(width/2, height/2,width/10,height/10);
			waitForUser("Please set region n." + (i + 1));
			getSelectionBounds(rectCoord[0], rectCoord[1], rectCoord[2], rectCoord[3]);
			print(f,"Object"+(i+1)+"\t"+rectCoord[0]+"\t"+rectCoord[1]+"\t"+ rectCoord[2]+"\t"+rectCoord[3]);
		}
	}

	

	if(darkR)
		darKA = removeDarkR(imTitle);
	
	run("Select None");
	setAutoThreshold("Triangle");
	waitForUser("Please set the threshold carefully and press OK");
	getThreshold(minth, maxth);
	setThreshold(minth,maxth);
	
	print(f, "Threshold\t" + minth + "\t" + maxth);
	print(f, "DarkR\t" + darKA[0] + "\t" + darKA[1]);
	
	roiManager("Show All without labels");
	roiManager("Show None");
	setBatchMode("hide");
	if(fps == 25)
		run("Analyze Particles...", "size=7-Infinity include add stack");
	else{
		
		for(i = 1; i < nSlices; i = i + 100/fps){
			setSlice(i);
			run("Analyze Particles...", "size=7-Infinity include add slice");
		}
			
	}
	setBatchMode("show");
	roiManager("Show All without labels");
	roiManager("Show None");

	roiManager("Save", dir + imTitle + "ROIs.zip");
	
	//File operations done!
	File.close(f);
	run("Select None");

	oriID=getImageID();

	getParametersRT(fps, dir, imTitle, nRegions);

	dialog2(oriID, dir, imTitle, 4);

	
	
}
///////////////////////////////////////////////////////
////function to get the parameters of the regions 
////where hte magic happens!!!


function getParametersRT(fps,dir, imTitle, n){
	if(fps != 25){
		delay = 1/fps;
	}else
		delay = 1/25;
	
	//delay = 0.04;
	run("Set Measurements...", "centroid redirect=None decimal=3");
	
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
	for(i=0, j = 0; i<roiManager("count");i++){
		roiManager("Select", i);
		List.setMeasurements();
		arrayX[i] = List.getValue("X");
		arrayY[i] = List.getValue("Y");

		//Get the details of where it is
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

	run("Clear Results");
	for(i=0, j=0; i<roiManager("count"); i++){
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
	setResult("Value",1, nSlices * delay);
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

function getDirectionRT(dir, imTitle, n){
	
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

		//Get the maxs and mins of the length array
		nInter = 10;
		do{
			maxlengths = Array.findMaxima(length, nInter);
			minlengths = Array.findMinima(length, nInter);
			nInter = round(nInter - (nInter/3));
		}while(lengthOf(maxlengths)==0)
		

		for(i = 0, j = 0 ; i < n; i++, j++){
			regAprox = sortRegions(xp, yp, xc, yc, maxlengths[0], dir, imTitle,  i);
			angle[j] = regAprox[0];
			j++;
			angle[j] = regAprox[1];
		}
				

			
		
		


		return angle;
	 
}

//This functions works only in px
//Check if the mouse is near a region of interest or not
function sortRegions(xp, yp, xc, yc, headC, dir, imTitle, n){

	temp = newArray(2);
	
	Array.fill(temp, 0);
	//get the region
	regArray = getFileData(6+n, dir, imTitle, 4);
	
	//calculate center of oval and ratio
	radius = (regArray[2] + regArray[3])/4;
	centerX = regArray[0] + (regArray[2]/2);
	centerY = regArray[1] + (regArray[3]/2);

	dist = calculateDistance(centerX, centerY, xc, yc);
	
	//check if the mouse is close to the regions
	if(dist < radius * 6){
		//check if head or body is close to the region
		dist = calculateDistance(centerX,centerY,xp[headC],yp[headC]);
		
		if(dist <= radius * 2){
			temp[0] = 1;
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

//////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
//Macro to evaluate the TY Puzzle mice 
//It will be track the mouse in the cross like puzzle and
//calculate the time spent in each arm and the first time it goes in each arm
function MiceYTTracker(){

	
	checkAndSort();
	
	//First clean up and setup the macro actions
	dir = getDirectory("image");
	imTitle = getTitle();
	rectRegions = newArray(4);
	run("Set Measurements...", "limit redirect=None decimal=3");


	
	//Reduce the fps of acquisition
	temp = dialog1(5);
	blaWhi = temp[0];
	fps = temp[1];
	armsD = temp[2];
	darkR = temp[5];
	gaus = temp[6];
	
	//Takes care of cases where tracking has been done already
	//asks if you want to delete it or not
	//This is for the future!
	if(File.exists(dir + imTitle + ".TY.trac")){
		string = "File exists. Do you want to overwrite it? Cancel will stop the macro.";
		showMessageWithCancel(string);
		File.delete(dir + imTitle + ".TY.trac");		
	}
	
	//Save file to open later on
	f = File.open(dir + imTitle + ".TY.trac");
	print(f, dir + "\t" + getWidth + "\t" + getHeight + "\t" + nSlices + "\t" + gaus);
	print(f, imTitle);
	print(f, "FPS\t" + fps);

	//get dimensions of the image in px
	getDimensions(width, height, channels, slices, frames);
	makePolygon(width/2, height/2,width/2 + 40, height/2,width/2 + 20, height/2+40);
	waitForUser("Please adjust the vertices of the triangle to match the vertices of the arms");

	//get the dimensions of the triangle in the center of the T/Y
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
	//Calculate the pixel size of the image for x and y
	//And will later on put it in the image once I have the dimensions that 
	//it represents in reality
	getPixelSize(unit, pw, ph);
	if(pw == 1 && ph == 1){
		pixx = armsD/dist; pixy = armsD/dist;
		print(f, "Pixel size\t"+pixx+"\t"+pixy);	
		//Set the pizel size 
		run("Properties...", "channels=1 slices="+nSlices+" frames=1 unit=cm pixel_width="+pixx+" pixel_height="+pixy+" voxel_depth=1");
	}
	else 
		print(f, "Pixel size\t"+pw+"\t"+ph);	


	//Asks the user to draw the polygon that the cross forms to clear outside ot if
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
	

	//Deals with the virtual stack if it is one
	//This is necessary since several operations do not work on virtual stacks
	if(is("Virtual Stack")){
		roiManager("Add");
		close();
		sortVirtual(dir, 0, 3);
		roiManager("Reset");
	}else{
		if(!blaWhi)
			setBackgroundColor(255, 255, 255);
		else
			setBackgroundColor(0, 0, 0);
			
		run("Clear Outside", "stack");
	}

	if(darkR){
		darKA = removeDarkR(imTitle);
	}

	//Asks for threshold to be set to be able to detect the mouse
	//run("Threshold...");
	setAutoThreshold("Yen");
	waitForUser("Set the threshold carefully. Open threshold window by Image>Adjust>Threshold");
	getThreshold(minth, maxth);
	setThreshold(minth,maxth);
	print(f, "Threshold\t" + minth + "\t" + maxth);
	print(f, "DarkR\t" + darKA[0] + "\t" + darKA[1]);

	//Try to speed up things with batch mode but not sure it actually helps
	setBatchMode(true);

	//deals with reduction of frame acquisition
	if(fps == 25)
		run("Analyze Particles...", "size=7-Infinity include add stack");
	else{
		
		for(i = 1; i < nSlices; i = i + 100/fps){
			setSlice(i);
			run("Analyze Particles...", "size=7-Infinity include add slice");
		}
			
	}

	roiManager("Show All without labels");
	roiManager("Show None");
	setBatchMode(false);

	//Save the selection results
	roiManager("Save", dir + imTitle + "ROIs.zip");
	//print(f, dir + imTitle + "ROIs.zip");

	//File operations done!
	File.close(f);
	run("Select None");

	//gets image ID
	oriID=getImageID();
	
	getParametersTY(fps, dir, imTitle);

	dialog2(oriID, dir, imTitle, 5);
	
}

//Main calculus function. Gets the selections for each slice and 
//pumps out the details relevant to the test
function getParametersTY(fps, dir, imTitle){
	if(fps != 25){
		delay = 1/fps;
	}else
		delay = 1/25;

	run("Set Measurements...", "area centroid redirect=None decimal=3");
	
	arrayX = newArray(roiManager("Count"));
	arrayY = newArray(roiManager("Count"));
	displacement = newArray(roiManager("Count"));
	velocity = newArray(roiManager("Count"));
	armsPosition = newArray(roiManager("Count"));
	armsPositionA = newArray(roiManager("Count"));
	slices = newArray(roiManager("Count"));
	
	displa = 0; visit1 = 0; visit2=0; visit3 = 0; 
	time1 = 0; time2 = 0; time3=0;
	order1 = 0; order2 = 0; order3=0;
	ordem = "";
	
	roiManager("Deselect");
	setBatchMode("hide");
	for(i=0; i<roiManager("count");i++){
		roiManager("Select", i);
		//smooth a bit the selection to eliminate tails and small bits on walls
		//keeping the head - due to problems in the ilumination
		run("Enlarge...", "enlarge=-3 pixel");
		run("Enlarge...", "enlarge=3 pixel");
		List.setMeasurements();

		//Center coordinates of mouse
		arrayX[i] = List.getValue("X");
		arrayY[i] = List.getValue("Y");
		

		//angle is an array which provides several properties to setup
		//information. 
		armsPosition[i] = getDirectionTY();			
		slices[i] = getSliceNumber();


				
		if(i==0){
			displacement[i] = 0;
			velocity[i] = 0;

		}else{
			displacement[i] = calculateDistance(arrayX[i-1], arrayY[i-1], arrayX[i], arrayY[i]);
			velocity[i] = displacement[i]/delay;
			if(displacement[i] > 0.1)
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


	ordem = toString(armsPosition[0]);
	
	for(i = 1; i< armsPositionA.length; i++){
		if(armsPositionA[i]==1){
			time1 = time1 + delay;
			if(armsPositionA[i-1] != 1){
				visit1++;
				ordem = ordem + ",1";
				if(order1 == 0){
					roiManager("Select", i);
					order1 = delay * getSliceNumber();
				}
					
			}
				
		}else if(armsPosition[i]==2){
			time2 = time2 + delay;
			if(armsPosition[i-1] != 2){
				visit2++;
				ordem = ordem + ",2";
				if(order2 == 0){
					roiManager("Select", i);
					order2 = delay * getSliceNumber();
				}
					
			}
		}else if(armsPosition[i]==3){
			time3 = time3 + delay;
			if(armsPosition[i-1] != 3){
				visit3++;
				ordem = ordem + ",3";
				if(order3 == 0){
					roiManager("Select", i);
					order3 = delay * getSliceNumber();
				}
					
			}
		}else ;

	}

	

	
	setBatchMode("show");
	run("Select None");

	tripletStory = getTripletStat(ordem);

	run("Clear Results");
	//Write the Spot statistics file
	for(i=0; i<roiManager("count"); i++){
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
	setResult("Label", 14, "Total triplets + double");
	setResult("Value", 14, tripletStory[1]);

	
	updateResults();
	selectWindow("Results");
	saveAs("text", dir+imTitle+".TrackTY.xls");
	run("Close");

}


//This function works in pixels only
//that doesn t matter for this case as it only matters 
//where it is or not!
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


//////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Sort image type and first preparations+
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


////////////////Dialog box
//Dialog to ask if you want to reduce the fps
function dialog1(option){
	/* 0 - Black/White mice - all
	 * 1-fps
	 * 2-width of box or diamter of pool or arms of Y
	 * 3 - heigth of box
	 * 4 remove regions in pool - regions to analyze in box
	 * 5 - dark vader
	 */
	temp = newArray(7); 
	Array.fill(temp, 0);
	stringA = newArray("Box Track", "Elevated Puzzled", "Swim Test", "Regions Box", "T/Y Test");
	array1 = newArray("Black mice in white bckgrnd", "White mice in black bkgrnd");
	array2 = newArray("25", "20", "15", "5");
	array3 = newArray("Center Region", "Objects");

	str = "JAMouT (Just Another Mouse Tracker) -- " + stringA[option-1];
	Dialog.create(str);
	Dialog.addRadioButtonGroup("Mice color", array1, 1, 2, "Black mice in white bckgrnd");
	
	Dialog.addMessage("Do you want to reduce the tracking resolution to increase speed?");
	Dialog.addRadioButtonGroup("Frames per second (25 is all)", array2, 1, 4, "25");
	
	//Specific dialog options for each macro
	if(option == 1 || option == 2 || option == 4){
		if(option == 2)
			n = 8;
		else 
			n = 38;
		Dialog.addMessage("Measurements of box/central area of cross:");
		Dialog.addNumber("Width (in cm)", n);
		Dialog.addNumber("Height (in cm)", n);
	}
	if(option == 3){
		Dialog.addNumber("Diameter of the pool (cm):", 125);
		Dialog.addMessage("Do you want to remove any region(s)? Leave zero if not.");
		Dialog.addNumber("How many", 0);
	}
		
	if(option == 4){
		Dialog.addSlider("Regions to analyze", 1, 5, 2);
	}

	if(option == 5){
		Dialog.addNumber("Width of arms (in cm):", 7);
	}

	if(option != 3){
		Dialog.addMessage("Dark/White regions treatment?");
		Dialog.addCheckbox("Dark/White Vader?", false);
	}

	Dialog.addMessage(" ");
	Dialog.addNumber("Guassian blur to apply to image (0 for not)", 2);


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
	//all but pool	
	if(option != 3 && Dialog.getCheckbox)
		temp[5] = 1;

	temp[6] = Dialog.getNumber();
	return temp;

}




//Dialog to ask what other images you want to take
function dialog2(imageID, dir, imTitle, option){
	Dialog.create("Coordinates");
	Dialog.addMessage("What other images to you want?");
	Dialog.addCheckbox("Heatmap", true);
	Dialog.addCheckbox("Line track",true);
	Dialog.show();
	
	heat = Dialog.getCheckbox();
	line = Dialog.getCheckbox();

	if(heat)
		heatMap(imageID, dir, imTitle, option);
		
	if(line)
		lineTrack(imageID, dir, imTitle, option);
	
}


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
	
}


//Drawing the path of the mouse around the puzzle
function lineTrack(imageID, dir, imTitle, option){

		
	selectImage(imageID);
	getDimensions(width, height, channels, slices, frames);
	newImage("lineTrack", "8-bit black", width, height, 1);
	setBatchMode("show");
	
	if(option == 1) //Empty box
		choice = promptandgetChoice(0, 1, 0, 0, 0);
	else if(option == 2 || option == 5)//Cross and TY regions
		choice = promptandgetChoice(0, 0, 0, 1, 0);
	else if(option == 3) //Swimming
		choice = promptandgetChoice(0, 1, 0, 0, 0);
	else
		choice = promptandgetChoice(0, 0, 0, 0, 1);


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
			else
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
			for(k = 6; k < (6+count); k++){
				array = getFileData(k, dir, imTitle, option);
				drawOval(array[0], array[1], array[2], array[3]);
			}
		}
		else ;
		
	}
	
	run("Set Measurements...", "centroid redirect=None decimal=3");
	setLineWidth(2);
	setForegroundColor(255, 255, 255); 
	
	for(i=0;i<roiManager("count")-1;i++){
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
}


//Create a heatmap of the mice movement
function heatMap(imageID, dir, imTitle, option){
		
		
	if(option == 1) 								//Empty box
		choice = promptandgetChoice(1, 1, 0, 0, 0);
	else if(option == 2 || option == 5)				//Cross/TY region
		choice = promptandgetChoice(1, 0, 0, 1, 0);
	else if(option == 3)							//Swimming
		choice = promptandgetChoice(1, 0, 1, 0, 0);
	else 
		choice = promptandgetChoice(1, 0, 0, 0, 1);
		
	x = choice[0];

	selectImage(imageID);
	getDimensions(width, height, channels, slices, frames);
	newImage("HeatMap", "16-bit black", width, height, 1);
	heat = getImageID();

	
	run("Set Measurements...", "centroid redirect=None decimal=3");

	//selectImage(ori);
	if(x==0){
		selectImage(heat);
		setBatchMode("hide");
		for(i=0; i<roiManager("count");i++){
			roiManager("Select", i);
			run("Add...", "value=1 slice");
		}
		setBatchMode("show");
		
	}else{
		selectImage(heat);
		setBatchMode("hide");
		for(i=0; i<roiManager("count");i++){
			roiManager("Select", i);
			List.setMeasurements();
			xc = List.getValue("X");
			yc = List.getValue("Y");
			for(j=xc-x;j<xc+x;j++){
				for(k=yc-x;k<yc+x;k++){
					setPixel(j, k, getPixel(j,k)+1);  // 
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
			for(k = 6; k < (6+count); k++){
				array = getFileData(k, dir, imTitle, option);
				drawOval(array[0], array[1], array[2], array[3]);
			}
		}
		else ;
	}
		
}




///////////////Dialog box
//Provides options of drawing regions in the heatmap and 
//trajectory map
function promptandgetChoice(c1, c2, c3, c4, c5){
	temp = newArray(3);
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
	}

	//Case of cross puzzles
	if(c4)
		Dialog.addCheckbox("Draw cross region?", true);

	//case of regions
	if(c5){
		Dialog.addCheckbox("Draw box region?", true);
		Dialog.addCheckbox("Draw regions?", true);
	}

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

	
	return temp; 
}

//Retrieve data from a specific line from a file in dir with the name imTitle
//Only in use for Mice_Track
function getFileData(line, dir, imTitle, option){

	strTer = newArray(".cube.trac", ".cross.trac", ".swim.trac", ".objects.trac", ".TY.trac");
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


//simple function to calculate the distance between two points
//by the Pitagoras formula
function calculateDistance(x1, y1, x2, y2){
	temp = sqrt(pow((x2-x1), 2) + pow((y2-y1),2));
	return temp;
}


//function to clear a region
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

//Function to count the lines of a txt file separated by \n
function countLinesStartingWith(dir, imTitle, option, strBegin){
	strTer = newArray(".cube.trac", ".cross.trac", ".swim.trac", ".objects.trac", ".TY.trac");
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


//Tries to sort out the dark regions
function removeDarkR(imTitle){
	temp = newArray(2);
	run("Select None");
	showMessage("Remove Dark regions","<html>"+"<font size=2><center>Please select the starting and end point<br>"+"<font size=2><center>of the stack to create a shading correction.<br>" + "<font size=2><center>Ideally you want frames where the mouse isn´t present yet (minimum 50 frames)<br>" + "<font size=2><center>If you have to use frames with mice in use as many as possible (>1000)<br><br>");
	waitForUser("Please select the inital frame to start the averaging");
	temp[0] = getSliceNumber();
	waitForUser("Please select the final frame to start the averaging");
	temp[1] = getSliceNumber();
	darkRPorjection(imTitle, temp[0], temp[1]);
	/*n = nSlices;
	if(n > 2010){
		start = round(n/2) - 999;
		end = round(n/2) + 999;
	}else{
		start = 1;
		end = nSlices;
	}*/
	
	return temp;
}

function darkRPorjection(imTitle, min, max) {
	setBatchMode(true);
	run("Z Project...", "start="+min+" stop="+max+" projection=[Average Intensity]");
	projTile = getTitle();
	imageCalculator("Difference create stack", imTitle, projTile);
	close("\\Others");
	run("Invert", "stack");
	run("Gamma...", "value=5 stack");
	setBatchMode(false);
	
}



//function to calculate the angle between two points
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

/*Everything related with redoing analysis 
is from here downwards!!
/////////////////////////////////////////////////////
////////////////////////////////////////////////////////
///////////////////////////////////////////////////// */

function openPreviousAnalysis(){

	strTer = newArray(".cube.trac", ".cross.trac", ".swim.trac", ".objects.trac", ".TY.trac");
	file = File.openDialog("Please select the output file of the previous analysis.")
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
		}else
			exit("Could not identify the type of analysis of this trac file");
	}else
		print("This file " + file + " does not appear to be a valid JAMoT file.");

}


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
		setThrandAna(thrMin, thrMax, fps);
		
		//gets image ID
		oriID=getImageID();
		getParametersTY(fps, dir, imName);
		dialog2(oriID, dir, imName, 5);
		
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
			getParametersTY(fps, dir, imName);
		}
		if(option == 2){
			oriID = getImageID();
			dialog2(oriID, dir, imName, 5);
		}	
		
			
			
	}
	
}
	

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
		setThrandAna(thrMin, thrMax, fps);
		
		//Get data of the dectetions
		oriID=getImageID();
		getParametersRT(fps, dir, imName, nRegions);
		dialog2(oriID, dir, imName, 4);
		
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
			getParametersRT(fps, dir, imName, nRegions);
		}
		if(option == 2){
			//oriID = getImageID();
			dialog2(oriID, dir, imName, 4);
		}	
		
			
			
	}
	
}


function swimRedo(temp, option){
	//Get the data from the file		
	box = newArray(4);
	dir = temp[0];
	iw = parseInt(temp[1]); ih = parseInt(temp[2]); inS = parseInt(temp[3]); 
	gaus = parseInt(temp[4]);
	imName = temp[5];
	fps = parseInt(temp[7]);
	box[0] = parseInt(temp[9]); box[1] = parseInt(temp[10]); box[2] = parseInt(temp[11]); box[3] = parseInt(temp[12]);
	pw = parseFloat(temp[14]); py = parseFloat(temp[15]);
	
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
		setThrandAna(thrMin, thrMax, fps);
		
		//Get data of the dectetions
		oriID = getImageID;
		getParametersSM(fps,dir, imTitle);
		dialog2(oriID, dir, imTitle, 3);
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
			getParametersSM(fps,dir, imTitle);
		}
		if(option == 2){
			//oriID = getImageID();
			dialog2(oriID, dir, imTitle, 3);
		}	
	}
}



function crossRedo(temp, option){
	
	//Get the data from the file		
	box = newArray(4);
	dir = temp[0];
	iw = parseInt(temp[1]); ih = parseInt(temp[2]); inS = parseInt(temp[3]); 
	gaus = parseInt(temp[4]);
	imName = temp[5];
	fps = parseInt(temp[7]);
	box[0] = parseInt(temp[9]); box[1] = parseInt(temp[10]); box[2] = parseInt(temp[11]); box[3] = parseInt(temp[12]);
	pw = parseFloat(temp[14]); py = parseFloat(temp[15]);
	count = 17;
	while(temp[count]!= "CrossRegionY")
		count++;
	xp = newArray(count-17);
	yp = newArray(count-17);
	for(i = 0; i < count-17; i++){
		xp[i] = temp[17+i];
		yp[i] = temp[count+1+i];
	}
	jump = 17 + ((count-17)*2) + 1;
	thrMin = parseInt(temp[jump+1]); thrMax = parseInt(temp[jump+2]);
	drkMin = parseInt(temp[jump+4]); drkMax = parseInt(temp[jump+5]);

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
		setThrandAna(thrMin, thrMax, fps);
		
		//Get data of the dectetions
		oriID = getImageID;
		getParametersET(fps, dir, imTitle);
		dialog2(oriID, dir, imTitle, 2);
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
			getParametersET(fps, dir, imTitle);
		}
		if(option == 2){
			//oriID = getImageID();
			dialog2(oriID, dir, imTitle, 2); 
		}	
	}
}



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
		
		if(drkMin!=drkMax)
			darkRPorjection(imName, drkMin,drkMax);

		//setThreshold and Analyse
		setThrandAna(thrMin, thrMax, fps);
		
		//Get data of the dectetions
		getParameters(fps, dir, imName);
		oriID = getImageID();
		dialog2(oriID, dir, imName, 1);
		
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
			getParameters(fps, dir, imName);
		}
		if(option == 2){
			//oriID = getImageID();
			dialog2(oriID, dir, imName, 1);
		}	
		
			
			
	}
}


function setThrandAna(thrMin, thrMax, fps){

		setThreshold(thrMin,thrMax);
	
		roiManager("Show All without labels");
		roiManager("Show None");
		setBatchMode("hide");
		//analyse particles taking in consideration the reduction in fps if selected
		if(fps == 25)
			run("Analyze Particles...", "size=15-Infinity include add stack");
		else{
			
			for(i = 1; i < nSlices; i = i + 100/fps){
				setSlice(i);
				run("Analyze Particles...", "size=15-Infinity include add slice");
			}
		}
		setBatchMode("show");
}

function setBackgrdCo(thr){
		if(thr < 50)
			setBackgroundColor(255, 255, 255);
		else
			setBackgroundColor(0, 0, 0);
			
}


function gausCheckRun(n){
	if(n > 0)
			run("Gaussian Blur...", "sigma="+n+" stack");
}

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
