package com.moubeat.mazes;

/*
 * Class to display and provide a possibility to update the positions of the head of the mouse and tail
 */

import javax.swing.AbstractAction;
import javax.swing.Action;
import javax.swing.ActionMap;
import javax.swing.InputMap;
import javax.swing.JButton;
import javax.swing.JComponent;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.KeyStroke;
import javax.swing.ListSelectionModel;
import javax.swing.event.ListSelectionEvent;
import javax.swing.event.ListSelectionListener;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableCellRenderer;

import ij.IJ;
import ij.gui.PointRoi;
import java.awt.Color;
import java.awt.Component;
import java.awt.Dimension;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Rectangle;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.util.ArrayList;

@SuppressWarnings("serial")
public class ListDialog extends JPanel {
	private boolean DEBUG = true;
	DefaultTableModel tableModel;
	private int selrow;
	private int selcol;
	
	//Array to hold the new List of point coordinates
	
	private ArrayList<PointRoi> pointList = roiLists.getInstance().getPointList();
	
	/*
	 * Main class to create the dialog and display the list
	 * using a GridBag Layout
	 */
	public ListDialog(int[] sList) {
		//Create the Layout of hold other frames
		super(new GridBagLayout());
		
		//Create the constrains
		GridBagConstraints c = new GridBagConstraints();

		//Titles of the columns
		String[] columnNames = { "Head X", "Head Y", "Body X", "Body Y", "Slice", "Quality"};
		
		//Create the table model
		tableModel = new DefaultTableModel(columnNames, 0);
		
		//Create the table frame with the model
		final JTable table = new JTable(tableModel) {
			/*
			 * Add the components to the table and renderer them in acordance with the
			 * parameters input
			 */
			public Component prepareRenderer(TableCellRenderer renderer, int row, int column) {
				Component c = super.prepareRenderer(renderer, row, column);
				
				int modelRow = convertRowIndexToModel(row);
				
				//Paint the rows accordingly to the quality column
				double type = (double) getModel().getValueAt(modelRow, 5);
				if (type > 20)
					c.setBackground(Color.RED);
				else if (type > 10 && type <= 20)
					c.setBackground(Color.YELLOW);
				else if (isRowSelected(modelRow))
					c.setBackground(Color.GRAY);
				else
					c.setBackground(super.getBackground());

				return c;
			}

			@Override
			public boolean isCellEditable(int row, int column) {
				// all cells false
				return false;
			}
		};
		InputMap im = this.getInputMap(JComponent.WHEN_ANCESTOR_OF_FOCUSED_COMPONENT);
		ActionMap am = this.getActionMap();
		table.setPreferredScrollableViewportSize(new Dimension(500, 500));
		table.setFillsViewportHeight(true);
		table.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
		
		//Set the shortcut key U to make update and move action
		im.put(KeyStroke.getKeyStroke(KeyEvent.VK_U, 0), "updateandmove");
		am.put("updateandmove", new AbstractAction() {

			public void actionPerformed(ActionEvent arg0) {
				updateAndMove(table);

			}

		});
		
		//On mouse click call tableToImage
		if (DEBUG) {
			table.addMouseListener(new MouseAdapter() {
				public void mouseClicked(MouseEvent e) {
					tableToImage(table);

				}

			});
		}

		// Create the scroll pane and add the table to it.
		JScrollPane scrollPane = new JScrollPane(table);

		// Add the scroll pane to this panel.
		c.gridx = 0;
		c.gridy = 0;
		add(scrollPane, c);
		addEntry(roiLists.getInstance().getPointList(), sList);
		table.getSelectionModel().setSelectionInterval(0, 0);

		table.getSelectionModel().addListSelectionListener(new ListSelectionListener() {

			@Override
			public void valueChanged(ListSelectionEvent e) {
				// TODO Auto-generated method stub
				tableToImage(table);
			}

		});
		
		//Deal with the events from shortcut u on the image
		IJ.getImage().getCanvas().addKeyListener(new KeyListener() {

			@Override
			public void keyPressed(KeyEvent e) {
				char keyCode = e.getKeyChar();
				if (keyCode == 'u') {
					updateAndMove(table);
				}
			}

			@Override
			public void keyReleased(KeyEvent arg0) {
				// TODO Auto-generated method stub

			}

			@Override
			public void keyTyped(KeyEvent arg0) {
				// TODO Auto-generated method stub

			}

		});
		
		//Add the buttons to the frame at the button of the table
		JButton updateBtn = new JButton("Update Point");
		updateBtn.setPreferredSize(new Dimension(150, 50));
		updateBtn.addActionListener(new ActionListener() {

			@Override
			public void actionPerformed(ActionEvent e) {
				updatePoint(table);
				refreshColors(table);

			}

		});
		c.gridx = 0;
		c.gridy = 1;
		c.anchor = GridBagConstraints.WEST;
		add(updateBtn, c);

		JButton nextBtn = new JButton("Next Point");
		nextBtn.setPreferredSize(new Dimension(150, 50));
		nextBtn.addActionListener(new ActionListener() {

			@Override
			public void actionPerformed(ActionEvent e) {
				nextPoint(table);
				tableToImage(table);

			}

		});
		c.gridx = 0;
		c.gridy = 1;
		c.anchor = GridBagConstraints.CENTER;
		add(nextBtn, c);
		
		JButton doneBtn = new JButton("Done...");
		doneBtn.setPreferredSize(new Dimension(150, 50));
		doneBtn.addActionListener(new ActionListener() {

			@Override
			public void actionPerformed(ActionEvent e) {
				//pointList = getBackHead(table);
				dispose();
			}

		});
		c.gridx = 0;
		c.gridy = 1;
		c.anchor = GridBagConstraints.EAST;
		add(doneBtn, c);
	}
	
