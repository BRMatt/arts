with MaRTE_OS;
with Chute; use Chute;
with Text_IO;
with Ada.Calendar; use Ada.Calendar;

procedure Main is
  ReleasedBall : Chute.Ball_Detected;
  task type releaseball;
  task body releaseball is
  begin
    Endless_loop:
    loop
      Chute.Hopper_load;
      delay 0.8;
      Chute.Hopper_Unload;
      delay 3.8;
    end loop Endless_loop;
  end releaseball;
  task type DetectBall;
  task body DetectBall is
    ReleasedBall : Ball_Detected;
    ReleasedAt   : Time;
  begin
    Endless_loop:
    loop
      Get_Ball(ReleasedBall, ReleasedAt);

      case ReleasedBall is
        when Metal =>
          Text_IO.Put_Line("Metal ball!");
        when Unknown =>
          Text_IO.Put_Line("Unknown");
        when others =>
          Text_IO.Put_Line("WAT");
      end case;
    end loop Endless_loop;
  end DetectBall;


  WatchBall : DetectBall;
  r2task:releaseball;

begin
  Text_IO.Put_Line("Cool beans");
--  Endless_Loop:
--  loop
--    Chute.Hopper_Load;
--    delay 0.8;
--    Chute.Hopper_Unload;
--    Chute.Get_Ball(ReleasedBall);
--  end loop Endless_Loop;
end Main;
