﻿package com.webdevils {	import flash.display.*;	import flash.events.*;		public class Rotating_Knob extends MovieClip {		private var max_angle:Number;		private var rotate_knob:Boolean;		private static const WIDGET:Number = 180 / Math.PI;				public function Rotating_Knob() {			max_angle = 120;			rotate_knob = false;						setup_event_listeners();		}				private function setup_event_listeners():void {			addEventListener( MouseEvent.MOUSE_DOWN, on_press );		}				private function on_press( e:MouseEvent ):void {			rotate_knob = true;			addEventListener( MouseEvent.MOUSE_UP, on_release );			stage.addEventListener( MouseEvent.MOUSE_UP, on_release );			addEventListener( Event.ENTER_FRAME, on_mousemove );		}				private function on_release( e:MouseEvent ):void {			rotate_knob = true;			removeEventListener( MouseEvent.MOUSE_UP, on_release );			stage.removeEventListener( MouseEvent.MOUSE_UP, on_release );			removeEventListener( Event.ENTER_FRAME, on_mousemove );		}				private function on_mousemove( e:Event ):void {			var r = Math.floor( Math.atan2( mouseY, mouseX ) * WIDGET );			knob_mc.rotation = r + 90;						if ( knob_mc.rotation <= -max_angle ) {				knob_mc.rotation = -max_angle; 			}						if ( knob_mc.rotation >= max_angle ) { 				knob_mc.rotation = max_angle;			}					var n:Number = Math.floor( ( 100 + knob_mc.rotation / max_angle * 100 ) / 2 );			// trace( n );			dispatchEvent( new KnobEvent( KnobEvent.UPDATE, n ) );		}	} // -----------------------------------------}