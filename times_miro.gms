$eolCom //
*#################################
*#  1) INPUT CUBE CONFIGURATION  #
*#################################
set xidom          'Extraordinary input domains'  / UC_N UserConstraint, ALL_REG Region, ALLYEAR Period, PRC Process, COM_GRP Commodity, ALL_TS TimeSlice, LIM Limit Types, CUR Currencies/
    typ            'symbol type'                  / 'Par', 'Set' / // changes here require changes in Python code
    siName         'domain of input symbol names'
;

* List of TIMES input data symbols. 
* Extraordinary input domains (xidom) are listed explictly. For other domain sets the generic notation 1,2,3,... is used
* Note that the time slice set ALL_TS is also used for TIMES domain sets STL and TSLVL.
Set cdInput(siName<,typ,*) 'Cube Input Data' /
ALL_REG         .'Set'.'ALL_REG'
PRC             .'Set'.'PRC'
COM_GRP         .'Set'.'COM_GRP'
REG             .'Set'.'ALL_REG'                
CLU             .'Set'.'PRC'                                              //      'Set of cluster technologies in ETL'
COM             .'Set'.'COM_GRP'
COM_TYPE        .'Set'.'COM_GRP'                                          //      'Primary grouping of commodities'       
CUR             .'Set'.'CUR'
DATAYEAR        .'Set'.'ALLYEAR'                                         
MODLYEAR        .'Set'.'ALLYEAR'
PASTYEAR        .'Set'.'ALLYEAR'                                         
PRC_GRP         .'Set'.'1'                                                //      'Set of process groups'
TEG             .'Set'.'PRC'                                              //      'Set of processes with ETL'
UC_N            .'Set'.'UC_N'
UNITS           .'Set'.'1'                         
UNITS_ACT       .'Set'.'1'                         
UNITS_CAP       .'Set'.'1'                         
UNITS_COM       .'Set'.'1'                         
UNITS_MONY      .'Set'.'1'

