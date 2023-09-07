a = 2.5;
b = 2.5;
c = 1.5;
lawofcosines(a,b,c);

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