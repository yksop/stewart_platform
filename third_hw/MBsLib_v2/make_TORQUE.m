%%  make_TORQUE
% Create a troque object: it is a structure that contains
% - type: store the type of object in this  case is 'TORQUE'. It is used to
% check if an operation is valid or not for the object.
% - vector: the vector of magnitute and direction of torque 
% - application_point: the point where the force is applied
% - acting_on_body: the body  the force is applied to
function obj = make_TORQUE(vec,body)
 
  if ~strcmp(vec.type,'VECTOR')
    error('First argument must be a VECTOR. Received %s',vec.type);
  end
  if ~strcmp(body.type,'BODY')
    error('Third argument must be a BODY. Received %s',body.type);
  end
  obj.type              = 'TORQUE';
  obj.vector            = vec;
  obj.acting_on         = body;
end
