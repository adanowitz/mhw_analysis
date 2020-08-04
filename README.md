# mhw_analysis

## mhw_analysis/calpoly_mhw_anon.csv ##
Anonymized Cal Poly survey data that can be fed through the survey parse script

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
Reads in the survey csv, zeroes out columns with personal identifying information, and other data collection information. It replaces the survey questions with easier to handle short text headers. This also removes entries from individuals who did not consent, those who responded with a year in program other than 1, 2, or "prefer not to respond", and those didn't complete the first screen question (Kessler q1). It returns this filtered and parsed data.

### kessler_analysis.r ###
Looks at the Kessler questions and returns screens for major and moderate kessler distress.

### phq_analysis.r ###
Contains functions for handling the myriad of PHQ screens

### pcptsd_analysis.r ###
Contains functions for the pc-ptsd screens

### multilineheader.r ###
A basic utility used in loading the survey csv. It takes question headers that are spread across two rows and concatenates them for easier processing.

## table_struct/survey_headers.csv ##
Replacement/condensed/informative headers used to replace the survey questions when importing raw survey result csvs

## roy_scripts ##
Sample script developed by Soma Roy as part of stats department office hours to help with basic logistic regression of data

### roy_scripts/Belief on Grad Regression.r ###
Runs regression models on factors against a newly coded variable "new_belief" to find associations between mental health and intent to persist (graduation)

## proc_data.r ##
Takes in processed data and summarizes screen results by race and gender, and by gender and sexual identity

Returns a list with rows **rg** containing race and gender data; **rgf** race and gender with nas and 100% positive screens (used as a proxy for overly small race/gender groups) filtered out; **gs** with gender and sexuality; and **gsf** which is gs with nas and 100% positive screens filtered out.
