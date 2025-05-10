📊 School Enrollment Regression Analysis
Overview
This project was completed as part of a Data Science I course to analyze factors influencing public school enrollment across counties in the United States. Using a multivariate linear regression approach in SAS, the study investigated how economic conditions, law enforcement presence, and violent crime rates impact total school enrollment.

Objective
To determine the relationship between county-level socioeconomic and public safety indicators and school enrollment levels, using regression modeling.

Dataset
Observations: ~33,000 county-level records

Dependent Variable: New_Total_Enroll – Total public school enrollment

Independent Variables:

employ_county – Employment count in the county

percap_income_county – Per capita income

total_officers – Number of law enforcement officers

violent_crime_rate – Violent crime incidents per population

Methodology
Performed multiple regression analyses using the SAS REG procedure

Developed:

A full model including all four predictors

Three individual models for each category: economic, law enforcement, and crime

A combined model for law enforcement and crime factors

Evaluated model fit using R², Adjusted R², F-statistics, and p-values

Interpreted coefficients to assess the direction and magnitude of each predictor

Key Findings
✅ Employment (employ_county) had a positive and statistically significant effect on school enrollment.

❌ Per capita income was negatively associated with school enrollment, contrary to expectations.

❌ Number of officers showed a negative association in the full model but a positive effect when modeled alone.

✅ Violent crime rate had a positive and significant relationship with enrollment in all models.

Model Performance
Model	R²	Interpretation
Full Model (All Predictors)	0.1137	Low explanatory power; all variables significant
Economic Factors Only	0.0803	Positive effect from employment; negative from income
Law Enforcement Only	0.0020	Very weak explanatory power
Crime Factors Only	0.0505	Positive relationship with violent crime
Officers + Crime Combined	0.0514	Slight improvement when factors are combined

Conclusion
While all predictors were statistically significant, the model’s overall explanatory power (R² ~11%) was limited. The findings suggest that school enrollment may be influenced by a complex mix of factors not captured in this analysis. Further research with additional variables (e.g., school funding, population demographics, urban/rural classification) may improve predictive accuracy.

Repository Contents
Data_Science_I_Final_Project_Output.docx – Full SAS output and interpretations

README.md – Project summary and documentation

Tools Used
SAS Studio – Data analysis and regression modeling

Microsoft Word – Report documentation and interpretation

Author
Shreya Kadav
B.S. in Data Science (Public Health concentration)
University of Toledo

