function [] = COMMON_POST(transition)
global global_info 

disp(['Fired transition: ', transition.name]); % just fired trans

travel_random = randi([-2 2]); % adding Random time delay as traveling of rider is not always on exact time 
%travel_random = 0; % IF want the travel time to be exatly given time then uncomment this line  
if strcmp(transition.name, 'tStart_preparation')
    global_info.ORDERS_LIST(end+1) = global_info.ORDERS_PRO_TIME + travel_random;
elseif (strcmpi(transition.name, 'tCycle_Accept'))
    global_info.RIDERS_RES_TRAVEL_LIST(end+1) = global_info.CYCLE.RES_TRAVEL_TIME + travel_random;
elseif (strcmpi(transition.name, 'tBike_Accept'))
    global_info.RIDERS_RES_TRAVEL_LIST(end+1) = global_info.BIKE.RES_TRAVEL_TIME + travel_random;
elseif (strcmpi(transition.name, 'tCar_Accept'))
    global_info.RIDERS_RES_TRAVEL_LIST(end+1) = global_info.CAR.RES_TRAVEL_TIME + travel_random;

    % Adding Riders Traveling to Deliver Food
elseif (strcmpi(transition.name, 'tCycle_Rider'))
    global_info.CYCLE.ORDER_DELIVERING_LIST(end+1) = global_info.CYCLE.ORDER_DELIVERING_TIME + travel_random;

elseif (strcmpi(transition.name, 'tBike_Rider'))
    global_info.BIKE.ORDER_DELIVERING_LIST(end+1) = global_info.BIKE.ORDER_DELIVERING_TIME + travel_random;

elseif (strcmpi(transition.name, 'tCar_Rider'))
    global_info.CAR.ORDER_DELIVERING_LIST(end+1) = global_info.CAR.ORDER_DELIVERING_TIME + travel_random;
    
    % Adding Riders Traveling Back to City Center
elseif (strcmpi(transition.name, 'tCycle_Travel_Des'))
    global_info.CYCLE.TRAVEL_BACK_LIST(end+1) = global_info.CYCLE.TRAVEL_BACK_TIME + travel_random;

elseif (strcmpi(transition.name, 'tBike_Travel_Des'))
    global_info.BIKE.TRAVEL_BACK_LIST(end+1) = global_info.BIKE.TRAVEL_BACK_TIME + travel_random;

elseif (strcmpi(transition.name, 'tCar_Travel_Des'))
    global_info.CAR.TRAVEL_BACK_LIST(end+1) = global_info.CAR.TRAVEL_BACK_TIME + travel_random;
end