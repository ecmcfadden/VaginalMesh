
/* do file to extract all tests
* codelists based on those from O'Sullivan et al. 

*interested in:
MRI scans
CT scans
transvaginal ultrasounds

*/

do "X:\CPRD_19_167_Mesh\referrals and scans\steering file"

log using "${logs}\extract_all_tests.txt", text

*****************************************************************************
**CLINICAL FILES*

foreach file in  clinical1_all clinical2_all  {

	use "${source}\\`file'.dta", clear
	merge m:1 patid using "${save}\patient_format.dta"
	drop if _merge==1
	drop if _merge==2
	drop _merge
	
	gen event_date=date(eventdate, "DMY") 
	format event_date %td

	**************************************
	sort patid event_date

	* 20. pelvic CT
	gen pelvic_ct=0
	replace pelvic_ct=1 if medcode==	101033
	replace pelvic_ct=1 if medcode==	100939
	replace pelvic_ct=1 if medcode==	14218
	replace pelvic_ct=1 if medcode==	101000
	replace pelvic_ct=1 if medcode==	91437
	
	/*introduced in - 
101030	Dec 2010	
100939	Nov 2010	
14218	Feb 09		
10100	Nov 2010	
91437	Feb 09		
*seem to have no events prior to 2012.
*/ 
	* 21 pelvic ultrasound - 
	*tighter list that excludes the antenatal ones. 
	gen pelvic_us=0
	replace pelvic_us=1 if medcode==	103473
	replace pelvic_us=1 if medcode==	12871
	replace pelvic_us=1 if medcode==	696
	replace pelvic_us=1 if medcode==	13992
	replace pelvic_us=1 if medcode==	10814
	replace pelvic_us=1 if medcode==	103497
	replace pelvic_us=1 if medcode==	55021
	*237	Abdominal ultra sound
	replace pelvic_us=1 if enttype==	237 
	*238	Pelvic ultra sound
	replace pelvic_us=1 if enttype==	238

	*PELVIS MRI
	gen pelvic_mri=0
	replace pelvic_mri=1 if medcode==97243
				
	
				
	** URINALYSIS **
	* urine dipstick
	gen urine_dipstick=0
	replace urine_dipstick=1 if medcode==	13606
	replace urine_dipstick=1 if medcode==	13927
	replace urine_dipstick=1 if medcode==	35590
	replace urine_dipstick=1 if medcode==	55158
	replace urine_dipstick=1 if medcode==	13610
	replace urine_dipstick=1 if medcode==	27005
	replace urine_dipstick=1 if medcode==	13924
	replace urine_dipstick=1 if medcode==	13940
	replace urine_dipstick=1 if medcode==	55140
	replace urine_dipstick=1 if medcode==	13615
	replace urine_dipstick=1 if medcode==	13595
	replace urine_dipstick=1 if medcode==	13937
	replace urine_dipstick=1 if medcode==	13601
	replace urine_dipstick=1 if medcode==	13594
	replace urine_dipstick=1 if medcode==	14088
	replace urine_dipstick=1 if medcode==	33302
	replace urine_dipstick=1 if medcode==	43
	replace urine_dipstick=1 if medcode==	14091
	replace urine_dipstick=1 if medcode==	14395
	replace urine_dipstick=1 if medcode==	13612
	replace urine_dipstick=1 if medcode==	13590
	replace urine_dipstick=1 if medcode==	27214
	replace urine_dipstick=1 if medcode==	14094
	replace urine_dipstick=1 if medcode==	8482
	replace urine_dipstick=1 if medcode==	14383
	replace urine_dipstick=1 if medcode==	13611
	replace urine_dipstick=1 if medcode==	44179
	replace urine_dipstick=1 if medcode==	14382
	replace urine_dipstick=1 if medcode==	13621
	replace urine_dipstick=1 if medcode==	43262
	replace urine_dipstick=1 if medcode==	13600
	replace urine_dipstick=1 if medcode==	27059
	replace urine_dipstick=1 if medcode==	13613
	replace urine_dipstick=1 if medcode==	39243
	replace urine_dipstick=1 if medcode==	47131
	replace urine_dipstick=1 if medcode==	34842
	replace urine_dipstick=1 if medcode==	13939
	replace urine_dipstick=1 if medcode==	4393
	replace urine_dipstick=1 if medcode==	6878
	replace urine_dipstick=1 if medcode==	8741
	replace urine_dipstick=1 if medcode==	14561
	replace urine_dipstick=1 if medcode==	9430
	replace urine_dipstick=1 if medcode==	13936
	replace urine_dipstick=1 if medcode==	13910
	replace urine_dipstick=1 if medcode==	14562
	replace urine_dipstick=1 if medcode==	43523
	replace urine_dipstick=1 if medcode==	39212
	replace urine_dipstick=1 if medcode==	42
	replace urine_dipstick=1 if enttype== 430 ///
				| enttype==431 | enttype==432 | enttype==433 ///
				| enttype==434 | enttype==473
	replace urine_dipstick=1 if enttype==286 ///
				| enttype==287 | enttype==340
	 
	* 21. urine MCS
	gen urine_mcs=0
	replace urine_mcs=1 if medcode==	10891
	replace urine_mcs=1 if medcode==	38204
	replace urine_mcs=1 if medcode==	13935
	replace urine_mcs=1 if medcode==	41079
	replace urine_mcs=1 if medcode==	13622
	replace urine_mcs=1 if medcode==	13920
	replace urine_mcs=1 if medcode==	13914
	replace urine_mcs=1 if medcode==	13912
	replace urine_mcs=1 if medcode==	13923
	replace urine_mcs=1 if medcode==	19113
	replace urine_mcs=1 if medcode==	41078
	replace urine_mcs=1 if medcode==	29463
	replace urine_mcs=1 if medcode==	13915
	replace urine_mcs=1 if medcode==	13916
	replace urine_mcs=1 if medcode==	38205
	replace urine_mcs=1 if medcode==	16273
	replace urine_mcs=1 if medcode==	19791
	replace urine_mcs=1 if medcode==	30877
	replace urine_mcs=1 if medcode==	17531
	replace urine_mcs=1 if medcode==	39644
	replace urine_mcs=1 if medcode==	14517
	replace urine_mcs=1 if medcode==	39371
	replace urine_mcs=1 if medcode==	32332
	replace urine_mcs=1 if medcode==	23294
	replace urine_mcs=1 if medcode==	29628
	replace urine_mcs=1 if medcode==	16511
	replace urine_mcs=1 if medcode==	16380
	replace urine_mcs=1 if medcode==	9534
	replace urine_mcs=1 if medcode==	37211
	replace urine_mcs=1 if medcode==	13874
	replace urine_mcs=1 if medcode==	13873
	replace urine_mcs=1 if medcode==	27009
	replace urine_mcs=1 if medcode==	13921
	replace urine_mcs=1 if medcode==	13917
	replace urine_mcs=1 if medcode==	27000
	replace urine_mcs=1 if medcode==	23509
	replace urine_mcs=1 if medcode==	47177
	replace urine_mcs=1 if medcode==	27004
	replace urine_mcs=1 if medcode==	55744
	replace urine_mcs=1 if medcode==	40180
	replace urine_mcs=1 if medcode==	27003
	replace urine_mcs=1 if medcode==	49970
	replace urine_mcs=1 if medcode==	13922
	replace urine_mcs=1 if medcode==	13911
	replace urine_mcs=1 if medcode==	42184
	replace urine_mcs=1 if medcode==	40903
	replace urine_mcs=1 if medcode==	13918
	replace urine_mcs=1 if enttype==403
	replace urine_mcs=1 if enttype==227 ///
	 | enttype==484

	* 22. vaginal swab
	gen vaginal_swab=0
	replace vaginal_swab=1 if medcode==	3379
	replace vaginal_swab=1 if medcode==	14522
	replace vaginal_swab=1 if medcode==	13959
	replace vaginal_swab=1 if medcode==	13946
	replace vaginal_swab=1 if medcode==	13945
	replace vaginal_swab=1 if medcode==	42615
	replace vaginal_swab=1 if medcode==	33295
	replace vaginal_swab=1 if medcode==	13947
	replace vaginal_swab=1 if medcode==	27253
	replace vaginal_swab=1 if medcode==	27062
	replace vaginal_swab=1 if medcode==	94015
	replace vaginal_swab=1 if medcode==	8251
	replace vaginal_swab=1 if medcode==	11302
	replace vaginal_swab=1 if enttype==243 | enttype==249
	*243 - High vaginal swab
	*249 - Vaginal swab

	keep patid medcode enttype event_date pelvic_ct-vaginal_swab
	
	keep if pelvic_ct==1 | pelvic_us==1  | pelvic_mri==1 |  ///
		urine_dipstick==1 | urine_mcs==1 | vaginal_swab==1

	save "${data}\extract_tests_`file'", replace
}

