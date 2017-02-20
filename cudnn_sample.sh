#!/usr/bin/bash
cuda=$1
if [ "$cuda"x = ""x ];
then
cuda=7.5
fi
export LD_LIBRARY_PATH=/usr/local/cuda-$cuda/lib64
sudo rm /usr/local/cuda
sudo ln -s /usr/local/cuda-$cuda /usr/local/cuda
cp -r /usr/src/cudnn_samples_v6 ./
cd cudnn_samples_v6
samples="mnistCUDNN RNN"
for sample in $samples
do
        echo "&&&&RUNNING ************************ $sample *************************"
        cd $sample
        make
	if [ "$sample" = "RNN"  ];
	then
        	./$sample 20 2 512 64 0
	else
		./$sample
	fi
	cd ..
done
cd ..
rm -r cudnn_samples_v6
