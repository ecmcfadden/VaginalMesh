
*create code lists for CRP and ESR
*then extract from test, clinical and referral files

/*
O'Sullivan et al. list for these:

CRP
medcode	readterm
14067	C reactive protein normal
19809	C reactive protein abnormal
14066	Plasma C reactive protein
14068	Serum C reactive protein level

ESR
46		Erythrocyte sedimentation rate
27037	Erythrocyte sediment rate NOS
16816	Elevated sedimentation rate
27038	ESR normal
14924	ESR raised
25450	ESR abnormal
57305	ESR low

*/

do "X:\CPRD_19_167_Mesh\referrals and scans\steering file"
*
import delimited using "${source}medical.txt", clear varnames(1) delim(tab) stringcols(_all)
rename _12 medcode
rename v2 readcode 
rename v7 desc
drop v3-v6
drop v8

gen varname=ustrlower(desc)

gen poss_crp=.
replace poss_crp=1 if strmatch(varname, "*c reactive*")==1
replace poss_crp=1 if strmatch(varname, "*CRP*")==1
replace poss_crp=1 if strmatch(varname, "*reactive protein*")==1

gen poss_esr=.
replace poss_esr=1 if strmatch(varname, "*esr*")==1
replace poss_esr=1 if strmatch(varname, "*sedimentation*")==1
replace poss_esr=1 if strmatch(varname, "*erythrocyte*")==1
replace poss_esr=1 if strmatch(varname, "*sediment*")==1

list if poss_crp==1 
replace poss_crp=0 if strmatch(varname, "*postdysenteric reactive*")==1
replace poss_crp=0 if strmatch(varname, "*reactive hepatitis*")==1
replace poss_crp=0 if strmatch(varname, "*reactive depression*")==1

*consistent with O'Sullivan et al.

list if poss_esr==1
replace poss_esr=0 if strmatch(varname, "*pbg deaminase level*")==1

*1 additional code
keep if poss_crp==1 | poss_esr==1

sort poss_crp medcode
destring(medcode), replace

save "${codes}tests_esr_crp", replace

**** Now extract

capture log close
log using "${logs}\extract_esr_crp.txt", text replace

*TEST FILES AND REFERRAL FILE

foreach file in 1 2 referral {
	if "`file'"!="referral" {
		use "${source}\\test`file'_all.dta", clear
	}
	if "`file'"=="referral" {
		use "${source}\\referral.dta", clear
	}
	keep if medcode==14066 | ///
			medcode==14067 | ///
			medcode==14068 | ///
			medcode==19809 | ///
			medcode==14924 | ///
			medcode==16816 | ///
			medcode==25450 | ///
			medcode==27037 | ///
			medcode==27038 | ///
			medcode==46 | ///
			medcode==57305
			
			
	merge m:1 patid using "${save}\patient_format.dta"
	drop if _merge==1
	drop if _merge==2
	drop _merge
	gen event_date=date(eventdate, "DMY") 
	format event_date %td
	sort patid event_date
	merge m:1 medcode using "${codes}tests_esr_crp", keepusing(poss_*)
	drop if _merge==2
	drop _merge
	
	gen esr=0
	replace esr=1 if poss_esr==1
	
	gen crp=0
	replace crp=1 if poss_crp==1
	
	drop poss_*
	
	if "`file'"!="referral" {
		keep patid medcode enttype event_date esr crp
		
	}
	if "`file'"=="referral" {
		keep patid medcode event_date esr crp
	
	}
			
	keep if esr==1 | crp==1
	
	save "${data}\extract_tests_ESR_CRP_`file'", replace
}

*CLINICAL FILES	
foreach file in  clinical1_all clinical2_all  {
	use "${source}\\`file'.dta", clear
	keep if medcode==14066 | ///
			medcode==14067 | ///
			medcode==14068 | ///
			medcode==19809 | ///
			medcode==14924 | ///
			medcode==16816 | ///
			medcode==25450 | ///
			medcode==27037 | ///
			medcode==27038 | ///
			medcode==46 | ///
			medcode==57305
				
	merge m:1 patid using "${save}\patient_format.dta"
	drop if _merge==1
	drop if _merge==2
	drop _merge
	gen event_date=date(eventdate, "DMY") 
	format event_date %td
	sort patid event_date

	merge m:1 medcode using "${codes}tests_esr_crp", keepusing(poss_*)
	drop if _merge==2
	drop _merge

	gen esr=0
	replace esr=1 if poss_esr==1
	gen crp=0
	replace crp=1 if poss_crp==1
	drop poss_*
	keep patid medcode enttype event_date esr crp
	keep if esr==1 | crp==1
	save "${data}\extract_tests_ESR_CRP_`file'", replace
}

log close