use "${data}\extract_tests_clinical1_all" , clear
append using "${data}\extract_tests_clinical2_all", 

save "${data}\extract_tests_clinical_all", replace

log close
*****************************************************************************
**TEST FILES**

log using "${logs}\extract_all_tests_cprd_test_file.txt", text
	
foreach file in 1 2 {
	use "${source}\\test`file'_all.dta", clear
	merge m:1 patid using "${save}\patient_format.dta"
	drop if _merge==1
	drop if _merge==2
	drop _merge

	gen event_date=date(eventdate, "DMY") 
	format event_date %td
	
	sort patid event_date

	* 20. pelvic CT
	gen pelvic_ct=0
	replace pelvic_ct=1 if medcode==	101033
	replace pelvic_ct=1 if medcode==	100939
	replace pelvic_ct=1 if medcode==	14218
	replace pelvic_ct=1 if medcode==	101000
	replace pelvic_ct=1 if medcode==	91437
	
	/*introduced in - 
101030	Dec 2010	
100939	Nov 2010	
14218	Feb 09		
10100	Nov 2010	
91437	Feb 09		
*seem to have no events prior to 2012.

*/ 

	* 21 pelvic ultrasound - 
	*tighter list that excludes the antenatal ones. 
	gen pelvic_us=0
	replace pelvic_us=1 if medcode==	103473
	replace pelvic_us=1 if medcode==	12871
	replace pelvic_us=1 if medcode==	696
	replace pelvic_us=1 if medcode==	13992
	replace pelvic_us=1 if medcode==	10814
	replace pelvic_us=1 if medcode==	103497
	replace pelvic_us=1 if medcode==	55021
	*237	Abdominal ultra sound
	replace pelvic_us=1 if enttype==	237 
	*238	Pelvic ultra sound
	replace pelvic_us=1 if enttype==	238

	*PELVIS MRI
	gen pelvic_mri=0
	replace pelvic_mri=1 if medcode==97243
			
	** URINALYSIS **
	* 20 urine dipstick
	gen urine_dipstick=0
	replace urine_dipstick=1 if medcode==	13606
	replace urine_dipstick=1 if medcode==	13927
	replace urine_dipstick=1 if medcode==	35590
	replace urine_dipstick=1 if medcode==	55158
	replace urine_dipstick=1 if medcode==	13610
	replace urine_dipstick=1 if medcode==	27005
	replace urine_dipstick=1 if medcode==	13924
	replace urine_dipstick=1 if medcode==	13940
	replace urine_dipstick=1 if medcode==	55140
	replace urine_dipstick=1 if medcode==	13615
	replace urine_dipstick=1 if medcode==	13595
	replace urine_dipstick=1 if medcode==	13937
	replace urine_dipstick=1 if medcode==	13601
	replace urine_dipstick=1 if medcode==	13594
	replace urine_dipstick=1 if medcode==	14088
	replace urine_dipstick=1 if medcode==	33302
	replace urine_dipstick=1 if medcode==	43
	replace urine_dipstick=1 if medcode==	14091
	replace urine_dipstick=1 if medcode==	14395
	replace urine_dipstick=1 if medcode==	13612
	replace urine_dipstick=1 if medcode==	13590
	replace urine_dipstick=1 if medcode==	27214
	replace urine_dipstick=1 if medcode==	14094
	replace urine_dipstick=1 if medcode==	8482
	replace urine_dipstick=1 if medcode==	14383
	replace urine_dipstick=1 if medcode==	13611
	replace urine_dipstick=1 if medcode==	44179
	replace urine_dipstick=1 if medcode==	14382
	replace urine_dipstick=1 if medcode==	13621
	replace urine_dipstick=1 if medcode==	43262
	replace urine_dipstick=1 if medcode==	13600
	replace urine_dipstick=1 if medcode==	27059
	replace urine_dipstick=1 if medcode==	13613
	replace urine_dipstick=1 if medcode==	39243
	replace urine_dipstick=1 if medcode==	47131
	replace urine_dipstick=1 if medcode==	34842
	replace urine_dipstick=1 if medcode==	13939
	replace urine_dipstick=1 if medcode==	4393
	replace urine_dipstick=1 if medcode==	6878
	replace urine_dipstick=1 if medcode==	8741
	replace urine_dipstick=1 if medcode==	14561
	replace urine_dipstick=1 if medcode==	9430
	replace urine_dipstick=1 if medcode==	13936
	replace urine_dipstick=1 if medcode==	13910
	replace urine_dipstick=1 if medcode==	14562
	replace urine_dipstick=1 if medcode==	43523
	replace urine_dipstick=1 if medcode==	39212
	replace urine_dipstick=1 if medcode==	42
	replace urine_dipstick=1 if enttype== 430 ///
	 | enttype==431 | enttype==432 | enttype==433 ///
	 | enttype==434 | enttype==473
	replace urine_dipstick=1 if enttype==286 ///
	 | enttype==287 | enttype==340
	 
	* 21. urine MCS
	gen urine_mcs=0
	replace urine_mcs=1 if medcode==	10891
	replace urine_mcs=1 if medcode==	38204
	replace urine_mcs=1 if medcode==	13935
	replace urine_mcs=1 if medcode==	41079
	replace urine_mcs=1 if medcode==	13622
	replace urine_mcs=1 if medcode==	13920
	replace urine_mcs=1 if medcode==	13914
	replace urine_mcs=1 if medcode==	13912
	replace urine_mcs=1 if medcode==	13923
	replace urine_mcs=1 if medcode==	19113
	replace urine_mcs=1 if medcode==	41078
	replace urine_mcs=1 if medcode==	29463
	replace urine_mcs=1 if medcode==	13915
	replace urine_mcs=1 if medcode==	13916
	replace urine_mcs=1 if medcode==	38205
	replace urine_mcs=1 if medcode==	16273
	replace urine_mcs=1 if medcode==	19791
	replace urine_mcs=1 if medcode==	30877
	replace urine_mcs=1 if medcode==	17531
	replace urine_mcs=1 if medcode==	39644
	replace urine_mcs=1 if medcode==	14517
	replace urine_mcs=1 if medcode==	39371
	replace urine_mcs=1 if medcode==	32332
	replace urine_mcs=1 if medcode==	23294
	replace urine_mcs=1 if medcode==	29628
	replace urine_mcs=1 if medcode==	16511
	replace urine_mcs=1 if medcode==	16380
	replace urine_mcs=1 if medcode==	9534
	replace urine_mcs=1 if medcode==	37211
	replace urine_mcs=1 if medcode==	13874
	replace urine_mcs=1 if medcode==	13873
	replace urine_mcs=1 if medcode==	27009
	replace urine_mcs=1 if medcode==	13921
	replace urine_mcs=1 if medcode==	13917
	replace urine_mcs=1 if medcode==	27000
	replace urine_mcs=1 if medcode==	23509
	replace urine_mcs=1 if medcode==	47177
	replace urine_mcs=1 if medcode==	27004
	replace urine_mcs=1 if medcode==	55744
	replace urine_mcs=1 if medcode==	40180
	replace urine_mcs=1 if medcode==	27003
	replace urine_mcs=1 if medcode==	49970
	replace urine_mcs=1 if medcode==	13922
	replace urine_mcs=1 if medcode==	13911
	replace urine_mcs=1 if medcode==	42184
	replace urine_mcs=1 if medcode==	40903
	replace urine_mcs=1 if medcode==	13918
	replace urine_mcs=1 if enttype==403
	replace urine_mcs=1 if enttype==227 ///
	 | enttype==484

	* 22. vaginal swab
	gen vaginal_swab=0
	replace vaginal_swab=1 if medcode==	3379
	replace vaginal_swab=1 if medcode==	14522
	replace vaginal_swab=1 if medcode==	13959
	replace vaginal_swab=1 if medcode==	13946
	replace vaginal_swab=1 if medcode==	13945
	replace vaginal_swab=1 if medcode==	42615
	replace vaginal_swab=1 if medcode==	33295
	replace vaginal_swab=1 if medcode==	13947
	replace vaginal_swab=1 if medcode==	27253
	replace vaginal_swab=1 if medcode==	27062
	replace vaginal_swab=1 if medcode==	94015
	replace vaginal_swab=1 if medcode==	8251
	replace vaginal_swab=1 if medcode==	11302
	replace vaginal_swab=1 if enttype==243 | enttype==249
	*243 - High vaginal swab
	*249 - Vaginal swab

	keep patid medcode enttype event_date pelvic_ct-vaginal_swab
	
	keep if pelvic_ct==1 | pelvic_us==1 | pelvic_mri==1 |  ///
			urine_dipstick==1 | urine_mcs==1 | vaginal_swab==1

		*FILE 1 - drops from 42,238,866 rows to.... 2,475,553
	save "${data}\extract_tests_`file'", replace
}

