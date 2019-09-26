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
 
% Is Place visited or not
array[Places] of var 0..1: visited;
% how much of bugdet and time is used
array[Limitations] of var 0..max(capacity): used;

% Cannot use more than the available Budget and Time:
constraint forall (l in Limitations) (     
      used[l] = sum (p in Places)(consumption[p, l] * visited[p]) 
);

constraint forall (l in Limitations) (     
      used[l] <= capacity[l]
);    

% Maximize satisfaction
solve maximize sum (p in Places) (satisfaction[p]*visited[p]);

output [ "\(p) = \(visited[p]);\n" | p in Places ] ++
       [ "\(l) = \(used[l]);\n" | l in Limitations ];
