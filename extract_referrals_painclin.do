
/*
*referrals 
	*for pain clinics/services
*/

do "X:\CPRD_19_167_Mesh\referrals and scans\steering file"

log using "${logs}\extract_referrals_painclin.txt", text

*get the same codes from referral file but also check clinical file and others
foreach file in referral clinical1_all clinical2_all test1_all test2_all {

	use "${source}\\`file'.dta", clear
	merge m:1 patid using "${save}\patient_format.dta"
	drop if _merge==1
	drop if _merge==2
	drop _merge

	gen event_date=date(eventdate, "DMY") 
	format event_date %td

	gen painclin=0
	recode painclin 0=1 if medcode==	6899
	recode painclin 0=1 if medcode==	1936
	recode painclin 0=1 if medcode==	9682
	recode painclin 0=1 if medcode==	105661
	recode painclin 0=1 if medcode==	21965
	recode painclin 0=1 if medcode==	61911
	recode painclin 0=1 if medcode==	70001
	recode painclin 0=1 if medcode==	10902
	recode painclin 0=1 if medcode==	32539
	recode painclin 0=1 if medcode==	107428
	recode painclin 0=1 if medcode==	51210
	recode painclin 0=1 if medcode==	45921
	recode painclin 0=1 if medcode==	11017
	recode painclin 0=1 if medcode==	97767
	recode painclin 0=1 if medcode==	107475
	recode painclin 0=1 if medcode==	13670
	recode painclin 0=1 if medcode==	48922
	recode painclin 0=1 if medcode==	12160
	recode painclin 0=1 if medcode==	32957
	recode painclin 0=1 if medcode==	61554
	recode painclin 0=1 if medcode==	26076
	recode painclin 0=1 if medcode==	46604
	recode painclin 0=1 if medcode==	43476

	keep patid painclin event_date medcode 
	keep if painclin==1
	sort patid event_date
		
	save "${data}\extract_painclin_`file'", replace
}

*********************************************************************************
use "${data}\extract_painclin_referral", clear
append using "${data}\extract_painclin_clinical1_all"
append using "${data}\extract_painclin_clinical2_all"
append using "${data}\extract_painclin_test1_all"
append using "${data}\extract_painclin_test2_all"

bys patid event_date medcode: gen dup=_n
bys patid event_date medcode: gen x=_N
drop if dup>1
drop dup x 
save "${data}\extract_painclin_all", replace

log close
