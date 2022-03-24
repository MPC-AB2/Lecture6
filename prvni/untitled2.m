
addpath('V:/mpc/ab2/Lecture6')

path = 'V:/mpc/ab2/Lecture6/Ants';

[trajectories] = prvni(path);

[errorTracking] = EvaluationAnts(trajectories);