with MaRTE_OS;
with Chute; use Chute;
with Text_IO;
with Ada.Calendar; use Ada.Calendar;
--
-- Best so far
-- 0.45 & 1.9
--

procedure Main2 is
  LastBall  :  Chute.Ball_Detected;
  ReleasedBall : Chute.Ball_Detected;
  suspend : boolean := false;
  ReleasedAt   : Time;
  ballsReleased : Integer := 0;
  
  task type releaseball;
  task body releaseball is
  begin
    Endless_loop:
    loop
      Chute.Hopper_load;
      delay 0.55;
      Chute.Hopper_Unload;
      delay 0.55;
      ballsReleased := ballsReleased+1;
      if ballsReleased > 55 then
        exit;
      end if;
    end loop Endless_loop;
  end releaseball;
  
  task type SortMetalBall;
  task body SortMetalBall is
  guard : boolean := false;
  
    Procedure Run is
    begin
      guard := true;
    end Run;
  begin
    Endless_loop2:
    loop
      if guard = true then
        delay 1.85;
        Chute.Sorter_Metal;
        suspend := true;
        delay 0.55;
        suspend := false;
        guard := false;
      else
        delay 0.05; -- yum jitter
      end if;
    end loop Endless_loop2;
  end SortMetalBall;
  type SortMetalBallPointer is access SortMetalBall;
  
  task type DetectBall;
  task body DetectBall is
    ReleasedBall : Ball_Detected;
    i : Integer;
    k : array(1..5) of SortMetalBallPointer;
  begin
    i := 1;
    k(1) := new SortMetalBall;
    k(2) := new SortMetalBall;
    k(3) := new SortMetalBall;
    k(4) := new SortMetalBall;
    k(5) := new SortMetalBall;
    Endless_loop:
    loop
      LastBall := ReleasedBall;
      Get_Ball(ReleasedBall, ReleasedAt);
      case ReleasedBall is
        when Metal =>
          Text_IO.Put_Line("Metal ball!");
          if(i = 5) then
            i := 1;
          end if;
          k(i).Run;
          i := i + 1;
        when Unknown =>
          if suspend = false then
            Chute.Sorter_Glass;
            Text_IO.Put_Line("Glass Ball!");
          end if;
        when others =>
          Text_IO.Put_Line("The World Ended. Well Done.");
      end case;
    end loop Endless_loop;
  end DetectBall;
  
  r2task    : releaseball;
  
  begin
    Text_IO.Put_Line("We are alive");
end Main2;
