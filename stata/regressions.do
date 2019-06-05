*************************************************************
***REGRESSIONS SECTION 5.2****************
*************************************************************

label variable minPriceTsuchiura "policy_change"

*label variable cartelTsuchiura "long_run_Tsuchiura"
*label variable cartelTsuchiuraXpolicy "long_run_Tsuchiura X policy_change"


**TABLE 4

eststo m1: reg norm_bid_trimmed minPriceTsuchiura lngdp tt_city* i.month i.year i.city if winner==1 & [city ==1  | city==3 | city==2  & date<mdy(4,1,2014)]
eststo m2: reg norm_bid_trimmed minPriceTsuchiura lngdp tt_city* i.month i.year i.city if winner==1 & [city ==1  | city==3 | city==2  & date<mdy(4,1,2014)] & norm_bid_trimmed>0.8
eststo m3: qreg norm_bid_trimmed minPriceTsuchiura lngdp tt_city* i.month i.year i.city if winner==1 & [city ==1  | city==3 | city==2  & date<mdy(4,1,2014)] & norm_bid_trimmed>0.8, quantile(10)
eststo m4: qreg norm_bid_trimmed minPriceTsuchiura lngdp tt_city* i.month i.year i.city if winner==1 & [city ==1  | city==3 | city==2  & date<mdy(4,1,2014)] & norm_bid_trimmed>0.8, quantile(20)
eststo m5: qreg norm_bid_trimmed minPriceTsuchiura lngdp tt_city* i.month i.year i.city if winner==1 & [city ==1  | city==3 | city==2  & date<mdy(4,1,2014)] & norm_bid_trimmed>0.8, quantile(40)
eststo m6: qreg norm_bid_trimmed minPriceTsuchiura lngdp tt_city* i.month i.year i.city if winner==1 & [city ==1  | city==3 | city==2  & date<mdy(4,1,2014)] & norm_bid_trimmed>0.8, quantile(60)
eststo m7: qreg norm_bid_trimmed minPriceTsuchiura lngdp tt_city* i.month i.year i.city if winner==1 & [city ==1  | city==3 | city==2  & date<mdy(4,1,2014)] & norm_bid_trimmed>0.8, quantile(80)

  
estout m1 m2 m4 m5 m6 m7 using table4.tex, style(tex) replace label ///
  keep(minPriceTsuchiura lngdp) stats(r2 N) prefoot("\hline") mlabels(, none) ///
  collabels(, none) cells(b(star fmt(3)) se(par fmt(3))) ///
  starlevels ($^{*}$ 0.1 $^{**}$ 0.05 $^{***}$ 0.01) ///
  substitute(_ \_)



label variable minPriceTsuchiura "policy_change"
label variable cartel_broad "long_run"
label variable minPriceXcartel_broad "long_run X policy_change"

*Table 5 -- columns 1 and 2

eststo m1: reg norm_bid_trimmed minPriceTsuchiura cartel_broad cartelBroadUshiku cartelBroadTsukuba minPriceXcartel_broad lngdp tt_city* i.month i.year i.city if winner==1 & [city ==1  | city==3 | city==2  & date<mdy(4,1,2014)]
eststo m2: reg norm_bid_trimmed minPriceTsuchiura cartel_broad cartelBroadUshiku cartelBroadTsukuba minPriceXcartel_broad lngdp tt_city* i.month i.year i.city if winner==1 & [city ==1  | city==3 | city==2  & date<mdy(4,1,2014)] & norm_bid_trimmed>0.8
  
estout m1 m2 using table5a.tex, style(tex) replace label ///
  keep(cartel_broad minPriceXcartel_broad minPriceTsuchiura) stats(r2 N) prefoot("\hline") mlabels(, none) ///
  collabels(, none) cells(b(star fmt(3)) se(par fmt(3))) ///
  starlevels ($^{*}$ 0.1 $^{**}$ 0.05 $^{***}$ 0.01) ///
  substitute(_ \_)

*Table 5 -- columns 3 and 4  
  
label variable cartel_participation "long_run"
label variable minPriceXcartel_participation "long_run X policy_change"

eststo m1: reg norm_bid_trimmed minPriceTsuchiura cartel_participation minPriceXcartel_participation lngdp tt_city* i.month i.year i.city if winner==1 & city ==1
eststo m2: reg norm_bid_trimmed minPriceTsuchiura cartel_participation minPriceXcartel_participation lngdp tt_city* i.month i.year i.city if winner==1 & city ==1 & norm_bid_trimmed>0.8
estout m1 m2 using table5b.tex, style(tex) replace label ///
  keep(cartel_participation minPriceXcartel_participation minPriceTsuchiura) stats(r2 N) prefoot("\hline") mlabels(, none) ///
  collabels(, none) cells(b(star fmt(3)) se(par fmt(3))) ///
  starlevels ($^{*}$ 0.1 $^{**}$ 0.05 $^{***}$ 0.01) ///
  substitute(_ \_)

  

**********************  
**Table 6: Aggregate regression
**********************   
eststo clear

set matsize 1000

global cartelCities cartelHit cartelInashiki cartelToride cartelTsuchiura ///
  cartelTsukuba cartelTsukubamirai

global cartelBroadCities cartelBroadHit cartelBroadInashiki cartelBroadToride cartelBroadTsuchiura ///
  cartelBroadTsukuba cartelBroadTsukubamirai cartelBroadUshiku cartelBroadSakuragawa cartelBroadKamisu cartelBroadShimotsuma cartelBroadKasumigaura
  

egen city_year = group(city year) 
egen group_year = group(group year)
egen group_month = group(group month)
egen group_city = group(group city)
egen group_cartel_broad = group(group cartel_broad)


label variable minPrice "policy_change"
label variable cartel_broad "long_run_winner"
label variable minPriceXcartel_broad "long_run_winner x policy_change"

  eststo clear

eststo m1: xi: reg norm_bid_trimmed minPrice lngdp i.group i.group*tt_city_id1 i.group*tt_city_id2 i.group*tt_city_id3 i.group*tt_city_id4 i.group*tt_city_id5 i.group*tt_city_id6 i.group*tt_city_id7 i.group*tt_city_id8 i.group*tt_city_id9 i.group*tt_city_id10 i.group*tt_city_id11 i.group*tt_city_id12 i.group*tt_city_id13 i.group*tt_city_id14 i.group*i.year i.group*i.month i.group*i.city if winner==1  & citiesUsed==1, cluster(city_year)
eststo m2: xi: reg norm_bid_trimmed minPrice lngdp i.group i.group*tt_city_id1 i.group*tt_city_id2 i.group*tt_city_id3 i.group*tt_city_id4 i.group*tt_city_id5 i.group*tt_city_id6 i.group*tt_city_id7 i.group*tt_city_id8 i.group*tt_city_id9 i.group*tt_city_id10 i.group*tt_city_id11 i.group*tt_city_id12 i.group*tt_city_id13 i.group*tt_city_id14 i.group*i.year i.group*i.month i.group*i.city if winner==1  & citiesUsed==1 & norm_bid_trimmed>0.8, cluster(city_year)
eststo m3: xi: reg norm_bid_trimmed cartel_broad cartelBroadHit cartelBroadInashiki cartelBroadToride cartelBroadTsuchiura cartelBroadTsukuba cartelBroadTsukubamirai cartelBroadUshiku cartelBroadSakuragawa cartelBroadKamisu cartelBroadShimotsuma cartelBroadKasumigaura minPriceXcartel_broad  minPrice lngdp i.group i.group*cartel_broad i.group*tt_city_id1 i.group*tt_city_id2 i.group*tt_city_id3 i.group*tt_city_id4 i.group*tt_city_id5 i.group*tt_city_id6 i.group*tt_city_id7 i.group*tt_city_id8 i.group*tt_city_id9 i.group*tt_city_id10 i.group*tt_city_id11 i.group*tt_city_id12 i.group*tt_city_id13 i.group*tt_city_id14 i.group*i.year i.group*i.month i.group*i.city if winner==1  & citiesUsed==1, cluster(city_year)
eststo m4: xi: reg norm_bid_trimmed cartel_broad cartelBroadHit cartelBroadInashiki cartelBroadToride cartelBroadTsuchiura cartelBroadTsukuba cartelBroadTsukubamirai cartelBroadUshiku cartelBroadSakuragawa cartelBroadKamisu cartelBroadShimotsuma cartelBroadKasumigaura minPriceXcartel_broad  minPrice lngdp i.group i.group*cartel_broad i.group*tt_city_id1 i.group*tt_city_id2 i.group*tt_city_id3 i.group*tt_city_id4 i.group*tt_city_id5 i.group*tt_city_id6 i.group*tt_city_id7 i.group*tt_city_id8 i.group*tt_city_id9 i.group*tt_city_id10 i.group*tt_city_id11 i.group*tt_city_id12 i.group*tt_city_id13 i.group*tt_city_id14 i.group*i.year i.group*i.month i.group*i.city if winner==1  & citiesUsed==1 & norm_bid_trimmed>0.8, cluster(city_year)
estout m1 m3 m2 m4 using Aggregate.tex, style(tex) replace label ///
  keep(minPrice minPriceXcartel_broad) stats(r2 N) prefoot("\hline") mlabels(, none) ///
  collabels(, none) cells(b(star fmt(3)) se(par fmt(3))) ///
  starlevels ($^{*}$ 0.1 $^{**}$ 0.05 $^{***}$ 0.01) ///
  substitute(_ \_)  
  

  
*Bootstrapped standard errors
* on minimum price:
xi: cgmwildboot norm_bid_trimmed minPrice lngdp tt_city_id* i.group_year ///
  i.group_month i.group_city ///
  if winner == 1  & citiesUsed == 1, ///
  cluster(city_year) bootcluster(city_year) reps(999) seed(4381)

  
* same as above with truncated norm_bid:
xi: cgmwildboot norm_bid_trimmed minPrice lngdp tt_city_id* i.group_year ///
  i.group_month i.group_city ///
  if winner == 1  & citiesUsed == 1 & norm_bid_trimmed > 0.8, ///
  cluster(city_year) bootcluster(city_year) reps(999) seed(4381)

  
* on cartel and interaction with minPrice:
xi: cgmwildboot norm_bid_trimmed cartel_broad $cartelBroadCities minPriceXcartel_broad ///
  minPrice lngdp tt_city_id* i.group_cartel_broad i.group_year i.group_month ///
  i.group_city if winner == 1 & citiesUsed == 1, ///
  cluster(city_year) bootcluster(city_year) reps(999) seed(4381)

* same as above with truncated norm_bid:
xi: cgmwildboot norm_bid_trimmed cartel_broad $cartelBroadCities minPriceXcartel_broad ///
  minPrice lngdp tt_city_id* i.group_cartel_broad i.group_year i.group_month ///
  i.group_city if winner == 1 & citiesUsed == 1 & norm_bid_trimmed > 0.8, ///
  cluster(city_year) bootcluster(city_year) reps(999) seed(4381)   

  
  