COM_DESC        .'Set'.'ALL_REG,COM_GRP'
COM_GMAP        .'Set'.'ALL_REG,COM_GRP,1'
COM_LIM         .'Set'.'ALL_REG,COM_GRP,LIM'                              //      'List of equation type for balance'     
COM_OFF         .'Set'.'ALL_REG,COM_GRP,ALLYEAR,1'                        //      'Periods for which a commodity is unavailable' 
COM_PEAK        .'Set'.'ALL_REG,COM_GRP'                                  //      'Peaking required flag'                
COM_PKTS        .'Set'.'ALL_REG,COM_GRP,ALL_TS'                           //      'Peaking time-slices'                  
COM_TMAP        .'Set'.'ALL_REG,COM_GRP,1'
COM_TS          .'Set'.'ALL_REG,COM_GRP,ALL_TS'                           //      'Timeslices for which a commodity is available'
*COM_TSL         .'Set'.'ALL_REG,COM_GRP,TSLVL'                           //      'Level at which a commodity tracked'
COM_TSL         .'Set'.'ALL_REG,COM_GRP,ALL_TS'                           //      'Level at which a commodity tracked'FF TSLVL-->ALL_TS
COM_UNIT        .'Set'.'ALL_REG,COM_GRP,1'                             
DEM_SMAP        .'Set'.'ALL_REG,1,COM_GRP'                                //      'Mapping of demands to sectors'
ENV_MAP         .'Set'.'ALL_REG,1,COM_GRP'                                //      'Mapping of environmental commodities to main types'
NRG_TMAP        .'Set'.'ALL_REG,1,COM_GRP'   
PRC_ACTUNT      .'Set'.'ALL_REG,PRC,COM_GRP,1'     
PRC_AOFF        .'Set'.'ALL_REG,PRC,ALLYEAR,1'                            //      'Periods for which activity is unavailable' 
PRC_DESC        .'Set'.'ALL_REG,PRC'               
PRC_DSCNCAP     .'Set'.'ALL_REG,PRC'                                      //      'Set of processes modelled using the lumpy investment'
PRC_FOFF        .'Set'.'ALL_REG,PRC,COM_GRP,ALL_TS,ALLYEAR,1'             //      'Periods/timeslices for which flow is not possible' 
PRC_MAP         .'Set'.'ALL_REG,1,PRC'             
PRC_NOFF        .'Set'.'ALL_REG,PRC,ALLYEAR,1'                            //      'Periods for which new capacity can NOT be built' 
PRC_NSTTS       .'Set'.'ALL_REG,PRC,ALL_TS'                               //        'Night storage process and time-slice for storaging' 
PRC_PKAF        .'Set'.'ALL_REG,PRC'                                      //        'Flag for default value of NCAP_PKCNT' 
PRC_PKNO        .'Set'.'ALL_REG,PRC'                                      //        'Processes which cannot be involved in peaking' 
PRC_RCAP        .'Set'.'ALL_REG,PRC'                                      //      'Set of processes with early retirement'
PRC_STGIPS      .'Set'.'ALL_REG,PRC,COM_GRP'                              //        'Storage process and stored commodity for inter-period storage' 
PRC_STGTSS      .'Set'.'ALL_REG,PRC,COM_GRP'                              //        'Storage process and stored commodity for time-slice storage' 
PRC_TS          .'Set'.'ALL_REG,PRC,ALL_TS'                               //      'Timeslices for which a process is available'
*PRC_TSL         .'Set'.'ALL_REG,PRC,TSLVL'                               //        'Timeslice level for a process'
PRC_TSL         .'Set'.'ALL_REG,PRC,ALL_TS'                               //        'Timeslice level for a process'   FF: TSLVL --> ALL_TS
PRC_VINT        .'Set'.'ALL_REG,PRC'                                      //        'Process is to be vintaged'       
TOP             .'Set'.'ALL_REG,PRC,COM_GRP,1'                           
TOP_IRE         .'Set'.'ALL_REG,COM_GRP,1,2,PRC'                         
*TS_GROUP        .'Set'.'ALL_REG,TSVL,ALL_TS'
TS_GROUP        .'Set'.'ALL_REG,1,ALL_TS'
TS_MAP          .'Set'.'ALL_REG,ALL_TS,1'
UC_ATTR         .'Set'.'ALL_REG,UC_N,1,2,3'                               //      'Mapping of parameter names to groups'
UC_DYNBND       .'Set'.'UC_N,LIM'                                         //      'Dynamic process-wise UC bounds'   
UC_R_EACH       .'Set'.'ALL_REG,UC_N'              
uc_r_sum        .'Set'.'UC_N,ALL_REG'              
UC_T_EACH       .'Set'.'ALL_REG,UC_N,ALLYEAR'                             //      'Indicator that a user constraint will be generated for each specified period'
UC_T_SUCC       .'Set'.'ALL_REG,UC_N,ALLYEAR'                             //      'Indicator that a user constraint will be generated between two successive periods t and t+1'
uc_t_sum        .'Set'.'ALL_REG,UC_N,ALLYEAR'      
UC_TS_EACH      .'Set'.'ALL_REG,UC_N,ALL_TS'                              //      'Indicator that a user constraint will be generated for each time slice'
UC_TS_SUM       .'Set'.'ALL_REG,UC_N,ALL_TS'                              //      'Indicator that the user constraint will be generated by summing over the specified timeslices'
*UC_TSL          .'Set'.'ALL_REG,UC_N,1,TSLVL'                                  
UC_TSL          .'Set'.'ALL_REG,UC_N,1,ALL_TS'                            //      'Indicator of the target timeslice level of a timeslice-dynamic user constraint '
ACT_BND         .'Par'.'ALL_REG,ALLYEAR,PRC,ALL_TS,LIM'                   //      'Bound on activity of a process' 
ACT_COST        .'Par'.'ALL_REG,ALLYEAR,PRC,CUR'                          //      'Variable costs associated with activity of a process' 
ACT_CSTPL       .'Par'.'ALL_REG,ALLYEAR,PRC,CUR'                          //      'Partial load cost penalty' 
ACT_CSTRMP      .'Par'.'ALL_REG,ALLYEAR,PRC,LIM,CUR'                      //      'Ramp-up .'LIM=UP' or ramp-down .'LIM=LO' cost per unit of load change' 
ACT_CSTSD       .'Par'.'ALL_REG,ALLYEAR,PRC,1,LIM,CUR'                    //        'Start-up .'LIM=UP' and shutdown costs .'LIM=LO' per unit of started-up capacity, by start-up type'
*ACT_CSTUP       .'Par'.'ALL_REG,ALLYEAR,PRC,TSLVL,CUR'                   //      'Variable costs associated with startup of a process'
ACT_CSTUP       .'Par'.'ALL_REG,ALLYEAR,PRC,ALL_TS,CUR'                   //      'Variable costs associated with startup of a process' FF TSLVL-->ALL_TS
ACT_CUM         .'Par'.'ALL_REG,PRC,ALLYEAR,1,LIM'                        //      'Bound on cumulative activity' 
ACT_EFF         .'Par'.'ALL_REG,ALLYEAR,PRC,COM_GRP,ALL_TS'               //      'Activity efficiency for process' 
ACT_LOSPL       .'Par'.'ALL_REG,ALLYEAR,PRC,LIM'                          //      'Fuel consumption increase at minimum load' 
ACT_LOSSD       .'Par'.'ALL_REG,ALLYEAR,PRC,1,LIM'                        //      'Efficiency at one hour from start-up .'LIM=UP' or at one hour to end of shut-down .'LIM=LO'' 
ACT_MAXNON      .'Par'.'ALL_REG,ALLYEAR,PRC,1'                            //      'Max. non-operational time before transition to next stand-by condition, by start-up type, in hours' 
ACT_MINLD       .'Par'.'ALL_REG,ALLYEAR,PRC'                              //      'Minimum stable operation level' 
ACT_SDTIME      .'Par'.'ALL_REG,ALLYEAR,PRC,1,LIM'                        //      'Duration of start-up .'LIM=UP' and shut-down LIM=LO' phases, by start-up type, in hours' 
ACT_TIME        .'Par'.'ALL_REG,ALLYEAR,PRC,LIM'                          //      'Minimum online/offline hours' 
ACT_UPS         .'Par'.'ALL_REG,ALLYEAR,PRC,ALL_TS,LIM'                   //      'Max. ramp rate, fraction of capacity per hour'
B               .'Par'.'ALLYEAR'                                         
BS_BNDPRS       .'Par'.'ALL_REG,ALLYEAR,PRC,COM_GRP,ALL_TS,LIM'           //      'Bound on process reserve provision' 
BS_CAPACT       .'Par'.'ALL_REG'                                          //      'Conversion factor from exogenous reserve demand to activity' 
BS_DELTA        .'Par'.'ALL_REG,ALLYEAR,COM_GRP,ALL_TS'                   //      'Calibration 'Par'.s for probabilistic reserve demands' 
BS_DEMDET       .'Par'.'ALL_REG,ALLYEAR,1,COM_GRP,ALL_TS'                 //      'Deterministic demands of reserves - EXOGEN and WMAXSI' 
BS_DETWT        .'Par'.'ALL_REG,ALLYEAR,COM_GRP'                          //      'Weights for deterministic reserve demands' 
BS_LAMBDA       .'Par'.'ALL_REG,ALLYEAR,COM_GRP'                          //      'Fudge factors for dependencies in reserve requirements' 
BS_MAINT        .'Par'.'ALL_REG,ALLYEAR,PRC,ALL_TS'                       //      'Continuous maintenance duration .'hours'' 
BS_OMEGA        .'Par'.'ALL_REG,ALLYEAR,COM_GRP,ALL_TS'                   //      'Indicator of how to define reserve demand from deterministic and probabilistic component' 
BS_RMAX         .'Par'.'ALL_REG,ALLYEAR,PRC,COM_GRP,ALL_TS'               //      'Maximum contribution of process PRC to provision of reserve COM_GRP as a fraction of capacity' 
BS_RTYPE        .'Par'.'ALL_REG,COM_GRP'                                  //      'Types of reserve commodities, positive or negative 1-4' 
BS_SHARE        .'Par'.'ALL_REG,ALLYEAR,COM_GRP,1,LIM'                    //      'Share of group reserve provision' 
BS_SIGMA        .'Par'.'ALL_REG,ALLYEAR,COM_GRP,1,ALL_TS'                 //      'Standard deviation of imbalance source ITEM' 
BS_STIME        .'Par'.'ALL_REG,PRC,COM_GRP,LIM'                          //      'Minimum times for reserve provision form storage .'hours'' 
CAP_BND         .'Par'.'ALL_REG,ALLYEAR,PRC,LIM'                          //      'Bound on total installed capacity in a period' 
CCAP0           .'Par'.'ALL_REG,PRC'                                      //      ''                                                        
CCAPM           .'Par'.'ALL_REG,PRC'                                      //      ''
CLUSTER         .'Par'.'ALL_REG,PRC,PRC'                                  //      ''
CM_CO2GTC       .'Par'.'ALL_REG,COM_GRP'                                  //      'Conversion factors from CO2 commodities to GtC' 
CM_CONST        .'Par'.'1'                                                //      'Climate module constants' 
CM_EXOFORC      .'Par'.'ALLYEAR'                                          //      'Radiative forcing from exogenous sources' 
CM_HISTORY      .'Par'.'ALLYEAR,1'                                        //        'Calibration values for CO2 and forcing' 
CM_LINFOR       .'Par'.'ALLYEAR,1,LIM'                                    //        'Linearized forcing function' 
CM_MAXC         .'Par'.'ALLYEAR,1'                                        //    'Maximum level of climate variable' 
CM_MAXCO2C      .'Par'.'ALLYEAR'                                          //      'Maximum allowable atmospheric CO2 concentration' 
COM_AGG         .'Par'.'ALL_REG,ALLYEAR,COM_GRP,1'                        //        'Commodity aggregation 'Par'.'          
COM_BNDNET      .'Par'.'ALL_REG,ALLYEAR,COM_GRP,ALL_TS,LIM'               //      'Net bound on commodity .'e.g., emissions'' 
COM_BNDPRD      .'Par'.'ALL_REG,ALLYEAR,COM_GRP,ALL_TS,LIM'               //      'Limit on production of a commodity'       
COM_BPRICE      .'Par'.'ALL_REG,ALLYEAR,COM_GRP,ALL_TS,CUR'               //      'Base price of elastic demands'     
COM_CSTBAL      .'Par'.'ALL_REG,ALLYEAR,COM_GRP,ALL_TS,1,CUR'             //    'Cost on specific component of node balance';
COM_CSTNET      .'Par'.'ALL_REG,ALLYEAR,COM_GRP,ALL_TS,CUR'               //      'Cost on Net of commodity .'e.g., emissions tax'' 
COM_CSTPRD      .'Par'.'ALL_REG,ALLYEAR,COM_GRP,ALL_TS,CUR'               //      'Cost on production of a commodity'        
COM_CUMNET      .'Par'.'ALL_REG,ALLYEAR,1,COM_GRP,LIM'                    //        'Cumulative net bound on commodity .'e.g. emissions'' 
COM_CUMPRD      .'Par'.'ALL_REG,ALLYEAR,1,COM_GRP,LIM'                    //        'Cumulative limit on production of a commodity' 
COM_ELAST       .'Par'.'ALL_REG,ALLYEAR,COM_GRP,ALL_TS,LIM'               //      'Elasticity of demand'              
COM_ELASTX      .'Par'.'ALL_REG,ALLYEAR,COM_GRP,LIM'                      //      'Elasticity shape of demand'        
COM_FR          .'Par'.'ALL_REG,ALLYEAR,COM_GRP,ALL_TS'                   //      'Seasonal distribution of a commodity'     
COM_IE          .'Par'.'ALL_REG,ALLYEAR,COM_GRP,ALL_TS'                   //      'Seasonal efficiency of commodity'         
COM_PKFLX       .'Par'.'ALL_REG,ALLYEAR,COM_GRP,ALL_TS'                   //      'Peaking flux ratio'       
COM_PKRSV       .'Par'.'ALL_REG,ALLYEAR,COM_GRP'                          //      'Peaking reserve margin'   
COM_PROJ        .'Par'.'ALL_REG,ALLYEAR,COM_GRP'                          //      'Demand baseline projection'        
COM_STEP        .'Par'.'ALL_REG,COM_GRP,LIM'                              //      'Step size for elastic demand'      
COM_SUBPRD      .'Par'.'ALL_REG,ALLYEAR,COM_GRP,ALL_TS,CUR'               //      'Subsidy on production of a commodity net' 
COM_TAXNET      .'Par'.'ALL_REG,ALLYEAR,COM_GRP,ALL_TS,CUR'               //      'Tax on a commodity net'                   
COM_TAXPRD      .'Par'.'ALL_REG,ALLYEAR,COM_GRP,ALL_TS,CUR'               //      'Tax on production of a commodity net'     
COM_VOC         .'Par'.'ALL_REG,ALLYEAR,COM_GRP,LIM'                      //      'Variance of elastic demand'        
D               .'Par'.'ALLYEAR'
DAM_BQTY        .'Par'.'ALL_REG,COM_GRP'                                  //      'Base quantity of emissions'           
DAM_COST        .'Par'.'ALL_REG,ALLYEAR,COM_GRP,CUR'                      //      'Marginal damage cost of emissions'
DAM_ELAST       .'Par'.'ALL_REG,COM_GRP,LIM'                              //      'Elasticity of damage cost'
DAM_STEP        .'Par'.'ALL_REG,COM_GRP,LIM'                              //      'Step number for emissions up to base' 
DAM_VOC         .'Par'.'ALL_REG,COM_GRP,LIM'                              //      'Variance of emissions'                
E               .'Par'.'ALLYEAR'
FLO_BND         .'Par'.'ALL_REG,ALLYEAR,PRC,COM_GRP,ALL_TS,LIM'           //      'Bound on the flow variable'                           
FLO_COST        .'Par'.'ALL_REG,ALLYEAR,PRC,COM_GRP,ALL_TS,CUR'           //      'Added variable O&M of using a commodity'              
FLO_CUM         .'Par'.'ALL_REG,PRC,COM_GRP,ALLYEAR,1,LIM'                //      'Bound on cumulative flow'                             
FLO_DELIV       .'Par'.'ALL_REG,ALLYEAR,PRC,COM_GRP,ALL_TS,CUR'           //      'Delivery cost for using a commodity'                  
FLO_EMIS        .'Par'.'ALL_REG,ALLYEAR,PRC,COM_GRP,1,ALL_TS'             //        'General process emission 'Par'.' 
FLO_FR          .'Par'.'ALL_REG,ALLYEAR,PRC,COM_GRP,ALL_TS,LIM'           //      'Load-curve of availability of commodity to a process' 
FLO_FUNC        .'Par'.'ALL_REG,ALLYEAR,PRC,COM_GRP,1,ALL_TS'             //        'Relationship between 2 .'group of' flows'              
FLO_FUNCX       .'Par'.'ALL_REG,ALLYEAR,PRC,COM_GRP,1'                    //        'Change in FLO_FUNC/FLO_SUM by age'                    
FLO_MARK        .'Par'.'ALL_REG,ALLYEAR,PRC,COM_GRP,LIM'                  //      'Process-wise market share in total commodity production' 
FLO_PKCOI       .'Par'.'ALL_REG,ALLYEAR,PRC,COM_GRP,ALL_TS'               //      'Factor increasing the average demand' 
FLO_SHAR        .'Par'.'ALL_REG,ALLYEAR,PRC,COM_GRP,1,ALL_TS,LIM'         //        'Relationship between members of the same flow group'  
FLO_SUB         .'Par'.'ALL_REG,ALLYEAR,PRC,COM_GRP,ALL_TS,CUR'           //      'Subsidy for the production/use of a commodity'        
FLO_TAX         .'Par'.'ALL_REG,ALLYEAR,PRC,COM_GRP,ALL_TS,CUR'           //      'Tax on the production/use of a commodity'             
G_CHNGMONY      .'Par'.'ALL_REG,ALLYEAR,CUR'                              //      'Exchange rate for currency'    
G_CUREX         .'Par'.'CUR,1'                                            //      'Global currency conversions'
*G_CYCLE         .'Par'.'TSLVL'                                           //      'Number of cycles in average ALLYEAR'
G_CYCLE         .'Par'.'ALL_TS'                                           //      'Number of cycles in average ALLYEAR' FF: TSLVL-->ALL_TS
G_DRATE         .'Par'.'ALL_REG,ALLYEAR,CUR'                              //      'Discount rate for a currency'  
G_DYEAR         .'Par'.''                                                 //      'ALLYEAR to discount to'                          
G_OFFTHD        .'Par'.'ALLYEAR'                                          //      'Threshold for OFF ranges'
G_OVERLAP       .'Par'.''                                                 //      'Overlap of stepped solutions'
G_YRFR          .'Par'.'ALL_REG,ALL_TS'                                   //      'Seasonal fraction of the ALLYEAR' 
GR_DEMFR        .'Par'.'ALL_REG,ALLYEAR,COM_GRP,ALL_TS'                   //      'Fraction of total electricity demand allocated to grid node' 
GR_ENDFR        .'Par'.'ALL_REG,ALLYEAR,COM_GRP,1'                        //        'Fraction of sectoral electricity demand allocated to grid node' 
GR_GENFR        .'Par'.'ALL_REG,ALLYEAR,COM_GRP,1'                        //    'Fraction of electricity generation type allocated to grid node'
GR_GENLEV       .'Par'.'ALL_REG,COM_GRP'                                  //      'Grid connection category for electricity generation commodity'
GR_GENMAP       .'Par'.'ALL_REG,PRC,1'                                    //    'Mapping of technology to generation type' 
GR_THMIN        .'Par'.'ALL_REG,ALLYEAR,PRC'                              //      'Thermal minimum level' 
GR_VARGEN       .'Par'.'ALL_REG,ALL_TS,1,LIM'                             //    'Variance in type of generation'
GR_XBND         .'Par'.'ALL_REG,ALLYEAR'                                  //      'Maximum level of net imports to / exports from region' 
IRE_BND         .'Par'.'ALL_REG,ALLYEAR,COM_GRP,ALL_TS,ALL_REG,1,LIM'     //      'Limit on inter-ALL_REG exchange of commodity' 
IRE_CCVT        .'Par'.'ALL_REG,COM_GRP,1,2'                              //      'Commodity unit conversion factor between regions' 
IRE_FLO         .'Par'.'ALL_REG,ALLYEAR,PRC,COM_GRP,1,2,ALL_TS'           //      'Efficiency of exchange for inter-regional trade' 
IRE_FLOSUM      .'Par'.'ALL_REG,ALLYEAR,PRC,COM_GRP,ALL_TS,1,2,3'         //      'Aux. consumption/emissions from inter-regional trade'
IRE_PRICE       .'Par'.'ALL_REG,ALLYEAR,PRC,COM_GRP,ALL_TS,1,2,CUR'       //        'Exogenous price of import/export' 
IRE_TSCVT       .'Par'.'ALL_REG,ALL_TS,1,2'                               //      'Identification and ALL_TS-conversion factor between regions' 
IRE_XBND        .'Par'.'ALL_REG,ALLYEAR,COM_GRP,ALL_TS,1,LIM'             //      'Limit on all .'external and inter-regional' exchange of commodity' 
M               .'Par'.'ALLYEAR'                                         
MULTI           .'Par'.'1,ALLYEAR'                                        //      'Multiplier table'    
NCAP_AF         .'Par'.'ALL_REG,ALLYEAR,PRC,ALL_TS,LIM'                   //      'Availability of capacity'                
NCAP_AFA        .'Par'.'ALL_REG,ALLYEAR,PRC,LIM'                          //      'Annual Availability of capacity'         
NCAP_AFAC       .'Par'.'ALL_REG,ALLYEAR,PRC,COM_GRP'                      //      'Annual availability of capacity for commodity group COM_GRP'
*NCAP_AFC        .'Par'.'ALL_REG,ALLYEAR,PRC,COM_GRP,STL'                 //      'Availability of capacity for commodity group COM_GRP'
NCAP_AFC        .'Par'.'ALL_REG,ALLYEAR,PRC,COM_GRP,ALL_TS'               //      'Availability of capacity for commodity group COM_GRP'
NCAP_AFCS       .'Par'.'ALL_REG,ALLYEAR,PRC,COM_GRP,ALL_TS'               //        'Availability of capacity for commodity group COM_GRP'
NCAP_AFM        .'Par'.'ALL_REG,ALLYEAR,PRC'                              //        'Pointer to availity change multiplier'   
NCAP_AFS        .'Par'.'ALL_REG,ALLYEAR,PRC,ALL_TS,LIM'                   //        'Seasonal Availability of capacity'       
NCAP_AFX        .'Par'.'ALL_REG,ALLYEAR,PRC'                              //        'Change in capacity availability'         
NCAP_BND        .'Par'.'ALL_REG,ALLYEAR,PRC,LIM'                          //        'Bound on overall capacity in a period'   
NCAP_CHPR       .'Par'.'ALL_REG,ALLYEAR,PRC,LIM'                          //        'Combined heat:power ratio'               
NCAP_CLED       .'Par'.'ALL_REG,ALLYEAR,PRC,COM_GRP'                      //        'Leadtime of a commodity before new capacity ready' 
NCAP_COM        .'Par'.'ALL_REG,ALLYEAR,PRC,COM_GRP,1'                    //        'Use .'but +' of commodity based upon capacity' 
NCAP_COST       .'Par'.'ALL_REG,ALLYEAR,PRC,CUR'                          //        'Investment cost for new capacity'        
NCAP_CPX        .'Par'.'ALL_REG,ALLYEAR,PRC'                              //        'Pointer to capacity transfer multiplier' 
NCAP_DCOST      .'Par'.'ALL_REG,ALLYEAR,PRC,CUR'                          //        'Cost of decomissioning'                  
NCAP_DELIF      .'Par'.'ALL_REG,ALLYEAR,PRC'                              //        'Economic lifetime to pay for decomissioning' 
NCAP_DISC       .'Par'.'ALL_REG,ALLYEAR,PRC,1'                            //    'Unit size of discrete capacity addition'
NCAP_DLAG       .'Par'.'ALL_REG,ALLYEAR,PRC'                              //        'Delay to begin decomissioning'           
NCAP_DLAGC      .'Par'.'ALL_REG,ALLYEAR,PRC,CUR'                          //        'Cost of decomissioning delay'            
NCAP_DLIFE      .'Par'.'ALL_REG,ALLYEAR,PRC'                              //        'Time for the actual decomissioning'      
NCAP_DRATE      .'Par'.'ALL_REG,ALLYEAR,PRC'                              //        'Process specific discount .'hurdle' rate' 
NCAP_ELIFE      .'Par'.'ALL_REG,ALLYEAR,PRC'                              //        'Economic .'payback' lifetime'             
NCAP_FDR        .'Par'.'ALL_REG,ALLYEAR,PRC'                              //        'Functional depreciation rate of process' 
NCAP_FOM        .'Par'.'ALL_REG,ALLYEAR,PRC,CUR'                          //        'Fixed annual O&M costs'                  
NCAP_FOMM       .'Par'.'ALL_REG,ALLYEAR,PRC'                              //        'Pointer to fixed O&M change multiplier'  
NCAP_FOMX       .'Par'.'ALL_REG,ALLYEAR,PRC'                              //        'Change in fixed O&M'                     
NCAP_FSUB       .'Par'.'ALL_REG,ALLYEAR,PRC,CUR'                          //        'Fixed tax on installed capacity'         
NCAP_FSUBM      .'Par'.'ALL_REG,ALLYEAR,PRC'                              //        'Pointer to fixed subsidy change multiplier' 
NCAP_FSUBX      .'Par'.'ALL_REG,ALLYEAR,PRC'                              //        'Change in fixed tax'                     
NCAP_FTAX       .'Par'.'ALL_REG,ALLYEAR,PRC,CUR'                          //        'Fixed tax on installed capacity'         
NCAP_FTAXM      .'Par'.'ALL_REG,ALLYEAR,PRC'                              //        'Pointer to fixed tax change multiplier'  
NCAP_FTAXX      .'Par'.'ALL_REG,ALLYEAR,PRC'                              //        'Change in fixed tax'                     
NCAP_ICOM       .'Par'.'ALL_REG,ALLYEAR,PRC,COM_GRP'                      //        'Input of commodity for install of new capacity' 
NCAP_ILED       .'Par'.'ALL_REG,ALLYEAR,PRC'                              //        'Lead-time required for building a new capacity' 
NCAP_ISUB       .'Par'.'ALL_REG,ALLYEAR,PRC,CUR'                          //        'Subsidy for a new investment in capacity' 
NCAP_ITAX       .'Par'.'ALL_REG,ALLYEAR,PRC,CUR'                          //        'Tax on a new investment in capacity'     
NCAP_OCOM       .'Par'.'ALL_REG,ALLYEAR,PRC,COM_GRP'                      //        'Commodity release during decomissioning' 
NCAP_OLIFE      .'Par'.'ALL_REG,ALLYEAR,PRC'                              //        'Operating lifetime of a process'
NCAP_PASTI      .'Par'.'ALL_REG,ALLYEAR,PRC'                              //        'Capacity install prior to study years'   
NCAP_PASTY      .'Par'.'ALL_REG,ALLYEAR,PRC'                              //        'Buildup years for past investments'      
NCAP_PKCNT      .'Par'.'ALL_REG,ALLYEAR,PRC,ALL_TS'                       //        'Fraction of capacity contributing to peaking in time-slice ALL_TS' 
NCAP_SEMI       .'Par'.'ALL_REG,ALLYEAR,PRC'                              //        'Semi-continuous capacity, lower bound'
NCAP_START      .'Par'.'ALL_REG,PRC'                                      //        'Start ALLYEAR for new investments'  
NCAP_TLIFE      .'Par'.'ALL_REG,ALLYEAR,PRC'                              //        'Technical lifetime of a process'         
NCAP_VALU       .'Par'.'ALL_REG,ALLYEAR,PRC,COM_GRP,CUR'                  //        'Value of material released during decomissioning' 
PRAT            .'Par'.'ALL_REG,PRC'                                      //      ''
PRC_ACTFLO      .'Par'.'ALL_REG,ALLYEAR,PRC,COM_GRP'                      //        'Convert from process activity to particular commodity flow' 
PRC_CAPACT      .'Par'.'ALL_REG,PRC'                                      //        'Factor for going from capacity to activity' 
PRC_MARK        .'Par'.'ALL_REG,ALLYEAR,PRC,1,COM_GRP,LIM'                //    'Process group-wise market share' 
PRC_REACT       .'Par'.'ALL_REG,ALLYEAR,PRC'                              //        'Reactance of transmission line'
PRC_REFIT       .'Par'.'ALL_REG,PRC,PRC'                                  //        'Process with retrofit or life-extension'
PRC_RESID       .'Par'.'ALL_REG,ALLYEAR,PRC'                              //        'Residual capacity available in each period' 
R_CUREX         .'Par'.'ALL_REG,CUR,CUR'                                  //        'Regional currency conversions'
RCAP_BND        .'Par'.'ALL_REG,ALLYEAR,PRC,LIM'                          //        'Retirement bounds'
REG_BNDCST      .'Par'.'ALL_REG,ALLYEAR,1,CUR,LIM'                        //      'Bound on regional costs by type'    
REG_CUMCST      .'Par'.'ALL_REG,ALLYEAR,1,2,CUR,LIM'                      //      'Cumulative bound on regional costs' 
REG_FIXT        .'Par'.'ALL_REG'                                          //      'ALLYEAR up to which periods are fixed'
RPT_OPT         .'Par'.'1,2'                                              //      ''
S_CAP_BND       .'Par'.'ALL_REG,ALLYEAR,PRC,LIM,1,2'                      //        'Bound on total installed capacity'  
S_CM_CONST      .'Par'.'1,2,3'                                            //      ''
S_CM_MAXC       .'Par'.'ALLYEAR,1,2,3'                                    //    'Maximum allowable climatic quantity' 
S_CM_MAXCO2C    .'Par'.'ALLYEAR,1,2'                                      //        'Maximum allowable atmospheric CO2 concentration' 
S_COM_CUMNET    .'Par'.'ALL_REG,ALLYEAR,1,COM_GRP,LIM,2,3'                //      'Cumulative limit on COMNET' 
S_COM_CUMPRD    .'Par'.'ALL_REG,ALLYEAR,1,COM_GRP,LIM,2,3'                //      'Cumulative limit on COMPRD' 
S_COM_FR        .'Par'.'ALL_REG,ALLYEAR,COM_GRP,ALL_TS,1,2'               //      ''
S_COM_PROJ      .'Par'.'ALL_REG,ALLYEAR,COM_GRP,1,2'                      //        'Demand scenario projection'  
S_COM_TAX       .'Par'.'ALL_REG,ALLYEAR,COM_GRP,ALL_TS,1,CUR,2,3'         //      'Tax on commodity NET/PRD' 
S_DAM_COST      .'Par'.'ALL_REG,ALLYEAR,COM_GRP,CUR,1,2'                  //        'Damage costs'
S_FLO_CUM       .'Par'.'ALL_REG,PRC,COM_GRP,ALLYEAR,1,LIM,2,3'            //        'Cumulative limit on FLOW' 
S_FLO_FUNC      .'Par'.'ALL_REG,ALLYEAR,PRC,COM_GRP,1,2,3'                //      'Uncertain multiplier of process transformation'
S_NCAP_AFS      .'Par'.'ALL_REG,ALLYEAR,PRC,ALL_TS,1,2'                   //      ''
S_NCAP_COST     .'Par'.'ALL_REG,ALLYEAR,PRC,1,2'                          //        'Uncertain multiplier of investment cost' 
S_UC_RHS        .'Par'.'UC_N,LIM,1,2'                                     //        'RHS of user constraint'  
S_UC_RHSR       .'Par'.'ALL_REG,UC_N,LIM,1,2'                             //        'RHS of user constraint' 
S_UC_RHSRT      .'Par'.'ALL_REG,UC_N,ALLYEAR,LIM,1,2'                     //        'RHS of user constraint' 
S_UC_RHSRTS     .'Par'.'ALL_REG,UC_N,ALLYEAR,ALL_TS,LIM,1,2'              //        'RHS of user constraint' 
S_UC_RHST       .'Par'.'UC_N,ALLYEAR,LIM,1,2'                             //        'RHS of user constraint' 
S_UC_RHSTS      .'Par'.'UC_N,ALLYEAR,ALL_TS,LIM,1,2'                      //        'RHS of user constraint' 
S_UCOBJ         .'Par'.'UC_N,1'                                           //        'Weight of UC objective component in tradeoff analysis' 
SC0             .'Par'.'ALL_REG,PRC'                                      //      ''
SEG             .'Par'.'ALL_REG,PRC'                                      //      ''
SHAPE           .'Par'.'1,2'                                              //        'Shaping table'       
STG_CHRG        .'Par'.'ALL_REG,ALLYEAR,PRC,ALL_TS'                       //        'Exogeneous charging of a storage technology ' 
STG_EFF         .'Par'.'ALL_REG,ALLYEAR,PRC'                              //        'Storage efficiency'       
STG_LOSS        .'Par'.'ALL_REG,ALLYEAR,PRC,ALL_TS'                       //        'Annual energy loss from a storage technology' 
STG_MAXCYC      .'Par'.'ALL_REG,ALLYEAR,PRC'                              //        'Maximum number of storage cycles over lifetime' 
STG_SIFT        .'Par'.'ALL_REG,ALLYEAR,PRC,COM_GRP,ALL_TS'               //        'Max load sifting in proportion to total load' 
STGIN_BND       .'Par'.'ALL_REG,ALLYEAR,PRC,COM_GRP,ALL_TS,LIM'           //        'Bound on output-flow of storage process'      
STGOUT_BND      .'Par'.'ALL_REG,ALLYEAR,PRC,COM_GRP,ALL_TS,LIM'           //        'Bound on output-flow of storage process'      
SW_LAMBDA       .'Par'.''                                                 //      ''  
SW_PROB         .'Par'.'1'                                                //      ''
SW_SPROB        .'Par'.'1,2'                                              //      ''
SW_START        .'Par'.'1'                                                //      ''
SW_SUBS         .'Par'.'1,2'                                              //      ''
TM_ARBM         .'Par'.''                                                 //      ''  
TM_DEFVAL       .'Par'.''                                                 //      ''  
TM_DEPR         .'Par'.'ALL_REG'                                          //        'Depreciation rate'
TM_DMTOL        .'Par'.'ALL_REG'                                          //        'Demand lower bound factor'
TM_ESUB         .'Par'.'ALL_REG'                                          //        'Elasticity of substitution'     
TM_EXPBND       .'Par'.'ALL_REG,ALLYEAR,PRC'                              //        'Market Penetration Cutoff for Applying Cost Penalty'        
TM_EXPF         .'Par'.'ALL_REG,ALLYEAR'                                  //        'Annual percent expansion factor'
TM_GDP0         .'Par'.'ALL_REG'                                          //        'Initial GDP'
TM_GR           .'Par'.'ALL_REG,ALLYEAR'                                  //        'Growth rate'
TM_IVETOL       .'Par'.'ALL_REG'                                          //        'Investment and enery tolerance' 
TM_KGDP         .'Par'.'ALL_REG'                                          //        'Initial capital to GDP ratio'
TM_KPVS         .'Par'.'ALL_REG'                                          //        'Capital value share'            
TM_QFAC         .'Par'.'ALL_REG'                                          //        'Switch for market penetration penalty function'             
TM_SCALE_CST    .'Par'.''                                                 //      ''  
TM_SCALE_NRG    .'Par'.''                                                 //      ''  
TM_SCALE_UTIL   .'Par'.''                                                 //      'Scaling factor utility function'                            
TS_CYCLE        .'Par'.'ALL_REG,ALL_TS'                                   //        'Length of cycles below timeslice, in days' 
UC_ACT          .'Par'.'UC_N,1,ALL_REG,ALLYEAR,PRC,ALL_TS'                //    'Multiplier of activity variables' 
UC_ACTBET       .'Par'.'UC_N,ALL_REG,ALLYEAR,PRC'                         //      ''
UC_CAP          .'Par'.'UC_N,1,ALL_REG,ALLYEAR,PRC'                       //        'Multiplier of capacity variables'    
UC_CLI          .'Par'.'UC_N,1,ALL_REG,ALLYEAR,1'                         //      'Climate variable'                    
UC_COMCON       .'Par'.'UC_N,1,ALL_REG,ALLYEAR,COM_GRP,ALL_TS'            //        'Multiplier of VAR_COMCON variables' 
UC_COMNET       .'Par'.'UC_N,1,ALL_REG,ALLYEAR,COM_GRP,ALL_TS'            //        'Multiplier of VAR_COMNET variables' 
UC_COMPRD       .'Par'.'UC_N,1,ALL_REG,ALLYEAR,COM_GRP,ALL_TS'            //        'Multiplier of VAR_COMPRD variables' 
UC_CUMACT       .'Par'.'UC_N,ALL_REG,PRC,ALLYEAR,1'                       //        'Multiplier of cumulative process activity variable' 
UC_CUMCOM       .'Par'.'UC_N,ALL_REG,1,COM_GRP,ALLYEAR,2'                 //        'Multiplier of cumulative commodity variable' 
UC_CUMFLO       .'Par'.'UC_N,ALL_REG,PRC,COM_GRP,ALLYEAR,1'               //        'Multiplier of cumulative process flow variable' 
UC_FLO          .'Par'.'UC_N,1,ALL_REG,ALLYEAR,PRC,COM_GRP,ALL_TS'        //    'Multiplier of flow variables' 
UC_FLOBET       .'Par'.'UC_N,ALL_REG,ALLYEAR,PRC,COM_GRP'                 //      ''
UC_IRE          .'Par'.'UC_N,1,ALL_REG,ALLYEAR,PRC,COM_GRP,ALL_TS,2'      //        'Multiplier of inter-regional exchange variables' 
UC_NCAP         .'Par'.'UC_N,1,ALL_REG,ALLYEAR,PRC'                       //    'Multiplier of VAR_NCAP variables' 
UC_RHS          .'Par'.'UC_N,LIM'                                         //        'Constant in user constraint'  
UC_RHSR         .'Par'.'ALL_REG,UC_N,LIM'                                 //        'Constant in user constraint'  
UC_RHSRS        .'Par'.'ALL_REG,UC_N,ALL_TS,LIM'                          //        'Constant in user constraint'  
UC_RHSRT        .'Par'.'ALL_REG,UC_N,ALLYEAR,LIM'  
UC_RHSRTS       .'Par'.'ALL_REG,UC_N,ALLYEAR,ALL_TS,LIM'                  //        'Constant in user constraint'  
UC_RHSS         .'Par'.'UC_N,ALL_TS,LIM'                                  //        'Constant in user constraint'  
UC_RHST         .'Par'.'UC_N,ALLYEAR,LIM'                                 //        'Constant in user constraint'  
UC_RHSTS        .'Par'.'UC_N,ALLYEAR,ALL_TS,LIM'                          //        'Constant in user constraint'  
UC_TIME         .'Par'.'UC_N,ALL_REG,ALLYEAR'                             //        'Multiplier of time in model periods'
UC_UCN          .'Par'.'UC_N,1,ALL_REG,ALLYEAR,UC_N'                      //        'Multiplier of user constraint variable' 
VDA_CEH         .'Par'.'ALL_REG,ALLYEAR,PRC'                              //        'The slope of pass-out turbine'
VDA_EMCB        .'Par'.'ALL_REG,ALLYEAR,COM_GRP,1'                        //        'Combustion emission'
VDA_FLOP        .'Par'.'ALL_REG,ALLYEAR,PRC,COM_GRP,ALL_TS'               //        'General process transformation'
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

