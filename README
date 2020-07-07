### Djankuat_glacier_model

### General information

 The model code is a 1D coupled ice flow-debris cover model. It uses bedrock 
 geometry together with a parameterized mass balance profile to calculate the
 ice thickness evolution on a grid with spatial resolution dx for the Djankuat 
 Glacier, and also takes into account an evolving supraglacial debris cover. It 
 is written in MATLAB_R2019a.

 The main equation to be solved for the flow model is (Eq. 1 in Verhaegen et al., 2020) :
 
    dH       1  d(wUH)
    --- = - --- ------ + ba
    dt       w    dx

    where:
      H = ice thickness (m)
      t = time (y)
      w = glacier width (m)
      U = vert. integrated ice velocity (m yr-1)
      x = horizontal distance (m)
     ba = local annual surface mass balance (m yr-1 ice eq.)

  And for supraglacial debris (Eq. 12, 13, 14, 15, 17 in Verhaegen et al., 2020) :

    dH_d    C_d * (min(0,ba))     d(U_sfc * H_d)
    ---- = ------------------- - --------------- + I_d
     dt       (1-phi_d)(p_d)           dx

    where:
    phi_d = debris cover porosity (-)
      p_d = density debris (kg m-3) 
    U_sfc = glacier surface flow velocity (m yr-1) 
      I_d = input/removal of debris (m yr-1)
      C_d = englacial debris concentration (kg m-3)
    U_sfc = glacier surface flow velocity (m yr-1)
      H_d = debris thickness (m)
        t = time (y)

 Constructed by Verhaegen et al. (2020), with supraglacial debris cover model adopted but sligthly adjusted from Anderson and Anderson (2016).

### Model structure

The model structure consists of the following elemennts:

 a) Main script (MAIN.m):

 All submodel codes are integrated in one main script (MAIN.m). This serves as
 the main model script and has to be ran to obtain model results.

 b) Debris-free steady state glacier (/loop_Flow_model_debrisfree/):

 The model first uses input variables related to geometry (bed_data, wbed_data
 and mu_data in Djankuat_main.m) together with a parameterized mass balance profile 
 (massbalance.m), to create a steady state glacier without debris cover. For more 
 information regarding the input variables and calculations, see the main paper.

 c) Imposing a supraglacial debris cover (/loop_Flow_model/ and /loop_Debris_model/):

 After the steady state is reached, a supraglacial debris cover is imposed on
 the steady state glacier. For this aspect, the model uses the debris-related
 Variables in 'debris_variables.m' The model then updates the glacier geometry until
 a new steady state is reached for both glacier geometry and the supraglacial
 debris cover.

 d) Storage of data:

 The loop in the model stores the data related to glacier geometry (length, area,
 width, etc.) and supraglacial debris cover (mean thickness, thickness front, debris-
 covered area, etc).

### Running and adjusting the model

 To run the model, unzip the data package and open the script MAIN.m to run the model code. 

 To adjust the model, adjust the parameters in the input files:
 
 a) geometric data:

 * wbed_data (/loop_Flow_model_debrisfree/, bed width, Eq. 1)
 * mu_data (/loop_Flow_model_debrisfree/, valley angles, Eq. 1)
 * bed_data ((/loop_Flow_model_debrisfree/, bedrock elevation, Eq. 1)

 b) variables related to the evolution of the supraglacial debris cover:

 * hstar (debris_variables.m, decay of exponential ice melt-debris thickness function, Eq. 14)
 * inputlocation_debris (debris_variables.m, debris input location, Eq. 13)
 * depositionrate_debris (debris_variables.m, deposition rate debris topographic source, Eq. 13)
 * rho_debris (debris_variables.m, density debris cover, Eq. 12)
 * concentration_debris (debris_variables.m, englacial debris concentration, Eq. 12)
 * phi_debris (debris_variables.m, porosity debris cover, Eq. 12)
 * terminusflux_cst (debris_variables.m, terminus foreland deposition, Eq. 13)
 * tdebris (debris_variables.m, time of release of topographic debris source, Eq. 13)
 * width_shrinkage (debris_variables.m, glacier surface width at which contribution of debris stops, Eq. 13)
 * yearly_growthfactor_area_d_past (/loop_Debris_model/debris_model/Debris_cover_main/, growth factor debris area, Eq. 17)
 * debrisarea_d_past (/loop_Debris_model/debris_model/debris_areacalc/, distance front parameterization debris area, Eq. 15)

 c) numerical values:

 * numberofyears (MAIN.m, number of years to be considered in the ice flow-debris model after initial steady state)

### Model output

 The model output consists of the following elements:

 a) Output plots:
 * Figure 1: Bedrock elevation, surface elevation and ice thickness along the flow line
 * Figure 2: Evolution of glacier length and surface area with time until steady state
 * Figure 3: Steady state debris parameters (thickness and area)

 b) Output variables:
 * yearly_area_glacier (yearly total glacier surface area, km2)
 * yearly_length_glacier (yearly glacier length, m)
 * yearly_height_debris (yearly debris thickness along the flow line, m)
 * yearly_mean_front_height_debris (yearly mean debris thickness over glacier front, i.e. 30 first grid points, m)
 * yearly_mean_height_debris (yearly mean debris thickness over the entire glacier, m)
 * yearly_fractarea_debris (yearly fractional debris covered area along the flow line, -)
 * yearly_total_area_debris (yearly absolute debris covered area along the flow line, m2)
 * yearly_totalglacier_area_debris (yearly total glacier debris-covered surface area, km2)
 * yearly_totalglacier_fractarea_debris (yearly fractional glacier debris-covered surface area, -)

### References

Anderson, L. S. and Anderson, R. S.: Modeling debris-covered glaciers: response to steady debris deposition, The Cryosphere, 10, 1105–1124, https://doi.org/10.5194/tc-10-1105-2016, 2016.

Verhaegen, Y., Huybrechts, P., Rybak, O., and Popovnin, V. V.: Modelling the evolution of Djankuat Glacier, North Caucasus, from 1752 until 2100 AD, The Cryosphere Discuss., https://doi.org/10.5194/tc-2019-312, in review, 2020.

### Citation

Please cite the usage of the model as follows:

Verhaegen, Y., Huybrechts, P., Rybak, O., and Popovnin, V. V.: Modelling the evolution of Djankuat Glacier, North Caucasus, from 1752 until 2100 AD, The Cryosphere Discuss., https://doi.org/10.5194/tc-2019-312, in review, 2020.
[![DOI](https://zenodo.org/badge/277853270.svg)](https://zenodo.org/badge/latestdoi/277853270)
