# Lecture6 - OBJECT TRACKING

[**Benchmark Results**](https://moodle.vut.cz/pluginfile.php/410380/mod_resource/content/1/L6_BenchmarkTracking.xlsx%20-%20List1.pdf)

## Preparation

1. Run Git bash.
2. Set username by: `$ git config --global user.name "name_of_your_GitHub_profile"`
3. Set email by: `$ git config --global user.email "email@example.com"`
4. Select some MAIN folder with write permision.
5. Clone the **Lecture6** repository from GitHub by: `$ git clone https://github.com/MPC-AB2/Lecture6.git`
6. In the MAIN folder should be new folder **Lecture6**.
7. In the **Lecture6** folder create subfolder **NAME_OF_YOUR_TEAM**.
8. Run Git bash in **Lecture6** folder (should be *main* branch active).
9. Create a new branch for your team by: `$ git checkout -b NAME_OF_YOUR_TEAM`
10. Check that  *NAME_OF_YOUR_TEAM* branch is active.
11. Continue to the task...

## Tasks to do

1. Download the data in a zip folder from [here](https://www.vut.cz/www_base/vutdisk.php?i=286473a42c). Extract the content of the zip folder into **Lecture6** folder. It contains folder **Ants** with 215 *00000XXX.jpg* during time acquired images of Petri dish with 6 ants.
2. Load all images from folder **Ants**.
3. Design and implement an automatic tracking algorithm to track all ants in all images separately.
4. Use the provided MATLAB function for evaluation of the results and submit the output to the provided Excel table. The function *EvaluationAnts.p* called as:
`[errorTracking] = EvaluationAnts(trajectories)`,
has the following inputs and outputs:
  * trajectories (cell array 1x6, where each cell contains matrix for each ant trajectory; matrix should have size 215x2, where the first column indicates the row coordination in the image and the second column of the matrix indicates the column coordinate in the image. It does not matter on the order of the ants.
  * errorTracking (structure containing fields of MAE (mean absolute error for whole dataset), std (standard deviation), MAE_details (details for track errors), and orderAnts (corrected order of the ants).
5. Store your implemented algorithm as a form of function `[trajectories] = TeamName( path )`; for *trajectories* see above; *path* is the path to the **Ants** folder with containing blind dataset of images. The function will be used for evaluation of universality of your solution using another input scenes. **Push** your program implementations into GitHub repository **Lecture6** using the **branch of your team** (stage changed -> fill commit message -> sign off -> commit -> push -> select *NAME_OF_YOUR_TEAM* branch -> push -> manager-core -> web browser -> fill your credentials).
6. Submit *.tiff* image of the last image from the sequence with trajectory of one ant obtained by your method. [Excel table](https://docs.google.com/spreadsheets/d/1VIllqvMLBjmxFt1AZKB2N-HExYDgqSSt/edit#gid=275097401). The evaluation of results from each team will be presented at the end of the lecture.
