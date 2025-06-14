%% get_rotation_matrix
% Get the rotation matrix of a given frame
% Return a  3 x 3 rotation matrix
function res = get_rotation_matrix(frame)
  arguments
    frame (4,4) 
  end
  if ~is_frame(frame)
    error('A frame matrix is expected')
  end
  res = frame(1:3,1:3);
end