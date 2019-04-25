package com.moubeat.mazes;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Component;
import java.awt.Dimension;
import java.awt.EventQueue;
import java.awt.Font;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.ItemEvent;
import java.awt.event.ItemListener;
import java.awt.event.KeyEvent;
import java.util.Enumeration;

import javax.swing.AbstractButton;
import javax.swing.BorderFactory;
import javax.swing.Box;
import javax.swing.ButtonGroup;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JCheckBox;
import javax.swing.JComponent;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JProgressBar;
import javax.swing.JRadioButton;
import javax.swing.JTextField;
import javax.swing.SwingConstants;
import javax.swing.border.LineBorder;
import javax.swing.plaf.basic.BasicBorders.RadioButtonBorder;

import ij.IJ;
import ij.ImagePlus;

@SuppressWarnings("serial")
public class EntryGUI extends JPanel implements ActionListener {

	private JPanel menuPane;
	private JLabel menuTitle;
	private JLabel fpsString;
	private JTextField cubeW, cubeH, gausN;
	private ButtonGroup groupFPS;
	private JButton okBtn;
	private JButton okBtn2, okBtn3;
	private JButton label;
	private JCheckBox Vader, Stagger;

	private JPanel otherPane;
	private JLabel otherTitle;
	private JButton backBtn;
	private ImageIcon image;

	private JPanel thirdPane;
	private JButton backBtn2;
	private JTextField iVader, lVader, iStagger, lStagger;

	private ImagePlus img = IJ.getImage();
	static String birdString = "BOW";
	static String catString = "WOB";
	String buttonString = "";
	int fps = 0;

	JLabel picture;

	public EntryGUI() {

		mainMenu();
		otherPanel();
		thirdPanel();
		setSize(400, 400);
		setVisible(true);

	}

