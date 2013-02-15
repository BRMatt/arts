package body Buffer is
  -- in file Buffer.adb
  procedure Create (B : in out Buf) is
  begin
    B := new Buff;
  end Create;

  function Empty (B : Buf) return Boolean is
  begin
    return B.First = B.Last;
  end Empty;

  function Full (B : Buf) return Boolean is
  begin
    return B.Last = B.First - 1;
  end Full;

  procedure Place (B : in out Buf; E : Ball_Detected) is
  begin
    B.Cont(B.First) := E;
    B.First := B.First + 1;
  end Place;

  procedure Take (B : in out Buf; E : out Ball_Detected) is
  begin
    E := B.Cont(B.Last);
    B.Last := B.Last + 1;
  end Take;
end Buffer;
