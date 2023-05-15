function [fx, Fx] = coordinatedTurnMotion(x, T)
    %COORDINATEDTURNMOTION calculates the predicted state using a coordinated
    %turn motion model, and also calculates the motion model Jacobian

    % Input:
    %   x           [5 x 1] state vector
    %   T           [1 x 1] Sampling time

    % Output:
    %   fx          [5 x 1] motion model evaluated at state x
    %   Fx          [5 x 5] motion model Jacobian evaluated at state x

    % Extract state variables from x
    px = x(1);
    py = x(2);
    v = x(3);
    phi = x(4);
    omega = x(5);

    % Motion model equations
    fx = [px + v*cos(phi)*T;
          py + v*sin(phi)*T;
          v;
          phi + omega*T;
          omega];

    % Check if the Jacobian is requested by the calling function
    if nargout > 1
        % Motion model Jacobian
        Fx = [1, 0, cos(phi)*T, -v*sin(phi)*T, 0;
              0, 1, sin(phi)*T, v*cos(phi)*T, 0;
              0, 0, 1, 0, 0;
              0, 0, 0, 1, T;
              0, 0, 0, 0, 1];
    end
end