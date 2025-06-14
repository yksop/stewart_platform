%%translate
% Define a 4 x 4 translation  matrix
function res = translate(coords)
  arguments
    coords (1,3) 
  end
  % definitions of symbolic variables
  %tr = symmatrix('tr',[4,4]);
  syms tr res
  %tr = eye(4,4);
  tr = [1 0 0 coords(1); 0 1 0 coords(2) ; 0 0 1 coords(3); 0  0 0  1];
  
  % Definition of rotation matrices
  % rotation around x-primary axis

 
  %tr(1:3,4) = coords;
  res = tr;
end