$eolCom //         
set xidom          'Extraordinary input domains'  / UC_N UserConstraint, ALL_REG Region, ALLYEAR Period, PRC Process, COM_GRP Commodity, ALL_TS TimeSlice, LIM Limit Types, CUR Currencies/
    xodom          'Extraordinary output domains' /                      ALL_REG Region, ALLYEAR Period, PRC Process, COM_GRP Commodity, ALL_TS TimeSlice/
    typ            'symbol type'                  / 'Par', 'Set', 'Equ.l', 'Var.l' / // changes here require changes in Python code
    siName         'domain of input symbol names'
    soName         'domain of output symbol names'
;
Set cdInput(siName<,typ,*) 'Cube Input Data' /
$ontext
REG             .'Set'.'ALL_REG'
CUR             .'Set'.'1'
UNITS           .'Set'.'1'                                               
UNITS_ACT       .'Set'.'1'                                               
UNITS_CAP       .'Set'.'1'                                               
UNITS_COM       .'Set'.'1'                                               
UNITS_MONY      .'Set'.'1'                                               
ACT_BND         .'Par'.'ALL_REG,ALLYEAR,PRC,ALL_TS,1'                    
ACT_COST        .'Par'.'ALL_REG,ALLYEAR,PRC,1'                           
ACT_CUM         .'Par'.'ALL_REG,PRC,1,2,3'                               
ACT_EFF         .'Par'.'ALL_REG,ALLYEAR,PRC,COM_GRP,ALL_TS'              
ALL_REG         .'Set'.'ALL_REG'                                         
B               .'Par'.'ALLYEAR'                                         
COM             .'Set'.'COM_GRP'                                         
COM_AGG         .'Par'.'ALL_REG,ALLYEAR,COM_GRP,1'                       
COM_DESC        .'Set'.'ALL_REG,COM_GRP'                                 
COM_FR          .'Par'.'ALL_REG,ALLYEAR,COM_GRP,ALL_TS'                  
COM_GMAP        .'Set'.'ALL_REG,COM_GRP,1'                               
COM_GRP         .'Set'.'COM_GRP'                                         
COM_IE          .'Par'.'ALL_REG,ALLYEAR,COM_GRP,ALL_TS'                  
COM_PEAK        .'Set'.'ALL_REG,COM_GRP'                                 
COM_PKRSV       .'Par'.'ALL_REG,ALLYEAR,COM_GRP'                         
COM_PROJ        .'Par'.'ALL_REG,ALLYEAR,COM_GRP'                         
COM_TMAP        .'Set'.'ALL_REG,COM_GRP,1'                               
COM_TSL         .'Set'.'ALL_REG,COM_GRP,1'                               
COM_UNIT        .'Set'.'ALL_REG,COM_GRP,1'                               
D               .'Par'.'ALLYEAR'                                         
DATAYEAR        .'Set'.'ALLYEAR'                                         
E               .'Par'.'ALLYEAR'                                         
FLO_SHAR        .'Par'.'ALL_REG,ALLYEAR,PRC,COM_GRP,1,ALL_TS,2'          // reorder
G_DRATE         .'Par'.'ALL_REG,ALLYEAR,1'                               
G_DYEAR         .'Par'.''                                               
G_YRFR          .'Par'.'ALL_REG,ALL_TS'                                  
IRE_PRICE       .'Par'.'ALL_REG,ALLYEAR,PRC,COM_GRP,ALL_TS,1,2,3'        
M               .'Par'.'ALLYEAR'                                         
MODLYEAR        .'Set'.'ALLYEAR'                                         
NCAP_AF         .'Par'.'ALL_REG,ALLYEAR,PRC,ALL_TS,1'                    
NCAP_AFA        .'Par'.'ALL_REG,ALLYEAR,PRC,1'                           
NCAP_BND        .'Par'.'ALL_REG,ALLYEAR,PRC,1'                           
NCAP_COST       .'Par'.'ALL_REG,ALLYEAR,PRC,1'                           
NCAP_FOM        .'Par'.'ALL_REG,ALLYEAR,PRC,1'                           
NCAP_PASTI      .'Par'.'ALL_REG,ALLYEAR,PRC'                             
NCAP_PKCNT      .'Par'.'ALL_REG,ALLYEAR,PRC,ALL_TS'                      
NCAP_START      .'Par'.'ALL_REG,PRC'                                     
NCAP_TLIFE      .'Par'.'ALL_REG,ALLYEAR,PRC'                             
NRG_TMAP        .'Set'.'ALL_REG,1,COM_GRP'                               // reorder
PASTYEAR        .'Set'.'ALLYEAR'                                         
PRC             .'Set'.'PRC'                                             
PRC_ACTFLO      .'Par'.'ALL_REG,ALLYEAR,PRC,COM_GRP'                     
PRC_ACTUNT      .'Set'.'ALL_REG,PRC,COM_GRP,1'                           
PRC_CAPACT      .'Par'.'ALL_REG,PRC'                                     
PRC_DESC        .'Set'.'ALL_REG,PRC'                                     
PRC_MAP         .'Set'.'ALL_REG,1,PRC'                                   // reorder
PRC_RESID       .'Par'.'ALL_REG,ALLYEAR,PRC'                             
PRC_TSL         .'Set'.'ALL_REG,PRC,1'                                   
PRC_VINT        .'Set'.'ALL_REG,PRC'                                     
TOP             .'Set'.'ALL_REG,PRC,COM_GRP,1'                           
TOP_IRE         .'Set'.'ALL_REG,COM_GRP,1,2,PRC'                         // reorder
TS_GROUP        .'Set'.'ALL_REG,1,ALL_TS'                                // reorder
TS_MAP          .'Set'.'ALL_REG,ALL_TS,1'                                
UC_CAP          .'Par'.'UC_N,1,ALL_REG,ALLYEAR,PRC'                      // reorder
UC_COMPRD       .'Par'.'UC_N,1,ALL_REG,ALLYEAR,COM_GRP,ALL_TS'           // reorder
UC_FLO          .'Par'.'UC_N,1,ALL_REG,ALLYEAR,PRC,COM_GRP,ALL_TS'       // reorder
UC_N            .'Set'.'UC_N'                                            
UC_RHSRT        .'Par'.'ALL_REG,UC_N,ALLYEAR,1'                          // reorder
UC_RHSRTS       .'Par'.'ALL_REG,UC_N,ALLYEAR,ALL_TS,1'                   // reorder
UC_R_EACH       .'Set'.'ALL_REG,UC_N'                                    // reorder
VDA_EMCB        .'Par'.'ALL_REG,ALLYEAR,COM_GRP,1'
* New with dk
uc_r_sum        .'Set'.'UC_N,ALL_REG'
flo_deliv       .'Par'.'ALL_REG,ALLYEAR,PRC,COM_GRP,ALL_TS,1'
uc_ncap         .'Par'.'UC_N,1,ALL_REG,ALLYEAR,PRC'
ncap_itax       .'Par'.'ALL_REG,ALLYEAR,PRC,1'
ncap_chpr       .'Par'.'ALL_REG,ALLYEAR,PRC,1'
com_lim         .'Set'.'ALL_REG,COM_GRP,1'
ncap_ftax       .'Par'.'ALL_REG,ALLYEAR,PRC,1'
flo_cost        .'Par'.'ALL_REG,ALLYEAR,PRC,COM_GRP,ALL_TS,1'
uc_act          .'Par'.'UC_N,1,ALL_REG,ALLYEAR,PRC,ALL_TS'
ncap_iled       .'Par'.'ALL_REG,ALLYEAR,PRC'
com_taxnet      .'Par'.'ALL_REG,ALLYEAR,COM_GRP,ALL_TS,1'
vda_ceh         .'Par'.'ALL_REG,ALLYEAR,PRC'
cap_bnd         .'Par'.'ALL_REG,ALLYEAR,PRC,1'
uc_ire          .'Par'.'UC_N,1,ALL_REG,ALLYEAR,PRC,COM_GRP,ALL_TS,2'
ncap_elife      .'Par'.'ALL_REG,ALLYEAR,PRC'
flo_tax         .'Par'.'ALL_REG,ALLYEAR,PRC,COM_GRP,ALL_TS,1'
uc_attr         .'Set'.'ALL_REG,UC_N,1,2,3'
g_curex         .'Par'.'1,2'
ire_flo         .'Par'.'ALL_REG,ALLYEAR,PRC,COM_GRP,1,2,ALL_TS'
flo_sub         .'Par'.'ALL_REG,ALLYEAR,PRC,COM_GRP,ALL_TS,1'
ncap_drate      .'Par'.'ALL_REG,ALLYEAR,PRC'
flo_emis        .'Par'.'ALL_REG,ALLYEAR,PRC,COM_GRP,1,ALL_TS'
uc_rhsts        .'Par'.'UC_N,ALLYEAR,ALL_TS,1'
prc_noff        .'Set'.'ALL_REG,PRC,1,2'
vda_flop        .'Par'.'ALL_REG,ALLYEAR,PRC,COM_GRP,ALL_TS '
flo_func        .'Par'.'ALL_REG,ALLYEAR,PRC,COM_GRP,1,All_TS'
uc_comnet       .'Par'.'UC_N,1,ALL_REG,ALLYEAR,COM_GRP,ALL_TS'
ncap_isub       .'Par'.'ALL_REG,ALLYEAR,PRC,1'
uc_rhs          .'Par'.'UC_N,1'
uc_t_sum        .'Set'.'ALL_REG,UC_N,ALLYEAR'
* New with starter
com_pkts        .'Set'.'ALL_REG,COM_GRP,ALL_TS'
COM_BNDNET      .'Par'.'ALL_REG,ALLYEAR,COM_GRP,ALL_TS,1'
NCAP_DISC       .'Par'.'ALL_REG,ALLYEAR,PRC,1'
$offtext


                




