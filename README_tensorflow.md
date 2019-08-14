# tensorflow without Intel extenstion such as AVX and GPU support  

### Refer many binaries on [Tensorflow Community binary](https://github.com/yaroslavvb/tensorflow-community-wheels/issues)  

### Use whl of [Tensorflow 1.13.1, Ubuntu 16.04, Python 2.7, CPU-only, without AVX #105](https://github.com/yaroslavvb/tensorflow-community-wheels/issues/105)  

- Prerequisite
Ubuntu16.04  
numpy 1.16.0  
python-pip  

```
 # pip install numpy=1.16.0    # because numpy==1.17.0 could be installed
 # pip install https://github.com/maxhgerlach/tensorflow-1.13.1-ubuntu16.04-py27-no_avx-westmere/raw/master/tensorflow-1.13.1-cp27-cp27mu-linux_x86_64.whl
 # python -c "import tensorflow"
 #
 # pip list | grep tensorflow
  tensorboard (1.13.1)
  tensorflow (1.13.1)
  tensorflow-estimator (1.13.0)
 #
```
**Make sure that same version of tensorflow, tensorboard and tensorflow-estimator such as (1.13.x).**  

- Check with **same tensorflow tutorials version**  

```
 $ git clone https://github.com/tensorflow/tensorflow
 $ cd tensorflow/examples/tutorials/mnist
 $ git checkout v1.13.0-rc0
 $ python mnist_with_summaries.py
  Accuracy at step 960: 0.9678
  Accuracy at step 970: 0.9654
  Accuracy at step 980: 0.9669
  Accuracy at step 990: 0.9691
  Adding run metadata for 999
 $
```
 Worked fine!  
 
**14.Aug,2019**  
