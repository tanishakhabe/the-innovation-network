// Run from the repository root.
import delimited "data/social_capital_county.csv", clear

// Splitting the county_name variable. 
split county_name, parse(",") generate(part)

rename part1 new_county_name
rename part2 state_name

// Adding "County" to the new_county_name variable. 
replace new_county_name = new_county_name + " County"

drop county_name
rename county county_number

save "data/social_capital_data.dta", replace


// Loading in the crosswalk data. 
import excel "data/commuting_zone_names.xls", sheet("Sheet1") firstrow clear

rename CountyFIPS county_number

save "data/cz_crosswalk_data.dta", replace


// Merging the social_capital and crosswalk data sets to get the data down to the commuting zone level.
use "data/social_capital_data.dta", clear
merge 1:1 county_number using "data/cz_crosswalk_data.dta"
keep if _merge == 3

save "data/merged_social_capital_data.dta", replace

// Merging the opportunity insights neighborhood characteristics dataset and the inventors dataset.

use "data/cz_covariates.dta", clear
rename cz commuting_zone
save "data/cz_neighborhood_characteristics.dta", replace

use "data/inventors.dta", clear
rename par_cz commuting_zone
save "data/inventors.dta", replace

merge 1:1 commuting_zone using "data/cz_neighborhood_characteristics.dta"
save "data/merged_inventors_opportunity_atlas_data.dta", replace

// Doing the final merge of the Social Capital and OA/Inventors datasets.

// First, collapsing the merged_social_capital_data. 
use "data/merged_social_capital_data.dta", clear
rename CZ1990definition commuting_zone
sort commuting_zone
collapse (mean) ec_county clustering_county support_ratio_county volunteering_rate_county civic_organizations_county, by(commuting_zone)
save data/aggregated_county_social_capital_data.dta, replace

// Then, merging it with the other two datasets, OA and Inventors. 
use "data/merged_inventors_opportunity_atlas_data.dta", clear
drop _merge
merge 1:1 commuting_zone using "data/aggregated_county_social_capital_data.dta"
save "data/final_inventors_sc_oa_data.dta", replace
