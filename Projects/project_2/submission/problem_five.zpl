var x_tv integer >=0 <=12;
var x_news integer >=0 <=5;
var x_prime integer >=0 <=25;
var x_after integer >=0 <=20;

maximize profit:
  5000 * x_tv + 8500 * x_news + 2400 * x_prime + 2800 * x_after;
  
subto radio_time:
  x_prime + x_after >= 5;
  
subto radio_cost:
  290 * x_prime + 380 * x_after <= 1800;
  
subto budget:
  800 * x_tv + 925 * x_news + 290*x_prime + 380 * x_after <= 8000;    