%%  make_POINT
% Create a point object: it is a structure that contains
% - type 
% - frame: where coordinates are specified
% - coords: coordinates of point in frame 
function obj = make_POINT(frame,coords)
  arguments
    frame (4,4)
    coords (1,3)
  end
  if is_frame(frame)
    obj.type    = 'POINT';
    obj.frame   = frame;
    obj.coords  = [coords,1].';
  end
end