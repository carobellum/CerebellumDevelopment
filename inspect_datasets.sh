cd /data/project/dev_cereb/data

source /etc/profile.d/modules.sh

mrview /data/project/dev_cereb/data/word/sub-202/anat/sub-202_acq-a_T1w.nii.gz &



# How can I pull up fsleyes on Juseless?
# How can I run fsleyes with the containers?
# Currently I'm downloading aliases from the cluster, but I can't find the actual files

# For now: scp data to local

scp caron@juseless.inm7.de:/data/project/dev_cereb/data/word/sub-211/anat/sub-211_acq-a_T1w.nii.gz /Users/callithrix/Documents/Projects/RaynorDevelopment/data

file=word/sub-211/anat/sub-211_acq-a_T1w.nii.gz
file=word/sub-211/func/sub-211_task-audphono_acq-a_bold.nii.gz
rsync -avh --progress caron@juseless.inm7.de:/data/project/dev_cereb/data/${file} .

ssh -X caron@juseless.inm7.de