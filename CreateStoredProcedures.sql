use MyDBprojectTransport;
create procedure AddDriver
@LastName varchar(16),
@FirstName varchar(16),
@Contact int
as
insert into Driver(LastName,FirstName,Contact)
values (@LastName,@FirstName,@Contact);



create procedure AddTruck
@producer varchar(16),
@model varchar(8),
@regnum varchar(8),
@AxleConfiguration varchar(8)
as
begin try
  begin tran
  declare @id int
  insert into Vehicle(class,producer)
  values ('truck',@producer)
  set @id=scope_identity()
  insert into truck(id_vehicle,model,regnum,axelconfiguration)
  values (@id,@model,@regnum,@axleconfiguration)
  commit tran
end try
begin catch
  begin
  print 'Error!Axle configuration could be "4x2" or "6x2"!'
  rollback
  end
end catch;

create procedure AddTrailer
@producer varchar(16),
@model varchar(8),
@type varchar(8),
@regnum varchar(8)
as
begin try
 begin tran
  declare @id int
  insert into vehicle(class,producer)
  values ('trailer',@producer)
  set @id=SCOPE_IDENTITY()
  insert into trailer(id_vehicle,model,trailertype,regnum)
  values (@id,@model,@type,@regnum)
 commit tran
end try
begin catch
 begin
  print 'Error!The trailer type could be "box","fridge" or "tank"!'
  rollback
 end
end catch

create procedure LoanTruck
@id_driver int,
@id_vehicle int
as
if not exists(select id_driver from dbo.DriverCurrentLoan where id_driver=@id_driver and class='truck')
   begin
     if not exists (select id_vehicle from dbo.DriverCurrentLoan where id_vehicle=@id_vehicle)
	   begin
	   insert into DriverVehicle(Id_driver,Id_vehicle)
	   values (@id_driver,@id_vehicle)
	   end
	 else
	   print 'Vehicle is busy!'
	end
else
  print 'Driver is busy';

create procedure LoanTrailer
@id_driver int,
@id_vehicle int
as
if not exists (select id_Driver from dbo.drivercurrentloan where id_driver=@id_driver and class='trailer')
   begin
    if not exists (select id_vehicle from dbo.DriverCurrentLoan where id_vehicle=@id_vehicle)
	 begin
	 insert into DriverVehicle(Id_driver,Id_vehicle)
	 values (@id_driver,@id_vehicle)
	 end
	else
	 print 'Vehicle is busy!'
    end
else
 print 'Driver is busy!';


create procedure ReturnVehicle
@id_driver int,
@id_vehicle int
as
update DriverVehicle
set FinishTime=GETDATE()
where Id_driver=@id_driver and id_vehicle=@id_vehicle;

create procedure AddFirm
@name varchar(32),
@country varchar(8),
@city varchar(8),
@street varchar(8),
@contact varchar(16),
@postcode int
as
insert into Firm (FirmName,Country,City,Street,PostCode,Contact)
values (@name,@country,@city,@street,@postcode,@contact);

create procedure AddOrder
@id_sender int,
@id_receiver int,
@deadline datetime
as
declare @id_order int
insert into Orders(Deadline)
values (@deadline)
set @id_order=SCOPE_IDENTITY()
insert into OrderDetails (Id_order,Id_FirmSender,Id_FirmReceiver)
values (@id_order,@id_sender,@id_receiver);

create procedure TransportOrder
@id_driver int,
@id_order int
as
if exists (select id_driver from dbo.DriverCurrentLoan where id_driver=@id_driver)
 begin
 insert into OrderTransportDetails (Id_order,Id_driver)
 values (@id_order,@id_driver)
 end
else
 print 'Driver is not working! :D';

create procedure DeliveredOrder
@id_order int
as
update OrderTransportDetails
set DeliveryTime=GETDATE()
where Id_order=@id_order;