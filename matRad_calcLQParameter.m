function [vAlpha, vBeta]= matRad_calcLQParameter(vRadDepths,sEnergy,mTissueClass,baseData)

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Copyright 2015, Mark Bangert, on behalf of the matRad development team
%
% m.bangert@dkfz.de
%
% This file is part of matRad.
%
% matrad is free software: you can redistribute it and/or modify it under 
% the terms of the GNU General Public License as published by the Free 
% Software Foundation, either version 3 of the License, or (at your option)
% any later version.
%
% matRad is distributed in the hope that it will be useful, but WITHOUT ANY
% WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
% FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
% details.
%
% You should have received a copy of the GNU General Public License in the
% file license.txt along with matRad. If not, see
% <http://www.gnu.org/licenses/>.
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vAlpha = NaN*ones(numel(vRadDepths),1);
vBeta  = NaN*ones(numel(vRadDepths),1);

% find corresponding index
index = find([baseData(:).energy]== sEnergy.energy);
numOfTissueClass = size(baseData(1).alpha,2);

for i = 1:numOfTissueClass
    vAlpha(mTissueClass==i) = interp1(baseData(index).depths,baseData(index).alpha(:,i),vRadDepths,'nearest');
    vBeta(mTissueClass==i)  = interp1(baseData(index).depths,baseData(index).beta(:,i), vRadDepths,'nearest');
end

if sEnergy.energy >176 && sEnergy.energy<180
[vRadSort vSortIndex] = sort(vRadDepths);
vAlphaSort = vAlpha(vSortIndex);
vBetaSort = vBeta(vSortIndex);
figure, subplot(121),plot(vRadSort,vAlphaSort,'LineWidth',3),title(['Interpolated alpha using energy ' num2str(sEnergy.energy)],'FontSize',16);
        grid on, set(gca,'FontSize',12)
        subplot(122),plot(baseData(index).depths,baseData(index).alpha(:,1),'LineWidth',3),title(['alpha from base data at energy ' num2str(sEnergy.energy)],'FontSize',16);
        grid on, set(gca,'FontSize',12)
        
end