****************
*ONLINE APPENDIX****
****************

*TABLE OA.1

label variable minPriceTsuchiura "policy_change"
label variable lngdp "ln_gdp"
*label variable minPriceXcartel "cartel_winner x policy_change"


eststo m1: reg norm_bid_trimmed minPriceTsuchiura lngdp year i.month if city==1 & winner==1
eststo m2: reg norm_bid_trimmed minPriceTsuchiura lngdp year i.month  if city==1 & winner==1 & norm_bid>0.8
eststo m3: qreg norm_bid_trimmed minPriceTsuchiura lngdp year i.month  if city==1 & winner==1 & norm_bid>0.8, quantile(10)
eststo m4: qreg norm_bid_trimmed minPriceTsuchiura lngdp year i.month  if city==1 & winner==1 & norm_bid>0.8, quantile(20)
eststo m5: qreg norm_bid_trimmed minPriceTsuchiura lngdp year i.month  if city==1 & winner==1 & norm_bid>0.8, quantile(40)
eststo m6: qreg norm_bid_trimmed minPriceTsuchiura lngdp year i.month  if city==1 & winner==1 & norm_bid>0.8, quantile(60)
eststo m7: qreg norm_bid_trimmed minPriceTsuchiura lngdp year i.month  if city==1 & winner==1 & norm_bid>0.8, quantile(80)

estout m1 m2 m4 m5 m6 m7 using tableA1.tex, style(tex) replace label ///
  keep(minPriceTsuchiura lngdp year) stats(r2 N) prefoot("\hline") mlabels(, none) ///
  collabels(, none) cells(b(star fmt(3)) se(par fmt(3))) ///
  starlevels ($^{*}$ 0.1 $^{**}$ 0.05 $^{***}$ 0.01) ///
  substitute(_ \_)
  

*TABLE OA.2

label variable numbidders "num_bidders"
label variable numentrants "num_entrants"
eststo clear
eststo m1: reg numentrants minPriceTsuchiura lngdp year i.month if city==1 & winner==1
eststo m2: reg numbidders minPriceTsuchiura lngdp year i.month  if city==1 & winner==1
eststo m3: reg numbidders minPriceTsuchiura lngdp year i.month numentrants if city==1 & winner==1 
eststo m4: reg numbidders minPriceTsuchiura lngdp year i.month numentrants ln_reserve if city==1 & winner==1 

estout m1 m2 m3 m4 using tableA2.tex, style(tex) replace label ///
  keep(numentrants minPriceTsuchiura lngdp year numentrants ln_reserve) stats(r2 N) prefoot("\hline") mlabels(, none) ///
  collabels(, none) cells(b(star fmt(3)) se(par fmt(3))) ///
  starlevels ($^{*}$ 0.1 $^{**}$ 0.05 $^{***}$ 0.01) ///
  substitute(_ \_)


*TABLE OA.3 -- see end of do file  
      

************************************************
*** Difference in Difference: All policy groups
*** Tables OA.4 and OA.5
************************************************

*Hitachiomiya
eststo clear
eststo m1: reg norm_bid_trimmed minPriceHit lngdp tt_city* i.month i.year i.city if winner==1 & [city ==4 | city==10 | city==6 & date>=mdy(7,10,2010)] 
eststo m2: reg norm_bid_trimmed minPriceHit lngdp tt_city* i.month i.year i.city if winner==1 & [city ==4 | city==10 | city==6 & date>=mdy(7,10,2010)] & norm_bid_trimmed>0.80
eststo m3: qreg norm_bid_trimmed minPriceHit lngdp tt_city* i.month i.year i.city if winner==1 & [city ==4 | city==10 | city==6 & date>=mdy(7,10,2010)] & norm_bid_trimmed>0.80, quantile(10)
eststo m4: qreg norm_bid_trimmed minPriceHit lngdp tt_city* i.month i.year i.city if winner==1 & [city ==4 | city==10 | city==6 & date>=mdy(7,10,2010)] & norm_bid_trimmed>0.80, quantile(20)
eststo m5: qreg norm_bid_trimmed minPriceHit lngdp tt_city* i.month i.year i.city if winner==1 & [city ==4 | city==10 | city==6 & date>=mdy(7,10,2010)] & norm_bid_trimmed>0.80, quantile(40)
eststo m6: qreg norm_bid_trimmed minPriceHit lngdp tt_city* i.month i.year i.city if winner==1 & [city ==4 | city==10 | city==6 & date>=mdy(7,10,2010)] & norm_bid_trimmed>0.80, quantile(60)
eststo m7: qreg norm_bid_trimmed minPriceHit lngdp tt_city* i.month i.year i.city if winner==1 & [city ==4 | city==10 | city==6 & date>=mdy(7,10,2010)] & norm_bid_trimmed>0.80, quantile(80)
  
estout m1 m2 m4 m5 m6 m7 using tableDIDHitachiomiya.tex, style(tex) replace label ///
  keep(minPriceHit) stats(r2 N) prefoot("\hline") mlabels(, none) ///
  collabels(, none) cells(b(star fmt(3)) se(par fmt(3))) ///
  starlevels ($^{*}$ 0.1 $^{**}$ 0.05 $^{***}$ 0.01) ///
  substitute(_ \_)

  
eststo clear
label variable cartel_broad "long_run"
label variable cartelBroadHit "long_run_Hitachiomiya"
label variable minPriceXcartel_broad "long_run X policy_change"

eststo m1: reg norm_bid_trimmed minPriceHit cartel_broad cartelBroadInashiki cartelBroadSakuragawa minPriceXcartel_broad lngdp tt_city* i.month i.year i.city if winner==1 & [city ==4 | city==10 | city==6 & date>=mdy(7,10,2010)] 
eststo m2: reg norm_bid_trimmed minPriceHit cartel_broad cartelBroadInashiki cartelBroadSakuragawa minPriceXcartel_broad lngdp tt_city* i.month i.year i.city if winner==1 & [city ==4 | city==10 | city==6 & date>=mdy(7,10,2010)] & norm_bid_trimmed>0.80 
eststo m3: qreg norm_bid_trimmed minPriceHit cartel_broad cartelBroadInashiki cartelBroadSakuragawa minPriceXcartel_broad  lngdp tt_city* i.month i.year i.city if winner==1 & [city ==4 | city==10 | city==6 & date>=mdy(7,10,2010)] & norm_bid_trimmed>0.80, quantile(10)
eststo m4: qreg norm_bid_trimmed minPriceHit cartel_broad cartelBroadInashiki cartelBroadSakuragawa minPriceXcartel_broad  lngdp tt_city* i.month i.year i.city if winner==1 & [city ==4 | city==10 | city==6 & date>=mdy(7,10,2010)] & norm_bid_trimmed>0.80, quantile(20)
eststo m5: qreg norm_bid_trimmed minPriceHit cartel_broad cartelBroadInashiki cartelBroadSakuragawa minPriceXcartel_broad  lngdp tt_city* i.month i.year i.city if winner==1 & [city ==4 | city==10 | city==6 & date>=mdy(7,10,2010)] & norm_bid_trimmed>0.80, quantile(40)
eststo m6: qreg norm_bid_trimmed minPriceHit cartel_broad cartelBroadInashiki cartelBroadSakuragawa minPriceXcartel_broad  lngdp tt_city* i.month i.year i.city if winner==1 & [city ==4 | city==10 | city==6 & date>=mdy(7,10,2010)] & norm_bid_trimmed>0.80, quantile(60)
eststo m7: qreg norm_bid_trimmed minPriceHit cartel_broad cartelBroadInashiki cartelBroadSakuragawa minPriceXcartel_broad  lngdp tt_city* i.month i.year i.city if winner==1 & [city ==4 | city==10 | city==6 & date>=mdy(7,10,2010)] & norm_bid_trimmed>0.80, quantile(80)
  
estout m1 m2 m4 m5 m6 m7 using tableDIDHitachiomiyaCartelBroad.tex, style(tex) replace label ///
  keep(minPriceHit cartel_broad minPriceXcartel_broad) stats(r2 N) prefoot("\hline") mlabels(, none) ///
  collabels(, none) cells(b(star fmt(3)) se(par fmt(3))) ///
  starlevels ($^{*}$ 0.1 $^{**}$ 0.05 $^{***}$ 0.01) ///
  substitute(_ \_)
  
  
  
*Inashiki
eststo clear

label variable minPriceInashiki "policy_change"

eststo m1: reg norm_bid_trimmed minPriceInashiki lngdp tt_city* i.month i.year i.city if winner==1 & [city ==4  & date<mdy(04,07,2011) | city==10 | city==6]
eststo m2: reg norm_bid_trimmed minPriceInashiki lngdp tt_city* i.month i.year i.city if winner==1 & [city ==4  & date<mdy(04,07,2011) | city==10 | city==6] & norm_bid_trimmed>0.80
eststo m3: qreg norm_bid_trimmed minPriceInashiki lngdp tt_city* i.month i.year i.city if winner==1 & [city ==4  & date<mdy(04,07,2011) | city==10 | city==6] & norm_bid_trimmed>0.8, quantile(10)
eststo m4: qreg norm_bid_trimmed minPriceInashiki lngdp tt_city* i.month i.year i.city if winner==1 & [city ==4  & date<mdy(04,07,2011) | city==10 | city==6] & norm_bid_trimmed>0.8, quantile(20)
eststo m5: qreg norm_bid_trimmed minPriceInashiki lngdp tt_city* i.month i.year i.city if winner==1 & [city ==4  & date<mdy(04,07,2011) | city==10 | city==6] & norm_bid_trimmed>0.8, quantile(40)
eststo m6: qreg norm_bid_trimmed minPriceInashiki lngdp tt_city* i.month i.year i.city if winner==1 & [city ==4  & date<mdy(04,07,2011) | city==10 | city==6] & norm_bid_trimmed>0.8, quantile(60)
eststo m7: qreg norm_bid_trimmed minPriceInashiki lngdp tt_city* i.month i.year i.city if winner==1 & [city ==4  & date<mdy(04,07,2011) | city==10 | city==6] & norm_bid_trimmed>0.8, quantile(80)
  
estout m1 m2 m4 m5 m6 m7 using tableDIDInashiki.tex, style(tex) replace label ///
  keep(minPriceInashiki) stats(r2 N) prefoot("\hline") mlabels(, none) ///
  collabels(, none) cells(b(star fmt(3)) se(par fmt(3))) ///
  starlevels ($^{*}$ 0.1 $^{**}$ 0.05 $^{***}$ 0.01) ///
  substitute(_ \_)
 

eststo clear


label variable cartelBroadInashiki "long_run_Inashiki"
label variable cartelBroadInashikiXpolicy "long_run_Inashiki X policy_change"

