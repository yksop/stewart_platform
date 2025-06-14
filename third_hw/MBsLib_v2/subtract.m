%% subtract
% the function can subtract:
% - a point with another point to obtain a new vector between the two
% points
% - a vector with another point to obtain a new vector
% Return  a vector
function res = subtract(obj1,obj2)
  % arguments
  %   frame (4,4)
  % end
  syms coords;
  % P2-P1
  if strcmp(obj1.type,'POINT') & strcmp(obj2.type,'POINT')
    tmp = project(obj2,obj1.frame);  % project P2 in P1 frame
    coords = simplify(tmp.coords-obj1.coords); % P2-P1 in frame of P1
    res = make_VECTOR(obj1.frame,coords(1:3));
  end
  % V2-V1
  if (strcmp(obj1.type,'VECTOR') & strcmp(obj2.type,'VECTOR')) 
    tmp = project(obj2,obj1.frame);   % project V2 in V1 frame
    coords = simplify(tmp.coords-obj1.coords);  % V2-V1 in frame of V1
    res = make_VECTOR(obj1.frame,coords(1:3));
  end
 % P1-V2 --> P2
 if (strcmp(obj1.type,'POINT') & strcmp(obj2.type,'VECTOR'))
    tmp = project(obj2,obj1.frame);  % project V2 in P1 frame
    coords = simplify(obj1.coords-tmp.coords); % P1-V1 in frame of V1 to create P2
    res = make_POINT(obj1.frame,coords(1:3));
  end
  if strcmp(obj2.type,'VECTOR') & strcmp(obj1.type,'POINT')
    error('subtract() operation not allowed between a vector and a point')
  end

end