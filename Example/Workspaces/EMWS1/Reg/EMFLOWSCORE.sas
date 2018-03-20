*************************************;
*** begin scoring code for regression;
*************************************;

length _WARN_ $4;
label _WARN_ = 'Warnings' ;

length I_RESPOND $ 3;
label I_RESPOND = 'Into: RESPOND' ;
*** Target Values;
array REGDRF [2] $3 _temporary_ ('YES' 'NO' );
label U_RESPOND = 'Unnormalized Into: RESPOND' ;
format U_RESPOND $3.;
length U_RESPOND $ 3;
*** Unnormalized target values;
array REGDRU[2] $ 3 _temporary_ ('yes'  'no ' );

*** Generate dummy variables for RESPOND ;
drop _Y ;
label F_RESPOND = 'From: RESPOND' ;
length F_RESPOND $ 3;
F_RESPOND = put( RESPOND , $3. );
%DMNORMIP( F_RESPOND )
if missing( RESPOND ) then do;
   _Y = .;
end;
else do;
   if F_RESPOND = 'NO'  then do;
      _Y = 1;
   end;
   else if F_RESPOND = 'YES'  then do;
      _Y = 0;
   end;
   else do;
      _Y = .;
   end;
end;

drop _DM_BAD;
_DM_BAD=0;

