#include "m_util.h"

#include <iostream>

MUtil::MUtil(const MUtil& __m)=delete;

template <typename T=flutter::EncodableValue>
void MUtil::CreateMethodChannel(
        flutter::FlutterViewController* controller,
        flutter::BinaryMessenger* messenger,
        const std::string& channel_name,
        flutter::MethodCallHandler<T> handler)
{
        std::unique_ptr<flutter::MethodChannel<T>> channel=std::make_unique<flutter::MethodChannel<T>>(
                        messenger==nullptr?controller->engine()->messenger():messenger,
                        channel_name,
                        new flutter::StandardMethodCodec()
                );
        channel->SetMethodCallHandler(handler);
        event_channels[channel_name]=std::move(channel);
}

void on_the_fly::LoadMethodChannels(flutter::FlutterViewController* controller)
{
}