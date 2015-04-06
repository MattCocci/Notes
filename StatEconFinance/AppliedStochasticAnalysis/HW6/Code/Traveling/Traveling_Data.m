%% This file constructs the data matrices that include the distance
%  between schools and the latitude and longitude coordinates

%% Assign indices for code readability
Butler     = 1;
ND         = 2;
Kansas     = 3;
Louisville = 4;
Villanova  = 5;
Duke       = 6;
UNC        = 7;
Georgetown = 8;
UCLA       = 9;
Arizona    = 10;
UVA        = 11;
Oklahoma   = 12;
Kentucky   = 13;
Nlocations = 13;
names = {'Butler'; 'Notre Dame'; 'Kansas'; 'Louisville'; ...
         'Villanova'; 'Duke'; 'UNC'; 'Georgetown'; 'UCLA'; ...
         'Arizona'; 'UVA'; 'Oklahoma'; 'Kentucky'};

%% Set up the distance matrix
D = zeros(Nlocations);

% From Butler
  D(Butler, ND)         = 136;
  D(Butler, Kansas)     = 530;
  D(Butler, Louisville) = 122;
  D(Butler, Villanova)  = 632;
  D(Butler, Duke)       = 608;
  D(Butler, UNC)        = 606;
  D(Butler, Georgetown) = 573;
  D(Butler, UCLA)       = 2090;
  D(Butler, Arizona)    = 1692;
  D(Butler, UVA)        = 561;
  D(Butler, Oklahoma)   = 747;
  D(Butler, Kentucky)   = 195;

% From Notre Dame
  D(ND, Kansas)     = 620;
  D(ND, Louisville) = 260;
  D(ND, Villanova)  = 656;
  D(ND, Duke)       = 723;
  D(ND, UNC)        = 721;
  D(ND, Georgetown) = 604;
  D(ND, UCLA)       = 2111;
  D(ND, Arizona)    = 1808;
  D(ND, UVA)        = 681;
  D(ND, Oklahoma)   = 881;
  D(ND, Kentucky)   = 328;

% From Kansas
  D(Kansas, Louisville) = 548;
  D(Kansas, Villanova)  = 1153;
  D(Kansas, Duke)       = 1085;
  D(Kansas, UNC)        = 1083;
  D(Kansas, Georgetown) = 1097;
  D(Kansas, UCLA)       = 1553;
  D(Kansas, Arizona)    = 1156;
  D(Kansas, UVA)        = 1038;
  D(Kansas, Oklahoma)   = 334;
  D(Kansas, Kentucky)   = 624;

% From Louisville
  D(Louisville, Villanova)  = 661;
  D(Louisville, Duke)       = 540;
  D(Louisville, UNC)        = 538;
  D(Louisville, Georgetown) = 602;
  D(Louisville, UCLA)       = 2102;
  D(Louisville, Arizona)    = 1704;
  D(Louisville, UVA)        = 493;
  D(Louisville, Oklahoma)   = 778;
  D(Louisville, Kentucky)   = 79;

% From Villanova
  D(Villanova, Duke)       = 400;
  D(Villanova, UNC)        = 409;
  D(Villanova, Georgetown) = 147;
  D(Villanova, UCLA)       = 2713;
  D(Villanova, Arizona)    = 2315;
  D(Villanova, UVA)        = 251;
  D(Villanova, Oklahoma)   = 1388;
  D(Villanova, Kentucky)   = 622;

% From Duke
  D(Duke, UNC)        = 11;
  D(Duke, Georgetown) = 262;
  D(Duke, UCLA)       = 2531;
  D(Duke, Arizona)    = 2114;
  D(Duke, UVA)        = 184;
  D(Duke, Oklahoma)   = 1194;
  D(Duke, Kentucky)   = 468;

% From UNC
  D(UNC, Georgetown) = 466;
  D(UNC, UCLA)       = 2530;
  D(UNC, Arizona)    = 2112;
  D(UNC, UVA)        = 188;
  D(UNC, Oklahoma)   = 1192;
  D(UNC, Kentucky)   = 466;

% From Georgetown
  D(Georgetown, UCLA)     = 2682;
  D(Georgetown, Arizona)  = 2277;
  D(Georgetown, UVA)      = 113;
  D(Georgetown, Oklahoma) = 1344;
  D(Georgetown, Kentucky) = 530;

% From UCLA
  D(UCLA, Arizona)  = 500;
  D(UCLA, UVA)      = 2563;
  D(UCLA, Oklahoma) = 1364;
  D(UCLA, Kentucky) = 2178;

% From Arizona
  D(Arizona, UVA)      = 2157;
  D(Arizona, Oklahoma) = 973;
  D(Arizona, Kentucky) = 1825;

% From UVA
  D(UVA, Oklahoma) = 1223;
  D(UVA, Kentucky) = 420;

% From Oklahoma
  D(Oklahoma, Kentucky) = 853;

% We filled in i to j above; now fill in j to i
flipped    = D';
replace    = find((D == 0));
D(replace) = flipped(replace);

%% Set up lattitude and longitude
L = zeros(Nlocations,2);
L(Butler,:)      = [-86.169784  39.839703];
L(ND, :)         = [-86.235382  41.705728];
L(Kansas, :)     = [-95.255871  38.954548];
L(Louisville, :) = [-85.758953  38.211178];
L(Villanova, :)  = [-75.337329  40.034889];
L(Duke, :)       = [-78.938261  36.001561];
L(UNC, :)        = [-79.046881  35.904882];
L(Georgetown, :) = [-77.072269  38.907588];
L(UCLA, :)       = [-118.445181 34.068997];
L(Arizona, :)    = [-110.950098 32.231808];
L(UVA, :)        = [-78.507934  38.033507];
L(Oklahoma, :)   = [-97.445832  35.205872];
L(Kentucky, :)   = [-84.504024  38.030613];
