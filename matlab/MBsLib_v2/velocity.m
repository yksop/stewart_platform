%% velocity
% compute the abolute velocity of a point or of a vector withe respect to ground frame.
% It projects coordinates in ground and then takes the time derivative.
% if frame is given velocity with respect to the given frame is computed
% Return a vector object with velocity components expressed in ground or in
% the given frame
function res = velocity(obj,varargin)
  syms t
  if strcmp(obj.type,'POINT') || strcmp(obj.type,'VECTOR')
    if nargin == 2 % if given frame: object is projected in frame
      frame = varargin{1};
      if ~is_frame(frame)
        error('A frame matrix is expected')
      end
      tmp_obj = project(obj,frame);
      coords = diff(tmp_obj.coords,t);
      res = make_VECTOR(frame,coords(1:3));
    else
    tmp = project(obj,ground());
    coords = diff(tmp.coords,t);
    res = make_VECTOR(ground(),coords(1:3));
    end
  end
  
end