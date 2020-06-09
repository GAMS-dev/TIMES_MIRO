$eolCom //         
set xidom          'Extraordinary input domains'  / UC_N UserConstraint, ALL_REG Region, ALLYEAR Period, PRC Process, COM_GRP Commodity, ALL_TS TimeSlice/
    xodom          'Extraordinary output domains' /                      ALL_REG Region, ALLYEAR Period, PRC Process, COM_GRP Commodity, ALL_TS TimeSlice/
    typ            'symbol type'                  / 'Par', 'Set', 'Equ.l', 'Var.l' / // changes here require changes in Python code
    siName         'domain of input symbol names'
    soName         'domain of output symbol names'
;
Set cdInput(siName<,typ,*) 'Cube Input Data' /
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
dinput_map = { r[1]:r[0]+2 for r in zip(range(len(xidom)),gams.get('xidom')) }
dinput_map.update({ str(i+1):i+len(xidom)+2 for i in range(max_inputExtra)})
os.environ['CUBEINPUTDOM'] = 'siName,dd,' + ','.join(list(gams.get('xidom'))) + ',*'*max_inputExtra

cd_output = list(gams.get('cdOutput'))
xodom = set(gams.get('xodom'))
max_outputExtra = check_and_calc_extra(cd_output, xodom)
doutput_map = { r[1]:r[0]+1 for r in zip(range(len(xodom)),gams.get('xodom')) }
doutput_map.update({ str(i+1):i+len(xodom)+1 for i in range(max_outputExtra)})
os.environ['CUBEOUTPUTDOM'] = 'soName,' + ','.join(list(gams.get('xodom'))) + ',*'*max_outputExtra
$offEmbeddedCode
$if not errorFree $stop

alias (*, UC_N, ALL_REG, ALLYEAR, PRC, COM_GRP, ALL_TS);

$onExternalInput
set           dd            'Scenario'  /base,newtechs,trade_param,dem_ref,syssettings,peak_rsv,refinery,demproj_dtcar,uc_nuc_maxcap,bounds-uc_wsets/;
set           TimeSlice     'ALL_TS'    / ANNUAL,S,W,SD,SN,WD,WN /;
set           MILESTONYR    'Years for this model run' / 2005, 2010, 2015, 2020, 2030, 2050/;
parameter     cubeInput(%sysEnv.CUBEINPUTDOM%);
singleton set gmsSolver(*)  'Solver for TIMES' / cplex /;
scalar        gmsResLim     'Time limit for solve' / 1000 /;
scalar        gmsBRatio     'Basis indicator' / 1 /;
scalar        gmsReduce     'Switch for TIMES reduction algorithm' /1/;
scalar        gmsDSCAuto    'Switch for lumpy investment formulation' /1/;
scalar        gmsDebug      'Switch for debugging files and extended quality assurance checks' /0/;
scalar        gmsDumpSol    'Switch for dumping out selected solution results into a text file' /0/;
scalar        gmsSolveNow   'Switch for entire run (1) versus data check (0)' /1/;
scalar        gmsXTQA       'Switch for quality assurance checks' /1/;
scalar        gmsVarUC      'Switch for explicit use of slack variables in user constraints' /1/;
singleton set gmsObj(*)     'Choice of objective function formulations' / 'MOD' /; // ALT, AUTO, LIN, MOD, STD
scalar        gmsSolVEDA    'Activities and flows as expected values' / 1 /;
scalar        gmsBOTime     'Adjustment for total available time span of years available in the model' / 1960 /;
singleton set gmsRunName    'name of the model run' / demo12 /;
scalar        gmsSolveLocal 'Switch for running locally or on NEOS' / 1 /;
* Skipped VDA DATAGDX VEDAVDD 
$offExternalInput

$onExternalOutput
parameter cubeOutput(%sysEnv.CUBEOUTPUTDOM%);
$offExternalOutput

