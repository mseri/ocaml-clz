let cfg =
  let time () = Int32.of_float (Ptime.to_float_s @@ Ptime_clock.now ()) in
  Gz.Higher.configuration Gz.Unix time