eststo m1: reg norm_bid_trimmed minPriceInashiki cartel_broad cartelBroadHit cartelBroadSakuragawa minPriceXcartel_broad lngdp tt_city* i.month i.year i.city if winner==1 & [city ==4  & date<mdy(04,07,2011) | city==10 | city==6]
eststo m2: reg norm_bid_trimmed minPriceInashiki cartel_broad cartelBroadHit cartelBroadSakuragawa minPriceXcartel_broad lngdp tt_city* i.month i.year i.city if winner==1 & [city ==4  & date<mdy(04,07,2011) | city==10 | city==6] & norm_bid_trimmed>0.8 
eststo m3: qreg norm_bid_trimmed minPriceInashiki cartel_broad cartelBroadHit cartelBroadSakuragawa minPriceXcartel_broad lngdp tt_city* i.month i.year i.city if winner==1 & [city ==4  & date<mdy(04,07,2011) | city==10 | city==6] & norm_bid_trimmed>0.8, quantile(10)
eststo m4: qreg norm_bid_trimmed minPriceInashiki cartel_broad cartelBroadHit cartelBroadSakuragawa minPriceXcartel_broad lngdp tt_city* i.month i.year i.city if winner==1 & [city ==4  & date<mdy(04,07,2011) | city==10 | city==6] & norm_bid_trimmed>0.8, quantile(20)
eststo m5: qreg norm_bid_trimmed minPriceInashiki cartel_broad cartelBroadHit cartelBroadSakuragawa minPriceXcartel_broad lngdp tt_city* i.month i.year i.city if winner==1 & [city ==4  & date<mdy(04,07,2011) | city==10 | city==6] & norm_bid_trimmed>0.8, quantile(40)
eststo m6: qreg norm_bid_trimmed minPriceInashiki cartel_broad cartelBroadHit cartelBroadSakuragawa minPriceXcartel_broad lngdp tt_city* i.month i.year i.city if winner==1 & [city ==4  & date<mdy(04,07,2011) | city==10 | city==6] & norm_bid_trimmed>0.8, quantile(60)
eststo m7: qreg norm_bid_trimmed minPriceInashiki cartel_broad cartelBroadHit cartelBroadSakuragawa minPriceXcartel_broad lngdp tt_city* i.month i.year i.city if winner==1 & [city ==4  & date<mdy(04,07,2011) | city==10 | city==6] & norm_bid_trimmed>0.8, quantile(80)
  
estout m1 m2 m4 m5 m6 m7 using tableDIDInashikiCartelBroad.tex, style(tex) replace label ///
  keep(minPriceInashiki cartel_broad minPriceXcartel_broad) stats(r2 N) prefoot("\hline") mlabels(, none) ///
  collabels(, none) cells(b(star fmt(3)) se(par fmt(3))) ///
  starlevels ($^{*}$ 0.1 $^{**}$ 0.05 $^{***}$ 0.01) ///
  substitute(_ \_)
  
  
*Toride
eststo clear
label variable minPriceToride "policy_change"

eststo m1: reg norm_bid_trimmed minPriceToride lngdp tt_city* i.month i.year i.city if winner==1 & [city ==12  | city==3 | city==1  & date>=mdy(10,29,2009)]
eststo m2: reg norm_bid_trimmed minPriceToride lngdp tt_city* i.month i.year i.city if winner==1 & [city ==12  | city==3 | city==1  & date>=mdy(10,29,2009)] & norm_bid_trimmed>0.8
eststo m3: qreg norm_bid_trimmed minPriceToride lngdp tt_city* i.month i.year i.city if winner==1 & [city ==12  | city==3 | city==1  & date>=mdy(10,29,2009)] & norm_bid_trimmed>0.8, quantile(10)
eststo m4: qreg norm_bid_trimmed minPriceToride lngdp tt_city* i.month i.year i.city if winner==1 & [city ==12  | city==3 | city==1  & date>=mdy(10,29,2009)] & norm_bid_trimmed>0.8, quantile(20)
eststo m5: qreg norm_bid_trimmed minPriceToride lngdp tt_city* i.month i.year i.city if winner==1 & [city ==12  | city==3 | city==1  & date>=mdy(10,29,2009)] & norm_bid_trimmed>0.8, quantile(40)
eststo m6: qreg norm_bid_trimmed minPriceToride lngdp tt_city* i.month i.year i.city if winner==1 & [city ==12  | city==3 | city==1  & date>=mdy(10,29,2009)] & norm_bid_trimmed>0.8, quantile(60)
eststo m7: qreg norm_bid_trimmed minPriceToride lngdp tt_city* i.month i.year i.city if winner==1 & [city ==12  | city==3 | city==1  & date>=mdy(10,29,2009)] & norm_bid_trimmed>0.8, quantile(80)
  
estout m1 m2 m4 m5 m6 m7 using tableDIDToride.tex, style(tex) replace label ///
  keep(minPriceToride) stats(r2 N) prefoot("\hline") mlabels(, none) ///
  collabels(, none) cells(b(star fmt(3)) se(par fmt(3))) ///
  starlevels ($^{*}$ 0.1 $^{**}$ 0.05 $^{***}$ 0.01) ///
  substitute(_ \_)

eststo clear

label variable cartelBroadToride "long_run_Toride"
label variable cartelBroadTorideXpolicy "long_run_Toride X policy_change"


eststo m1: reg norm_bid_trimmed minPriceToride cartel_broad cartelBroadUshiku cartelBroadTsuchiura minPriceXcartel_broad lngdp tt_city* i.month i.year i.city if winner==1 & [city ==12  | city==3 | city==1  & date>=mdy(10,29,2009)]
eststo m2: reg norm_bid_trimmed minPriceToride cartel_broad cartelBroadUshiku cartelBroadTsuchiura minPriceXcartel_broad lngdp tt_city* i.month i.year i.city if winner==1 & [city ==12  | city==3 | city==1  & date>=mdy(10,29,2009)] & norm_bid_trimmed>0.8
eststo m3: qreg norm_bid_trimmed minPriceToride cartel_broad cartelBroadUshiku cartelBroadTsuchiura minPriceXcartel_broad lngdp tt_city* i.month i.year i.city if winner==1 & [city ==12  | city==3 | city==1  & date>=mdy(10,29,2009)] & norm_bid_trimmed>0.8, quantile(10)
eststo m4: qreg norm_bid_trimmed minPriceToride cartel_broad cartelBroadUshiku cartelBroadTsuchiura minPriceXcartel_broad lngdp tt_city* i.month i.year i.city if winner==1 & [city ==12  | city==3 | city==1  & date>=mdy(10,29,2009)] & norm_bid_trimmed>0.8, quantile(20)
eststo m5: qreg norm_bid_trimmed minPriceToride cartel_broad cartelBroadUshiku cartelBroadTsuchiura minPriceXcartel_broad lngdp tt_city* i.month i.year i.city if winner==1 & [city ==12  | city==3 | city==1  & date>=mdy(10,29,2009)] & norm_bid_trimmed>0.8, quantile(40)
eststo m6: qreg norm_bid_trimmed minPriceToride cartel_broad cartelBroadUshiku cartelBroadTsuchiura minPriceXcartel_broad lngdp tt_city* i.month i.year i.city if winner==1 & [city ==12  | city==3 | city==1  & date>=mdy(10,29,2009)] & norm_bid_trimmed>0.8, quantile(60)
eststo m7: qreg norm_bid_trimmed minPriceToride cartel_broad cartelBroadUshiku cartelBroadTsuchiura minPriceXcartel_broad lngdp tt_city* i.month i.year i.city if winner==1 & [city ==12  | city==3 | city==1  & date>=mdy(10,29,2009)] & norm_bid_trimmed>0.8, quantile(80)

  
estout m1 m2 m4 m5 m6 m7 using tableDIDTorideCartelBroad.tex, style(tex) replace label ///
  keep(minPriceToride cartel_broad minPriceXcartel_broad) stats(r2 N) prefoot("\hline") mlabels(, none) ///
  collabels(, none) cells(b(star fmt(3)) se(par fmt(3))) ///
  starlevels ($^{*}$ 0.1 $^{**}$ 0.05 $^{***}$ 0.01) ///
  substitute(_ \_)

    
  
*Tsuchiura
eststo clear
label variable minPriceTsuchiura "policy_change"

eststo m1: reg norm_bid_trimmed minPriceTsuchiura lngdp tt_city* i.month i.year i.city if winner==1 & [city ==1  | city==3 | city==2  & date<mdy(4,1,2014)]
eststo m2: reg norm_bid_trimmed minPriceTsuchiura lngdp tt_city* i.month i.year i.city if winner==1 & [city ==1  | city==3 | city==2  & date<mdy(4,1,2014)] & norm_bid_trimmed>0.8
eststo m3: qreg norm_bid_trimmed minPriceTsuchiura lngdp tt_city* i.month i.year i.city if winner==1 & [city ==1  | city==3 | city==2  & date<mdy(4,1,2014)] & norm_bid_trimmed>0.8, quantile(10)
eststo m4: qreg norm_bid_trimmed minPriceTsuchiura lngdp tt_city* i.month i.year i.city if winner==1 & [city ==1  | city==3 | city==2  & date<mdy(4,1,2014)] & norm_bid_trimmed>0.8, quantile(20)
eststo m5: qreg norm_bid_trimmed minPriceTsuchiura lngdp tt_city* i.month i.year i.city if winner==1 & [city ==1  | city==3 | city==2  & date<mdy(4,1,2014)] & norm_bid_trimmed>0.8, quantile(40)
eststo m6: qreg norm_bid_trimmed minPriceTsuchiura lngdp tt_city* i.month i.year i.city if winner==1 & [city ==1  | city==3 | city==2  & date<mdy(4,1,2014)] & norm_bid_trimmed>0.8, quantile(60)
eststo m7: qreg norm_bid_trimmed minPriceTsuchiura lngdp tt_city* i.month i.year i.city if winner==1 & [city ==1  | city==3 | city==2  & date<mdy(4,1,2014)] & norm_bid_trimmed>0.8, quantile(80)
  
estout m1 m2 m4 m5 m6 m7 using tableDIDTsuchiura.tex, style(tex) replace label ///
  keep(minPriceTsuchiura ) stats(r2 N) prefoot("\hline") mlabels(, none) ///
  collabels(, none) cells(b(star fmt(3)) se(par fmt(3))) ///
  starlevels ($^{*}$ 0.1 $^{**}$ 0.05 $^{***}$ 0.01) ///
  substitute(_ \_)

  

eststo clear

label variable cartelBroadTsuchiura "long_run_Tsuchiura"
label variable cartelBroadTsuchiuraXpolicy "long_run_Tsuchiura X policy_change"

