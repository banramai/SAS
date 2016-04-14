* Read data from the input file and write to an output file
  sort by time, usage of informats, headers and labels;

* sets the line size, with no date and page number as 1 always;
option linesize=100 nodate pageno=1;

data marathon; *create a dataset; 
 	*Read an input file from the first observation: handle missing values by using partial info and skips to next line (truncover);
	infile 'B:\CSC433\Dataset\erie-marathon-2006.txt' firstobs = 12 truncover;
	input ID 5. @9 Place 3. @19 Finisher $13. @88 Final_Time TIME8. @98 Pace TIME5.; * Read the data from the file;
	Finisher = scan(Finisher, 1, ','); *reads the data field until it encounter COMMA;
	label ID="Jersey Number" Finisher="Name" Pace="Mile Pace";	*label the variable field appropriately;
		if ID = . then delete; * erases the data the begins with '.';
	
proc print;

proc sort;
	by Final_Time; * sorts the dataset by the time in ascending order;

data _null_;	*does not create a dataset;
	file 'B:\CSC433\Dataset\proj1-output.txt' print header=head;   *create a file with headers;
	set marathon; * reads from the dataset;
	put @2 ID @20 Place @28 Finisher @45 Final_Time @60 Pace; *writes data into the file;
	FORMAT Final_Time TIME8. Pace TIME5.; * usage of informats for the numeric fields;
return;	
head: 
	put//;
	put 'Name: Banumathi Ramaiah' @30 'Project Number:1' @50 'Submission Date: April 13, 2016'; * header that contains, name,project number and date;
	put//;
	put @2 'Jersey Number' @20 'Place' @28 'Name' @45 'Final Time' @60 'Mile Pace';	* creates variables name;

run;
quit;
 
