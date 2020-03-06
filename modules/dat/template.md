

# Objective

* To record the alpha spectrum of $Am-241$ radioactive source at different pressures.
* And to record the energy loss of alpha particles as a function of pressure,
* And hence to determine the range of alpha radiation in air.

# Apparatus

* Alpha spectroscopy chamber with vaccum pump • Scintillation Detector
* Discriminator-preamplifier
* MCA Box 
* HF Cables
* CASSY Lab software 

# Theory

Normal amplifiers, when amplifying weak signals, also amplifies the noise present in it. This noise incldes flicker noise at low frequencies which can be picked up from other electronics nearby, or thermal noise, which spans all frequencies and is of thermodynamic origin. Thsese noise signals can be ignored if we know the frequency of the signal we are looking for. This is what a lock-in amplifier does, extracting the signal given a known carrier wave.
$$
R=\int_{E_0}^0 \frac{dx}{dE}\cdot dE dx
$$


$$
R \propto E_0^{3/2}
$$

$$
x = \frac{c}{c_0}\cdot x_0
$$

## Determining Small Resistance

Measuring small resistances using conventional techniques can be tricky, since oftentimes, the resistance of the circuit itself can be higher than the resistance we are dealing with, which gives us a lot of noise. This can be solved by using lock-in amplifiers.

Using an AC signal, at each frequency, we plot a graph between $V_{DC}$ and $V_{AC}$, and get the slope.

Since $dV_{AC}=RdI_{AC}$m where R is the resistance of the primary circuit, and $dI_{AC}$ is the change in current through the low resistance when the signal generator voltage is changed by $dV_{AC}$. Also, the voltage $V_r$ changes by $dV_r$ where $dV_r=rdI_{AC}$. Therefore, we have:

$$
\frac{dV_{DC}}{dV_{AC}}=\mu \frac{r}{R}
$$

## Determining Mutual Inductance

Changing magnetic fields induces electric fields. Therefore, when a coil of wire is connected to an oscillating voltage, the changing magnetic fields due to it can induce an emf in a coil placed neaby.

Hence, if the current supplied to the primary coil is ,
then the emf induced in the secondary coil is obtained as:

$$
V=-M\frac{dI}{dt}= -2\pi Mft_0 sin(2\pi f t+\frac{\pi}{2})
$$

From above, it is evident that the induced current and the primary current are $90^o$ out of phase. Also, the induced current is directly proportional to the amplitude $I_0$ of the primary current, and it's frequency $f$.

# Observations

~tables~

# Graphs

~graphs~

# Results

- The amplification factor was obtained as: $\mu = 1.805 \times 10^3$
- The small resistance was obtained to be: $r =0.031\Omega$
- The mutual inductance of the given coil was obtained as: $M = 120.20 \mu H$

# Conclusion

The functioning of a lock-in amplifier, and its use in extracting signal from noise using phase modulation of the reference signal was studied. These were used in obtaining the resistance of a given small resistance, and the mutual inductance of a given coil.





