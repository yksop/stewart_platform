%% get_com
% return the centre of mass of the body. It is a point
function res = get_com(body)
   if strcmp(obj.type,'BODY')
     res = obj.com;
   else
    error('Expected a body as first argument')
   end
end