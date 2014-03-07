use mydbprojecttransport;
DBCC CHECKIDENT('Vehicle', RESEED, 1000);
DBCC CHECKIDENT('Driver',RESEED,0);
execute AddDriver 'Petrov','Ivan',56553;
execute AddDriver 'Stoimenov','Dimityr',0883654;
execute AddDriver 'Ivanov','Dragomir',852647;
execute AddDriver 'Todorov','Vasil',568947;
execute AddDriver 'Petkov','Stanislav',83645;
execute AddDriver 'Dimitrov','Petko',55884;
execute AddDriver 'Miroslavov','Danail',987423;
execute AddDriver 'Mishev','Marin',452013;
execute AddDriver 'Chanev','Vladimir',578365;
execute AddDriver 'Ivanov','Ivan',45457;

select * 
from driver;

execute AddTruck 'Mercedes','Actros','BH1243AC','4x2';
execute AddTruck 'Mercedes','Actros','BH1254AH','4x2';
execute AddTruck 'Mercedes','Actros','BH1413AE','4x2';
execute AddTruck 'Mercedes','Axor','BH9989BH','6x2';
execute AddTruck 'Renault','Magnum','C5412CH','6x2';
execute AddTruck 'Renault','Magnum','C7816CH','4x2';
execute AddTruck 'Renault','Magnum','A1213BH','4x2';
execute AddTruck 'Renault','Premium','A8736BH','4x2';
execute AddTruck 'Renault','Premium','BH8779AE','4x2';
execute AddTruck 'Renault','Premium','BH6547EA','4x2';
execute AddTruck 'Renault','Premium','C4323KH','4x2';
execute AddTruck 'DAF','XF105','BH2134AH','4x2';
execute AddTruck 'DAF','XF105','BH4234AH','4x2';
execute AddTruck 'DAF','XF105','C8204EH','4x2';
execute AddTruck 'Mercedes','Axor','A1237AH','4x2';
execute AddTruck 'Mercedes','Axor','A5324AH','4x2';
execute AddTruck 'Mercedes','Axor','BH8943AH','4x2';

execute AddTrailer 'Kogel','1FD','fridge','BH3216AC';
execute AddTrailer 'Kogel','1FD','fridge','BH6510CH';
execute AddTrailer 'Kogel','1FD','fridge','A4312AC';
execute AddTrailer 'Kogel','1FD','fridge','C1515AC';
execute AddTrailer 'Kogel','1FD','fridge','KH2134CH';
execute AddTrailer 'Schmitz','BB1','box','BH8990AC';
execute AddTrailer 'Schmitz','BB1','box','BH1010AC';
execute AddTrailer 'Schmitz','BB1','box','BH1340AC';
execute AddTrailer 'Schmitz','BB1','box','C1231CH';
execute AddTrailer 'Schmitz','BB1','box','C8909AC';
execute AddTrailer 'Nuova','F2007','tank','BH4232AC';
execute AddTrailer 'Nuova','F2007','tank','BH6567AC';
execute AddTrailer 'Nuova','F2007','tank','BH7489AC';

execute AddFirm 'MilkCompanyBulgaria','BG','Bourgas','Street1','32231',1212;
execute AddFirm 'FruitBourgas','BG','Bourgas','StreetNew','21312',1213;
execute AddFirm 'BourgasEgg','BG','Bourgas','M.Donkov','545454',1212;
execute AddFirm 'Nestle','BG','Sofia','Peshtera','12341',3232;
execute AddFirm 'MilkWay','BG','Sofia','DownStreet','MilkSof@abv.bg',3412;
execute AddFirm 'SunFruit','IT','Pescara','S.Lorenzo','SFF@gmail.com',1234;
execute AddFirm 'VegeIT','IT','Sienna','D.Michhi','321312',4465;
execute AddFirm 'IceS','S','Barcelona','LosAmigos','32432',42342;
execute AddFirm 'GreenCompany','S','Almeria','Bisscontes','GreenC@yahoo.com',123212;
execute AddFirm 'Shocoland','BEL','Antwerpen','Staggone','32432',124324;

