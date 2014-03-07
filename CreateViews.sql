use MyDBprojectTransport;
create view BusyVehicles
as
select id_vehicle
from DriverVehicle
where FinishTime is null;

 create view BusyTrucks
 as
 select vehicle.Id_vehicle
 from DriverVehicle 
 join Vehicle on DriverVehicle.Id_vehicle=Vehicle.Id_vehicle
 where class='truck' and finishtime is null;

 create view BusyTrailers
 as
 select Vehicle.Id_vehicle
 from DriverVehicle
 join vehicle on drivervehicle.id_vehicle=vehicle.Id_vehicle
 where class='trailer' and FinishTime is null;

create view DriverCurrentLoan
as
select id_loan,id_driver,vehicle.id_vehicle,class,producer
from DriverVehicle
join Vehicle on DriverVehicle.Id_vehicle=Vehicle.Id_vehicle
where finishtime is null;

create view FreeVehicles
as
select id_vehicle
from Vehicle
except
select id_vehicle
from dbo.BusyVehicles;

create view DriversTransportOrders(IdDriver,LastName,FirstName)
as
select Driver.Id_driver,LastName,FirstName
from OrderTransportDetails
join Driver on OrderTransportDetails.Id_driver=driver.id_driver
where DeliveryTime is null;

create view DriversWaitingOrders(IdDriver,LastName,FirstName)
as
select driver.Id_driver,LastName,FirstName
from Driver
except
select dbo.DriversTransportOrders.IdDriver,LastName,FirstName
from dbo.DriversTransportOrders;

create view OrdersInProgress(order_id)
as
select id_order
from OrderTransportDetails
where DeliveryTime is null;

create view OrdersInProgressDetails(order_id,deadline,Sender,Receiver,Driver)
as
select OrderTransportDetails.Id_order,deadline,OrderDetails.Id_FirmSender,OrderDetails.Id_FirmReceiver,id_driver
from OrderTransportDetails
join Orders on OrderTransportDetails.Id_order=Orders.Id_order
join OrderDetails on Orders.Id_order=OrderDetails.Id_order
where DeliveryTime is null;

create view DelayedOrders(Id_order)
as
select OrderTransportDetails.Id_order
from OrderTransportDetails
join Orders on OrderTransportDetails.Id_order=Orders.Id_order
where DeliveryTime>Deadline;

create view DelayedOrdersDetails
as
select Driver.Id_driver,LastName,FirstName,Orders.Id_order,DeliveryTime,Deadline
from Driver
join OrderTransportDetails on Driver.Id_driver=OrderTransportDetails.Id_driver
join Orders on OrderTransportDetails.Id_order=Orders.Id_order
where DeliveryTime>Deadline;