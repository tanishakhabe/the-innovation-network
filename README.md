# The Innovation Network

## Poster

[View the project poster](https://drive.google.com/file/d/1V60TL5ReInIoz1xXVWha84zwfIwjgvFz/view)

## Overview

This project investigates the impact of social capital on the propensity to
innovate within U.S. commuting zones by analyzing social networks and
innovation metrics.


## Repository layout

- [`code/`](./code/) contains the Stata analysis scripts.
- [`data/`](./data/) contains source, intermediate, and final datasets.
- [`figures/`](./figures/) contains generated plots.

## Requirements

This project requires Stata and the following Stata add-ons:

```stata
ssc install binscatter
ssc install coefplot
ssc install extremes
```

Run the scripts from the repository root so their relative paths resolve
correctly. The workflow begins with
[`01_clean_merge.do`](./code/01_clean_merge.do), followed by
[`02_descriptive_stats.do`](./code/02_descriptive_stats.do) and
[`03_regressions.do`](./code/03_regressions.do).

