//
//  CBPreset.h
//  TesProj
//
//  Created by Basith on 09/11/22.
//
#import <Foundation/Foundation.h>


@interface CBPreset : NSObject <NSCoding, NSSecureCoding>


@property (nonatomic, strong) NSNumber *month;
@property (nonatomic, strong) NSNumber *year;
@property (nonatomic, strong) NSNumber *position;
@property (nonatomic, strong) NSString *name;


@end

