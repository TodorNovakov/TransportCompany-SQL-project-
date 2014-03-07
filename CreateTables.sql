create database MyDBprojectTransport;
use MyDBprojectTransport;

create table Driver
(
    Id_driver int not null identity(1,1),
	LastName varchar(16) not null,
	FirstName varchar(16) not null,
	Contact int not null,
	constraint PK_Driver primary key (Id_driver)
)

create table Vehicle
(
    Id_vehicle int not null identity(1000,1),
	Class varchar(8) not null check(Class in ('truck','trailer')),
	Producer varchar(16) not null,
	constraint PK_Vehicle primary key (Id_vehicle)
)
create table Truck
(
    Id_vehicle int not null,
	RegNum varchar(8) not null unique,
	Model varchar(8) not null,
	AxelConfiguration varchar(8) not null check(AxelConfiguration in ('4x2','6x2')),
	constraint PK_Truck primary key (Id_vehicle),
	constraint FK_Vehicle_Truck foreign key (Id_vehicle) references Vehicle (Id_vehicle) on delete cascade
	                                                                                     on update cascade,
)
create table Trailer
(
   Id_vehicle int not null,
   RegNum varchar(8) not null unique,
   Model varchar(8) not null,
   TrailerType varchar(8) not null check(TrailerType in ('fridge','box','tank')),
   constraint PK_Trailer primary key (Id_Vehicle),
   constraint FK_Vehicle_Trailer foreign key (Id_vehicle) references Vehicle(Id_vehicle) on delete cascade 
                                                                                         on update cascade,
)

create table DriverVehicle
(
   Id_loan int not null identity (1,1),
   Id_driver int not null,
   Id_vehicle int not null,
   StartTime datetime default getdate(),
   FinishTime datetime default null,
   constraint PK_DriverVehicle primary key (Id_loan),
   constraint FK_DriverVehicle_Vehicle foreign key (Id_vehicle) references Vehicle(Id_vehicle) on delete no action
                                                                                               on update no action,
   constraint FK_DriverVehicle_Driver foreign key (Id_driver) references Driver(Id_driver) on delete no action
                                                                                           on update no action,
)						


create table Orders
(    
     Id_order int not null identity(1,1),
	 CreateDate datetime not null default getdate(),
	 Deadline datetime,
	 constraint PK_TransportOrder primary key (Id_order)
)

create table Firm
(
   Id_firm int not null identity(1,1),
   FirmName varchar(32) not null,
   Country varchar(8) not null,
   City varchar(8) not null,
   Street varchar(8) not null,
   PostCode int not null,
   Contact varchar(16) not null,
   constraint PK_Firm primary key (Id_firm)
)

create table OrderDetails
(
  Id_order int not null,
  Id_FirmSender int not null,
  Id_FirmReceiver int not null,
  constraint PK_OrderDetails primary key (Id_order),
  constraint FK_OrderDetails_Orders foreign key (Id_order) references Orders(Id_order) on delete cascade
                                                                                       on update cascade,
  constraint FK_OrderDetails_Firm1 foreign key (Id_FirmSender) references Firm(id_firm),
  constraint FK_OrderDetails_Firm2 foreign key (Id_FirmReceiver) references Firm(id_firm)
)

create table OrderTransportDetails
(
   Id_order int not null,
   Id_driver int not null,
   SendTime datetime default getdate(),
   DeliveryTime datetime default null,
   constraint PK_OrderTransportDetails primary key (Id_order),
   constraint FK_OrderTransportDetails_Orders foreign key (Id_order) references Orders(Id_order) on update cascade
                                                                                                 on delete cascade,
   constraint FK_OrderTransportDetails_Driver foreign key (Id_driver) references Driver(Id_driver) on update cascade
)

																   	                                                                                             