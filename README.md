# VGA Chinese Chess with Verilog

This is my final project of NTHU Logic Design Laboratory, design and implement using Verilog to build a special VGA Chinese chess game, supports two players with individual timers, random chess mode, P2S keyboard. The repo aims to be a meaningful reference for those who interests in writing a game with OOP-styled Verilog.

For (Traditional) Chinese guests, to see more details, you can check `doc/README.md` to see the spec, designs and implementation methods directly. Otherwise, feel free to browse source code, which most of the comments are in English.

Notice that `Ps2Interface.v` is created by some senior, who re-implement Ulrich Zolt's work from VHDL to Verilog, and I only modified a little bit for better coding style. Similarly, `vga_controller.v` is also created by some senior, but the coding style is quite... mentally distorting, so I re-implement a better version, which you can control hyper-parameters for different resolution of VGAs. All the other files are implemented by myself.

Hope this repo helps. For any questions, feel free to contact me or give your patch. Have a nice day.