$offEmbeddedCode
$if not errorFree $stop
$LOG ### CUBEINPUTDOM=%sysenv.CUBEINPUTDOM%

*############################################################################################
*#  2) LOAD DATA                                                                            #
*#     a) if run through MIRO, the data will be loaded from the MIRO App                    #
*#     b) if run through Studio, data specified via --DATASET will be read, a GDX file that #
*#        can be loaded into the MIRO app will be created and then the run terminates.      #
*############################################################################################

alias (*, UC_N, ALL_REG, ALLYEAR, PRC, COM_GRP, ALL_TS, LIM, CUR);
set scenario 'TIMES Scenario';
set ddorder 'Order index for DD Files' / 1*500 /;

$onExternalInput
set           solveropt(*,*,*)  'Solver options'                                 / cplex.(scaind.0,  rerun.yes, iis.yes, lpmethod.4, baralg.1,
                                                                                  barcrossalg.1, barorder.2, threads.8)
                                                                                  gurobi.method.2/;
singleton set gmsSolver(*)      'Solver for TIMES'                               / cplex /;
singleton set gmsTIMESsrc(*)    'Location of TIME source'                        / '' '' /; // leave at '' for default
scalar        gmsResLim         'Time limit for solve'                           / 1000 /;
scalar        gmsBRatio         'Basis indicator'                                / 1 /;
singleton set gmsRunOpt(*)      'Selection for local, short and long NEOS queue' / local /; // local, short, long
singleton set gmsddlocation(*)  'Location of DD files'                           / '' /;
singleton set gmsrunlocation(*) 'Location of Run file'                           / '' /;
$offExternalInput

