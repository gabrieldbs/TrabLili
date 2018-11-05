#ifndef DEFINICIONES_H
#define DEFINICIONES_H
double Ka_o(double ph, double base, double acido);
double Kd_o(double beta,double muep_o,double mueo_o,double muha_o);
double feop(double feo);
double feo(double fhap);
double fha(double fhap,double kd_o ,double rho_o, double v_p);
double alpha (double rho_o,double ka_o,double kd_o,double rho_h,double v_h,double v_p);
double fa(double fhap,double rho_h,double v_h,double ka_o);
double fhap(double alpha);
double rho_a_menos(double rho_a,double q_a, double psi);
double ener_conf(double rho_a, double rho_h,double v_a,double v_h,double mua_o,double muh_o);
double rho_h_mas(double rho_h,double q_h, double psi);
#endif
