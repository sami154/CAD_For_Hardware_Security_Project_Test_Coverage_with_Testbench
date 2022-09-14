#!/usr/bin/bash
# Monitor
function coverage_monitor()
{
  grep "aes " ./urgReport/hierarchy.txt| awk '{print $2 "\t" $3 "\t" $4 "\t" $6}' >> coverage_each_iter.txt
  line_cov=`grep "aes " ./urgReport/hierarchy.txt | awk '{print $2}'`
  cond_cov=`grep "aes " ./urgReport/hierarchy.txt | awk '{print $3}'`
  tgl_cov=`grep "aes " ./urgReport/hierarchy.txt | awk '{print $4}'`
  branch_cov=`grep "aes " ./urgReport/hierarchy.txt | awk '{print $6}'`

echo -en ""$line_cov"\n"$cond_cov"\n"$tgl_cov"\n"$branch_cov"\n" > coverage.txt

sort -n coverage.txt > coverage1.txt

cov_min=$(head -n 1 coverage1.txt)

}

#checker
function threshold_checker()
{

  i=1

  while (( $(echo "$cov_min < $target_cov" | bc -l)  )) 
  do
	
	
	
    vcs -sverilog ../goldedAES_RTL/*.v tb_aes.sv -R +v2k -timescale=1ns/1ps -debug_access+r -full64 -cm line+cond+fsm+tgl+branch -cm_tgl mda -cm_line contassign -cm_cond allops+anywidth+event -cm_name "test$i" +ntb_random_seed_automatic

    urg -lca -dir simv.vdb -show tests -format text

    coverage_monitor

    i=$[$i+1]
   echo "$cov_min"

	
  done
echo "Target Coverage "$target_cov" percent is achieved. Final Coverage "$cov_min""
}

if [ -f "./vcs_aes_output.txt" ] 
then
  rm ./vcs_aes_output.txt 
fi

if [ -d "./simv.vdb" ] 
then 
  rm ./simv.vdb -rf
fi

if [ -d "./urgReport" ] 
then
  rm ./urgReport -rf
fi


target_cov=70
vcs -sverilog ../goldedAES_RTL/*.v tb_aes.sv -R +v2k -timescale=1ns/1ps -debug_access+r -full64 -cm line+cond+fsm+tgl+branch -cm_tgl mda -cm_line contassign -cm_cond allops+anywidth+event -cm_name test1 +ntb_random_seed_automatic

urg -lca -dir simv.vdb -show tests -format text


min_cov=0

coverage_monitor

threshold_checker