eststo m1: reg norm_bid_trimmed minPriceTsuchiura cartel_broad cartelBroadUshiku cartelBroadTsukuba minPriceXcartel_broad lngdp tt_city* i.month i.year i.city if winner==1 & [city ==1  | city==3 | city==2  & date<mdy(4,1,2014)]
eststo m2: reg norm_bid_trimmed minPriceTsuchiura cartel_broad cartelBroadUshiku cartelBroadTsukuba minPriceXcartel_broad lngdp tt_city* i.month i.year i.city if winner==1 & [city ==1  | city==3 | city==2  & date<mdy(4,1,2014)] & norm_bid_trimmed>0.8
eststo m3: qreg norm_bid_trimmed minPriceTsuchiura cartel_broad cartelBroadUshiku cartelBroadTsukuba minPriceXcartel_broad lngdp tt_city* i.month i.year i.city if winner==1 & [city ==1  | city==3 | city==2  & date<mdy(4,1,2014)] & norm_bid_trimmed>0.8, quantile(10)
eststo m4: qreg norm_bid_trimmed minPriceTsuchiura cartel_broad cartelBroadUshiku cartelBroadTsukuba minPriceXcartel_broad lngdp tt_city* i.month i.year i.city if winner==1 & [city ==1  | city==3 | city==2  & date<mdy(4,1,2014)] & norm_bid_trimmed>0.8, quantile(20)
eststo m5: qreg norm_bid_trimmed minPriceTsuchiura cartel_broad cartelBroadUshiku cartelBroadTsukuba minPriceXcartel_broad lngdp tt_city* i.month i.year i.city if winner==1 & [city ==1  | city==3 | city==2  & date<mdy(4,1,2014)] & norm_bid_trimmed>0.8, quantile(40)
eststo m6: qreg norm_bid_trimmed minPriceTsuchiura cartel_broad cartelBroadUshiku cartelBroadTsukuba minPriceXcartel_broad lngdp tt_city* i.month i.year i.city if winner==1 & [city ==1  | city==3 | city==2  & date<mdy(4,1,2014)] & norm_bid_trimmed>0.8, quantile(60)
eststo m7: qreg norm_bid_trimmed minPriceTsuchiura cartel_broad cartelBroadUshiku cartelBroadTsukuba minPriceXcartel_broad lngdp tt_city* i.month i.year i.city if winner==1 & [city ==1  | city==3 | city==2  & date<mdy(4,1,2014)] & norm_bid_trimmed>0.8, quantile(80)
  
estout m1 m2 m4 m5 m6 m7 using tableDIDTsuchiuraCartelBroad.tex, style(tex) replace label ///
  keep(minPriceTsuchiura cartel_broad minPriceXcartel_broad ) stats(r2 N) prefoot("\hline") mlabels(, none) ///
  collabels(, none) cells(b(star fmt(3)) se(par fmt(3))) ///
  starlevels ($^{*}$ 0.1 $^{**}$ 0.05 $^{***}$ 0.01) ///
  substitute(_ \_)

  
  
*Tsukuba
eststo clear

label variable minPriceTsukuba "policy_change"

eststo m1: reg norm_bid_trimmed minPriceTsukuba lngdp tt_city* i.month i.year i.city if winner==1 & [city ==2  | city==7 | city==11]
eststo m2: reg norm_bid_trimmed minPriceTsukuba lngdp tt_city* i.month i.year i.city if winner==1 & [city ==2  | city==7 | city==11] & norm_bid_trimmed>0.8
eststo m3: qreg norm_bid_trimmed minPriceTsukuba lngdp tt_city* i.month i.year i.city if winner==1 & [city ==2  | city==7 | city==11] & norm_bid_trimmed>0.8, quantile(10)
eststo m4: qreg norm_bid_trimmed minPriceTsukuba lngdp tt_city* i.month i.year i.city if winner==1 & [city ==2  | city==7 | city==11] & norm_bid_trimmed>0.8, quantile(20)
eststo m5: qreg norm_bid_trimmed minPriceTsukuba lngdp tt_city* i.month i.year i.city if winner==1 & [city ==2  | city==7 | city==11] & norm_bid_trimmed>0.8, quantile(40)
eststo m6: qreg norm_bid_trimmed minPriceTsukuba lngdp tt_city* i.month i.year i.city if winner==1 & [city ==2  | city==7 | city==11] & norm_bid_trimmed>0.8, quantile(60)
eststo m7: qreg norm_bid_trimmed minPriceTsukuba lngdp tt_city* i.month i.year i.city if winner==1 & [city ==2  | city==7 | city==11] & norm_bid_trimmed>0.8, quantile(80)
  
estout m1 m2 m4 m5 m6 m7 using tableDIDTsukuba.tex, style(tex) replace label ///
  keep(minPriceTsukuba ) stats(r2 N) prefoot("\hline") mlabels(, none) ///
  collabels(, none) cells(b(star fmt(3)) se(par fmt(3))) ///
  starlevels ($^{*}$ 0.1 $^{**}$ 0.05 $^{***}$ 0.01) ///
  substitute(_ \_)

eststo clear

label variable cartelBroadTsukuba "long_run_Tsukuba"
label variable cartelBroadTsukubaXpolicy "long_run_Tsukuba X policy_change"

eststo m1: reg norm_bid_trimmed minPriceTsukuba cartel_broad cartelBroadKamisu cartelBroadShimotsuma  minPriceXcartel_broad lngdp tt_city* i.month i.year i.city if winner==1 & [city ==2  | city==7 | city==11]
eststo m2: reg norm_bid_trimmed minPriceTsukuba cartel_broad cartelBroadKamisu cartelBroadShimotsuma minPriceXcartel_broad lngdp tt_city* i.month i.year i.city if winner==1 & [city ==2  | city==7 | city==11] & norm_bid_trimmed>0.8
eststo m3: qreg norm_bid_trimmed minPriceTsukuba cartel_broad cartelBroadKamisu cartelBroadShimotsuma minPriceXcartel_broad lngdp tt_city* i.month i.year i.city if winner==1 & [city ==2  | city==7 | city==11] & norm_bid_trimmed>0.8, quantile(10)
eststo m4: qreg norm_bid_trimmed minPriceTsukuba cartel_broad cartelBroadKamisu cartelBroadShimotsuma minPriceXcartel_broad lngdp tt_city* i.month i.year i.city if winner==1 & [city ==2  | city==7 | city==11] & norm_bid_trimmed>0.8, quantile(20)
eststo m5: qreg norm_bid_trimmed minPriceTsukuba cartel_broad cartelBroadKamisu cartelBroadShimotsuma minPriceXcartel_broad lngdp tt_city* i.month i.year i.city if winner==1 & [city ==2  | city==7 | city==11] & norm_bid_trimmed>0.8, quantile(40)
eststo m6: qreg norm_bid_trimmed minPriceTsukuba cartel_broad cartelBroadKamisu cartelBroadShimotsuma minPriceXcartel_broad lngdp tt_city* i.month i.year i.city if winner==1 & [city ==2  | city==7 | city==11] & norm_bid_trimmed>0.8, quantile(60)
eststo m7: qreg norm_bid_trimmed minPriceTsukuba cartel_broad cartelBroadKamisu cartelBroadShimotsuma minPriceXcartel_broad lngdp tt_city* i.month i.year i.city if winner==1 & [city ==2  | city==7 | city==11] & norm_bid_trimmed>0.8, quantile(80)

  
estout m1 m2 m4 m5 m6 m7 using tableDIDTsukubaCartelBroad.tex, style(tex) replace label ///
  keep(minPriceTsukuba cartel_broad minPriceXcartel_broad ) stats(r2 N) prefoot("\hline") mlabels(, none) ///
  collabels(, none) cells(b(star fmt(3)) se(par fmt(3))) ///
  starlevels ($^{*}$ 0.1 $^{**}$ 0.05 $^{***}$ 0.01) ///
  substitute(_ \_)

  
  
*Tsukubamirai
eststo clear

label variable minPriceTsukubamirai "policy_change"

eststo m1: reg norm_bid_trimmed minPriceTsukubamirai lngdp tt_city* i.month i.year i.city if winner==1 & [city ==13  | city==8 | city==11]
eststo m2: reg norm_bid_trimmed minPriceTsukubamirai lngdp tt_city* i.month i.year i.city if winner==1 & [city ==13  | city==8 | city==11] & norm_bid_trimmed>0.8
eststo m3: qreg norm_bid_trimmed minPriceTsukubamirai lngdp tt_city* i.month i.year i.city if winner==1 & [city ==13  | city==8 | city==11] & norm_bid_trimmed>0.8, quantile(10)
eststo m4: qreg norm_bid_trimmed minPriceTsukubamirai lngdp tt_city* i.month i.year i.city if winner==1 & [city ==13  | city==8 | city==11] & norm_bid_trimmed>0.8, quantile(20)
eststo m5: qreg norm_bid_trimmed minPriceTsukubamirai lngdp tt_city* i.month i.year i.city if winner==1 & [city ==13  | city==8 | city==11] & norm_bid_trimmed>0.8, quantile(40)
eststo m6: qreg norm_bid_trimmed minPriceTsukubamirai lngdp tt_city* i.month i.year i.city if winner==1 & [city ==13  | city==8 | city==11] & norm_bid_trimmed>0.8, quantile(60)
eststo m7: qreg norm_bid_trimmed minPriceTsukubamirai lngdp tt_city* i.month i.year i.city if winner==1 & [city ==13  | city==8 | city==11] & norm_bid_trimmed>0.8, quantile(80)
  
estout m1 m2 m4 m5 m6 m7 using tableDIDTsukubamirai.tex, style(tex) replace label ///
  keep(minPriceTsukubamirai ) stats(r2 N) prefoot("\hline") mlabels(, none) ///
  collabels(, none) cells(b(star fmt(3)) se(par fmt(3))) ///
  starlevels ($^{*}$ 0.1 $^{**}$ 0.05 $^{***}$ 0.01) ///
  substitute(_ \_)
  
eststo clear

label variable cartelBroadTsukubamirai "long_run_Tsukubamirai"
label variable cartelBroadTsukubamiraiXpolicy "long_run_Tsukubamirai X policy_change"


