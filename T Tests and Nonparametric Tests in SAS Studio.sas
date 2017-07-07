data running;

infile'H:\Apps\MinitabFiles\Morrell\ST710\Elliott\running.dat';
input sex $ 3 min1 5 sec1 7-8 min2 10 sec2 12-13;
raceonetime = (min1*60) + (sec1); *Changing race times into seconds;
racetwotime = (min2*60) + (sec2);
testraceone = raceonetime-78;*Calculating the difference between each 
							  test and the average time;
testracetwo = racetwotime-95;
run;

proc means data = running n mean std probt; *Testing Race One Ho: mu =78 
											  vs Ha: mu>78. Race Two Ho :mu=95 
											  vs Ha mu>95;
												
where sex = 'F';
var testraceone testracetwo;
run;

proc univariate data= running; *Preforming Nonparamtric Test with 
								Univariate Function;
where sex = 'F';
var testraceone testracetwo;
run;


proc format; *Formatting Sex Variable; 
value sfmt 1 = 'Male' 2 = 'Female';
run;

data btt;
infile'H:\Apps\MinitabFiles\Morrell\ST710\Elliott\btt.dat';
input childid 1-4 sex 6 bweight 8-11 gestage 13-15;
gestagedays= gestage*7; *Changing gestage to days;
testgestage = gestagedays - 266; *Calculating difference between 
								  population avaerage;
if bweight <2500 then lowweight = 1; *Creating Lowweight Variable;
else lowweight = 0;
if bweight = . then lowweight = .;
testbweight = bweight -3332; *Calculating difference between 
							  population avaerage;
format sex sfmt.; 
run;


proc freq data = btt;
tables sex / chisq testp = (0.5, 0.50); *calculating difference between 
										 boys and girls in sample;

tables lowweight / chisq testp = (.918, .082); *calculating difference of 
												proprotion of Lowweight and 
												Non-Lowweight in sample vs. 
												Us Population;
title "sex proportions and low weight";

run;

proc means data=btt n mean std probt t; *Testing difference between Gestage and 
								         Birthweight vs Population;
var testgestage testbweight;
title "Gestage and Birthweight Tests";
run;

data handinj;

infile 'H:\Apps\MinitabFiles\Morrell\ST710\Elliott\handinj.dat';
input id $ 1-5 injurytype $ 7-11 dowl 13-14 cost 16-19; 
run;

proc ttest data = handinj; *Preforming ttest for Days of Work Lost 
			 and Cost between different Injury Types;
class injurytype;
var dowl cost;
title "11.4 T Tests for Days of work lost and cost";
run;

proc npar1way data=handinj wilcoxon; *Preforming Wilcoxon Rank Sum Test for the two groups 
						             of injury types for the variblae Days of Work Lost 
						             and Cost; 
class injurytype;
var dowl cost;
run;

data quarterback;
infile 'H:\Apps\MinitabFiles\Morrell\ST710\Elliott\quarterback.dat';
input player $ 5-22 tds 70-71 ints 74-75;
tdsvints = tds-ints; 
run;

proc ttest data =quarterback; *Preforming Paired T Test for TDs vs. Ints;
paired tds*ints;
run;


proc univariate data =  quarterback; *Preforming NonParametric Tests for if 
									  TDs - Ints is different from 0; 
var tdsvints;
run;

