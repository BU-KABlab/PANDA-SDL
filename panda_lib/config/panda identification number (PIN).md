# PANDA-BEAR Identifiction NUMBER (PIN)

Modeled on Vehicle Identification Number (VIN) the PIN identifies the hardware version of the PANDA-BEAR system
This is critical for experiment repeatability as an experiment run on different hardware may yield different results

Example PIN:
2 01 01 01 02 04 05 00 00 01 01

## Considerations

- The first category will not have leading 0s
- If any category grows beyond the initial 3-digits, all previous entries must be expanded with a leading 0.
- When adding a new category all previous entries must be backfilled with 0s
- All codes are numberic inorder to result in an integer value

## Categories

Mill | Pump | Potentiostat | Reference Electrode | Working Electrode | Wells | Pipette Adapter | Optics | Scale

mill 1 = Prover 3018 \
mill 2 = Prover 4030 Pro

pump 01 = New Era A-1000 syringe pump with 1ml, 4.699 diameter syringe

potentiostat 01 = Gamry

reference electrode 01 = silver chloride solution inside of glass tube\
reference electrode 02 = glass tube with reference elctrode fixed with PDMS\
reference electrode 03 = glass tube with reference elctrode fixed with epoxy\
reference electrode 04 = carbon-glass and silver

working electrode 01 = gold\
working electrode 02 = ITO

wells 00 = no wellplate
wells 01 = gold, grace bio-labs, 96, square, 4.0, 9.0, 7, 6, 300
wells 02 = ito, grace bio-labs, 96, square, 4.0, 9.0, 7, 6, 300
wells 03 = gold, pdms, 96, circular, 3.25, 8.90, 6, 4.5, 150
wells 04 = ito, pdms, 96, circular, 3.25, 9.0, 6, 4.5, 150
wells 05 = plastic, standard, 96, circular, 3.48, 9.0, 10.9, 8.5, 500
wells 06 = pipette tip box, standard, 96, circular, 3.48, 9.0, 45, 8.5, 300000

pipette adapter 01 = barbed fitting\
pipette adapter 02 = male leur-lock part of adapter\
pipette adapter 03 = female leur-lock part of adapter\
pipette adapter 04 = cut off end\
pipette adapter 05 = remodeled short adapter with female leur-lock

optics 00 = no optics

scale 00 = no scale
scale 01 = wellplate ontop of scale
scale 02 = scale below decking with access port

camera 00 = no camera
camera 01 = FLIR Grasshopper3 USB

lens 00 = no lens
lens 01 = edmunds optics 55mm Focal Length Partially Telecentric Video Lens #52-271
