# Neobis_iOS_StopWatch

## Table of contents
* [Description](#description)
* [Getting started](#getting-started)
* [Usage](#usage)
* [Running the Tests](#running-the-tests)
* [Workflow](#workflow)
* [Design](#design)
  
## Description 

This is the second project in Neobis Club. This app has two main functionalities: Timer and StopWatch. Design of project created by storyboard. 

## Getting started 

- Make sure you have the XCode version 14.0 or above installed on your computer
- Download the project files from the repository
- Open the project files in Xcode
- Run the active scheme by using any emulator (No install requirements for this project)

## Usage

App has two functionalities and to switch between each other there have UISegmentedControl, by clicking which we change image view on the top of screen.    
Timer has three action buttons: start, pause and stop buttons. Each of this buttons manipulate with timer. To show how much time has passed after start, there is timer label under segmented control.    
StopWatch also has this three buttons and label to manipulate and show timer, respectively. Additionally, StopWatch has timePickerView. With these view we can specify the time for the countdown.  

## Running the Tests

First of all, I tested auto-layout functionality by running different versions of apps. And each of them we have all components from design and they placed on right place. But it doesn't work, if we turn this app to 90 degrees.    
Tested action buttons by clicking them in different order like: stop -> pause, start -> start, pause -> pause and etc. and checking how timer will work on each order case. It works correctly on both functionalities.     

## Workflow

- Reporting Bugs:
    If you come across any bugs while using this project, please report us by creating an issue on the Github repository
- Submitting pull requests:
    If you have a bug fix or a new feature for project, feel free to submit a pull request. Make sure that your changes are well-tested.
- Improving documentation:
    If you notice any errors or mistakes in the documentation, you can submit pull request with your changes
- Providing feedback:
    If you have any feedback, you can send an email to project maintainer

## Design

Below is a screenshot of how this two functionalities looks like on iphone 14:
<img width="404" alt="Снимок экрана 2023-10-25 в 09 19 10" src="https://github.com/KryaKa57/Neobis_iOS_StopWatch/assets/132449744/859be69e-d109-4c74-a186-12ee842a9ad6">   
<img width="393" alt="Снимок экрана 2023-10-25 в 09 18 40" src="https://github.com/KryaKa57/Neobis_iOS_StopWatch/assets/132449744/90e864e6-383c-47c5-911c-8bd09287cd46">