eststo m1: reg norm_bid_trimmed minPriceTsukubamirai cartel_broad cartelBroadShimotsuma cartelBroadKasumigaura minPriceXcartel_broad lngdp tt_city* i.month i.year i.city if winner==1 & [city ==13  | city==8 | city==11]
eststo m2: reg norm_bid_trimmed minPriceTsukubamirai cartel_broad cartelBroadShimotsuma cartelBroadKasumigaura minPriceXcartel_broad lngdp tt_city* i.month i.year i.city if winner==1 & [city ==13  | city==8 | city==11] & norm_bid_trimmed>0.8 
eststo m3: qreg norm_bid_trimmed minPriceTsukubamirai cartel_broad cartelBroadShimotsuma cartelBroadKasumigaura minPriceXcartel_broad lngdp tt_city* i.month i.year i.city if winner==1 & [city ==13  | city==8 | city==11] & norm_bid_trimmed>0.8, quantile(10)
eststo m4: qreg norm_bid_trimmed minPriceTsukubamirai cartel_broad cartelBroadShimotsuma cartelBroadKasumigaura minPriceXcartel_broad lngdp tt_city* i.month i.year i.city if winner==1 & [city ==13  | city==8 | city==11] & norm_bid_trimmed>0.8, quantile(20)
eststo m5: qreg norm_bid_trimmed minPriceTsukubamirai cartel_broad cartelBroadShimotsuma cartelBroadKasumigaura minPriceXcartel_broad lngdp tt_city* i.month i.year i.city if winner==1 & [city ==13  | city==8 | city==11] & norm_bid_trimmed>0.8, quantile(40)
eststo m6: qreg norm_bid_trimmed minPriceTsukubamirai cartel_broad cartelBroadShimotsuma cartelBroadKasumigaura minPriceXcartel_broad lngdp tt_city* i.month i.year i.city if winner==1 & [city ==13  | city==8 | city==11] & norm_bid_trimmed>0.8, quantile(60)
eststo m7: qreg norm_bid_trimmed minPriceTsukubamirai cartel_broad cartelBroadShimotsuma cartelBroadKasumigaura minPriceXcartel_broad lngdp tt_city* i.month i.year i.city if winner==1 & [city ==13  | city==8 | city==11] & norm_bid_trimmed>0.8, quantile(80)

  
estout m1 m2 m4 m5 m6 m7 using tableDIDTsukubamiraiCartelBroad.tex, style(tex) replace label ///
  keep(minPriceTsukubamirai cartel_broad minPriceXcartel_broad ) stats(r2 N) prefoot("\hline") mlabels(, none) ///
  collabels(, none) cells(b(star fmt(3)) se(par fmt(3))) ///
  starlevels ($^{*}$ 0.1 $^{**}$ 0.05 $^{***}$ 0.01) ///
  substitute(_ \_)  
  
  
  
  
***********************
*****ROBUSTNESS********
***********************


***********************************************   
**Table OA.6: Aggregate regressions - taking out 6 months before-after
***********************************************
eststo clear

eststo m1: xi: reg norm_bid_trimmed minPrice lngdp i.group i.group*tt_city_id1 i.group*tt_city_id2 i.group*tt_city_id3 i.group*tt_city_id4 i.group*tt_city_id5 i.group*tt_city_id6 i.group*tt_city_id7 i.group*tt_city_id8 i.group*tt_city_id9 i.group*tt_city_id10 i.group*tt_city_id11 i.group*tt_city_id12 i.group*tt_city_id13 i.group*tt_city_id14 i.group*i.year i.group*i.month i.group*i.city if winner==1  & citiesUsed==1 & window6Months==0, cluster(city)
eststo m2: xi: reg norm_bid_trimmed minPrice lngdp i.group i.group*tt_city_id1 i.group*tt_city_id2 i.group*tt_city_id3 i.group*tt_city_id4 i.group*tt_city_id5 i.group*tt_city_id6 i.group*tt_city_id7 i.group*tt_city_id8 i.group*tt_city_id9 i.group*tt_city_id10 i.group*tt_city_id11 i.group*tt_city_id12 i.group*tt_city_id13 i.group*tt_city_id14 i.group*i.year i.group*i.month i.group*i.city if winner==1  & citiesUsed==1 & norm_bid_trimmed>0.8 & window6Months==0, cluster(city)
eststo m3: xi: reg norm_bid_trimmed $cartelBroadCities minPriceXcartel_broad  minPrice lngdp i.group i.group*cartel_broad i.group*tt_city_id1 i.group*tt_city_id2 i.group*tt_city_id3 i.group*tt_city_id4 i.group*tt_city_id5 i.group*tt_city_id6 i.group*tt_city_id7 i.group*tt_city_id8 i.group*tt_city_id9 i.group*tt_city_id10 i.group*tt_city_id11 i.group*tt_city_id12 i.group*tt_city_id13 i.group*tt_city_id14 i.group*i.year i.group*i.month i.group*i.city if winner==1  & citiesUsed==1 & window6Months==0, cluster(city_year)
eststo m4: xi: reg norm_bid_trimmed $cartelBroadCities minPriceXcartel_broad  minPrice lngdp i.group i.group*cartel_broad i.group*tt_city_id1 i.group*tt_city_id2 i.group*tt_city_id3 i.group*tt_city_id4 i.group*tt_city_id5 i.group*tt_city_id6 i.group*tt_city_id7 i.group*tt_city_id8 i.group*tt_city_id9 i.group*tt_city_id10 i.group*tt_city_id11 i.group*tt_city_id12 i.group*tt_city_id13 i.group*tt_city_id14 i.group*i.year i.group*i.month i.group*i.city if winner==1  & citiesUsed==1 & norm_bid_trimmed>0.8 &window6Months==0, cluster(city_year)
estout m1 m3 m2 m4 using Aggregate_Window6M.tex, style(tex) replace label ///
  keep(minPrice minPriceXcartel_broad) stats(r2 N) prefoot("\hline") mlabels(, none) ///
  collabels(, none) cells(b(star fmt(3)) se(par fmt(3))) ///
  starlevels ($^{*}$ 0.1 $^{**}$ 0.05 $^{***}$ 0.01) ///
  substitute(_ \_)  
  
  *Boostrapped standard errors:  
* on minimum price:
xi: cgmwildboot norm_bid_trimmed minPrice lngdp tt_city_id* i.group_year ///
  i.group_month i.group_city ///
  if winner == 1  & citiesUsed == 1 & window6Months==0, ///
  cluster(city_year) bootcluster(city_year) reps(999) seed(4381)

* same as above with truncated norm_bid:
xi: cgmwildboot norm_bid_trimmed minPrice lngdp tt_city_id* i.group_year ///
  i.group_month i.group_city ///
  if winner == 1  & citiesUsed == 1 & norm_bid_trimmed > 0.8 & window6Months==0, ///
  cluster(city_year) bootcluster(city_year) reps(999) seed(4381)


  * on cartel_broad and interaction with minPrice:
xi: cgmwildboot norm_bid_trimmed cartel_broad $cartelBroadCities minPriceXcartel_broad ///
  minPrice lngdp tt_city_id* i.group_cartel_broad i.group_year i.group_month ///
  i.group_city if winner == 1 & citiesUsed == 1 & window6Months==0, ///
  cluster(city_year) bootcluster(city_year) reps(999) seed(4381)

* same as above with truncated norm_bid:
xi: cgmwildboot norm_bid_trimmed cartel_broad $cartelBroadCities minPriceXcartel_broad ///
  minPrice lngdp tt_city_id* i.group_cartel_broad i.group_year i.group_month ///
  i.group_city if winner == 1 & citiesUsed == 1 & norm_bid_trimmed > 0.8 & window6Months==0, ///
  cluster(city_year) bootcluster(city_year) reps(999) seed(4381)   

  

***********************************************
***Table OA.7: Regressions with log winning bids
***********************************************

label variable minPrice "policy_change"
label variable minPriceXcartel_broad "long_run x policy_change"

eststo clear

eststo m1: xi: reg ln_bid ln_reserve minPrice lngdp i.group i.group*tt_city_id1 i.group*tt_city_id2 i.group*tt_city_id3 i.group*tt_city_id4 i.group*tt_city_id5 i.group*tt_city_id6 i.group*tt_city_id7 i.group*tt_city_id8 i.group*tt_city_id9 i.group*tt_city_id10 i.group*tt_city_id11 i.group*tt_city_id12 i.group*tt_city_id13 i.group*tt_city_id14 i.group*i.year i.group*i.month i.group*i.city if winner==1  & citiesUsed==1, cluster(city_year)
eststo m2: xi: reg ln_bid ln_reserve minPrice lngdp i.group i.group*tt_city_id1 i.group*tt_city_id2 i.group*tt_city_id3 i.group*tt_city_id4 i.group*tt_city_id5 i.group*tt_city_id6 i.group*tt_city_id7 i.group*tt_city_id8 i.group*tt_city_id9 i.group*tt_city_id10 i.group*tt_city_id11 i.group*tt_city_id12 i.group*tt_city_id13 i.group*tt_city_id14 i.group*i.year i.group*i.month i.group*i.city if winner==1  & citiesUsed==1 & norm_bid_trimmed>0.8, cluster(city_year)
eststo m3: xi: reg ln_bid ln_reserve $cartelBroadCities minPriceXcartel_broad  minPrice lngdp i.group i.group*cartel_broad i.group*tt_city_id1 i.group*tt_city_id2 i.group*tt_city_id3 i.group*tt_city_id4 i.group*tt_city_id5 i.group*tt_city_id6 i.group*tt_city_id7 i.group*tt_city_id8 i.group*tt_city_id9 i.group*tt_city_id10 i.group*tt_city_id11 i.group*tt_city_id12 i.group*tt_city_id13 i.group*tt_city_id14 i.group*i.year i.group*i.month i.group*i.city if winner==1  & citiesUsed==1, cluster(city_year)
eststo m4: xi: reg ln_bid ln_reserve $cartelBroadCities minPriceXcartel_broad  minPrice lngdp i.group i.group*cartel_broad i.group*tt_city_id1 i.group*tt_city_id2 i.group*tt_city_id3 i.group*tt_city_id4 i.group*tt_city_id5 i.group*tt_city_id6 i.group*tt_city_id7 i.group*tt_city_id8 i.group*tt_city_id9 i.group*tt_city_id10 i.group*tt_city_id11 i.group*tt_city_id12 i.group*tt_city_id13 i.group*tt_city_id14 i.group*i.year i.group*i.month i.group*i.city if winner==1  & citiesUsed==1 & norm_bid_trimmed>0.8, cluster(city_year)
estout m1 m3 m2 m4 using Aggregate_Logs.tex, style(tex) replace label ///
  keep(minPrice minPriceXcartel_broad) stats(r2 N) prefoot("\hline") mlabels(, none) ///
  collabels(, none) cells(b(star fmt(3)) se(par fmt(3))) ///
  starlevels ($^{*}$ 0.1 $^{**}$ 0.05 $^{***}$ 0.01) ///
  substitute(_ \_)  
  
  
*Boostrapped standard errors:  
* on minimum price:
xi: cgmwildboot ln_bid ln_reserve minPrice lngdp tt_city_id* i.group_year ///
  i.group_month i.group_city ///
  if winner == 1  & citiesUsed == 1, ///
  cluster(city_year) bootcluster(city_year) reps(999) seed(4381)