	private void mainMenu() {

		int i = 0;
		setPreferredSize(new Dimension(320, 500));
		menuPane = new JPanel();
		menuPane.setLayout(new GridBagLayout());
		// menuPane.setBounds(10, 10, 10, 10);

		GridBagConstraints c = new GridBagConstraints();

		menuTitle = new JLabel("Please select the parameters of the analysis");
		menuTitle.setForeground(Color.BLUE);
		menuTitle.setFont(new Font("Serif", Font.ITALIC, 18));
		c.gridx = 0;
		c.gridwidth = 4;
		c.gridy = i;
		c.insets = new Insets(0, 0, 20, 0);
		c.anchor = GridBagConstraints.CENTER;
		menuPane.add(menuTitle, c);

		ButtonGroup group = new ButtonGroup();
		setBorder(BorderFactory.createEmptyBorder(20, 20, 20, 20));

		Box grpHBox = Box.createHorizontalBox();
		grpHBox.setAlignmentX(JComponent.CENTER_ALIGNMENT);
		Box grpVBox = Box.createVerticalBox();

		// Create the radio buttons.
		JRadioButton bowButton = new JRadioButton("Black Over White");
		bowButton.setMnemonic(KeyEvent.VK_B);
		bowButton.setActionCommand(birdString);
		bowButton.setSelected(true);
		bowButton.addActionListener(new ActionListener() {

			@Override
			public void actionPerformed(ActionEvent e) {
				picture.setIcon(createImageIcon("/icons/" + e.getActionCommand() + ".png"));
				buttonString = e.getActionCommand();

			}
		});
		grpVBox.add(bowButton);
		group.add(bowButton);

		JRadioButton wobButton = new JRadioButton("White Over Black");
		wobButton.setMnemonic(KeyEvent.VK_C);
		wobButton.setActionCommand(catString);
		wobButton.addActionListener(new ActionListener() {

			@Override
			public void actionPerformed(ActionEvent e) {
				picture.setIcon(createImageIcon("/icons/" + e.getActionCommand() + ".png"));
				buttonString = e.getActionCommand();

			}

		});
		grpVBox.add(wobButton);
		group.add(wobButton);

		// Set up the picture label.
		picture = new JLabel(createImageIcon("/icons/" + birdString + ".png"));
		picture.setPreferredSize(new Dimension(177, 122));
		grpHBox.add(grpVBox);
		grpHBox.add(picture);
		c.gridx = 0;
		c.gridwidth = 4;
		c.gridy = 1;
		c.gridheight = 2;
		c.anchor = GridBagConstraints.CENTER;
		menuPane.add(grpHBox, c);

		// Take care of the fps choice
		Box fpsHBox = Box.createHorizontalBox();

		fpsString = new JLabel("Reduce time resolution of analysis (25 is all frames)");
		c.gridx = 0;
		c.gridy = 3;
		c.anchor = GridBagConstraints.WEST;
		menuPane.add(fpsString, c);

		groupFPS = new ButtonGroup();
		setBorder(BorderFactory.createEmptyBorder(20, 20, 20, 20));

		JRadioButton fps25 = new JRadioButton("25");
		fps25.setSelected(true);
		fps25.addActionListener(new ActionListener() {

			@Override
			public void actionPerformed(ActionEvent e) {
				fps = 25;

			}

		});
		fpsHBox.add(fps25);
		groupFPS.add(fps25);

		JRadioButton fps20 = new JRadioButton("20");
		fps20.addActionListener(new ActionListener() {

			@Override
			public void actionPerformed(ActionEvent e) {
				fps = 20;

			}

		});
		fpsHBox.add(fps20);
		groupFPS.add(fps20);

		JRadioButton fps15 = new JRadioButton("15");
		fps15.addActionListener(new ActionListener() {

			@Override
			public void actionPerformed(ActionEvent e) {
				fps = 15;

			}

		});
		fpsHBox.add(fps15);
		groupFPS.add(fps15);

		JRadioButton fps10 = new JRadioButton("10");
		fps10.addActionListener(new ActionListener() {

			@Override
			public void actionPerformed(ActionEvent e) {
				fps = 10;

			}

		});
		fpsHBox.add(fps10);
		groupFPS.add(fps10);

		JRadioButton fps5 = new JRadioButton("5");
		fps10.addActionListener(new ActionListener() {

			@Override
			public void actionPerformed(ActionEvent e) {
				fps = 5;

			}

		});
		fpsHBox.add(fps5);
		groupFPS.add(fps5);

		c.gridx = 0;
		c.gridy = 4;
		c.insets = new Insets(20, 0, 0, 0);
		c.gridheight = 2;
		c.anchor = GridBagConstraints.WEST;
		menuPane.add(fpsHBox, c);

		// Dimensions choices
		// WIDTH
		JLabel dimension = new JLabel("Dimension of the cage base");
		c.gridx = 0;
		c.gridy = 5;
		c.gridwidth = 4;
		c.anchor = GridBagConstraints.WEST;
		menuPane.add(dimension, c);

		JLabel cubeWL = new JLabel("Cube width (in units):");
		c.gridx = 0;
		c.gridy = 6;
		c.anchor = GridBagConstraints.WEST;
		c.insets = new Insets(30, 0, 0, 0);
		menuPane.add(cubeWL, c);

		cubeW = new JTextField();
		cubeW.setText("28");
		cubeW.setHorizontalAlignment(SwingConstants.RIGHT);
		cubeW.setColumns(10);
		c.gridx = 1;
		c.gridy = 6;
		c.anchor = GridBagConstraints.EAST;
		c.insets = new Insets(30, 0, 0, 0);
		menuPane.add(cubeW, c);
		// HEIGHT
		JLabel cubeHL = new JLabel("Cube height (in units):");
		c.gridx = 0;
		c.gridy = 7;
		c.anchor = GridBagConstraints.WEST;
		c.insets = new Insets(20, 0, 0, 0);
		menuPane.add(cubeHL, c);

		cubeH = new JTextField();
		cubeH.setText("28");
		cubeH.setHorizontalAlignment(SwingConstants.RIGHT);
		cubeH.setColumns(10);
		c.gridx = 1;
		c.gridy = 7;
		c.anchor = GridBagConstraints.EAST;
		c.insets = new Insets(20, 0, 0, 0);
		menuPane.add(cubeH, c);

		// Processing choices
		c.gridx = 0;
		c.gridy = 8;
		c.anchor = GridBagConstraints.WEST;
		menuPane.add(Box.createVerticalStrut(20), c);
		JLabel proc = new JLabel("Image processing choices:");
		proc.setForeground(Color.BLUE);
		c.gridx = 0;
		c.gridy = 9;
		c.gridwidth = 4;
		c.anchor = GridBagConstraints.WEST;
		menuPane.add(proc, c);

		// Gaussian blur
		JLabel gausL = new JLabel("Gaussian blur sigma to apply (0 not to):");
		c.gridx = 0;
		c.gridy = 10;
		c.anchor = GridBagConstraints.WEST;
		menuPane.add(gausL, c);

		gausN = new JTextField();
		gausN.setText("2");
		gausN.setHorizontalAlignment(SwingConstants.RIGHT);
		gausN.setColumns(2);
		c.gridx = 1;
		c.gridy = 10;
		c.anchor = GridBagConstraints.EAST;
		c.insets = new Insets(20, 0, 0, 0);
		menuPane.add(gausN, c);

		// dark Vader stuff
		Vader = new JCheckBox("Apply background and noise removal");
		Vader.setSelected(true);
		c.gridx = 0;
		c.gridy = 11;
		c.anchor = GridBagConstraints.WEST;
		c.insets = new Insets(30, 0, 0, 0);
		Vader.addItemListener(new ItemListener() {
			@Override
			public void itemStateChanged(ItemEvent e) {
				iVader.setEnabled(e.getStateChange() == ItemEvent.SELECTED);
				lVader.setEnabled(e.getStateChange() == ItemEvent.SELECTED);
			}
		});
		menuPane.add(Vader, c);

		// stagger stuff
		Stagger = new JCheckBox("Choose start/end of ROI analysis?");
		Stagger.setSelected(true);
		c.gridx = 0;
		c.gridy = 12;
		c.anchor = GridBagConstraints.WEST;
		c.insets = new Insets(30, 0, 0, 0);
		Stagger.addItemListener(new ItemListener() {
			@Override
			public void itemStateChanged(ItemEvent e) {
				iStagger.setEnabled(e.getStateChange() == ItemEvent.SELECTED);
				lStagger.setEnabled(e.getStateChange() == ItemEvent.SELECTED);

			}
		});
		menuPane.add(Stagger, c);

		JButton helpBtn = new JButton("Help");
		helpBtn.addActionListener(new ActionListener() {

			@Override
			public void actionPerformed(ActionEvent e) {
				OpenPageInDefaultBrowser();

			}

		});
		c.gridx = 0;
		c.gridy = 14;
		c.ipadx = 45;
		c.insets = new Insets(20, 0, 0, 0);
		c.anchor = GridBagConstraints.WEST;
		menuPane.add(helpBtn, c);

		JButton cancelBtn = new JButton("Cancel");
		cancelBtn.addActionListener(new ActionListener() {

			@Override
			public void actionPerformed(ActionEvent e) {
				dispose();

			}

		});
		c.gridx = 0;
		c.gridy = 14;
		c.ipadx = 45;
		c.insets = new Insets(20, 0, 0, 0);
		c.anchor = GridBagConstraints.CENTER;
		menuPane.add(cancelBtn, c);

		okBtn = new JButton(" OK ");
		okBtn.addActionListener(this);
		c.gridx = 0;
		c.gridy = 14;
		c.ipadx = 45;
		c.insets = new Insets(20, 0, 0, 0);
		c.anchor = GridBagConstraints.EAST;
		menuPane.add(okBtn, c);

		add(menuPane, BorderLayout.CENTER);
	}

