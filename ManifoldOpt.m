
clc;
clear;
close all;

% S = rand(3, 3);
% A = (S + S') / 2;

A = [ 0.6354    0.3127    0.4271;
    0.3127    0.0768    0.4764;
    0.4271    0.4764    0.9988];

disp(A);

[U,Sigma,~] = svd(A);
Minimizer = U(:,3);
disp(Minimizer);

maxiter = 150;
x0 = [0 ; -1; 0];
alpha = 0.01;
[x, iterates,conv] = RGDsphere02(A, x0, alpha, maxiter);

disp(iterates(:,maxiter));

% Generate the unit sphere
[X, Y, Z] = sphere;

% Plot the unit sphere
figure;
surf(X, Y, Z);
axis equal;
hold on;
legend('off');

MarkerSize = 10;
font_size = 14;

points = iterates';

h_limit_point = plot3(Minimizer(1, 1), Minimizer(2, 1), Minimizer(3, 1), 'bo', 'MarkerSize', MarkerSize, 'MarkerFaceColor', 'b');

pause(3);

% Plot the points one by one to create an animation effect
for i = 1:maxiter
    h_seq = plot3(points(i, 1), points(i, 2), points(i, 3), 'ro', 'MarkerSize', MarkerSize, 'MarkerFaceColor', 'r','DisplayName', 'Iterate');
    title('Riemannian Gradient Descent - Convergence','FontSize', font_size + 4);
    legend([h_limit_point, h_seq], {'Minimizer', 'Current iterate'}, 'FontSize', font_size);    
    pause(0.1);  % Pause between plotting points
    delete(h_seq);
end


hold off;

