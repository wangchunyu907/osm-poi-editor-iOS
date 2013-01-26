//
//  OPEManagedReferencePoiCategory.m
//  OSM POI Editor
//
//  Created by David on 1/25/13.
//
//

#import "OPEManagedReferencePoiCategory.h"
#import "OPEManagedReferencePoi.h"

@interface OPEManagedReferencePoiCategory ()

// Private interface goes here.

@end


@implementation OPEManagedReferencePoiCategory

-(NSArray *)allSortedPois
{
    NSPredicate *typeFilter = [NSPredicate predicateWithFormat:@"canAdd == %@ AND isLegacy==%@",[NSNumber numberWithBool:YES],[NSNumber numberWithBool:NO]];
    NSArray * filteredArray = [[self.referencePois filteredSetUsingPredicate:typeFilter] allObjects];
    NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortByName];
    NSArray * sortedArray = [filteredArray sortedArrayUsingDescriptors:sortDescriptors];
    
    return sortedArray;
    
    
    
}

+(NSArray *)allSortedCategories
{
    NSPredicate *osmCategoryFilter = [NSPredicate predicateWithFormat:@"referencePois.@count > 0"];
    NSArray * results = [OPEManagedReferencePoiCategory MR_findAllWithPredicate:osmCategoryFilter];
    NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortByName];
    NSArray * sortedArray = [results sortedArrayUsingDescriptors:sortDescriptors];
    
    return sortedArray;
    
}

+(OPEManagedReferencePoiCategory *)fetchOrCreateWithName:(NSString *)name
{
    NSPredicate *osmPoiFilter = [NSPredicate predicateWithFormat:@"name == %@",name];
    NSArray * results = [OPEManagedReferencePoiCategory MR_findAllWithPredicate:osmPoiFilter];
    
    OPEManagedReferencePoiCategory * referencePoiCategory = nil;
    
    if(![results count])
    {
        referencePoiCategory = [OPEManagedReferencePoiCategory MR_createEntity];
        referencePoiCategory.name = name;
        
        NSManagedObjectContext *context = [NSManagedObjectContext MR_contextForCurrentThread];
        [context MR_saveToPersistentStoreAndWait];
    }
    else
    {
        referencePoiCategory = [results objectAtIndex:0];
    }
    return referencePoiCategory;
}

@end
