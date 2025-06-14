%% get_origin
% return the origin (ie.e the point) of the given reference frame
% Return a new 'POINT' object with coordinates [0 0 0] and rotaiuon matrix
% the one of the given frame
function res = get_origin(frame)
  arguments
    frame (4,4) 
  end
  if ~is_frame(frame)
    error('A frame matrix is expected')
  end
  res = make_POINT(frame,[0 0 0]);
end