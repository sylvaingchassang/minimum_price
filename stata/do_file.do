*import Data.dta


**Generate variables
*generate city Indicators
gen city=0
replace city=1 if cityTsuchiura==1
replace city=2 if cityTsukuba==1
replace city=3 if cityUshiku==1
replace city=4 if cityHitachiomiya==1
replace city=5 if cityHokota==1
replace city=6 if cityInashiki==1
replace city=7 if cityKamisu==1
replace city=8 if cityKasumigaura==1
*replace city=9 if cityMoriya==1
replace city=10 if citySakuragawa==1
replace city=11 if cityShimotsuma==1
replace city=12 if cityToride==1
replace city=13 if cityTsukubamirai==1
replace city=14 if cityYuki==1

gen cityMoriya = 1 if city==0
replace city=9 if cityMoriya==1

*Cities used in DID
gen citiesUsed = 0
replace citiesUsed = 1 if [city==4 | city==10 | city==6 | city==12 | city == 3 | city==1 | city==2 | city == 7 | city==13 | city == 8 | city == 11]


*generate date
gen date = mdy(month,day,year)

*generate quarter- import gdp
drop quarter
gen quarter = 1 if month <= 3
replace quarter = 2 if month >= 4 & month <= 6
replace quarter = 3 if month >= 7 & month <= 9
replace quarter = 4 if month >= 10 & month <= 12

merge m:1 year quarter using gdpimport
drop _merge





*Number of bidders in Tsuchiura
sort pid
gen x = 1
by pid: egen numbidders = total(x)
drop x
replace numbidders = . if city>1

*Number of auctions per month in Tsuchiura
egen year_month = group(year month)  
sort year_month
gen x = 1
replace x = 0 if winner==0
by year_month: egen num_auctions = total(x)
drop x
*replace num_auctions = . if city>1

*Number of auctions per day in Tsuchiura
sort date
gen x = 1
replace x = 0 if winner==0
by date: egen num_auctions_day = total(x)
drop x
replace num_auctions_day = . if city>1



*Number of bidders in Tsukubamirai
sort auction_id
gen x = 1
by auction_id: egen numbidders2 = total(x)
drop x

replace numbidders = numbidders2 if city==13

drop numbidders2

gen numbidders_sqr = numbidders^2 
gen numbidders_cub = numbidders^3



**Number of entrants Tsuchiura
gen entrant = 0 if city==1
replace entrant = 1 if city==1 & num_participated<23
sort pid
gen x = 1 if entrant==1 & city==1
replace x = 0 if entrant==0 & city==1
by pid: egen numentrants = total(x)
drop x

gen numcartel = numbidders - numentrants


**replace reserve_price 

replace norm_bid = bid/reserve_price if norm_bid==.

replace winner=1 if winner==. & norm_bid<=1


*drop if norm_bid>1
*drop if norm_bid>1

*define log reserve and log bid
gen ln_reserve = log(reserve_price)
gen ln_bid = log(bid)

*define long_run bidders for each city
replace win_percentile = 0 if win_percentile ==.

gen cartel_broad = 0

replace cartel_broad = 1 if city==1 & win_percentile >=65
replace cartel_broad = 1 if city==2 & win_percentile >=65
replace cartel_broad = 1 if city==3 & win_percentile >=65*86/100
replace cartel_broad = 1 if city==4 & win_percentile >=65
replace cartel_broad = 1 if city==5 & win_percentile >=65
replace cartel_broad = 1 if city==6 & win_percentile >=65
replace cartel_broad = 1 if city==7 & win_percentile >=65
replace cartel_broad = 1 if city==8 & win_percentile >=65
replace cartel_broad = 1 if city==9 & win_percentile >=65*92/100
replace cartel_broad = 1 if city==10 & win_percentile >=65
replace cartel_broad = 1 if city==11 & win_percentile >=65*82/100
replace cartel_broad = 1 if city==12 & win_percentile >=65
replace cartel_broad = 1 if city==13 & win_percentile >=65*63/100
replace cartel_broad = 1 if city==14 & win_percentile >=65*64/100

replace cartel_broad=0 if cartel_broad==.

gen cartelBroadUshiku = 0
replace cartelBroadUshiku = 1 if city==3 & cartel_broad==1

gen cartelBroadSakuragawa = 0
replace cartelBroadSakuragawa = 1 if city==10 & cartel_broad==1

gen cartelBroadKamisu = 0
replace cartelBroadKamisu = 1 if city==7 & cartel_broad==1

gen cartelBroadShimotsuma = 0
replace cartelBroadShimotsuma = 1 if city==11 & cartel_broad==1

gen cartelBroadKasumigaura = 0
replace cartelBroadKasumigaura = 1 if city==8 & cartel_broad==1


tabulate city, gen(city_id)
for var city_id*: gen tt_X = X*(year - 2007)
for var city_id*: gen month_tt_X = X*(month-1) + 12*X*(year - 2007)
for var city_id*: gen tt_sqr_X = X*(year - 2007)^2




gen month_tt = (month-1) + 12*(year - 2007) 

*tabulate year, gen(year_id)

*tabulate month, gen(month_id)

********************************
*Generate long_run_bidder by city
********************************

gen cartelBroadTsuchiura = 0
replace cartelBroadTsuchiura = 1 if cartel_broad==1 & city==1


gen cartelBroadInashiki = 0
replace cartelBroadInashiki = 1 if cartel_broad==1 & city==6

gen cartelBroadHit = 0
replace cartelBroadHit = 1 if cartel_broad==1 & city==4

gen cartelBroadTsukubamirai = 0
replace cartelBroadTsukubamirai = 1 if cartel_broad==1 & city==13

gen cartelBroadTsukuba = 0
replace cartelBroadTsukuba = 1 if cartel_broad==1 & city==2

