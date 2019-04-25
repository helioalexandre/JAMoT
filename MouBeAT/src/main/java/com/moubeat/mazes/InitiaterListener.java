/*
 * https://stackoverflow.com/a/6270150/3675925
 */
package com.moubeat.mazes;

import java.util.*;

public class InitiaterListener {
	private List<Listener> listeners = new ArrayList<Listener>();
	
	private static final InitiaterListener INSTANCE = new InitiaterListener();
	
	private InitiaterListener() {
		
	}
	
	public static InitiaterListener getInstance() {
        return INSTANCE;
    }
	
	public void addListener(Listener toAdd) {
		System.out.println("Well lets see...");
		listeners.add(toAdd);
	}
	
	public void spreadMessage() {
		System.out.println("I said hello...");
		for(Listener ls : listeners)
			ls.changeeFlag();
	}
		
}
