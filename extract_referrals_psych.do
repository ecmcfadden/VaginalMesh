
/*
*referrals 
	*for psychological services
*/

do "X:\CPRD_19_167_Mesh\referrals and scans\steering file"

log using "${logs}\extract_referrals_psych.txt", text


foreach file in referral clinical1_all clinical2_all test1_all test2_all {

	use "${source}\\`file'.dta", clear
	merge m:1 patid using "${save}\patient_format.dta"
	drop if _merge==1
	drop if _merge==2
	drop _merge

	gen event_date=date(eventdate, "DMY") 
	format event_date %td

	gen psych=0
	recode psych 0=1 if medcode==	25510
	recode psych 0=1 if medcode==	106800
	recode psych 0=1 if medcode==	94758
	recode psych 0=1 if medcode==	53189
	recode psych 0=1 if medcode==	32560
	recode psych 0=1 if medcode==	26178
	recode psych 0=1 if medcode==	28609
	recode psych 0=1 if medcode==	56119
	recode psych 0=1 if medcode==	110621
	recode psych 0=1 if medcode==	32921
	recode psych 0=1 if medcode==	32924
	recode psych 0=1 if medcode==	40894
	recode psych 0=1 if medcode==	34538
	recode psych 0=1 if medcode==	10002
	recode psych 0=1 if medcode==	44910
	recode psych 0=1 if medcode==	34532
	recode psych 0=1 if medcode==	105244
	recode psych 0=1 if medcode==	27640
	recode psych 0=1 if medcode==	11270
	recode psych 0=1 if medcode==	13680
	recode psych 0=1 if medcode==	105357
	recode psych 0=1 if medcode==	5338
	recode psych 0=1 if medcode==	13677
	recode psych 0=1 if medcode==	1690
	recode psych 0=1 if medcode==	95936
	recode psych 0=1 if medcode==	10967
	recode psych 0=1 if medcode==	7052
	recode psych 0=1 if medcode==	11958
	recode psych 0=1 if medcode==	97420
	recode psych 0=1 if medcode==	36728
	recode psych 0=1 if medcode==	97570
	recode psych 0=1 if medcode==	2189
	recode psych 0=1 if medcode==	10669
	recode psych 0=1 if medcode==	51055
	recode psych 0=1 if medcode==	9868
	recode psych 0=1 if medcode==	110142
	recode psych 0=1 if medcode==	6540
	recode psych 0=1 if medcode==	2764
	recode psych 0=1 if medcode==	30727
	recode psych 0=1 if medcode==	27678
	recode psych 0=1 if medcode==	20829
	recode psych 0=1 if medcode==	59131
	recode psych 0=1 if medcode==	94684

	keep patid psych event_date medcode 
	keep if psych==1
	
	sort patid event_date

	save "${cons}\extract_psych_`file'", replace

}

*********************************************************************************

*combine extracted data*
use "${cons}\extract_psych_referral", clear
append using "${cons}\extract_psych_clinical1_all"
append using "${cons}\extract_psych_clinical2_all"
append using "${cons}\extract_psych_test1_all"
append using "${cons}\extract_psych_test2_all"

bys patid event_date medcode: gen dup=_n
bys patid event_date medcode: gen x=_N

drop if dup>1
drop dup x 

save "${cons}\extract_psych_all", replace