gen cartelBroadToride = 0
replace cartelBroadToride = 1 if cartel_broad==1 & city==12


***********
*Define groups
************
gen group=0
replace group=1 if [city ==12  | city==3 | city==1  & date>=mdy(10,29,2009)]
replace group=2 if [city ==2  | city==7 | city==11]
replace group=3 if [city ==13  | city==8 | city==11]
replace group=4 if [city ==4 | city==10 | city==6 & date>=mdy(7,10,2010)]
replace group=5 if [city ==4  & date<mdy(04,07,2011) | city==10 | city==6]
replace group=6 if [city==1  | city==3 | city==2  & date<mdy(4,1,2014)]

gen groupToride = 0
replace groupToride = 1 if [city ==12  | city==3 | city==1  & date>=mdy(10,29,2009)]

gen groupTsukuba = 0
replace groupTsukuba = 1 if  [city ==2  | city==7 | city==11]

gen groupTsukubamirai = 0
replace groupTsukubamirai=1 if [city ==13  | city==8 | city==11]

gen groupHit=0
replace groupHit = 1 if [city ==4 | city==10 | city==6 & date>=mdy(7,10,2010)]

gen groupInashiki = 0
replace groupInashiki=1 if [city ==4  & date<mdy(04,07,2011) | city==10 | city==6]

gen groupTsuchiura = 0
replace groupTsuchiura = 1 if [city==1  | city==3 | city==2  & date<mdy(4,1,2014)]




gen N = groupToride + groupTsukuba + groupTsukubamirai + groupHit + groupInashiki + groupTsuchiura

gen N_groupToride = groupToride/N
replace N_groupToride=0 if N_groupToride==.
gen N_groupTsukuba = groupTsukuba/N
replace N_groupTsukuba =0 if N_groupTsukuba==.
gen N_groupTsukubamirai = groupTsukubamirai/N
replace N_groupTsukubamirai=0 if N_groupTsukubamirai==.
gen N_groupHit = groupHit/N
replace N_groupHit=0 if N_groupHit/N==.
gen N_groupInashiki = groupInashiki/N
replace N_groupInashiki=0 if N_groupInashiki==.
gen N_groupTsuchiura = groupTsuchiura/N
replace N_groupTsuchiura=0 if N_groupTsuchiura==.

****************************************
***Define group variables
****************************************

foreach num in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 {
for var group*: gen N_city_`num'_X = city_id`num'*X 
*for var N_city_`num'_group*: replace X = 0 if X==.
for var group*: gen N_TT_city`num'_X = tt_city_id`num'*X
*for var N_TT_city`num'_*: replace X=0 if X==.
}

for var group*: gen month_X = month*X
*replace month_X = 0 if month_X==.

for var group*: gen year_X = year*X
*replace year_X = 0 if year_X==.



*********************************************************
*Generate aggregate 6 months window around policy change
*********************************************************

gen window6Months = 0
replace window6Months = 1 if [date>=mdy(4,28,2009) & date<=mdy(4,28,2010) & city==1] | [date>=mdy(1,10,2010) & date<=mdy(1,10,2011) & city==6] | [date>=mdy(10,7,2010) & date<=mdy(10,7,2011) & city==4] | [date>=mdy(10,1,2014) & date<=mdy(10,1,2015) & city==13] | [date>=mdy(10,1,2014) & date<=mdy(10,1,2015) & city==2] | [date>=mdy(9,8,2011) & date<=mdy(9,8,2012) & city==12]  


*********************************************************
*Generate  min price indicators
*********************************************************

gen minPrice = 0
replace minPrice = 1 if [date>=mdy(10,28,2009) & city==1] | [date>=mdy(7,10,2010) & city==6] | [date>=mdy(4,7,2011) & city==4] | [date>=mdy(4,1,2014) & city==13] | [date>=mdy(4,1,2014) & city==2] | [date>=mdy(3,8,2012) & city==12] 

gen treatment = 0
replace treatment = 1 if city==1 | city==6 | city==4 | city==13 | city==2 | city==12


gen minPriceXcartel_broad = minPrice*cartel_broad



gen minPriceTsuchiura = 0
replace minPriceTsuchiura = 1 if date>=mdy(10,28,2009) & city==1



gen cartelBroadTsuchiuraXpolicy = cartelBroadTsuchiura*minPriceTsuchiura 




gen minPriceInashiki = 0
replace minPriceInashiki = 1 if date>=mdy(7,10,2010) & city==6



gen cartelBroadInashikiXpolicy = cartelBroadInashiki*minPriceInashiki


gen minPriceHit = 0
replace minPriceHit = 1 if date>=mdy(4,7,2011) & city==4



gen cartelBroadHitXpolicy = cartelBroadHit*minPriceHit



gen minPriceTsukubamirai = 0
replace minPriceTsukubamirai = 1 if date>=mdy(4,1,2014) & city==13


gen cartelBroadTsukubamiraiXpolicy = cartelBroadTsukubamirai*minPriceTsukubamirai


gen minPriceTsukuba = 0
replace minPriceTsukuba = 1 if date>=mdy(4,1,2014) & city==2

gen cartelBroadTsukubaXpolicy = minPriceTsukuba*cartelBroadTsukuba


gen minPriceToride = 0
replace minPriceToride = 1 if date>=mdy(3,8,2012) & city==12


gen cartelBroadTorideXpolicy = cartelBroadToride*minPrice


gen minPriceXcartel_participation = minPrice*cartel_participation

winsor norm_bid, generate(norm_bid_trimmed) p(0.01)

winsor ln_bid, generate(ln_bid_trimmed) p(0.01)

winsor ln_reserve, generate(ln_reserve_trimmed) p(0.01)

