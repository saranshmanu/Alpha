//
//  Constants.swift
//  AlphaHealthDoctor
//
//  Created by Saransh Mittal on 11/03/18.
//  Copyright © 2018 Saransh Mittal. All rights reserved.
//

import Foundation
import UIKit

var diseases = [["A064", "Abscess"], ["G300", "Alzheimer's disease"], ["A220", "Anthrax"], ["K352", "Appendicitis"], ["I69090", "Apraxia"], ["A0104", "Arthritis"], ["A2781", "Aseptic meningitis"], ["G7000", "Asthenia"], ["J4520", "Asthma"], ["H52201", "Astigmatism"], ["I25700", "Atherosclerosis"], ["A5044", "Atrophy"], ["G008", "Bacterial meningitis"], ["E5111", "Beriberi"], ["A051", "Botulism"], ["J200", "Bronchitis"], ["A230", "Brucellosis"], ["A200", "Bubonic plague"], ["M21611", "Bunion"], ["D701", "Cancer"], ["B371", "Candidiasis"], ["G800", "Cerebral palsy"], ["H0011", "Chalazion"], ["A57", "Chancroid"], ["A55", "Chlamydia"], ["A000", "Cholera"], ["G254", "Chorea"], ["G4720", "Circadian rhythm sleep disorder"], ["B380", "Coccidioidomycosis"], ["A047", "Colitis"], ["J00", "Common cold"], ["A5131", "Condyloma"], ["B08010", "Cowpox"], ["K5000", "Crohn's Disease"], ["A90", "Dengue"], ["E08621", "Diabetes mellitus"], ["A360", "Diphtheria"], ["E860", "Dehydration"], ["A060", "Dysentery"], ["A984", "Ebola"], ["A1782", "Encephalitis"], ["J430", "Emphysema"], ["G40301", "Epilepsy"], ["M797", "Fibromyalgia"], ["A150", "flu"], ["A480", "Gangrene"], ["A09", "Gastroenteritis"], ["A609", "Genital herpes"], ["O98211", "Gonorrhea"], ["I018", "Heart disease"], ["B150", "Hepatitis A"], ["B160", "Hepatitis B"], ["B1710", "Hepatitis C"], ["B172", "Hepatitis E"], ["B20", "HIV"], ["R8581", "Human papillomavirus"], ["G10", "Huntington's disease"], ["H5200", "Hypermetropia"], ["P721", "Hyperthyroidism"], ["E02", "Hypothyroid"], ["P942", "Hypotonia"], ["L0100", "Impetigo"], ["N468", "Infertility"], ["A413", "Influenza"], ["N3010", "Interstitial cystitis"], ["K580", "Irritable bowel syndrome"], ["P580", "Jaundice"], ["A8181", "Kuru"], ["E40", "Kwashiorkor"], ["J040", "Laryngitis"], ["B550", "Leishmaniasis"], ["A300", "Leprosy"], ["A270", "Leptospirosis"], ["A320", "Listeriosis"], ["C9010", "Leukemia"], ["G9341", "Lice"], ["B743", "Loiasis"], ["H01121", "Lupus erythematosus"], ["A6920", "Lyme disease"], ["C8100", "Lymphoma"], ["B500", "Malaria"], ["B050", "Measles"], ["C430", "Melanoma"], ["A0101", "Meningitis"], ["G43001", "Migraine"], ["B2700", "Mononucleosis"], ["C9000", "Multiple myeloma"], ["G35", "Multiple sclerosis"], ["B260", "Mumps"], ["G710", "Muscular dystrophy"], ["G7000", "Myasthenia gravis"], ["A0105", "Myelitis"], ["G253", "Myoclonus"], ["H442A1", "Myopia"], ["E001", "Myxedema"], ["B2700", "Mononucleosis"], ["C000", "Neoplasm"], ["M726", "Necrotizing Fasciitis"], ["E505", "Night blindness"], ["E6601", "Obesity"], ["M158", "Osteoarthritis"], ["M810", "Osteoporosis"], ["A380", "Otitis"], ["M1230", "Palindromic rheumatism"], ["A011", "Paratyphoid fever"], ["G20", "Parkinson's disease"], ["A1817", "Pelvic inflammatory disease"], ["A1831", "Peritonitis"], ["E08630", "Periodontal disease"], ["A3700", "Pertussis"], ["E700", "Phenylketonuria"], ["A200", "Plague"], ["A800", "Poliomyelitis"], ["E800", "Porphyria"], ["A5422", "Prostatitis"], ["L400", "Psoriasis"], ["I2601", "Pulmonary embolism"], ["A0103", "pneumonia"], ["A78", "Q fever"], ["A820", "Rabies"], ["I00", "Rheumatic fever"], ["I018", "Rheumatic heart"], ["M1230", "Rheumatism"], ["M0510", "Rheumatoid arthritis"], ["E550", "Rickets"], ["A924", "Rift Valley fever"], ["B0600", "Rubella"], ["B86", "Scabies"], ["A380", "Scarlet fever"], ["M5430", "Sciatica"], ["L940", "Scleroderma"], ["A021", "Sepsis"], ["B9721", "SARS"], ["A030", "Shigellosis"], ["H44321", "Siderosis"], ["B03", "Smallpox"], ["L511", "Stevens-Johnson syndrome"], ["H49881", "Strabismus"], ["A491", "Streptococcal infection"], ["M1220", "Synovitis"], ["A5006", "Syphilis"], ["F200", "Schizophrenia"], ["B680", "Taeniasis"], ["E7502", "Tay-Sachs disease"], ["A33", "Tetanus"], ["H9311", "Tinnitus"], ["B002", "Tonsillitis"], ["A483", "Toxic shock syndrome"], ["A5900", "Trichomoniasis"], ["Q900", "Trisomy"], ["A150", "Tuberculosis"], ["A210", "Tularemia"], ["B881", "Tungiasis"], ["A0100", "Typhoid fever"], ["A750", "Typhus"], ["C49A0", "Tumor"], ["K5180", "Ulcerative colitis"], ["A664", "Ulcers"], ["R392", "Uremia"], ["L500", "Urticaria"], ["H44111", "Uveitis"], ["B010", "Varicella"], ["I83001", "Varicose veins"], ["H02731", "Vitiligo"], ["A928", "Viral fever"], ["A870", "Viral meningitis"], ["A924", "Valley fever"], ["A630", "Warts"], ["A950", "Yellow fever"], ["A282", "Yersiniosis"]]

