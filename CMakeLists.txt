cmake_minimum_required(VERSION 3.16)

project(base_project VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)

qt_standard_project_setup()

qt_add_executable(appbase_project
    main.cpp
)

qt_add_qml_module(appbase_project
    URI base_project
    VERSION 1.0
    QML_FILES Main.qml
    SOURCES database.h database.cpp
    SOURCES listmodel.h listmodel.cpp
    QML_FILES listmodel.js
)
find_package(Qt6 REQUIRED COMPONENTS Sql)
target_link_libraries(appbase_project PRIVATE Qt6::Sql)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appbase_project PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appbase_project
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appbase_project
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appbase_project
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
