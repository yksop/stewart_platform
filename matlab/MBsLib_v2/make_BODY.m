%%  make_POINT
% Create a body object given a point( the position of the centre of mass) 
% and the mass of the body and optionally the principal axes inertias Ixx Iyy Izz 
% or the full inertia tensor
% It returns a structure that contains
% - type: 'BODY'
% - com:  CoM point object
% - frame: refernce frame of the body with origin in CoM
% - mass: the mass of the object
% - inertia: the inertia tensor computed w.r.t. the CoM in the body frame
% (defined by the com)
function obj = make_BODY(obj,varargin)
  if strcmp(obj.type,'POINT')
    if nargin == 1+1 % only mass is given
     mass = varargin{1};
     inertia = sym(zeros(3,3));  
    elseif nargin == 1+4 % Principal axes inertia tensor is given
     mass = varargin{1};
     inertia = sym(eye(3,3));  
     inertia(1,1) = varargin{2};
     inertia(2,2) = varargin{3};
     inertia(3,3) = varargin{4};
    elseif nargin == 1+7 % Principal axes inertia tensor is given
     mass = varargin{1};
     inertia = zeros(eye(3,3));  
     inertia(1,1) = varargin{2};
     inertia(2,2) = varargin{3};
     inertia(3,3) = -varargin{4};
     inertia(1,2) = -varargin{5}; %Ixy
     inertia(2,1) = -varargin{5};
     inertia(1,3) = -varargin{6}; %Ixz
     inertia(3,1) = -varargin{6};
     inertia(2,3) = -varargin{7}; %Iyz
     inertia(3,2) = -varargin{7};
    end
    % Body reference frame is translated into CoM
    obj.type    = 'BODY';
    obj.com     = make_POINT(obj.frame*translate(obj.coords(1:3)),[0 0 0]);
    obj.frame   = obj.frame*translate(obj.coords(1:3));
    obj.mass    = mass;
    obj.inertia = inertia;
  else
    error('Expecting a point or first argument')
  end
end
