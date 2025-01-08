#include "flutter_window.h"
#include <optional>
#include "flutter/generated_plugin_registrant.h"
#include <flutter/event_channel.h>
#include <flutter/event_sink.h>
#include <flutter/event_stream_handler_functions.h>
#include <flutter/method_channel.h>
#include <flutter/standard_method_codec.h>
#include <windows.h>
#include "win32_window.h"

FlutterWindow::FlutterWindow(const flutter::DartProject& project) :project_(project)
{
}

FlutterWindow::~FlutterWindow()
{
}

bool FlutterWindow::OnCreate()
{
    if (!Win32Window::OnCreate())
        return false;
    RECT frame = GetClientArea();
    flutter_controller_ = std::make_unique<flutter::FlutterViewController>(
        frame.right - frame.left,
        frame.bottom - frame.top,
        project_
    );
    if (!flutter_controller_->engine() || !flutter_controller_->view())
        return false;
    RegisterPlugins(flutter_controller_->engine());
    // initiate the first method channel that we wrote (sanity_check)
    // sanity_check is just a regular method channel for seeing if the channels work properly (ie checking our sanity)
    flutter::MethodChannel<> sanity_check(
        flutter_controller_->engine()->messenger(),
        "net.exoad.on_the_fly/sanity_check",
        &flutter::StandardMethodCodec::GetInstance()
    );
    sanity_check.SetMethodCallHandler([](const auto& call, auto result)
        {
            // printf("METHOD_ENCOUNTER: %s",call.method_name()); !! PRONE ERROR
            if (call.method_name() == "DoesExist")
                result->Success(true);
        });
    flutter::MethodChannel<> win_man(
        flutter_controller_->engine()->messenger(),
        "net.exoad.on_the_fly/win_man",
        &flutter::StandardMethodCodec::GetInstance()
    );
    win_man.SetMethodCallHandler([&](const auto& call, auto result)
        {
            if (call.method_name() == "focus")
            {
                SetForegroundWindow(flutter_controller_->view()->GetNativeWindow());
                result->Success();
            }
            else if (call.method_name() == "set_title")
            {
                const auto* args = std::get_if<flutter::EncodableMap>(call.arguments());
                if (args)
                {
                    auto title = args->find(flutter::EncodableValue("title"));
                    if (title != args->end())
                    {
                        std::string title_Str = std::get<std::string>(title->second);
                        SetWindowText(
                            flutter_controller_->view()->GetNativeWindow(),
                            std::wstring(title_Str.begin(), title_Str.end()).c_str());
                    }
                }
            }
            else if (call.method_name() == "set_c_size") // stands for centered size, where we dont "pull" resize, we resize and keep the window at the center of the original origin
            {
                const auto* args = std::get_if<flutter::EncodableMap>(call.arguments());
                if (args)
                {
                    // the following implementation is very similar to Win32Window::Create()
                    // which has the centered scaling builtin
                    //
                    // see that function for more details and its implementation
                    auto width = args->find(flutter::EncodableValue("width"));
                    auto height = args->find(flutter::EncodableValue("height"));
                    if (width != args->end() && height != args->end())
                    {
                        unsigned int w = std::get<unsigned int>(width->second);
                        unsigned int h = std::get<unsigned int>(height->second);
                        RECT r;
                        GetWindowRect(flutter_controller_->view()->GetNativeWindow(), &r);
                        Point where = Win32Window::Point((GetSystemMetrics(SM_CXSCREEN) - (r.right - r.left)) / 2, (GetSystemMetrics(SM_CXSCREEN) - (r.bottom - r.top)) / 2);
                        const POINT target_point = { static_cast<LONG>(where.x), static_cast<LONG>(where.y) };
                        HMONITOR monitor = MonitorFromPoint(target_point, MONITOR_DEFAULTTONEAREST);
                        double scale_factor = FlutterDesktopGetDpiForMonitor(monitor) / 96;
                        HDWP hdwp = BeginDeferWindowPos(1);
                        DeferWindowPos(hdwp, flutter_controller_->view()->GetNativeWindow(), NULL,
                            static_cast<int>((where.x) - static_cast<int>(w / 2, scale_factor)),
                            static_cast<int>((where.y) - static_cast<int>(h / 2, scale_factor)),
                            static_cast<int>(w, scale_factor),
                            static_cast<int>(h, scale_factor),
                            NULL
                        );
                    }
                }
            }
        });
    SetChildContent(flutter_controller_->view()->GetNativeWindow());
    flutter_controller_->engine()->SetNextFrameCallback([&]() {this->Show();});
    flutter_controller_->ForceRedraw();
    return true;
}


void FlutterWindow::OnDestroy()
{
    if (flutter_controller_)
        flutter_controller_ = nullptr;
    Win32Window::OnDestroy();
}

LRESULT FlutterWindow::MessageHandler(HWND hwnd, UINT const message, WPARAM const wparam, LPARAM const lparam) noexcept
{
    if (flutter_controller_)
    {
        std::optional<LRESULT> result = flutter_controller_->HandleTopLevelWindowProc(
            hwnd,
            message,
            wparam,
            lparam
        );
        if (result)
            return *result;
    }
    switch (message)
    {
    case WM_FONTCHANGE:
        flutter_controller_->engine()->ReloadSystemFonts();
        break;
    }
    return Win32Window::MessageHandler(
        hwnd,
        message,
        wparam,
        lparam
    );
}