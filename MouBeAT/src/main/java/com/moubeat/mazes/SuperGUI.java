package com.moubeat.mazes;

/*
 * THis class works as a super class to the GUI windows
 * From here the different frames are created and populated
 */

import java.awt.EventQueue;
import java.awt.Point;
import java.awt.Rectangle;
import java.util.ArrayList;

import javax.swing.JFrame;
import ij.WindowManager;
import ij.gui.PointRoi;
import java.awt.Component;
import java.awt.Dimension;

@SuppressWarnings("serial")
public class SuperGUI extends JFrame {

	private JFrame frame;
	

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {

		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					SuperGUI window = new SuperGUI();
					window.frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	/**
	 * Create the application for the insertion of parameters
	 */
	public SuperGUI() {
		initialize();

	}

	/*
	 * Create the application for the table of results from
	 * point detection
	 */
	public SuperGUI(int[] sList) {
		initialize2(sList);

	}

	/**
	 * Initialize the contents of the frame for the insertion of the 
	 * initial parameters. Calls EntryGUI class
	 */
	private void initialize() {
		Component wm = WindowManager.getActiveWindow();
		Rectangle test = wm.getBounds();
		Point pt = new Point((int) test.getMaxX(), (int) test.getMinY());

		frame = new JFrame("Welcome to MouBeAT");
		frame.setBounds(100, 100, 450, 300);
		frame.setDefaultCloseOperation(JFrame.HIDE_ON_CLOSE);
		frame.setPreferredSize(new Dimension(400, 550));
		frame.setLocation(pt);

		EntryGUI card1 = new EntryGUI();
		frame.pack();
		frame.add(card1);

		frame.setVisible(true);

	}

	/**
	 * Initialize the contents of the frame for display of coordinates
	 * Calls ListDialog class
	 */
	private void initialize2(int[] sList) {
		Component wm = WindowManager.getActiveWindow();
		Rectangle test = wm.getBounds();
		Point pt = new Point((int) test.getMaxX(), (int) test.getMinY());
		
		// Create and set up the window.
		JFrame frame = new JFrame("Results");
		frame.setDefaultCloseOperation(JFrame.HIDE_ON_CLOSE);
		frame.setLocation(pt);

		// Create and set up the content pane.
		ListDialog newContentPane = new ListDialog(sList);
		newContentPane.setOpaque(true); // content panes must be opaque
		frame.setContentPane(newContentPane);

		// Display the window.
		frame.pack();
		frame.setVisible(true);
	}

}
