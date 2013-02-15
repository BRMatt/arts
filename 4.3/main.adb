with MaRTE_OS;
with Chute; use Chute;
with Text_IO;
with Ada.Calendar; use Ada.Calendar;
with Buffer;
--
-- Best so far
-- 0.45 & 1.9
--

procedure Main is

  BallBuffer : Buffer;

  task type ChuteController;
  task body ChuteController is
    release : Boolean;
  begin
    loop
      if release = true then
        Chute.Hopper_load;
        delay 0.55;
        Chute.Hopper_Unload;
        delay 0.55;
      end if;
    end loop;
  end;

  task type TypeDetector;
  task body TypeDetector is
    TailBall     : Ball_Detected;
    ReleasedBall : Ball_Detected;
    ReleasedAt   : Time;
  begin
    loop
      Get_Ball(ReleasedBall, ReleasedAt);

      if ReleasedBall = Metal then
        Buffer
      end if;
    end loop;
  end;

  task type ChuteSorter;
  task body ChuteSorter is
  begin
    loop
      accept NotifyBall do
        Text_IO.Put_Line("Sort: Notified of incoming ball");
      end;
    end loop;
  end;

  ReleaseTask  : ChuteController;
  SorterTask   : ChuteSorter;
  DetectorTask : TypeDetector(ReleaseTask, SorterTask);

begin
  Text_IO.Put_Line("Starting Cool beans");
end Main;
