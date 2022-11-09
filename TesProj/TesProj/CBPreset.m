//
//  CBPreset.m
//  TesProj
//
//  Created by Basith on 09/11/22.
//

#import <Foundation/Foundation.h>
#import "CBPreset.h"


NSString *CBPresetEntityName = @"Preset";

@implementation CBPreset
 

+ (BOOL)supportsSecureCoding {
    return YES;
}


- (void)encodeWithCoder:(NSCoder *)coder{
    [coder encodeObject:_month forKey:@"month"];
    [coder encodeObject:_year forKey:@"year"];
    [coder encodeObject:_position forKey:@"position"];
    [coder encodeObject:_name forKey:@"name"];
    
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        self.month = [decoder decodeObjectOfClass:[NSNumber class] forKey:@"month"];
        self.year = [decoder decodeObjectOfClass:[NSNumber class] forKey:@"year"];
        self.position = [decoder decodeObjectOfClass:[NSNumber class] forKey:@"position"];
        self.name = [decoder decodeObjectOfClass:[NSString class] forKey:@"name"];
    }
    return self;
}

@end
