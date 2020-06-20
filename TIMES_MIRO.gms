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
ACT_BND         .'Par'.'ALL_REG,ALLYEAR,PRC,ALL_TS,1' // 1-Lim 2-Cur 3-Gen
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
'par_ncapr'    . 'par'   . 'ALL_REG,ALLYEAR,PRC,2'
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
'reg_wobj'     . 'par'   . 'ALL_REG,2,COM_GRP'
'reg_obj'      . 'par'   . 'ALL_REG'
'reg_irec'     . 'par'   . 'ALL_REG'
'reg_acost'    . 'par'   . 'ALL_REG,ALLYEAR,2'
'par_ucsl'     . 'par'   . '2,ALL_REG,ALLYEAR,ALL_TS'
'par_ucsm'     . 'par'   . '2,ALL_REG,ALLYEAR,ALL_TS'
'par_ucmrk'    . 'par'   . 'ALL_REG,ALLYEAR,1,COM_GRP,ALL_TS'
'par_ucrtp'    . 'par'   . '2,ALL_REG,ALLYEAR,PRC,COM_GRP'
'par_ucmax'    . 'par'   . '2,ALL_REG,PRC,COM_GRP'
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

alias (*, UC_N, ALL_REG, ALLYEAR, PRC, COM_GRP, ALL_TS);
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
    with open('solver-output.zip', 'wb') as rf:
        rf.write(msg.data)
$  offEmbeddedCode
$  ifthen.dryRun not "x%dryRun%"=="x"
$    call cat "%dryRun%"
$  else.dryRun
$    hiddencall rm -f solve.log solve.lst solve.lxi out.gdx && gmsunzip -qq -o solver-output.zip
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
$offembeddedCode cubeOutput
$offMulti
$if exist ./solve.lst $hiddencall mv -f solve.lst solve%SCENCNT%.lst
$eval SCENCNT %SCENCNT%+1
$ifE %SCENCNT%<=card(gmsRunScenario) $goto SCENLOOPSTART
scalar cnt /0/;
loop(gmsRunScenario, cnt=cnt+1; put_utility 'incMsg' / 'solve' cnt:0:0 '.lst');
$endif
