****************************************************************;
******             DECISION TREE SCORING CODE             ******;
****************************************************************;
 
******         LENGTHS OF NEW CHARACTER VARIABLES         ******;
LENGTH I_TargetBuy  $   12;
LENGTH _WARN_  $    4;
 
******              LABELS FOR NEW VARIABLES              ******;
label _NODE_ = 'Node' ;
label _LEAF_ = 'Leaf' ;
label P_TargetBuy0 = 'Predicted: TargetBuy=0' ;
label P_TargetBuy1 = 'Predicted: TargetBuy=1' ;
label Q_TargetBuy0 = 'Unadjusted P: TargetBuy=0' ;
label Q_TargetBuy1 = 'Unadjusted P: TargetBuy=1' ;
label V_TargetBuy0 = 'Validated: TargetBuy=0' ;
label V_TargetBuy1 = 'Validated: TargetBuy=1' ;
label I_TargetBuy = 'Into: TargetBuy' ;
label U_TargetBuy = 'Unnormalized Into: TargetBuy' ;
label _WARN_ = 'Warnings' ;
 
 
******      TEMPORARY VARIABLES FOR FORMATTED VALUES      ******;
LENGTH _ARBFMT_12 $     12; DROP _ARBFMT_12;
_ARBFMT_12 = ' '; /* Initialize to avoid warning. */
LENGTH _ARBFMT_1 $      1; DROP _ARBFMT_1;
_ARBFMT_1 = ' '; /* Initialize to avoid warning. */
 
 
******             ASSIGN OBSERVATION TO NODE             ******;
IF  NOT MISSING(DemAge ) AND
  DemAge  <                 39.5 THEN DO;
  IF  NOT MISSING(DemAffl ) AND
    DemAffl  <                  6.5 THEN DO;
    _NODE_  =                    6;
    _LEAF_  =                    1;
    P_TargetBuy0  =      0.6593886462882;
    P_TargetBuy1  =     0.34061135371179;
    Q_TargetBuy0  =      0.6593886462882;
    Q_TargetBuy1  =     0.34061135371179;
    V_TargetBuy0  =     0.66009852216748;
    V_TargetBuy1  =     0.33990147783251;
    I_TargetBuy  = '0' ;
    U_TargetBuy  =                    0;
    END;
  ELSE IF  NOT MISSING(DemAffl ) AND
                     6.5 <= DemAffl  AND
    DemAffl  <                  9.5 THEN DO;
    _ARBFMT_1 = PUT( DemGender , $1.);
     %DMNORMIP( _ARBFMT_1);
    IF _ARBFMT_1 IN ('F' ) THEN DO;
      _NODE_  =                   21;
      _LEAF_  =                    2;
      P_TargetBuy0  =     0.38405797101449;
      P_TargetBuy1  =      0.6159420289855;
      Q_TargetBuy0  =     0.38405797101449;
      Q_TargetBuy1  =      0.6159420289855;
      V_TargetBuy0  =     0.41121495327102;
      V_TargetBuy1  =     0.58878504672897;
      I_TargetBuy  = '1' ;
      U_TargetBuy  =                    1;
      END;
    ELSE IF _ARBFMT_1 IN ('M' ) THEN DO;
      _NODE_  =                   22;
      _LEAF_  =                    3;
      P_TargetBuy0  =     0.58878504672897;
      P_TargetBuy1  =     0.41121495327102;
      Q_TargetBuy0  =     0.58878504672897;
      Q_TargetBuy1  =     0.41121495327102;
      V_TargetBuy0  =     0.59210526315789;
      V_TargetBuy1  =      0.4078947368421;
      I_TargetBuy  = '0' ;
      U_TargetBuy  =                    0;
      END;
    ELSE DO;
      _NODE_  =                   23;
      _LEAF_  =                    4;
      P_TargetBuy0  =     0.81395348837209;
      P_TargetBuy1  =      0.1860465116279;
      Q_TargetBuy0  =     0.81395348837209;
      Q_TargetBuy1  =      0.1860465116279;
      V_TargetBuy0  =     0.88679245283018;
      V_TargetBuy1  =     0.11320754716981;
      I_TargetBuy  = '0' ;
      U_TargetBuy  =                    0;
      END;
    END;
  ELSE IF  NOT MISSING(DemAffl ) AND
                    12.5 <= DemAffl  THEN DO;
    _NODE_  =                    9;
    _LEAF_  =                    7;
    P_TargetBuy0  =     0.13409961685823;
    P_TargetBuy1  =     0.86590038314176;
    Q_TargetBuy0  =     0.13409961685823;
    Q_TargetBuy1  =     0.86590038314176;
    V_TargetBuy0  =     0.11206896551724;
    V_TargetBuy1  =     0.88793103448275;
    I_TargetBuy  = '1' ;
    U_TargetBuy  =                    1;
    END;
  ELSE DO;
    _ARBFMT_1 = PUT( DemGender , $1.);
     %DMNORMIP( _ARBFMT_1);
    IF _ARBFMT_1 IN ('F' ) THEN DO;
      _NODE_  =                   24;
      _LEAF_  =                    5;
      P_TargetBuy0  =     0.23220973782771;
      P_TargetBuy1  =     0.76779026217228;
      Q_TargetBuy0  =     0.23220973782771;
      Q_TargetBuy1  =     0.76779026217228;
      V_TargetBuy0  =     0.21319796954314;
      V_TargetBuy1  =     0.78680203045685;
      I_TargetBuy  = '1' ;
      U_TargetBuy  =                    1;
      END;
    ELSE DO;
      _NODE_  =                   25;
      _LEAF_  =                    6;
      P_TargetBuy0  =     0.52032520325203;
      P_TargetBuy1  =     0.47967479674796;
      Q_TargetBuy0  =     0.52032520325203;
      Q_TargetBuy1  =     0.47967479674796;
      V_TargetBuy0  =     0.55963302752293;
      V_TargetBuy1  =     0.44036697247706;
      I_TargetBuy  = '0' ;
      U_TargetBuy  =                    0;
      END;
    END;
  END;
