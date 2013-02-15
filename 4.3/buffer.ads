with Chute; use Chute;

package Buffer is
  -- Package specification in file called buffer.ads
  -- example of an abstract data type
  type Buf is limited private;
  procedure Create (B : in out Buf);
  function Empty (B : Buf) return Boolean;
  procedure Place (B : in out Buf; E : Ball_Detected);
  procedure Take (B : in out Buf; E : out Ball_Detected);
private
  -- none of the following declarations are externally visible
  Size : constant := 10;
  type Small is mod Size;
  type Buff_Array is array(Small) of Ball_Detected;
  type Buff is record
    First, Last : Small := 0;
    Cont : Buff_Array;
  end record;
  type Buf is access Buff;
end Buffer;
