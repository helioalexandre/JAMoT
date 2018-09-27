package com.cellcounterutil;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Component;
import java.awt.Dimension;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.swing.JButton;
import javax.swing.JCheckBox;
import javax.swing.JColorChooser;
import javax.swing.JFileChooser;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;
import javax.swing.plaf.ButtonUI;
import javax.xml.parsers.ParserConfigurationException;

import org.scijava.util.XML;
import org.w3c.dom.Element;
import org.xml.sax.SAXException;

import ij.IJ;
import ij.ImagePlus;
import ij.gui.*;
import javax.swing.plaf.basic.BasicButtonUI;

@SuppressWarnings("serial")
public class GuiFrame extends JPanel implements ActionListener, ChangeListener {

	private JPanel mainPanel;
	private XML f = null;
	private int[] count = new int[9];
	private HashMap<String, JButton> mapb = new HashMap<String, JButton>();
	private HashMap<String, JCheckBox> mapc = new HashMap<String, JCheckBox>();
	private HashMap<String, JTextField> mapt = new HashMap<String, JTextField>();
	private HashMap<String, Overlay> mapover = new HashMap<String, Overlay>();
	private ImagePlus img1;
	private Overlay over = new Overlay();
	private Component[] comps;

	public GuiFrame() {

		if (ij.WindowManager.getImageCount() > 0) {
			img1 = IJ.getImage();
		} else {
			new NewImage();
			img1 = IJ.getImage();
		}
		img1.show();
		img1.setOverlay(over);

		setSize(400, 400);
		setVisible(true);

		for (int i = 0; i < 8; i++) {
			String g = "Color " + (i + 1);
			String co = "Group " + (i + 1);
			String te = "Text " + (i + 1);
			String ov = "Over" + (i + 1);

			mapb.put(g, new JButton(g));
			mapc.put(co, new JCheckBox(co));
			mapt.put(te, new JTextField(6));
			mapover.put(ov, new Overlay());

		}

		setPreferredSize(new Dimension(320, 500));
		mainPanel = new JPanel();
		mainPanel.setLayout(new GridBagLayout());

		// Create constrains
		GridBagConstraints c = new GridBagConstraints();

		JLabel npoints = new JLabel("N. Points");
		c.gridx = 1;
		c.gridy = 0;
		c.anchor = GridBagConstraints.CENTER;
		mainPanel.add(npoints, c);

		JLabel mapTitle = new JLabel("Colors");
		c.gridx = 2;
		c.gridy = 0;
		c.anchor = GridBagConstraints.CENTER;
		mainPanel.add(mapTitle, c);

		for (int i = 0; i < 8; i++) {
			String g = "Color " + (i + 1);
			String co = "Group " + (i + 1);
			String te = "Text " + (i + 1);

			// mapc.get(co).addActionListener(listenerCB);
			c.gridx = 0;
			c.gridy = i + 1;
			c.anchor = GridBagConstraints.CENTER;
			mainPanel.add(mapc.get(co), c);

			if (count[i] > 0) {
				mapt.get(te).setText(Integer.toString(count[i]));
				mapt.get(te).setEditable(false);
				c.gridx = 1;
				c.gridy = i + 1;
				c.anchor = GridBagConstraints.CENTER;
				mainPanel.add(mapt.get(te), c);
			} else {
				mapt.get(te).setText("NA");
				mapt.get(te).setEditable(false);
				c.gridx = 1;
				c.gridy = i + 1;
				c.anchor = GridBagConstraints.CENTER;
				mainPanel.add(mapt.get(te), c);
			}

			mapb.get(g).setUI((ButtonUI) BasicButtonUI.createUI(mapb.get(g)));
			mapb.get(g).setBackground(Color.CYAN);
			mapb.get(g).addActionListener(listener);
			c.gridx = 2;
			c.gridy = i + 1;
			c.anchor = GridBagConstraints.CENTER;
			mainPanel.add(mapb.get(g), c);

		}

		JButton open = new JButton("Open file");
		open.addActionListener(new ActionListener() {

			@Override
			public void actionPerformed(ActionEvent e) {
				JFileChooser fc = new JFileChooser();
				fc.setFileSelectionMode(JFileChooser.FILES_ONLY);
				fc.showDialog(fc, "Select XML file");
				try {
					f = new XML(fc.getSelectedFile());
				} catch (ParserConfigurationException e2) {
					// TODO Auto-generated catch block
					e2.printStackTrace();
				} catch (SAXException e2) {
					// TODO Auto-generated catch block
					e2.printStackTrace();
				} catch (IOException e2) {
					// TODO Auto-generated catch block
					e2.printStackTrace();
				}

				for (int i = 0; i < 8; i++) {
					count[i] = f
							.elements("/CellCounter_Marker_File/Marker_Data/Marker_Type[Type='" + (i + 1) + "']/Marker")
							.size();
					String te = "Text " + (i + 1);
					mapt.get(te).setText(Integer.toString(count[i]));
					mapt.get(te).setEditable(false);
					mapt.get(te).repaint();
					if (count[i] == 0) {
						mapt.get(te).setEnabled(false);
						String co = "Group " + (i + 1);
						mapc.get(co).setEnabled(false);
						mapc.get(co).repaint();
						String g = "Color " + (i + 1);
						mapb.get(g).setEnabled(false);
					} else {
						drawOverlay(i);
					}

				}

			}

		});
		c.gridx = 0;
		c.gridy = 9;
		c.anchor = GridBagConstraints.CENTER;
		mainPanel.add(open, c);

		JButton pre = new JButton("Preview");
		pre.addActionListener(listenerCB);
		c.gridx = 1;
		c.gridy = 9;
		c.anchor = GridBagConstraints.CENTER;
		mainPanel.add(pre, c);

		JButton draw = new JButton("In-Draw");
		draw.addActionListener(new ActionListener() {

			@Override
			public void actionPerformed(ActionEvent e) {
				AddToOverlay();
				IJ.run("Show Overlay");
				IJ.run("Flatten");
			}

		});
		c.gridx = 2;
		c.gridy = 9;
		c.anchor = GridBagConstraints.CENTER;
		mainPanel.add(draw, c);
		
		JButton done = new JButton("Done");
		done.addActionListener(new ActionListener() {

			@Override
			public void actionPerformed(ActionEvent e) {
				JFrame parent = (JFrame) mainPanel.getTopLevelAncestor();
				parent.dispose();

				}

		});
		c.gridx = 0;
		c.gridy = 10;
		c.gridwidth = 4;
		c.fill = GridBagConstraints.HORIZONTAL;
		c.anchor = GridBagConstraints.CENTER;
		mainPanel.add(done, c);

		add(mainPanel, BorderLayout.CENTER);
		comps = mainPanel.getComponents();
	}

