
--scalar functions
create function dbo.CountOrdersAfterDate(@date datetime)
returns int
begin
declare @res int=(select count(*)
              from Orders
			  where CreateDate>=@date)
return @res
end

create function CountFreeVehicles()
returns int
begin
declare @res int=(select count(*)
                  from dbo.FreeVehicles)
return @res
end

create function CountBusyVehicles()
returns int
begin
declare @res int=(select count(*)
                  from dbo.BusyVehicles)
return @res
end

create function CountBusyDrivers()
returns int
begin
declare @res int=(select count(*)
                  from dbo.DriversTransportOrders)
return @res
end


create function CountFreeDrivers()
returns int
begin
declare @res int=(select count(*)
                  from dbo.DriversWaitingOrders)
return @res
end; 
select * from dbo.DriversTransportOrders;
select * from dbo.DriversWaitingOrders;
create function CountOrdersFromDateToDate(@start datetime,@finish datetime)
returns int
begin
declare @res int=(select count(*) as Orders
                  from Orders
				  where CreateDate>= @start and CreateDate<=@finish)
return @res
end;

create function CountDelayedOrders()
returns int
begin
declare @res int=(select count(*)
                  from dbo.DelayedOrders)
return @res
end;


create function OrdersPerDriver(@id_driver int)
returns int
begin
declare @res int=(select count(*)
                  from Driver
				  join OrderTransportDetails on Driver.Id_driver=OrderTransportDetails.Id_driver
				  where Driver.Id_driver=@id_driver)
return @res
end;

--inline table-valued functions

create function DisplayOrdersPeriod(@startdate datetime,@lastdate datetime)
returns table
return (select orders.id_order as IdOrder,CreateDate,id_firmsender as IdSender,
               firmname as CompanySender,id_firmreceiver as IdReceiver,
		       (select firmname from firm where id_firmreceiver=id_firm) as CompanyReceiver
	    from Orders
		join OrderDetails on Orders.Id_order=OrderDetails.Id_order
		join Firm on OrderDetails.Id_FirmSender=Firm.Id_firm)


create function DriverHistoryVehicles(@id_driver int)
returns table
return (select Driver.Id_driver,LastName,FirstName,Vehicle.Id_vehicle,class,producer,StartTime,FinishTime
        from Driver
		join DriverVehicle on Driver.Id_driver=DriverVehicle.Id_driver
		join Vehicle on DriverVehicle.id_vehicle=Vehicle.Id_vehicle
		where Driver.Id_driver=@id_driver);

create function CompanyOrders(@id_company int)
returns table
return (select id_firm as IdCompany,firmname as CompanyName,Id_order as IdOrder,
               Id_FirmReceiver as IdReceiver,(select firmname from firm where Id_FirmReceiver=Id_firm)
			   as CompanyReceiver
        from firm
		join orderdetails on firm.id_firm=orderdetails.Id_FirmSender
		where Id_firm=@id_company)



--Multi-Statement Table-Valued Functions

create function DriversOrdersDetails(@id_driver int)
returns @ResultTable table (id_driver int not null,LastName varchar(16) not null,
                            FirstName varchar(16) not null,OrdersNumber int,
							DelayedOrders int)
begin
   insert into @ResultTable
   select driver.Id_driver,Driver.LastName,Driver.FirstName,count(OrderTransportDetails.Id_order) as OrdersNumber,
          count(dbo.DelayedOrdersDetails.id_order)      
   from Driver
   join OrderTransportDetails on Driver.Id_driver=OrderTransportDetails.Id_driver
   left join dbo.DelayedOrdersDetails on OrderTransportDetails.Id_order=dbo.DelayedOrdersDetails.Id_order
   where  Driver.Id_driver=@id_driver
   group by Driver.Id_driver,Driver.LastName,Driver.FirstName
   return
end