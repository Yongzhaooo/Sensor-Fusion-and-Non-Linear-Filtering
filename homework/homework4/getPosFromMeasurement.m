function [x, y] = getPosFromMeasurement(y1, y2, s1, s2)
    x = (s2(2) - s1(2) + tan(y1) * s1(1) - tan(y2) * s2(1)) / (tan(y1) - tan(y2));
    y = s1(2) + tan(y1) * (x - s1(1));
end