	ActionListener listener = new ActionListener() {
		@Override
		public void actionPerformed(ActionEvent e) {
			Color newcolor = JColorChooser.showDialog(null, "Choose a color", Color.white);
			JButton source = (JButton) e.getSource();
			source.setBackground(newcolor);
			String temp = source.getText().substring(source.getText().length() - 1, source.getText().length());

			mapover.get("Over" + temp).setLabelColor(newcolor);

		}
	};

	ActionListener listenerCB = new ActionListener() {
		@Override
		public void actionPerformed(ActionEvent e) {
			over.clear();
			AddToOverlay();
			IJ.run("Show Overlay");
		}

	};

	@Override
	public void stateChanged(ChangeEvent e) {
		// TODO Auto-generated method stub

	}

	@Override
	public void actionPerformed(ActionEvent e) {
		// TODO Auto-generated method stub

	}

	private void AddToOverlay() {
		for (Component comp : comps) {
			if (comp instanceof JCheckBox) {
				JCheckBox source = (JCheckBox) comp;
				if (source.isSelected()) {
					String src = source.getText().substring(source.getText().length() - 1, source.getText().length());
					Roi[] rois = mapover.get("Over" + src).toArray();
					for (Roi r : rois) {
						r.setFillColor(mapover.get("Over" + src).getLabelColor());
						over.add(r);
					}
				}
			}
		}
	}

	private void drawOverlay(int n) {
		String ov = "Over" + (n + 1);

		ArrayList<Element> nodesx = f
				.elements("/CellCounter_Marker_File/Marker_Data/Marker_Type[Type='" + (n + 1) + "']/Marker/MarkerX");
		ArrayList<Element> nodesy = f
				.elements("/CellCounter_Marker_File/Marker_Data/Marker_Type[Type='" + (n + 1) + "']/Marker/MarkerY");

		for (int j = 0; j < nodesx.size(); j++)
			mapover.get(ov).add(new OvalRoi(Integer.parseInt(nodesx.get(j).getTextContent()) - 4,
					Integer.parseInt(nodesy.get(j).getTextContent()) - 4, 8, 8));
	}

}
