package com.cellcounterutil;

import ij.*;
import ij.plugin.PlugIn;

public class App implements PlugIn {
	@Override
	public void run(String args) {

		new GuiApp();
	}

	/**
	 * Main method for debugging.
	 *
	 * For debugging, it is convenient to have a method that starts ImageJ, loads an
	 * image and calls the plugin, e.g. after setting breakpoints.
	 *
	 */
	public static void main(String[] args) {
		// set the plugins.dir property to make the plugin appear in the Plugins menu
		Class<?> clazz = App.class;
		String url = clazz.getResource("/" + clazz.getName().replace('.', '/') + ".class").toString();
		String pluginsDir = url.substring("file:".length(),
				url.length() - clazz.getName().length() - ".class".length());
		System.setProperty("plugins.dir", pluginsDir);

		// start ImageJ
		new ImageJ();

		// open the Clown sample
		IJ.open();

		// run the plugin
		IJ.runPlugIn(clazz.getName(), "");
		new App();

		// Process_Pixels test = new Process_Pixels();
		// test.run(null);
	}

}
