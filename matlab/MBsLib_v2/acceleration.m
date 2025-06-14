%% acceleration
% compute the abolute acceleration of a point or of a vector with respect to ground frame.
% It projects coordinates in ground and then takes the time derivative.
% if frame is given, acceleration with respect to the given frame is computed
% Return a vector object with acceleration components expressed in ground
% or in the given frame
function res = acceleration(obj,varargin)
  syms t
  if strcmp(obj.type,'POINT') || strcmp(obj.type,'VECTOR')
    if nargin == 2 % if given frame: object is projected in frame
      frame = varargin{1};
      if ~is_frame(frame)
        error('A frame matrix is expected')
      end
      res = velocity(velocity(obj,frame),frame);
    else
      res = velocity(velocity(obj));
    end
  end
end