* Read data from the input file and sort by name
  usage of informats, title and labels;

data marathon; *create a dataset ;
	*Read an input file from the first observation: handle missing values by using partial info and skips to next line (truncover);
	infile 'B:\CSC433\Dataset\erie-marathon-2006.txt' firstobs = 12 truncover; 
	input ID 5. @9 Place 3. @19 Finisher $13. @88 Final_Time TIME8. @98 Pace TIME5.; * Read the data from the file;
	label ID="Jersey Number" Finisher="Name" Pace="Mile Pace"; *label the variable field appropriately;
	Finisher = scan(Finisher, 1, ','); *reads the data field until it encounter COMMA;
		if ID = . then delete; * erases the data the begins with '.';

proc sort;
	by Finisher; * sorts the dataset by the name in ascending order;

proc print label;	
	title 'Project 1: Erie Marathon'; * assigns title to the dataset ;
	FORMAT Final_Time TIME8. Pace TIME5.; * usage of informats for the numeric fields;
run;
quit;
 