* same as above with truncated norm_bid:
xi: cgmwildboot ln_bid ln_reserve minPrice lngdp tt_city_id* i.group_year ///
  i.group_month i.group_city ///
  if winner == 1  & citiesUsed == 1 & norm_bid_trimmed > 0.8, ///
  cluster(city_year) bootcluster(city_year) reps(999) seed(4381)

* on cartel and interaction with minPrice:
xi: cgmwildboot ln_bid ln_reserve cartel_broad $cartelBroadCities minPriceXcartel_broad ///
  minPrice lngdp tt_city_id* i.group_cartel_broad i.group_year i.group_month ///
  i.group_city if winner == 1 & citiesUsed == 1, ///
  cluster(city_year) bootcluster(city_year) reps(999) seed(4381)

* same as above with truncated norm_bid:
xi: cgmwildboot ln_bid ln_reserve cartel_broad $cartelBroadCities minPriceXcartel_broad ///
  minPrice lngdp tt_city_id* i.group_cartel_broad i.group_year i.group_month ///
  i.group_city if winner == 1 & citiesUsed == 1 & norm_bid_trimmed > 0.8, ///
  cluster(city_year) bootcluster(city_year) reps(999) seed(4381)   

  
******************************************************
****Table OA.8: Regressions by reserve price quartile**
******************************************************  
  
*************
*Aggregate regressions -- by reserve price quantile
*************  

xtile reserve_tile = reserve_price if winner==1, nq(4)

*Quartile 1
eststo m1: xi: reg norm_bid_trimmed minPrice lngdp i.group i.group*tt_city_id1 i.group*tt_city_id2 i.group*tt_city_id3 i.group*tt_city_id4 i.group*tt_city_id5 i.group*tt_city_id6 i.group*tt_city_id7 i.group*tt_city_id8 i.group*tt_city_id9 i.group*tt_city_id10 i.group*tt_city_id11 i.group*tt_city_id12 i.group*tt_city_id13 i.group*tt_city_id14 i.group*i.year i.group*i.month i.group*i.city if winner==1  & citiesUsed==1 & reserve_tile == 1, cluster(city_year)
eststo m2: xi: reg norm_bid_trimmed minPrice lngdp i.group i.group*tt_city_id1 i.group*tt_city_id2 i.group*tt_city_id3 i.group*tt_city_id4 i.group*tt_city_id5 i.group*tt_city_id6 i.group*tt_city_id7 i.group*tt_city_id8 i.group*tt_city_id9 i.group*tt_city_id10 i.group*tt_city_id11 i.group*tt_city_id12 i.group*tt_city_id13 i.group*tt_city_id14 i.group*i.year i.group*i.month i.group*i.city if winner==1  & citiesUsed==1 & norm_bid_trimmed>0.8 & reserve_tile == 1, cluster(city_year)
eststo m3: xi: reg norm_bid_trimmed $cartelBroadCities minPriceXcartel_broad  minPrice lngdp i.group i.group*cartel_broad i.group*tt_city_id1 i.group*tt_city_id2 i.group*tt_city_id3 i.group*tt_city_id4 i.group*tt_city_id5 i.group*tt_city_id6 i.group*tt_city_id7 i.group*tt_city_id8 i.group*tt_city_id9 i.group*tt_city_id10 i.group*tt_city_id11 i.group*tt_city_id12 i.group*tt_city_id13 i.group*tt_city_id14 i.group*i.year i.group*i.month i.group*i.city if winner==1  & citiesUsed==1 & reserve_tile == 1, cluster(city_year)
eststo m4: xi: reg norm_bid_trimmed $cartelBroadCities minPriceXcartel_broad  minPrice lngdp i.group i.group*cartel_broad i.group*tt_city_id1 i.group*tt_city_id2 i.group*tt_city_id3 i.group*tt_city_id4 i.group*tt_city_id5 i.group*tt_city_id6 i.group*tt_city_id7 i.group*tt_city_id8 i.group*tt_city_id9 i.group*tt_city_id10 i.group*tt_city_id11 i.group*tt_city_id12 i.group*tt_city_id13 i.group*tt_city_id14 i.group*i.year i.group*i.month i.group*i.city if winner==1  & citiesUsed==1 & norm_bid_trimmed>0.8 & reserve_tile == 1, cluster(city_year)
estout m1 m3 m2 m4 using AggregateReserve_Q1.tex, style(tex) replace label ///
  keep(minPrice minPriceXcartel_broad) stats(r2 N) prefoot("\hline") mlabels(, none) ///
  collabels(, none) cells(b(star fmt(3)) se(par fmt(3))) ///
  starlevels ($^{*}$ 0.1 $^{**}$ 0.05 $^{***}$ 0.01) ///
  substitute(_ \_)  

  eststo clear

*Quartile 2
eststo m1: xi: reg norm_bid_trimmed minPrice lngdp i.group i.group*tt_city_id1 i.group*tt_city_id2 i.group*tt_city_id3 i.group*tt_city_id4 i.group*tt_city_id5 i.group*tt_city_id6 i.group*tt_city_id7 i.group*tt_city_id8 i.group*tt_city_id9 i.group*tt_city_id10 i.group*tt_city_id11 i.group*tt_city_id12 i.group*tt_city_id13 i.group*tt_city_id14 i.group*i.year i.group*i.month i.group*i.city if winner==1  & citiesUsed==1 & reserve_tile == 2, cluster(city_year)
eststo m2: xi: reg norm_bid_trimmed minPrice lngdp i.group i.group*tt_city_id1 i.group*tt_city_id2 i.group*tt_city_id3 i.group*tt_city_id4 i.group*tt_city_id5 i.group*tt_city_id6 i.group*tt_city_id7 i.group*tt_city_id8 i.group*tt_city_id9 i.group*tt_city_id10 i.group*tt_city_id11 i.group*tt_city_id12 i.group*tt_city_id13 i.group*tt_city_id14 i.group*i.year i.group*i.month i.group*i.city if winner==1  & citiesUsed==1 & norm_bid_trimmed>0.8 & reserve_tile == 2, cluster(city_year)
eststo m3: xi: reg norm_bid_trimmed $cartelBroadCities minPriceXcartel_broad  minPrice lngdp i.group i.group*cartel_broad i.group*tt_city_id1 i.group*tt_city_id2 i.group*tt_city_id3 i.group*tt_city_id4 i.group*tt_city_id5 i.group*tt_city_id6 i.group*tt_city_id7 i.group*tt_city_id8 i.group*tt_city_id9 i.group*tt_city_id10 i.group*tt_city_id11 i.group*tt_city_id12 i.group*tt_city_id13 i.group*tt_city_id14 i.group*i.year i.group*i.month i.group*i.city if winner==1  & citiesUsed==1 & reserve_tile == 2, cluster(city_year)
eststo m4: xi: reg norm_bid_trimmed $cartelBroadCities minPriceXcartel_broad  minPrice lngdp i.group i.group*cartel_broad i.group*tt_city_id1 i.group*tt_city_id2 i.group*tt_city_id3 i.group*tt_city_id4 i.group*tt_city_id5 i.group*tt_city_id6 i.group*tt_city_id7 i.group*tt_city_id8 i.group*tt_city_id9 i.group*tt_city_id10 i.group*tt_city_id11 i.group*tt_city_id12 i.group*tt_city_id13 i.group*tt_city_id14 i.group*i.year i.group*i.month i.group*i.city if winner==1  & citiesUsed==1 & norm_bid_trimmed>0.8 & reserve_tile == 2, cluster(city_year)
estout m1 m3 m2 m4 using AggregateReserve_Q2.tex, style(tex) replace label ///
  keep(minPrice minPriceXcartel_broad) stats(r2 N) prefoot("\hline") mlabels(, none) ///
  collabels(, none) cells(b(star fmt(3)) se(par fmt(3))) ///
  starlevels ($^{*}$ 0.1 $^{**}$ 0.05 $^{***}$ 0.01) ///
  substitute(_ \_)  
  
  eststo clear

*Quartile 3  
eststo m1: xi: reg norm_bid_trimmed minPrice lngdp i.group i.group*tt_city_id1 i.group*tt_city_id2 i.group*tt_city_id3 i.group*tt_city_id4 i.group*tt_city_id5 i.group*tt_city_id6 i.group*tt_city_id7 i.group*tt_city_id8 i.group*tt_city_id9 i.group*tt_city_id10 i.group*tt_city_id11 i.group*tt_city_id12 i.group*tt_city_id13 i.group*tt_city_id14 i.group*i.year i.group*i.month i.group*i.city if winner==1  & citiesUsed==1 & reserve_tile == 3, cluster(city_year)
eststo m2: xi: reg norm_bid_trimmed minPrice lngdp i.group i.group*tt_city_id1 i.group*tt_city_id2 i.group*tt_city_id3 i.group*tt_city_id4 i.group*tt_city_id5 i.group*tt_city_id6 i.group*tt_city_id7 i.group*tt_city_id8 i.group*tt_city_id9 i.group*tt_city_id10 i.group*tt_city_id11 i.group*tt_city_id12 i.group*tt_city_id13 i.group*tt_city_id14 i.group*i.year i.group*i.month i.group*i.city if winner==1  & citiesUsed==1 & norm_bid_trimmed>0.8 & reserve_tile == 3, cluster(city_year)
eststo m3: xi: reg norm_bid_trimmed $cartelBroadCities minPriceXcartel_broad  minPrice lngdp i.group i.group*cartel_broad i.group*tt_city_id1 i.group*tt_city_id2 i.group*tt_city_id3 i.group*tt_city_id4 i.group*tt_city_id5 i.group*tt_city_id6 i.group*tt_city_id7 i.group*tt_city_id8 i.group*tt_city_id9 i.group*tt_city_id10 i.group*tt_city_id11 i.group*tt_city_id12 i.group*tt_city_id13 i.group*tt_city_id14 i.group*i.year i.group*i.month i.group*i.city if winner==1  & citiesUsed==1 & reserve_tile == 3, cluster(city_year)
eststo m4: xi: reg norm_bid_trimmed $cartelBroadCities minPriceXcartel_broad  minPrice lngdp i.group i.group*cartel_broad i.group*tt_city_id1 i.group*tt_city_id2 i.group*tt_city_id3 i.group*tt_city_id4 i.group*tt_city_id5 i.group*tt_city_id6 i.group*tt_city_id7 i.group*tt_city_id8 i.group*tt_city_id9 i.group*tt_city_id10 i.group*tt_city_id11 i.group*tt_city_id12 i.group*tt_city_id13 i.group*tt_city_id14 i.group*i.year i.group*i.month i.group*i.city if winner==1  & citiesUsed==1 & norm_bid_trimmed>0.8 & reserve_tile == 3, cluster(city_year)
estout m1 m3 m2 m4 using AggregateReserve_Q3.tex, style(tex) replace label ///
  keep(minPrice minPriceXcartel_broad) stats(r2 N) prefoot("\hline") mlabels(, none) ///
  collabels(, none) cells(b(star fmt(3)) se(par fmt(3))) ///
  starlevels ($^{*}$ 0.1 $^{**}$ 0.05 $^{***}$ 0.01) ///
  substitute(_ \_)  


  eststo clear

