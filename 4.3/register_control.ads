package Register_Control is

    type Hopper_Command is (Unload, Load);
    type Sorter_Command is (Open, Closed);


    procedure Initialize_Interfaces;
    procedure Write_Hopper_Command_Bits(Command : Hopper_Command);
    procedure Write_Sorter_Command_Bits(First : Sorter_Command;
                                Second :  Sorter_Command);
    function SP_Check_Interrupt return Boolean;

   procedure Wait_For_Software_Control;
   -- blocks the caller until the software has control
   -- over the chute

private
    for Hopper_Command use (Unload => 1, Load => 2);
    for Sorter_Command use (Open => 0, Closed => 1);
end Register_Control;