var patientPublicKey = ""

@IBDesignable extension UIView {
    /* The color of the shadow. Defaults to opaque black. Colors created
     * from patterns are currently NOT supported. Animatable. */
    @IBInspectable var shadowColor: UIColor? {
        set {
            layer.shadowColor = newValue!.cgColor
        }
        get {
            if let color = layer.shadowColor {
                return UIColor.black
            }
            else {
                return nil
            }
        }
    }
    /* The opacity of the shadow. Defaults to 0. Specifying a value outside the
     * [0,1] range will give undefined results. Animatable. */
    @IBInspectable var shadowOpacity: Float {
        set {
            layer.shadowOpacity = newValue
        }
        get {
            return layer.shadowOpacity
        }
    }
    /* The shadow offset. Defaults to (0, -3). Animatable. */
    @IBInspectable var shadowOffset: CGPoint {
        set {
            layer.shadowOffset = CGSize(width: newValue.x, height: newValue.y)
        }
        get {
            return CGPoint(x: layer.shadowOffset.width, y:layer.shadowOffset.height)
        }
    }
    /* The blur radius used to create the shadow. Defaults to 3. Animatable. */
    @IBInspectable var shadowRadius: CGFloat {
        set {
            layer.shadowRadius = newValue
        }
        get {
            return layer.shadowRadius
        }
    }
}

// things to be adde in the appointment
// date, disease, time, location, 
