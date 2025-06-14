%% add
% the function can add:
% - a point with a vector to obtain a new point
% - a vector with a vector to obtain a new vector
% Return a  either a point object or a vector
function res = add(obj1,obj2)
  % arguments
  %   frame (4,4)
  % end
  syms coords;
  % P1+V2 --> P2
  if strcmp(obj1.type,'POINT') & strcmp(obj2.type,'VECTOR')
    tmp = project(obj2,obj1.frame);
    coords = simplify(tmp.coords+obj1.coords);
    res = make_POINT(obj1.frame,coords(1:3));
  end
  if strcmp(obj1.type,'VECTOR') & strcmp(obj2.type,'VECTOR')
    tmp = project(obj2,obj1.frame);
    coords = simplify(tmp.coords+obj1.coords);
    res = make_VECTOR(obj1.frame,coords(1:3));
  end
  if strcmp(obj1.type,'POINT') & strcmp(obj2.type,'POINT')
    error('Add() operation not allowed between points')
  end
  if strcmp(obj2.type,'POINT')
    error('Expected a VECTOR for the second argument')
  end

end