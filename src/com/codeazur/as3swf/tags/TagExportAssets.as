﻿package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.SWFSymbol;
	import com.codeazur.utils.StringUtils;
	
	public class TagExportAssets extends Tag implements ITag
	{
		public static const TYPE:uint = 56;
		
		protected var _symbols:Vector.<SWFSymbol>;
		
		public function TagExportAssets() {
			_symbols = new Vector.<SWFSymbol>();
		}
		
		public function get symbols():Vector.<SWFSymbol> { return _symbols; }
		
		public function parse(data:SWFData, length:uint):void {
			var numSymbols:uint = data.readUI16();
			for (var i:uint = 0; i < numSymbols; i++) {
				_symbols.push(data.readSYMBOL());
			}
		}

		override public function publish(data:SWFData):void {
			var body:SWFData = new SWFData();
			var numSymbols:uint = _symbols.length;
			body.writeUI16(numSymbols);
			for (var i:uint = 0; i < numSymbols; i++) {
				body.writeSYMBOL(_symbols[i]);
			}
			data.writeTagHeader(type, body.length);
			data.writeBytes(body, 0, body.length);
		}
		
		override public function get type():uint { return TYPE; }
		override public function get name():String { return "ExportAssets"; }
		override public function get version():uint { return 5; }
		
		public function toString(indent:uint = 0):String {
			var str:String = toStringMain(indent);
			if (_symbols.length > 0) {
				str += "\n" + StringUtils.repeat(indent + 2) + "Assets:";
				for (var i:uint = 0; i < _symbols.length; i++) {
					str += "\n" + StringUtils.repeat(indent + 4) + "[" + i + "] " + _symbols[i].toString();
				}
			}
			return str;
		}
	}
}
