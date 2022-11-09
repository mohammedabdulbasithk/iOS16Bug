//
//  ViewController.m
//  TesProj
//
//  Created by Basith on 09/11/22.
//

#import "ViewController.h"
#import "CBPreset.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createPresets];
    
    
    NSArray *myArray = [self openPresetsFromFile];
    NSLog(@"My array : %@", myArray);
}

-(void) createPresets {
    NSMutableArray *presetArray = [[NSMutableArray alloc] init];
    int a;
    for(a = 0; a < 5; a = a + 1 ) {
        
        //Adding custom class objects to array makes the problem
        CBPreset *synchedPreset = [[CBPreset alloc] init];
        synchedPreset.name = @"presetName";
        synchedPreset.month = @1;
        synchedPreset.year = @2022;
        synchedPreset.position = @1;
        [presetArray addObject:synchedPreset];
        
        
        //Adding system types objects to array worked fine while unarchiving
//        NSMutableDictionary *dct = [[NSMutableDictionary alloc] init];
//        [dct setValue:@"Name" forKey:@"name"];
//        [dct setValue:@1 forKey:@"month"];
//        [dct setValue:@2022 forKey:@"year"];
//        [dct setValue:@1 forKey:@"position"];
//        [presetArray addObject:dct];
     }
    
    [self savePresets:presetArray.mutableCopy];
}

-(void)savePresets:(NSArray*)presetArray{
//    NSData *plistData2 = [NSKeyedArchiver archivedDataWithRootObject:(id)presetArray];
    NSError *error;
    NSData *plistData2 = [NSKeyedArchiver archivedDataWithRootObject:presetArray requiringSecureCoding:YES error:&error];
    if (plistData2 != nil) {
        [[NSUserDefaults standardUserDefaults] setValue:plistData2 forKey:@"boom"];
        [plistData2 writeToFile:[self presetsDocumentFilePath] atomically: YES];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"presetSynched" object:self];
}


- (NSURL *)presetsDocumentDirectory {
    NSURL *documentsDirectory = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *directories = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    documentsDirectory = [directories lastObject];
    
    NSURL *presetsURL = [documentsDirectory URLByAppendingPathComponent:@"Presets"];

    NSError *error = nil;
    BOOL directoryCreated =
    [fileManager createDirectoryAtURL:presetsURL
          withIntermediateDirectories:YES
                           attributes:nil
                                error:&error];
    if (!directoryCreated) {
        return nil;
    }
    else {
        return presetsURL;
    }
}





- (NSString *)presetsDocumentFilePath {
    NSURL *presetsDirectoryURL = [self presetsDocumentDirectory];
    NSString * presetsFilename = @"Presets.plist";
    NSString *presetsDocument = [[presetsDirectoryURL URLByAppendingPathComponent:presetsFilename] path];
    return presetsDocument;
}

- (NSArray *)openPresetsFromFile {
    NSData *result = [[NSFileManager defaultManager] contentsAtPath:[self presetsDocumentFilePath]];
    NSArray *presets = [[NSArray alloc] init];
    NSError *err;
    @try {
        //this one retured a null value and error
        presets = (NSArray *)[NSKeyedUnarchiver unarchivedObjectOfClass:NSMutableArray.class fromData:result error:&err];
        
        //this one sends an exception and it shows warning as depricated
        presets = (NSArray *)[NSKeyedUnarchiver unarchiveObjectWithData:result];
         
     }
     @catch (NSException *exception) {
        NSLog(@"%@", exception.reason);
     }
    NSLog(@"Count %lu", (unsigned long)presets.count);
    return presets;
}


@end
