clc;
clear all;
a = arduino('COM5', 'Uno', 'Libraries', 'Servo');
r = servo(a, 'D3', 'MinPulseDuration', 700*10^-6, 'MaxPulseDuration', 2300*10^-6);
s = servo(a, 'D4', 'MinPulseDuration', 700*10^-6, 'MaxPulseDuration', 2300*10^-6);
in=0;
writePosition(r, 0);
writePosition(s, 0);
while in<1
    angle1=input('an angle between 0 and 149');
    x1=angle1/270;
    writePosition(s, x1);%%write the position by motor. "s" means which motor to do. x1 should between 0-1, x1 is the persentage you want to rotate
    angle2=input('an angle between 0 and 149');
    x2=angle2/270;
    writePosition(r, x2);
    in=input('good(1)/not good(0)');
end
writePosition(r, 0);
writePosition(s, 0);
            