* FF: Symbol list provided by EP (moved block with many sets to the beginning)
ALL_REG         .'Set'.'ALL_REG'                   //FF Symbol was on old list but is missing on new list provided by EP
REG             .'Set'.'ALL_REG'
CUR             .'Set'.'1'
UNITS           .'Set'.'1'                                               
UNITS_ACT       .'Set'.'1'                                               
UNITS_CAP       .'Set'.'1'                                               
UNITS_COM       .'Set'.'1'                                               
UNITS_MONY      .'Set'.'1'
PRC_MAP         .'Set'.'ALL_REG,1,PRC'             //FF Symbol was on old list but is missing on new list provided by EP                     
UC_N            .'Set'.'UC_N'                      //FF Symbol was on old list but is missing on new list provided by EP                      
UC_R_EACH       .'Set'.'ALL_REG,UC_N'              //FF Symbol was on old list but is missing on new list provided by EP                     
UC_RHSRT        .'Par'.'ALL_REG,UC_N,ALLYEAR,LIM'  //FF Symbol was on old list but is missing on new list provided by EP                     
PRC_ACTUNT      .'Set'.'ALL_REG,PRC,COM_GRP,1'     //FF Symbol was on old list but is missing on new list provided by EP                      
PRC_DESC        .'Set'.'ALL_REG,PRC'               //FF Symbol was on old list but is missing on new list provided by EP
uc_r_sum        .'Set'.'UC_N,ALL_REG'              //FF Symbol was on old list but is missing on new list provided by EP
uc_t_sum        .'Set'.'ALL_REG,UC_N,ALLYEAR'      //FF Symbol was on old list but is missing on new list provided by EP  
B               .'Par'.'ALLYEAR'                                         
COM             .'Set'.'COM_GRP'
COM_DESC        .'Set'.'ALL_REG,COM_GRP'
*COM_GMAP        .'Set'.'ALL_REG,COM_GRP,COM_GRP'
COM_GMAP        .'Set'.'ALL_REG,COM_GRP,1'
*COM_TMAP        .'Set'.'ALL_REG,COM_GRP,COM_GRP'
COM_TMAP        .'Set'.'ALL_REG,COM_GRP,1'
*COM_UNIT        .'Set'.'ALL_REG,COM_GRP,UNITS_COM'
COM_UNIT        .'Set'.'ALL_REG,COM_GRP,1'                             
COM_GRP         .'Set'.'COM_GRP'
D               .'Par'.'ALLYEAR'
DATAYEAR        .'Set'.'ALLYEAR'                                         
E               .'Par'.'ALLYEAR'
M               .'Par'.'ALLYEAR'                                         
MODLYEAR        .'Set'.'ALLYEAR'
*NRG_TMAP        .'Set'.'ALL_REG,NRG_TYPE,COM_GRP'
NRG_TMAP        .'Set'.'ALL_REG,1,COM_GRP'   
PASTYEAR        .'Set'.'ALLYEAR'                                         
PRC             .'Set'.'PRC'
*TOP             .'Set'.'ALL_REG,PRC,COM_GRP,IO'
TOP             .'Set'.'ALL_REG,PRC,COM_GRP,1'                           
*TOP_IRE         .'Set'.'ALL_REG,COM_GRP,ALL_REG,COM_GRP,PRC'
TOP_IRE         .'Set'.'ALL_REG,COM_GRP,1,2,PRC'                         
*TS_GROUP        .'Set'.'ALL_REG,TSVL,ALL_TS'
TS_GROUP        .'Set'.'ALL_REG,1,ALL_TS'                                
*TS_MAP          .'Set'.'ALL_REG,ALL_TS,ALL_TS'
TS_MAP          .'Set'.'ALL_REG,ALL_TS,1'  



