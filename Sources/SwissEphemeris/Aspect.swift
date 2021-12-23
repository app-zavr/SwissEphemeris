//
//  Aspect.swift
//  
//
//  29.08.20.
//

import Foundation

/// Models a geometric aspect between two bodies.
public enum Aspect: Equatable, Hashable, Codable {
    
	/// Major Aspects
	/// A 0° alignment.
    case conjunction(Double)
	/// A 60° alignment.
    case sextile(Double)
	/// A 90° alignment.
    case square(Double)
	/// A 120° alignment.
    case trine(Double)
	/// An 180° alignment.
    case opposition(Double)
	
	/// Minor Aspects
	/// A 30° alignment
    case semisextile(Double)
	/// A 45° alignment
    case semisquare(Double)
	/// A 145° alignment
    case sesquisquare(Double)
	/// A 150° alignment
    case quincunx(Double)
	/// A 72° alignment
    case quintile(Double)
	/// A 144° alignment
    // case biquintile(Double)	
	///
	
	/// Creates an optional `Aspect`. If there is no aspect within the orb, then this initializer will return `nil`.
	/// - Parameters:
	///   - pair: The two bodies to compare.
	///   - date: The date of the alignment.
	///   - orb: The number of degrees allowed for the aspect to differ from exactness.
    public init?<T, U>(pair: Pair<T, U>, date: Date, orb: Double = 10.0) {
		let degreeA = Coordinate(body: pair.a, date: date)
		let degreeB = Coordinate(body: pair.b, date: date)
		self.init(a: degreeA.value, b: degreeB.value, orb: orb)
	}
	
	/// Creates an optional `Aspect` between two degrees. If there is no aspect within the orb, then this initializer will return `nil`.
	/// - Parameters:
	///   - a: The first degree in the pair.
	///   - b: The second degree in the pair.
	///   - orb: The number of degrees allowed for the aspect to differ from exactness.
	public init?(a: Double, b: Double, orb: Double) {
		let aspectValue = abs(b - a) >= 180 ?
			abs(abs(b - a) - 360) : abs(b - a)
		switch aspectValue {
		case (0 - orb)...(0 + orb):
			self = .conjunction(round(aspectValue * 100) / 100)
		case (30 - orb)...(30 + orb):
			self = .semisextile(round((aspectValue - 30) * 100) / 100)
		case (45 - orb)...(45 + orb):
			self = .semisquare(round((aspectValue - 45) * 100) / 100)
		case (60 - orb)...(60 + orb):
			self = .sextile(round((aspectValue - 60) * 100) / 100)
		case (72 - orb)...(72 + orb):
			self = .quintile(round((aspectValue - 72) * 100) / 100)
		case (90 - orb)...(90 + orb):
			self = .square(round((aspectValue - 90) * 100) / 100)
		case (120 - orb)...(120 + orb):
			self = .trine(round((aspectValue - 120) * 100) / 100)
		// case (144 - orb)...(144 + orb):											
		// 	self = .biquintile(round((aspectValue - 144) * 100) / 100)
		case (145 - orb)...(145 + orb):
			self = .sesquisquare(round((aspectValue - 145) * 100) / 100)
		case (150 - orb)...(150 + orb):
			self = .quincunx(round((aspectValue - 150) * 100) / 100)
		case (180 - orb)...(180 + orb):
			self = .opposition(round((aspectValue - 180) * 100) / 100)
		default:
			return nil
		}
	}

	/// The symbol commonly associated with the aspect.
    public var symbol: String? {
        switch self {
        case .conjunction:
            return "☌"
        case .sextile:
            return "﹡"
        case .square:
            return "◾️"
        case .trine:
            return "▵"
        case .opposition:
            return "☍"
		case .semisextile:
			return "⊻"
		case .semisquare:
			return "⦣"
		case .sesquisquare:
			return "sS"			// Most of fonts doesn't support this unicode char U+26BC
		case .quincunx:
			return "⊼"
		case .quintile:
			return "Q"
		// case .biquintile:
			// return "bQ"
        }
    }
	
	/// The number of degrees from exactness.
	var remainder: Double {
		switch self {
		case .conjunction(let remainder), 
			.sextile(let remainder), 
			.square(let remainder),
			.trine(let remainder), 
			.opposition(let remainder), 
			.semisextile(let remainder),
			.semisquare(let remainder), 
			.sesquisquare(let remainder), 
			.quincunx(let remainder),
			.quintile(let remainder):
			// .biquintile(let remainder):
			return remainder
		}
	}
}
