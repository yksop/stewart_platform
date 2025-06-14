%% angular_velocity
% compute the angular velocity of a rotation matrix and the corresponding
% skew matrix.
% Return the 4 x 4 skew matrix and the vector of angular velocity
function [S_omega, omega] = angular_velocity(frame)
  arguments
    frame (4,4)
  end
  syms rmat S_omega omega t

  if is_frame(frame)
    rmat = get_rotation_matrix(frame);
    S_omega = simplify(expand((rmat.')*diff(rmat,t)));
    omega = make_VECTOR(frame,[S_omega(3,2),S_omega(1,3),S_omega(2,1)]);
  else
    error('Argument is not a frame');
  end
end