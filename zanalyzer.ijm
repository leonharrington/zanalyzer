macro "Zprofile extractor" {
	run("Clear Results");

	// Set the channel here for the desired protein:
	Stack.setChannel(3);

	// Set the real time interval here (e.g. 1 min = 1)
	interval = 5;
	
	// Choose directory to save results files
	path = getDirectory("Please choose directory for saving results");

	// Open a file for the timecourse values to be written to
	pkfname = path+"timecourse.csv";
	f = File.open(pkfname);
	print(f, "t"+","+"Peak intensity");
	
	getDimensions(w, h, channels, slices, frames);

	// Obtain z-profiles
	for (n=1; n<=frames; n++) {
		max_int = 0;
		Stack.setFrame(n);
		run("Plot Z-axis Profile", "profile=z-axis");
		
		// Get profile and display values in "Results" window
		Plot.getValues(x, y);
  		for (i=0; i<x.length; i++) {
			setResult("z", i, x[i]);
			setResult("Int", i, y[i]);
  		}
  		setOption("ShowRowNumbers", false);
		updateResults;
		
  		// Save as spreadsheet compatible text file
		fname = path+"profile"+n+".csv";
		saveAs("Results", fname);

		// Find the peak (numerical maximum)
		for (a=0; a<nResults(); a++) {
			if (getResult("Int",a)>max_int)
			{
				max_int = getResult("Int",a);
			}
    	else{};
		}

		// Write out peak value to file
		t = (n-1)*interval;
		print(f, t+","+max_int);

		// Tidy up for the next iteration
		run("Clear Results");
		close();
		
	}

File.close(f);

// Read-in and plot the time course data in ImageJ (for quick reference)
open(pkfname);
setOption("ShowRowNumbers", false);
updateResults();

Fit.doFit("Exponential with Offset", Table.getColumn("t", "timecourse.csv"),Table.getColumn("Peak intensity", "timecourse.csv"));
Fit.plot();
Plot.setXYLabels("t", "Peak intensity")
}
