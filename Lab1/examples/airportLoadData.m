% AIRPORTLOADDATA Loads data for Table of Distances between airports

%% Define the Radius of the Earth
spmd
    Rkm = 6378.1;  % in kilometers
    Rmi = 3963.2;  % in miles
    R = Rmi;
end

%% Load Data for Airport Distances Application
spmd 
    % Load data from the MAT-file 
    vars = load('airportdata');
    
    % Extract variables into replicated arrays
    lat = vars.lat;
    long = vars.long;
    airportcodes = vars.airportcodes;
end
