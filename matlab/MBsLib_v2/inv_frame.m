%%
% Compute the inverse of rotation transformation matrix
function res = inv_frame(frame)
  arguments
    frame (4,4) sym
  end
  % definitions of symbolic variables
  syms rm res
  if is_frame(frame)
    rm  = frame(1:3,1:3).'; %transpose of rotation matrix
    po  = -rm*frame(1:3,4);
    res = [[rm;0 0 0 ],[po; 1]];
  end
end