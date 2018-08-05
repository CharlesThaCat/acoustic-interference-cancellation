# Daily Logs
## 2018/7/3
* Get basic knowledge about echo cancellation by reading an instruction atricle [*Implementation of an Acoustic Echo Canceller Using Matlab*](http://scholarcommons.usf.edu/cgi/viewcontent.cgi?article=2452&context=etd)
* Configure the git repository
## 2018/7/4
* Code the program main_function.m
* Read a paper [*Acoustic Echo Cancellation Using NLMS-Neural Network Structures*](https://pdfs.semanticscholar.org/de48/88dc9cca6eef62563940b931a66da43a22b2.pdf)
## 2018/7/5
* Read a paper [*Multiple-input neural network-based residual echo suppression*](https://hal.inria.fr/hal-01723630/file/CARBAJAL_ICASSP_2018.pdf)
* Read a paper [*Multilayer Adaptation Based Complex Echo Cancellation And Voice Enhancement*](https://m.media-amazon.com/images/G/01/amazon.jobs/JunYang_ICASSP2018._CB1520904270_.pdf)
* Get the raw acoustic data from mentor
## 2018/7/6
* Read a paper [*Multi-Microphone Acoustic Echo Cancellation using Relative Echo Transfer Functions*](https://www.researchgate.net/publication/321792298_Multi-Microphone_acoustic_echo_cancellation_using_relative_echo_transfer_functions)
* Collect two other papers in realm of the new echo cancellation model
## 2018/7/9
* Read an instruction article [*Adaptive Noise Cancellation*](http://www.cs.cmu.edu/~aarti/pubs/ANC.pdf). Build a new model for adaptive interference cancellation (AIC).
* Download the AIC demo program from [*DSP ALGORITHM*](https://www.dspalgorithms.com/www/aic/aic.php). Test it on the raw acoustic data.
* Try several possible versions of AIC MATLAB code.
## 2018/7/10
* Read the the second chapter and several example programs about echo cancellation in [*User Manual of The Adaptive Signal Processing Toolbox*](https://www.dspalgorithms.com/www/aspt/maspt/aspt.html)
* Create a mind map about how this project is conducted
* Code a usable program using NLMS filter
## 2018/7/11
* Change the step size of NLMS algorithm in my program to make the result better
* Compare the output of AIC demo program from [*DSP ALGORITHM*](https://www.dspalgorithms.com/www/aic/aic.php) with my own program output
* Code a usable program using RLS filter
* Analyze the output of my own program using cool edit with the mentor
## 2018/7/12
* Change the program by using several other adaptive filters and check their usabilities.
* Try to implement the NLMS algorithm without calling the MATLAB build-in function
## 2018/7/13
* Book the ticket of MLA live 2018
## 2018/7/16
* Read a paper providing a frequency-domain-based evaluation and adjustment method to echo cancellation system using adaptive algorithms [*Analysis of Acoustic Feedback & Echo Cancellation in Multiple-Microphone and Single-Loudspeaker Systems using a Power Transfer Function Method*](http://kom.aau.dk/~jje/pubs/jp/guo_et_al_2011_tsp.pdf)
* Change the working focus to subband adaptive filtering AEC and collect some papers
## 2018/7/17
* Read a paper introducing subband echo cancellation using DFT modulation filter bank [*语音系统中的子带自适应回声消除技术*](http://www.doc88.com/p-7337013452161.html)
* Read the principle introduction part of the paper [*A Subband Kalman Filter for Echo Cancellation*](https://scholarsmine.mst.edu/cgi/viewcontent.cgi?article=8483&context=masters_theses)
## 2018/7/18
* Obtain a book named as *Subband Adaptive Filtering* from one of the colleagues
* Read the simulation and result analysis part of the paper [*A Subband Kalman Filter for Echo Cancellation*](https://scholarsmine.mst.edu/cgi/viewcontent.cgi?article=8483&context=masters_theses)
* Comprehend the structure of the given MATLAB implementation of the paper [*A Subband Kalman Filter for Echo Cancellation*](https://scholarsmine.mst.edu/cgi/viewcontent.cgi?article=8483&context=masters_theses)
## 2018/7/19
* Read Chapter 1 of the book *Subband Adaptive Filtering*, comprehend the mathematical essence of adaptive filtering.
* Code a usable program of fullband AIC without calling MATLAB toolbox build-in functions 
## 2018/7/20
* Read Chapter 2 of the book *Subband Adaptive Filtering*
* Spend some time reciting GRE vocabularies
## 2018/7/23
* Read Chapter 2 of the book *Subband Adaptive Filtering*, comprehend the mathematical and coding process of desinging analysis and synthesis filter bank.
* Get all the commonly-used code in the book *Subband Adaptive Filtering*
* Read Chapter 4 of the book *Subband Adaptive Filtering*
## 2018/7/24
* Read Chapter 4 of the book *Subband Adaptive Filtering*, comprehend the structures of adaptive filters in subband domain.
## 2018/7/25
* Read Appendix B of the book *Subband Adaptive Filtering*
* Code a usable program of subband adaptive AIC without calling MATLAB toolbox build-in functions
## 2018/7/26
* Read Chapter 5 of the book *Subband Adaptive Filtering*
## 2018/7/27
* Read Chapter 5 of the book *Subband Adaptive Filtering*
* Spend some time reciting GRE vocabularies and reading articles on *The New Yorker*
## 2018/7/30
* Read Chapter 5 of the book *Subband Adaptive Filtering*, get the knowledge of techniques for improving the performance of subband adptive filter
* Test my program using subband adaptive AIC with raw data from mentor
## 2018/7/31
* Read Chapter 6 of the book *Subband Adaptive Filtering*
* Test the AEC program in *Speex* with raw data from mentor
## 2018/8/1
* Read Chapter 6 of the book *Subband Adaptive Filtering*, get the knowledge about a new way of adaptive filtering -- multiband-structured subband adaptive filter
* Code a usable program of multiband-structured subband adaptive filter AIC
## 2018/8/2
* Read a paper about the basic algorithm of MDF in *Speex Codec* [*On Adjusting the Learning Rate in Frequency Domain Echo Cancellation with Double-Talk*](http://people.xiph.org/~jm/papers/valin_taslp2006.pdf)
* Try the AIC effect of MDF in *Speex Codec*
## 2018/8/3
* Comparing the spectrograms of the outputs from AIC programs of *Speex*, SAF and MSAF.
## 2018/8/6
* Summarize