% This code finds the transmission angle (mu) and Time Ration (TR) of a
% 4-bar crank-rocker mechanism

R1 = 2.5; % ground bar
R2 = 3; % input bar
R3 = 1; % connecting bar
R4 = 2; % output bar
calculator(R1,R2,R3,R4);


function [u, TR] = calculator(R1, R2, R3, R4)
    % Sorting input values into s, q, p, l
    matrix = [R1, R2, R3, R4];
    mat = sort(matrix);
    s = mat(1);
    q = mat(2);
    p = mat(3);
    l = mat(4);

    % Rest of calculations
    umax = acosd((l^2 + q^2 - (s + p)^2) / (s * l));
    umin = acosd((l^2 + q^2 - (s - p)^2) / (s * l));
    u = umax - umin;
    Rlow = abs(R2 - R3);
    Rhigh = abs(R2+R3);

    % Use fsolve to find thetaguess
    theta1 = lawofcosines(R1,Rlow,R4);
    theta2 = lawofcosines(R1,Rhigh,R4);
    theta = theta2 - theta1;
    TR = (pi + theta) / (pi - theta);

    % Display the result
    disp(mat(2))
    disp(['umin = ', num2str(umin)]);
    disp(['umax = ', num2str(umax)]);
    disp(['a = ',num2str(theta2)])
    disp(['u = ', num2str(u)]);
    disp(['Time Ratio = ', num2str(TR)]);
end

function theta = lawofcosines(a, b, c)
    % Define a function for fsolve to solve
    fun = @(thetaguess) a^2 - (b^2 + c^2 - 2 * b * c * cos(thetaguess));

    % Initial guess for thetaguess
    thetaguess0 = pi/2;  % You can choose any initial guess you prefer

    % Use fsolve to find thetaguess
    theta = fsolve(fun, thetaguess0);

    % Calculate theta
    %theta = acos((b^2 + c^2 - a^2) / (2 * b * c));

    % Display the result
    disp(['Theta = ', num2str(theta)]);
end