ACT_BND              .'Par'        .'ALL_REG,ALLYEAR,PRC,ALL_TS,LIM'                     //     'Bound on activity of a process' 
ACT_COST             .'Par'        .'ALL_REG,ALLYEAR,PRC,CUR'                            //     'Variable costs associated with activity of a process' 
ACT_CSTPL            .'Par'        .'ALL_REG,ALLYEAR,PRC,CUR'                            //     'Partial load cost penalty' 
ACT_CSTRMP           .'Par'        .'ALL_REG,ALLYEAR,PRC,LIM,CUR'                        //     'Ramp-up .'LIM=UP' or ramp-down .'LIM=LO' cost per unit of load change' 
ACT_CSTSD            .'Par'        .'ALL_REG,ALLYEAR,PRC,1,LIM,CUR'                      //    	'Start-up .'LIM=UP' and shutdown costs .'LIM=LO' per unit of started-up capacity, by start-up type'
*ACT_CSTUP            .'Par'        .'ALL_REG,ALLYEAR,PRC,TSLVL,CUR'                      //     'Variable costs associated with startup of a process'
ACT_CSTUP            .'Par'        .'ALL_REG,ALLYEAR,PRC,ALL_TS,CUR'                      //     'Variable costs associated with startup of a process' FF TSLVL-->ALL_TS
ACT_CUM              .'Par'        .'ALL_REG,PRC,ALLYEAR,1,LIM'                          //     'Bound on cumulative activity' 
ACT_EFF              .'Par'        .'ALL_REG,ALLYEAR,PRC,COM_GRP,ALL_TS'                 //     'Activity efficiency for process' 
ACT_LOSPL            .'Par'        .'ALL_REG,ALLYEAR,PRC,LIM'                            //     'Fuel consumption increase at minimum load' 
ACT_LOSSD            .'Par'        .'ALL_REG,ALLYEAR,PRC,1,LIM'                          //     'Efficiency at one hour from start-up .'LIM=UP' or at one hour to end of shut-down .'LIM=LO'' 
ACT_MAXNON           .'Par'        .'ALL_REG,ALLYEAR,PRC,1'                              //     'Max. non-operational time before transition to next stand-by condition, by start-up type, in hours' 
ACT_MINLD            .'Par'        .'ALL_REG,ALLYEAR,PRC'                                //     'Minimum stable operation level' 
ACT_SDTIME           .'Par'        .'ALL_REG,ALLYEAR,PRC,1,LIM'                          //     'Duration of start-up .'LIM=UP' and shut-down LIM=LO' phases, by start-up type, in hours' 
ACT_TIME             .'Par'        .'ALL_REG,ALLYEAR,PRC,LIM'                            //     'Minimum online/offline hours' 
ACT_UPS              .'Par'        .'ALL_REG,ALLYEAR,PRC,ALL_TS,LIM'                     //     'Max. ramp rate, fraction of capacity per hour'
BS_BNDPRS            .'Par'        .'ALL_REG,ALLYEAR,PRC,COM_GRP,ALL_TS,LIM'             //     'Bound on process reserve provision' 
BS_CAPACT            .'Par'        .'ALL_REG'                                            //     'Conversion factor from exogenous reserve demand to activity' 
BS_DELTA             .'Par'        .'ALL_REG,ALLYEAR,COM_GRP,ALL_TS'                     //     'Calibration 'Par'.s for probabilistic reserve demands' 
*BS_DEMDET            .'Par'        .'ALL_REG,ALLYEAR,RSP,COM_GRP,ALL_TS'                 //     'Deterministic demands of reserves - EXOGEN and WMAXSI' 
BS_DETWT             .'Par'        .'ALL_REG,ALLYEAR,COM_GRP'                            //     'Weights for deterministic reserve demands' 
BS_LAMBDA            .'Par'        .'ALL_REG,ALLYEAR,COM_GRP'                            //     'Fudge factors for dependencies in reserve requirements' 
BS_MAINT             .'Par'        .'ALL_REG,ALLYEAR,PRC,ALL_TS'                         //     'Continuous maintenance duration .'hours'' 
BS_OMEGA             .'Par'        .'ALL_REG,ALLYEAR,COM_GRP,ALL_TS'                     //     'Indicator of how to define reserve demand from deterministic and probabilistic component' 
BS_RMAX              .'Par'        .'ALL_REG,ALLYEAR,PRC,COM_GRP,ALL_TS'                 //     'Maximum contribution of process PRC to provision of reserve COM_GRP as a fraction of capacity' 
BS_RTYPE             .'Par'        .'ALL_REG,COM_GRP'                                    //     'Types of reserve commodities, positive or negative 1-4' 
BS_SHARE             .'Par'        .'ALL_REG,ALLYEAR,COM_GRP,1,LIM'                      //     'Share of group reserve provision' 
BS_SIGMA             .'Par'        .'ALL_REG,ALLYEAR,COM_GRP,1,ALL_TS'                   //     'Standard deviation of imbalance source ITEM' 
BS_STIME             .'Par'        .'ALL_REG,PRC,COM_GRP,LIM'                            //     'Minimum times for reserve provision form storage .'hours'' 
CAP_BND              .'Par'        .'ALL_REG,ALLYEAR,PRC,LIM'                            //     'Bound on total installed capacity in a period' 
CCAP0                .'Par'        .'ALL_REG,PRC'                                        //     ''       													
CCAPM                .'Par'        .'ALL_REG,PRC'                                        //     ''
CLUSTER              .'Par'        .'ALL_REG,PRC,PRC'                                    //     ''
CM_CO2GTC            .'Par'        .'ALL_REG,COM_GRP'                                    //     'Conversion factors from CO2 commodities to GtC' 
CM_CONST             .'Par'        .'1'                                                  //     'Climate module constants' 
CM_EXOFORC           .'Par'        .'ALLYEAR'                                            //     'Radiative forcing from exogenous sources' 
CM_HISTORY           .'Par'        .'ALLYEAR,1'                                          // 	    'Calibration values for CO2 and forcing' 
CM_LINFOR            .'Par'        .'ALLYEAR,1,LIM'                                      // 	    'Linearized forcing function' 
CM_MAXC              .'Par'        .'ALLYEAR,1'                                          //   	'Maximum level of climate variable' 
CM_MAXCO2C           .'Par'        .'ALLYEAR'                                            //     'Maximum allowable atmospheric CO2 concentration' 
COM_AGG              .'Par'        .'ALL_REG,ALLYEAR,COM_GRP,1'                          //	    'Commodity aggregation 'Par'.'          
COM_BNDNET           .'Par'        .'ALL_REG,ALLYEAR,COM_GRP,ALL_TS,LIM'                 //     'Net bound on commodity .'e.g., emissions'' 
COM_BNDPRD           .'Par'        .'ALL_REG,ALLYEAR,COM_GRP,ALL_TS,LIM'                 //     'Limit on production of a commodity'       
COM_BPRICE           .'Par'        .'ALL_REG,ALLYEAR,COM_GRP,ALL_TS,CUR'                 //     'Base price of elastic demands'     
COM_CSTBAL           .'Par'        .'ALL_REG,ALLYEAR,COM_GRP,ALL_TS,1,CUR'               //   	'Cost on specific component of node balance';
COM_CSTNET           .'Par'        .'ALL_REG,ALLYEAR,COM_GRP,ALL_TS,CUR'                 //     'Cost on Net of commodity .'e.g., emissions tax'' 
COM_CSTPRD           .'Par'        .'ALL_REG,ALLYEAR,COM_GRP,ALL_TS,CUR'                 //     'Cost on production of a commodity'        
COM_CUMNET           .'Par'        .'ALL_REG,ALLYEAR,1,COM_GRP,LIM'                      //	    'Cumulative net bound on commodity .'e.g. emissions'' 
COM_CUMPRD           .'Par'        .'ALL_REG,ALLYEAR,1,COM_GRP,LIM'                      //	    'Cumulative limit on production of a commodity' 
COM_ELAST            .'Par'        .'ALL_REG,ALLYEAR,COM_GRP,ALL_TS,LIM'                 //     'Elasticity of demand'              
COM_ELASTX           .'Par'        .'ALL_REG,ALLYEAR,COM_GRP,LIM'                        //     'Elasticity shape of demand'        
COM_FR               .'Par'        .'ALL_REG,ALLYEAR,COM_GRP,ALL_TS'                     //     'Seasonal distribution of a commodity'     
COM_IE               .'Par'        .'ALL_REG,ALLYEAR,COM_GRP,ALL_TS'                     //     'Seasonal efficiency of commodity'         
COM_LIM              .'Set'        .'ALL_REG,COM_GRP,LIM'                                //     'List of equation type for balance'     
COM_OFF              .'Set'        .'ALL_REG,COM_GRP,ALLYEAR,1'                          //     'Periods for which a commodity is unavailable' 
COM_PEAK             .'Set'        .'ALL_REG,COM_GRP'                                    //     'Peaking required flag'                
COM_PKFLX            .'Par'        .'ALL_REG,ALLYEAR,COM_GRP,ALL_TS'                     //     'Peaking flux ratio'       
COM_PKRSV            .'Par'        .'ALL_REG,ALLYEAR,COM_GRP'                            //     'Peaking reserve margin'   
COM_PKTS             .'Set'        .'ALL_REG,COM_GRP,ALL_TS'                             //     'Peaking time-slices'                  
COM_PROJ             .'Par'        .'ALL_REG,ALLYEAR,COM_GRP'                            //     'Demand baseline projection'        
COM_STEP             .'Par'        .'ALL_REG,COM_GRP,LIM'                                //     'Step size for elastic demand'      
*COM_STEP             .'Par'        .'ALL_REG,COM_GRP,LIM'                                //     'Step size for elastic demand'      
COM_SUBPRD           .'Par'        .'ALL_REG,ALLYEAR,COM_GRP,ALL_TS,CUR'                 //     'Subsidy on production of a commodity net' 
COM_TAXNET           .'Par'        .'ALL_REG,ALLYEAR,COM_GRP,ALL_TS,CUR'                 //     'Tax on a commodity net'                   
COM_TAXPRD           .'Par'        .'ALL_REG,ALLYEAR,COM_GRP,ALL_TS,CUR'                 //     'Tax on production of a commodity net'     
*COM_TSL              .'Set'        .'ALL_REG,COM_GRP,TSLVL'                              //     'Level at which a commodity tracked'
COM_TSL              .'Set'        .'ALL_REG,COM_GRP,ALL_TS'                              //     'Level at which a commodity tracked'FF TSLVL-->ALL_TS
COM_TYPE             .'Set'        .'COM_GRP'                                            //     'Primary grouping of commodities'       
COM_VOC              .'Par'        .'ALL_REG,ALLYEAR,COM_GRP,LIM'                        //     'Variance of elastic demand'        
DAM_BQTY             .'Par'        .'ALL_REG,COM_GRP'                                    //     'Base quantity of emissions'           
DAM_COST             .'Par'        .'ALL_REG,ALLYEAR,COM_GRP,CUR'                        //     'Marginal damage cost of emissions'
DAM_ELAST            .'Par'        .'ALL_REG,COM_GRP,LIM'                                //     'Elasticity of damage cost'
DAM_STEP             .'Par'        .'ALL_REG,COM_GRP,LIM'                                //     'Step number for emissions up to base' 
DAM_VOC              .'Par'        .'ALL_REG,COM_GRP,LIM'                                //     'Variance of emissions'                
FLO_BND              .'Par'        .'ALL_REG,ALLYEAR,PRC,COM_GRP,ALL_TS,LIM'             //     'Bound on the flow variable'                           
FLO_COST             .'Par'        .'ALL_REG,ALLYEAR,PRC,COM_GRP,ALL_TS,CUR'             //     'Added variable O&M of using a commodity'              
FLO_CUM              .'Par'        .'ALL_REG,PRC,COM_GRP,ALLYEAR,1,LIM'                  //     'Bound on cumulative flow'                             
FLO_DELIV            .'Par'        .'ALL_REG,ALLYEAR,PRC,COM_GRP,ALL_TS,CUR'             //     'Delivery cost for using a commodity'                  
FLO_EMIS             .'Par'        .'ALL_REG,ALLYEAR,PRC,COM_GRP,1,ALL_TS'               //	    'General process emission 'Par'.' 
FLO_FR               .'Par'        .'ALL_REG,ALLYEAR,PRC,COM_GRP,ALL_TS,LIM'             //     'Load-curve of availability of commodity to a process' 
FLO_FUNC             .'Par'        .'ALL_REG,ALLYEAR,PRC,COM_GRP,1,ALL_TS'               //	    'Relationship between 2 .'group of' flows'              
FLO_FUNCX            .'Par'        .'ALL_REG,ALLYEAR,PRC,COM_GRP,1'                      //	    'Change in FLO_FUNC/FLO_SUM by age'                    
FLO_MARK             .'Par'        .'ALL_REG,ALLYEAR,PRC,COM_GRP,LIM'                    //     'Process-wise market share in total commodity production' 
FLO_PKCOI            .'Par'        .'ALL_REG,ALLYEAR,PRC,COM_GRP,ALL_TS'                 //     'Factor increasing the average demand' 
FLO_SHAR             .'Par'        .'ALL_REG,ALLYEAR,PRC,COM_GRP,1,ALL_TS,LIM'           //	    'Relationship between members of the same flow group'  
FLO_SUB              .'Par'        .'ALL_REG,ALLYEAR,PRC,COM_GRP,ALL_TS,CUR'             //     'Subsidy for the production/use of a commodity'        
FLO_TAX              .'Par'        .'ALL_REG,ALLYEAR,PRC,COM_GRP,ALL_TS,CUR'             //     'Tax on the production/use of a commodity'             
G_CHNGMONY           .'Par'        .'ALL_REG,ALLYEAR,CUR'                                //     'Exchange rate for currency'    
G_CUREX              .'Par'        .'CUR,1'                                              //     'Global currency conversions'
*G_CYCLE              .'Par'        .'TSLVL'                                              //     'Number of cycles in average ALLYEAR'
G_CYCLE              .'Par'        .'ALL_TS'                                              //     'Number of cycles in average ALLYEAR' FF: TSLVL-->ALL_TS
G_DRATE              .'Par'        .'ALL_REG,ALLYEAR,CUR'                                //     'Discount rate for a currency'  
G_DYEAR              .'Par'        .''                                                   //     'ALLYEAR to discount to'                          
G_OFFTHD             .'Par'        .'ALLYEAR'                                            //     'Threshold for OFF ranges'
G_OVERLAP            .'Par'        .''                                                   //     'Overlap of stepped solutions'
G_YRFR               .'Par'        .'ALL_REG,ALL_TS'                                     //     'Seasonal fraction of the ALLYEAR' 
GR_DEMFR             .'Par'        .'ALL_REG,ALLYEAR,COM_GRP,ALL_TS'                     //     'Fraction of total electricity demand allocated to grid node' 
GR_ENDFR             .'Par'        .'ALL_REG,ALLYEAR,COM_GRP,1'                          //	    'Fraction of sectoral electricity demand allocated to grid node' 
GR_GENFR             .'Par'        .'ALL_REG,ALLYEAR,COM_GRP,1'                          //   	'Fraction of electricity generation type allocated to grid node'
GR_GENLEV            .'Par'        .'ALL_REG,COM_GRP'                                    //     'Grid connection category for electricity generation commodity'
GR_GENMAP            .'Par'        .'ALL_REG,PRC,1'                                      //   	'Mapping of technology to generation type' 
GR_THMIN             .'Par'        .'ALL_REG,ALLYEAR,PRC'                                //     'Thermal minimum level' 
GR_VARGEN            .'Par'        .'ALL_REG,ALL_TS,1,LIM'                               //   	'Variance in type of generation'
GR_XBND              .'Par'        .'ALL_REG,ALLYEAR'                                    //     'Maximum level of net imports to / exports from region' 
IRE_BND              .'Par'        .'ALL_REG,ALLYEAR,COM_GRP,ALL_TS,ALL_REG,1,LIM'       //     'Limit on inter-ALL_REG exchange of commodity' 
IRE_CCVT             .'Par'        .'ALL_REG,COM_GRP,1,2'                          	   //     'Commodity unit conversion factor between regions' 
IRE_FLO              .'Par'        .'ALL_REG,ALLYEAR,PRC,COM_GRP,1,2,ALL_TS'             //    'Efficiency of exchange for inter-regional trade' 
IRE_FLOSUM           .'Par'        .'ALL_REG,ALLYEAR,PRC,COM_GRP,ALL_TS,1,2,3'           //    'Aux. consumption/emissions from inter-regional trade'
IRE_PRICE            .'Par'        .'ALL_REG,ALLYEAR,PRC,COM_GRP,ALL_TS,1,2,CUR'         // 	    'Exogenous price of import/export' 
IRE_TSCVT            .'Par'        .'ALL_REG,ALL_TS,1,2'                            	   //     'Identification and ALL_TS-conversion factor between regions' 
IRE_XBND             .'Par'        .'ALL_REG,ALLYEAR,COM_GRP,ALL_TS,1,LIM'               //     'Limit on all .'external and inter-regional' exchange of commodity' 
MULTI                .'Par'        .'1,ALLYEAR'                                          //     'Multiplier table'    
NCAP_AF              .'Par'        .'ALL_REG,ALLYEAR,PRC,ALL_TS,LIM'                     //     'Availability of capacity'                
NCAP_AFA             .'Par'        .'ALL_REG,ALLYEAR,PRC,LIM'                            //     'Annual Availability of capacity'         
NCAP_AFAC            .'Par'        .'ALL_REG,ALLYEAR,PRC,COM_GRP'                        //     'Annual availability of capacity for commodity group COM_GRP' 
*NCAP_AFC             .'Par'        .'ALL_REG,ALLYEAR,PRC,COM_GRP,STL'                    //     'Availability of capacity for commodity group COM_GRP'
NCAP_AFC             .'Par'        .'ALL_REG,ALLYEAR,PRC,COM_GRP,ALL_TS'                 //     'Availability of capacity for commodity group COM_GRP'
NCAP_AFM             .'Par'        .'ALL_REG,ALLYEAR,PRC'                                //     	'Pointer to availity change multiplier'   
NCAP_AFS             .'Par'        .'ALL_REG,ALLYEAR,PRC,ALL_TS,LIM'                     //     	'Seasonal Availability of capacity'       
NCAP_AFX             .'Par'        .'ALL_REG,ALLYEAR,PRC'                                //     	'Change in capacity availability'         
NCAP_AFCS            .'Par'        .'ALL_REG,ALLYEAR,PRC,COM_GRP,ALL_TS'                 //     	'Availability of capacity for commodity group COM_GRP'
NCAP_BND             .'Par'        .'ALL_REG,ALLYEAR,PRC,LIM'                            //     	'Bound on overall capacity in a period'   
NCAP_CHPR            .'Par'        .'ALL_REG,ALLYEAR,PRC,LIM'                            //     	'Combined heat:power ratio'               
NCAP_CLED            .'Par'        .'ALL_REG,ALLYEAR,PRC,COM_GRP'                        //     	'Leadtime of a commodity before new capacity ready' 
NCAP_COM             .'Par'        .'ALL_REG,ALLYEAR,PRC,COM_GRP,1'                      //     	'Use .'but +' of commodity based upon capacity' 
NCAP_COST            .'Par'        .'ALL_REG,ALLYEAR,PRC,CUR'                            //     	'Investment cost for new capacity'        
NCAP_CPX             .'Par'        .'ALL_REG,ALLYEAR,PRC'                                //     	'Pointer to capacity transfer multiplier' 
NCAP_DCOST           .'Par'        .'ALL_REG,ALLYEAR,PRC,CUR'                            //     	'Cost of decomissioning'                  
NCAP_DELIF           .'Par'        .'ALL_REG,ALLYEAR,PRC'                                //     	'Economic lifetime to pay for decomissioning' 
NCAP_DISC            .'Par'        .'ALL_REG,ALLYEAR,PRC,1'                              //   	'Unit size of discrete capacity addition'
NCAP_DLAG            .'Par'        .'ALL_REG,ALLYEAR,PRC'                                //     	'Delay to begin decomissioning'           
NCAP_DLAGC           .'Par'        .'ALL_REG,ALLYEAR,PRC,CUR'                            //     	'Cost of decomissioning delay'            
NCAP_DLIFE           .'Par'        .'ALL_REG,ALLYEAR,PRC'                                //     	'Time for the actual decomissioning'      
NCAP_DRATE           .'Par'        .'ALL_REG,ALLYEAR,PRC'                                //     	'Process specific discount .'hurdle' rate' 
NCAP_ELIFE           .'Par'        .'ALL_REG,ALLYEAR,PRC'                                //     	'Economic .'payback' lifetime'             
NCAP_FDR             .'Par'        .'ALL_REG,ALLYEAR,PRC'                                //     	'Functional depreciation rate of process' 
NCAP_FOM             .'Par'        .'ALL_REG,ALLYEAR,PRC,CUR'                            //     	'Fixed annual O&M costs'                  
NCAP_FOMM            .'Par'        .'ALL_REG,ALLYEAR,PRC'                                //     	'Pointer to fixed O&M change multiplier'  
NCAP_FOMX            .'Par'        .'ALL_REG,ALLYEAR,PRC'                                //     	'Change in fixed O&M'                     
NCAP_FSUB            .'Par'        .'ALL_REG,ALLYEAR,PRC,CUR'                            //     	'Fixed tax on installed capacity'         
NCAP_FSUBM           .'Par'        .'ALL_REG,ALLYEAR,PRC'                                //     	'Pointer to fixed subsidy change multiplier' 
NCAP_FSUBX           .'Par'        .'ALL_REG,ALLYEAR,PRC'                                //     	'Change in fixed tax'                     
NCAP_FTAX            .'Par'        .'ALL_REG,ALLYEAR,PRC,CUR'                            //     	'Fixed tax on installed capacity'         
NCAP_FTAXM           .'Par'        .'ALL_REG,ALLYEAR,PRC'                                //     	'Pointer to fixed tax change multiplier'  
NCAP_FTAXX           .'Par'        .'ALL_REG,ALLYEAR,PRC'                                //     	'Change in fixed tax'                     
NCAP_ICOM            .'Par'        .'ALL_REG,ALLYEAR,PRC,COM_GRP'                        //     	'Input of commodity for install of new capacity' 
NCAP_ILED            .'Par'        .'ALL_REG,ALLYEAR,PRC'                                //     	'Lead-time required for building a new capacity' 
NCAP_ISUB            .'Par'        .'ALL_REG,ALLYEAR,PRC,CUR'                            //     	'Subsidy for a new investment in capacity' 
NCAP_ITAX            .'Par'        .'ALL_REG,ALLYEAR,PRC,CUR'                            //     	'Tax on a new investment in capacity'     
NCAP_OCOM            .'Par'        .'ALL_REG,ALLYEAR,PRC,COM_GRP'                        //     	'Commodity release during decomissioning' 
NCAP_OLIFE           .'Par'        .'ALL_REG,ALLYEAR,PRC'                                //     	'Operating lifetime of a process'
NCAP_PASTI           .'Par'        .'ALL_REG,ALLYEAR,PRC'                                //     	'Capacity install prior to study years'   
NCAP_PASTY           .'Par'        .'ALL_REG,ALLYEAR,PRC'                                //     	'Buildup years for past investments'      
NCAP_PKCNT           .'Par'        .'ALL_REG,ALLYEAR,PRC,ALL_TS'                         //     	'Fraction of capacity contributing to peaking in time-slice ALL_TS' 
NCAP_SEMI            .'Par'        .'ALL_REG,ALLYEAR,PRC'                                //     	'Semi-continuous capacity, lower bound'
NCAP_START           .'Par'        .'ALL_REG,PRC'                                        //     	'Start ALLYEAR for new investments'  
NCAP_TLIFE           .'Par'        .'ALL_REG,ALLYEAR,PRC'                                //     	'Technical lifetime of a process'         
NCAP_VALU            .'Par'        .'ALL_REG,ALLYEAR,PRC,COM_GRP,CUR'                    //     	'Value of material released during decomissioning' 
PRAT                 .'Par'        .'ALL_REG,PRC'                                        //     ''
PRC_ACTFLO           .'Par'        .'ALL_REG,ALLYEAR,PRC,COM_GRP'                        //    	'Convert from process activity to particular commodity flow' 
PRC_AOFF             .'Set'        .'ALL_REG,PRC,ALLYEAR,1'                              //     'Periods for which activity is unavailable' 
PRC_CAPACT           .'Par'        .'ALL_REG,PRC'                                        //    	'Factor for going from capacity to activity' 
PRC_FOFF             .'Set'        .'ALL_REG,PRC,COM_GRP,ALL_TS,ALLYEAR,1'               //     'Periods/timeslices for which flow is not possible' 
PRC_MARK             .'Par'        .'ALL_REG,ALLYEAR,PRC,1,COM_GRP,LIM'                  //   	'Process group-wise market share' 
PRC_NOFF             .'Set'        .'ALL_REG,PRC,ALLYEAR,1'                              //     'Periods for which new capacity can NOT be built' 
PRC_NSTTS            .'Set'        .'ALL_REG,PRC,ALL_TS'                                 //     	'Night storage process and time-slice for storaging' 
PRC_PKAF             .'Set'        .'ALL_REG,PRC'                                        //     	'Flag for default value of NCAP_PKCNT' 
PRC_PKNO             .'Set'        .'ALL_REG,PRC'                                        //     	'Processes which cannot be involved in peaking' 
PRC_REACT            .'Par'        .'ALL_REG,ALLYEAR,PRC'                                //     	'Reactance of transmission line'
PRC_REFIT            .'Par'        .'ALL_REG,PRC,PRC'                                    //     	'Process with retrofit or life-extension'
PRC_RESID            .'Par'        .'ALL_REG,ALLYEAR,PRC'                                //     	'Residual capacity available in each period' 
PRC_STGIPS           .'Set'        .'ALL_REG,PRC,COM_GRP'                                //     	'Storage process and stored commodity for inter-period storage' 
PRC_STGTSS           .'Set'        .'ALL_REG,PRC,COM_GRP'                                //     	'Storage process and stored commodity for time-slice storage' 
*PRC_TSL              .'Set'        .'ALL_REG,PRC,TSLVL'                                  //     	'Timeslice level for a process'
PRC_TSL              .'Set'        .'ALL_REG,PRC,ALL_TS'                                 //     	'Timeslice level for a process'   FF: TSLVL --> ALL_TS
PRC_VINT             .'Set'        .'ALL_REG,PRC'                                        //     	'Process is to be vintaged'       
R_CUREX              .'Par'        .'ALL_REG,CUR,CUR'                                    //     	'Regional currency conversions'
RCAP_BND             .'Par'        .'ALL_REG,ALLYEAR,PRC,LIM'                            //     	'Retirement bounds'
REG_BNDCST           .'Par'        .'ALL_REG,ALLYEAR,1,CUR,LIM'                          //     'Bound on regional costs by type'    
REG_CUMCST           .'Par'        .'ALL_REG,ALLYEAR,1,2,CUR,LIM'                        //     'Cumulative bound on regional costs' 
REG_FIXT             .'Par'        .'ALL_REG'                                            //     'ALLYEAR up to which periods are fixed'
RPT_OPT              .'Par'        .'1,2'                                                //     ''
S_CAP_BND            .'Par'        .'ALL_REG,ALLYEAR,PRC,LIM,1,2'                        //     	'Bound on total installed capacity'  
S_CM_CONST           .'Par'        .'1,2,3'                                              //     ''
S_CM_MAXC            .'Par'        .'ALLYEAR,1,2,3'                                      //   	'Maximum allowable climatic quantity' 
S_CM_MAXCO2C         .'Par'        .'ALLYEAR,1,2'                                        // 	    'Maximum allowable atmospheric CO2 concentration' 
S_COM_CUMNET         .'Par'        .'ALL_REG,ALLYEAR,1,COM_GRP,LIM,2,3'             	    //    'Cumulative limit on COMNET' 
S_COM_CUMPRD         .'Par'        .'ALL_REG,ALLYEAR,1,COM_GRP,LIM,2,3'             	    //    'Cumulative limit on COMPRD' 
S_COM_FR             .'Par'        .'ALL_REG,ALLYEAR,COM_GRP,ALL_TS,1,2'                 //     ''
S_COM_PROJ           .'Par'        .'ALL_REG,ALLYEAR,COM_GRP,1,2'                        //    	'Demand scenario projection'  
S_COM_TAX            .'Par'        .'ALL_REG,ALLYEAR,COM_GRP,ALL_TS,1,CUR,2,3'           //     'Tax on commodity NET/PRD' 
S_DAM_COST           .'Par'        .'ALL_REG,ALLYEAR,COM_GRP,CUR,1,2'                    // 	    'Damage costs'
S_FLO_CUM            .'Par'        .'ALL_REG,PRC,COM_GRP,ALLYEAR,1,LIM,2,3'              // 	    'Cumulative limit on FLOW' 
S_FLO_FUNC           .'Par'        .'ALL_REG,ALLYEAR,PRC,COM_GRP,1,2,3'             	    //    'Uncertain multiplier of process transformation'
S_NCAP_AFS           .'Par'        .'ALL_REG,ALLYEAR,PRC,ALL_TS,1,2'                     //     ''
S_NCAP_COST          .'Par'        .'ALL_REG,ALLYEAR,PRC,1,2'                            // 	    'Uncertain multiplier of investment cost' 
S_UC_RHS             .'Par'        .'UC_N,LIM,1,2'                                       // 	    'RHS of user constraint'  
S_UC_RHSR            .'Par'        .'ALL_REG,UC_N,LIM,1,2'                               // 	    'RHS of user constraint' 
S_UC_RHSRT           .'Par'        .'ALL_REG,UC_N,ALLYEAR,LIM,1,2'                       // 	    'RHS of user constraint' 
S_UC_RHSRTS          .'Par'        .'ALL_REG,UC_N,ALLYEAR,ALL_TS,LIM,1,2'                // 	    'RHS of user constraint' 
S_UC_RHST            .'Par'        .'UC_N,ALLYEAR,LIM,1,2'                               // 	    'RHS of user constraint' 
S_UC_RHSTS           .'Par'        .'UC_N,ALLYEAR,ALL_TS,LIM,1,2'                        // 	    'RHS of user constraint' 
S_UCOBJ              .'Par'        .'UC_N,1'                                             // 	    'Weight of UC objective component in tradeoff analysis' 
SC0                  .'Par'        .'ALL_REG,PRC'                                        //     ''
SEG                  .'Par'        .'ALL_REG,PRC'                                        //     ''
SHAPE                .'Par'        .'1,2'                                                //    	'Shaping table'       
STG_CHRG             .'Par'        .'ALL_REG,ALLYEAR,PRC,ALL_TS'                         //     	'Exogeneous charging of a storage technology ' 
STG_EFF              .'Par'        .'ALL_REG,ALLYEAR,PRC'                                //     	'Storage efficiency'       
STG_LOSS             .'Par'        .'ALL_REG,ALLYEAR,PRC,ALL_TS'                         //     	'Annual energy loss from a storage technology' 
STG_MAXCYC           .'Par'        .'ALL_REG,ALLYEAR,PRC'                                //     	'Maximum number of storage cycles over lifetime' 
STG_SIFT             .'Par'        .'ALL_REG,ALLYEAR,PRC,COM_GRP,ALL_TS'                 //     	'Max load sifting in proportion to total load' 
STGIN_BND            .'Par'        .'ALL_REG,ALLYEAR,PRC,COM_GRP,ALL_TS,LIM'             //     	'Bound on output-flow of storage process'      
STGOUT_BND           .'Par'        .'ALL_REG,ALLYEAR,PRC,COM_GRP,ALL_TS,LIM'             //     	'Bound on output-flow of storage process'      
SW_LAMBDA            .'Par'        .''                                                   //     ''  
SW_PROB              .'Par'        .'1'                                                  //     ''
SW_SPROB             .'Par'        .'1,2'                                                //     ''
SW_START             .'Par'        .'1'                                                  //     ''
SW_SUBS              .'Par'        .'1,2'                                                //     ''
TM_ARBM              .'Par'        .''                                                   //     ''  
TM_DEFVAL            .'Par'        .''                                                   //     ''  
TM_DEPR              .'Par'        .'ALL_REG'                                            //     	'Depreciation rate'
TM_DMTOL             .'Par'        .'ALL_REG'                                            //     	'Demand lower bound factor'
TM_ESUB              .'Par'        .'ALL_REG'                                            //     	'Elasticity of substitution'     
TM_EXPBND            .'Par'        .'ALL_REG,ALLYEAR,PRC'                                //     	'Market Penetration Cutoff for Applying Cost Penalty'        
TM_EXPF              .'Par'        .'ALL_REG,ALLYEAR'                                    //     	'Annual percent expansion factor'
TM_GDP0              .'Par'        .'ALL_REG'                                            //     	'Initial GDP'
TM_GR                .'Par'        .'ALL_REG,ALLYEAR'                                    //     	'Growth rate'
TM_IVETOL            .'Par'        .'ALL_REG'                                            //     	'Investment and enery tolerance' 
TM_KGDP              .'Par'        .'ALL_REG'                                            //     	'Initial capital to GDP ratio'
TM_KPVS              .'Par'        .'ALL_REG'                                            //     	'Capital value share'            
TM_QFAC              .'Par'        .'ALL_REG'                                            //     	'Switch for market penetration penalty function'             
TM_SCALE_CST         .'Par'        .''                                                   //     ''  
TM_SCALE_NRG         .'Par'        .''                                                   //     ''  
TM_SCALE_UTIL        .'Par'        .''                                                   //     'Scaling factor utility function'                            
TS_CYCLE             .'Par'        .'ALL_REG,ALL_TS'                                     //     	'Length of cycles below timeslice, in days' 
UC_ACT               .'Par'        .'UC_N,1,ALL_REG,ALLYEAR,PRC,ALL_TS'                  //   	'Multiplier of activity variables' 
UC_ATTR              .'Set'        .'ALL_REG,UC_N,1,2,3'                                 //     'Mapping of parameter names to groups'
UC_ACTBET            .'Par'        .'UC_N,ALL_REG,ALLYEAR,PRC'                           //     ''
*UC_CAP               .'Par'        .'UC_N,SIDE,ALL_REG,ALLYEAR,PRC'                      //    	'Multiplier of capacity variables' 
*UC_CLI               .'Par'        .'UC_N,SIDE,ALL_REG,ALLYEAR,CM_VAR'                   //     'Climate variable'      
*UC_COMCON            .'Par'        .'UC_N,SIDE,ALL_REG,ALLYEAR,COM_GRP,ALL_TS'           //     	'Multiplier of VAR_COMCON variables' 
*UC_COMNET            .'Par'        .'UC_N,SIDE,ALL_REG,ALLYEAR,COM_GRP,ALL_TS'           //     	'Multiplier of VAR_COMNET variables' 
*UC_COMPRD            .'Par'        .'UC_N,SIDE,ALL_REG,ALLYEAR,COM_GRP,ALL_TS'           //     	'Multiplier of VAR_COMPRD variables'
UC_CAP               .'Par'        .'UC_N,1,ALL_REG,ALLYEAR,PRC'                      //    	'Multiplier of capacity variables'    
UC_CLI               .'Par'        .'UC_N,1,ALL_REG,ALLYEAR,1'                        //     'Climate variable'                    
UC_COMCON            .'Par'        .'UC_N,1,ALL_REG,ALLYEAR,COM_GRP,ALL_TS'           //     	'Multiplier of VAR_COMCON variables' 
UC_COMNET            .'Par'        .'UC_N,1,ALL_REG,ALLYEAR,COM_GRP,ALL_TS'           //     	'Multiplier of VAR_COMNET variables' 
UC_COMPRD            .'Par'        .'UC_N,1,ALL_REG,ALLYEAR,COM_GRP,ALL_TS'           //     	'Multiplier of VAR_COMPRD variables' 
UC_CUMACT            .'Par'        .'UC_N,ALL_REG,PRC,ALLYEAR,1'                         //     	'Multiplier of cumulative process activity variable' 
*UC_CUMCOM            .'Par'        .'UC_N,ALL_REG,COM_VAR,COM_GRP,ALLYEAR,1'             //     	'Multiplier of cumulative commodity variable'
UC_CUMCOM            .'Par'        .'UC_N,ALL_REG,1,COM_GRP,ALLYEAR,2'             //     	'Multiplier of cumulative commodity variable' 
UC_CUMFLO            .'Par'        .'UC_N,ALL_REG,PRC,COM_GRP,ALLYEAR,1'                 //     	'Multiplier of cumulative process flow variable' 
UC_DYNBND            .'Set'        .'UC_N,LIM'                                           //     'Dynamic process-wise UC bounds'   
UC_FLO               .'Par'        .'UC_N,1,ALL_REG,ALLYEAR,PRC,COM_GRP,ALL_TS'          //   	'Multiplier of flow variables' 
UC_FLOBET            .'Par'        .'UC_N,ALL_REG,ALLYEAR,PRC,COM_GRP'                   //     ''
UC_IRE               .'Par'        .'UC_N,1,ALL_REG,ALLYEAR,PRC,COM_GRP,ALL_TS,2'        // 	    'Multiplier of inter-regional exchange variables' 
UC_NCAP              .'Par'        .'UC_N,1,ALL_REG,ALLYEAR,PRC'                         //   	'Multiplier of VAR_NCAP variables' 
UC_RHS               .'Par'        .'UC_N,LIM'                                           //     	'Constant in user constraint'  
UC_RHSR              .'Par'        .'ALL_REG,UC_N,LIM'                                   //     	'Constant in user constraint'  
UC_RHSRS             .'Par'        .'ALL_REG,UC_N,ALL_TS,LIM'                            //     	'Constant in user constraint'  
UC_RHST              .'Par'        .'UC_N,ALLYEAR,LIM'                                   //     	'Constant in user constraint'  
UC_RHSRTS            .'Par'        .'ALL_REG,UC_N,ALLYEAR,ALL_TS,LIM'                    //     	'Constant in user constraint'  
UC_RHSS              .'Par'        .'UC_N,ALL_TS,LIM'                                    //     	'Constant in user constraint'  
*UC_RHST              .'Par'        .'UC_N,ALLYEAR,LIM'                                   //     	'Constant in user constraint'  
UC_RHSTS             .'Par'        .'UC_N,ALLYEAR,ALL_TS,LIM'                            //     	'Constant in user constraint'  
UC_TIME              .'Par'        .'UC_N,ALL_REG,ALLYEAR'                               //     	'Multiplier of time in model periods'
UC_UCN               .'Par'        .'UC_N,1,ALL_REG,ALLYEAR,UC_N'                        //     	'Multiplier of user constraint variable' 
VDA_CEH              .'Par'        .'ALL_REG,ALLYEAR,PRC'                                //     	'The slope of pass-out turbine'
VDA_EMCB             .'Par'        .'ALL_REG,ALLYEAR,COM_GRP,1'                          //    	'Combustion emission'
VDA_FLOP             .'Par'        .'ALL_REG,ALLYEAR,PRC,COM_GRP,ALL_TS'                 //     	'General process transformation'


