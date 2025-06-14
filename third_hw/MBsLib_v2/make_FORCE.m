%%  make_FORCE
% Create a force object: it is a structure that contains
% - type: store the type of object in this  case is 'FORCE'. It is used to
% check if an operation is valid or not for the object.
% - force: the vector of magnitute and direction of force 
% - application_point: the point where the force is applied
% - acting_on_body: the body  the force is applied to
function obj = make_FORCE(vec,pt,body)
 
  if ~strcmp(vec.type,'VECTOR')
    error('First argument must be a VECTOR. Received %s',vec.type);
  end
  if ~strcmp(pt.type,'POINT')
    error('Second argument must be a POINT. Received %s',pt.type);
  end
  if ~strcmp(body.type,'BODY')
    error('Third argument must be a BODY. Received %s',body.type);
  end
  obj.type              = 'FORCE';
  obj.force             = vec;
  obj.application_point = pt; 
  obj.acting_on_body    = body;
end
