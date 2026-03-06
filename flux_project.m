%begin solar flux project

%file
solarData=readmatrix("solarfluxdata.txt");

%data
%data, parsed
dates=solarData(1:90:end,1); %taking every 90 data points
date=datetime(dates,'ConvertFrom','yyyyMMdd');
carrington=solarData(:,4);
obsflux=solarData(1:90:end,5); %observed flux data 
adjflux=solarData(1:90:end,6); %adjusted flux data
ursiflux=solarData(1:90:end,7); %URSI Series D (adj * 0.9)
%data, full
datesFull=solarData(:,1);
datesFull=datetime(datesFull,'ConvertFrom','yyyyMMdd');
carringtonFull=solarData(:,4);
obsFull=solarData(:,5);
adjFull=solarData(:,6);
usriFull=solarData(:,7);

%figures
figure(1)
plot(date,obsflux)

hold on
baseDate=date(1);
daysSince=days(date-baseDate);
coef=polyfit(daysSince,obsflux,24);
xFit=linspace(min(daysSince),max(daysSince),260);
yFit=polyval(coef,xFit);
datesFit=baseDate+days(xFit);
plot(datesFit,yFit,'-')

xlabel('Date')
ylabel('Flux (10^-22 W m^-2 Hz^-1)')
title('Observed Flux')
grid on


figure(2)
plot(datesFull,obsFull)
xlabel('Date')
ylabel('Flux (10^-22 W m^-2 Hz^-1)')
title('Observed Flux (all data)')
grid on

[i]=findpeaks(obsFull, 'SortStr','descend','NPeaks',4);
disp(i(1))
disp(i(2))

tt=timetable(datesFull,obsFull);
monthly_avg=retime(tt,'monthly','mean');
monthly_array=table2array(monthly_avg);
disp(length(monthly_array))
xt=monthly_array;
ts1=timeseries(xt);
ts1.Name='Monthly Count';
ts1.TimeInfo.Units='monthly';
ts1.TimeInfo.StartDate='28-October-2004';
ts1.Time=ts1.Time - ts1.Time(1);

%figures
figure(3)
plot(ts1)


%end of solar flux project