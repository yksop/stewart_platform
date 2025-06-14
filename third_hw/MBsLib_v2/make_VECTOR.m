%%  make_VECTOR
% Create a point object: it is a structure that contains
% - type: store the type of object in this  case is 'POINT'. It is used to
% check if an operation is valid or not for the object.
% - frame: where coordinates are defined
% - coords: coordinates of point in frame 
function obj = make_VECTOR(frame,coords)
  arguments
    frame (4,4)
    coords (1,3)
  end
  if is_frame(frame)
    obj.type    = 'VECTOR';
    obj.frame   = frame;
    obj.coords  = [coords,0].';
  end
end