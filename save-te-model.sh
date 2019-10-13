#! /bin/bash
. ./init.sh

# Train file path
train='./train'

# Fixed parameter
wn=1
k=32
c=5

# Data setr
tr='trva.ffm'
imp_va='imp_trva.ffm'
item='item.ffm'

# Log path
log_path="save-model"
mkdir -p $log_path


task(){
# Set up fixed parameter and train command
train_cmd="${train} -wn ${wn} -k ${k} -c ${c} --ns"

# Print out all parameter pair
l=16
w=1e-4
r=-5
t=49
model_name="$l.$w.$r.$t.${imp_va}.model"
cmd=${train_cmd}
cmd="${cmd} -l ${l}"
cmd="${cmd} -w ${w}"
cmd="${cmd} -r ${r}"
cmd="${cmd} -t ${t}"
cmd="${cmd} -save-imp ${log_path}/${model_name}"
echo "${cmd} -p ${imp_va} ${item} ${tr} > ${log_path}/$l.$w.$r.${imp_va}.log"
}


# Check command
echo "Check command list (the command may not be runned!!)"
task
wait


# Run
echo "Run"
task | xargs -0 -d '\n' -P 3 -I {} sh -c {} &
