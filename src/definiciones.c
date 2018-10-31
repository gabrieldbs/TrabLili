#include "definiciones.h"
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>
/*
//---------------------------------------------//
	Lo primero que defino es el Ka		
	COMO PH= PKA +LOG (BASE/ACIDO)
	Y KA =10^-PKA
	ENTONCES QUEDA KA EN FUNCION DE PH, ACIDO Y BASE, QUE VAN A SER DATOS
//--------------------------------------------// */
double Ka_o(double ph,double base,double acido){
	double pka,ka_o;
	pka=ph - log (base/acido);
	ka_o=pow(10,-pka);
	return(ka_o);
}

//--------------------------------------//
/*
	DEFINO KD
*/
//---------------------------------//
double Kd_o(double beta,double muep_o,double mueo_o,double muha_o){
	double kd_o;
	kd_o=exp(-beta*(-muep_o+mueo_o+muha_o));
	return(kd_o);
}

//-------------------------------------//
/*
	DEFINO LAS FRACCIONES TENGO 5 VINNCULOS Y 5 FRACCIONES

1	FHAC +FA +FHAP=1
2	FEO+FEOP=1
3	FEOP=FEO
4	FA RO/FHA =KAO/VH
5	FEP/FEORHOFHA =VPA/KD

*/
//------------------------------------//

double alpha (double rho_o,double ka_o,double kd_o,double rho_h,double v_h,double v_p){
	double alpha;
	alpha=(kd_o*(ka_o+rho_h*v_h))/(v_p*rho_o*rho_h*v_h) ;
 return(alpha);
}

double fhap_a(double alpha){
	double fhap_a;
	fhap_a= 1+alpha*0.5+0.5*pow((alpha*(alpha+2)),0.5);
}
double fhap_b(double alpha){
	double fhap_b;
	fhap_b= 1+alpha*0.5-0.5*pow((alpha*(alpha+2)),0.5);
}

double feop(double fhap){
	double feop;
	feop=fhap;
	return(feop);
}

double feo(double fhap){
	double feo;
	feo=1-fhap;
	return(feo);
}

double fha(double fhap,double kd_o ,double rho_o, double v_p){
	double fha;
	fha= fhap*kd_o/(rho_o*(1-fhap)*v_p );
	return(fha);
}

double fa(double fhap,double rho_h,double v_h,double ka_o){
	double fa;
	fa=(1-fhap)*rho_h*v_h/(ka_o+rho_h*v_h);
	return(fa);
}

double ener_conf(rho_a,rho_h,v_a,v_h,mua_o,muh_o){
	double ener_conf,cont_a,cont_b;
	
	return(ener_conf);
}
/*
	Defino todas las constantes en un mismo lugar para que sea mas comodo

double constantes(){
	
	va=1;
	vh=1;
	mua_o=1;
	muh_o=1;
	mupa_o=1;
	rho_o=1;		
	vp=1;
	mueo_o=1;
	muhac_o=1;
	muac_o=1
	qa=1;
	qh=1;
	qac=-1;
	psi=1;
	return(0);
}

double elibre(){
	

	return(0);
}
*/

