function VAll = VObjgenerator(p);
%makesphericalvoxelphantom(p);
%the following code is used to test if the parameter has been sucessfully
%assigned to each of the spheres 
%should be deleted after the demo


oneDgrid = linspace(0,1,64);
[x,y,z] = ndgrid(oneDgrid,oneDgrid,oneDgrid);


% Make Sphere 1...(the biggest one)
r1 = 0.47;
x1 = 0.5;y1 = 0.5;z1 = 0.5;
[th,phi,r] = cart2sph(x-x1,y-y1,z-z1); %equation of sphere from cart to sphere
Vsph1 = r<r1;

% Make Sphere 2...
r2 = 0.15;
x2 = 0.35;y2 = 0.35;z2 = 0.35;
[th,phi,r] = cart2sph(x-x2,y-y2,z-z2);
Vsph2 = r<r2;

% Make Sphere 3...
r3 = 0.15;
x3 = 0.35;y3 = 0.65;z3 = 0.65;
[th,phi,r] = cart2sph(x-x3,y-y3,z-z3);
Vsph3 = r<r3;

% Make Sphere 4...
r4 = 0.15;
x4 = 0.65;y4 = 0.35;z4 = 0.65;
[th,phi,r] = cart2sph(x-x4,y-y4,z-z4);
Vsph4 = r<r4;

% Make Sphere 5...
r5 = 0.13;
x5 = 0.65;y5 = 0.35;z5 = 0.28;
[th,phi,r] = cart2sph(x-x5,y-y5,z-z5);
Vsph5 = r<r5;

% Label the sphere's with individual 
% labels that will later be used to 
% assign tissue properties...
% Note that we have to handle the exterior
% of the small spheres which lie inside 
% sphere 0 separately; outside sphere 0 must
% have the label of 0.
V1 = xor(Vsph1,Vsph2);
V1 = xor(V1,Vsph3);
V1 = xor(V1,Vsph4);

% Now, assign label 1 to be the exterior of the small spheres that
% lie in the big spheres.
Vsph1 = xor(V1,Vsph5);

%assign tissue properties
T1 = (p.muscle.t1)*Vsph1+(p.skin.t1)*Vsph2+(p.skin.t1)*Vsph3+(p.contissue.t1)*Vsph4+(p.muscle.t1)*Vsph5;
T2 = (p.muscle.t2)*Vsph1+(p.skin.t2)*Vsph2+(p.skin.t2)*Vsph3+(p.contissue.t2)*Vsph4+(p.muscle.t2)*Vsph5;
T2star = (p.muscle.t2star)*Vsph1+(p.skin.t2star)*Vsph2+(p.skin.t2star)*Vsph3+(p.contissue.t2star)*Vsph4+(p.muscle.t2star)*Vsph5;
Rho = (p.muscle.rho)*Vsph1+(p.skin.rho)*Vsph2+(p.skin.rho)*Vsph3+(p.contissue.rho)*Vsph4+(p.muscle.rho)*Vsph5;
MassDen = (p.muscle.mdensity)*Vsph1+(p.skin.mdensity)*Vsph2+(p.skin.mdensity)*Vsph3+(p.contissue.mdensity)*Vsph4+(p.muscle.mdensity)*Vsph5;

%writing data into struct
VObj.Gyro = 267538030.379707;
VObj.ChemShift = 0;
[sizex,sizey,sizez] = size(x);
VObj.XDim = sizex;
VObj.YDim = sizey;
VObj.ZDim = sizez;
VObj.XDimRes = 0.002;
VObj.YDimRes = 0.002;
VObj.ZDimRes = 0.002;
VObj.Type = 'Water';
VObj.TypeNum = 1;
VObj.T1 = T1;
VObj.T2 = T2;
VObj.T2star = T2star;
VObj.Rho = Rho;
VObj.MassDen = MassDen;

outfile = 'myvobj.mat';
save(outfile, 'VObj');
