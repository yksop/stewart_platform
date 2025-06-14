%%
% Check that the matrix is a frame
function res = is_frame(frame)
  %[nr,nc] = size(frame);
  arguments
    frame (4,4)
  end

  if ~frame(4,4)==1 ...
      & ( frame(4,1:3)*(frame(4,1:3).') == 0 )
    error('Matrix is not a frame');
    res = false;
  else
    res = true;
  end
end
