#include <flutter/dart_project.h>
#include <flutter/flutter_view_controller.h>
// #include <windows.h>
#include <bitsdojo_window_windows/bitsdojo_window_plugin.h>
#include "flutter_window.h"
#include "utils.h"

#define WINDOW_HEIGHT 620
#define WINDOW_WIDTH 980
int bdw = bitsdojo_window_configure(BDW_CUSTOM_FRAME | BDW_HIDE_ON_STARTUP);
int APIENTRY wWinMain(_In_ HINSTANCE instance, _In_opt_ HINSTANCE prev, _In_ wchar_t* command_line, _In_ int show_command)
{
        if (!::AttachConsole(ATTACH_PARENT_PROCESS) && ::IsDebuggerPresent())
                CreateAndAttachConsole();
        ::CoInitializeEx(nullptr, COINIT_APARTMENTTHREADED);
        flutter::DartProject project(L"data");
        std::vector<std::string> command_line_arguments = GetCommandLineArguments();
        project.set_dart_entrypoint_arguments(std::move(command_line_arguments));
        FlutterWindow window(project);
        // it shld be better to use an externally defined header for these values lol
        if (!window.Create(
                L"OnTheFly",
                Win32Window::Point((GetSystemMetrics(SM_CXSCREEN) - WINDOW_WIDTH) / 2, (GetSystemMetrics(SM_CYSCREEN) - WINDOW_HEIGHT) / 2),
                Win32Window::Size(980, 620)
        )
                )
                return EXIT_FAILURE;
        window.SetQuitOnClose(true);
        ::MSG msg;
        while (::GetMessage(&msg, nullptr, 0, 0))
        {
                ::TranslateMessage(&msg);
                ::DispatchMessage(&msg);
        }
        ::CoUninitialize();
        return EXIT_SUCCESS;
}


