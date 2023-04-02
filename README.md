# VGA Chinese Chess with Verilog

This repository contains the final project for NTHU Logic Design Laboratory (2022 Spring). The project is a special VGA Chinese chess game designed and implemented using Verilog. The game supports two players with individual timers, random chess mode, and P2S keyboard. This repository aims to be a meaningful reference for those interested in writing a game with OOP-styled Verilog.

For Chinese guests, please refer to `doc/README.md` to see the specifications, designs, and implementation methods directly. The source code contains mostly English comments.

Please note that `Ps2Interface.v`, `KeyboardCtrl.v`, and `KeyboardDecoder.v` were originally implemented by a senior, who re-implemented Ulrich Zolt's work from VHDL to Verilog. I made some modifications to `Ps2Interface.v` for better coding style. Additionally, vga_controller.v was also created by a senior, but the coding style was quite... mentally distorting, so I re-implemented a better version that allows control of hyper-parameters for different VGA resolutions. All other files were implemented by myself.

I hope this repository serves as a helpful reference. Please feel free to contact me or submit a patch if you have any questions. Have a great day!