//
//  JLKernel.h
//  JLKernel
//
//  Created by clsource on 02-02-22
//
//  Copyright (c) 2022 Jasonelle.com
//
//  This file is part of Jasonelle Project <https://jasonelle.com>.
//  Jasonelle Project is dual licensed. You can choose between AGPLv3 or MPLv2.
//  MPLv2 is only valid if the software has a unique Jasonelle Key which was purchased in official channels.
//
//  == AGPLv3
//  Jasonelle is free software: you can redistribute it and/or modify it under the terms of the Affero GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
//  Jasonelle is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the Affero GNU General Public License for more details.
//  You should have received a copy of the Affero GNU General Public License along with Jasonelle. If not, see <https://www.gnu.org/licenses/>.
//
//  == MPLv2 (Only valid if purchased a Jasonelle Key)
//  This Source Code Form is subject to the terms
//  of the Mozilla Public License, v. 2.0.
//  If a copy of the MPL was not distributed
//  with this file, You can obtain one at
//
//  <https://mozilla.org/MPL/2.0/>.
//

#import <Foundation/Foundation.h>

// ! Project version number for JLKernel.
FOUNDATION_EXPORT double JLKernelVersionNumber;

// ! Project version string for JLKernel.
FOUNDATION_EXPORT const unsigned char JLKernelVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <JLKernel/PublicHeader.h>

// Logger
#import <JLKernel/JLLoggerMacros.h>
#import <JLKernel/JLLoggerProtocol.h>
#import <JLKernel/JLLogHandlerProtocol.h>
#import <JLKernel/JLLoggingSystem.h>
#import <JLKernel/JLLogLevel.h>
#import <JLKernel/JLLogLevelFactory.h>
#import <JLKernel/JLLogger.h>
#import <JLKernel/JLStreamLogHandler.h>

// Application Container
#import <JLKernel/JLApplication.h>
#import <JLKernel/JLApplicationUtils.h>
#import <JLKernel/JLApplicationExtensions.h>

// Utils
#import <JLKernel/JLUtil.h>
#import <JLKernel/JLUtilsBase64.h>
#import <JLKernel/JLUtilsJSON.h>
#import <JLKernel/JLUtilsPlist.h>
#import <JLKernel/JLUtilsFileSystem.h>

// Environment
#import <JLKernel/JLEnvironment.h>
#import <JLKernel/JLProcess.h>

// Events
// Notification Center
#import <JLKernel/JLNotificationCenter.h>

#import <JLKernel/JLEvent.h>
#import <JLKernel/JLUserInfo.h>
#import <JLKernel/JLApplicationEvents.h>
#import <JLKernel/JLEventOrientationDidChange.h>
#import <JLKernel/JLEventAppDidEnterBackground.h>
#import <JLKernel/JLEventAppWillEnterForeground.h>
#import <JLKernel/JLEventAppDidLoad.h>
#import <JLKernel/JLEventViewDidAppear.h>
#import <JLKernel/JLEventViewDidDisappear.h>
#import <JLKernel/JLEventDidReceiveOpenURL.h>

// Networking
#import <JLKernel/JLHTTPAdapterProtocol.h>

// Renderers
#import <JLKernel/JLRendererProtocol.h>

// Javascript Engine
#import <JLKernel/JLJSValue.h>
#import <JLKernel/JLJSContext.h>
#import <JLKernel/JLJSParams.h>

// WebView Message Handlers
#import <JLKernel/JLJSMessageHandler.h>
#import <JLKernel/JLJSMessageHandlerOptions.h>
#import <JLKernel/JLJSMessageHandlers.h>
#import <JLKernel/JLWebViewMessageHandlerProtocol.h>

// JS Bridges
#import <JLKernel/JLJSBridge.h>
#import <JLKernel/JLJSBridgeLogger.h>
#import <JLKernel/JLJSBridgeApp.h>
#import <JLKernel/JLJSBridgei18n.h>
#import <JLKernel/JLJSBridgeOpenURL.h>

// JS Polyfills
#import <JLKernel/JLJSPolyfill.h>
#import <JLKernel/JLJSPolyfillCrypto.h>

// Config
#import <JLKernel/JLJSConfigLoader.h>
#import <JLKernel/JLJSConfig.h>

// Routes
#import <JLKernel/JLJSRoutesLoader.h>
#import <JLKernel/JLJSRoutes.h>

// Extensions
#import <JLKernel/JLExtension.h>
