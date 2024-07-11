### Contacts

Arcenis Rojas (Former BLS Analyst who wrote cepumd package) - [GitHub](https://github.com/arcenis-r), [LinkedIn](https://linkedin.com/in/arcenisrojas), [blog](https://arcenis-r.github.io/ajr-portfolio/).

Taylor Wilson (Former BLS Economist that is contact point on downloaded [training](https://www.bls.gov/cex/pumd/documentation/trainings.zip) from CEX) - [LinkedIn](https://www.linkedin.com/in/taylorjameswilson/)

Shane Meyers (BLS Economist) Meyers.Shane@bls.gov

Bryan Rigg (BLS Economist) Rigg.Bryan@bls.gov

### Questions

To Arcenis Rojas: 
1. You note in your [introduction to cepumd](https://arcenis-r.github.io/ajr-portfolio/posts/20240124-cepumd-intro/cepumd-intro.html#dealing-with-inconsistent-code-definitions) that calculating medians (and any quantile value) with `ce_quantiles()` is not recommended for _integrated_ expenditures because the calculation involves using weights from both the Diary and Survey instruments. 

In a scenario where there are categories that have a number of items from both the Interview and Diary surveys, such as the PETS UCC group which has pet food and vet services from the Diary survey and pet purchase, supplies, and medicine, and pet services from the Interview survey, would it be advisable to calculate the median expenditures for UCCs only from the Diary survey and Interview survey for that group separately and then add them together to approximate a total? Or would the weighted mean via `ce_mean()` from the integrated product be more appropriate?

2. Is there any way to account for CUs that did _not_ purchase an item in the specified purchasing period and calculate means/percentiles of items for only CUs that did?

~~3. What is the way I can tell if a UCC/item is only from the interview or diary product?~~
A: You can get hierarchical structure from the [Hierarchical Groupings (HG) zip file](https://www.bls.gov/cex/pumd/stubs.zip) output when run through the `cepumd::ce_hg()` function

My motivation for asking both these questions is that I am checking to see how well the weighted means published in the [BLS annual detailed expenditure means tables](https://www.bls.gov/cex/tables/calendar-year/mean/cu-all-detail-2022.pdf) are good measures of centrality for each item category. Some of the categories I am interested in have very high percent reporting rates such as food at home, healthcare, gasoline, other fuels, and motor oil, computer information services (internet), and telephone services have very high percent reporting rates but others such as pets, septic tank cleaning, trash and garbage collection, and other vehicle expenses had lower than 50% of consumer units reporting during the time period.

I am hoping this microdata would provide me the ability to get a better sense of the CU expenditure density distrubtion for each item/category I'm interested in so I'm able to make a more informed selection of the most appropriate measure of centrality to report on.