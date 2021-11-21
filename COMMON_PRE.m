
function [fire, transition] = COMMON_PRE(transition)

global global_info 

%  Condition To check is Resturant is Open 
if (strcmpi(transition.name, 'tRes_close'))
    if global_info.RESTURANT_STATUS == false
        fire = 1;
    else
        fire = 0;
    end
elseif (strcmpi(transition.name, 'tRes_open'))
        if global_info.RESTURANT_STATUS == true
        fire = 1;
    else
        fire = 0;
        end
% Condition For Generator
elseif (strcmpi(transition.name, 'tGEN'))
    if isempty(global_info.tokens_firing_times)
        fire = 0;
        return
    end
    
    time_to_generate_token = global_info.tokens_firing_times(1);
    ctime = current_time();
    if lt(ctime, time_to_generate_token)  % it is not the time to fire
        fire = 0; return
    end

    if ge(length(global_info.tokens_firing_times),2)
        global_info.tokens_firing_times = global_info.tokens_firing_times(2:end);
    else
        global_info.tokens_firing_times = [];
    end
    ran_num = randi([1 3]);
    transition.new_color = global_info.ORDER_COLORS{ran_num};
    fire = 1;


elseif (strcmpi(transition.name, 'tAccept'))
    if global_info.RESTURANT_ORDER_STATUS == true
        fire = 1;
    else
        fire = 0;
    end

elseif (strcmpi(transition.name, 'tReject'))
    if global_info.RESTURANT_ORDER_STATUS == false
        fire = 1;
    else
        fire = 0;
    end

elseif (strcmpi(transition.name, 'tStart_preparation'))
    fire = 1;
elseif (strcmpi(transition.name, 'tComplete_Order'))
    if isempty(global_info.ORDERS_LIST)
        fire = 0;
    else
     global_info.ORDERS_LIST = global_info.ORDERS_LIST - 1;
     indexs = find(global_info.ORDERS_LIST <= 0);
     if isempty(indexs)
         fire = 0;
     else
         global_info.ORDERS_LIST(indexs(1))=[];
         fire = 1;
     end
    end
elseif (strcmpi(transition.name, 'tRes_Capacity_Reset'))
    transition.override = 1;
    fire = 1;
    
    % ********** Transitions From Rider Check Module ***************
elseif (strcmpi(transition.name, 'tOrder_for_Cycle'))
    order_color = global_info.ORDER_COLORS{1};
    tokID1 = tokenEXColor('pRi_Order_Recive', 1, {order_color});
    transition.selected_tokens = tokID1;
    fire = tokID1;

elseif (strcmpi(transition.name, 'tOrder_for_Bike'))
    order_color = global_info.ORDER_COLORS{2};
    tokID1 = tokenEXColor('pRi_Order_Recive', 1, {order_color});
    transition.selected_tokens = tokID1;
    fire = tokID1;

elseif (strcmpi(transition.name, 'tOrder_for_Car'))
    order_color = global_info.ORDER_COLORS{3};
    tokID1 = tokenEXColor('pRi_Order_Recive', 1, {order_color});
    transition.selected_tokens = tokID1;
    fire = tokID1;
elseif (strcmpi(transition.name, 'tCycle_Accept'))
    if global_info.CYCLE.ORDER_ACCEPT_STATUS == true
        transition.new_color = global_info.RIDERS_TYPE{1};
        transition.override = 1;
        fire = 1;
    else
        fire = 0;
    end
elseif (strcmpi(transition.name, 'tCycle_Reject'))
    if global_info.CYCLE.ORDER_ACCEPT_STATUS == false
        fire = 1;
    else
        fire = 0;
    end
elseif (strcmpi(transition.name, 'tBike_Accept'))
    if global_info.BIKE.ORDER_ACCEPT_STATUS == true
        transition.new_color = global_info.RIDERS_TYPE{2};
        transition.override = 1;
        fire = 1;
    else
        fire = 0;
    end

elseif (strcmpi(transition.name, 'tBike_Reject'))
    if global_info.BIKE.ORDER_ACCEPT_STATUS == false
        order_color = global_info.ORDER_COLORS{2};
        tokID1 = tokenEXColor('pRi_Order_Recive', 1, {order_color});
        transition.selected_tokens = tokID1;
        transition.new_color = global_info.ORDER_COLORS{1};
        transition.override = 1;
        fire = tokID1;
    else
        fire = 0;
    end

elseif (strcmpi(transition.name, 'tCar_Accept'))
    if global_info.CAR.ORDER_ACCEPT_STATUS == true
        transition.new_color = global_info.RIDERS_TYPE{3};
        transition.override = 1;
        fire = 1;
    else
        fire = 0;
    end 

