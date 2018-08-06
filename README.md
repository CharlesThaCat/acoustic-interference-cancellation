Acoustic Interference Cancellation
======

# Introduction
This is the GitHub page for Acoustic Interference (Echo) Cancellation, which is the project in the summer internship in *Shenzhen Micro and Nano Institute*.<br>

The main contributor to this project is:<br>
`Zhuowen Lin`<br>
The programming language is MATLAB. 

# Mind map
![mind map](https://raw.githubusercontent.com/CharlesThaCat/acoustic-interference-cancellation/master/Adaptive%20Interference%20Cancellation%20mind%20map.jpg)

# Repository document components
* `Daily Logs`: Records the daily schedules.
* `Fullband processing`: Codes for fullband adaptive acoustic interference cancellation.
* `Speex Codec`: MATLAB version of the acoustic echo cancellation program in *Speex Codec*. The code is forked from [*here*](https://github.com/wavesaudio/Speex-AEC-matlab/blob/master/speex_mdf.m).
* `Subband processing`: Codes for subband adaptive acoustic interference cancellation.
    * `Book`: MATLAB codes for different algorithms proposed in different chapters of the book *Subband Adaptive Filtering*. (The pdf version of this book is included in the document Supporting Materials.)
    * `Common Code`: All the usable codes in the book *Subband Adaptive Filtering*. 
* `Supporting materials`: pdf version of supporting materials including books and papers.

# Result demonstration
The spectrogram of the original acoustic file, which contains background musical interference signal and demanded speech signal "Xiao Du Xiao Du" under 500 Hz.<br>
![Original spectrogram](https://github.com/CharlesThaCat/acoustic-interference-cancellation/blob/master/original%20spectrogram_1.png)<br>
The spectrogram of the processed acoustic file, which contains deteriorated and suppressed background musical interference signal and clearer demanded speech signal "Xiao Du Xiao Du" under 500 Hz.
![Processed spectrogram](https://github.com/CharlesThaCat/acoustic-interference-cancellation/blob/master/Spectrogram_MSAF_output_01_1.png)<br>