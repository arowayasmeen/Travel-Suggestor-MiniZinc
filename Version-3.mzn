% Hotels to be visited
enum Hotels;  
% Ratings per hotels
array[Hotels] of int: Ratings;
% Limitations aka budget
enum Limitations;
% Total amount of Limitation/budget
array[Limitations] of int: capacity; 

% units of each limitation required to stay at 1 hotel
array[Hotels, Limitations] of int: consumption;
 
% Is hotel visited or not
array[Hotels] of var 0..1: visited;
% how much of bugdet is used
array[Limitations] of var 0..max(capacity): used;

% Cannot use more than the available Budget:
constraint forall (l in Limitations) (     
      used[l] = sum (p in Hotels)(consumption[p, l] * visited[p]) 
);

constraint forall (l in Limitations) (     
      used[l] <= capacity[l]
);    

% Maximize satisfaction
solve maximize sum (p in Hotels) (Ratings[p]*visited[p]);

output [ "\(p) = \(visited[p]);\n" | p in Hotels ] ++
       [ "\(l) = \(used[l]);\n" | l in Limitations ];