log close

******************************************************************************
****referrals for scans****
*****************************************************************************
log using "${logs}\extract_all_tests_cprd_referral_file.txt", text

use "${source}\\referral.dta", clear
merge m:1 patid using "${save}\patient_format.dta"
drop if _merge==1
drop if _merge==2
drop _merge

gen event_date=date(eventdate, "DMY") 
format event_date %td

*** DIRECT COPY AND PASTE BELOW, AND THEN REMOVE THE ENTTYPE LINES OF CODE ***

	sort patid event_date


	* 20. pelvic CT
	gen pelvic_ct=0
	replace pelvic_ct=1 if medcode==	101033
	replace pelvic_ct=1 if medcode==	100939
	replace pelvic_ct=1 if medcode==	14218
	replace pelvic_ct=1 if medcode==	101000
	replace pelvic_ct=1 if medcode==	91437
	 
	* 21 pelvic ultrasound 
	*tighter list that excludes the antenatal ones. 
	gen pelvic_us=0
	replace pelvic_us=1 if medcode==	103473
	replace pelvic_us=1 if medcode==	12871
	replace pelvic_us=1 if medcode==	696
	replace pelvic_us=1 if medcode==	13992
	replace pelvic_us=1 if medcode==	10814
	replace pelvic_us=1 if medcode==	103497
	replace pelvic_us=1 if medcode==	55021
	*237	Abdominal ultra sound
	*replace pelvic_us=1 if enttype==	237 
	*238	Pelvic ultra sound
	*replace pelvic_us=1 if enttype==	238

	*PELVIS MRI
	gen pelvic_mri=0
	replace pelvic_mri=1 if medcode==97243
		
	** URINALYSIS **
	* 20 urine dipstick
	gen urine_dipstick=0
	replace urine_dipstick=1 if medcode==	13606
	replace urine_dipstick=1 if medcode==	13927
	replace urine_dipstick=1 if medcode==	35590
	replace urine_dipstick=1 if medcode==	55158
	replace urine_dipstick=1 if medcode==	13610
	replace urine_dipstick=1 if medcode==	27005
	replace urine_dipstick=1 if medcode==	13924
	replace urine_dipstick=1 if medcode==	13940
	replace urine_dipstick=1 if medcode==	55140
	replace urine_dipstick=1 if medcode==	13615
	replace urine_dipstick=1 if medcode==	13595
	replace urine_dipstick=1 if medcode==	13937
	replace urine_dipstick=1 if medcode==	13601
	replace urine_dipstick=1 if medcode==	13594
	replace urine_dipstick=1 if medcode==	14088
	replace urine_dipstick=1 if medcode==	33302
	replace urine_dipstick=1 if medcode==	43
	replace urine_dipstick=1 if medcode==	14091
	replace urine_dipstick=1 if medcode==	14395
	replace urine_dipstick=1 if medcode==	13612
	replace urine_dipstick=1 if medcode==	13590
	replace urine_dipstick=1 if medcode==	27214
	replace urine_dipstick=1 if medcode==	14094
	replace urine_dipstick=1 if medcode==	8482
	replace urine_dipstick=1 if medcode==	14383
	replace urine_dipstick=1 if medcode==	13611
	replace urine_dipstick=1 if medcode==	44179
	replace urine_dipstick=1 if medcode==	14382
	replace urine_dipstick=1 if medcode==	13621
	replace urine_dipstick=1 if medcode==	43262
	replace urine_dipstick=1 if medcode==	13600
	replace urine_dipstick=1 if medcode==	27059
	replace urine_dipstick=1 if medcode==	13613
	replace urine_dipstick=1 if medcode==	39243
	replace urine_dipstick=1 if medcode==	47131
	replace urine_dipstick=1 if medcode==	34842
	replace urine_dipstick=1 if medcode==	13939
	replace urine_dipstick=1 if medcode==	4393
	replace urine_dipstick=1 if medcode==	6878
	replace urine_dipstick=1 if medcode==	8741
	replace urine_dipstick=1 if medcode==	14561
	replace urine_dipstick=1 if medcode==	9430
	replace urine_dipstick=1 if medcode==	13936
	replace urine_dipstick=1 if medcode==	13910
	replace urine_dipstick=1 if medcode==	14562
	replace urine_dipstick=1 if medcode==	43523
	replace urine_dipstick=1 if medcode==	39212
	replace urine_dipstick=1 if medcode==	42