$onEmpty
$if not set DATASET $set DATASET demo
$ifthen.data %DATASET%==dk
$include dkdata
$elseif.data %DATASET%==starter
$set DDPREFIX D:\Users\mbussieck\Downloads\times_starter\
$include starterdata
$elseif.data %DATASET%==starter_extended
$set DDPREFIX C:\Users\Fred\Documents\ffiand_TIMES_MIRO\GAMS_WrkMIRO\
$include starterdata_extended
$elseif.data %DATASET%==starter20200621
$set DDPREFIX C:\Users\Fred\Documents\ffiand_TIMES_MIRO\GAMS_WrkMIRO20200621\
$include starterdata20200621
$elseif.data %DATASET%==swiss
$set DDPREFIX E:\WC\TIMES_MIRO\swiss\
$include swissdata.gms
$elseif.data  %DATASET%==mydata
* Fill in your data
$onExternalInput
$offExternalInput
$else.data
$onExternalInput
set           dd                              'DD Files'                      / base,newtechs,trade_param,dem_ref,syssettings,peak_rsv,
                                                                                refinery,demproj_dtcar,uc_nuc_maxcap,bounds-uc_wsets /;
set           scenddmap(scenario<,ddorder,dd) 'Scenario DD File map'          / demo12.(#ddorder:#dd) /;
set           offeps(dd)                      'dd read under offeps'          / /;                                         
set           TimeSlice                       'ALL_TS'                        / ANNUAL,S,W,SD,SN,WD,WN/ ;
set           MILESTONYR                      'Years for this model run'      / 2005, 2010, 2015, 2020, 2030, 2050 /;
scalar        gmsBOTime                       'Adjustment for total available time span of years available in the model' / 1960 /;
scalar        gmsEOTime                       'Adjustment for total available time span of years available in the model' / 2200 /;
set           gmsRunScenario(scenario)        'Selected scenario'             / demo12 /;
set           extensions(*,*,*)               'TIMES Extensions'              / ''.(REDUCE.YES, DSCAUTO.YES, VDA.YES, DEBUG.NO, DUMPSOL.NO,
                                                                                SOLVE_NOW.YES, XTQA.YES, VAR_UC.YES, SOLVEDA.YES, DATAGDX.YES,
                                                                                VEDAVDD.YES) /;
singleton set gmsObj(*)      'Choice of objective function formulations'      / 'MOD' /; // ALT, AUTO, LIN, MOD, STD
$onMulti
singleton set gmsddlocation(*)                'Location of DD files'          / '' 'TIMES_Demo/model/'/;
singleton set gmsrunlocation(*)               'Location of Run file'          / '' 'TIMES_Demo/model/demo12.run'/;
$offMulti
$offExternalInput
$endif.data
$onExternalInput
parameter     cubeInput(%sysEnv.CUBEINPUTDOM%) / /;
set           dd_PRC_DESC(*,*,*) /  /
              dd_COM_DESC(*,*,*) /  /;
* Skipped VDA DATAGDX VEDAVDD 
$offExternalInput
$offEmpty

$onExternalOutput
alias (*,soName,sow,Vintage)
parameter cubeOutput(scenario,soName,sow,COM_GRP,PRC,ALLYEAR,ALL_REG,Vintage,ALL_TS,UC_N);
$offExternalOutput

$eval.set DDPREFIX gmsddlocation.te
$eval.set RUNFILE gmsrunlocation.te
$setNames "%RUNFILE%" fp fn fe

*if this file is run through Studio and command line parameter is not set, the data from the *.dd files specified above will
*be translated into a GDX file that can be imported into MIRO
$ifThenE sameas("x%gams.IDCGDXInput%","x")or(card(dd)=0)
* 2b) read data from *.dd files specified above
* FF: Shouldnt this be onEchoV?
$onecho > "%gams.scrDir%mkdd.%gams.scrExt%"
$onmulti
$oneps
$include "%mydd%"
$offecho
$onMulti
$ifThenE.card_dd card(dd)=0
set           solveropt(*,*,*)  'Solver options'                                 / cplex.(scaind.0,  rerun.yes, iis.yes, lpmethod.4, baralg.1,
                                                                                  barcrossalg.1, barorder.2, threads.8)
                                                                                  gurobi.method.2/;
