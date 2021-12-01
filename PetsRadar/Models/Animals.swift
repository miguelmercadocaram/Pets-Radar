//
//  Animals.swift
//  PetsRadar
//
//  Created by Pelayo Mercado on 11/29/21.
//

import Foundation

struct Animals: Codable {
    let animals: [Animal]
}

struct Animal: Codable {
    let age: String
    let name: String
    let description: String?
    let photos: [Photo]?
    let status: String
    let published_at: String
    let contact: Contact?
}

struct Photo: Codable {
    let small: String
    let medium: String
    let large: String
    let full: String

}

struct Contact: Codable {
    let email: String?
    let phone: String?
   let address: Address?
}

struct Address: Codable {
    let address1: String?
    let address2: String?
    let city: String
    let state: String
    let postcode: String
    let country: String
}

//{
//    animals =     (
//                {
//            "_links" =             {
//                organization =                 {
//                    href = "/v2/organizations/il192";
//                };
//                self =                 {
//                    href = "/v2/animals/53716290";
//                };
//                type =                 {
//                    href = "/v2/types/dog";
//                };
//            };
//            age = Baby;
//            attributes =             {
//                declawed = "<null>";
//                "house_trained" = 0;
//                "shots_current" = 1;
//                "spayed_neutered" = 1;
//                "special_needs" = 0;
//            };
//            breeds =             {
//                mixed = 1;
//                primary = "American Staffordshire Terrier";
//                secondary = "German Shepherd Dog";
//                unknown = 0;
//            };
//            coat = Short;
//            colors =             {
//                primary = Black;
//                secondary = "White / Cream";
//                tertiary = "<null>";
//            };
//            contact =             {
//                address =                 {
//                    address1 = "13005 Ernesti Rd";
//                    address2 = "<null>";
//                    city = Huntley;
//                    country = US;
//                    postcode = 60142;
//                    state = IL;
//                };
//                email = "info@animalhouseshelter.com";
//                phone = "(847) 961-5541";
//            };
//            description = "SPECIAL APPOINTMENT ONLY!!!\n\nTo meet newly adoptable puppies, you must have an APPROVED application THEN email ahs.adoption.appointments@gmail.com Inquiries will be...";
//            distance = "<null>";
//            environment =             {
//                cats = 1;
//                children = 1;
//                dogs = 1;
//            };
//            gender = Male;
//            id = 53716290;
//            name = Sander;
//            "organization_animal_id" = "<null>";
//            "organization_id" = IL192;
//            photos =             (
//                                {
//                    full = "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/53716290/1/?bust=1638211783";
//                    large = "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/53716290/1/?bust=1638211783&width=600";
//                    medium = "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/53716290/1/?bust=1638211783&width=300";
//                    small = "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/53716290/1/?bust=1638211783&width=100";
//                },
//                                {
//                    full = "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/53716290/2/?bust=1638211784";
//                    large = "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/53716290/2/?bust=1638211784&width=600";
//                    medium = "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/53716290/2/?bust=1638211784&width=300";
//                    small = "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/53716290/2/?bust=1638211784&width=100";
//                },
//                                {
//                    full = "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/53716290/3/?bust=1638211785";
//                    large = "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/53716290/3/?bust=1638211785&width=600";
//                    medium = "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/53716290/3/?bust=1638211785&width=300";
//                    small = "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/53716290/3/?bust=1638211785&width=100";
//                },
//                                {
//                    full = "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/53716290/4/?bust=1638211785";
//                    large = "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/53716290/4/?bust=1638211785&width=600";
//                    medium = "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/53716290/4/?bust=1638211785&width=300";
//                    small = "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/53716290/4/?bust=1638211785&width=100";
//                },
//                                {
//                    full = "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/53716290/5/?bust=1638211786";
//                    large = "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/53716290/5/?bust=1638211786&width=600";
//                    medium = "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/53716290/5/?bust=1638211786&width=300";
//                    small = "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/53716290/5/?bust=1638211786&width=100";
//                }
//            );
//            "primary_photo_cropped" =             {
//                full = "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/53716290/1/?bust=1638211783";
//                large = "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/53716290/1/?bust=1638211783&width=600";
//                medium = "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/53716290/1/?bust=1638211783&width=450";
//                small = "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/53716290/1/?bust=1638211783&width=300";
//            };
//            "published_at" = "2021-11-29T18:49:47+0000";
//            size = Medium;
//            species = Dog;
//            status = adoptable;
//            "status_changed_at" = "2021-11-29T18:49:47+0000";
//            tags =             (
//            );
//            type = Dog;
//            url = "https://www.petfinder.com/dog/sander-53716290/il/huntley/animal-house-shelter-il192/?referrer_id=cd829356-2e57-4176-af6e-4ec1181efac7";
//            videos =             (
//            );
//        }
//    );
//    pagination =     {
//        "_links" =         {
//            next =             {
//                href = "/v2/animals?limit=1&page=3&type=dog";
//            };
//            previous =             {
//                href = "/v2/animals?limit=1&page=1&type=dog";
//            };
//        };
//        "count_per_page" = 1;
//        "current_page" = 2;
//        "total_count" = 96842;
//        "total_pages" = 96842;
//    };
//}
