options ls=78;
title "Eigenvalues and Eigenvectors - Wechsler Data";

 /* The first two lines define the name of the data set with the name 'wechsler'
  * and specify the path where the contents of the data set are read from.
  * Since we have a header row, the first observation begins on the 2nd row,
  * and the delimiter option is needed because columns are separated by commas.
  * The input statement is where we provide names for the variables in order 
  * of the columns in the data set. If any were categorical (not the case here), 
  * we would need to put a '$' character after its name.
  */

data wechsler;
  infile "/home/u918990/505/data/wechsler.csv" firstobs=2 delimiter=',';
  input id info sim arith pict;
  run;

 /* This prints the specified variable(s) from the data set 'wechsler'. 
  * Since no variables are specified, all are printed.
  */



proc print data=wechsler;
  run;

 /* The corr procedure calculates the pairwise correlations 
  * for the variables specified in the var statement. The default is 
  * to operate on the correlation matrix of the data, but the 'cov' option 
  * can be added to output the covariance matrix as well.
  * The Fisher test results and confidence intervals can be added with the
  * fisher option. The biasadj=no option is used to produce results that match
  * the lesson formulas. The default adjustment is a modification of the
  * formula to improve bias.
  */

title "Inference for correlations";
proc corr data=wechsler cov fisher(alpha=.05 biasadj=no) ;
var info sim arith pict;
run;