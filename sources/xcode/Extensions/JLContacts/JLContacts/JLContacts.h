//
//  JLContacts.h
//  JLContacts
//
//  Created by clsource on 05-02-23.
//  Copyright (c) 2023 Jasonelle.com
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
#import <JLKernel/JLKernel.h>
#import <Contacts/Contacts.h>

//! Project version number for JLContacts.
FOUNDATION_EXPORT double JLContactsVersionNumber;

//! Project version string for JLContacts.
FOUNDATION_EXPORT const unsigned char JLContactsVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <JLContacts/PublicHeader.h>


NS_ASSUME_NONNULL_BEGIN

@interface JLContacts : JLExtension

@property (nonatomic) BOOL granted;
@property (nonatomic) CNAuthorizationStatus status;
@property (nonatomic, strong) CNContactStore * contacts;

- (void) authorize;
- (CNAuthorizationStatus) authorizeWithCompletionHandler:(void (^)(BOOL granted, NSError *__nullable error, CNAuthorizationStatus status))completionHandler;

- (NSString *) statusToString: (CNAuthorizationStatus) status;

- (NSArray *) all;

@end

NS_ASSUME_NONNULL_END
