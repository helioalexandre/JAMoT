package com.cellcounterutil;

import java.awt.EventQueue;
import javax.swing.JFrame;
import ij.ImageJ;
import java.awt.Dimension;

@SuppressWarnings("serial")
public class GuiApp extends JFrame {

	private JFrame frame;

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {

		// start ImageJ
		new ImageJ();

		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					GuiApp window = new GuiApp();
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
	public GuiApp() {
		initialize();

	}

	/**
	 * Initialize the contents of the frame for the insertion of the initial
	 * parameters. Calls EntryGUI class
	 */
	private void initialize() {
		frame = new JFrame("Cell Counter Utility");
		frame.setBounds(100, 100, 450, 300);
		frame.setDefaultCloseOperation(JFrame.HIDE_ON_CLOSE);
		frame.setPreferredSize(new Dimension(300, 400));
		// frame.setLocation(pt);

		GuiFrame card1 = new GuiFrame();
		frame.pack();
		frame.add(card1);

		frame.setVisible(true);

	}

}
