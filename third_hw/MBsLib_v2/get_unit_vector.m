%% get_unit_vector
% Get the unit vector of a given frame for a desired axis
% Return a new object with coordinates of the unit vector in the frame
function res = get_unit_vector(uv_ax,frame)
  arguments
    uv_ax (1,1) string
    frame (4,4) 
  end

  if ~is_frame(frame)
    error('A frame matrix is expected')
  end
  
  syms pp 
  
  switch uv_ax
    case 'X'
       pp  = frame(1:3,1);  
    case 'Y'
       pp  = frame(1:3,2);  
    case 'Z'
       pp  = frame(1:3,3);  
    otherwise
      error('Unknown axis %s. Options are {X,Y,Z}.',uv_ax)
  end
  res = make_VECTOR(frame,pp(1:3));
end