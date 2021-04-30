function[] = finalProjectGraph()
 close all; %closses all windows
 global gui;
 global typeS 
 global typeC
 typeS = 'o'; %Makes sure that the default set up matches the gui
 typeC = 'r';
 gui.fig = figure();
 gui.p = plot(0,0);
 gui.p.Parent.Position = [.37 .3 .6 .6];

%-------------------------------Plot/Reset buttons-----------------------------------
 
gui.pButton = uicontrol('style','pushbutton','units','normalized','position',[.04 .15 .1 .08],'string','plot','callback',{@plotValues});
gui.rButton = uicontrol('style','pushbutton','units','normalized','position',[.04 .05 .1 .08],'string','Reset','callback',{@resetValues});
 
%----------------------------------------------Radio Buttons-----------------------------------------------

 gui.buttongroupS = uibuttongroup('visible','on','unit','normalized','position', [ .04 .6 .1 .2],'selectionchangedfcn',{@symbolSelect});
    gui.S1 = uicontrol(gui.buttongroupS, 'style','radiobutton','units','normalized','position',[.1 .7 1 .2],'handlevisibility','off','string','o');
    gui.S2 = uicontrol(gui.buttongroupS, 'style','radiobutton','units','normalized','position',[.1 .4 1 .2],'handlevisibility','off','string','-');
    gui.S3 = uicontrol(gui.buttongroupS, 'style','radiobutton','units','normalized','position',[.1 .1 1 .2],'handlevisibility','off','string','*');
 gui.buttongroupC = uibuttongroup('visible','on','unit','normalized','position', [ .04 .3 .1 .2],'selectionchangedfcn',{@colorSelect});
    gui.C1 = uicontrol(gui.buttongroupC, 'style','radiobutton','units','normalized','position',[.1 .7 1 .2],'handlevisibility','off','string','r');
    gui.C2 = uicontrol(gui.buttongroupC, 'style','radiobutton','units','normalized','position',[.1 .4 1 .2],'handlevisibility','off','string','b');
    gui.C3 = uicontrol(gui.buttongroupC, 'style','radiobutton','units','normalized','position',[.1 .1 1 .2],'handlevisibility','off','string','k');
    
        gui.colorTitle = uicontrol('style','text','units','normalized','position',[.06 .5 .05 .04],'string','Color');
        gui.typeTitle = uicontrol('style','text','units','normalized','position',[.06 .8 .05 .04],'string','Style');
        
%----------------------------------------Input Boxes-------------------------
        
gui.xInput = uicontrol('style','edit','units','normalized','position',[.2 .05 .3 .1],'string','');
     gui.xTitle = uicontrol('style','text','units','normalized','position',[.3 .15 .11 .04],'string','X Values');
gui.yInput = uicontrol('style','edit','units','normalized','position',[.6 .05 .3 .1],'string','');
    gui.yTitle = uicontrol('style','text','units','normalized','position',[.7 .15 .11 .04],'string','Y Values');
    
%-----------------------------Axis' limits and titles---------------------------------
    
gui.graphTitle = uicontrol('style','edit','units','normalized','position',[.15 .85 .13 .05],'string','Title');
    gui.graphTitleTitle = uicontrol('style','text','units','normalized','position',[.17 .9 .1 .05],'string','Graph Title');
gui.xAxis = uicontrol('style','edit','units','normalized','position',[.15 .7 .13 .05],'string','X Axis');
    gui.xAxisTitle = uicontrol('style','text','units','normalized','position',[.17 .75 .1 .05],'string','X Axis Title');
gui.yAxis = uicontrol('style','edit','units','normalized','position',[.15 .55 .13 .05],'string','Y Axis');
    gui.yAxisTitle = uicontrol('style','text','units','normalized','position',[.17 .6 .1 .05],'string','Y Axis Title');
gui.xLimUpper = uicontrol('style','edit','units','normalized','position',[.15 .45 .13 .05],'string','');
    gui.xLimUpperTitle = uicontrol('style','text','units','normalized','position',[.16 .5 .12 .03],'string','X Limit Upper');
gui.xLimLower = uicontrol('style','edit','units','normalized','position',[.15 .37 .13 .05],'string','');
     gui.xLimLowerTitle = uicontrol('style','text','units','normalized','position',[.16 .42 .12 .03],'string','X Limit Lower');
