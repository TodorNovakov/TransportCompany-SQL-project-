--TRIGGERS

create trigger triggerNewOrder
on orders
after insert
as
print 'Dobavena e nova porychka!Tryabva da se transportira!';


create trigger TriggerDeliveredOrder
on OrderTransportDetails
after update
as
 begin
 declare @idOrder int =(select id_order from inserted)
 declare @deadline datetime=(select deadline from Orders where @idOrder=Orders.Id_order)
 declare @delivered datetime=(select deliverytime from inserted)
 if (@deadline<@delivered)
  print 'Porychkata e dostavena!SROKA ZA DOSTAVKA E PROSROCHEN!'
 else
  print 'Porychkata e dostavena navreme!Chudesna rabota!'
 end
