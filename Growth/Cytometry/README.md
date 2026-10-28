# Quantify bacteria by flow cytometry

In some cases, bacterial growth cannot be reliably quantified by optical density measurements. This may occur, for example, when the medium contains an insoluble carbon source or when the culture consists of two distinct bacterial populations. In such cases, bacterial abundance can instead be quantified by counting SYBR-stained bacteria by flow cytometry. We are using a [Beckman Cytoflex](https://goto.beckman.com/en/cytoflex/?campaign=1623714122&adgroup=61311338146&asset=705192651245&kw=facs%20flow%20cytometer&match=p&device=c&gad_source=1&gad_campaignid=1623714122&gclid=Cj0KCQjwt9jVBhDXARIsAFSP-6ccxUneT9WpIc_BT97NvR5tMVV2VHXAF_bz7zLtNmnLI-Zj77qDxq8aAriXEALw_wcB) instrument with three lasers:

### Lasers

-   Violet Laser: 405 nm
-   Blue Laser: 488 nm
-   Red Laser: 638 nm

### Bandpass Filters (center/bandwidth)

-   450/45 nm

-   525/40 nm

-   585/40 nm

-   660/20 nm

-   690/50 nm

-   780/60 nm

## Set the threshold and gain at sample acquisition

There are 3 parameters that are set at sample acquisition: threshold, gain, and width. We are using the CytoFLEX to quantify bacteria labeled with SYBR-green (495/520 nm). Thus, we use FL1 fluorescence channel (488/525) to set these parameters:

1.  Threshold: Run sample of SYBR-stained medium (ie lignocellulose medium) without cells. Examine univariate distribution of FL1-H fluorescence. Set min threshold to exclude lignocellulose particles.
2.  Gain: Run sample of SYBR-stained bacteria. Examine FL1-H distribution. Set gain so cell distribution is mid decades of log-scale.
3.  Width: keep software defaults.

## Sample acquisition

The abort rate will be elevated if the sample is too concentrated. Run a sample at 10 ul/min. If the abort rate is \>5%, dilute the sample and run again. Run a sample for 20 seconds with a target event rate of 1e3-3e3 events/second, leading to a total of 2e4 - 6e4 events. Save data as .FSC file

## Count cells by analysis of .FSC files

[This code](./model_cytoflex.qmd) and [Quarto html](./model_cytoflex.html) describes how to quantify SYBR-stained bacteria from flow cytometry data (FCS files) using the R [flowCore package](https://bioconductor.org/packages/release/bioc/html/flowCore.html). Data is read into a flowFrame object and then bacterial cells are differentiated from background using a multi-step gating strategy:

1.  Gate 1: Define min threshold of SYBR fluorescence. Examine FL1-A univariate plot of unstained sample. Set min FL1-A threshold as max FL1-A in unstained sample.
2.  Gate 2: Examine univariate plot of SSC-1-A (violet distribution) of SYBR-stained sample. Set min/max thresholds to capture main population.
3.  Gate 3: Plot data of bivariate plot FL1-A (x-axis) vs SSC-1-A violet (y-axis). Apply rectangular gates defined by Gate 1 (FL1-A) and Gate 2 (SSC-1-A) to quantify cells.
4.  Gate 4: Remove doublets. Plot SSC-1-A (x-axis) vs SSC_1-H (y-axis) and apply rectangular gate to remove event that are not on the diagona. This removes coincident/aggregated events (doublets).