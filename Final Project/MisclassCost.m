function m = MisclassCost(R, n,C)
v_r=length(R.I)/n;
[p_r, c_r, r_r]=ClassDistr(C,R.I);
m=v_r*r_r;
end