/*	replace urine_dipstick=1 if enttype== 430 ///
	 | enttype==431 | enttype==432 | enttype==433 ///
	 | enttype==434 | enttype==473
	replace urine_dipstick=1 if enttype==286 ///
	 | enttype==287 | enttype==340
	*/ 
	* 21. urine MCS
	gen urine_mcs=0
	replace urine_mcs=1 if medcode==	10891
	replace urine_mcs=1 if medcode==	38204
	replace urine_mcs=1 if medcode==	13935
	replace urine_mcs=1 if medcode==	41079
	replace urine_mcs=1 if medcode==	13622
	replace urine_mcs=1 if medcode==	13920
	replace urine_mcs=1 if medcode==	13914
	replace urine_mcs=1 if medcode==	13912
	replace urine_mcs=1 if medcode==	13923
	replace urine_mcs=1 if medcode==	19113
	replace urine_mcs=1 if medcode==	41078
	replace urine_mcs=1 if medcode==	29463
	replace urine_mcs=1 if medcode==	13915
	replace urine_mcs=1 if medcode==	13916
	replace urine_mcs=1 if medcode==	38205
	replace urine_mcs=1 if medcode==	16273
	replace urine_mcs=1 if medcode==	19791
	replace urine_mcs=1 if medcode==	30877
	replace urine_mcs=1 if medcode==	17531
	replace urine_mcs=1 if medcode==	39644
	replace urine_mcs=1 if medcode==	14517
	replace urine_mcs=1 if medcode==	39371
	replace urine_mcs=1 if medcode==	32332
	replace urine_mcs=1 if medcode==	23294
	replace urine_mcs=1 if medcode==	29628
	replace urine_mcs=1 if medcode==	16511
	replace urine_mcs=1 if medcode==	16380
	replace urine_mcs=1 if medcode==	9534
	replace urine_mcs=1 if medcode==	37211
	replace urine_mcs=1 if medcode==	13874
	replace urine_mcs=1 if medcode==	13873
	replace urine_mcs=1 if medcode==	27009
	replace urine_mcs=1 if medcode==	13921
	replace urine_mcs=1 if medcode==	13917
	replace urine_mcs=1 if medcode==	27000
	replace urine_mcs=1 if medcode==	23509
	replace urine_mcs=1 if medcode==	47177
	replace urine_mcs=1 if medcode==	27004
	replace urine_mcs=1 if medcode==	55744
	replace urine_mcs=1 if medcode==	40180
	replace urine_mcs=1 if medcode==	27003
	replace urine_mcs=1 if medcode==	49970
	replace urine_mcs=1 if medcode==	13922
	replace urine_mcs=1 if medcode==	13911
	replace urine_mcs=1 if medcode==	42184
	replace urine_mcs=1 if medcode==	40903
	replace urine_mcs=1 if medcode==	13918
	/*replace urine_mcs=1 if enttype==403
	replace urine_mcs=1 if enttype==227  | enttype==484
	*/

	* 22. vaginal swab
	gen vaginal_swab=0
	replace vaginal_swab=1 if medcode==	3379
	replace vaginal_swab=1 if medcode==	14522
	replace vaginal_swab=1 if medcode==	13959
	replace vaginal_swab=1 if medcode==	13946
	replace vaginal_swab=1 if medcode==	13945
	replace vaginal_swab=1 if medcode==	42615
	replace vaginal_swab=1 if medcode==	33295
	replace vaginal_swab=1 if medcode==	13947
	replace vaginal_swab=1 if medcode==	27253
	replace vaginal_swab=1 if medcode==	27062
	replace vaginal_swab=1 if medcode==	94015
	replace vaginal_swab=1 if medcode==	8251
	replace vaginal_swab=1 if medcode==	11302
	*replace vaginal_swab=1 if enttype==243 | enttype==249
	*243 - High vaginal swab
	*249 - Vaginal swab

	keep patid medcode event_date pelvic_ct-vaginal_swab

		
	keep if pelvic_ct==1 | pelvic_us==1 | pelvic_mri==1 |  ///
		urine_dipstick==1 | urine_mcs==1 | vaginal_swab==1

	save "${data}\extract_tests_referral", replace


log close
