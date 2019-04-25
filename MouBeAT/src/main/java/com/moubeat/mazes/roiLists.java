package com.moubeat.mazes;

import java.util.ArrayList;

import ij.gui.PointRoi;
import ij.gui.Roi;

public final class roiLists {
	
	//Create list of ROIs of the selections
	private ArrayList<Roi> roiList = new ArrayList<Roi>();
	private ArrayList<Roi> roiList2 = new ArrayList<Roi>();
	//Create an arrayList of points to hold the center, head and tail of the mouse
	ArrayList<PointRoi> pointList = new ArrayList<PointRoi>();
	
	private static final roiLists INSTANCE = new roiLists();
	
	private roiLists() {
	
	}
	
	public static roiLists getInstance() {
        return INSTANCE;
    }
	
	public ArrayList<Roi> getRoiList(boolean option){
		if(option)
			return roiList;
		else
			return roiList2;
	}
	
	public ArrayList<PointRoi> getPointList(){
		return pointList;
	}
	
	public void addRoi(Roi r, boolean option) {
		if(option)
			roiList.add(r);
		else
			roiList2.add(r);
	}
	
	public void addPoint(PointRoi e) {
		pointList.add(e);
	}
	
	public void updateRoi(int i, Roi r, boolean option) {
		if(option)
			roiList.set(i, r);
		else
			roiList2.set(i, r);
	}
	
	public Roi getRoi(int i, boolean option) {
		Roi r;
		if(option)
			r = roiList.get(i);
		else
			r = roiList2.get(i);
		
		return r;
	}
	
	public PointRoi getPRoi(int i) {
		PointRoi r;
		r = pointList.get(i);
		
		return r;
	}
	
	public int getSize(int option) {
		int temp = 0;
		switch (option) {
			case 0: temp = roiList.size();
				break;
			case 1: temp = roiList2.size();
				break;
			case 2: temp = pointList.size();
				break;
		}
		
		return temp;
		
	}
	
	public void updateRoi(int i, PointRoi r) {
		pointList.set(i, r);
	}
	

	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
