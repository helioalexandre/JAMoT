package com.moubeat.mazes;

import java.awt.BorderLayout;
import java.awt.FlowLayout;

import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.JPanel;
import javax.swing.JTextField;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import javax.swing.UIManager;
import javax.swing.SwingConstants;
import java.awt.Font;
import java.awt.Dimension;

@SuppressWarnings("serial")
public class helpMessages extends JDialog {

	private final JPanel contentPanel = new JPanel();
	private JTextField textField;
	private String[] text = {"Please draw a rectangle in the image!",
			"Please select the first slice to start averaging",
			"Please select the last slice to start averaging"};
	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		try {
			helpMessages dialog = new helpMessages(0);
			dialog.setDefaultCloseOperation(JDialog.DISPOSE_ON_CLOSE);
			dialog.setVisible(true);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * Create the dialog.
	 */
	public helpMessages(int x) {
		setLocationByPlatform(true);
		// TODO Auto-generated method stub
				
				setTitle("User Interaction");
				setModalityType(ModalityType.DOCUMENT_MODAL);
				setBounds(100, 100, 480, 117);
				getContentPane().setLayout(new BorderLayout());
				contentPanel.setLayout(new FlowLayout());
				getContentPane().add(contentPanel, BorderLayout.CENTER);
				{
					textField = new JTextField();
					textField.setPreferredSize(new Dimension(6, 38));
					textField.setBorder(null);
					textField.setFont(new Font("Tahoma", Font.PLAIN, 14));
					textField.setHorizontalAlignment(SwingConstants.CENTER);
					textField.setText(text[x]);
					textField.setBackground(UIManager.getColor("Button.background"));
					contentPanel.add(textField);
					textField.setColumns(40);
				}
				{
					JPanel buttonPane = new JPanel();
					buttonPane.setLayout(new FlowLayout(FlowLayout.RIGHT));
					getContentPane().add(buttonPane, BorderLayout.SOUTH);
					{
						JButton okButton = new JButton("OK");
						okButton.addActionListener(new ActionListener() {
							public void actionPerformed(ActionEvent e) {
								dispose();
							}
						});
						okButton.setActionCommand("OK");
						buttonPane.add(okButton);
						getRootPane().setDefaultButton(okButton);
					}
				}
			}
		
	
	public void changesText(int x) {
		this.textField.setText(text[x]);
		this.revalidate();
	}

}
