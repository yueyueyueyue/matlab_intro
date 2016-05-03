function powerProfile(Per,c,k, Uc, Uf, Ur)

u = 0:0.01:Uf+2;
a = Per*Uc^k/(Uc^k-Ur^k);
b = Per/(Ur^k-Uc^k);

for i=1:length(u)    
    if u(i) > Uc && u(i) <=Ur
        P(i) = a + b*u(i)^k;
    elseif u(i) > Ur && u(i) <= Uf
        P(i) = Per;
    else
        P(i) = 0;
    end
end
% Convert from Watts to Kilowatts
P = P/1000;

% Plot wind profile
figure
r = wblrnd(c,k,[15000 1]);
hist(r,15)
h = get(gca,'Children');
set(h(1),'FaceColor',[.8 .8 1])

% Overlay plot of turbine power profile
hold on
plot(u,P,'LineWidth',3,'Color','k')
xlabel('Wind speed (m/s)'); ylabel('Turbine power (kW)')
title ('Wind Turbine Power Profile')
legend('wind profile','Turbine power profile','Location','East')
text(Uc-1.5,300,'Uc','FontSize',14)
text(Ur+1,2200,'Ur','FontSize',14)
text(Uf+1,300,'Uf','FontSize',14)
end
