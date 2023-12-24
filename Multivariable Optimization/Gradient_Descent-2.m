
    
%% ENTER YOUR CODE HERE

function [x_final, y_final, n_iteracions, x_real, y_real, minim_final, minim_real] = Gradient_Descent (tria_funcio, x_inicial, y_inicial, alfa)
question1 = 'How many maximum iterations ';
question2 = 'What is the alpha?';
itermax = input(question1)
tol = input(question2)
tolreal=0;
Grad =[];
positions=[];
values=[];
j=0;
z=Generate_fxy(tria_funcio);



top_x=(size(z,1)-1)/2;
top_y=(size(z,2)-1)/2;
botom_x=-(size(z,1)-1)/2;
botom_y=-(size(z,2)-1)/2;
x_ini=x_inicial;
y_ini=y_inicial;


  x_c=x_inicial+100;

   y_c=y_inicial+100;



 
 for i = 1:itermax+1
   x_1= z(round(x_c)-1,round(y_c));
   x_2= z(round(x_c)+1,round(y_c));
   y_1= z(round(x_c),round(y_c)-1);
   y_2= z(round(x_c),round(y_c)+1);

 Gradx = (x_2 - x_1)/2;
 Grady = (y_2 - y_1)/2;
   
      x_c = x_c - alfa*Gradx;
      y_c = y_c - alfa*Grady;

       
   
tolreal=(abs(alfa*Gradx)+abs(alfa*Grady));
           if tolreal<tol
             text0=['        Hemos alcanzado el mínimo por criterio tolerancia          '];
             disp('---------------------------------------------------------------------')
             disp(text0)
             disp('---------------------------------------------------------------------')
             break;
        end

         values=[values,[z(round(x_c),round(y_c))]];
         Grad = [Grad,[Gradx;Grady]];
         positions = [positions, [x_c-100;y_c-100]];
         j=j+1;
 end
 
 [M,I]=min(min(z));
  minim_real=M;
 [row,col]=find(z==M);
  x_real=row-100;
  y_real=col-100;


     
[M,I]=min(min(z));
minim_real=M;
[row,col]=find(z==M);
x_real=row-100;
y_real=col-100;
n_iteracions=j;
x_final=positions(1,j);
y_final=positions(2,j);
minim_final=(z(round(x_final)+100,round(y_final)+100));
save('positions');
save('values');



end

