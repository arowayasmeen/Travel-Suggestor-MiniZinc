% Places to be visited
enum Places;  
% satisfaction per place
array[Places] of int: satisfaction;
% Limitations
enum Limitations;
% Total amount of each Limitation
array[Limitations] of int: capacity; 

% units of each limitation required to visit 1 place
array[Places, Limitations] of int: consumption;
 
% Variables: how much should we make of each product
array[Places] of var 0..1: visited;
array[Limitations] of var 0..max(capacity): used;

% Production cannot use more than the available Resources:
constraint forall (l in Limitations) (     
      used[l] = sum (p in Places)(consumption[p, l] * visited[p]) 
);

constraint forall (p in Places) (visited[p]<=1); 
constraint forall (p in Places) (visited[p]>=0);
constraint forall (l in Limitations) (     
      used[l] <= capacity[l]
);    

% Maximize satisfaction
solve maximize sum (p in Places) (satisfaction[p]*visited[p]);

output [ "\(p) = \(visited[p]);\n" | p in Places ] ++
       [ "\(l) = \(used[l]);\n" | l in Limitations ];