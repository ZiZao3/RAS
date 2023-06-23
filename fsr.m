clc;
clear all;
a = arduino('COM5', 'Uno', 'Libraries', 'SPI, I2C');
v=readVoltage(a, 'A0');
r=readVoltage(a, 'A1');
disp(v)
disp(r)