	/*
	 * Just call a series of actions as a response to u key shortcut
	 */
	private Action updateAndMove(JTable table) {
		updatePoint(table);
		refreshColors(table);
		nextPoint(table);
		tableToImage(table);
		return null;
	}
	
	/*
	 * Dispose of frame
	 */
	protected void dispose() {
		JFrame parent = (JFrame) this.getTopLevelAncestor();
		parent.dispose();

	}

	/*
	 * Move to next point on red or yellow bckgrnd
	 */
	private void nextPoint(JTable table) {
		int x = 0;
		for (int j = table.getSelectedRow() + 1; j < table.getRowCount(); j++) {
			if ((double) table.getValueAt(j, 5) > 10) {
				x = j;
				break;
			}
		}
		Rectangle rect = table.getCellRect(x, 0, true);
		table.scrollRectToVisible(rect); // scroll to the row
		table.getSelectionModel().setSelectionInterval(x, x);
	}
	
	/*
	 * Update the cells with the new coordinates of the points
	 * that the user adjusted on the image
	 */
	private void updatePoint(JTable table) {

		PointRoi pt = (PointRoi) IJ.getImage().getRoi();
		int[] coorx = pt.getPolygon().xpoints;
		int[] coory = pt.getPolygon().ypoints;
		if (selcol < 2) {
			table.setValueAt(coorx[0], selrow, 0);
			table.setValueAt(coory[0], selrow, 1);
		} else if(selcol < 4){
			table.setValueAt(coorx[0], selrow, 2);
			table.setValueAt(coory[0], selrow, 3);
		}
	
		
		roiLists.getInstance().updateRoi(selrow, pt);
	}
	
	/*
	 * Add entries to the table model from the arrays and calculates the 
	 * quality of the entries by checking the distance between head points 2 frames apart
	 */
	public void addEntry(ArrayList<PointRoi> obj, int[] sList) {

		double[] dist = new double[obj.size()];
		
		dist[0] = 0;
		for (int i = 0; i < obj.size(); i++) {
			int[] xp = obj.get(i).getPolygon().xpoints;
			int[] yp = obj.get(i).getPolygon().ypoints;
			int headx = xp[1];
			int heady = yp[1];
			int bodyx = xp[0];
			int bodyy = yp[0];

			if (i > 0) {
				int[] tempx = obj.get(i - 1).getPolygon().xpoints;
				int[] tempy = obj.get(i - 1).getPolygon().ypoints;
				double x = Math.abs(headx - tempx[1]);
				double y = Math.abs(heady - tempy[1]);
				dist[i] = Math.sqrt(x * x + y * y);
			}

			Object[] data = { headx, heady, bodyx, bodyy, sList[i], dist[i] };

			tableModel.addRow(data);

		}

	}
	
	/*
	 * Function to refresh the color of the table when head coordinates are updated
	 * by the user
	 */
	private void refreshColors(JTable table) {
		int start;

		if (selrow - 3 < 1)
			start = 1;
		else
			start = selrow - 3;

		for (int i = start; i < selrow + 3; i++) {
			int x1 = (int) table.getValueAt(i - 1, 0);
			int y1 = (int) table.getValueAt(i - 1, 1);
			int x2 = (int) table.getValueAt(i, 0);
			int y2 = (int) table.getValueAt(i, 1);
			double x = Math.abs(x2 - x1);
			double y = Math.abs(y2 - y1);
			double dist = Math.sqrt(x * x + y * y);
			table.setValueAt(dist, i, 5);

		}

	}
	
	/*
	 * Add the points to the image from the table
	 * Dont get why the selections of the col and row need to be different...
	 * Long time did this...
	 */
	private Action tableToImage(JTable table) {
		IJ.setTool("point");
		IJ.setSlice((int) table.getValueAt(table.getSelectedRow(), 4));
		selcol = table.getSelectedColumn();
		selrow = table.getSelectedRow();
		
		//This is if you select the colums of ehad, body or tail
		if (selcol < 2)
			IJ.makePoint((int) table.getValueAt(table.getSelectedRow(), 0),
					(int) table.getValueAt(table.getSelectedRow(), 1));
		else if(selcol < 4)
			IJ.makePoint((int) table.getValueAt(table.getSelectedRow(), 2),
					(int) table.getValueAt(table.getSelectedRow(), 3));

		return null;

	}
	
	private ArrayList<PointRoi> getBackHead(JTable table) {
		ArrayList<PointRoi> temp = new ArrayList<PointRoi>();
		
		for(int i = 0; i < table.getRowCount(); i++) {
			temp.add((int) table.getValueAt(i, 4), new PointRoi((int) table.getValueAt(i, 0), (int) table.getValueAt(i, 1)));
		}
		return temp;
	}
	
	public ArrayList<PointRoi> getList(){
		return pointList;	
	}

}