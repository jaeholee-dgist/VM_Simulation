# VM_Simulation
Simulation code of Virtual Metrology (VM) in MATLAB.

## Files
- **semi.m**: The main code that computes the Mean Squared Error (MSE) between the output $(y)$ and the target value $(T)$ of 1,000 repeated simulations.
- **find_sigma.m**: The function that finds the upper bound of $\sigma_n^{VM}$ that performs better than Physical Metrology (PM) with given factors.


## Factors affecting the output
![manufacturing_process](https://github.com/jaeholee-dgist/VM_Simulation/assets/169323185/99fd26c0-d2a4-43b3-bb37-4600af0832c2)
The output is influenced by the sampling interval $(s)$, delay $(L)$, and the standard deviation of measurement noise $(\sigma_n)$.
- The output is not measured every trial; instead, it is measured every $s$ steps.
- There is a delay of $L$ steps before the measured values affect the next control input.
- Measurement is subject to white Gaussian noise with a standard deviation of $(\sigma_n)$.


## Usage
- <kbd>semi $(s,L,\sigma_n)$</kbd> calculates the MSE between the output and the target value when metrology is conducted with a sampling interval of $s$, a delay of $L$, and noise with a standard deviation of $\sigma_n$.
- <kbd>find_sigma $(s,L,\sigma_n)$</kbd> calculates the upper bound of $\sigma_n^{VM}$ to achieve a lower MSE than physical metrology, considering a sampling interval of $s$, a delay of $L$, and noise with a standard deviation of $\sigma_n$.


## Original Paper
To be updated