	private void otherPanel() {

		setPreferredSize(new Dimension(320, 501));
		otherPane = new JPanel(new GridBagLayout());
		GridBagConstraints c = new GridBagConstraints();

		otherTitle = new JLabel("Open Field Analysis");
		c.gridx = 0;
		c.gridy = 0;
		c.insets = new Insets(0, 0, 20, 0);
		otherPane.add(otherTitle, c);

		JLabel message = new JLabel(
				"<html><center>Please draw a rectangle to match the field base.<br> Click on the image below for example.</center></html>");
		message.setAlignmentX(Component.CENTER_ALIGNMENT);
		c.gridx = 0;
		c.gridy = 1;
		c.insets = new Insets(10, 0, 0, 0);
		otherPane.add(message, c);

		image = new ImageIcon(SuperGUI.class.getResource("/icons/rectBase1.gif"));
		label = new JButton(image);
		label.setText("Click me to rewind...");
		label.setBorderPainted(false);
		label.addActionListener(this);
		label.setPreferredSize(new Dimension(300, 300));
		c.gridx = 0;
		c.gridy = 2;
		c.anchor = GridBagConstraints.CENTER;
		otherPane.add(label, c);

		JProgressBar progressBar = new JProgressBar(0, 100);
		progressBar.setValue(20);
		progressBar.setStringPainted(true);

		c.gridx = 0;
		c.gridy = 12;
		c.insets = new Insets(20, 0, 0, 0);
		c.anchor = GridBagConstraints.CENTER;
		otherPane.add(progressBar, c);

		backBtn = new JButton("Back");
		backBtn.addActionListener(this);
		c.gridx = 0;
		c.gridy = 14;
		c.ipadx = 35;
		c.insets = new Insets(20, 0, 0, 0);
		c.anchor = GridBagConstraints.WEST;
		otherPane.add(backBtn, c);

		JButton cancelBtn2 = new JButton("Cancel");
		cancelBtn2.addActionListener(new ActionListener() {

			@Override
			public void actionPerformed(ActionEvent e) {
				dispose();

			}

		});
		c.gridx = 0;
		c.gridy = 14;
		c.ipadx = 35;
		c.insets = new Insets(20, 0, 0, 0);
		c.anchor = GridBagConstraints.CENTER;
		otherPane.add(cancelBtn2, c);

		okBtn2 = new JButton("  OK  ");
		okBtn2.addActionListener(this);
		c.gridx = 0;
		c.gridy = 14;
		c.ipadx = 35;
		c.insets = new Insets(20, 0, 0, 0);
		c.anchor = GridBagConstraints.EAST;
		otherPane.add(okBtn2, c);

	}

