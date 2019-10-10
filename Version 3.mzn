% Places to be visited
enum Places ={ Ahsan_Manjil, Lalbagh_Fort, Jatiya_Shangshad_Bhaban, Star_Mosque, Dhakeshwari_Temple, Shishu_Park,Shahid_Minar, Baitul_Mukarram_National_Mosque };  
% satisfaction per place
array[Places] of int: satisfaction;
% Hotels that can be stayed in
enum Hotels;
int : Hotel_Budget;
array[Hotels] of int: hotel_cost;
array[Hotels] of var 0..1: can_be_visited;

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

constraint forall ( p in Hotels) (     
     if hotel_cost[p] <= Hotel_Budget
     then can_be_visited[p]= 1
     else can_be_visited[p]= 0
     endif
);
 
%Certain places cannot be visited on the same day   
constraint visited[Lalbagh_Fort] != visited[Ahsan_Manjil];
constraint visited[Lalbagh_Fort] != visited[Shahid_Minar];
constraint visited[Star_Mosque] != visited[Baitul_Mukarram_National_Mosque];

% Maximize satisfaction
solve maximize sum (p in Places) (satisfaction[p]*visited[p]);

output [ "\(p) = \(visited[p]);\n" | p in Places ] ++
       [ "\(l) = \(used[l]);\n" | l in Limitations ] ++ 
       [ "\(p) = \(can_be_visited[p]);\n" | p in Hotels ];