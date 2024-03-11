//===-- PlatformRemoteMacOSX.h ---------------------------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef LLDB_SOURCE_PLUGINS_PLATFORM_MACOSX_PLATFORMREMOTEMACOSX_H
#define LLDB_SOURCE_PLUGINS_PLATFORM_MACOSX_PLATFORMREMOTEMACOSX_H

#include "PlatformRemoteDarwinDevice.h"
#include "lldb/Utility/FileSpec.h"
#include "lldb/Utility/Status.h"
#include "lldb/lldb-forward.h"
#include "llvm/ADT/StringRef.h"

#include <string>
#include <vector>

namespace lldb_private {
class ArchSpec;
class FileSpec;
class UUID;

class PlatformRemoteMacOSX : public virtual PlatformRemoteDarwinDevice {
public:
  PlatformRemoteMacOSX();

  static lldb::PlatformSP CreateInstance(bool force, const ArchSpec *arch);

  static void Initialize();

  static void Terminate();

  static llvm::StringRef GetPluginNameStatic() { return "remote-macosx"; }

  static llvm::StringRef GetDescriptionStatic();

  llvm::StringRef GetPluginName() override { return GetPluginNameStatic(); }

  llvm::StringRef GetDescription() override { return GetDescriptionStatic(); }

  std::vector<ArchSpec>
  GetSupportedArchitectures(const ArchSpec &process_host_arch) override;

protected:
  llvm::StringRef GetDeviceSupportDirectoryName() override;
  llvm::StringRef GetPlatformName() override;
};

} // namespace lldb_private

#endif // LLDB_SOURCE_PLUGINS_PLATFORM_MACOSX_PLATFORMREMOTEMACOSX_H
