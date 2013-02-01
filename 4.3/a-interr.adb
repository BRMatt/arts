with Ada.Interrupts.Names; use Ada.Interrupts.Names;
--  with POSIX;
with POSIX_Hardware_Interrupts;
with Basic_Integer_Types; use Basic_Integer_Types;
with IO_Interface; use IO_Interface;
--  with Basic_Console_IO;



package body Ada.Interrupts is
   type Attached_Handlers_t is array (Interrupt_Id) of Parameterless_Handler;
   Attached_Handlers : Attached_Handlers_t := (others => null);

   function Is_Reserved (Interrupt : Interrupt_Id) return Boolean is
   begin
      if Interrupt = CLK then return True;
      else return False; end if;
   end Is_Reserved;

   function Is_Attached (Interrupt : Interrupt_Id)
      return Boolean is
   begin
      if Interrupt = CLK then raise Program_Error; end if;
      if Attached_Handlers (Interrupt) /= null then return True;
      else return False; end if;
   end Is_Attached;

   function Current_Handler (Interrupt : Interrupt_Id)
      return Parameterless_Handler is
   begin
      if Interrupt = CLK then raise Program_Error; end if;
      return Attached_Handlers (Interrupt);
   end Current_Handler;

   procedure Attach_Handler
      (New_Handler : in Parameterless_Handler;
       Interrupt   : in Interrupt_Id) is
   begin
      if Interrupt = CLK then raise Program_Error; end if;
      Attached_Handlers (Interrupt) := New_Handler;
   --  Install interrupt handler and atach task with interrupt
      if Interrupt = Parallel_1 then POSIX_Hardware_Interrupts.Associate
 (POSIX_Hardware_Interrupts.PARALLEL1_INTERRUPT,
 PP_Interrupt_Handler'Unrestricted_Access, System.Null_Address, 0);
      elsif Interrupt = Serial_1 then POSIX_Hardware_Interrupts.Associate
      (POSIX_Hardware_Interrupts.SERIAL1_INTERRUPT,
      SP_Interrupt_Handler'Unrestricted_Access, System.Null_Address, 0);
      end if;
   end Attach_Handler;

   procedure Exchange_Handler
      (Old_Handler : out Parameterless_Handler;
       New_Handler : in Parameterless_Handler;
       Interrupt   : in Interrupt_Id) is
   begin
      if Interrupt = CLK then raise Program_Error; end if;
      Old_Handler := Attached_Handlers (Interrupt);
      Attached_Handlers (Interrupt) := New_Handler;
      --  Add POSIX Stuff Here
   --  Install interrupt handler and atach task with interrupt
      if Interrupt = Parallel_1 then POSIX_Hardware_Interrupts.Associate
 (POSIX_Hardware_Interrupts.PARALLEL1_INTERRUPT,
 PP_Interrupt_Handler'Unrestricted_Access, System.Null_Address, 0);
      elsif Interrupt = Serial_1 then POSIX_Hardware_Interrupts.Associate
      (POSIX_Hardware_Interrupts.SERIAL1_INTERRUPT,
      SP_Interrupt_Handler'Unrestricted_Access, System.Null_Address, 0);
      end if;
   end Exchange_Handler;

   procedure Detach_Handler
      (Interrupt : in Interrupt_Id) is
   begin
      if Interrupt = CLK then raise Program_Error; end if;
      Attached_Handlers (Interrupt) := null;
   end Detach_Handler;

   function PP_Interrupt_Handler
     (Area : in System.Address;
      Intr : in POSIX_Hardware_Interrupts.Hardware_Interrupt)
     return POSIX_Hardware_Interrupts.Handler_Return_Code is
   begin
      --  Never use Text_IO inside an interrupt handler
      --  Basic_Console_IO.Put ("got metal (PPIH)");
      --  Basic_Console_IO.New_Line;
      if Is_Attached (Parallel_1) then Attached_Handlers (Parallel_1).all;
      end if;
      return POSIX_Hardware_Interrupts.POSIX_INTR_HANDLED_NOTIFY;
   end PP_Interrupt_Handler;

   -----------------------------
   -- Serial Port Registers --
   -----------------------------
   SP_BASE_REG    : constant IO_Port := 16#3F8#; --
   SP_MSR_REG     : constant IO_Port := 6; -- Modem status register

   SP_IENABLE : constant Unsigned_8 := 16#08#;  -- receive data available

   function SP_Interrupt_Handler (Area : in System.Address;
    Intr : in POSIX_Hardware_Interrupts.Hardware_Interrupt)
 return POSIX_Hardware_Interrupts.Handler_Return_Code is
   begin
      --  Never use Text_IO inside an interrupt handler
      --  Basic_Console_IO.Put ("got metal (SPIH)");
      --  Basic_Console_IO.New_Line;
      if Is_Attached (Serial_1) then Attached_Handlers (Serial_1).all;
      end if;
      return POSIX_Hardware_Interrupts.POSIX_INTR_HANDLED_NOTIFY;
   end SP_Interrupt_Handler;

   function Reference (Interrupt : Interrupt_Id)
      return System.Address is
   begin
      raise Program_Error;
      return System.Null_Address;
   end Reference;
end Ada.Interrupts;

