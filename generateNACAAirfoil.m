function generateNACAAirfoil(M, P, T)

    % Convert inputs to numbers
    M = 0.02; % Maximum camber (0 - 0.095)
    P = 0.3;  % Location of maximum camber (as a fraction of chord) (0 - 0.9)
    T = 0.1; % Maximum thickness (0.01 - 0.4)

    % Number of points
    N = 100;

    % Generate x-coordinates from 0 to 1 (chord length)
    x = linspace(0, 1, N);

    % Calculate camber line
    if P == 0
        yc = zeros(size(x));
        dycdx = zeros(size(x));
    else
        yc = zeros(size(x));
        dycdx = zeros(size(x));
        for i = 1:length(x)
            if x(i) <= P
                yc(i) = (M/P^2)*(2*P*x(i) - x(i)^2);
                dycdx(i) = (2*M/P^2)*(P - x(i));
            else
                yc(i) = (M/(1-P)^2)*((1 - 2*P) + 2*P*x(i) - x(i)^2);
                dycdx(i) = (2*M/(1-P)^2)*(P - x(i));
            end
        end
    end

    % Calculate thickness distribution
    yt = 5*T*(0.2969*sqrt(x) - 0.1260*x - 0.3516*x.^2 + 0.2843*x.^3 - 0.1015*x.^4);

    % Calculate angle of camber line
    theta = atan(dycdx);

    % Calculate upper and lower airfoil coordinates
    xu = x - yt.*sin(theta);
    xl = x + yt.*sin(theta);
    yu = yc + yt.*cos(theta);
    yl = yc - yt.*cos(theta);

    % Plot airfoil
    figure;
    plot(xu, yu, 'b', 'LineWidth', 2); hold on;
    plot(xl, yl, 'r', 'LineWidth', 2);
    axis equal;
    xlabel('x');
    ylabel('y');
    title(['NACA ' num2str(M*100) num2str(P*10) num2str(T*100) ' Airfoil']);
    legend('Upper Surface', 'Lower Surface', 'Location', 'NorthEast');

end
