	var BrowserDetect = {
		init : function() {
			this.browser = this.searchString(this.dataBrowser)
					|| "An unknown browser";
			this.version = this.searchVersion(navigator.userAgent)
					|| this.searchVersion(navigator.appVersion)
					|| "an unknown version";
			this.OS = this.searchString(this.dataOS) || "an unknown OS";
		},
		searchString : function(data) {
			for ( var i = 0; i < data.length; i++) {
				var dataString = data[i].string;
				var dataProp = data[i].prop;
				this.versionSearchString = data[i].versionSearch
						|| data[i].identity;
				if (dataString) {
					if (dataString.indexOf(data[i].subString) != -1)
						return data[i].identity;
				} else if (dataProp)
					return data[i].identity;
			}
	
		},
		searchVersion : function(dataString) {
			var index = dataString.indexOf(this.versionSearchString);
			if (index == -1)
				return;
			return parseFloat(dataString.substring(index
					+ this.versionSearchString.length + 1));
		},
		dataBrowser : [ {
			string : navigator.userAgent,
			subString : "Chrome",
			identity : "Chrome"
		}, {
			string : navigator.userAgent,
			subString : "OmniWeb",
			versionSearch : "OmniWeb/",
			identity : "OmniWeb"
		}, {
			string : navigator.vendor,
			subString : "Apple",
			identity : "Safari",
			versionSearch : "Version"
		}, {
			prop : window.opera,
			identity : "Opera",
			versionSearch : "Version"
		}, {
			string : navigator.vendor,
			subString : "iCab",
			identity : "iCab"
		}, {
			string : navigator.vendor,
			subString : "KDE",
			identity : "Konqueror"
		}, {
			string : navigator.userAgent,
			subString : "Firefox",
			identity : "Firefox"
		}, {
			string : navigator.vendor,
			subString : "Camino",
			identity : "Camino"
		},
	
		{ // for newer Netscapes (6+)
			string : navigator.userAgent,
			subString : "Netscape",
			identity : "Netscape"
		}, {
			string : navigator.userAgent,
			subString : "MSIE",
			identity : "Explorer",
			versionSearch : "MSIE"
		}, {
			string : navigator.userAgent,
			subString : "Gecko",
			identity : "Mozilla",
			versionSearch : "rv"
		}, { // for older Netscapes (4-)
			string : navigator.userAgent,
			subString : "Mozilla",
			identity : "Netscape",
			versionSearch : "Mozilla"
		} ],
	
		dataOS : [ {
			string : navigator.platform,
			subString : "Win",
			identity : "Windows"
		}, {
			string : navigator.platform,
	
			subString : "Mac",
	
			identity : "Mac"
	
		}, {
			string : navigator.userAgent,
			subString : "iPhone",
			identity : "iPhone/iPod"
		}, {
			string : navigator.platform,
			subString : "Linux",
			identity : "Linux"
		} ]
	
	};
	
	BrowserDetect.init();
	
	var PdfDetect = {
		GetInfo : function(explorerName) {
			this.pdfVersion = this.searchPdf(explorerName);
	
		},
		searchPdf : function(explorerName) {
			explorerName = explorerName.toLowerCase();
			if (explorerName != 'explorer' && navigator.plugins.length > 0) {
				var version = 0;
				if (navigator.plugins['Adobe Acrobat']
						|| navigator.plugins['Adobe PDF Plug-in']) {
					if (explorerName == 'chrome') {
						// version = navigator.plugins[i].name.match(/([\d.]+)/) +
						// "<br />"
						version = 8; // chrome浏览器无法有效检测pdf版本
					}
					else {
						version = navigator.plugins['Adobe PDF Plug-in'] ?
						navigator.plugins['Adobe Acrobat'].version :
						navigator.plugins['Adobe Acrobat'].version;
					}
				}
				return version;
			}
	
			else {
				var contol = null;
				try {
					// AcroPDF.PDF is used by version 7 and later
					control = new ActiveXObject('AcroPDF.PDF');
				} catch (e) {
					return 0;
				}
	
				if (!control) {
					try {
						// PDF.PdfCtrl is used by version 6 and earlier
						control = new ActiveXObject('PDF.PdfCtrl');
					} catch (e) {
						return 0;
					}
				}
	
				if (control) {
					isInstalled = true;
					version = control.GetVersions().split(',');
					version = version[0].split('=');
					version = parseFloat(version[1]);
					return version;
				}
	
				return 0;
	
			}
	
		}
	
	};
	
	function isExistPdfPlug(){
		PdfDetect.GetInfo(BrowserDetect.browser);
		var version = PdfDetect.pdfVersion;
		if(version==0){
			return false;
		}else{
			return true;
		}
	}
	
	function download(){
		return "http://192.168.3.125/manual1/tools/AdbeRdr.exe";
	}