
var basic_tables;
var deluxe_tables;

maximize profit: 
  200 * basic_tables + 350 * deluxe_tables;

subto legs_constraint:  
  5 * (basic_tables + deluxe_tables) <= 240;

subto wood_tops_constraint:  
  basic_tables <= 50;

subto glass_tops_constraint:  
  deluxe_tables <= 35;

subto assembly_hours_constraint: 
  0.6 * basic_tables + 1.5 * deluxe_tables <= 63;
