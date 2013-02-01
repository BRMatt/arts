with System;
with POSIX_Hardware_Interrupts;

package Ada.Interrupts is
   type Interrupt_Id is private;
   type Parameterless_Handler is access protected procedure;

   function Is_Reserved (Interrupt : Interrupt_Id)
     return Boolean;

   function Is_Attached (Interrupt : Interrupt_Id)
     return Boolean;

   function Current_Handler (Interrupt : Interrupt_Id)
     return Parameterless_Handler;

   procedure Attach_Handler
     (New_Handler : in Parameterless_Handler;
      Interrupt   : in Interrupt_Id);

   procedure Exchange_Handler
     (Old_Handler : out Parameterless_Handler;
      New_Handler : in Parameterless_Handler;
      Interrupt   : in Interrupt_Id);

   procedure Detach_Handler
     (Interrupt : in Interrupt_Id);

   function PP_Interrupt_Handler
     (Area : in System.Address;
      Intr : in POSIX_Hardware_Interrupts.Hardware_Interrupt)
     return POSIX_Hardware_Interrupts.Handler_Return_Code;

   function SP_Interrupt_Handler
     (Area : in System.Address;
      Intr : in POSIX_Hardware_Interrupts.Hardware_Interrupt)
     return POSIX_Hardware_Interrupts.Handler_Return_Code;

   function Reference (Interrupt : Interrupt_Id)
      return System.Address;
private
   pragma Inline (Is_Reserved);
   pragma Inline (Is_Attached);
   pragma Inline (Current_Handler);
   pragma Inline (Attach_Handler);
   pragma Inline (Detach_Handler);
   pragma Inline (Exchange_Handler);
   type Interrupt_Id is range 1 .. 7;
end Ada.Interrupts;