$ifThen "x%gams.IDCGDXInput%"=="x"
$onExternalInput
$onEmbeddedCode Python:
gams.wsWorkingDir = '.'
do_print = False
dd_db = { dd:gams.ws.add_database_from_gdx(dd+'.gdx') for dd in gams.get('dd') }
noDD = []
for cdRec in cd_input:
  sym = cdRec[0]
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
      key = [sym,dd] + ['\u00A0']*(len(xidom)+max_inputExtra)
      for idx in zip(range(dd_sym.dimension),dom):
        key[dinput_map[idx[1]]] = r.key(idx[0])
      if cdRec[1]=='Par':
        if do_print: gams.printLog(str(key)+' '+str(r.value))
        gams.db['cubeInput'].add_record(key).value = r.value
      else:
        gams.db['cubeInput'].add_record(key).value = 1
        if do_print: gams.printLog(str(key))
  if not someDD:
    noDD.append(sym)
if len(noDD):
  gams.printLog('*** Symbols not in any dd: ' + str(noDD))    
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
$onEmbeddedCode Python:
gams.wsWorkingDir = '.'
gams.ws.my_eps = 0
dd_txt = { dd:open(dd+'.dd','w') for dd in gams.get('dd') }
cube_input = gams.db['cubeInput']
for dd in gams.get('dd'):
  dd_txt[dd].write('$onEmpty\n$onEps\n$onWarning\n$set SCENARIO_NAME "' + dd + '"\n')
last_sym = ''
for cr in cube_input:
  if not cr.key(0)==last_sym:
    if not last_sym=='':
      for dd in gams.get('dd'):
        if dd_sym_written[dd]:
          dd_txt[dd].write('/;\n')
    dd_sym_written = { dd:False for dd in gams.get('dd') }
    last_sym = cr.key(0)
    cdr = next(r for r in cd_input if r[0]==last_sym)
    last_dd = ''
    if cdr[2]=='':
      dom = []
    else:
      dom = cdr[2].split(',')
  if not cr.key(1)==last_dd:
    last_dd = cr.key(1)
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
  
for dd in gams.get('dd'):
  if dd_sym_written[dd]:
    dd_txt[dd].write('/;\n')
  dd_txt[dd].close()
$offEmbeddedCode

$eval.set GMSSOLVER   gmsSolver.tl
$eval     GMSRESLIM   gmsResLim   
$eval     GMSBRATIO   gmsBRatio   
$eval     GMSBOTIME   gmsBOTime   
$eval.set GMSRUNNAME  gmsRunName.tl  
$eval.set GMSOBJ      gmsObj.tl

* YES/NO options
$ifE     1==gmsReduce     $set GMSREDUCE   YES
$ifE     1==gmsDSCAuto    $set GMSDSCAUTO  YES
$ifE     1==gmsDebug      $set GMSDEBUG    YES
$ifE     1==gmsDumpSol    $set GMSDUMPSOL  YES
$ifE     1==gmsSolveNow   $set GMSSOLVENOW YES
$ifE     1==gmsXTQA       $set GMSXTQA     YES
$ifE     1==gmsVarUC      $set GMSVARUC    YES
$ifE     1==gmsSolVEDA    $set GMSSOLVEDA  YES

$ifE not 1==gmsReduce     $set GMSREDUCE    NO
$ifE not 1==gmsDSCAuto    $set GMSDSCAUTO   NO
$ifE not 1==gmsDebug      $set GMSDEBUG     NO
$ifE not 1==gmsDumpSol    $set GMSDUMPSOL   NO
$ifE not 1==gmsSolveNow   $set GMSSOLVENOW  NO
$ifE not 1==gmsXTQA       $set GMSXTQA      NO
$ifE not 1==gmsVarUC      $set GMSVARUC     NO
$ifE not 1==gmsSolVEDA    $set GMSSOLVEDA   NO

$onecho > timesdriver.gms
$Title TIMES -- VERSION 4.1.0
option resLim=%GMSRESLIM%, profile=1, solveOpt=REPLACE, bRatio=1;
option limRow=0, limCol=0, solPrint=OFF, solver=%GMSSOLVER%;
$offListing
$offEcho

