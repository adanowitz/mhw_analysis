# mhw_analysis

## proc_data.r ##
Takes in processed data and summarizes screen results by race and gender, and by gender and sexual identity

Returns a list with rows **rg** containing race and gender data; **rgf** race and gender with nas and 100% positive screens (used as a proxy for overly small race/gender groups) filtered out; **gs** with gender and sexuality; and **gsf** which is gs with nas and 100% positive screens filtered out.

## table_struct/survey_headers.csv ##
Replacement/condensed/informative headers used to replace the survey questions when importing raw survey result csvs

## rfunc ##
This directory contains all of the heavy lifting scripts for calculating screen rates and processing the data

### survey_parse.r ###
This is the main script for processing a survey. When sourced, it loads some necessary libraries and sets some environment variables so the scripts can find the table_struct/survey_headers.

When run, this function takes in a path to a csv, then:

   * Runs load.raw to read in the csv, delete unneeded columns, and replace the headers
   * Runs analysis.kessler to compute the screens attached to the Kessler 6 instrument (kessler moderate and kessler major)
   * Runs analysis.phq.depr to compute the phq depressive major and other depressive
   * Runs analysis.phq.panic to compute panic screen
   * Runs analysis.phq.other to compute other anxiety
   * Runs analysis.phq.eating to compute eating disorder screens
   * Runs analysis.pcptsd to compute ptsd screen
	
   All screen results are appended to the end of the imported data
   
### load_raw.r ###