/;

Set cdOutput(soName<,typ,*) 'Cube Data' /
*** Variables & Parameters
'par_actl'     . 'par'   . 'ALL_REG,1,ALLYEAR,PRC,ALL_TS'        
'par_actm'     . 'par'   . 'ALL_REG,1,ALLYEAR,PRC,ALL_TS'        
'par_capl'     . 'par'   . 'ALL_REG,ALLYEAR,PRC'                 
'par_pasti'    . 'par'   . 'ALL_REG,ALLYEAR,PRC,1'               
'par_capm'     . 'par'   . 'ALL_REG,ALLYEAR,PRC'                 
'par_ncapl'    . 'par'   . 'ALL_REG,ALLYEAR,PRC'                 
'par_ncapm'    . 'par'   . 'ALL_REG,ALLYEAR,PRC'                 
'par_ncapr'    . 'par'   . 'ALL_REG,ALLYEAR,PRC,1'               
'f_in'         . 'par'   . 'ALL_REG,1,ALLYEAR,PRC,COM_GRP,ALL_TS'
'f_out'        . 'par'   . 'ALL_REG,1,ALLYEAR,PRC,COM_GRP,ALL_TS'
'agg_out'      . 'par'   . 'ALL_REG,ALLYEAR,COM_GRP,ALL_TS'      
'p_out'        . 'par'   . 'ALL_REG,ALLYEAR,PRC,COM_GRP,ALL_TS'  
'par_rtcs'     . 'par'   . 'ALL_REG,ALLYEAR,COM_GRP,ALL_TS'      
'par_comprdl'  . 'par'   . 'ALL_REG,ALLYEAR,COM_GRP,ALL_TS'      
'par_comprdm'  . 'par'   . 'ALL_REG,ALLYEAR,COM_GRP,ALL_TS'      
'par_comnetl'  . 'par'   . 'ALL_REG,ALLYEAR,COM_GRP,ALL_TS'      
'par_comnetm'  . 'par'   . 'ALL_REG,ALLYEAR,COM_GRP,ALL_TS'      
'par_eout'     . 'par'   . 'ALL_REG,1,ALLYEAR,PRC,COM_GRP'       
'par_cumcst'   . 'par'   . 'ALL_REG,1,ALLYEAR,2,COM_GRP'         
*** Equations                                                 
'eqg_combal'   . 'equ.l' . 'ALL_REG,ALLYEAR,COM_GRP,ALL_TS'      
'par_combalem' . 'par'   . 'ALL_REG,ALLYEAR,COM_GRP,ALL_TS'      
'eqe_combal'   . 'equ.l' . 'ALL_REG,ALLYEAR,COM_GRP,ALL_TS'      
'par_combalgm' . 'par'   . 'ALL_REG,ALLYEAR,COM_GRP,ALL_TS'      
'eq_peak'      . 'equ.l' . 'ALL_REG,ALLYEAR,COM_GRP,ALL_TS'      
'par_peakm'    . 'par'   . 'ALL_REG,ALLYEAR,COM_GRP,ALL_TS'      
'par_ipric'    . 'par'   . 'ALL_REG,ALLYEAR,PRC,COM_GRP,ALL_TS,1'
'par_cumflol'  . 'par'   . 'ALL_REG,PRC,COM_GRP,1,ALLYEAR'       
'par_cumflom'  . 'par'   . 'ALL_REG,PRC,COM_GRP,1,ALLYEAR'       
*** Parameters                                                  
'par_top'      . 'par'   . 'ALL_REG,ALLYEAR,PRC,COM_GRP,1'       
'par_caplo'    . 'par'   . 'ALL_REG,ALLYEAR,PRC'                 
'par_capup'    . 'par'   . 'ALL_REG,ALLYEAR,PRC'                 
'Cap_New'      . 'par'   . 'ALL_REG,1,PRC,ALLYEAR,2'             
*** Costs                                                       
'cst_invc'     . 'par'   . 'ALL_REG,1,ALLYEAR,PRC,2'             
'cst_invx'     . 'par'   . 'ALL_REG,1,ALLYEAR,PRC,2'             
'cst_salv'     . 'par'   . 'ALL_REG,1,PRC'                       
'cst_decc'     . 'par'   . 'ALL_REG,1,ALLYEAR,PRC'               
'cst_fixc'     . 'par'   . 'ALL_REG,1,ALLYEAR,PRC'               
'cst_fixx'     . 'par'   . 'ALL_REG,1,ALLYEAR,PRC'               
'cst_actc'     . 'par'   . 'ALL_REG,1,ALLYEAR,PRC,2'             
'cst_floc'     . 'par'   . 'ALL_REG,1,ALLYEAR,PRC,COM_GRP'       
'cst_flox'     . 'par'   . 'ALL_REG,1,ALLYEAR,PRC,COM_GRP'       
'cst_comc'     . 'par'   . 'ALL_REG,ALLYEAR,COM_GRP'             
'cst_comx'     . 'par'   . 'ALL_REG,ALLYEAR,COM_GRP'             
'cst_come'     . 'par'   . 'ALL_REG,ALLYEAR,COM_GRP'             
'cst_dam'      . 'par'   . 'ALL_REG,ALLYEAR,COM_GRP'             
'cst_irec'     . 'par'   . 'ALL_REG,1,ALLYEAR,PRC,COM_GRP'       
'cst_pvp'      . 'par'   . '1,ALL_REG,PRC'                       
'cst_pvc'      . 'par'   . '1,ALL_REG,COM_GRP'                  
'cst_time'     . 'par'   . 'ALL_REG,ALLYEAR,ALL_TS,1'            
'val_flo'      . 'par'   . 'ALL_REG,1,ALLYEAR,PRC,COM_GRP'       
'ObjZ'         . 'var.l' .  ''                                     
'reg_wobj'     . 'par'   . 'ALL_REG,1,COM_GRP'                   
'reg_obj'      . 'par'   . 'ALL_REG'                             
'reg_irec'     . 'par'   . 'ALL_REG'                             
'reg_acost'    . 'par'   . 'ALL_REG,ALLYEAR,1'                   
'par_ucsl'     . 'par'   . '1,ALL_REG,ALLYEAR,ALL_TS'            
'par_ucsm'     . 'par'   . '1,ALL_REG,ALLYEAR,ALL_TS'            
'par_ucmrk'    . 'par'   . 'ALL_REG,ALLYEAR,1,COM_GRP,ALL_TS'    
'par_ucrtp'    . 'par'   . '1,ALL_REG,ALLYEAR,PRC,COM_GRP'       
'par_ucmax'    . 'par'   . '1,ALL_REG,PRC,COM_GRP'               
*** Climate and MACRO                                 
'CM_RESULT'    . 'par'   . 'COM_GRP,ALLYEAR'                     
'CM_MAXC_M'    . 'par'   . 'COM_GRP,ALLYEAR'                     
'TM_RESULT'    . 'par'   . 'COM_GRP,ALL_REG,ALLYEAR'                     
/;


