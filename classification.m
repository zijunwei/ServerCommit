% given the training data, classify them uisng chi-square svm
load('H2_tstLb');
load('H2_trLb');
 
load('tstD_full.mat');
load('trD_full.mat');


classTxt = {'AnswerPhone', 'DriveCar', 'Eat', 'FightPerson', 'GetOutCar', 'HandShake', ...
    'HugPerson', 'Kiss', 'Run', 'SitDown', 'SitUp', 'StandUp'};
C=100;
aps = svms.kerSVM(C, trD, trLb, tstD, tstLb,classTxt);

