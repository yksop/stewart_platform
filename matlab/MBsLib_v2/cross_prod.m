%% cross_prod
% the function make the cross_product between two vectors or between a
% vector and a Force. 
% Return a VECTOR or a TORQUE if second argument is a force
function res = cross_prod(obj1,obj2)
  syms coords;
  if strcmp(obj1.type,'VECTOR') & strcmp(obj2.type,'VECTOR') || ...
     strcmp(obj1.type,'VECTOR') & strcmp(obj2.type,'FORCE')
    u_frame  = obj1.frame;
    v2   = project(obj2,u_frame);
    U = obj1.coords;
    V = v2.coords;
    W = make_VECTOR(u_frame ,simplify([U(2)*V(3)-U(3)*V(2), U(3)*V(1)-U(1)*V(3), U(1)*V(2)-U(2)*V(1)]));
    if strcmp(obj2.type,'FORCE')
      res = make_TORQUE(W,obj2.body);
    else
      res = W;
    end
  else
    error('cross_prod() operation not allowed between points and vectors and point and point')
  end
end


