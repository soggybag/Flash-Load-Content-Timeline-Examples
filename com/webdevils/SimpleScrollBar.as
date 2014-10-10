﻿package com.webdevils {	import flash.display.Stage;	import flash.display.MovieClip;	import flash.events.*;	import flash.geom.Rectangle;	import flash.text.*;	public class SimpleScrollBar extends MovieClip {		private var scroll_rect:Rectangle;				private var upper_limit:Number;		private var lower_limit:Number;		private var range:Number;		private var scroll_speed:Number;				private var is_horizontal:Boolean;		private var drag:MovieClip;		private var track:MovieClip;		private var up:MovieClip;		private var down:MovieClip;		public function SimpleScrollBar( _drag:MovieClip = null, _track:MovieClip = null, _up:MovieClip = null, _down:MovieClip = null ) {			scroll_speed = .033;			is_horizontal = false;						if ( _drag != null ) {				drag  = _drag;			} else { 				drag = drag_mc;			}						if ( _track != null ) {				track = _track;			} else {				track = track_mc;			}						if ( _up != null ) {				up    = _up;			} else {				up = up_mc;			}						if ( _down != null ) {				down  = _down;			} else {				down = down_mc;			}			setup_clips();			set_limits();		}						// Set up movie clips. 		private function setup_clips():void {			if ( drag != null ) {				drag.buttonMode = true;				drag.mouseChildren = false;				drag.addEventListener( MouseEvent.MOUSE_DOWN, press_drag );			}						if ( track != null ) {				track.buttonMode = true;				track.mouseChildren = false;				track.addEventListener( MouseEvent.CLICK, click_track );			}						if ( up != null ) {				up.buttonMode = true;				up.addEventListener( MouseEvent.MOUSE_DOWN, press_up );			} 						if ( down != null ) {				down.buttonMode = true;				down.addEventListener( MouseEvent.MOUSE_DOWN, press_down );			}		}						// Functions for up and down buttons -------------------------------------------		private function press_up( e:MouseEvent ):void {			addEventListener( Event.ENTER_FRAME, scroll_up );			up.stage.addEventListener( MouseEvent.MOUSE_UP, release_up );		}				private function press_down( e:MouseEvent ):void {			addEventListener( Event.ENTER_FRAME, scroll_down );			down.stage.addEventListener( MouseEvent.MOUSE_UP, release_down );		}				private function release_up( e:MouseEvent ):void {			removeEventListener( Event.ENTER_FRAME, scroll_up );			up.stage.removeEventListener( MouseEvent.MOUSE_UP, release_up );		}				private function release_down( e:MouseEvent ):void {			removeEventListener( Event.ENTER_FRAME, scroll_down );			down.stage.removeEventListener( MouseEvent.MOUSE_UP, release_down );		}				private function scroll_up( e:Event ):void {			if ( is_horizontal ) {				drag.x -= range * scroll_speed;				if ( drag.x < upper_limit ) {					drag.x = upper_limit;				}			} else {				drag.y -= range * scroll_speed;				if ( drag.y < upper_limit ) {					drag.y = upper_limit;				}			}			broadcast_update();		}				private function scroll_down( e:Event ):void {			if ( is_horizontal ) {				drag.x += range * scroll_speed;				if ( drag.x > lower_limit ) {					drag.x = lower_limit;				}			} else {				drag.y += range * scroll_speed;				if ( drag.y > lower_limit ) {					drag.y = lower_limit;				}			}			broadcast_update();		}		// ----------------------------------------------------------------------------												// Dragger functions ----------------------------------------------------------		private function press_drag( e:MouseEvent ):void {			drag.stage.addEventListener( MouseEvent.MOUSE_UP, release_drag, false, 0, true );			drag.startDrag( false, scroll_rect );			drag.addEventListener( Event.ENTER_FRAME, dragging );		}				private function release_drag( e:MouseEvent ):void {			drag.removeEventListener( Event.ENTER_FRAME, dragging );			drag.stage.removeEventListener( MouseEvent.MOUSE_UP, release_drag );			drag.stopDrag();		}				private function dragging( e:Event ):void {			broadcast_update();		}		// ----------------------------------------------------------------------------												// Track functions ------------------------------------------------------------		private function click_track( e:MouseEvent ):void {			// add		}		// ----------------------------------------------------------------------------										// General functions ----------------------------------------------------------		private function set_limits():void {			if ( is_horizontal ) {				scroll_rect = new Rectangle( track.x, track.y, track.width - drag.width, 0 );				upper_limit = track.x;				range = track.width - drag.width;				lower_limit = track.x + range;			} else {				scroll_rect = new Rectangle( track.x, track.y, 0, track.height - drag.height );				upper_limit = track.y;				range = track.height - drag.height;				lower_limit = track.y + range;			}		}				private function calculate_scroll_precent():Number {			if ( is_horizontal ) {				return ( drag.x - track.x ) / range;			} else {				return ( drag.y - track.y ) / range;			}		}				private function broadcast_update():void {			dispatchEvent( new ScrollBarEvent( ScrollBarEvent.UPDATE, calculate_scroll_precent() ) );		}										// public functions -----------------------------------------------------------------		public function set_scroll_speed( _n:Number ):void {			scroll_speed = _n;		}				public function scroll_horizontal():void {			is_horizontal = true;			set_limits();		}				public function scroll_vertical():void {			is_horizontal = false;			set_limits();		}	}}