macro"Open Previous Analysis"{

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
			tyRedo(temp, option);
		}else if(endsWith(filename, ".objects.trac")){
			option = repeatAnalysisDialog();
			objectsRedo(temp, option);
		}else if(endsWith(filename, ".swim.trac")){
			option = repeatAnalysisDialog();
			swimRedo(temp, option);
		}else if(endsWith(filename, ".cross.trac")){
			option = repeatAnalysisDialog();
			type = 4;
		}else
			exit("Could not identify the type of analysis of this trac file");
	}else
		print("This file " + file + " does not appear to be a valid JAMoT file.");
	
			

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
		/*oriID = getImageID;
		getParametersSM(fps,dir, imTitle);
		dialog2(oriID, dir, imTitle, 3);*/
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
			//getParametersSM(fps,dir, imTitle);
		}
		if(option == 2){
			//oriID = getImageID();
			//dialog2(oriID, dir, imTitle, 3);
		}	
	}
}



function tyRedo(temp, option){
	
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
		//oriID = getImageID;
		//getParametersET(fps, dir, imTitle);
		//dialog2(oriID, dir, imTitle, 2);
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
			//getParametersET(fps, dir, imTitle);
		}
		if(option == 2){
			//oriID = getImageID();
			//dialog2(oriID, dir, imTitle, 2); 
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
		//getParameters(fps, dir, imName);
		//oriID = getImageID();
		//dialog2(oriID, dir, imName, 1);
		
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
			//getParameters(fps, dir, imName);
		}
		if(option == 2){
			//oriID = getImageID();
			//dialog2(oriID, dir, imName, 1);
		}	
		
			
			
	}
}


function setThrandAna(thrMin, thrMax, fps){

		setThreshold(thrMin,thrMax);
	
		roiManager("Show All without labels");
		roiManager("Show None");
		
		//analyse particles taking in consideration the reduction in fps if selected
		if(fps == 25)
			run("Analyze Particles...", "size=15-Infinity include add stack");
		else{
			
			for(i = 1; i < nSlices; i = i + 100/fps){
				setSlice(i);
				run("Analyze Particles...", "size=15-Infinity include add slice");
			}
		}
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
