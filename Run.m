% This script contains the parameters of different tissues.
% a table is set up. 
% It has three(for now) different sets of tissue properties including 
% T1, T2, T2*, Proton density Rho, Mass Density

%Parameters = struct(muscle,skin,contissue)

p.muscle = struct('t1', 1.1, 't2', 0.035, 't2star', 0.0175, 'rho', 0.7, 'mdensity', 1090);
p.skin = struct('t1', 0.3, 't2', 0.03, 't2star', 0.015, 'rho', 0.6, 'mdensity', 1908);
p.contissue = struct('t1', 1, 't2', 0.042, 't2star', 0.021, 'rho', 0.75, 'mdensity', 1027);

VObjgenerator(p);