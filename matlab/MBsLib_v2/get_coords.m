%% get_coords
% Get the coordinates of a POINT or VECTOR in its frame or in the new given
% frame. A 1x4 vector is returned.
% Return a vector with the coordinates of the obejct
%  - if frame is given: object is projected in given frame and coordinates
%  are given in the new frame
%  - if frame is not given: ocoordinates of the object are given in object farme
function res = get_coords(obj,varargin)
  % arguments
  %   frame (4,4)
  % end
  syms res
  if isstruct(obj) & ( strcmp(obj.type,'POINT') || strcmp(obj.type,'VECTOR'))
    if nargin == 2 % if given frame: object is projected in frame
      frame = varargin{1};
      if ~is_frame(frame)
        error('A frame matrix is expected')
      end
      tmp_obj = project(obj,frame);
      res = tmp_obj.coords;
    else % if frame is not given: coordinates of the object are given in object frame
      res = obj.coords;
    end
  else
    error('Unexpected input: not a POINT or a VECTOR')
  end

end