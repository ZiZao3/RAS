clc;
clear all;
a = arduino('COM5', 'Uno', 'Libraries', 'Servo, SPI, I2C');%claim the device and function want to use
v1=readVoltage(a, 'A0');
v2=readVoltage(a, 'A1');%claim fsr sensor
p1 = servo(a, 'D3', 'MinPulseDuration', 700*10^-6, 'MaxPulseDuration', 2300*10^-6);
p2 = servo(a, 'D4', 'MinPulseDuration', 700*10^-6, 'MaxPulseDuration', 2300*10^-6);%servo motor
writePosition(p1, 0);
writePosition(p2, 0);%motor back to 0 before using
X=0;
Y=0;
l1=40;
l2=30;
theta1=0;
theta2=0;
t=input('wana control by yourself?1/0')%different functions to choose
if t==1%control by fsr sensor
    while X<90&&Y<90%up right cornor to close
        hold off;%clean the table
        mouse_position=get(gca,'CurrentPoint');%get the location by clicking
        X=mouse_position(1,1);%X-axis
        Y=mouse_position(1,2);%Y-axis
        plot(X,Y,'gs','linewidth',20);%draw the dot on the coordinate with green
    if theta2<63&&v2>0.4
        theta2=theta2+3;%press on the sensor and still can bend down, go down
    else if theta2==63&&v2>0.4
        theta2=theta2;%finger want to keep gridding
    else if theta2==0&&v2<=0.4
            theta2=theta2;%don't get upper when the finger is straight 
    else
        theta2=theta2-3;%release
    end
    end
    end
    writePosition(p2, theta2/270);%realize by actuator
    pause(0.01);%then check with another group of sensor and actuator 
    if  theta1<63&&v1>0.4
         theta1=theta1+3;
    else if theta1==63&&v1>0.4
            theta1=theta1;
    else if theta1==0&&v1<=0.4
            theta1=theta1;
    else
        theta1=theta1-3;
    end
    end
    end
    writePosition(p1, theta1/270);%servo work from 0-270 degree,cut the full range to 270 to simulate
    pause(0.01);
    x1=l1*cos(0.5*pi-theta2*pi/180);
    y1=30+l1*sin(0.5*pi-theta2*pi/180);
    x2=l1*cos(0.5*pi-theta2*pi/180)+l2*cos(0.5*pi-(theta1+theta2)*pi/180);
    y2=30+l1*sin(0.5*pi-(theta2*pi)/180)+l2*sin(0.5*pi-(theta1+theta2)*pi/180);
    plot([0,x1],[30,y1],[x1,x2],[y1,y2],'LineWidth',2);
    hold on;
    plot(X,Y,'gs','linewidth',20);
    grid on;
    axis([0 100 0 100]);
    pause(0.2);
    end
else%control with the control panel
    while X<90&&Y<90
        hold off;      
        mouse_position=get(gca,'CurrentPoint');
        X=mouse_position(1,1);
        Y=mouse_position(1,2);
        if X>80&&X<90&&Y<10&&Y>0&&theta2<63%buttom for bend down the secon knuckle
            theta2=theta2+1;
            writePosition(p2, theta2/270);
        else if X>80&&Y>10&&Y<20&&X<90&&theta2>0%buttom to bend back the second knuckle
                theta2=theta2-1;
                writePosition(p2, theta2/270);
        else if X>70&&X<80&&Y<10&&Y>0&&theta1<63%bend down the first knuckle
                theta1=theta1+1;
                writePosition(p1, theta1/270);
        else if X>70&&X<80&&Y>10&&Y<20&&theta1>0%bend back the first knuckle
                theta1=theta1-1;
                writePosition(p1, theta1/270);
        else if X>60&&X<70&&Y>0&&Y<10&&theta1<63&&theta2<63%bend down bottom for both joints
                theta1=theta1+1;
                theta2=theta2+1;
                writePosition(p1, theta1/270);
                writePosition(p2, theta2/270);
        else if X>60&&X<70&&Y>10&&Y<20&&theta1>0&&theta2>0%bend back both joints
                theta1=theta1-1;
                theta2=theta2-1;
                writePosition(p1, theta1/270);
                writePosition(p2, theta2/270);
        else
            theta1=theta1;
            theta2=theta2;%don't move if one of the joints on control reach its limitation
        end
        end
        end
        end
        end
        end
            x1=l1*cos(0.5*pi-theta2*pi/180);
            y1=30+l1*sin(0.5*pi-theta2*pi/180);%forward kinematic, start from (0,30) simulate palm
            x2=l1*cos(0.5*pi-theta2*pi/180)+l2*cos(0.5*pi-(theta1+theta2)*pi/180);
            y2=30+l1*sin(0.5*pi-(theta2*pi)/180)+l2*sin(0.5*pi-(theta1+theta2)*pi/180);
            plot([0,x1],[30,y1],[x1,x2],[y1,y2],'LineWidth',2);%draw the links
            hold on;% not disappear until th next clicking
            plot(X,Y,'gs','linewidth',20);%cover the old spot
            grid on;% use web table to find the buttom
            axis([0 100 0 100]);%define the range of showing table
            pause(0.1);
    end

end
writePosition(p1, 0);
writePosition(p2, 0);%motor back to 0 after using
close all;