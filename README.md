More About Covariance Descriptors for Image Set Coding: Log-Euclidean Framework based Kernel Matrix Representation

Written by Kai-Xuan Chen (e-mail: kaixuan_chen_jsh@163.com)   

Please cite the following paper (more theoretical and technical details) if your are using this code:

Kai-Xuan Chen, Xiao-Jun Wu，Jie-Yi Ren, Rui Wang, Josef Kittler. More About Covariance Descriptors for Image Set Coding: Log-Euclidean Framework based Kernel Matrix Representation[C]// Proceedings of the IEEE international conference on computer vision workshops, 2019.


BibTex : 
```
@inproceedings{chen2019more,
  title={More About Covariance Descriptors for Image Set Coding: Log-Euclidean Framework based Kernel Matrix Representation},
  author={Kai-Xuan Chen, Xiao-Jun Wu，Jie-Yi Ren, Rui Wang, Josef Kittler},
  booktitle={Proceedings of the IEEE international conference on computer vision workshops},
  year={2019}
} 
```

The ETH-80 dataset is needed to be downloaded(https://github.com/Kai-Xuan/ETH-80/),  
and put 8 filefolders(visual image sets from 8 different categories) into filefolder '.\ETH-80\'.  
Please run 'read_ETH.m' to generate Kernel Matrix Representation. Then run 'run_ETH.m' for image set classification.  


For classification, we employ four NN classifiers and one discriminative classifiers in this source code.  

Ker-SVM : Qilong Wang implemented a one-vs-all classifier by using LIBSVM package in the paper:  
Q. Wang, P. Li, W. Zuo, and L. Zhang. Raid-g: Robust estimation of approximate infinite dimensional gaussian with application to material recognition. In Proceedings of the IEEE Conference on Computer Vision and Pattern Recognition, pages 4433-4441, 2016.  
Chih-Chung Chang and Chih-Jen Lin. Libsvm: a library for support vector machines. ACM transactions on intelligent systems and technology
(TIST), 2(3):27, 2011.