singleton set gmsSolver(*)      'Solver for TIMES'                               / cplex /;
singleton set gmsTIMESsrc(*)    'Location of TIME source'                        / '' '' /; // leave at '' for default
scalar        gmsResLim         'Time limit for solve'                           / 1000 /;
scalar        gmsBRatio         'Basis indicator'                                / 1 /;
singleton set gmsRunOpt(*)      'Selection for local, short and long NEOS queue' / local /; // local, short, long
$onembeddedCode Python:
import glob
gams.wsWorkingDir = '.'
run_name = os.path.splitext(os.path.basename(r'%runfile%'))[0]
print(r"### Analyzing Run File %runfile%")
with open(r'%runfile%') as frun:
  rl = frun.readlines()
scenddmap = []
ddcnt = 1
codecnt = 1
recordcode = 0
extensions = []
print("### Start writing myrun.gms")
with open('myrun.gms','w') as frun:
  for l in rl:
    if len(l.rstrip()) == 0 or l[0]=="*":
      continue
    if 'batinclude' in l.lower():
      if '_ts.dd' in l.lower():
        frun.write(l)
      elif '.dd' in l.lower():
        scenddmap.append((run_name,str(ddcnt),l.split(' ')[1].split('.dd')[0]))
        ddcnt += 1
      elif 'maindrv.mod' in l.lower():
        recordcode = 2
        codecnt = 1
    else:
      if (recordcode > 0) and (not 'run_name' in l.lower()) and (not 'vedavdd' in l.lower()):
        if recordcode == 1:
          extensions.append(('','premain',str(codecnt),l.rstrip()))
        else:
          extensions.append(('','postmain',str(codecnt),l.rstrip()))
        codecnt += 1
      else:
        if 'milestonyr' in l.lower():
          recordcode = 1
        if not '$if' in l.lower():
          frun.write(l)
  frun.write('$show\n')
