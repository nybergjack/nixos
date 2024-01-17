{ config, inputs , pkgs, ...}:

{

 programs.git = {
    enable = true;
    userName  = "nybergjack";
    userEmail = "nybergjack@gmail.com";
  };

}
