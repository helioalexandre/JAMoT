package com.moubeat.mazes;

import ij.gui.Roi;

public final class parameT{
	

	private String choiceRadioH;	
	private float width;	
	private float height;
	private float sigma;
	private int fps;
	private boolean dVader;
	private boolean stg;
	private Roi rect;
	private Roi centerRect;
	private int[] aVader = new int[2];
	private int[] stag = new int[2];
	
	private static final parameT INSTANCE = new parameT();
	
	private parameT() {
	
	}
	
	public static parameT getInstance() {
        return INSTANCE;
    }
	
	public void setparameT(parameT p) {
		this.choiceRadioH = p.choiceRadioH;
		this.width = p.width;
		this.height = p.height;
		this.sigma = p.sigma;
		this.fps = p.fps;
		this.dVader = p.dVader;
		this.stg = p.stg;
		this.rect = p.rect;
		this.centerRect = p.centerRect;
		this.aVader = p.aVader;
		this.stag = p.stag;
	}
	
	public void setOptions(String str, boolean v, boolean s, int  w, int h, int g, int f) {
		choiceRadioH = str;
		dVader = v;
		stg = s;
		width = w;
		height = h;
		sigma = g;
		fps = f;
		
	}
	
	public void setRect(Roi temp) { 
		rect = temp;
		double partx = rect.getFloatWidth() / 5;
		double party = rect.getFloatHeight() / 5;
		centerRect = new Roi((rect.getXBase()+partx), (rect.getYBase()+party), rect.getFloatWidth()-partx, rect.getFloatHeight()-party);
		System.out.println(rect.getXBase());
	}
	
	
	public void setFrames(int iv, int lv, int is, int ls) {
		aVader[0] = iv;
		aVader[1] = lv;
		stag[0] = is;
		stag[1] = ls;
	}
	
	public String getChoice() {	return choiceRadioH;}
	public boolean getVader() {return dVader;}
	public boolean getStagger() {return stg;}
	public float getW() {return width;}
	public float getH() {return height;}
	public float getSigma() { return sigma;}
	public int getFPS() { return fps;}
	public Roi getRect() { return rect;}
	
	public int[] getVaderCoor() { return aVader;}
	public int[] getStagCoor() { return stag; }
	
	
	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		
		
	}



}