print("### execute gams myrun.gms ... and create myrun.gdx")  
cmd = 'gams myrun.gms a=c ps=0 pw=512 gdx=myrun.gdx idir "' + r'%DDPREFIX% '.rstrip() + '"'
rc = os.system(cmd)
if not rc == 0:
   raise NameError('Problem running myrun. Inspect myrun.lst')
# Read timeslice, need to be first UELs
print("### Read myrun.gdx")
db = gams.ws.add_database_from_gdx('myrun.gdx')
db['ALL_TS'].copy_symbol(gams.db['TimeSlice'])
dd = []
offeps = []
for df in glob.glob(r'%DDPREFIX% '.rstrip()+'*.dd'):
   if not '_ts.dd' in df:
     ddbase = os.path.splitext(os.path.basename(df))[0]
     s = 'grep -i offeps "' + df + '" > ' + os.devnull
     rc = os.system(s)
     if 0 == rc:
       offeps.append(ddbase)
     dd.append(ddbase)
gams.set('dd',dd)
gams.set('offeps',offeps)
db['MILESTONYR'].copy_symbol(gams.db['MILESTONYR'])
gams.set('gmsRunScenario',[run_name])
gams.set('scenddmap',scenddmap)
# process myrun.lst for compile time variables
print("### Process myrun.lst for compile time variables")
with open('myrun.lst') as flst:
  rl = flst.readlines()
