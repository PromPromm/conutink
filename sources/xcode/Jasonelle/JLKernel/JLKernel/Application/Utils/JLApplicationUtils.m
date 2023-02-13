//
//  JLApplicationUtils.m
//  JLKernel
//
//  Created by clsource on 05-05-22
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

#import "JLApplicationUtils.h"

@implementation JLApplicationUtils

- (instancetype)initWithLogger:(id<JLLoggerProtocol>)logger {
    self = [super init];

    if (self) {
        self.logger = logger;
    }

    return self;
}

- (NSString *)uuid {
    return [[NSUUID UUID] UUIDString];
}

- (JLUtilsBase64 *)base64 {
    if (!_base64) {
        _base64 = [[JLUtilsBase64 alloc] initWithLogger:self.logger];
    }

    return _base64;
}

- (JLUtilsJSON *)json {
    if (!_json) {
        _json = [[JLUtilsJSON alloc] initWithLogger:self.logger];
    }

    return _json;
}

- (JLUtilsFileSystem *)fs {
    if (!_fs) {
        _fs = [[JLUtilsFileSystem alloc] initWithLogger:self.logger];
    }

    return _fs;
}

- (BOOL) openURL: (NSString *) urlString {
    NSURL * url = [[NSURL alloc] initWithString:urlString];
    jlog_trace_join(@"Openning URL: ", url);
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
            jlog_trace_join(@"Was Open?: ", jlog_b2s(success));
        }];
        return YES;
    }
    jlog_trace(@"Could not open URL");
    return NO;
}
@end