*Quartile 4   
eststo m1: xi: reg norm_bid_trimmed minPrice lngdp i.group i.group*tt_city_id1 i.group*tt_city_id2 i.group*tt_city_id3 i.group*tt_city_id4 i.group*tt_city_id5 i.group*tt_city_id6 i.group*tt_city_id7 i.group*tt_city_id8 i.group*tt_city_id9 i.group*tt_city_id10 i.group*tt_city_id11 i.group*tt_city_id12 i.group*tt_city_id13 i.group*tt_city_id14 i.group*i.year i.group*i.month i.group*i.city if winner==1  & citiesUsed==1 & reserve_tile == 4, cluster(city_year)
eststo m2: xi: reg norm_bid_trimmed minPrice lngdp i.group i.group*tt_city_id1 i.group*tt_city_id2 i.group*tt_city_id3 i.group*tt_city_id4 i.group*tt_city_id5 i.group*tt_city_id6 i.group*tt_city_id7 i.group*tt_city_id8 i.group*tt_city_id9 i.group*tt_city_id10 i.group*tt_city_id11 i.group*tt_city_id12 i.group*tt_city_id13 i.group*tt_city_id14 i.group*i.year i.group*i.month i.group*i.city if winner==1  & citiesUsed==1 & norm_bid_trimmed>0.8 & reserve_tile == 4, cluster(city_year)
eststo m3: xi: reg norm_bid_trimmed $cartelBroadCities minPriceXcartel_broad  minPrice lngdp i.group i.group*cartel_broad i.group*tt_city_id1 i.group*tt_city_id2 i.group*tt_city_id3 i.group*tt_city_id4 i.group*tt_city_id5 i.group*tt_city_id6 i.group*tt_city_id7 i.group*tt_city_id8 i.group*tt_city_id9 i.group*tt_city_id10 i.group*tt_city_id11 i.group*tt_city_id12 i.group*tt_city_id13 i.group*tt_city_id14 i.group*i.year i.group*i.month i.group*i.city if winner==1  & citiesUsed==1 & reserve_tile == 4, cluster(city_year)
eststo m4: xi: reg norm_bid_trimmed $cartelBroadCities minPriceXcartel_broad  minPrice lngdp i.group i.group*cartel_broad i.group*tt_city_id1 i.group*tt_city_id2 i.group*tt_city_id3 i.group*tt_city_id4 i.group*tt_city_id5 i.group*tt_city_id6 i.group*tt_city_id7 i.group*tt_city_id8 i.group*tt_city_id9 i.group*tt_city_id10 i.group*tt_city_id11 i.group*tt_city_id12 i.group*tt_city_id13 i.group*tt_city_id14 i.group*i.year i.group*i.month i.group*i.city if winner==1  & citiesUsed==1 & norm_bid_trimmed>0.8 & reserve_tile == 4, cluster(city_year)
estout m1 m3 m2 m4 using AggregateReserve_Q4.tex, style(tex) replace label ///
  keep(minPrice minPriceXcartel_broad) stats(r2 N) prefoot("\hline") mlabels(, none) ///
  collabels(, none) cells(b(star fmt(3)) se(par fmt(3))) ///
  starlevels ($^{*}$ 0.1 $^{**}$ 0.05 $^{***}$ 0.01) ///
  substitute(_ \_)  

  



**Bootstrapped standard errors
***Reserve Price: quartile 1
* on minimum price:
xi: cgmwildboot norm_bid_trimmed minPrice lngdp tt_city_id* i.group_year ///
  i.group_month i.group_city ///
  if winner == 1  & citiesUsed == 1 & reserve_tile == 1, ///
  cluster(city_year) bootcluster(city_year) reps(999) seed(4381)

* same as above with truncated norm_bid:
xi: cgmwildboot norm_bid_trimmed minPrice lngdp tt_city_id* i.group_year ///
  i.group_month i.group_city ///
  if winner == 1  & citiesUsed == 1 & norm_bid_trimmed > 0.8  & reserve_tile == 1, ///
  cluster(city_year) bootcluster(city_year) reps(999) seed(4381)

* on cartel and interaction with minPrice:
xi: cgmwildboot norm_bid_trimmed cartel_broad $cartelBroadCities minPriceXcartel_broad ///
  minPrice lngdp tt_city_id* i.group_cartel_broad i.group_year i.group_month ///
  i.group_city if winner == 1 & citiesUsed == 1  & reserve_tile == 1, ///
  cluster(city_year) bootcluster(city_year) reps(999) seed(4381)

* same as above with truncated norm_bid:
xi: cgmwildboot norm_bid_trimmed cartel_broad $cartelBroadCities minPriceXcartel_broad ///
  minPrice lngdp tt_city_id* i.group_cartel_broad i.group_year i.group_month ///
  i.group_city if winner == 1 & citiesUsed == 1 & norm_bid_trimmed > 0.8  & reserve_tile == 1, ///
  cluster(city_year) bootcluster(city_year) reps(999) seed(4381)   

***Reserve Price: quartile 2
* on minimum price:
xi: cgmwildboot norm_bid_trimmed minPrice lngdp tt_city_id* i.group_year ///
  i.group_month i.group_city ///
  if winner == 1  & citiesUsed == 1 & reserve_tile == 2, ///
  cluster(city_year) bootcluster(city_year) reps(999) seed(4381)

* same as above with truncated norm_bid:
xi: cgmwildboot norm_bid_trimmed minPrice lngdp tt_city_id* i.group_year ///
  i.group_month i.group_city ///
  if winner == 1  & citiesUsed == 1 & norm_bid_trimmed > 0.8  & reserve_tile == 2, ///
  cluster(city_year) bootcluster(city_year) reps(999) seed(4381)

* on cartel and interaction with minPrice:
xi: cgmwildboot norm_bid_trimmed cartel_broad $cartelBroadCities minPriceXcartel_broad ///
  minPrice lngdp tt_city_id* i.group_cartel_broad i.group_year i.group_month ///
  i.group_city if winner == 1 & citiesUsed == 1  & reserve_tile == 2, ///
  cluster(city_year) bootcluster(city_year) reps(999) seed(4381)

* same as above with truncated norm_bid:
xi: cgmwildboot norm_bid_trimmed cartel_broad $cartelBroadCities minPriceXcartel_broad ///
  minPrice lngdp tt_city_id* i.group_cartel_broad i.group_year i.group_month ///
  i.group_city if winner == 1 & citiesUsed == 1 & norm_bid_trimmed > 0.8  & reserve_tile == 2, ///
  cluster(city_year) bootcluster(city_year) reps(999) seed(4381)   
  

***Reserve Price: quartile 3
* on minimum price:
xi: cgmwildboot norm_bid_trimmed minPrice lngdp tt_city_id* i.group_year ///
  i.group_month i.group_city ///
  if winner == 1  & citiesUsed == 1 & reserve_tile == 3, ///
  cluster(city_year) bootcluster(city_year) reps(999) seed(4381)

* same as above with truncated norm_bid:
xi: cgmwildboot norm_bid_trimmed minPrice lngdp tt_city_id* i.group_year ///
  i.group_month i.group_city ///
  if winner == 1  & citiesUsed == 1 & norm_bid_trimmed > 0.8  & reserve_tile == 3, ///
  cluster(city_year) bootcluster(city_year) reps(999) seed(4381)

* on cartel and interaction with minPrice:
xi: cgmwildboot norm_bid_trimmed cartel_broad $cartelBroadCities minPriceXcartel_broad ///
  minPrice lngdp tt_city_id* i.group_cartel_broad i.group_year i.group_month ///
  i.group_city if winner == 1 & citiesUsed == 1  & reserve_tile == 3, ///
  cluster(city_year) bootcluster(city_year) reps(999) seed(4381)

* same as above with truncated norm_bid:
xi: cgmwildboot norm_bid_trimmed cartel_broad $cartelBroadCities minPriceXcartel_broad ///
  minPrice lngdp tt_city_id* i.group_cartel_broad i.group_year i.group_month ///
  i.group_city if winner == 1 & citiesUsed == 1 & norm_bid_trimmed > 0.8  & reserve_tile == 3, ///
  cluster(city_year) bootcluster(city_year) reps(999) seed(4381)   


***Reserve Price: quartile 4
* on minimum price:
xi: cgmwildboot norm_bid_trimmed minPrice lngdp tt_city_id* i.group_year ///
  i.group_month i.group_city ///
  if winner == 1  & citiesUsed == 1 & reserve_tile == 4, ///
  cluster(city_year) bootcluster(city_year) reps(999) seed(4381)

* same as above with truncated norm_bid:
xi: cgmwildboot norm_bid_trimmed minPrice lngdp tt_city_id* i.group_year ///
  i.group_month i.group_city ///
  if winner == 1  & citiesUsed == 1 & norm_bid_trimmed > 0.8  & reserve_tile == 4, ///
  cluster(city_year) bootcluster(city_year) reps(999) seed(4381)

* on cartel and interaction with minPrice:
xi: cgmwildboot norm_bid_trimmed cartel_broad $cartelBroadCities minPriceXcartel_broad ///
  minPrice lngdp tt_city_id* i.group_cartel_broad i.group_year i.group_month ///
  i.group_city if winner == 1 & citiesUsed == 1  & reserve_tile == 4, ///
  cluster(city_year) bootcluster(city_year) reps(999) seed(4381)

* same as above with truncated norm_bid:
xi: cgmwildboot norm_bid_trimmed cartel_broad $cartelBroadCities minPriceXcartel_broad ///
  minPrice lngdp tt_city_id* i.group_cartel_broad i.group_year i.group_month ///
  i.group_city if winner == 1 & citiesUsed == 1 & norm_bid_trimmed > 0.8  & reserve_tile == 4, ///
  cluster(city_year) bootcluster(city_year) reps(999) seed(4381)   

*******************************************
*TABLE A.9: OBSERVABILITY OF PARTICIPATION
*******************************************
label variable minPrice "policy_change"
label variable numcartel "num_cartel"
label variable numentrants "num_entrants"
label variable ln_reserve "ln_reserve"
eststo clear

eststo m1:reg norm_bid_trimmed minPrice numentrants numcartel lngdp  year if city==1, cluster(pid)
eststo m2: reg ln_bid minPrice numentrants numcartel ln_reserve lngdp  year if city==1, cluster(pid)
estout m1 m2 using TableA9.tex, style(tex) replace label ///
  keep(minPrice numentrants numcartel ln_reserve) stats(r2 N) prefoot("\hline") mlabels(, none) ///
  collabels(, none) cells(b(star fmt(3)) se(par fmt(3))) ///
  starlevels ($^{*}$ 0.1 $^{**}$ 0.05 $^{***}$ 0.01) ///
  substitute(_ \_)  

  

  
  
