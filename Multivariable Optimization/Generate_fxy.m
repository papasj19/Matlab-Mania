function [f] = Generate_fxy(choose_function)

%This function returns a two-dimensional function (f(x,y)) depending 
%on the value of the parameter choose_function, which can take the following values:
%   'circular_parboloid', 'elliptical paraboloid', 'inverse_gaussian',
%   'arbitrary_function'
%% DO NOT MODIFY THIS CODE

switch choose_function
    case 'circular_paraboloid'
        for i = 1:201
            for j = 1:201
                f(i,j) = (i-100)^2+(j-100)^2;
            end
        end
               
    case 'elliptical paraboloid'
        for i = 1:201
            for j = 1:201
                f(i,j) = 0.8*(i-100)^2+3*(j-100)^2;
            end
        end
        
    case 'inverse_gaussian'
        f_gauss = 100*fspecial('gaussian', 201, 40);
        f = max(max(f_gauss))-f_gauss;
        
    case 'arbitrary_function'
        mu=[6;14];
        space=[0:.1:20];
        x = repmat(space,201,1);
        y = repmat(space',1,201);
        f1 = 0.7 * (1/(2*pi)) * exp(-0.01 * ((x-mu(1)).^2 + (y-mu(2)).^2)) ...
            + 0.3 * (1/(2*pi)) * exp(-0.1 * ((x-mu(2)).^2 + (y-mu(1)).^2));
        
        f = max(max(f1))-f1;
end