ELSE IF  NOT MISSING(DemAge ) AND
                  39.5 <= DemAge  AND
  DemAge  <                 44.5 THEN DO;
  IF  NOT MISSING(DemAffl ) AND
    DemAffl  <                  6.5 THEN DO;
    _NODE_  =                   10;
    _LEAF_  =                    8;
    P_TargetBuy0  =     0.80346820809248;
    P_TargetBuy1  =     0.19653179190751;
    Q_TargetBuy0  =     0.80346820809248;
    Q_TargetBuy1  =     0.19653179190751;
    V_TargetBuy0  =     0.78030303030303;
    V_TargetBuy1  =     0.21969696969696;
    I_TargetBuy  = '0' ;
    U_TargetBuy  =                    0;
    END;
  ELSE IF  NOT MISSING(DemAffl ) AND
                     6.5 <= DemAffl  AND
    DemAffl  <                  9.5 THEN DO;
    _ARBFMT_1 = PUT( DemGender , $1.);
     %DMNORMIP( _ARBFMT_1);
    IF _ARBFMT_1 IN ('F' ) THEN DO;
      _NODE_  =                   29;
      _LEAF_  =                    9;
      P_TargetBuy0  =     0.57516339869281;
      P_TargetBuy1  =     0.42483660130718;
      Q_TargetBuy0  =     0.57516339869281;
      Q_TargetBuy1  =     0.42483660130718;
      V_TargetBuy0  =     0.58407079646017;
      V_TargetBuy1  =     0.41592920353982;
      I_TargetBuy  = '0' ;
      U_TargetBuy  =                    0;
      END;
    ELSE DO;
      _NODE_  =                   30;
      _LEAF_  =                   10;
      P_TargetBuy0  =     0.80869565217391;
      P_TargetBuy1  =     0.19130434782608;
      Q_TargetBuy0  =     0.80869565217391;
      Q_TargetBuy1  =     0.19130434782608;
      V_TargetBuy0  =     0.82716049382716;
      V_TargetBuy1  =     0.17283950617283;
      I_TargetBuy  = '0' ;
      U_TargetBuy  =                    0;
      END;
    END;
  ELSE IF  NOT MISSING(DemAffl ) AND
                    11.5 <= DemAffl  THEN DO;
    _ARBFMT_1 = PUT( DemGender , $1.);
     %DMNORMIP( _ARBFMT_1);
    IF _ARBFMT_1 IN ('F' ) THEN DO;
      _NODE_  =                   33;
      _LEAF_  =                   13;
      P_TargetBuy0  =      0.2063492063492;
      P_TargetBuy1  =     0.79365079365079;
      Q_TargetBuy0  =      0.2063492063492;
      Q_TargetBuy1  =     0.79365079365079;
      V_TargetBuy0  =     0.32142857142857;
      V_TargetBuy1  =     0.67857142857142;
      I_TargetBuy  = '1' ;
      U_TargetBuy  =                    1;
      END;
    ELSE DO;
      _NODE_  =                   34;
      _LEAF_  =                   14;
      P_TargetBuy0  =     0.49056603773584;
      P_TargetBuy1  =     0.50943396226415;
      Q_TargetBuy0  =     0.49056603773584;
      Q_TargetBuy1  =     0.50943396226415;
      V_TargetBuy0  =     0.46511627906976;
      V_TargetBuy1  =     0.53488372093023;
      I_TargetBuy  = '1' ;
      U_TargetBuy  =                    1;
      END;
    END;
  ELSE DO;
    _ARBFMT_1 = PUT( DemGender , $1.);
     %DMNORMIP( _ARBFMT_1);
    IF _ARBFMT_1 IN ('F' ) THEN DO;
      _NODE_  =                   31;
      _LEAF_  =                   11;
      P_TargetBuy0  =     0.45762711864406;
      P_TargetBuy1  =     0.54237288135593;
      Q_TargetBuy0  =     0.45762711864406;
      Q_TargetBuy1  =     0.54237288135593;
      V_TargetBuy0  =     0.33783783783783;
      V_TargetBuy1  =     0.66216216216216;
      I_TargetBuy  = '1' ;
      U_TargetBuy  =                    1;
      END;
    ELSE DO;
      _NODE_  =                   32;
      _LEAF_  =                   12;
      P_TargetBuy0  =     0.71428571428571;
      P_TargetBuy1  =     0.28571428571428;
      Q_TargetBuy0  =     0.71428571428571;
      Q_TargetBuy1  =     0.28571428571428;
      V_TargetBuy0  =     0.68115942028985;
      V_TargetBuy1  =     0.31884057971014;
      I_TargetBuy  = '0' ;
      U_TargetBuy  =                    0;
      END;
    END;
  END;