start = [i for i, s in enumerate(rl) if 'Level SetVal' in s][0]+2
print("### Compile time variable report starts in line ", start)
end = [i for i, s in enumerate(rl) if 'End of Compile-time Variable List' in s][0]
print("### Compile time variable report ends in line   ", end)
while start<end:
  vl = rl[start].split()
  if vl[1].lower() == 'obj':
    gams.set('gmsObj',[vl[3]])
  elif vl[1].lower() == 'botime':
    gams.set('gmsBOTime',[float(vl[3])])
  elif vl[1].lower() == 'eotime':
    gams.set('gmsEOTime',[float(vl[3])])
  elif vl[1].lower() == 'run_name':
    pass
  else:
    val = ' '.join(vl[3:])
    extensions.append(('',vl[1],val,''))
  start += 1
gams.set('extensions',extensions)
$offembeddedcode TimeSlice dd MILESTONYR scenddmap gmsRunScenario offeps gmsBOTime gmsEOTime extensions gmsObj
$endif.card_dd

$onEmbeddedCode Python:
gams.wsWorkingDir = '.'
do_print = False
dd_db = {}
print("\n### cube domain = " + str(os.environ['CUBEINPUTDOM']))
domlist = str(os.environ['CUBEINPUTDOM']).split(",")
dd_idx  = domlist.index("dd")
reg_idx = domlist.index("ALL_REG")
prc_idx = domlist.index("PRC")
com_idx = domlist.index("COM_GRP")
print("### dd_idx  = " , dd_idx)
print("### reg_idx = " , reg_idx)
print("### prc_idx = " , prc_idx)
print("### com_idx = " , com_idx)