elseif (strcmpi(transition.name, 'tCar_Reject'))
    if global_info.CAR.ORDER_ACCEPT_STATUS == false
        order_color = global_info.ORDER_COLORS{3};
        tokID1 = tokenEXColor('pRi_Order_Recive', 1, {order_color});
        transition.selected_tokens = tokID1;
        transition.new_color = global_info.ORDER_COLORS{2};
        transition.override = 1;
        fire = tokID1;
    else
        fire = 0;
    end

elseif (strcmpi(transition.name, 'tRider_Res_Travel'))
    if isempty(global_info.RIDERS_RES_TRAVEL_LIST)
        fire = 0;
    else
     global_info.RIDERS_RES_TRAVEL_LIST = global_info.RIDERS_RES_TRAVEL_LIST - 1;
     r_indexs = find(global_info.RIDERS_RES_TRAVEL_LIST <= 0);
     if isempty(r_indexs)
         fire = 0;
     else
         global_info.RIDERS_RES_TRAVEL_LIST(r_indexs(1))=[];
         fire = 1;
     end
    end
elseif (strcmpi(transition.name, 'tCycle_GEN'))
    transition.new_color = global_info.RIDERS_TYPE{1};
    fire = 1;
elseif (strcmpi(transition.name, 'tBike_GEN'))
    transition.new_color = global_info.RIDERS_TYPE{2};
    fire = 1;
elseif (strcmpi(transition.name, 'tCar_GEN'))
    transition.new_color = global_info.RIDERS_TYPE{3};
    fire = 1;
    
    % ********** Transitions From Food Delivering Module *****************
elseif (strcmpi(transition.name, 'tOrder_Fr_Cycle'))
    order_color = global_info.ORDER_COLORS{1};
    tokID1 = tokenEXColor('pOrders_From_Res', 1, {order_color});
    transition.selected_tokens = tokID1;
    fire = tokID1;
elseif (strcmpi(transition.name, 'tOrder_Fr_Bike'))
    order_color = global_info.ORDER_COLORS{2};
    tokID1 = tokenEXColor('pOrders_From_Res', 1, {order_color});
    transition.selected_tokens = tokID1;
    fire = tokID1;
elseif (strcmpi(transition.name, 'tOrder_Fr_Car'))
    order_color = global_info.ORDER_COLORS{3};
    tokID1 = tokenEXColor('pOrders_From_Res', 1, {order_color});
    transition.selected_tokens = tokID1;
    fire = tokID1;
elseif (strcmpi(transition.name, 'tCycle_Rider'))
    order_color = global_info.ORDER_COLORS{1};
    rider_color = global_info.RIDERS_TYPE{1};
    tokID1Cycle = tokenEXColor('pOrder_Fr_Cycle', 1, {order_color});
    tokID2Cycle = tokenEXColor('pRiders_At_Res', 1, {rider_color});
    if (isempty(tokID1Cycle))
        fire = 0;
    elseif (isempty(tokID2Cycle))
        fire =0;
    else
        
         selected_tokens_Cycle = [tokID1Cycle tokID2Cycle];
         transition.selected_tokens = selected_tokens_Cycle;
         fire = selected_tokens_Cycle;
    end
elseif (strcmpi(transition.name, 'tBike_Rider'))
    order_color_Bike = global_info.ORDER_COLORS{2};
    rider_color_Bike = global_info.RIDERS_TYPE{2};
    tokID1Bike = tokenEXColor('pOrder_Fr_Bike', 1, {order_color_Bike});
    tokID2Bike = tokenEXColor('pRiders_At_Res', 1, {rider_color_Bike});
    if (isempty(tokID1Bike))
        fire = 0;
    elseif (isempty(tokID2Bike))
        fire =0;
    else
         selected_tokens_Bike = [tokID1Bike tokID2Bike];
         transition.selected_tokens = selected_tokens_Bike;
         fire = selected_tokens_Bike;
    end

elseif (strcmpi(transition.name, 'tCar_Rider'))
    order_color_car = global_info.ORDER_COLORS{3};
    rider_color_car = global_info.RIDERS_TYPE{3};
    tokID1Car = tokenEXColor('pOrder_Fr_Car', 1, {order_color_car});
    tokID2Car = tokenEXColor('pRiders_At_Res', 1, {rider_color_car});
    if (isempty(tokID1Car))
        fire = 0;
    elseif (isempty(tokID2Car))
        fire =0;
    else
         selected_tokens_Car = [tokID1Car tokID2Car];
         transition.selected_tokens = selected_tokens_Car;
         fire = selected_tokens_Car;
    end

