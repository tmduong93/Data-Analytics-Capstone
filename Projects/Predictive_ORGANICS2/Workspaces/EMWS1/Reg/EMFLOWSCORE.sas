*************************************;
*** begin scoring code for regression;
*************************************;

length _WARN_ $4;
label _WARN_ = 'Warnings' ;

length I_TargetBuy $ 12;
label I_TargetBuy = 'Into: TargetBuy' ;
*** Target Values;
array REGDRF [2] $12 _temporary_ ('1' '0' );
label U_TargetBuy = 'Unnormalized Into: TargetBuy' ;
*** Unnormalized target values;
ARRAY REGDRU[2]  _TEMPORARY_ (1 0);

*** Generate dummy variables for TargetBuy ;
drop _Y ;
label F_TargetBuy = 'From: TargetBuy' ;
length F_TargetBuy $ 12;
F_TargetBuy = put( TargetBuy , BEST12. );
%DMNORMIP( F_TargetBuy )
if missing( TargetBuy ) then do;
   _Y = .;
end;
else do;
   if F_TargetBuy = '0'  then do;
      _Y = 1;
   end;
   else if F_TargetBuy = '1'  then do;
      _Y = 0;
   end;
   else do;
      _Y = .;
   end;
end;

drop _DM_BAD;
_DM_BAD=0;