$onEmbeddedCode Python:
import os
def printme(s):
  if len(s)<255:
    gams.printLog(s)
  else:
    print(s)
  
def check_and_calc_extra(cd, xdom):
  maxExtra = 0
  for cdRec in cd:
    if cdRec[2]=='':
      if not (cdRec[1]=='Par' or cdRec[1]=='Equ.l' or cdRec[1]=='Var.l'):
        raise NameError('Zero dimensional symbol ' + cdRec[0] + ' is not of type Par, Equ.l, or Var.l')
      continue
    dom = cdRec[2].split(',') 
    ndom = len(dom)
    for d in dom:
      if d.isdigit():
        maxExtra = max(maxExtra,int(d))
      elif not d in xdom:
        raise NameError('Domain ' + d + ' in symbol ' + cdRec[0] + ' unknown')
  return maxExtra
  
cd_input = list(gams.get('cdInput'))
xidom = set(gams.get('xidom'))
max_inputExtra = check_and_calc_extra(cd_input, xidom)
dinput_map = { r[1]:r[0]+3 for r in zip(range(len(xidom)),gams.get('xidom')) }
dinput_map.update({ str(i+1):i+len(xidom)+3 for i in range(max_inputExtra)})
os.environ['CUBEINPUTDOM'] = 'siName,typ,dd,' + ','.join(list(gams.get('xidom'))) + ',*'*max_inputExtra