* Copy solver option file creation at execution time
$ifThen.slvopt exist %GMSSOLVER%.opt
$onEcho >> timesdriver.gms
file fslvopt / '%GMSSOLVER%.opt' /; put fslvopt;
$onPut
$offEcho
$call cat %GMSSOLVER%.opt >> timesdriver.gms
$echo $offPut   >> timesdriver.gms
$echo putClose; >> timesdriver.gms
$endif.slvopt

$onecho >> timesdriver.gms
$set REDUCE     %GMSREDUCE%
$set DSCAUTO    %GMSDSCAUTO%
$set DEBUG      %GMSDEBUG%
$set DUMPSOL    %GMSDUMPSOL%
$set SOLVE_NOW  %GMSSOLVENOW%
$set XTQA       %GMSXTQA%
$set VAR_UC     %GMSVARUC%
$set SOLVEDA    %GMSSOLVEDA%
$set OBJ        %GMSOBJ%

$set VDA        YES 
$set DATAGDX    YES

$onMulti
set ALL_TS /
$offecho
$onEmbeddedCode Python:
with open('timesdriver.gms', 'a+') as td:
    for tsr in gams.get('TimeSlice'):
      td.write(tsr + '\n')
$offEmbeddedCode
$onecho >> timesdriver.gms 
/;
* perform fixed declarations
$set BOTIME %GMSBOTIME%
$batInclude initsys.mod

* declare the (system/user) empties
$batInclude initmty.mod
$offecho
$onEmbeddedCode Python:
with open('timesdriver.gms', 'a+') as td:
    for ddr in gams.get('dd'):
      td.write('$batInclude ' + ddr + '.dd\n')
    td.write('\nSet MILESTONYR /\n')
    for msr in gams.get('MILESTONYR'):
      td.write(msr + '\n')
$offEmbeddedCode
$onecho >> timesdriver.gms 
/;

$set RUN_NAME %GMSRUNNAME%
$set VEDAVDD YES

* do the rest
$batInclude maindrv.mod mod
$offecho

$ifThenE.localSolve gmsSolveLocal==1
$  call.checkErrorLevel gams timesdriver.gms idir=TIMES_Demo%system.dirsep%source lo=%gams.lo% er=99 ide=1 gdx=out.gdx
$else.localSolve
$  call.checkErrorLevel gams timesdriver.gms idir=TIMES_Demo%system.dirsep%source lo=%gams.lo% er=99 ide=1 a=c s=times.g00
$  set restartFile times.g00
$  set queue       short
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
<priority>%queue%</priority>
<inputType>GAMS</inputType>
<model><![CDATA[]]></model>
<options><![CDATA[]]></options>
<parameters><![CDATA[%gmsOptions%]]></parameters>
<restart><base64>:restartb64:</base64></restart>
<wantlog><![CDATA[yes]]></wantlog>
<wantlst><![CDATA[yes]]></wantlst>
<wantgdx><![CDATA[%wantGDX%]]></wantgdx>
</document>'''

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
    with open('solver-output.zip', 'wb') as rf:
        rf.write(msg.data)
$  offEmbeddedCode
$  ifthen.dryRun not "x%dryRun%"=="x"
$    call cat "%dryRun%"
$  else.dryRun
$    hiddencall rm -f solve.log solve.lst solve.lxi out.gdx && gmsunzip -qq -o solver-output.zip
$  endif.dryRun
$endIf.localSolve

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
    key = [symName] + ['\u00A0']*(len(xodom)+max_outputExtra)
    for idx in zip(range(sym.dimension),dom):
      key[doutput_map[idx[1]]] = r.key(idx[0])
    if cdRec[1]=='Par':
      if do_print: gams.printLog(str(key)+' '+str(r.value))
      gams.db['cubeOutput'].add_record(key).value = r.value
    else: # equ.l or var.L
      if do_print: gams.printLog(str(key)+' '+str(r.value))
      gams.db['cubeOutput'].add_record(key).value = r.level
$offembeddedCode cubeOutput
$endif




