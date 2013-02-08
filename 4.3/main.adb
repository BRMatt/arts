with MaRTE_OS;
with Chute; use Chute;
with Text_IO;
with Ada.Calendar; use Ada.Calendar;
--
-- Best so far
-- 0.45 & 1.9
--

procedure Main is
  LastBall  :  Chute.Ball_Detected;
  ReleasedBall : Chute.Ball_Detected;
  
  suspend : boolean;
  ReleasedAt   : Time;
  ballsReleased : Integer := 0;
  
  task type releaseball;
  task body releaseball iswith MaRTE_OS;
with Chute; use Chute;
with Text_IO;
with Ada.Calendar; use Ada.Calendar;
--
-- Best so far
-- 0.45 & 1.9
--

procedure Main is
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
  begin
    delay 1.85;
    Chute.Sorter_Metal;
    suspend := true;
    delay 0.55;
    suspend := false;
  end SortMetalBall;
  
  type SortMetalBallPointer is access SortMetalBall;
  --type k is array(Positive range <>) of SortMetalBallPointer;
  task type DetectBall;
  task body DetectBall is
    ReleasedBall : Ball_Detected;
    i : Integer;
    k : array(1..61) of SortMetalBallPointer;
  begin
    i := 0;
    Endless_loop:
    loop
      LastBall := ReleasedBall;
      Get_Ball(ReleasedBall, ReleasedAt);
      case ReleasedBall is
        when Metal =>
          Text_IO.Put_Line("Metal ball!");
          if(i = 60) then
            i := 1;
          end if;
          i := i + 1;
          k(i) := new SortMetalBall;
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

  WatchBall : DetectBall;
  r2task    : releaseball;

begin
  suspend := false;
  Text_IO.Put_Line("Starting Cool beans");
end Main;