cd_output = list(gams.get('cdOutput'))
xodom = set(gams.get('xodom'))
max_outputExtra = check_and_calc_extra(cd_output, xodom)
doutput_map = { r[1]:r[0]+2 for r in zip(range(len(xodom)),gams.get('xodom')) }
doutput_map.update({ str(i+1):i+len(xodom)+2 for i in range(max_outputExtra)})
os.environ['CUBEOUTPUTDOM'] = 'scenario,soName,' + ','.join(list(gams.get('xodom'))) + ',*'*max_outputExtra
$offEmbeddedCode
$if not errorFree $stop

alias (*, UC_N, ALL_REG, ALLYEAR, PRC, COM_GRP, ALL_TS, LIM, CUR);
set scenario 'TIMES Scenario';
set ddorder 'Order index for DD Files' / 1*500 /;

$onEmpty
$if not set DATASET $set DATASET demo
$ifthen.data %DATASET%==dk
$set DDPREFIX TIMES-DK_COMETS/model/
$include dkdata
$elseif.data %DATASET%==starter
$set DDPREFIX D:\Users\mbussieck\Downloads\times_starter\
$include starterdata
$elseif.data %DATASET%==starter_extended
$set DDPREFIX D:\Users\mbussieck\Downloads\GAMS_WrkMIRO\
$include starterdata_extended
$elseif.data  %DATASET%==mydata
* Fill in your data
$onExternalInput
$offExternalInput
$else.data
$set DDPREFIX TIMES_Demo/model/
$onExternalInput
set           dd                              'DD Files'                      / base,newtechs,trade_param,dem_ref,syssettings,peak_rsv,
                                                                                refinery,demproj_dtcar,uc_nuc_maxcap,bounds-uc_wsets /;
