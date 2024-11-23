#pragma once
#ifndef __AUTO__IMG_LIB__
#define __AUTO__IMG_LIB__

#ifdef _WIN32
#include <windows.h>
#include "../windows/runner/flutter_window.h"
inline const wchar_t* GetApplicationWindowTitle() noexcept
{
  return L"AutoImg";
}

inline Win32Window::Size GetApplicationWindowSize() noexcept
{
  return Win32Window::Size(1280, 720);
}
#endif

#ifdef __linux__



#endif
#endif
