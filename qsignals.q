
// step 1, update local data store
updateData:{[]
	load`trades;
	lasttime: exec last time from trades;
	h:hopen`::5010;
	`trades insert (h"" sv ("select from trades where time > ";string lasttime));
	hclose h;}

// step 2, create candlestick binned data.
candles:{[]
	select date: time,o,h,l,c,v,close from select o:first price,h:max price,l:min price,c:last price,v:sum size,close:last price by 00:15:00.000000 xbar time from trades};


mavg1:{a:sum[x#y]%x; b:(x-1)%x; a,a b\(x+1)_y%x};
calcRsi:{100*rs%1+rs:mavg1[x;y*y>0]%mavg1[x;abs y*(y:y-prev y)<0]};

j:0; psar:(); ud:(); ud:ud, 1; ep:(); af:(); af:af, 0.02; afl:();
calcpsar:{[h;l]
    $[1=ud[j-1];
           $[l < (psar[j-1])+afl[j-1]; psar::psar,ep[j-1];psar::psar,(psar[j-1])+afl[j-1]];
       $[h > (psar[j-1])+afl[j-1]; psar::psar,ep[j-1];psar::psar,(psar[j-1])+afl[j-1]]
    ];};
calcaf:{[]
    $[(ud[j])=ud[j-1];
        $[(ud[j])=1;
            $[(ep[j])>ep[j-1];
                af::af,min(0.2,af[j-1]+0.02);
                af::af,af[j-1]
            ];
            $[(ep[j])<ep[j-1];
                af::af,min(0.2,af[j-1]+0.02);
                af::af,af[j-1]
            ]
         ];
         af:: af,0.02
    ];};
calcSAR:{[data]
    j::0; psar::(); ud::(); ud::ud, 1; ep::(); af::(); af::af, 0.02; afl::();
    psar::psar,first exec l from data where i = 0;
    ep::ep,first exec h from data where i = 0;
    afl::afl,af[0]*ep[0]-psar[0];
        do[-1+count data;
                j::j+1;
        h:first exec h from data where i=j;
        l:first exec l from data where i=j;
        calcpsar[h;l];

                $[ h > psar[j]; ud::ud,1; ud::ud,0];
                if[ud[j]=1;$[h > ep[j-1]; ep::ep,h;ep::ep,ep[j-1]]];
                if[ud[j]=0;$[l < ep[j-1]; ep::ep,l;ep::ep,ep[j-1]]];
        calcaf[];
                afl::afl, af[j]*ep[j]-psar[j];
        ]; data: update count psar:psar,ep:ep,af:af,SAR: "b"$ud from data; data};

// step 3, add indicators to local candlestick data
indicators:{[data]
	data:update
	  momentum:{(x>=0)} -1+close%close[i-5],
      rsi:((10#0Nf),calcRsi[10;close]),
	  volatility:0^5 mdev log close%close[i-1],
	  sma20:mavg[20;close],
	  sma50:mavg[50;close],
      ATR:ema[2%11;h-l],
      hdash:h-h[i-1],
      ldash:l[i-1]-l,
      macd:(ema[2%41;close])-ema[2%71;close],
	  macdsignal:ema[2%61;(ema[2%41;close])-ema[2%71;close]],
      boll: mdev [14;close] from data;
       //KST
        data:update signal:mavg[9;(((mavg[10;100*-1+close%close[i-10]])+2*mavg[10;100*-1+close%close[i-15]])+3*mavg[10;100*-1+close%close[i-20]])+4*mavg[15;100*-1+close%close[i-30]]],kst:(((mavg[10;100*-1+close%close[i-10]])+2*mavg[10;100*-1+close%close[i-15]])+3*mavg[10;100*-1+close%close[i-20]])+4*mavg[15;100*-1+close%close[i-30]] from data;

        //ADX
        data:update Dplus:hdash from data where hdash>ldash,hdash>0;
        data:0^update Dminus:ldash from data where ldash>hdash,ldash>0;
        data:update DMIplus: (ema[2%11;Dplus])%ATR from data;
        data:update DMIminus: (ema[2%11;Dminus])%ATR from data;
        data:update Dx:100*(sqrt[(DMIplus-DMIminus)*DMIplus-DMIminus])%DMIplus+DMIminus from data;
        data:update adx:mavg[10;Dx] from data;

        //SAR
        data:calcSAR[data]; 
        data}

updateData[];
data:candles[];
data:indicators[data];

.z.ts:{[] updateData[]; data:candles[]; data:indicators[data];}

\t 300000
