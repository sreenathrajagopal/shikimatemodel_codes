# shikimatemodel_codes
# POSYBAL_multicore.R

	POSYBAL_multicore.R is a script that has been built to read an FBA model and parse into the linear inverse model. Further a single optimum solution is generated (Biomass maximisation) and used as a seed point for the population run. The script is parallelised into 6 cores to develop independently random population of x numbers. The individual files are populated further to form a mega collection of iteration that shall constitute the targeted population number. (Multiple different maximasation can also be generated, where each of the cores can start working with different optimum solution as seed, further giving diverse solution)

	## Installation

	This script requires the user to install R programming language.
	The following libraries are essential for running the script post the installation of R.
	1. LIM library and its associated dependancy
	2. foreach library and its associated dependancies
	3. doMC library and its associated dependancies.

	The model file must be present in the same directory as the script as the same is passed as an argument to the script.

	## USAGE

	Rscript POSYBAL_multicore.R Final_ecoli_model.lim

	## Input
	Final_ecoli_model.lim 

	## Output

	Final_ecoli_model_posybal_all.csv

# ISSHIKIMATE.R 

	Once the Matrix of all the solution points containing different possible solution of an underdetermined system is generated, it is passed as an argument for this script.For the metabolite of interest the script filters out all the samples in the population having flux greater than the threshold selected (ex. 90% of max flux and above) generating the maxflux containing subset of the population as a file output. Further it also analyses in the respective population the fluxes of the reaction that are found to run minimal(10% of respective reaction max) allowing us to visualise the reaction that can be knocked out to harness maximum target metabolite reaction.
The final output is the list of reactions that are found to be running low from the given model for the thresholds selected and subset of the population corresponding to maximum target flux reaction.

	## USAGE

	Rscript ISSHIKIMATE.R Final_ecoli_model_posybal_all.csv

	## Input

	Final_ecoli_model_posybal_all.csv

	## Output

	kncdwn.csv
	maxshikimate.csv
	reactions_shikimate.txt


# extracting_selected.py

	This script takes in the reported reaction list as the input file and pulls out the data (reaction equation, genese involved) from the model reaction only file(main.txt). The final output is an text file containing the reactions that are running low for maximum target metabolite flux with the details of the genes involved in the respective fluxes. These gene list can further be used to carry out knock outs

	## Installation
	
	This script requires the user to install Python programming language

	## Usage

	python extracting_selected.py
	
	## Input 
	
	main.txt
	reactions_shikimate.txt

	## Output
	
	output_shikimate.txt








