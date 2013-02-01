with ada.calendar; use ada.calendar;

package chute is

    type ball_detected is (metal, unknown);	-- types of ball
    procedure hopper_load;			-- load hopper
    procedure hopper_unload;			-- unload hopper
    procedure sorter_metal;			-- first solenoid open
    procedure sorter_glass;			-- second solenoid open
    procedure sorter_close;			-- neither solenoid open
    procedure get_ball(b: out ball_detected; t: out time);
						-- returns ball type
						-- and time detected
end chute;


