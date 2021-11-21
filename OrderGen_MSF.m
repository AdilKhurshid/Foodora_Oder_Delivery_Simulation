clear all; clc;

global global_info

% Creating Orders in a normal sequence 
%closing_time = 2*60;
%quarters = closing_time/5;
%order_sequence = zeros(1, quarters+1);

quarters = 40;
order_sequence = zeros(1,quarters+1);
for i = 0:quarters
    at = 5 * i + normrnd(0, 5);
    order_sequence(i+1) = at;
end
%order_sequence =[5,10,15,20];
global_info.tokens_firing_times = order_sequence;
global_info.STOP_AT = 300; % simulation Time Unit
global_info.DELTA_TIME = 1;
% This Flag is to check Resturnat is Open Or Close
global_info.RESTURANT_STATUS = true; 
% Flag To check that Resturnat is Accepting Order or not
global_info.RESTURANT_ORDER_STATUS = true; 
% Or Color on the basis of there distance
% program will generate random Order with different distance each time
global_info.ORDER_COLORS = {'RED_ORDER', 'GREEN_ORDER', 'BLUE_ORDER'};
global_info.RIDERS_TYPE = {'CYCLE','BIKE','CAR'};
global_info.ORDERS_LIST = []; % List of ordes in process in Resturant
global_info.ORDERS_PRO_TIME = 10; % Processing Time for Order

global_info.RIDERS_RES_TRAVEL_LIST = []; % List of Riders Traveling to Resturant

global_info.CYCLE.ORDER_DELIVERING_LIST = []; % List of Riders Traveling to Delivering Food 
global_info.BIKE.ORDER_DELIVERING_LIST = []; 
global_info.CAR.ORDER_DELIVERING_LIST = [];

global_info.CYCLE.TRAVEL_BACK_LIST = []; % List of Riders Traveling  Back to Center of the City
global_info.BIKE.TRAVEL_BACK_LIST = [];
global_info.CAR.TRAVEL_BACK_LIST = []; 

global_info.CYCLE.RES_TRAVEL_TIME = 10; % Required time for Cycle to Reach Resturant
global_info.CYCLE.ORDER_DELIVERING_TIME = 20; % Required time for Cycle to Reach Destination
global_info.CYCLE.TRAVEL_BACK_TIME = 10; % Required time for Cycle to Reach Center
global_info.CYCLE.ORDER_ACCEPT_STATUS = true; % Order Accepting or Not

global_info.BIKE.RES_TRAVEL_TIME = 5; % Required time for Bike to Reach Resturant
global_info.BIKE.ORDER_DELIVERING_TIME = 15; % Required time for Bike to Reach Destination
global_info.BIKE.TRAVEL_BACK_TIME = 15; % Required time for Bike to Reach City Center
global_info.BIKE.ORDER_ACCEPT_STATUS = true; % Order Accepting or Not

global_info.CAR.RES_TRAVEL_TIME = 5; % Required time for Car to Reach Resturant
global_info.CAR.ORDER_DELIVERING_TIME = 15; % Required time for Car to Reach Destination
global_info.CAR.TRAVEL_BACK_TIME = 15; % Required time for Car to Reach City Center
global_info.CAR.ORDER_ACCEPT_STATUS = true; % Order Accepting or Not

%Note: if this flag is true the simulation will run in a loop you might not
%be able to see the order is deliver because the rider will deliver order
%and return to the cith center Default is False 
global_info.SET_RIDERS_RETURN = true; % This flag is to allow rider to go back to city Center


Number_OF_Cycles = 20; % Avalible Riders on Cycles
Number_OF_Bikes = 10; % Avalible Riders on Bikes
Number_OF_Cars = 10; % Avalible Riders on Cars
Resturan_Capacity = 5;% Resturant Capacity to handle Order at Particular time

 pns = pnstruct({'OrderGen_pdf', 'foodora_hub_pdf', 'connector_pdf', ...
     'Resturant_pdf', 'Rider_Check_pdf', 'Food_Delivering_pdf'});

% NO initial tokens
dyn.m0 = {'pRes_Capacity', Resturan_Capacity, 'pCycle_GEN', Number_OF_Cycles, ...
    'pBike_GEN', Number_OF_Bikes, 'pCar_GEN', Number_OF_Cars, ...
     };

dyn.ft = {'tGEN', 1, 'tComplete_Order', 1, 'allothers',0.1};
pni = initialdynamics(pns, dyn);

sim = gpensim(pni); % No initial dynamics 
plotp(sim, {'pCycle_Reach_Des','pBike_Reach_Des', 'pCar_Reach_Des'});
% plotp(sim, {'pOrder_Wait','pOrder_Complete'});
prnfinalcolors(sim);  %%%% PRINT RESULTS %%%%%