select * 
from Firm;
select *
from Vehicle;
select *
from Orders; 

execute AddOrder 1,10,'06/30/2013';
execute LoanTruck 1,1001;
execute LoanTrailer 1,1020;
execute TransportOrder 1,1;
execute DeliveredOrder 1;

execute AddOrder 2,6,'06/06/2013';
execute LoanTruck 2,1002;
execute LoanTrailer 2,1021;
execute Transportorder 2,2;
execute DeliveredOrder 2;

execute AddOrder 3,5,'07/01/2013';
execute LoanTruck 3,1004;
execute LoanTrailer 3,1022;
execute TransportOrder 3,3;
execute DeliveredOrder 3;

execute AddOrder 4,10,'06/24/2013';
execute LoanTruck 4,1005;
execute LoanTrailer 4,1023;
execute TransportOrder 4,4;
execute DeliveredOrder 4;
select * 

execute AddOrder 1,4,'07/05/2013';
execute LoanTruck 5,1006;
execute LoanTrailer 5,1024;
execute TransportOrder 5,5;
execute DeliveredOrder 5;

execute AddOrder 4,5,'07/02/2013';
execute TransportOrder 1,6;

execute AddOrder 5,10,'07/25/2103';
execute TransportOrder 2,7;

execute AddOrder 10,1,'06/27/2013';
execute TransportOrder 3,8;

select * from DriverVehicle;

execute ReturnVehicle 4,1005;
execute ReturnVehicle 4,1023;

execute ReturnVehicle 5,1006;
execute ReturnVehicle 5,1024;

select driver.id_driver
from Driver
except
select id_driver
from DriverVehicle
where FinishTime is null;

select *
from dbo.FreeVehicles;

execute LoanTruck 10,1006;
execute LoanTruck 9,1007;
execute LoanTrailer 10,1031;
execute LoanTrailer 9,1030;
select * from dbo.BusyVehicles;
select * from dbo.DelayedOrdersDetails;
select * from dbo.OrdersInProgress;
select * from dbo.DriverCurrentLoan;
select * from dbo.DriversWaitingOrders;
select * from dbo.DriversTransportOrders;
select * from OrdersInProgressDetails;

select * from dbo.CompanyOrders(10);
select * from dbo.DisplayOrdersPeriod('05/05/2013',getdate());
select * from dbo.DriverHistoryVehicles(5);
select * from dbo.DriversOrdersDetails(1);


select dbo.CountBusyDrivers();
select dbo.CountBusyVehicles();
select dbo.CountDelayedOrders();
select dbo.CountFreeDrivers();
select dbo.CountOrdersAfterDate ('06/06/2013');
select dbo.CountOrdersFromDateToDate('05/21/2013',getdate());
select dbo.OrdersPerDriver(1);

select *
from vehicle
left join truck on vehicle.Id_vehicle=Truck.Id_vehicle
where class='Truck';

select * 
from Vehicle
left join Trailer on vehicle.Id_vehicle=trailer.Id_vehicle
where class='Trailer';

select *
from DriverVehicle;

select *
from Driver;

select * 
from Driver
left join driverVehicle on driver.id_driver=driverVehicle.Id_driver;

select * 
from Orders;

select * 
from OrderTransportDetails;

select * 
from Orders
left join OrderTransportDetails on orders.id_order=ordertransportdetails.id_order;

execute TransportOrder 10,9;

select *
from orderdetails;

select *
from Orders
left join OrderDetails on Orders.Id_order=OrderDetails.Id_order
left join OrderTransportDetails on OrderDetails.Id_order=OrderTransportDetails.id_order;

select * 
from firm;

execute AddOrder 5,8,'07/03/2013';
execute TransportOrder 9,10;