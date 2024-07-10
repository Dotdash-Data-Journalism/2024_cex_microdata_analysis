The CEX microdata files are available [here](https://www.bls.gov/cex/pumd_data.htm#csv) and are the necessary format for usage with the `cepumd` package.

You will need to download both the Intervew Survey "Interview" as well as the Diary Survey "Diary" zip files to analyze the full breadth of the CEX.

You will also need to download the [Hierarchical Groupings (HG) zip file](https://www.bls.gov/cex/pumd/stubs.zip) which includes a description of each UCC along with its hierarchical standing within each expenditure or income category for a given year. This file can be found on the [CEX PUMD Documentation page](https://www.bls.gov/cex/pumd_doc.htm). 

Since hierarchical groupings are not available prior to 1996 the `cepumd` package will not calculate statistics from integrated data prior to that year. For years 1996 and forward, three file types are available:

* __Integrated groupings__ lists UCCs that the CE tables use, and identifies the survey source for the UCCs. These files use this naming convention: CE-HG-Integ-2017.
* __Interview groupings__ lists the UCCs from the Interview Survey. These files use this naming convention: CE-HG-Inter-2017. Not available for 1996.
* __Diary groupings__ list the UCCs from the Diary Survey. These files use this naming convention: CE-HG-Diary-2017. Not available for 1996.
For each UCC, the files provide this information:

It is also helpful to download the [data dictionary for the PUMD interview and diary surveys](https://www.bls.gov/cex/pumd/ce-pumd-interview-diary-dictionary.xlsx) which provide the UCC variables and codes in an Excel file. This can also be found on the [CEX PUMD Documentation page](https://www.bls.gov/cex/pumd_doc.htm). 

