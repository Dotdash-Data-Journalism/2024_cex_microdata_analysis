The CEX microdata files are available [here](https://www.bls.gov/cex/pumd_data.htm#csv) and are the necessary format for usage with the `cepumd` package.

You will need to download both the Intervew Survey "Interview" as well as the Diary Survey "Diary" zip files to analyze the full breadth of the CEX.

You will also need to download the [Hierarchical Groupings (HG) zip file](https://www.bls.gov/cex/pumd/stubs.zip) which includes a description of each UCC along with its hierarchical standing within each expenditure or income category for a given year. This file can be found on the [CEX PUMD Documentation page](https://www.bls.gov/cex/pumd_doc.htm). 

Interview and Diary HG files are available starting in 1997 and integrated files start in 1996. For consistency, cepumd functions only work with data starting in 1997. For years 1996 and forward, three file types are available:

* __Integrated groupings__ lists UCCs that the CE tables use, and identifies the survey source for the UCCs. These files use this naming convention: CE-HG-Integ-2017.
* __Interview groupings__ lists the UCCs from the Interview Survey. These files use this naming convention: CE-HG-Inter-2017. Not available for 1996.
* __Diary groupings__ list the UCCs from the Diary Survey. These files use this naming convention: CE-HG-Diary-2017. Not available for 1996.
For each UCC, the files provide this information:

It is also helpful to download the [data dictionary for the PUMD interview and diary surveys](https://www.bls.gov/cex/pumd/ce-pumd-interview-diary-dictionary.xlsx) which provide the UCC variables and codes in an Excel file. This can also be found on the [CEX PUMD Documentation page](https://www.bls.gov/cex/pumd_doc.htm). 

## [Consumer Expenditure Surveys (CE/CEX) Public Use Microdata (PUMD) Getting Started Guide](https://www.bls.gov/cex/pumd-getting-started-guide.htm)

### Section 1 CE Program
CE data are collected by the Census Bureau for the Bureau of Labor Statistics (BLS) in two surveys, the Interview Survey for major and/or recurring items, and the Diary Survey for more minor or frequently purchased items.

#### 2.1 CE PUMD files
All PUMD files cover a full calendar year. For years prior to 1996, file availability may be limited. For a more comprehensive list of files provided in the CE PUMD, see the [Data Dictionary for the Interview and Diary Surveys](https://www.bls.gov/cex/pumd/ce-pumd-interview-diary-dictionary.xlsx)

* __What to consider when usign PUMD files?__
The files contain individual survey responses. Thus their uses depend on the survey design. For example, the CE survey design supports reliable national averages of major expenditures. However, it may not support reliable estimates for some states. For more information, see [CE Considerations When Using the public use Microdata](https://www.bls.gov/cex/research_papers/pumd-understanding-constraining-considerations.htm).

#### 2.2 CE PUMD file conventions
* __How do data users link an interview or diary for a given Consumer Unit (CU) in different files?__
NEWID links data for one CU across interviews and files. *Users cannot link CUs across surveys because the Diary and Interview surveys use different samples.*

* __How is the variable NEWID structured?__
NEWID is a unique sequential number concatenated with the number of the interview. The last digit of NEWID indicates the interview number in a series of 4, or the week of diary collection in a series of 2. All values prior to the last digit, identify a CU.

### Section 7 Considerations
#### 7.5 Impact of CE methods on some categories of data
The available detail for some categories may have limited analytical use due to the following major reasons:
* __CE program bundles some products into single categories__: Some items are grouped with others into one Universal Classification Code (UCC) because sparse data preclude them from being presented separately. For example, Apple watches, answering machines, Bluetooth accessories, cell phones, cell phone covers, chargers, cordless telephones, headsets, phone jacks and cords, selfie sticks, smartphones, and smartwatches are all bundled into the category "Telephones and accessories." In this case data users cannot identify expenditures on the individual items that are contained in the bundled UCC.

* __PUMD exclude data that could divulge a respondent's identity__. To prevent data users from identifying respondents, the CE program applies a number of methods to mask the identity of its respondents. Thus a published value may differ from the reported value. PUMD flags these items. For more information on these methods, see CE's [Protecting Respondent Confidentiality](https://www.bls.gov/cex/pumd_disclosure.htm).

#### 7.7 Analyzing aggregate data over time
Trend analyses of aggregated PUMD variables and to a lesser degree, items in CE tables, over several years are limited by the changes in collection and sampling methods. For example, every ten years the CE program introduces a new sample design. Generally, when the CE program introduces a new sample design, method, item, or question, the program does not create an overlap where both the old and the new version are available during the transition.

However, longitudinal analysis of major categories across several years is possible if the data user concludes that the changes in the underlying collection methods do not affect the overall trend. Generally, larger categories are less impacted than small categories. For a list of the main survey changes in the history of the CE program, see [Consumer Expenditures and Income: History](https://www.bls.gov/opub/hom/cex/history.htm) in the BLS Handbook of Methods.

