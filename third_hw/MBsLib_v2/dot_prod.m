%% dot_prod
% the function make the dot_product between two vectors:
% Return a scalar expression
function res = dot_prod(obj1,obj2)
  syms coords;
  if strcmp(obj1.type,'VECTOR') & strcmp(obj2.type,'VECTOR')
    tmp1    = project(obj1,ground());
    tmp2    = project(obj2,ground());
    res    = (tmp1.coords.')*tmp2.coords;
  else
    error('dot_prod() operation not allowed between points and vectors and point and point')
  end
end