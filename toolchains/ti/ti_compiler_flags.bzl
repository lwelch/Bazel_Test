"""\r
This script is where all compiler and linker flags will be set.\r
These flags will be passed to the compiler/linker as part of the toolchain.\r
"""

def arm_c_flags():
    """ This funciton will be used to return all the c flags for the arm compiler.\r
\r
    Returns:\r
        List of strings to pass as C Flags to the Arm Compiler\r
    """
    return [
        "-mlittle-endian",
        "-mcpu=cortex-r5",
        "-gdwarf-3",
        "-mfloat-abi=hard",
        "-mfpu=vfpv3-d16",
        #"-mthumb",
        "-Werror",
        "-ffunction-sections",
        "-Oz",
        #"-mthumb",
        "-g",
        "-fdiagnostics-show-option",
        "-ffunction-sections",
        "-fshort-enums",
        "-mno-unaligned-access",
        # Define Flags that should be passed to every file
        "-DCLANG",
        "-DAWR29XXETS_PLATFORM",
        "-DBUILD_SOC_AWR294X",
        "-DBUILD_SUBSYS_MSS",
        "-DTRACE_ENABLE",
        "-DASSERT_ENABLE",
        #Define for enabling the ADC Test pattern generation to trigger the EDMA/HWA-RFFT-DFFT-RDD processing.
        #"-DADC_TEST_PATTERN_GEN_MODE_ENABLED",
    ]

def arm_cpp_flags():
    """ This funciton will be used to return all the c flags for the arm compiler.\r
\r
    Returns:\r
        List of strings to pass as C Flags to the Arm Compiler\r
    """
    return [
        "",
    ]

def arm_asm_flags():
    """ This funciton will be used to return all the assembler flags for the arm compiler.\r
\r
    Returns:\r
        List of strings to pass as C Flags to the Arm Compiler\r
    """
    return [
        "-mcpu=cortex-r5",
        "-mfloat-abi=hard",
        "-mfpu=vfpv3-d16",
    ]

def arm_linker_flags(r5f_codegen_path):
    """ This funciton will be used to return all the c flags for the arm compiler.\r
\r
    Returns:\r
        List of strings to pass as C Flags to the Arm Compiler\r
    """
    return [
        "-Wl,--diag_suppress=10063",
        "-Wl,--emit_warnings_as_errors",
        "-Wl,-qq",
        #"-Wl,--rom_model",
        "-Wl,-mcpu=cortex-r5",
        "-Wl,-qq",
        "-Wl,-a",
        "-Wl,--rom_model",
        "-Wl,--reread_libs",
        "-Wl,--unused_section_elimination=on",
        "-Wl,--compress_dwarf=on",
        "-Wl,--copy_compression=rle",
        "-Wl,--cinit_compression=rle",
    ]

def c66_c_flags():
    """ This funciton will be used to return all the c flags for the c66 compiler.\r
\r
    Returns:\r
        List of strings to pass as flags to the C66 Compiler\r
    """
    return [
        # "--use_llvm",
        "-c",
        "-mv6600",
        "--abi=eabi",
        "--gcc",
        "-g",
        "-O3",
        "-mf3",
        "-mo",
        "--define=SUBSYS_DSS",
        "--define=SOC_AWR294X",
        "--define=_LITTLE_ENDIAN",
        "--display_error_number",
        "--define=DebugP_ASSERT_ENABLED",
        "--diag_warning=225",
        "--diag_wrap=off",
        "--preproc_with_compile",
        "--emit_warnings_as_errors",
        #Define for enabling the ADC Test pattern generation to trigger the EDMA/HWA-RFFT-DFFT-RDD processing.
        #"--define=ADC_TEST_PATTERN_GEN_MODE_ENABLED",
        #Define for enabling the ADC Offline Data in Flash test mode - must define DISABLE_LAUTERBACH_TEST_ADC_OUTPUT also
        #"--define=ADC_OFFLINE_DATA_ENABLED",
        #"--define=DISABLE_LAUTERBACH_TEST_ADC_OUTPUT"
    ]

def c66_cpp_flags():
    """ This funciton will be used to return all the c flags for the c66 compiler.\r
\r
    Returns:\r
        List of strings to pass as C Flags to the C66 Compiler\r
    """
    return [
        "",
    ]

def c66_asm_flags():
    """ This funciton will be used to return all the assembler flags for the c66 compiler.\r
\r
    Returns:\r
        List of strings to pass as flags to the C66 Compiler\r
    """
    return [
        "-mv6600",
        "--abi=eabi",
        "-q",
        "-mi10",
        "-mo",
        "-pden",
        "-pds=238",
        "-pds=880",
        "-pds1110",
        "--emit_warnings_as_errors",
        "--program_level_compile",
        "-o3",
        "-mf3",
        "-DSOC_AWR294X",
    ]

def c66_linker_flags(c66_codegen_path):
    """ This funciton will be used to return all the flags for the c66 linker.\r
\r
    Returns:\r
        List of strings to pass as flags to the C66 Linker\r
    """
    return [
        "-mv6600",
        "--abi=eabi",
        "-g",
        "--define=SOC_AWR294X",
        "--display_error_number",
        "--diag_warning=225",
        "--diag_wrap=off",
        "-z",
        "--reread_libs",
        "--warn_sections",
        "--ram_model",
        "-i" + c66_codegen_path + "/lib",
        "--emit_warnings_as_errors",
        "--diag_error=10015",
        "--map_file=awr294x_mmw_demo_dss.map",
    ]
