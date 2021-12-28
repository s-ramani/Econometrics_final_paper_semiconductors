import excel "\\Client\C$\Users\suhaasramani\Documents\Fall 2021\Econometrics\Research Paper\auto labor data.xls", sheet("Sheet3") cellrange(A1:I664) firstrow clear

su val_auto_ex auto_share total_semi auto_semi pop house_inc min_wage

corr val_auto_ex auto_semi pop house_inc min_wage

graph matrix val_auto_ex auto_semi pop house_inc min_wage

graph twoway (lfit val_auto_ex auto_semi) (scatter val_auto_ex auto_semi)

egen territory_id = group(territory), label

xtset territory_id year

xtreg log_auto_ex auto_semi

xtreg val_auto_ex auto_semi pop house_inc min_wage i.year, fe 

testparm i.year

collin val_auto_ex auto_semi pop house_inc min_wage

gen log_semi_im = log(auto_semi)

xtreg log_auto_ex log_semi_im pop house_inc min_wage i.year, fe

regsave, tstat pval ci 

corrtex log_auto_ex log_semi_im house_inc pop min_wage, file(auto)

*Doing Hausman Test

xtreg log_auto_ex log_semi_im pop house_inc min_wage i.year, fe
estimates store fixed

xtreg log_auto_ex log_semi_im pop house_inc min_wage i.year, re
estimates store random

hausman fixed random


*The test suggests that a random effects model should be run to assess the effects since the prob>chi2 is not significant at the 0.05 level so we need to use random effects, we cannot reject the null. 

** Making latex tables

xtreg log_auto_ex log_semi_im, re
eststo model1

xtreg log_auto_ex log_semi_im pop, re
eststo model2

xtreg log_auto_ex log_semi_im pop house_inc, re
eststo model3

xtreg log_auto_ex log_semi_im pop house_inc min_wage, re 
eststo model4

xtreg log_auto_ex log_semi_im pop house_inc min_wage i.year, re 
eststo model5

esttab