	private void thirdPanel() {

		setPreferredSize(new Dimension(320, 501));
		thirdPane = new JPanel();
		thirdPane.setLayout(new GridBagLayout());
		GridBagConstraints c = new GridBagConstraints();

		JLabel thirdTitle = new JLabel("Open Field Analysis");
		c.gridx = 0;
		c.gridy = 0;
		c.insets = new Insets(0, 0, 20, 0);
		thirdPane.add(thirdTitle, c);

		JLabel message2 = new JLabel("<html><center>Please choose the following parameters.</center></html>");
		message2.setAlignmentX(Component.CENTER_ALIGNMENT);
		c.gridx = 0;
		c.gridy = 1;
		c.insets = new Insets(10, 0, 0, 0);
		thirdPane.add(message2, c);

		JLabel VadderL = new JLabel("Please fill in frames to average:");
		c.gridx = 0;
		c.gridy = 2;
		c.anchor = GridBagConstraints.CENTER;
		thirdPane.add(VadderL, c);

		JLabel iVaderL = new JLabel("First frame: ");
		c.gridx = 0;
		c.gridy = 3;
		c.anchor = GridBagConstraints.WEST;
		thirdPane.add(iVaderL, c);

		iVader = new JTextField();
		iVader.setText("1");
		iVader.setHorizontalAlignment(SwingConstants.RIGHT);
		iVader.setColumns(10);
		c.gridx = 0;
		c.gridy = 3;
		c.anchor = GridBagConstraints.EAST;
		thirdPane.add(iVader, c);

		JLabel lVaderL = new JLabel("Last frame: ");
		c.gridx = 0;
		c.gridy = 4;
		c.anchor = GridBagConstraints.WEST;
		thirdPane.add(lVaderL, c);

		lVader = new JTextField();
		lVader.setText(Integer.toString(img.getNSlices()));
		lVader.setHorizontalAlignment(SwingConstants.RIGHT);
		lVader.setColumns(10);
		c.gridx = 0;
		c.gridy = 4;
		c.anchor = GridBagConstraints.EAST;
		thirdPane.add(lVader, c);

		JLabel StagL = new JLabel("Please fill in frames to analyse:");
		c.gridx = 0;
		c.gridy = 5;
		c.anchor = GridBagConstraints.CENTER;
		thirdPane.add(StagL, c);

		JLabel iStaggerL = new JLabel("First frame: ");
		c.gridx = 0;
		c.gridy = 6;
		c.anchor = GridBagConstraints.WEST;
		thirdPane.add(iStaggerL, c);

		iStagger = new JTextField();
		iStagger.setText("1");
		iStagger.setHorizontalAlignment(SwingConstants.RIGHT);
		iStagger.setColumns(10);
		c.gridx = 0;
		c.gridy = 6;
		c.anchor = GridBagConstraints.EAST;
		thirdPane.add(iStagger, c);

		JLabel lStaggerL = new JLabel("Last frame: ");
		c.gridx = 0;
		c.gridy = 7;
		c.anchor = GridBagConstraints.WEST;
		thirdPane.add(lStaggerL, c);

		lStagger = new JTextField();
		lStagger.setText(Integer.toString(img.getNSlices()));
		lStagger.setHorizontalAlignment(SwingConstants.RIGHT);
		lStagger.setColumns(10);
		c.gridx = 0;
		c.gridy = 7;
		c.anchor = GridBagConstraints.EAST;
		thirdPane.add(lStagger, c);

		JProgressBar progressBar = new JProgressBar(0, 100);
		progressBar.setValue(40);
		progressBar.setStringPainted(true);
		c.gridx = 0;
		c.gridy = 12;
		c.insets = new Insets(20, 0, 0, 0);
		c.anchor = GridBagConstraints.CENTER;
		thirdPane.add(progressBar, c);

		Box box = Box.createHorizontalBox();
		box.setPreferredSize(new Dimension(300, 20));
		c.gridx = 0;
		c.gridy = 13;
		c.insets = new Insets(20, 0, 0, 0);
		c.anchor = GridBagConstraints.CENTER;
		thirdPane.add(box, c);

		backBtn2 = new JButton("Back");
		backBtn2.addActionListener(this);
		c.gridx = 0;
		c.gridy = 14;
		c.ipadx = 35;
		c.insets = new Insets(20, 0, 0, 0);
		c.anchor = GridBagConstraints.WEST;
		thirdPane.add(backBtn2, c);

		JButton cancelBtn3 = new JButton("Cancel");
		cancelBtn3.addActionListener(new ActionListener() {

			@Override
			public void actionPerformed(ActionEvent e) {
				dispose();

			}

		});
		c.gridx = 0;
		c.gridy = 14;
		c.ipadx = 35;
		c.insets = new Insets(20, 0, 0, 0);
		c.anchor = GridBagConstraints.CENTER;
		thirdPane.add(cancelBtn3, c);

		okBtn3 = new JButton(" OK ");
		okBtn3.addActionListener(this);
		c.gridx = 0;
		c.gridy = 14;
		c.ipadx = 40;
		c.insets = new Insets(20, 0, 0, 0);
		c.anchor = GridBagConstraints.EAST;
		thirdPane.add(okBtn3, c);

	}