set           scenddmap(scenario<,ddorder,dd) 'Scenario DD File map'          / demo12.(#ddorder:#dd) /;
set           offeps(dd)                      'dd read under offeps'          / /;                                         
set           TimeSlice                       'ALL_TS'                        / ANNUAL,S,W,SD,SN,WD,WN/ ;
set           MILESTONYR                      'Years for this model run'      / 2005, 2010, 2015, 2020, 2030, 2050 /;
scalar        gmsBOTime                       'Adjustment for total available time span of years available in the model' / 1960 /;
set           gmsRunScenario(scenario)        'Selected scenario'             / demo12 /;
set           extensions(*,*,*)               'TIMES Extensions'              / ''.(REDUCE.YES, DSCAUTO.YES, VDA.YES, DEBUG.NO, DUMPSOL.NO,
                                                                                SOLVE_NOW.YES, XTQA.YES, VAR_UC.YES, SOLVEDA.YES, DATAGDX.YES,
                                                                                VEDAVDD.YES) /;
singleton set gmsObj(*)      'Choice of objective function formulations'      / 'MOD' /; // ALT, AUTO, LIN, MOD, STD
$offExternalInput
$endif.data
$onExternalInput
parameter     cubeInput(%sysEnv.CUBEINPUTDOM%);
set           solveropt(*,*,*) 'Solver options'                               / cplex.(scaind.0,  rerun.yes, iis.yes, lpmethod.4, baralg.1,
                                                                                barcrossalg.1, barorder.2, threads.8)
                                                                                gurobi.method.2/;
singleton set gmsSolver(*)   'Solver for TIMES'                               / cplex /;
scalar        gmsResLim      'Time limit for solve'                           / 1000 /;
scalar        gmsBRatio      'Basis indicator'                                / 1 /;
singleton set gmsRunOpt(*)   'Selection for local, short and long NEOS queue' / local /; // local, short, long
* Skipped VDA DATAGDX VEDAVDD 
$offExternalInput
$offEmpty

$onExternalOutput
parameter cubeOutput(%sysEnv.CUBEOUTPUTDOM%);
$offExternalOutput

$ifThen "x%gams.IDCGDXInput%"=="x"
$onecho > "%gams.scrDir%mkdd.%gams.scrExt%"
$onmulti
$oneps
$include "%mydd%"
$offecho
$onExternalInput
$onEmbeddedCode Python:
gams.wsWorkingDir = '.'
do_print = False
dd_db = {}
for dd in gams.get('dd'):
  s = 'grep -iv offeps ' + r'%DDPREFIX% '.rstrip()+dd+'.dd > "' + r'%gams.scrDir%mydd.%gams.scrExt%'+'"'
  rc = os.system(s)
  if not rc==0:
    raise NameError('probem executing: ' + s)
  s = 'gams "'+r'%gams.scrDir%mkdd.%gams.scrExt%'+'" --mydd "'+r'%gams.scrDir%mydd.%gams.scrExt%'+'" mp=2 lo=2 gdx='+dd+'.gdx'
  rc = os.system(s)
  if not rc==0:
    raise NameError('probem executing: ' + s)
  dd_db[dd] = gams.ws.add_database_from_gdx(dd+'.gdx')
noDD = []
for cdRec in cd_input:
  sym = cdRec[0]
  typ = cdRec[1]
  someDD = False
  for dd in gams.get('dd'):
    try:
      dd_sym = dd_db[dd][sym]
    except:
      if do_print: gams.printLog('No ' + sym + ' in ' + dd)
      continue
    someDD = True
    if cdRec[2]=='':
      dom = []
    else:
      dom = cdRec[2].split(',')
    if not dd_sym.dimension==len(dom):
      raise NameError('Dimension mismatch for ' + sym + ' in ' + dd + ': ' + str(dd_sym.dimension) + '<>' + str(len(dom)))
    for r in dd_sym:
      key = [sym,typ,dd] + ['-']*(len(xidom)+max_inputExtra)
      for idx in zip(range(dd_sym.dimension),dom):
        key[dinput_map[idx[1]]] = r.key(idx[0])
      if cdRec[1]=='Par':
        if do_print: gams.printLog(str(key)+' '+str(r.value))
        gams.db['cubeInput'].add_record(key).value = r.value
      else:
        gams.db['cubeInput'].add_record(key).value = 1
        if do_print: gams.printLog(str(key))
  if not someDD:
    noDD.append(sym.lower())
if len(noDD):
  printme('--- Symbols not in any dd: ' + str(noDD))    
# Check if some symbol in DD is not in our input map
miss_sym = set()
i_sym = set(s[0].lower() for s in cd_input)
for dd in gams.get('dd'):
  for sym in dd_db[dd]:
    if not sym.name.lower() in i_sym:
      miss_sym.add(sym.name.lower())
if len(miss_sym):
  printme('*** Unmapped symbols in dd files: ' + str(miss_sym))
  raise NameError('Unmapped symbols in dd files')
$offEmbeddedCode cubeInput
$offExternalInput
$gdxOut _miro_gdxin_.gdx
$unLoad
$gdxOut
$else
$onEPS
$onExternalInput
$gdxIn _miro_gdxin_.gdx
$loadDC cubeInput
$gdxIn
$offExternalInput
$ifE card(cubeInput)=0 $abort 'No data in input cube'
$ifE card(gmsRunScenario)=0 $abort 'No scenario selected'

set actdd(dd), orderactdd(ddorder,dd);
$hiddencall rm -f solve*.lst solver-output*.zip
$set SCENCNT 1
$label SCENLOOPSTART

$onMultiR
$onEmbeddedCode Python:
actScen = list(gams.get('gmsRunScenario'))[%SCENCNT%-1]
actdd = []
orderactdd = []
for r in gams.get('scenddmap'):
   if r[0]==actScen:
     actdd.append(r[2])
     orderactdd.append((r[1],r[2]))
gams.set('actdd',actdd)
gams.set('orderactdd',orderactdd)
os.environ['GMSRUNNAME'] = actScen
$offEmbeddedCode actdd orderactdd
$offMulti
$set GMSRUNNAME  %sysEnv.GMSRUNNAME%


* Write DD files
$onEmbeddedCode Python:
gams.wsWorkingDir = '.'
gams.ws.my_eps = 0
offeps = set(gams.get('offeps'))
dd_txt = { dd:open(dd+'.dd','w') for dd in gams.get('actdd') }
cube_input = gams.db['cubeInput']
act_dd = set()
for dd in gams.get('actdd'):
  dd_txt[dd].write('$onEmpty\n$onEps\n$onWarning\n$set SCENARIO_NAME "' + dd + '"\n')
  act_dd.add(dd)
  if dd in offeps:
    dd_txt[dd].write('$offEps\n')
  
last_sym = ''
for cr in cube_input:
  if not cr.key(2) in act_dd:
     continue
  if not cr.key(0)==last_sym:
    if not last_sym=='':
      for dd in gams.get('actdd'):
        if dd_sym_written[dd]:
          dd_txt[dd].write('/;\n')
    dd_sym_written = { dd:False for dd in gams.get('actdd') }
    last_sym = cr.key(0)
    cdr = next(r for r in cd_input if r[0]==last_sym)
    last_dd = ''
    if cdr[2]=='':
      dom = []
    else:
      dom = cdr[2].split(',')
  if not cr.key(2)==last_dd:
    last_dd = cr.key(2)
    dd_sym_written[last_dd] = True
    f = dd_txt[last_dd]
    if cdr[1]=='Par':
      f.write('Parameter ' + cdr[0] + ' /\n')
    else: 
      f.write('Set ' + cdr[0] + ' /\n')

  keys = [cr.key(dinput_map[d]) for d in dom]
  if len(dom):
    f.write("'" + "'.'".join(keys) + "'")
  if cdr[1]=='Par':
    f.write(' ' + str(cr.value) + '\n')
  else:
    f.write('\n')

for dd in gams.get('actdd'):
  if dd_sym_written[dd]:
    dd_txt[dd].write('/;\n')
  dd_txt[dd].close()
$offEmbeddedCode
$if not errorFree $abort 'Errors. No point in continuing.'

* Write timesdriver.gms
$eval.set GMSSOLVER   gmsSolver.tl
$eval     GMSRESLIM   gmsResLim   
$eval     GMSBRATIO   gmsBRatio   
$eval     GMSBOTIME   gmsBOTime   
$eval.set GMSOBJ      gmsObj.tl
$eval.set GMSRUNOPT   gmsRunOpt.tl

$onecho > timesdriver.gms
$Title TIMES -- VERSION 4.1.0
option resLim=%GMSRESLIM%, profile=1, solveOpt=REPLACE, bRatio=%GMSBRATIO%;
option limRow=0, limCol=0, solPrint=OFF, solver=%GMSSOLVER%;
$offListing
$offEcho

* Copy solver option file creation at execution time
$onEmbeddedCode Python:
with open('timesdriver.gms', 'a+') as td:
    td.write('file fslvopt / "%GMSSOLVER%.opt" /; put fslvopt "* Generated %GMSSOLVER% option file" /;\n$onPut\n')
    for sor in gams.get('solveropt'):
      if sor[0].lower() == '%GMSSOLVER%'.lower():
        td.write(sor[1]+' '+sor[2]+'\n')
    td.write('$offPut\nputClose;\n')
    ext = {'obj':'%GMSOBJ%', 'botime':'%GMSBOTIME%', 'milestonyr':','.join(gams.get('MILESTONYR'))}
    for er in gams.get('extensions'):
      if er[0] == '':
        ext[er[1].lower()] = er[2]
    for er in gams.get('extensions'):
      if er[0].lower() == '%GMSRUNNAME%'.lower():
        ext[er[1].lower()] = er[2]
    for er in ext.items():
      if not er[0].lower() == 'milestonyr':
        td.write('$set '+er[0].upper() +' '+er[1]+'\n')
    td.write('$onMulti\nset ALL_TS /\n')
    for tsr in gams.get('TimeSlice'):
      td.write(tsr + '\n')
    td.write('/;\n$batInclude initsys.mod\n$batInclude initmty.mod\n')
    for ddr in gams.get('orderactdd'):
      td.write('$batInclude ' + ddr[1] + '.dd\n')
    td.write('\nSet MILESTONYR / ' + ext['milestonyr'] + '/;\n')
$offEmbeddedCode
$onecho >> timesdriver.gms 
$set RUN_NAME %GMSRUNNAME%
$batInclude maindrv.mod mod
$offecho

* Execute timesdriver.gms
$ifThenI.localSolve %GMSRUNOPT%==local
$  call.checkErrorLevel gams timesdriver.gms idir1=%gams.idir1%TIMES_Demo%system.dirsep%source lo=%gams.lo% er=99 ide=1 o=solve.lst gdx=out.gdx
$else.localSolve
$  call.checkErrorLevel gams timesdriver.gms idir1=%gams.idir1%TIMES_Demo%system.dirsep%source lo=%gams.lo% er=99 ide=1 a=c xs=times.g00
$  set restartFile times.g00
$  set wantGDX     yes

$  set dryRun      ''
$  set gmsOptions  'fw=1'
$  onEmbeddedCode Python:
# Copyright (c) 2017 NEOS-Server
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import os
import sys
import time
import base64
import re
try:
    import xmlrpc.client as xmlrpclib
except ImportError:
    import xmlrpclib

# NEOS XML Template (to be filled)
xml = r'''<document>
<category>lp</category>
<solver>BDMLP</solver>
<priority>:queue:</priority>
<inputType>GAMS</inputType>
<model><![CDATA[]]></model>
<options><![CDATA[]]></options>
<parameters><![CDATA[%gmsOptions%]]></parameters>
<restart><base64>:restartb64:</base64></restart>
<wantlog><![CDATA[yes]]></wantlog>
<wantlst><![CDATA[yes]]></wantlst>
<wantgdx><![CDATA[%wantGDX%]]></wantgdx>
</document>'''
xml = xml.replace(":queue:", '%GMSRUNOPT%'.lower())

neos = xmlrpclib.ServerProxy('https://neos-server.org:3333')
alive = neos.ping()
if alive != "NeosServer is alive\n":
    raise NameError('\n***\n*** Could not make connection to NEOS Server\n***')
with open(r'%restartFile%', 'rb') as restartfile:
    restart = restartfile.read()
    xml = xml.replace(":restartb64:", base64.b64encode(restart).decode('utf-8'))


if len(r'%dryRun%'):
    with open(os.path.splitext(r'%dryRun%')[0]+'.xml', 'w') as rf:
        rf.write(xml)
else:       
    (jobNumber, password) = neos.submitJob(xml)
    sys.stdout.write("\nJob number = %d\nJob password = %s\n" % (jobNumber, password))
    sys.stdout.flush()

    if jobNumber == 0:
        raise NameError('\n***\n*** NEOS Server error:' + password + '\n***')
    
    offset = 0
    echo = 1
    status = ''
    while status != 'Done':
        time.sleep(1)
        (msg, offset) = neos.getIntermediateResults(jobNumber, password, offset)
        if echo == 1:
           s = msg.data.decode()
           if s.find('Composing results.') != -1:
              sys.stdout.write(s.split('Composing results.', 1)[0])
              echo = 0;
           else:
              sys.stdout.write(s)
           sys.stdout.flush()
    
        status = neos.getJobStatus(jobNumber, password)
    
    msg = neos.getOutputFile(jobNumber, password, 'solver-output.zip')
    with open('solver-output%SCENCNT%.zip', 'wb') as rf:
        rf.write(msg.data)
$  offEmbeddedCode
$  ifthen.dryRun not "x%dryRun%"=="x"
$    call cat "%dryRun%"
$  else.dryRun
$    hiddencall rm -f solve.log solve.lst solve.lxi out.gdx
$    hiddencall gmsunzip -qq -o solver-output%SCENCNT%.zip
$  endif.dryRun
$endIf.localSolve

* Collect results in cubeOutput
$onMulti
$log --- Collecting result for scenario %GMSRUNNAME%
$onembeddedCode Python:
gams.wsWorkingDir = '.'
do_print = False
out = gams.ws.add_database_from_gdx('out.gdx')
for cdRec in cd_output:
  if cdRec[2]=='':
    dom = []
  else:
    dom = cdRec[2].split(',')
  symName = cdRec[0]
  sym = out[symName]
  for r in sym:
    key = [r'%GMSRUNNAME%',symName] + ['-']*(len(xodom)+max_outputExtra)
    for idx in zip(range(sym.dimension),dom):
      key[doutput_map[idx[1]]] = r.key(idx[0])
    if cdRec[1]=='Par':
      if do_print: gams.printLog(str(key)+' '+str(r.value))
      gams.db['cubeOutput'].add_record(key).value = r.value
    else: # equ.l or var.L
      if do_print: gams.printLog(str(key)+' '+str(r.level))
      gams.db['cubeOutput'].add_record(key).value = r.level
out.__del__() # release out.gdx
$offembeddedCode cubeOutput
$offMulti
$if exist ./solve.lst $hiddencall mv -f solve.lst solve%SCENCNT%.lst
$eval SCENCNT %SCENCNT%+1
$ifE %SCENCNT%<=card(gmsRunScenario) $goto SCENLOOPSTART
scalar cnt /0/;
loop(gmsRunScenario, cnt=cnt+1; put_utility 'incMsg' / 'solve' cnt:0:0 '.lst');
$endif
