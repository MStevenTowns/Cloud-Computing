spmd
    vars = load('airportdata');
    lat = codistributed(vars.lat);
    long = codistributed(vars.long);
    lat = 90 - lat;
    long = 360 + long;
    R = 3963.2;  % in miles
    x = R * sind(lat) .* cosd(long);
    y = R * sind(lat) .* sind(long);
    z = R * cosd(lat);
    coords = [x y z]';    
    dotprod = coords' * coords;
    mag = sqrt(sum(coords.^2));
    angles = min(dotprod ./ (mag' * mag), 1);
    dist = R * acos(angles);    % Arc length
end