ELSE IF  NOT MISSING(DemAge ) AND
                  44.5 <= DemAge  AND
  DemAge  <                 76.5 THEN DO;
  IF  NOT MISSING(DemAffl ) AND
    DemAffl  <                  8.5 THEN DO;
    _ARBFMT_1 = PUT( DemGender , $1.);
     %DMNORMIP( _ARBFMT_1);
    IF _ARBFMT_1 IN ('F' ) THEN DO;
      IF  NOT MISSING(DemAffl ) AND
        DemAffl  <                  5.5 THEN DO;
        _NODE_  =                   50;
        _LEAF_  =                   15;
        P_TargetBuy0  =     0.94455445544554;
        P_TargetBuy1  =     0.05544554455445;
        Q_TargetBuy0  =     0.94455445544554;
        Q_TargetBuy1  =     0.05544554455445;
        V_TargetBuy0  =      0.9421965317919;
        V_TargetBuy1  =     0.05780346820809;
        I_TargetBuy  = '0' ;
        U_TargetBuy  =                    0;
        END;
      ELSE DO;
        _NODE_  =                   51;
        _LEAF_  =                   16;
        P_TargetBuy0  =     0.83933787731256;
        P_TargetBuy1  =     0.16066212268743;
        Q_TargetBuy0  =     0.83933787731256;
        Q_TargetBuy1  =     0.16066212268743;
        V_TargetBuy0  =     0.87733333333333;
        V_TargetBuy1  =     0.12266666666666;
        I_TargetBuy  = '0' ;
        U_TargetBuy  =                    0;
        END;
      END;
    ELSE IF _ARBFMT_1 IN ('M' ) THEN DO;
      _NODE_  =                   36;
      _LEAF_  =                   17;
      P_TargetBuy0  =     0.94970760233918;
      P_TargetBuy1  =     0.05029239766081;
      Q_TargetBuy0  =     0.94970760233918;
      Q_TargetBuy1  =     0.05029239766081;
      V_TargetBuy0  =     0.95555555555555;
      V_TargetBuy1  =     0.04444444444444;
      I_TargetBuy  = '0' ;
      U_TargetBuy  =                    0;
      END;
    ELSE DO;
      _NODE_  =                   37;
      _LEAF_  =                   18;
      P_TargetBuy0  =     0.98405797101449;
      P_TargetBuy1  =      0.0159420289855;
      Q_TargetBuy0  =     0.98405797101449;
      Q_TargetBuy1  =      0.0159420289855;
      V_TargetBuy0  =     0.98003992015968;
      V_TargetBuy1  =     0.01996007984031;
      I_TargetBuy  = '0' ;
      U_TargetBuy  =                    0;
      END;
    END;
  ELSE IF  NOT MISSING(DemAffl ) AND
                    12.5 <= DemAffl  AND
    DemAffl  <                 16.5 THEN DO;
    _ARBFMT_1 = PUT( DemGender , $1.);
     %DMNORMIP( _ARBFMT_1);
    IF _ARBFMT_1 IN ('F' ) THEN DO;
      _NODE_  =                   42;
      _LEAF_  =                   24;
      P_TargetBuy0  =     0.51301115241635;
      P_TargetBuy1  =     0.48698884758364;
      Q_TargetBuy0  =     0.51301115241635;
      Q_TargetBuy1  =     0.48698884758364;
      V_TargetBuy0  =     0.55707762557077;
      V_TargetBuy1  =     0.44292237442922;
      I_TargetBuy  = '0' ;
      U_TargetBuy  =                    0;
      END;
    ELSE DO;
      _NODE_  =                   43;
      _LEAF_  =                   25;
      P_TargetBuy0  =     0.82258064516129;
      P_TargetBuy1  =      0.1774193548387;
      Q_TargetBuy0  =     0.82258064516129;
      Q_TargetBuy1  =      0.1774193548387;
      V_TargetBuy0  =     0.74834437086092;
      V_TargetBuy1  =     0.25165562913907;
      I_TargetBuy  = '0' ;
      U_TargetBuy  =                    0;
      END;
    END;
  ELSE IF  NOT MISSING(DemAffl ) AND
                    16.5 <= DemAffl  THEN DO;
    _NODE_  =                   17;
    _LEAF_  =                   26;
    P_TargetBuy0  =     0.22784810126582;
    P_TargetBuy1  =     0.77215189873417;
    Q_TargetBuy0  =     0.22784810126582;
    Q_TargetBuy1  =     0.77215189873417;
    V_TargetBuy0  =     0.28571428571428;
    V_TargetBuy1  =     0.71428571428571;
    I_TargetBuy  = '1' ;
    U_TargetBuy  =                    1;
    END;
  ELSE DO;
    _ARBFMT_1 = PUT( DemGender , $1.);
     %DMNORMIP( _ARBFMT_1);
    IF _ARBFMT_1 IN ('F' ) THEN DO;
      IF  NOT MISSING(DemAffl ) AND
                        10.5 <= DemAffl  THEN DO;
        _NODE_  =                   53;
        _LEAF_  =                   20;
        P_TargetBuy0  =     0.69174757281553;
        P_TargetBuy1  =     0.30825242718446;
        Q_TargetBuy0  =     0.69174757281553;
        Q_TargetBuy1  =     0.30825242718446;
        V_TargetBuy0  =     0.72068965517241;
        V_TargetBuy1  =     0.27931034482758;
        I_TargetBuy  = '0' ;
        U_TargetBuy  =                    0;
        END;
      ELSE DO;
        _NODE_  =                   52;
        _LEAF_  =                   19;
        P_TargetBuy0  =      0.8002512562814;
        P_TargetBuy1  =     0.19974874371859;
        Q_TargetBuy0  =      0.8002512562814;
        Q_TargetBuy1  =     0.19974874371859;
        V_TargetBuy0  =     0.76923076923076;
        V_TargetBuy1  =     0.23076923076923;
        I_TargetBuy  = '0' ;
        U_TargetBuy  =                    0;
        END;
      END;
    ELSE IF _ARBFMT_1 IN ('M' ) THEN DO;
      _NODE_  =                   39;
      _LEAF_  =                   21;
      P_TargetBuy0  =     0.87738853503184;
      P_TargetBuy1  =     0.12261146496815;
      Q_TargetBuy0  =     0.87738853503184;
      Q_TargetBuy1  =     0.12261146496815;
      V_TargetBuy0  =                  0.9;
      V_TargetBuy1  =                  0.1;
      I_TargetBuy  = '0' ;
      U_TargetBuy  =                    0;
      END;
    ELSE IF _ARBFMT_1 IN ('U' ) THEN DO;
      _NODE_  =                   40;
      _LEAF_  =                   22;
      P_TargetBuy0  =     0.95652173913043;
      P_TargetBuy1  =     0.04347826086956;
      Q_TargetBuy0  =     0.95652173913043;
      Q_TargetBuy1  =     0.04347826086956;
      V_TargetBuy0  =     0.94482758620689;
      V_TargetBuy1  =      0.0551724137931;
      I_TargetBuy  = '0' ;
      U_TargetBuy  =                    0;
      END;
    ELSE DO;
      _NODE_  =                   41;
      _LEAF_  =                   23;
      P_TargetBuy0  =           0.92578125;
      P_TargetBuy1  =           0.07421875;
      Q_TargetBuy0  =           0.92578125;
      Q_TargetBuy1  =           0.07421875;
      V_TargetBuy0  =     0.94358974358974;
      V_TargetBuy1  =     0.05641025641025;
      I_TargetBuy  = '0' ;
      U_TargetBuy  =                    0;
      END;
    END;
  END;
