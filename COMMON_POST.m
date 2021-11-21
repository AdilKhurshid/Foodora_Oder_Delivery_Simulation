function [] = COMMON_POST(transition)
global global_info 

disp(['Fired transition: ', transition.name]); % just fired trans

% at the end of every sequence, printout the state
if strcmp(transition.name, 'tStart_preparation')
    global_info.ORDERS_LIST(end+1) = global_info.ORDERS_PRO_TIME;
elseif (strcmpi(transition.name, 'tCycle_Accept'))
    global_info.RIDERS_RES_TRAVEL_LIST(end+1) = global_info.CYCLE.RES_TRAVEL_TIME;
elseif (strcmpi(transition.name, 'tBike_Accept'))
    global_info.RIDERS_RES_TRAVEL_LIST(end+1) = global_info.BIKE.RES_TRAVEL_TIME;
elseif (strcmpi(transition.name, 'tCar_Accept'))
    global_info.RIDERS_RES_TRAVEL_LIST(end+1) = global_info.CAR.RES_TRAVEL_TIME;

    % Adding Riders Traveling to Deliver Food
elseif (strcmpi(transition.name, 'tCycle_Rider'))
    global_info.CYCLE.ORDER_DELIVERING_LIST(end+1) = global_info.CYCLE.ORDER_DELIVERING_TIME;

elseif (strcmpi(transition.name, 'tBike_Rider'))
    global_info.BIKE.ORDER_DELIVERING_LIST(end+1) = global_info.BIKE.ORDER_DELIVERING_TIME;

elseif (strcmpi(transition.name, 'tCar_Rider'))
    global_info.CAR.ORDER_DELIVERING_LIST(end+1) = global_info.CAR.ORDER_DELIVERING_TIME;
    
    % Adding Riders Traveling Back to City Center
elseif (strcmpi(transition.name, 'tCycle_Travel_Des'))
    global_info.CYCLE.TRAVEL_BACK_LIST(end+1) = global_info.CYCLE.TRAVEL_BACK_TIME;

elseif (strcmpi(transition.name, 'tBike_Travel_Des'))
    global_info.BIKE.TRAVEL_BACK_LIST(end+1) = global_info.BIKE.TRAVEL_BACK_TIME;

elseif (strcmpi(transition.name, 'tCar_Travel_Des'))
    global_info.CAR.TRAVEL_BACK_LIST(end+1) = global_info.CAR.TRAVEL_BACK_TIME;
end