elseif (strcmpi(transition.name, 'tCycle_Travel_Des'))
     if isempty(global_info.CYCLE.ORDER_DELIVERING_LIST)
        fire = 0;
    else
     global_info.CYCLE.ORDER_DELIVERING_LIST = global_info.CYCLE.ORDER_DELIVERING_LIST - 1;
     r_indexs = find(global_info.CYCLE.ORDER_DELIVERING_LIST <= 0);
     if isempty(r_indexs)
         fire = 0;
     else
         global_info.CYCLE.ORDER_DELIVERING_LIST(r_indexs(1))=[];
         fire = 1;
     end
    end
elseif (strcmpi(transition.name, 'tBike_Travel_Des'))
    if isempty(global_info.BIKE.ORDER_DELIVERING_LIST)
        fire = 0;
    else
     global_info.BIKE.ORDER_DELIVERING_LIST = global_info.BIKE.ORDER_DELIVERING_LIST - 1;
     r_indexs = find(global_info.BIKE.ORDER_DELIVERING_LIST <= 0);
     if isempty(r_indexs)
         fire = 0;
     else
         global_info.BIKE.ORDER_DELIVERING_LIST(r_indexs(1))=[];
         fire = 1;
     end
    end
elseif (strcmpi(transition.name, 'tCar_Travel_Des'))
   if isempty(global_info.CAR.ORDER_DELIVERING_LIST)
        fire = 0;
    else
     global_info.CAR.ORDER_DELIVERING_LIST = global_info.CAR.ORDER_DELIVERING_LIST - 1;
     r_indexs = find(global_info.CAR.ORDER_DELIVERING_LIST <= 0);
     if isempty(r_indexs)
         fire = 0;
     else
         global_info.CAR.ORDER_DELIVERING_LIST(r_indexs(1))=[];
         fire = 1;
     end
    end
elseif (strcmpi(transition.name, 'tCycle_Travel_Back'))
   if isempty(global_info.CYCLE.TRAVEL_BACK_LIST)
        fire = 0;
    else
     global_info.CYCLE.TRAVEL_BACK_LIST = global_info.CYCLE.TRAVEL_BACK_LIST - 1;
     r_indexs = find(global_info.CYCLE.TRAVEL_BACK_LIST <= 0);
     if isempty(r_indexs)
         fire = 0;
     else
         global_info.CYCLE.TRAVEL_BACK_LIST(r_indexs(1))=[];
         fire = 1;
     end
    end
elseif (strcmpi(transition.name, 'tBike_Travel_Back'))
   if isempty(global_info.BIKE.TRAVEL_BACK_LIST)
        fire = 0;
    else
     global_info.BIKE.TRAVEL_BACK_LIST = global_info.BIKE.TRAVEL_BACK_LIST - 1;
     r_indexs = find(global_info.BIKE.TRAVEL_BACK_LIST <= 0);
     if isempty(r_indexs)
         fire = 0;
     else
         global_info.BIKE.TRAVEL_BACK_LIST(r_indexs(1))=[];
         fire = 1;
     end
    end
elseif (strcmpi(transition.name, 'tCar_Travel_Back'))
   if isempty(global_info.CAR.TRAVEL_BACK_LIST)
        fire = 0;
    else
     global_info.CAR.TRAVEL_BACK_LIST = global_info.CAR.TRAVEL_BACK_LIST - 1;
     r_indexs = find(global_info.CAR.TRAVEL_BACK_LIST <= 0);
     if isempty(r_indexs)
         fire = 0;
     else
         global_info.CAR.TRAVEL_BACK_LIST(r_indexs(1))=[];
         fire = 1;
     end
    end

    % ********** Transitions From Connector Module ***********************
elseif(strcmpi(transition.name, 'tDC1'))
    fire = 1;
elseif(strcmpi(transition.name, 'tDC2'))
    fire = 1;
elseif(strcmpi(transition.name, 'tDC3'))
    fire = 1;
elseif(strcmpi(transition.name, 'tDC4'))
    fire = 1;
elseif(strcmpi(transition.name, 'tDC5'))
    fire = 1;
elseif(strcmpi(transition.name, 'tDC_Cycle'))
    if global_info.SET_RIDERS_RETURN == true
        transition.new_color = global_info.RIDERS_TYPE{1};
        transition.override = 1;
        fire = 1;
    else
        fire = 0;
    end 
elseif(strcmpi(transition.name, 'tDC_Bike'))
    if global_info.SET_RIDERS_RETURN == true
        transition.new_color = global_info.RIDERS_TYPE{2};
        transition.override = 1;
        fire = 1;
    else
        fire = 0;
    end
elseif(strcmpi(transition.name, 'tDC_Car'))
    if global_info.SET_RIDERS_RETURN == true
        transition.new_color = global_info.RIDERS_TYPE{3};
        transition.override = 1;
        fire = 1;
    else
        fire = 0;
    end
else
    error([transition.name, ' is not in transitions...']);

end



    
    
