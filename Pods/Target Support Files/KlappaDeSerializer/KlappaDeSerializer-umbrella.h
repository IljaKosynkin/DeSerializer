#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "KlappaDeSerializer.h"
#import "KLPDeserializer.h"
#import "KLPStringToURLConverter.h"
#import "KLPStandardDeserializer.h"
#import "KLPArrayTypeExtractor.h"
#import "KLPDeserializable.h"
#import "KLPDeserializerProtocol.h"
#import "KLPFieldsRetriever.h"
#import "KLPNamingStrategy.h"
#import "KLPValueConverter.h"
#import "KLPDefaultNamingStrategy.h"
#import "KLPExplicitNamingStrategy.h"
#import "KLPConvertedTypes.h"
#import "KLPDefaultArrayTypeExtractor.h"
#import "KLPDefaultFieldsRetriever.h"

FOUNDATION_EXPORT double KlappaDeSerializerVersionNumber;
FOUNDATION_EXPORT const unsigned char KlappaDeSerializerVersionString[];

