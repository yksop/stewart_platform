%% angular_momentum
% return the vector of angular momentum of a body with respect to the C.o.M.
function AM = angular_momentum(body,ptO)
  if strcmp(body.type,'BODY') & strcmp(ptO.type,'POINT')
    % angular momentum w.r.t. the CoM
    b_frame = body.com.frame;
    [~,omega] = angular_velocity(b_frame);
    J     = body.inertia;
    M     = body.mass;
    %VG    = project(velocity(body.com),b_frame); % linear Momentum
    G     = body.com;
    POG   = project(subtract(ptO,G),b_frame);
    AM    = make_VECTOR(b_frame,J*omega.coords(1:3)); % angular momentum w.r.t. CoM
    if M ~=0
      LM = linear_momentum(body);
      AM = add(AM,cross_prod(POG,LM));
    end
  else
    error('Expected a body as first argument')
  end
end
