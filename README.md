# A very minimal {targets} demonstration and exercises

## Overview

This is an introduction to {targets}. The targets package is a Make-like pipeline tool for statistics and data science in R. https://books.ropensci.org/targets/ 

The philosophy is for this demonstration is to be **as simple as possible**, and focus on the key aspects of why making pipelines is a good idea.

Unlike most pipeline tools, which are language agnostic or Python-focused, the targets package allows data scientists and researchers to work entirely within R. targets implicitly nudges users toward a clean, function-oriented programming style that fits the intent of the R language and helps practitioners maintain their data analysis projects.

There are some slides in `/slides` which I use for introducing the concepts.

## Demonstration - getting to grips with {targets}

In order to demonstrate {targets} functionality, I show how a basic R script can be written as a {targets} pipeline. This pipeline takes a csv of two numeric variables, `x` and `y` and produces a plot with a linear model prediction.

The first script `0_generate_test_data.R` sets up some example data to use in the demonstration. It creates an `inputs` and `outputs` folders (which are ignored by git).

I first walk through how you might write this script with a "business as usual" approach, no {targets}. This is demonstrated in `1_non_targets_version.R` and does all the things you'd expect how it might work if you didn't use targets.

I then use `2_targets_version.R` as a reference for myself but don't show it to participants. Encourge users to create their own `_targets.R` file and create the pipeline step by step. These are roughly the steps I walk through to demonstrate the usage of {targets}:

 - Create a `_targets.R` file
 - Add `library(targets)`
 - Add `list()` to the end of the file
 - Add `tar_target(data_file, "inputs/data.csv",format = "file")` to make a 1 node pipeline, explain the importance of `format="file"`
 - Then do `tar_visnetwork()` then `tar_make()` then `tar_visnetwork()` again to show how it updates the graph
 - Add `tar_target(data, read.csv(data_file))`
 - Define a function to model the data and add `tar_target(data_model, model_data(data))`. Do `tar_visnetwork()` to show how functions appear.
 - Explain how the tracking works, take a look in the `targets` folder and show `tar_read()`
 - Add the rest of the pipeline, including explaining how outputs (noting how the function returns file path not R object), highlight use of `format="file"` again.
 - Get participants to ask questions and modify pipeline in response to demosntrate your answer

## Extra bits

`3_static_branching.R` shows how you can do static branching by subsetting the iris dataset by species and producing a species for each plot.

Other things you might want to cover:

 - How to put your R functions in separate files (eg. `R/functions.R`) and source them from `_targets.R` to help you organise your code.
 - How to have multiple targets dependent on the same target