print("### Turning dd files into gdx files")
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
  print("### " + dd + ".dd --> " + dd + ".gdx")
noDD = []
for cdRec in cd_input:
  sym = cdRec[0]
  typ = cdRec[1]
  someDD = False
  if cdRec[2]=='':
    dom = []
  else:
    dom = cdRec[2].split(',')
  d_map = [(idx[0],dinput_map[idx[1]]) for idx in zip(range(len(dom)),dom)]
  for dd in gams.get('dd'):
    try:
      dd_sym = dd_db[dd][sym]
    except:
      if do_print: gams.printLog('No ' + sym + ' in ' + dd)
      continue
    key = [sym,typ,dd] + ['-']*(len(xidom)+max_inputExtra)
    someDD = True
    if not dd_sym.dimension==len(dom):
      raise NameError('Dimension mismatch for ' + sym + ' in ' + dd + ': ' + str(dd_sym.dimension) + '<>' + str(len(dom)))
    for r in dd_sym:
      rkey = r.keys
      for idx in d_map:
        key[idx[1]] = rkey[idx[0]]
      if cdRec[1]=='Par':
        gams.db['cubeInput'].add_record(key).value = r.value
        if do_print: gams.printLog(str(key)+' '+str(r.value))
      else:
        gams.db['cubeInput'].add_record(key).value = 1
        if do_print: gams.printLog(str(key))
        if "PRC_DESC" == str(key[0]):
           gams.db['dd_PRC_DESC'].add_record([dd,key[reg_idx],key[prc_idx]]).text = r.text
           if do_print: gams.printLog("dd_PRC_DESC(" + str(key[dd_idx]) + " , " + str(key[reg_idx]) + " , " + str(key[prc_idx]) + ") : " + r.text )
        if "COM_DESC" == str(key[0]):
           gams.db['dd_COM_DESC'].add_record([dd,key[reg_idx],key[com_idx]]).text = r.text
           if do_print: gams.printLog("dd_COM_DESC(" + str(key[dd_idx]) + " , " + str(key[reg_idx]) + " , " + str(key[com_idx]) + ") : " + r.text )   
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
$offEmbeddedCode cubeInput dd_PRC_DESC dd_COM_DESC
$gdxOut "%fp%%fn%.gdx"
$unLoad
$gdxOut
$log ---
$log --- Scenario exported to "%fp%%fn%.gdx". Please import into MIRO.
$log ---
$else
* 2a) load data from MIRO
$onEPS
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



*######################################
*#  3) Write TIMES Data (*.dd files)  #
*######################################

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


*#############################################
*#  4) Write TIMES Driver (timesdriver.gms)  #
*#############################################
$eval.set GMSSOLVER   gmsSolver.tl
$eval.set GMSTIMESSRC gmsTIMESsrc.te
$if "x%GMSTIMESSRC%"=="x" $set GMSTIMESSRC %gams.idir1%times_model%system.dirsep%
$eval     GMSRESLIM   gmsResLim   
$eval     GMSBRATIO   gmsBRatio   
$eval     GMSBOTIME   gmsBOTime  
$eval     GMSEOTIME   gmsEOTime   
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
    ext = {'obj':'%GMSOBJ%', 'botime':'%GMSBOTIME%', 'eotime':'%GMSEOTIME%', 'milestonyr':','.join(gams.get('MILESTONYR'))}
    for er in gams.get('extensions',keyFormat=KeyFormat.FLAT, valueFormat=ValueFormat.FLAT):
      if er[0] == '':
        if er[1].lower() in ['premain','postmain']:
          ext[er[1].lower()+er[2]] = er[3]
        else:
          ext[er[1].lower()] = er[2]
    for er in gams.get('extensions'):
      if er[0].lower() == '%GMSRUNNAME%'.lower():
        if er[1].lower() in ['premain','postmain']:
          ext[er[1].lower()+er[2]] = er[3]
        else:
          ext[er[1].lower()] = er[2]
    for er in ext.items():
      if not (er[0] == 'milestonyr' or 'premain' in er[0] or 'postmain' in er[0]):
        td.write('$set '+er[0].upper() +' '+er[1]+'\n')
    td.write('$onMulti\nset ALL_TS /\n')
    for tsr in gams.get('TimeSlice'):
      td.write(tsr + '\n')
    td.write('/;\n$batInclude initsys.mod\n$batInclude initmty.mod\n')
    for ddr in gams.get('orderactdd'):
      td.write('$batInclude ' + ddr[1] + '.dd\n')
    td.write('\nSet MILESTONYR / ' + ext['milestonyr'] + '/;\n')
    os.environ['GMSSTAGES'] = ext.get('stages', 'no').upper()
    for i in range(50):
      s = ext.get('premain'+str(i+1), '')
      if '' == s:
        break
      td.write(s+'\n')
$offEmbeddedCode
$onecho >> timesdriver.gms 
$set RUN_NAME %GMSRUNNAME%
$batInclude maindrv.mod mod
$offecho
$onEmbeddedCode Python:
with open('timesdriver.gms', 'a+') as td:
    for i in range(50):
      s = ext.get('postmain'+str(i+1), '')
      if '' == s:
        break
      td.write(s+'\n')
$offEmbeddedCode

*#####################################################################
*#  5) Execute TIMES driver                                          #
*#     a) execute locally                                            #
*#     b) compile locally and submit workfile to NEOS for execution  # 
*#####################################################################
* 5a) execute locally
$ifThenI.localSolve %GMSRUNOPT%==local
$  call.checkErrorLevel gams timesdriver.gms idir1=%GMSTIMESSRC% lo=%gams.lo% filecase=2 er=99 ide=1 o=solve.lst gdx=out.gdx
$else.localSolve
* 5b) compile locally and submit workfile to NEOS
$  call.checkErrorLevel gams timesdriver.gms idir1=%GMSTIMESSRC% lo=%gams.lo% filecase=2 er=99 ide=1 a=c xs=times.g00
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

*###############################################
*#  6) Collect results and prepare output cube # 
*###############################################

$log --- Collecting result for scenario %GMSRUNNAME%
$ifThen.stages %sysEnv.GMSSTAGES% == NO
$  call.checkErrorLevel gdx2veda out.gdx %GMSTIMESSRC%times2veda.vdd
$else.stages
$  call.checkErrorLevel gdx2veda out.gdx %GMSTIMESSRC%times2veda_stc.vdd
$endif.stages

$onMulti
$oneps
$onembeddedCode Python:
import csv
gams.wsWorkingDir = '.'
have_stages = os.environ['GMSSTAGES'] == 'YES'
with open('out.vd', newline='') as csvfile:
    vddreader = csv.reader(csvfile, delimiter=',', quotechar='"')
    for row in vddreader:
        if len(row)>0 and not row[0][0] == '*':
            if have_stages:
                key = ['%GMSRUNNAME%'] + row[:-1]
            else:
                key = ['%GMSRUNNAME%',row[0],'-'] + row[1:-1]
            gams.db['cubeOutput'].add_record(key).value = float(row[-1])
$offEmbeddedCode cubeOutput
$offMulti
$if exist ./solve.lst $hiddencall mv -f solve.lst solve%SCENCNT%.lst
$eval SCENCNT %SCENCNT%+1
$ifE %SCENCNT%<=card(gmsRunScenario) $goto SCENLOOPSTART
scalar cnt /0/;
loop(gmsRunScenario, cnt=cnt+1; put_utility 'incMsg' / 'solve' cnt:0:0 '.lst');
$endif