*** Check DemAffl for missing values ;
if missing( DemAffl ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check DemAge for missing values ;
if missing( DemAge ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check PromSpend for missing values ;
if missing( PromSpend ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check PromTime for missing values ;
if missing( PromTime ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Generate dummy variables for DemClusterGroup ;
drop _1_0 _1_1 _1_2 _1_3 _1_4 _1_5 ;
*** encoding is sparse, initialize to zero;
_1_0 = 0;
_1_1 = 0;
_1_2 = 0;
_1_3 = 0;
_1_4 = 0;
_1_5 = 0;
if missing( DemClusterGroup ) then do;
   _1_0 = .;
   _1_1 = .;
   _1_2 = .;
   _1_3 = .;
   _1_4 = .;
   _1_5 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm1 $ 1; drop _dm1 ;
   %DMNORMCP( DemClusterGroup , _dm1 )
   _dm_find = 0; drop _dm_find;
   if _dm1 <= 'D'  then do;
      if _dm1 <= 'B'  then do;
         if _dm1 = 'A'  then do;
            _1_0 = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm1 = 'B'  then do;
               _1_1 = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm1 = 'C'  then do;
            _1_2 = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm1 = 'D'  then do;
               _1_3 = 1;
               _dm_find = 1;
            end;
         end;
      end;
   end;
   else do;
      if _dm1 <= 'F'  then do;
         if _dm1 = 'E'  then do;
            _1_4 = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm1 = 'F'  then do;
               _1_5 = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm1 = 'U'  then do;
            _1_0 = -1;
            _1_1 = -1;
            _1_2 = -1;
            _1_3 = -1;
            _1_4 = -1;
            _1_5 = -1;
            _dm_find = 1;
         end;
      end;
   end;
   if not _dm_find then do;
      _1_0 = .;
      _1_1 = .;
      _1_2 = .;
      _1_3 = .;
      _1_4 = .;
      _1_5 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for DemGender ;
drop _2_0 _2_1 ;
if missing( DemGender ) then do;
   _2_0 = .;
   _2_1 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm1 $ 1; drop _dm1 ;
   %DMNORMCP( DemGender , _dm1 )
   if _dm1 = 'F'  then do;
      _2_0 = 1;
      _2_1 = 0;
   end;
   else if _dm1 = 'M'  then do;
      _2_0 = 0;
      _2_1 = 1;
   end;
   else if _dm1 = 'U'  then do;
      _2_0 = -1;
      _2_1 = -1;
   end;
   else do;
      _2_0 = .;
      _2_1 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for DemReg ;
drop _3_0 _3_1 _3_2 _3_3 ;
*** encoding is sparse, initialize to zero;
_3_0 = 0;
_3_1 = 0;
_3_2 = 0;
_3_3 = 0;
if missing( DemReg ) then do;
   _3_0 = .;
   _3_1 = .;
   _3_2 = .;
   _3_3 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm10 $ 10; drop _dm10 ;
   %DMNORMCP( DemReg , _dm10 )
   _dm_find = 0; drop _dm_find;
   if _dm10 <= 'SCOTTISH'  then do;
      if _dm10 <= 'NORTH'  then do;
         if _dm10 = 'MIDLANDS'  then do;
            _3_0 = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm10 = 'NORTH'  then do;
               _3_1 = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm10 = 'SCOTTISH'  then do;
            _3_2 = 1;
            _dm_find = 1;
         end;
      end;
   end;
   else do;
      if _dm10 = 'SOUTH EAST'  then do;
         _3_3 = 1;
         _dm_find = 1;
      end;
      else do;
         if _dm10 = 'SOUTH WEST'  then do;
            _3_0 = -1;
            _3_1 = -1;
            _3_2 = -1;
            _3_3 = -1;
            _dm_find = 1;
         end;
      end;
   end;
   if not _dm_find then do;
      _3_0 = .;
      _3_1 = .;
      _3_2 = .;
      _3_3 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for DemTVReg ;
drop _4_0 _4_1 _4_2 _4_3 _4_4 _4_5 _4_6 _4_7 _4_8 _4_9 _4_10 _4_11 ;
*** encoding is sparse, initialize to zero;
_4_0 = 0;
_4_1 = 0;
_4_2 = 0;
_4_3 = 0;
_4_4 = 0;
_4_5 = 0;
_4_6 = 0;
_4_7 = 0;
_4_8 = 0;
_4_9 = 0;
_4_10 = 0;
_4_11 = 0;
if missing( DemTVReg ) then do;
   _4_0 = .;
   _4_1 = .;
   _4_2 = .;
   _4_3 = .;
   _4_4 = .;
   _4_5 = .;
   _4_6 = .;
   _4_7 = .;
   _4_8 = .;
   _4_9 = .;
   _4_10 = .;
   _4_11 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   %DMNORMCP( DemTVReg , _dm12 )
   if _dm12 = 'LONDON'  then do;
      _4_3 = 1;
   end;
   else if _dm12 = 'MIDLANDS'  then do;
      _4_4 = 1;
   end;
   else if _dm12 = 'S & S EAST'  then do;
      _4_8 = 1;
   end;
   else if _dm12 = 'N WEST'  then do;
      _4_7 = 1;
   end;
   else if _dm12 = 'EAST'  then do;
      _4_2 = 1;
   end;
   else if _dm12 = 'WALES & WEST'  then do;
      _4_11 = 1;
   end;
   else if _dm12 = 'YORKSHIRE'  then do;
      _4_0 = -1;
      _4_1 = -1;
      _4_2 = -1;
      _4_3 = -1;
      _4_4 = -1;
      _4_5 = -1;
      _4_6 = -1;
      _4_7 = -1;
      _4_8 = -1;
      _4_9 = -1;
      _4_10 = -1;
      _4_11 = -1;
   end;
   else if _dm12 = 'C SCOTLAND'  then do;
      _4_1 = 1;
   end;
   else if _dm12 = 'N EAST'  then do;
      _4_5 = 1;
   end;
   else if _dm12 = 'S WEST'  then do;
      _4_9 = 1;
   end;
   else if _dm12 = 'N SCOT'  then do;
      _4_6 = 1;
   end;
   else if _dm12 = 'BORDER'  then do;
      _4_0 = 1;
   end;
   else do;
      _4_0 = .;
      _4_1 = .;
      _4_2 = .;
      _4_3 = .;
      _4_4 = .;
      _4_5 = .;
      _4_6 = .;
      _4_7 = .;
      _4_8 = .;
      _4_9 = .;
      _4_10 = .;
      _4_11 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for PromClass ;
drop _5_0 _5_1 _5_2 ;
if missing( PromClass ) then do;
   _5_0 = .;
   _5_1 = .;
   _5_2 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm8 $ 8; drop _dm8 ;
   %DMNORMCP( PromClass , _dm8 )
   if _dm8 = 'SILVER'  then do;
      _5_0 = 0;
      _5_1 = 0;
      _5_2 = 1;
   end;
   else if _dm8 = 'GOLD'  then do;
      _5_0 = 1;
      _5_1 = 0;
      _5_2 = 0;
   end;
   else if _dm8 = 'TIN'  then do;
      _5_0 = -1;
      _5_1 = -1;
      _5_2 = -1;
   end;
   else if _dm8 = 'PLATINUM'  then do;
      _5_0 = 0;
      _5_1 = 1;
      _5_2 = 0;
   end;
   else do;
      _5_0 = .;
      _5_1 = .;
      _5_2 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** If missing inputs, use averages;
if _DM_BAD > 0 then do;
   _P0 = 0.2643852211;
   _P1 = 0.7356147789;
   goto REGDR1;
end;

*** Compute Linear Predictor;
drop _TEMP;
drop _LP0;
_LP0 = 0;

***  Effect: DemAffl ;
_TEMP = DemAffl ;
_LP0 = _LP0 + (    0.24341238901254 * _TEMP);

***  Effect: DemAge ;
_TEMP = DemAge ;
_LP0 = _LP0 + (   -0.05278198078786 * _TEMP);

***  Effect: DemClusterGroup ;
_TEMP = 1;
_LP0 = _LP0 + (    0.12896107987695) * _TEMP * _1_0;
_LP0 = _LP0 + (    0.13977618737294) * _TEMP * _1_1;
_LP0 = _LP0 + (    0.17380938077329) * _TEMP * _1_2;
_LP0 = _LP0 + (    0.20178748764864) * _TEMP * _1_3;
_LP0 = _LP0 + (    0.11978180470459) * _TEMP * _1_4;
_LP0 = _LP0 + (    0.15967816546173) * _TEMP * _1_5;

***  Effect: DemGender ;
_TEMP = 1;
_LP0 = _LP0 + (    0.94670324174172) * _TEMP * _2_0;
_LP0 = _LP0 + (     0.0406021554163) * _TEMP * _2_1;

***  Effect: DemReg ;
_TEMP = 1;
_LP0 = _LP0 + (    0.09910329178248) * _TEMP * _3_0;
_LP0 = _LP0 + (   -0.31849953162598) * _TEMP * _3_1;
_LP0 = _LP0 + (    0.04179241463367) * _TEMP * _3_2;
_LP0 = _LP0 + (   -0.04814332948551) * _TEMP * _3_3;

***  Effect: DemTVReg ;
_TEMP = 1;
_LP0 = _LP0 + (   -0.31033524884552) * _TEMP * _4_0;
_LP0 = _LP0 + (    0.02064386750873) * _TEMP * _4_1;
_LP0 = _LP0 + (   -0.03658594758674) * _TEMP * _4_2;
_LP0 = _LP0 + (    0.06067327735822) * _TEMP * _4_3;
_LP0 = _LP0 + (   -0.15876372656482) * _TEMP * _4_4;
_LP0 = _LP0 + (    0.39676911804233) * _TEMP * _4_5;
_LP0 = _LP0 + (   -0.15157194073022) * _TEMP * _4_6;
_LP0 = _LP0 + (                   0) * _TEMP * _4_7;
_LP0 = _LP0 + (                   0) * _TEMP * _4_8;
_LP0 = _LP0 + (                   0) * _TEMP * _4_9;
_LP0 = _LP0 + (                   0) * _TEMP * _4_10;
_LP0 = _LP0 + (                   0) * _TEMP * _4_11;

***  Effect: PromClass ;
_TEMP = 1;
_LP0 = _LP0 + (    0.11842494837271) * _TEMP * _5_0;
_LP0 = _LP0 + (   -0.11027237115871) * _TEMP * _5_1;
_LP0 = _LP0 + (   -0.01805302764153) * _TEMP * _5_2;

***  Effect: PromSpend ;
_TEMP = PromSpend ;
_LP0 = _LP0 + ( -7.0151482131872E-6 * _TEMP);

***  Effect: PromTime ;
_TEMP = PromTime ;
_LP0 = _LP0 + (    0.01047983874439 * _TEMP);

*** Naive Posterior Probabilities;
drop _MAXP _IY _P0 _P1;
_TEMP =    -1.34091951263469 + _LP0;
if (_TEMP < 0) then do;
   _TEMP = exp(_TEMP);
   _P0 = _TEMP / (1 + _TEMP);
end;
else _P0 = 1 / (1 + exp(-_TEMP));
_P1 = 1.0 - _P0;

REGDR1:

*** Residuals;
if (_Y = .) then do;
   R_TargetBuy1 = .;
   R_TargetBuy0 = .;
end;
else do;
    label R_TargetBuy1 = 'Residual: TargetBuy=1' ;
    label R_TargetBuy0 = 'Residual: TargetBuy=0' ;
   R_TargetBuy1 = - _P0;
   R_TargetBuy0 = - _P1;
   select( _Y );
      when (0)  R_TargetBuy1 = R_TargetBuy1 + 1;
      when (1)  R_TargetBuy0 = R_TargetBuy0 + 1;
   end;
end;

*** Posterior Probabilities and Predicted Level;
label P_TargetBuy1 = 'Predicted: TargetBuy=1' ;
label P_TargetBuy0 = 'Predicted: TargetBuy=0' ;
P_TargetBuy1 = _P0;
_MAXP = _P0;
_IY = 1;
P_TargetBuy0 = _P1;
if (_P1 >  _MAXP + 1E-8) then do;
   _MAXP = _P1;
   _IY = 2;
end;
I_TargetBuy = REGDRF[_IY];
U_TargetBuy = REGDRU[_IY];

*************************************;
***** end scoring code for regression;
*************************************;
