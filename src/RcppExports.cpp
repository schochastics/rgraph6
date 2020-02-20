// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

// b2d
double b2d(NumericVector x);
RcppExport SEXP _rgraph6_b2d(SEXP xSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< NumericVector >::type x(xSEXP);
    rcpp_result_gen = Rcpp::wrap(b2d(x));
    return rcpp_result_gen;
END_RCPP
}
// d2b
std::vector<double> d2b(int x);
RcppExport SEXP _rgraph6_d2b(SEXP xSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< int >::type x(xSEXP);
    rcpp_result_gen = Rcpp::wrap(d2b(x));
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_rgraph6_b2d", (DL_FUNC) &_rgraph6_b2d, 1},
    {"_rgraph6_d2b", (DL_FUNC) &_rgraph6_d2b, 1},
    {NULL, NULL, 0}
};

RcppExport void R_init_rgraph6(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}