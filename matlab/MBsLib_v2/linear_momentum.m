%% linear_momentum
% return the vector of a linear momentum of a body
function res = linear_momentum(body)
   if strcmp(body.type,'BODY')
     res = velocity(body.com);
     res.coords = body.mass*res.coords;
   else
    error('Expected a body as first argument')
   end
end