	public void actionPerformed(ActionEvent event) {

		if (event.getSource() == okBtn) {
			parameT.getInstance().setOptions(buttonString, Vader.isSelected(), Stagger.isSelected(),
					Integer.parseInt(cubeW.getText()), Integer.parseInt(cubeH.getText()),
					Integer.parseInt(gausN.getText()), setFPS());
			remove(menuPane);
			add(otherPane);
			validate();
			repaint();

		} else if (event.getSource() == backBtn) {
			remove(otherPane);
			add(menuPane);
			validate();
			repaint();
		} else if (event.getSource() == okBtn2) {
			if (img.getRoi() != null) {
				parameT.getInstance().setRect(img.getRoi());
				
				remove(otherPane);
				add(thirdPane);
				validate();
				repaint();
			} else {

				label.setBorder(new LineBorder(Color.RED));
				label.setBorderPainted(true);
				validate();
				repaint();
			}

		} else if (event.getSource() == label) {
			image.getImage().flush();

		} else if (event.getSource() == backBtn2) {
			remove(thirdPane);
			add(otherPane);
			validate();
			repaint();
		} else if (event.getSource() == okBtn3) {
			parameT.getInstance().setFrames(Integer.parseInt(iVader.getText()), Integer.parseInt(lVader.getText()),
					Integer.parseInt(iStagger.getText()), Integer.parseInt(lStagger.getText()));
			dispose();
			InitiaterListener.getInstance().spreadMessage();
		}
	}

	private int setFPS() {
		for (Enumeration<AbstractButton> buttons = groupFPS.getElements(); buttons.hasMoreElements();) {
			AbstractButton button = buttons.nextElement();

			if (button.isSelected()) {
				return Integer.parseInt(button.getText());
			}
		}

		return 0;
	}

	protected void dispose() {
		JFrame parent = (JFrame) this.getTopLevelAncestor();
		parent.dispose();

	}

	/// file OpenPageInDefaultBrowser.java
	public void OpenPageInDefaultBrowser() {

		try {
			// Set your page url in this string. For eg, I m using URL for Google Search
			// engine
			String url = "http://www.google.com";
			java.awt.Desktop.getDesktop().browse(java.net.URI.create(url));
		} catch (java.io.IOException e) {
			System.out.println(e.getMessage());
		}
	}

	/** Returns an ImageIcon, or null if the path was invalid. */
	protected static ImageIcon createImageIcon(String path) {
		java.net.URL imgURL = RadioButtonBorder.class.getResource(path);
		if (imgURL != null) {
			return new ImageIcon(imgURL);
		} else {
			System.err.println("Couldn't find file: " + path);
			return null;
		}
	}

	public static void main(String[] args) {
		EventQueue.invokeLater(() -> new EntryGUI());
	}
}