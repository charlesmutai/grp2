options ls=78;   
title "95% prediction ellipse";   

data a;   /*This data set defines the polar coordinates for plotting the prediction ellipse as a function of the angle theta. It stores the results in variables 'u' and 'v' that will be used below.*/
  pi=2.d0*arsin(1);   
  do i=0 to 200;   
    theta=pi*i/100;   
    u=cos(theta);   
    v=sin(theta);   
    output;   
  end;   
  run;   

proc iml;   /*The iml procedure allows for many general calculations to be made. In this case*/
  create b var{x y};   /*This defines a data set 'b' with two variables 'x' and 'y' that will be used in the calculations below.*/
  start ellipse;   /*This defines a SAS module named 'ellipse' that can be called to calculate the xy coordinates for ploting the prediction ellipse. The lines of code below are executed when 'ellipse' is called.*/
    mu={0,   /*This specifies the value of the bivariate mean vector (0, 0). This will be the center of the prediction ellipse.*/
        0};   
    sigma={1.0000 0.5000,   /*This specifies the values of the covariance matrix, which must be symmetric.*/
           0.5000 2.0000};   
    lambda=eigval(sigma);   /*The statements below calculate the xy coordinates for plotting the ellipse from the polar coordinates that are provided above.*/
    e=eigvec(sigma);   
    d=diag(sqrt(lambda));   
    z=z*d*e`*sqrt(5.99);   
    do i=1 to nrow(z);   
      x=z[i,1];   
      y=z[i,2];   
      append;   
    end;   
  finish;   /*This ends the module definition.*/
  use a;   /*This makes the polar coordinates defined in the data set 'a' available.*/
  read all var{u v} into z;   /*The polar coordinates are assigned to the vector z, which is used in the ellipse module.*/
  run ellipse;   /*This calls the ellipse module, which runs and populates the data set 'b' with the xy coordinates that will be used for plotting the prediction ellipse.*/

proc gplot;   /*This plots the prediction ellipse from the coordinates in the data set 'b'.*/
  axis1 order=-5 to 5 length=3 in;   /*The axis statements set the limits of the plotting region.*/
  axis2 order=-5 to 5 length=3 in;   
  plot y*x / vaxis=axis1 haxis=axis2 vref=0 href=0;   /*These options specify the variables for plotting, which to put on which axis, and the vertical and horizontal reference lines.*/
  symbol v=none l=1 i=join color=black;   /*This option specifies that the points are to be joined in a continuous curve in black.*/
  run;   