%% angular_acceleration
% compute the angular acceleration of a rotation matrix 
% Return the vector of angular acceleration in moving frame
function [res] = angular_acceleration(frame)
  arguments
    frame (4,4)
  end
  syms rmat S_omega omega t

  if is_frame(frame)
    [tmp, ang_vel] = angular_velocity(frame);
    res = simplify(velocity(ang_vel));
  else
    error('Argument is not a frame');
  end
end