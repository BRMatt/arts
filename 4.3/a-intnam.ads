package Ada.Interrupts.Names is

   Parallel_1 : constant Interrupt_Id;
   Serial_1   : constant Interrupt_Id;
   CLK      : constant Interrupt_Id;
private
   Parallel_1 : constant Interrupt_Id := 7;
   Serial_1   : constant Interrupt_Id := 4;
   CLK      : constant Interrupt_Id := 3;
end Ada.Interrupts.Names;