gui.yLimUpper = uicontrol('style','edit','units','normalized','position',[.15 .29 .13 .05],'string','');
    gui.yLimUpperTitle = uicontrol('style','text','units','normalized','position',[.16 .34 .12 .03],'string','Y Limit Upper');
gui.yLimLower = uicontrol('style','edit','units','normalized','position',[.15 .21 .13 .05],'string','');
    gui.yLimLowerTitle = uicontrol('style','text','units','normalized','position',[.15 .26 .12 .03],'string','Y Limit Lower');
end
function[] = symbolSelect(~,~)
global typeS;
global gui;
typeS = gui.buttongroupS.SelectedObject.String; %makes typeS whatever button is selected for style
end
function[] = colorSelect(~,~)
global gui;
global typeC;
typeC = gui.buttongroupC.SelectedObject.String; %makes typeC whatever button is selected for colors
end
function[] = plotValues(~,~)
hold on;
global gui;
global typeS;
global typeC;

%------------------------------Values for X and Y------------------

xValArray = char(regexp(gui.xInput.String,',','split')); %turns the input into a charecter array with commas dividing the charecters
    if ~isempty(regexp(gui.xInput.String,'[^\-0-9,\.]')) %makes sure there are no invalid inputs
        msgbox('Please enter numbers seperated by commas!','X Input Error','error','modal');
        return
    end
    
yValArray = char(regexp(gui.yInput.String,',','split')); %Turns the Y value into a charecter array divided by commas as well
    if ~isempty(regexp(gui.yInput.String,'[^\-0-9,\.]')) %Makes sure the Y input is only numbers and commas
        msgbox('Please enter numbers seperated by commas!','Y Input Error','error','modal');
        return
    end
    
[lengthX, ~] = size(xValArray); 

[lengthY, ~] = size(yValArray);

if lengthX ~= lengthY   % Makes sure that X and Y have the same number of inputs
    msgbox('X and Y need to have the same number of inputs.','Input Length Error','modal')
    return
end
    
for i = 1:lengthY %for every charecter of the string
    yA = yValArray(i, :); %takes the ith value of the array
    yA = yA(yA ~= ' '); %takes charecters that are not a space
    y(i) = str2double(yA); %converts the string to a number
    xA = xValArray(i, :);
    xA = xA(xA ~= ' ');
    x(i) = str2double(xA);
end

%---------------Radio Buttons---------------------------------------
    if typeS == '-' && typeC == 'r' %logic check to find the combonations of colors and symbols
        plot(x, y, 'r-');
        elseif typeS == '-' && typeC == 'b'
            plot(x, y, 'b-');
        elseif typeS == '-' && typeC == 'k'
            plot(x, y, 'k-');
            
        elseif typeS == '*' && typeC == 'r'
             plot(x, y, 'r*');
        elseif typeS == '*' && typeC == 'b'
            plot(x, y, 'b*');
        elseif typeS == '*' && typeC == 'k'
            plot(x, y, 'k*');
            
        elseif typeS == 'o' && typeC == 'r'
             plot(x, y, 'ro');
        elseif typeS == 'o' && typeC == 'b'
            plot(x, y, 'bo');
    else
            plot(x,y, 'ko');
    end
    
%---------------------------------------------
%--------------Labels-------------------------
 labelY = gui.yAxis.String;
    ylabel(labelY)
  labelX = gui.xAxis.String;
    xlabel(labelX)
  GraphTitle = gui.graphTitle.String;
    title(GraphTitle)
%---------Limit------------------------------

xLU = str2double(gui.xLimUpper.String);
xLL = str2double(gui.xLimLower.String);
yLU = str2double(gui.yLimUpper.String);
yLL = str2double(gui.yLimLower.String);
    if xLU > xLL %Makes sure lower limit is always smaller than upper limit
        xlim([xLL xLU])
    elseif xLU <= xLL
        msgbox('Lower X limit is larger than upper limit','Limit Error','Error','modal')
        return
    end
     if yLU > yLL
        ylim([yLL yLU])
     elseif yLU <= yLL
        msgbox('Lower Y limit is larger than upper limit','Limit Error','Error','modal')
        return
     end
%----------------------------------------------------------------------------------------------------
end
function[] = resetValues(~,~)
hold off; %Resets the Graph
plot(0,0)
end