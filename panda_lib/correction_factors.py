from math import isclose

'''
0.91 cP // y = 0.99x - 6.23
3.06 cP // y = 0.97x - 4.91
9.96 cP // y = 0.97x - 2.78
31.88 cP // y = 0.98x + 3.68
'''


def correction_factor(x, viscosity=0.91) -> float:
    '''
    Calculate the correction factor to applied to the programmed volume
    for the viscosity of the sample.
    
    0.91 cP // y = 1.01x + 6.23
    3.06 cP // y = 1.03x + 4.91
    9.96 cP // y = 1.03x + 2.78
    31.88 cP // y = 1.02x -3.68
    
    with x = programmed volume
    '''
    if viscosity is None or x == 0:
        corrected_volume = x
    elif isclose(viscosity, 0.91, abs_tol=0.05):
        corrected_volume = round(1.01 * x + 6.23, 6)
    elif isclose(viscosity, 3.06):
        corrected_volume = round(1.03 * x + 4.91, 6)
    elif isclose(viscosity, 9.96):
        corrected_volume = round(1.03 * x + 2.78, 6)
    elif isclose(viscosity, 31.88):
        corrected_volume = round(1.02 * x - 3.68, 6)
    else:
        corrected_volume = x

    return corrected_volume

def reverse_correction_factor(x, viscosity) -> float:
    """Calculate the original volume based on the given volume x and viscosity."""
    if viscosity is None or x == 0:
        original_volume = x
    elif isclose(viscosity, 0.91):
        original_volume = round((x - 6.23) / 1.01, 6)
    elif isclose(viscosity, 3.06):
        original_volume = round((x - 4.91) / 1.03, 6)
    elif isclose(viscosity, 9.96):
        original_volume = round((x - 2.78) / 1.03, 6)
    elif isclose(viscosity, 31.88):
        original_volume = round((x + 3.68) / 1.02, 6)
    else:
        original_volume = x

    return original_volume