**********************  
**Table A.10: Aggregate regressions: different thresholds
**********************   

label variable minPrice "policy_change"
label variable cartel_broad "long_run"
label variable minPriceXcartel_broad "long_run x policy_change"


*eststo m1: xi: reg norm_bid_trimmed minPrice lngdp i.group i.group*tt_city_id1 i.group*tt_city_id2 i.group*tt_city_id3 i.group*tt_city_id4 i.group*tt_city_id5 i.group*tt_city_id6 i.group*tt_city_id7 i.group*tt_city_id8 i.group*tt_city_id9 i.group*tt_city_id10 i.group*tt_city_id11 i.group*tt_city_id12 i.group*tt_city_id13 i.group*tt_city_id14 i.group*i.year i.group*i.month i.group*i.city if winner==1  & citiesUsed==1, cluster(city)
eststo m1: xi: reg norm_bid_trimmed minPrice lngdp i.group i.group*tt_city_id1 i.group*tt_city_id2 i.group*tt_city_id3 i.group*tt_city_id4 i.group*tt_city_id5 i.group*tt_city_id6 i.group*tt_city_id7 i.group*tt_city_id8 i.group*tt_city_id9 i.group*tt_city_id10 i.group*tt_city_id11 i.group*tt_city_id12 i.group*tt_city_id13 i.group*tt_city_id14 i.group*i.year i.group*i.month i.group*i.city if winner==1  & citiesUsed==1 & norm_bid_trimmed>0.78, cluster(city)
eststo m2: xi: reg norm_bid_trimmed minPrice lngdp i.group i.group*tt_city_id1 i.group*tt_city_id2 i.group*tt_city_id3 i.group*tt_city_id4 i.group*tt_city_id5 i.group*tt_city_id6 i.group*tt_city_id7 i.group*tt_city_id8 i.group*tt_city_id9 i.group*tt_city_id10 i.group*tt_city_id11 i.group*tt_city_id12 i.group*tt_city_id13 i.group*tt_city_id14 i.group*i.year i.group*i.month i.group*i.city if winner==1  & citiesUsed==1 & norm_bid_trimmed>0.82, cluster(city)
eststo m3: xi: reg norm_bid_trimmed $cartelBroadCities minPriceXcartel_broad  minPrice lngdp i.group i.group*cartel_broad i.group*tt_city_id1 i.group*tt_city_id2 i.group*tt_city_id3 i.group*tt_city_id4 i.group*tt_city_id5 i.group*tt_city_id6 i.group*tt_city_id7 i.group*tt_city_id8 i.group*tt_city_id9 i.group*tt_city_id10 i.group*tt_city_id11 i.group*tt_city_id12 i.group*tt_city_id13 i.group*tt_city_id14 i.group*i.year i.group*i.month i.group*i.city if winner==1  & citiesUsed==1 & norm_bid_trimmed>0.78, cluster(city)
eststo m4: xi: reg norm_bid_trimmed $cartelBroadCities minPriceXcartel_broad  minPrice lngdp i.group i.group*cartel_broad i.group*tt_city_id1 i.group*tt_city_id2 i.group*tt_city_id3 i.group*tt_city_id4 i.group*tt_city_id5 i.group*tt_city_id6 i.group*tt_city_id7 i.group*tt_city_id8 i.group*tt_city_id9 i.group*tt_city_id10 i.group*tt_city_id11 i.group*tt_city_id12 i.group*tt_city_id13 i.group*tt_city_id14 i.group*i.year i.group*i.month i.group*i.city if winner==1  & citiesUsed==1 & norm_bid_trimmed>0.82, cluster(city)
estout m1 m3 m2 m4 using Aggregate_Thresholds.tex, style(tex) replace label ///
  keep(minPrice minPriceXcartel_broad) stats(r2 N) prefoot("\hline") mlabels(, none) ///
  collabels(, none) cells(b(star fmt(3)) se(par fmt(3))) ///
  starlevels ($^{*}$ 0.1 $^{**}$ 0.05 $^{***}$ 0.01) ///
  substitute(_ \_)  

  
*Bootstrapped std errors
xi: cgmwildboot norm_bid_trimmed minPrice lngdp tt_city_id* i.group_year ///
  i.group_month i.group_city ///
  if winner == 1  & citiesUsed == 1 & norm_bid_trimmed > 0.78, ///
  cluster(city_year) bootcluster(city_year) reps(999) seed(4381)

xi: cgmwildboot norm_bid_trimmed minPrice lngdp tt_city_id* i.group_year ///
  i.group_month i.group_city ///
  if winner == 1  & citiesUsed == 1 & norm_bid_trimmed > 0.82, ///
  cluster(city_year) bootcluster(city_year) reps(999) seed(4381)
  
xi: cgmwildboot norm_bid_trimmed cartel_broad $cartelBroadCities minPriceXcartel_broad ///
  minPrice lngdp tt_city_id* i.group_cartel_broad i.group_year i.group_month ///
  i.group_city if winner == 1 & citiesUsed == 1 & norm_bid_trimmed > 0.78, ///
  cluster(city_year) bootcluster(city_year) reps(999) seed(4381)   

xi: cgmwildboot norm_bid_trimmed cartel_broad $cartelBroadCities minPriceXcartel_broad ///
  minPrice lngdp tt_city_id* i.group_cartel_broad i.group_year i.group_month ///
  i.group_city if winner == 1 & citiesUsed == 1 & norm_bid_trimmed > 0.82, ///
  cluster(city_year) bootcluster(city_year) reps(999) seed(4381)   
  
****************  
*TABLE OA.3
****************

******************************************************
*IV: # of bidders in previous auction  
********************************************************************************
********************************************************************************
* Generate the average number of bidders in auctions on a date:
bys pid date: gen n = _n
egen tmp = mean(numbidders) if n == 1, by(date)
egen avg_num_bidders = mode(tmp), by(date)
drop tmp n
label var avg_num_bidders "Average number of bidders in auctions on a date"

replace avg_num_bidders=. if city>1

* Generate the lagged average number of bidders in an auction on a date:
preserve
        keep avg_num_bidders date city pid
        duplicates drop
        sort  date 
        gen lag_avg_num_bidders = avg_num_bidders[_n-1] if city==1
        tempfile pvs
        save `pvs'
restore
merge m:1 date city pid using `pvs', assert(3) nogen
label var lag_avg_num_bidders ///
  "Average number of bidders in auctions on last auction date"

********************************************************************************
* Generate the number of bidders in auctions on a date by reserve price pctiles:

* Create quantile for reserve price:
drop reserve_tile
xtile reserve_tile = reserve_price if city==1, nq(5)

* Create a date-quantile ID:
egen date_tile = group(date reserve_tile)

bys pid date reserve_tile: gen n = _n if city==1
egen tmp = mean(numbidders) if n == 1, by(date reserve_tile)
egen avg_num_bidders_tile = mode(tmp), by(date reserve_tile)
drop n tmp
label var avg_num_bidders_tile ///
  "Average number of bidders in auctions on a date by reserve price quintile"
  
* Generate the lagged average number of bidders in an auction on a date:
preserve
        keep avg_num_bidders_tile date reserve_tile city pid
        duplicates drop
        sort reserve_tile date
        gen lag_avg_num_bidders_tile = avg_num_bidders_tile[_n-1] if city==1
	bys reserve_tile: gen n_within_tile = _n if city==1
	replace lag_avg_num_bidders_tile = . if n_within_tile == 1 & city==1
	drop n_within_tile
        tempfile pvs
        save `pvs'
restore
merge m:1 date reserve_tile city pid using `pvs', assert(3) nogen
label var lag_avg_num_bidders_tile ///
  "Average number of bidders in auctions on last auction date by reserve price quintile"


  
********************************************************************************
* Run the IV regressions:
eststo clear

label variable minPrice "policy_change"
label variable cartel_participation "cartel"
label variable minPriceXcartel_participation "policy_change X cartel"
label variable numbidders "num_bidders"
label variable lngdp "ln_gdp"


	
eststo m1: reg norm_bid_trimmed minPrice numbidders ///
  lngdp year i.month if winner == 1 & city==1
*eststo m2: reg norm_bid_trimmed minPrice cartel_participation minPriceXcartel_participation numbidders ///
 * lngdp year i.month if winner == 1& city==1  
eststo m3: ivreg2 norm_bid_trimmed minPrice (numbidders=lag_avg_num_bidders_tile) ///
  lngdp year i.month if winner == 1& city==1
*eststo m4: ivreg2 norm_bid_trimmed minPrice cartel_participation minPriceXcartel_participation (numbidders=lag_avg_num_bidders_tile) ///
  *lngdp year i.month if winner == 1& city==1
eststo m5: reg norm_bid_trimmed minPrice numbidders ///
  lngdp year i.month if winner == 1 & city==1 & norm_bid_trimmed>0.8
*eststo m6: reg norm_bid_trimmed minPrice cartel_participation minPriceXcartel_participation numbidders ///
*  lngdp year i.month if winner == 1& city==1 & norm_bid_trimmed>0.8  
eststo m7: ivreg2 norm_bid_trimmed minPrice (numbidders=lag_avg_num_bidders_tile) ///
  lngdp year i.month if winner == 1& city==1 & norm_bid_trimmed>0.8
*eststo m8: ivreg2 norm_bid_trimmed minPrice cartel_participation minPriceXcartel_participation (numbidders=lag_avg_num_bidders_tile) ///
*  lngdp year i.month if winner == 1& city==1 & norm_bid_trimmed>0.8

  estout m1 m3 m5 m7 using tableA3.tex, style(tex) replace label ///
  keep(minPrice numbidders lngdp year) stats(r2 N) prefoot("\hline") mlabels(, none) ///
  collabels(, none) cells(b(star fmt(3)) se(par fmt(3))) ///
  starlevels ($^{*}$ 0.1 $^{**}$ 0.05 $^{***}$ 0.01) ///
  substitute(_ \_)

  
eststo clear

eststo m1: reg numbidders minPrice lag_avg_num_bidders_tile ///
  lngdp year i.month if winner == 1& city==1
eststo m2: reg numbidders minPrice lag_avg_num_bidders_tile ///
  lngdp year i.month if winner == 1& city==1 & norm_bid_trimmed>0.8
  estout m1 m2 using tableA3_bis.tex, style(tex) replace label ///
  keep(lag_avg_num_bidders_tile) stats(r2 N) prefoot("\hline") mlabels(, none) ///
  collabels(, none) cells(b(star fmt(3)) se(par fmt(3))) ///
  starlevels ($^{*}$ 0.1 $^{**}$ 0.05 $^{***}$ 0.01) ///
  substitute(_ \_)  