ELSE DO;
  IF  NOT MISSING(DemAffl ) AND
    DemAffl  <                 10.5 THEN DO;
    _ARBFMT_1 = PUT( DemGender , $1.);
     %DMNORMIP( _ARBFMT_1);
    IF _ARBFMT_1 IN ('F' ) THEN DO;
      _NODE_  =                   44;
      _LEAF_  =                   27;
      P_TargetBuy0  =             0.759375;
      P_TargetBuy1  =             0.240625;
      Q_TargetBuy0  =             0.759375;
      Q_TargetBuy1  =             0.240625;
      V_TargetBuy0  =      0.7520325203252;
      V_TargetBuy1  =     0.24796747967479;
      I_TargetBuy  = '0' ;
      U_TargetBuy  =                    0;
      END;
    ELSE IF _ARBFMT_1 IN ('M' ) THEN DO;
      _NODE_  =                   45;
      _LEAF_  =                   28;
      P_TargetBuy0  =     0.85795454545454;
      P_TargetBuy1  =     0.14204545454545;
      Q_TargetBuy0  =     0.85795454545454;
      Q_TargetBuy1  =     0.14204545454545;
      V_TargetBuy0  =     0.90178571428571;
      V_TargetBuy1  =     0.09821428571428;
      I_TargetBuy  = '0' ;
      U_TargetBuy  =                    0;
      END;
    ELSE IF _ARBFMT_1 IN ('U' ) THEN DO;
      _NODE_  =                   46;
      _LEAF_  =                   29;
      P_TargetBuy0  =     0.98148148148148;
      P_TargetBuy1  =     0.01851851851851;
      Q_TargetBuy0  =     0.98148148148148;
      Q_TargetBuy1  =     0.01851851851851;
      V_TargetBuy0  =     0.94594594594594;
      V_TargetBuy1  =     0.05405405405405;
      I_TargetBuy  = '0' ;
      U_TargetBuy  =                    0;
      END;
    ELSE DO;
      _NODE_  =                   47;
      _LEAF_  =                   30;
      P_TargetBuy0  =     0.90277777777777;
      P_TargetBuy1  =     0.09722222222222;
      Q_TargetBuy0  =     0.90277777777777;
      Q_TargetBuy1  =     0.09722222222222;
      V_TargetBuy0  =     0.93333333333333;
      V_TargetBuy1  =     0.06666666666666;
      I_TargetBuy  = '0' ;
      U_TargetBuy  =                    0;
      END;
    END;
  ELSE IF  NOT MISSING(DemAffl ) AND
                    13.5 <= DemAffl  THEN DO;
    _NODE_  =                   20;
    _LEAF_  =                   33;
    P_TargetBuy0  =                 0.36;
    P_TargetBuy1  =                 0.64;
    Q_TargetBuy0  =                 0.36;
    Q_TargetBuy1  =                 0.64;
    V_TargetBuy0  =     0.46511627906976;
    V_TargetBuy1  =     0.53488372093023;
    I_TargetBuy  = '1' ;
    U_TargetBuy  =                    1;
    END;
  ELSE DO;
    _ARBFMT_1 = PUT( DemGender , $1.);
     %DMNORMIP( _ARBFMT_1);
    IF _ARBFMT_1 IN ('F' ) THEN DO;
      _NODE_  =                   48;
      _LEAF_  =                   31;
      P_TargetBuy0  =     0.49541284403669;
      P_TargetBuy1  =      0.5045871559633;
      Q_TargetBuy0  =     0.49541284403669;
      Q_TargetBuy1  =      0.5045871559633;
      V_TargetBuy0  =     0.56976744186046;
      V_TargetBuy1  =     0.43023255813953;
      I_TargetBuy  = '1' ;
      U_TargetBuy  =                    1;
      END;
    ELSE DO;
      _NODE_  =                   49;
      _LEAF_  =                   32;
      P_TargetBuy0  =     0.78873239436619;
      P_TargetBuy1  =      0.2112676056338;
      Q_TargetBuy0  =     0.78873239436619;
      Q_TargetBuy1  =      0.2112676056338;
      V_TargetBuy0  =     0.73333333333333;
      V_TargetBuy1  =     0.26666666666666;
      I_TargetBuy  = '0' ;
      U_TargetBuy  =                    0;
      END;
    END;
  END;
 
****************************************************************;
******          END OF DECISION TREE SCORING CODE         ******;
****************************************************************;
 
drop _LEAF_;
