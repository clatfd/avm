%problem 1: small branch inteference
[t1_nodelist,t1_linkfrom,t1_linkto]=loadswc('snake_tracing_mt.swc');
[t2_nodelist,t2_linkfrom,t2_linkto]=loadswc('snake_tracing_mtc.swc');

nsicompare('snake_tracing_mt.swc','snake_tracing_mtc.swc');