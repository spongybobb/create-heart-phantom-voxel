function VAll = makesphericalvoxelphantom(Parameters);
% Function to make and show a spherical phantom containing
% 4 nested spheres. The "Parameters" argument will be a structure holding
% the parameters of each sphere (radius, and x,y,z positions
% of centres); this is currently not yet set up, but
% will be done in future work
%
% Note - in this approach we *start* in voxel space
% then provide a cool rendering based on using
% the isosurface command to create iso-surfaces

% Later, we will look at how to start in "surface"
% space...

% To Do:
% 1. Go from voxel space to surface representation, and render
% 2. Refactor to pass in the "Parameters" argument to 
%    allow these to be set more sensibly
% 3. Write some code to vary the sphere parameters, but ensuring that
%    there is no "clash of the spheres" in doing so....

% Make a coordinate system that goes from 0 to 1
% in all three dimensions....
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


% This combines all of the individual regions, assigning each
% a different "semantic" label; a bit like connected components
% would do, but since we are generating the data ourselves, 
% we can label it from first principles!
VAll = Vsph1+2*Vsph2+3*Vsph3+4*Vsph4+5*Vsph5;


%tissue properties
T1 = (Parameters.muscle.t1)*Vsph1+(Parameters.skin.t1)*Vsph2+(Parameters.skin.t1)*Vsph3+(Parameters.contissue.t1)*Vsph4+(Parameters.muscle.t1)*Vsph5;
T2 = (Parameters.muscle.t2)*Vsph1+(Parameters.skin.t2)*Vsph2+(Parameters.skin.t2)*Vsph3+(Parameters.contissue.t2)*Vsph4+(Parameters.muscle.t2)*Vsph5;
T2star = (Parameters.muscle.t2star)*Vsph1+(Parameters.skin.t2star)*Vsph2+(Parameters.skin.t2star)*Vsph3+(Parameters.contissue.t2star)*Vsph4+(Parameters.muscle.t2star)*Vsph5;
Rho = (Parameters.muscle.rho)*Vsph1+(Parameters.skin.rho)*Vsph2+(Parameters.skin.rho)*Vsph3+(Parameters.contissue.rho)*Vsph4+(Parameters.muscle.rho)*Vsph5;


Phantom.T1 = T1
Phantom.T2 = T2
Phantom.T2star = T2star
Phantom.Rho = Rho


%plotting
hf = figure('Position', [100, 100, 800, 800]);
set(hf,'Color','w');
cmap = parula(6);
cmap(1,:) = [0,0,0];
for i = 1:64
    subplot(8,8,i)
    image(squeeze(1+VAll(:,:,i)));
    axis off
    axis square
end
colormap(cmap);


disp(''); % I keep this in as a convenient place to set a breakpoint

