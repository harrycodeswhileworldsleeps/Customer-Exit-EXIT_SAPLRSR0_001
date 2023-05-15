*&---------------------------------------------------------------------*
*& Report  ZBW_ZSLDTE1
*&
*&---------------------------------------------------------------------*
*& Author - HXS0615 ( Harsh Sharma ) ENHC0057569
*&
*&---------------------------------------------------------------------*
report zbw_zsldte1.

type-pools rsr.
type-pools rrs0.

*&---------------------------------------------------------------------*
*&      Form  FORM_ Z1YRBCK
*&---------------------------------------------------------------------*
*      -->I_VNAM         Name of Variable to be Replaced
*      -->I_VARTYP       Variable Type (Characteristic Value, Text,
*                         Formula, and so on)
*      -->I_IOBJNM       InfoObject that the Variable Refers to
*      -->I_S_COB_PRO    InfoObject Properties
*      -->I_S_RKB1D      Query Reporting Attribute
*      -->I_PERIV        Query Definition Attribute
*      -->I_T_VAR_RANGE  Variable Input values
*      -->I_STEP         Step value
*      -->E_T_RANGE      Variables Value Table
*      -->E_MEEHT        Unit of Measure (Not Used)
*      -->E_MEFAC        Unit of Measure Factor (Not Used)
*      -->E_WAERS        Currency (Not Used)
*      -->E_WHFAC        Currency Factor (Not Used)
*      -->C_S_CUSTOMER   N/A
*----------------------------------------------------------------------*
form  form_zsldte1 using
                               i_vnam
                               i_vartyp
                               i_iobjnm
                               i_s_cob_pro
                               i_s_rkb1d
                               i_periv
                               i_t_var_range  type  rrs0_t_var_range
                               i_step
                    changing   e_t_range      type rsr_t_rangesid
                               e_meeht
                               e_mefac
                               e_waers
                               e_whfac
                               c_s_customer.
  types: begin of ty_var,
           low  type /bic/oize_varlow,
           high type /bic/oize_varhig,
         end of ty_var.

  data: l_s_range type rsr_s_rangesid,
        t_range   type table of rsr_s_rangesid,
        wa_var    type ty_var,
        it_var    type standard table of ty_var,
        z_date1   type dats,
        z_date2   type dats.

  if i_step = 2.

    select single /bic/ze_varlow /bic/ze_varhig
    from /bic/pze_var
    into ( wa_var-low , wa_var-high )
    where /bic/ze_var = 'SERVICE_DATE'.


    z_date1 = wa_var-low.
    z_date2 = wa_var-high.


    l_s_range-low = z_date1.
    l_s_range-high = z_date2.
    l_s_range-sign      = 'I'.

    l_s_range-opt       = 'BT'.

    append l_s_range to e_t_range.

  endif.
endform.
