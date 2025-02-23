

cmake_minimum_required(VERSION 3.22)
project(TimAudioPlugin VERSION 0.0.1)

# Variables.
set(PLUGIN_NAME "TimAudioPlugin" CACHE INTERNAL "")
set(MANUFACTURER_NAME "NerdyTimCorp" CACHE INTERNAL "")
SET(CMAKE_CONFIGURATION_TYPES ${CMAKE_BUILD_TYPE} CACHE STRING "" FORCE)

if (UNIX AND NOT APPLE)
    message(STATUS "Building LV2 plugin format")
    list(APPEND JUCE_FORMATS LV2)
    message(STATUS "Building VST3 plugin format")
    list(APPEND JUCE_FORMATS VST3)
    message(STATUS "Building Standalone plugin format")
    list(APPEND JUCE_FORMATS Standalone)
endif ()

# If you've installed JUCE somehow (via a package manager, or directly using the CMake install
# target), you'll need to tell this project that it depends on the installed copy of JUCE. If you've
# included JUCE directly in your source tree (perhaps as a submodule), you'll need to tell CMake to
# include that subdirectory as part of the build.

find_package(JUCE CONFIG REQUIRED)        # If you've installed JUCE to your system
# or
#add_subdirectory(JUCE)                    # If you've put JUCE in a subdirectory called JUCE

juce_add_plugin(
    ${PLUGIN_NAME}
    VERSION "1.0.0"                               # Set this if the plugin version is different to the project version
    COMPANY_NAME ${MANUFACTURER_NAME}                          # Specify the name of the plugin's author
    PLUGIN_MANUFACTURER_CODE Ntim               # A four-character manufacturer id with at least one upper-case character
    PLUGIN_CODE Tap1                            # A unique four-character plugin id with exactly one upper-case character
    FORMATS ${JUCE_FORMATS}                  
    PRODUCT_NAME ${PLUGIN_NAME}
    LV2URI https://github.com/timlau
)        

juce_generate_juce_header(${PLUGIN_NAME})


target_sources(TimAudioPlugin
    PRIVATE
        src/PluginEditor.cpp
        src/PluginProcessor.cpp
)

target_include_directories(
        ${PLUGIN_NAME}
        PUBLIC
            include
)

target_compile_definitions(
    ${PLUGIN_NAME}
    PUBLIC
        JUCE_WEB_BROWSER=0
        JUCE_USE_CURL=0
        JUCE_VST3_CAN_REPLACE_VST2=0
)

# If your target needs extra binary assets, you can add them here. The first argument is the name of
# a new static library target that will include all the binary resources. There is an optional
# `NAMESPACE` argument that can specify the namespace of the generated binary data class. Finally,
# the SOURCES argument should be followed by a list of source files that should be built into the
# static library. These source files can be of any kind (wav data, images, fonts, icons etc.).
# Conversion to binary-data will happen when your target is built.

# juce_add_binary_data(AudioPluginData SOURCES ...)

# `target_link_libraries` links libraries and JUCE modules to other libraries or executables. Here,
# we're linking our executable target to the `juce::juce_audio_utils` module. Inter-module
# dependencies are resolved automatically, so `juce_core`, `juce_events` and so on will also be
# linked automatically. If we'd generated a binary data target above, we would need to link to it
# here too. This is a standard CMake command.

target_link_libraries(
    ${PLUGIN_NAME}
    PRIVATE
        # AudioPluginData           # If we'd created a binary data target, we'd link to it here
        juce::juce_audio_utils
    PUBLIC
        juce::juce_recommended_config_flags
        juce::juce_recommended_lto_flags
        juce::juce_recommended_warning_flags
)
