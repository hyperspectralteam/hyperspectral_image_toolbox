#include "mex.h"

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    mxDouble *X = mxGetDoubles(prhs[0]);
    
    int n = mxGetM(prhs[0]);
    int d = mxGetN(prhs[0]);
    

    
    const mwSize dims[]={d, d, d};
    
    plhs[0] = mxCreateNumericArray(3, dims, mxDOUBLE_CLASS, mxREAL);
    mxDouble *T = mxGetDoubles(plhs[0]);
    
    int i, j, k, l;
    for(i=0; i<d; i++)
    {
        for(j=0; j<=i; j++)
        {
            for(k=0; k<=j; k++)
            {
                for(l=0; l<n; l++)
                {
                    T[i*d*d+j*d+k] += X[l+i*n] *  X[l+j*n] * X[l+k*n];
                }
                T[i*d*d+j*d+k] = T[i*d*d+j*d+k]  / n;
                T[i*d*d+k*d+j] = T[i*d*d+j*d+k];
                T[j*d*d+i*d+k] = T[i*d*d+j*d+k];
                T[j*d*d+k*d+i] = T[i*d*d+j*d+k];
                T[k*d*d+i*d+j] = T[i*d*d+j*d+k];
                T[k*d*d+j*d+i] = T[i*d*d+j*d+k];
            }
        }
    }
}