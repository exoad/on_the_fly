#include "flutter_window.h"
#include <optional>
#include "flutter/generated_plugin_registrant.h"
#include <flutter/event_channel.h>
#include <flutter/event_sink.h>
#include <flutter/event_stream_handler_functions.h>
#include <flutter/method_channel.h>
#include <flutter/standard_method_codec.h>
#include <windows.h>

FlutterWindow::FlutterWindow(const flutter::DartProject& project):project_(project)
{
}

FlutterWindow::~FlutterWindow()
{
}

bool FlutterWindow::OnCreate()
{
        if (!Win32Window::OnCreate())
                return false;
        RECT frame=GetClientArea();
        flutter_controller_=std::make_unique<flutter::FlutterViewController>(
                                        frame.right-frame.left,
                                        frame.bottom-frame.top,
                                        project_
                                );
        if (!flutter_controller_->engine()||!flutter_controller_->view())
                return false;
        RegisterPlugins(flutter_controller_->engine());
        // initiate the first method channel that we wrote (sanity_check)
        // sanity_check is just a regular method channel for seeing if the channels work properly (ie checking our sanity)

        flutter::MethodChannel<> sanity_check(flutter_controller_->engine()->messenger(),"net.exoad.on_the_fly/sanity_check",&flutter::StandardMethodCodec::GetInstance());
        sanity_check.SetMethodCallHandler([](const auto& call,auto result)
        {
                printf("METHOD_ENCOUNTER: %s",call.method_name());
                if(call.method_name()=="DoesExist")
                        result->Success(true);

        });
        SetChildContent(flutter_controller_->view()->GetNativeWindow());
        flutter_controller_->engine()->SetNextFrameCallback([&](){this->Show();});
        flutter_controller_->ForceRedraw();
        return true;
}

void FlutterWindow::OnDestroy()
{
        if (flutter_controller_)
                flutter_controller_=nullptr;
        Win32Window::OnDestroy();
}

LRESULT FlutterWindow::MessageHandler(HWND hwnd,UINT const message,WPARAM const wparam,LPARAM const lparam) noexcept
{
        if (flutter_controller_)
        {
                std::optional<LRESULT> result=flutter_controller_->HandleTopLevelWindowProc(
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