*** Check AGE for missing values ;
if missing( AGE ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check CAMPAIGN for missing values ;
if missing( CAMPAIGN ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check CCI for missing values ;
if missing( CCI ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check CPI for missing values ;
if missing( CPI ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check DURATION for missing values ;
if missing( DURATION ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check EMPVAR for missing values ;
if missing( EMPVAR ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check EURIBOR3M for missing values ;
if missing( EURIBOR3M ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check PDAYS for missing values ;
if missing( PDAYS ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check PREVIOUS for missing values ;
if missing( PREVIOUS ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Generate dummy variables for CONTACT ;
drop _1_0 ;
if missing( CONTACT ) then do;
   _1_0 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm9 $ 9; drop _dm9 ;
   _dm9 = put( CONTACT , $9. );
   %DMNORMIP( _dm9 )
   if _dm9 = 'CELLULAR'  then do;
      _1_0 = 1;
   end;
   else if _dm9 = 'TELEPHONE'  then do;
      _1_0 = -1;
   end;
   else do;
      _1_0 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for DEFAULT ;
drop _2_0 _2_1 ;
if missing( DEFAULT ) then do;
   _2_0 = .;
   _2_1 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm7 $ 7; drop _dm7 ;
   _dm7 = put( DEFAULT , $7. );
   %DMNORMIP( _dm7 )
   if _dm7 = 'NO'  then do;
      _2_0 = 1;
      _2_1 = 0;
   end;
   else if _dm7 = 'UNKNOWN'  then do;
      _2_0 = 0;
      _2_1 = 1;
   end;
   else if _dm7 = 'YES'  then do;
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

*** Generate dummy variables for DOW ;
drop _3_0 _3_1 _3_2 _3_3 ;
*** encoding is sparse, initialize to zero;
_3_0 = 0;
_3_1 = 0;
_3_2 = 0;
_3_3 = 0;
if missing( DOW ) then do;
   _3_0 = .;
   _3_1 = .;
   _3_2 = .;
   _3_3 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm3 $ 3; drop _dm3 ;
   _dm3 = put( DOW , $3. );
   %DMNORMIP( _dm3 )
   _dm_find = 0; drop _dm_find;
   if _dm3 <= 'THU'  then do;
      if _dm3 <= 'MON'  then do;
         if _dm3 = 'FRI'  then do;
            _3_0 = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm3 = 'MON'  then do;
               _3_1 = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm3 = 'THU'  then do;
            _3_2 = 1;
            _dm_find = 1;
         end;
      end;
   end;
   else do;
      if _dm3 = 'TUE'  then do;
         _3_3 = 1;
         _dm_find = 1;
      end;
      else do;
         if _dm3 = 'WED'  then do;
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

*** Generate dummy variables for EDUCATION ;
drop _4_0 _4_1 _4_2 _4_3 _4_4 _4_5 _4_6 ;
*** encoding is sparse, initialize to zero;
_4_0 = 0;
_4_1 = 0;
_4_2 = 0;
_4_3 = 0;
_4_4 = 0;
_4_5 = 0;
_4_6 = 0;
if missing( EDUCATION ) then do;
   _4_0 = .;
   _4_1 = .;
   _4_2 = .;
   _4_3 = .;
   _4_4 = .;
   _4_5 = .;
   _4_6 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm19 $ 19; drop _dm19 ;
   _dm19 = put( EDUCATION , $19. );
   %DMNORMIP( _dm19 )
   if _dm19 = 'UNIVERSITY.DEGREE'  then do;
      _4_6 = 1;
   end;
   else if _dm19 = 'HIGH.SCHOOL'  then do;
      _4_3 = 1;
   end;
   else if _dm19 = 'BASIC.9Y'  then do;
      _4_2 = 1;
   end;
   else if _dm19 = 'PROFESSIONAL.COURSE'  then do;
      _4_5 = 1;
   end;
   else if _dm19 = 'BASIC.4Y'  then do;
      _4_0 = 1;
   end;
   else if _dm19 = 'BASIC.6Y'  then do;
      _4_1 = 1;
   end;
   else if _dm19 = 'UNKNOWN'  then do;
      _4_0 = -1;
      _4_1 = -1;
      _4_2 = -1;
      _4_3 = -1;
      _4_4 = -1;
      _4_5 = -1;
      _4_6 = -1;
   end;
   else if _dm19 = 'ILLITERATE'  then do;
      _4_4 = 1;
   end;
   else do;
      _4_0 = .;
      _4_1 = .;
      _4_2 = .;
      _4_3 = .;
      _4_4 = .;
      _4_5 = .;
      _4_6 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for HOUSING ;
drop _5_0 _5_1 ;
if missing( HOUSING ) then do;
   _5_0 = .;
   _5_1 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm7 $ 7; drop _dm7 ;
   _dm7 = put( HOUSING , $7. );
   %DMNORMIP( _dm7 )
   if _dm7 = 'YES'  then do;
      _5_0 = -1;
      _5_1 = -1;
   end;
   else if _dm7 = 'NO'  then do;
      _5_0 = 1;
      _5_1 = 0;
   end;
   else if _dm7 = 'UNKNOWN'  then do;
      _5_0 = 0;
      _5_1 = 1;
   end;
   else do;
      _5_0 = .;
      _5_1 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for JOB ;
drop _6_0 _6_1 _6_2 _6_3 _6_4 _6_5 _6_6 _6_7 _6_8 _6_9 _6_10 ;
*** encoding is sparse, initialize to zero;
_6_0 = 0;
_6_1 = 0;
_6_2 = 0;
_6_3 = 0;
_6_4 = 0;
_6_5 = 0;
_6_6 = 0;
_6_7 = 0;
_6_8 = 0;
_6_9 = 0;
_6_10 = 0;
if missing( JOB ) then do;
   _6_0 = .;
   _6_1 = .;
   _6_2 = .;
   _6_3 = .;
   _6_4 = .;
   _6_5 = .;
   _6_6 = .;
   _6_7 = .;
   _6_8 = .;
   _6_9 = .;
   _6_10 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm13 $ 13; drop _dm13 ;
   _dm13 = put( JOB , $13. );
   %DMNORMIP( _dm13 )
   _dm_find = 0; drop _dm_find;
   if _dm13 <= 'RETIRED'  then do;
      if _dm13 <= 'ENTREPRENEUR'  then do;
         if _dm13 <= 'BLUE-COLLAR'  then do;
            if _dm13 = 'ADMIN.'  then do;
               _6_0 = 1;
               _dm_find = 1;
            end;
            else do;
               if _dm13 = 'BLUE-COLLAR'  then do;
                  _6_1 = 1;
                  _dm_find = 1;
               end;
            end;
         end;
         else do;
            if _dm13 = 'ENTREPRENEUR'  then do;
               _6_2 = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm13 <= 'MANAGEMENT'  then do;
            if _dm13 = 'HOUSEMAID'  then do;
               _6_3 = 1;
               _dm_find = 1;
            end;
            else do;
               if _dm13 = 'MANAGEMENT'  then do;
                  _6_4 = 1;
                  _dm_find = 1;
               end;
            end;
         end;
         else do;
            if _dm13 = 'RETIRED'  then do;
               _6_5 = 1;
               _dm_find = 1;
            end;
         end;
      end;
   end;
   else do;
      if _dm13 <= 'STUDENT'  then do;
         if _dm13 <= 'SERVICES'  then do;
            if _dm13 = 'SELF-EMPLOYED'  then do;
               _6_6 = 1;
               _dm_find = 1;
            end;
            else do;
               if _dm13 = 'SERVICES'  then do;
                  _6_7 = 1;
                  _dm_find = 1;
               end;
            end;
         end;
         else do;
            if _dm13 = 'STUDENT'  then do;
               _6_8 = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm13 <= 'UNEMPLOYED'  then do;
            if _dm13 = 'TECHNICIAN'  then do;
               _6_9 = 1;
               _dm_find = 1;
            end;
            else do;
               if _dm13 = 'UNEMPLOYED'  then do;
                  _6_10 = 1;
                  _dm_find = 1;
               end;
            end;
         end;
         else do;
            if _dm13 = 'UNKNOWN'  then do;
               _6_0 = -1;
               _6_1 = -1;
               _6_2 = -1;
               _6_3 = -1;
               _6_4 = -1;
               _6_5 = -1;
               _6_6 = -1;
               _6_7 = -1;
               _6_8 = -1;
               _6_9 = -1;
               _6_10 = -1;
               _dm_find = 1;
            end;
         end;
      end;
   end;
   if not _dm_find then do;
      _6_0 = .;
      _6_1 = .;
      _6_2 = .;
      _6_3 = .;
      _6_4 = .;
      _6_5 = .;
      _6_6 = .;
      _6_7 = .;
      _6_8 = .;
      _6_9 = .;
      _6_10 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for LOAN ;
drop _7_0 _7_1 ;
if missing( LOAN ) then do;
   _7_0 = .;
   _7_1 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm7 $ 7; drop _dm7 ;
   _dm7 = put( LOAN , $7. );
   %DMNORMIP( _dm7 )
   if _dm7 = 'NO'  then do;
      _7_0 = 1;
      _7_1 = 0;
   end;
   else if _dm7 = 'YES'  then do;
      _7_0 = -1;
      _7_1 = -1;
   end;
   else if _dm7 = 'UNKNOWN'  then do;
      _7_0 = 0;
      _7_1 = 1;
   end;
   else do;
      _7_0 = .;
      _7_1 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for MARITAL ;
drop _8_0 _8_1 _8_2 ;
if missing( MARITAL ) then do;
   _8_0 = .;
   _8_1 = .;
   _8_2 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm8 $ 8; drop _dm8 ;
   _dm8 = put( MARITAL , $8. );
   %DMNORMIP( _dm8 )
   if _dm8 = 'MARRIED'  then do;
      _8_0 = 0;
      _8_1 = 1;
      _8_2 = 0;
   end;
   else if _dm8 = 'SINGLE'  then do;
      _8_0 = 0;
      _8_1 = 0;
      _8_2 = 1;
   end;
   else if _dm8 = 'DIVORCED'  then do;
      _8_0 = 1;
      _8_1 = 0;
      _8_2 = 0;
   end;
   else if _dm8 = 'UNKNOWN'  then do;
      _8_0 = -1;
      _8_1 = -1;
      _8_2 = -1;
   end;
   else do;
      _8_0 = .;
      _8_1 = .;
      _8_2 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for MONTH ;
drop _9_0 _9_1 _9_2 _9_3 _9_4 _9_5 _9_6 _9_7 _9_8 ;
*** encoding is sparse, initialize to zero;
_9_0 = 0;
_9_1 = 0;
_9_2 = 0;
_9_3 = 0;
_9_4 = 0;
_9_5 = 0;
_9_6 = 0;
_9_7 = 0;
_9_8 = 0;
if missing( MONTH ) then do;
   _9_0 = .;
   _9_1 = .;
   _9_2 = .;
   _9_3 = .;
   _9_4 = .;
   _9_5 = .;
   _9_6 = .;
   _9_7 = .;
   _9_8 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm3 $ 3; drop _dm3 ;
   _dm3 = put( MONTH , $3. );
   %DMNORMIP( _dm3 )
   _dm_find = 0; drop _dm_find;
   if _dm3 <= 'JUN'  then do;
      if _dm3 <= 'DEC'  then do;
         if _dm3 <= 'AUG'  then do;
            if _dm3 = 'APR'  then do;
               _9_0 = 1;
               _dm_find = 1;
            end;
            else do;
               if _dm3 = 'AUG'  then do;
                  _9_1 = 1;
                  _dm_find = 1;
               end;
            end;
         end;
         else do;
            if _dm3 = 'DEC'  then do;
               _9_2 = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm3 = 'JUL'  then do;
            _9_3 = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm3 = 'JUN'  then do;
               _9_4 = 1;
               _dm_find = 1;
            end;
         end;
      end;
   end;
   else do;
      if _dm3 <= 'NOV'  then do;
         if _dm3 <= 'MAY'  then do;
            if _dm3 = 'MAR'  then do;
               _9_5 = 1;
               _dm_find = 1;
            end;
            else do;
               if _dm3 = 'MAY'  then do;
                  _9_6 = 1;
                  _dm_find = 1;
               end;
            end;
         end;
         else do;
            if _dm3 = 'NOV'  then do;
               _9_7 = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm3 = 'OCT'  then do;
            _9_8 = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm3 = 'SEP'  then do;
               _9_0 = -1;
               _9_1 = -1;
               _9_2 = -1;
               _9_3 = -1;
               _9_4 = -1;
               _9_5 = -1;
               _9_6 = -1;
               _9_7 = -1;
               _9_8 = -1;
               _dm_find = 1;
            end;
         end;
      end;
   end;
   if not _dm_find then do;
      _9_0 = .;
      _9_1 = .;
      _9_2 = .;
      _9_3 = .;
      _9_4 = .;
      _9_5 = .;
      _9_6 = .;
      _9_7 = .;
      _9_8 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for POUTCOME ;
drop _10_0 _10_1 ;
if missing( POUTCOME ) then do;
   _10_0 = .;
   _10_1 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm11 $ 11; drop _dm11 ;
   _dm11 = put( POUTCOME , $11. );
   %DMNORMIP( _dm11 )
   if _dm11 = 'NONEXISTENT'  then do;
      _10_0 = 0;
      _10_1 = 1;
   end;
   else if _dm11 = 'FAILURE'  then do;
      _10_0 = 1;
      _10_1 = 0;
   end;
   else if _dm11 = 'SUCCESS'  then do;
      _10_0 = -1;
      _10_1 = -1;
   end;
   else do;
      _10_0 = .;
      _10_1 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** If missing inputs, use averages;
if _DM_BAD > 0 then do;
   _P0 = 0.1126897389;
   _P1 = 0.8873102611;
   goto REGDR1;
end;

*** Compute Linear Predictor;
drop _TEMP;
drop _LP0 ;
_LP0 = 0;

***  Effect: AGE ;
_TEMP = AGE ;
_LP0 = _LP0 + (   -0.00086255790888 * _TEMP);

***  Effect: CAMPAIGN ;
_TEMP = CAMPAIGN ;
_LP0 = _LP0 + (   -0.02099482654831 * _TEMP);

***  Effect: CCI ;
_TEMP = CCI ;
_LP0 = _LP0 + (    0.00966181512116 * _TEMP);

***  Effect: CONTACT ;
_TEMP = 1;
_LP0 = _LP0 + (    0.34412995159437) * _TEMP * _1_0;

***  Effect: CPI ;
_TEMP = CPI ;
_LP0 = _LP0 + (    1.86589596673436 * _TEMP);

***  Effect: DEFAULT ;
_TEMP = 1;
_LP0 = _LP0 + (    0.48135837353471) * _TEMP * _2_0;
_LP0 = _LP0 + (    0.17342646314954) * _TEMP * _2_1;

***  Effect: DOW ;
_TEMP = 1;
_LP0 = _LP0 + (   -0.10522544233072) * _TEMP * _3_0;
_LP0 = _LP0 + (   -0.21459327546707) * _TEMP * _3_1;
_LP0 = _LP0 + (    0.06000715205421) * _TEMP * _3_2;
_LP0 = _LP0 + (    0.12768079932403) * _TEMP * _3_3;

***  Effect: DURATION ;
_TEMP = DURATION ;
_LP0 = _LP0 + (    0.00481156012372 * _TEMP);

***  Effect: EDUCATION ;
_TEMP = 1;
_LP0 = _LP0 + (   -0.01413251022748) * _TEMP * _4_0;
_LP0 = _LP0 + (   -0.08926850248974) * _TEMP * _4_1;
_LP0 = _LP0 + (   -0.19199667943291) * _TEMP * _4_2;
_LP0 = _LP0 + (   -0.00327414722506) * _TEMP * _4_3;
_LP0 = _LP0 + (    0.75266918024701) * _TEMP * _4_4;
_LP0 = _LP0 + (   -0.25373174485795) * _TEMP * _4_5;
_LP0 = _LP0 + (   -0.00563391179961) * _TEMP * _4_6;

***  Effect: EMPVAR ;
_TEMP = EMPVAR ;
_LP0 = _LP0 + (   -1.68207774014656 * _TEMP);

***  Effect: EURIBOR3M ;
_TEMP = EURIBOR3M ;
_LP0 = _LP0 + (    0.54560767322655 * _TEMP);

***  Effect: HOUSING ;
_TEMP = 1;
_LP0 = _LP0 + (     0.1433515608364) * _TEMP * _5_0;
_LP0 = _LP0 + (   -0.22137929682428) * _TEMP * _5_1;

***  Effect: JOB ;
_TEMP = 1;
_LP0 = _LP0 + (   -0.11816981425879) * _TEMP * _6_0;
_LP0 = _LP0 + (   -0.15355678485249) * _TEMP * _6_1;
_LP0 = _LP0 + (   -0.30421718242277) * _TEMP * _6_2;
_LP0 = _LP0 + (   -0.24856057472667) * _TEMP * _6_3;
_LP0 = _LP0 + (   -0.24095877214035) * _TEMP * _6_4;
_LP0 = _LP0 + (    0.21845465483391) * _TEMP * _6_5;
_LP0 = _LP0 + (    0.14487114983468) * _TEMP * _6_6;
_LP0 = _LP0 + (   -0.15620688044978) * _TEMP * _6_7;
_LP0 = _LP0 + (    0.18852444456647) * _TEMP * _6_8;
_LP0 = _LP0 + (    0.18113691030971) * _TEMP * _6_9;
_LP0 = _LP0 + (   -0.21574097696709) * _TEMP * _6_10;

***  Effect: LOAN ;
_TEMP = 1;
_LP0 = _LP0 + (    0.05200727771158) * _TEMP * _7_0;
_LP0 = _LP0 + (                   0) * _TEMP * _7_1;

***  Effect: MARITAL ;
_TEMP = 1;
_LP0 = _LP0 + (    0.15676988547107) * _TEMP * _8_0;
_LP0 = _LP0 + (    0.08358014153424) * _TEMP * _8_1;
_LP0 = _LP0 + (    0.07530046186828) * _TEMP * _8_2;

***  Effect: MONTH ;
_TEMP = 1;
_LP0 = _LP0 + (   -0.04919758761359) * _TEMP * _9_0;
_LP0 = _LP0 + (    0.48323175530607) * _TEMP * _9_1;
_LP0 = _LP0 + (    0.17646503391584) * _TEMP * _9_2;
_LP0 = _LP0 + (   -0.11395990401056) * _TEMP * _9_3;
_LP0 = _LP0 + (    -0.6469003961032) * _TEMP * _9_4;
_LP0 = _LP0 + (     1.8664127988545) * _TEMP * _9_5;
_LP0 = _LP0 + (   -0.71294312562006) * _TEMP * _9_6;
_LP0 = _LP0 + (   -0.71534917923175) * _TEMP * _9_7;
_LP0 = _LP0 + (   -0.23819384121181) * _TEMP * _9_8;

***  Effect: PDAYS ;
_TEMP = PDAYS ;
_LP0 = _LP0 + (    -0.0011197699243 * _TEMP);

***  Effect: POUTCOME ;
_TEMP = 1;
_LP0 = _LP0 + (    -0.4824224814171) * _TEMP * _10_0;
_LP0 = _LP0 + (   -0.06685048689163) * _TEMP * _10_1;

***  Effect: PREVIOUS ;
_TEMP = PREVIOUS ;
_LP0 = _LP0 + (   -0.19298480816293 * _TEMP);

*** Naive Posterior Probabilities;
drop _MAXP _IY _P0 _P1;
drop _LPMAX;
_LPMAX= 0;
_LP0 =    -179.449803049407 + _LP0;
if _LPMAX < _LP0 then _LPMAX = _LP0;
_LP0 = exp(_LP0 - _LPMAX);
_LPMAX = exp(-_LPMAX);
_P1 = 1 / (_LPMAX + _LP0);
_P0 = _LP0 * _P1;
_P1 = _LPMAX * _P1;

REGDR1:

*** Residuals;
if (_Y = .) then do;
   R_RESPONDyes = .;
   R_RESPONDno = .;
end;
else do;
    label R_RESPONDyes = 'Residual: RESPOND=yes' ;
    label R_RESPONDno = 'Residual: RESPOND=no' ;
   R_RESPONDyes = - _P0;
   R_RESPONDno = - _P1;
   select( _Y );
      when (0)  R_RESPONDyes = R_RESPONDyes + 1;
      when (1)  R_RESPONDno = R_RESPONDno + 1;
   end;
end;

*** Posterior Probabilities and Predicted Level;
label P_RESPONDyes = 'Predicted: RESPOND=yes' ;
label P_RESPONDno = 'Predicted: RESPOND=no' ;
P_RESPONDyes = _P0;
_MAXP = _P0;
_IY = 1;
P_RESPONDno = _P1;
if (_P1 >  _MAXP + 1E-8) then do;
   _MAXP = _P1;
   _IY = 2;
end;
I_RESPOND = REGDRF[_IY];
U_RESPOND = REGDRU[_IY];

*************************************;
***** end scoring code for regression;
*************************************;