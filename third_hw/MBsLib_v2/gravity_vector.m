%%  gravity_vector
% given the gravity vector components
% Return a vector which is the vector of gravity in ground frame 
function obj = gravity_vector(comps)
  arguments
    comps (1,3)
  end
    obj.type    = 'VECTOR';
    obj.frame   = ground();
    obj.coords  = [comps,0].';
end