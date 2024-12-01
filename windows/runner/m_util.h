#ifndef ON_THE_FLY_M_UTIL_H
#define ON_THE_FLY_M_UTIL_H

#include <flutter/event_channel.h>
#include <flutter/event_sink.h>
#include <flutter/event_stream_handler_functions.h>
#include <flutter/method_channel.h>
#include <flutter/standard_method_codec.h>
#include "flutter_window.h"

#include <vector>
#include <cstring>
#include <unordered_map>

const std::string CHANNEL_PREFIX_NAME="net.exoad.on_the_fly/";

class MUtil
{
private:
        MUtil()
        {
        }

        MUtil(const MUtil&);

public:
        void operator=(const MUtil&)=delete;
        std::unordered_map<std::string,std::unique_ptr<flutter::MethodChannel<>>> event_channels;

        static MUtil& GetInstance()
        {
                static MUtil instance;
                return instance;
        }

        /**
         * @brief Create a Method Channel object (helper function)
         *
         * @tparam T The type of the method channel
         * @param messenger The binary messenger
         * @param channel_name The name of the channel usually prefixed
         * @param handler The method call handler (what to do when a method is called from this platform channel)
         *
         * @return std::unique_ptr<flutter::MethodChannel<T>>
         */
        template <typename T=flutter::EncodableValue>
        void CreateMethodChannel(
                flutter::FlutterViewController* controller,
                flutter::BinaryMessenger* messenger,
                const std::string& channel_name,
                flutter::MethodCallHandler<T> handler);
};

namespace on_the_fly
{
        /**
         * @brief Loads all the method channels we need
         *
         * @param controller The flutter view controller that should be supplied successfully
         */
        void LoadMethodChannels(flutter::FlutterViewController* controller);
}

#endif