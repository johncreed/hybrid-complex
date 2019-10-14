# Train file path
train='./train'

# Fixed parameter
t=50
wn=1
k=32
c=5
r=0

# Data set
tr='imp_tr.ffm'
va='va.ffm'
item='item.ffm'
model_name="tr.model"

# Log path
log_path="logs"
mkdir -p $log_path


task(){
# Set up fixed parameter and train command
train_cmd="${train} -t ${t} -wn ${wn} -k ${k} -c ${c} -r ${r} --ns"

# Print out all parameter pair
for l in 4
do
    for w in 1e-3 1e-4 1e-5
    do
        cmd=${train_cmd}
        cmd="${cmd} -l ${l}"
        cmd="${cmd} -w ${w}"
        cmd="${cmd} -imp ${model_name}"
        echo "${cmd} -p ${va} ${item} ${tr} > ${log_path}/$l.$w.$r.log"
    done
done
}


# Check command
echo "Check command list (the command may not be runned!!)"
task
wait


# Run
echo "Run"
task | xargs -0 -d '\n' -P 3 -I {} sh -c {} &
