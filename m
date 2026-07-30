Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023099.outbound.protection.outlook.com [52.101.127.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBEC3B27C6;
	Thu, 30 Jul 2026 11:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785412223; cv=fail; b=M7z2aGpbLq5vxXDi3IWCVoaDF3umS9w0gy8eKoygZ+y/cPipjGS5aNMxj4DRjSpM9Pb/AMOwp2oDcDUL4HgQWV7graCA8K08Ui6yvHx5dAoMyRkK2G3CFeheCHkwGW4p3hBp2C28tjBtF19fuvcfMG58Jad14CKsAKH+Ykm7Ajo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785412223; c=relaxed/simple;
	bh=Q5TI42tOVseKcEPXIOJ5qZzoz6h/ZoVAHe4stWbcqw0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rbOsqRVQgeCJguUkprPKGvtNnAiI4gE+hz3H+m+7NJLcgi2SOYqM5ICm9yEVpkxOt3nBjwx4yMtOBxuaIkfhL8PpiBq3+qfX4Qg3lRaK0DnpXKejT7ZZRDGI0/OjVSM/JP2vD8xi+U+RsYjpVXoD4TmYuNxV2raqUa5xdl6GG0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com; spf=pass smtp.mailfrom=transsion.com; dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b=HgJ29ZHE; arc=fail smtp.client-ip=52.101.127.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=transsion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b="HgJ29ZHE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OBaJZEcaO/+pylNLOXWI7VCUEJsuWCiWsYynP0EKZU1jVmjdV8klJ3lC5ZxRs4PTuwBeXEZGLe+4CzDBQxfOOe3+ocBYmsX72JOK/mU5fE5Wr58YCKwxn2vj7bn+FxTgmg7fmuHFfWtufZ+4dTds3WYxN9AmZ4BZbqHKkub5j++uxhRMyHXDWbpSeCk5E/amAbCwqmbfnDScxvKUKK7RH1XkVzBvXVE4DeVnkdKH3g0AyeIjEtV32u7mojnt+AmuCBxLukiBlSK4rIyp/f4DLvIwPrTiFsBE7HBUCnX+58iQ00HcRJX/Y78MJGBAhb+GhpzPwo4ZWBTAVoiPT5jDgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q5TI42tOVseKcEPXIOJ5qZzoz6h/ZoVAHe4stWbcqw0=;
 b=Y22fVmvo1yQvFF5B3WS/WPGprpuaK17TkbMIDAWaKmFqbdUKShGd5f0+HjYhbd4rXO/0hbhgokYpbENYe+/HQtZD7WESuo+4+CiPBxHIriJqWtvrBVHVjJ1dfP+UWPF6REfK7eNGM2rA07ZyqHrTH0HmDsMd/FK1de3nV5mwU0YevbPoOV8ZIMtQcTF4RvzCUWmLV/40bvJJdim43L14qOZN1q7jU1UPrL9+Hg0+fYQ0Tinrtquo20C1Q0snUCumfJft9Ba9yJ9wd5BBJnEik7PO4XOqWqdiUQQsbbs6Cnf5N0Lhaj3MQkUIk2GYPcg2Sg8alv6tVFZ2CrGx3FLIRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5TI42tOVseKcEPXIOJ5qZzoz6h/ZoVAHe4stWbcqw0=;
 b=HgJ29ZHEvnyDpC+VXbwTR8AHvnTstlVNm1+dbTuaHCEVL2ZdFTz0bC4hkGUutAv4rgE61LGaSQh6xuT1ZC2XOZ5MpaZ/d8bEulu8SyeCSZ+5VvKGIxz/zGK4ntfmmwd4BSdN3j2YivloSPnmhOcnmzybsXd0AC8kk+AOCJXbBg8=
Received: from TY0PR04MB6192.apcprd04.prod.outlook.com (2603:1096:400:32b::10)
 by SEZPR04MB7734.apcprd04.prod.outlook.com (2603:1096:101:21d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.8; Thu, 30 Jul
 2026 11:50:18 +0000
Received: from TY0PR04MB6192.apcprd04.prod.outlook.com
 ([fe80::e43:f9a5:d1da:59bb]) by TY0PR04MB6192.apcprd04.prod.outlook.com
 ([fe80::e43:f9a5:d1da:59bb%5]) with mapi id 15.21.0292.005; Thu, 30 Jul 2026
 11:50:18 +0000
From: Hongyan Xia <hongyan.xia@transsion.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Steven Rostedt
	<steven@rostedt.org>
CC: Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter
	<cl@gentwo.org>, Oleg Nesterov <oleg@redhat.com>, Naveen N Rao
	<naveen@kernel.org>, "David S. Miller" <davem@davemloft.net>, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
	Jiazi Li <jiazi.li@transsion.com>, Pu Hu <hupu@transsion.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>, "llvm@lists.linux.dev"
	<llvm@lists.linux.dev>
Subject: Re: [RFC PATCH 9/9] arm64/debug: Mark debug exception helpers
 __always_inline
Thread-Topic: [RFC PATCH 9/9] arm64/debug: Mark debug exception helpers
 __always_inline
Thread-Index: AQHdHcMO39AcF/TaiUWqS0RapTlJlbaEzxIAgABjAYCAAMVngA==
Date: Thu, 30 Jul 2026 11:50:17 +0000
Message-ID: <2c7a6d63-b98a-4d8d-897f-50ad365026ff@transsion.com>
References: <cover.1785153469.git.hongyan.xia@transsion.com>
 <eb38b41ae1b3216ec69fb45555ef5df57efd7b8d.1785153469.git.hongyan.xia@transsion.com>
 <20260729140846.3c18f437@gandalf.local.home>
 <20260730090307.24d3e4b1041f30d87d390e1c@kernel.org>
In-Reply-To: <20260730090307.24d3e4b1041f30d87d390e1c@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR04MB6192:EE_|SEZPR04MB7734:EE_
x-ms-office365-filtering-correlation-id: eaf7095f-6266-4211-61b1-08deee30b9ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|38070700021|6133799003|56012099006|11063799006|10067099003|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 tq+tG+YquVv/QD580E7rgroQuMnxg7d5qJmaCHZzXBiu9D/Jwdh3SlReAwkgCz40WNjkrqCLp/FCl+jadOs3XlSNNRrsnheAcmKnuXmx71AgXEvyTIjFXs1KXkmYRgIpXwNbK2NLWg0pRqk29vkrQNfPvJgS//GBfS4XsTU/PD4U9/rFf1gwD90c+FQZr/Rzlwx2uX+qhsxpL8gdZuX84r3+eVCkzFm/JTM6NYRKp6e/2GknL4JogL/q92AIDoyCdpVsspyRu/yDQLK7o0PYwpBJepMZ1OdLVo6CEi9Yjvv0KIaUUd353pG2Z/nHGiTML5UtP5Pu0hrx31g7SFLTcdJhSdfsyuaIHCehSbM0aS4GfB9jGCjQKFI44wXbVdoSoW/D6QmfNuGdebuJ+ht1sgag9LHImvxW0Iw1sT59HImZIGJRBINHfrZli3L1a5e8Ddn7QO/mhcK+xp+YAPb4xZUA26+Vc5i4K1fGe9X0b5aZYT7fSUEkPk05QaHZo4mqx5o5kX/JMSHkxRZUrH+5gOHFm1WSeagLf0dlQQHRAm/r8pwBK7kFL1r7dd8DPT6GLQkznV0zGv0gS7SEKK+qbfA5EjE6w57ltonYu/x2iVRi7KWqmSgzeg0xLYxz8TVJCpj4SpsGiNcdF6szShvOE4RVXh3vXnB/ivzpkD15NVpYdrviNsKYCLP7CkEeZlWq2Kef6HxqBateo8KHbar3Ug==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR04MB6192.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(38070700021)(6133799003)(56012099006)(11063799006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UTd1bWIyN2hxMkFzSUM4eVViQllYYlRaWndoVWY1ZnVVNTIxT3UydWxpSzE3?=
 =?utf-8?B?MFUzcTdZaGdkK3VTdmtwYmhwM3k2TTJja3BnNSs3ZTd6b1VRakVPa203NlFp?=
 =?utf-8?B?Z0hKL1duSGM3M3NOL01ZRzdiUjg4UW9oM0JBMkZkSFhLUDVIU3M4TjhCVVNo?=
 =?utf-8?B?d01GZDQ0a0ZYanVsdkJuMWprZStPaDBnMzdabDIyVmNwNE93ZEdnb0t1Njll?=
 =?utf-8?B?RWhXazMvVEhCQUg5SzZRR0k1aGd5NFBWcVBza2NVVDJ4M3VsWVl2VnZCWi8v?=
 =?utf-8?B?dXNwajV6dm5Vc25rZjdqK3RwYkhGcVBuOWVIU1VYaG5HREZDVExlRi9Ka1Rz?=
 =?utf-8?B?dkJPb2dxeXFZOGtzbVhybEhuZ3pjOU9qR0Y1d2FWcXB3U1YxcVdyNjN1cytI?=
 =?utf-8?B?dFZUTnQ3WXg1eWpJcFB3c1VlUVdIOE1Rc3dDQ3l4YUQ0aGNQN2M2dkJENy9L?=
 =?utf-8?B?VGFRYm1MRXgrbEk2OEhkQTRYYTh4UTZOWWczMTYxME12b3Y1KzA3bnMra2Rx?=
 =?utf-8?B?YW52QkpMN0hPS1hHeWEyaEhjR0NhOWR0SjZ0TjdtQnd5Q3ZpcDMyUHNaM0Ra?=
 =?utf-8?B?Qk8zSyt6b2xuR293cTN2QTFMTnpoL3Nrbll3YmRNVm9YZVZuYmp2MTBMSFRE?=
 =?utf-8?B?OHBDY2syc3FLcWFUOGJQajJ5cHZkajVoZ3U0OW55UXMvSkZrRjVDakwrUkZw?=
 =?utf-8?B?WktEODE4b0Q3NmRnVlZCYU5QL0tPQWFpd3NRQjdsVHdLSHl4QW1KRkdydHBp?=
 =?utf-8?B?dk5HdTltTVd6K04zR3FCWTRDelp4cnJoY3huLzRMSG5YOElFaDc0QzNkb3FS?=
 =?utf-8?B?RGIyeC9iZUdGd0pqU3BiRWt2b01CdXhUSTgxWW9VaDk4bHlPVEU5eW9hUTBW?=
 =?utf-8?B?MkM3bHVhaWxLNnFQeDlheHJML3Rud0RvdkUrSlJOZXk1ZU9USWdUUkJ2R0pS?=
 =?utf-8?B?YUN5RWdwemxSUXc1MUJXb2ExWTRoR1lINDFWa0YxSXc4RGFyTVJaMEd2c1dD?=
 =?utf-8?B?b3VOZEVBeEpnY29Fbmc0Y1hWV3hiaHgyWXlFVDNDWlZnSERxemVtcTVrQzlh?=
 =?utf-8?B?dDFtVjUzZ0d1cTdWb1VXSFUzeGsxSFhOT1E5RUE3SHJ6dURWQjlwcFdYZHp2?=
 =?utf-8?B?U1JncFFlY1RxSTNqcm45dm96dUlLOWpQajhXbFZMM0I1bS93dFh2eWJ0QnJM?=
 =?utf-8?B?V2RPSU1hSEoxQzUreU5oWXdPRnVQUE9jRGFKOWVSTFpzWXluUkU1elVTck5i?=
 =?utf-8?B?TzdpejRWOFBRVVhqVGJsanlsSkw1OFZjeGY3MnFiVUl1TG5rNXpNODFXSTlN?=
 =?utf-8?B?TkRJdHFqOW9jakxWQ3h3SEkvQldmMVR1amFzTzJ6bGNyMTRUZVlXd2Qyd2gr?=
 =?utf-8?B?d1RCbFVvVDhWbVQ4UW95b1ZJK3ZjcXNaZDhuZUhybzZzMDVpbXZRSjYxang4?=
 =?utf-8?B?L1NsMWY2S3dCQjdUMFBvMWl0TVpHSGNhTXFPRUQxaXNIQmxnVTFIYkI3MXZk?=
 =?utf-8?B?djgwWUlLV3RUNzhRNjIwVEo2TDJIc1VzTWticFFmcE5Lb3ZwL3VUdXIrc0NP?=
 =?utf-8?B?NGl3VjVURG9ad1Z3YUphckVkUSt1NU9kTHFXT1JkMHpabnExV1g3Qjl4Mkgz?=
 =?utf-8?B?OHlxQm9VdWpabTJyT1ovYWNTcHFFbGpUSVRDOVUwaDdGOU5aYVg4OU0rQVBB?=
 =?utf-8?B?QTdWa1VKWGk4bEZqQXRGWWo1cmZocytRZk5RanQwWjhyVEVOWlVCSm9Dd1By?=
 =?utf-8?B?RmRTSUY4OXArejEybW96Y3dJL3Nnc3k2bXE0dEdOZ1RKenlwaW1Ncm50U2ll?=
 =?utf-8?B?endsNTlmL0NZdUFGa0c5Z21FWVgzZllOcEZBY0R1cElyeGlPVU5DNkk0LzQw?=
 =?utf-8?B?UFNhNUFpQXQ5TWdKbThjUkFjTGMzVjdDUXJFOHpQRks1U204cGIyQUV1UnRl?=
 =?utf-8?B?ajU3aHFRT3kyK3hwUDNRTDBMU2dZa2ZKNUxWaHZubHBpNzFqYnJpMGN6L1RK?=
 =?utf-8?B?L01wZHUrYlhTOTQwQWtBYWJ1VkZycjQybVlzMzhyc0p6RVZRTHdWU3NpR2Nx?=
 =?utf-8?B?RThSQmsyOCs3Zi9nRmRFSzZyam9wY3FEcUdBL05XS2k4UVdZWFVaV3R0bkxG?=
 =?utf-8?B?bnFkdWE1VU5ueGtEbjJnZHlCVS9TdDFYYm8ySFBVQ01YQTlKSlZHZXNSbFhU?=
 =?utf-8?B?dnZ4Z1lYeC9DdHJmNEpOejJKc3JRSkJYc2crT2ZxbktFaDJUejRkRzhWeC85?=
 =?utf-8?B?RjdsN21YeXphaFQ1TE5oalh2NzZIVEg4VnRSV2tiZ20yRlczTmlrUEl4WXNH?=
 =?utf-8?B?RzFuUUFuZEZPQnQ5R2t5M1BHVitseFBabkxiVTlKNXNSM2xZdW1BQTBDS0lI?=
 =?utf-8?Q?vCc9SW4WLrfu82tY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE9D86E1A3DB0E4A894CA31450BB4B2C@apcprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: transsion.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR04MB6192.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaf7095f-6266-4211-61b1-08deee30b9ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2026 11:50:17.7928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ep6Dydnd9PbhwSdOjLJmTXttDMP9x/a/EM2xKMbs76FnzEWuizmpBK2sHUjn/UyGgWiEqVK90PPfefvEDY0mkewillN9kqZ3WhEhu/PQLW4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB7734

T24gNy8zMC8yMDI2IDg6MDMgQU0sIE1hc2FtaSBIaXJhbWF0c3Ugd3JvdGU6DQo+IE9uIFdlZCwg
MjkgSnVsIDIwMjYgMTQ6MDg6NDYgLTA0MDANCj4gU3RldmVuIFJvc3RlZHQgPHN0ZXZlbkByb3N0
ZWR0Lm9yZz4gd3JvdGU6DQo+IA0KPj4NCj4+IE1hc2FtaSwNCj4+DQo+Pg0KPj4gT24gTW9uLCAy
NyBKdWwgMjAyNiAxMjoyNTo0OCArMDAwMA0KPj4gSG9uZ3lhbiBYaWEgPGhvbmd5YW4ueGlhQHRy
YW5zc2lvbi5jb20+IHdyb3RlOg0KPj4NCj4+PiBGcm9tOiBIb25neWFuIFhpYSA8aG9uZ3lhbi54
aWFAdHJhbnNzaW9uLmNvbT4NCj4+Pg0KPj4+IFN0YXRpYyBpbmxpbmUgc2hvdWxkIGJlIGVub3Vn
aCB0byBhY3R1YWxseSBpbmxpbmUgZnVuY3Rpb25zIGZvciBtb3N0DQo+Pj4gY29tcGlsZXJzLCBi
dXQgbXkgQ2xhbmctMTkgc29tZWhvdyB0aGlua3MgaXQncyBiZXR0ZXIgdG8gb3V0bGluZSB0aGVt
Lg0KPj4+IFRoZXNlIHRpbnkgaGVscGVycyB0aGVuIGxpdmUgaW4gbm9ybWFsIC50ZXh0IHNlY3Rp
b25zIGluc3RlYWQgb2YNCj4+PiAubm9pbnN0ciBzZWN0aW9ucywgdmlvbGF0aW5nIG5vaW5zdHIu
DQo+Pj4NCj4+PiBNYXJrIHRoZW0gX19hbHdheXNfaW5saW5lIHNvIHRoZSBjb21waWxlciBjYW4g
bmV2ZXIgb3V0bGluZSB0aGVtLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogSG9uZ3lhbiBYaWEg
PGhvbmd5YW4ueGlhQHRyYW5zc2lvbi5jb20+DQo+Pj4gLS0tDQo+Pj4gICBhcmNoL2FybTY0L2lu
Y2x1ZGUvYXNtL2Vzci5oICAgICAgIHwgMiArLQ0KPj4+ICAgYXJjaC9hcm02NC9pbmNsdWRlL2Fz
bS9wZXJjcHUuaCAgICB8IDIgKy0NCj4+PiAgIGFyY2gvYXJtNjQvaW5jbHVkZS9hc20vcHJlZW1w
dC5oICAgfCA0ICsrLS0NCj4+PiAgIGFyY2gvYXJtNjQvaW5jbHVkZS9hc20vcHRyYWNlLmggICAg
fCA0ICsrLS0NCj4+PiAgIGFyY2gvYXJtNjQva2VybmVsL2RlYnVnLW1vbml0b3JzLmMgfCAyICst
DQo+Pj4gICBpbmNsdWRlL2xpbnV4L2twcm9iZXMuaCAgICAgICAgICAgIHwgOCArKysrLS0tLQ0K
Pj4NCj4+IEFyZSB5b3UgT0sgd2l0aCB0aGlzIHBhdGNoPyBJZiBzbywgY2FuIHlvdSBhY2sgaXQ/
DQo+IA0KPiBZZWFoLCB0aGlzIHBhdGNoIGxvb2tzIGdvb2QgdG8gbWUuIEFueXdheSB0aGVzZSBh
cmUgZXhwZWN0ZWQgdG8gYmUNCj4gaW5saW5lZC4NCj4gDQo+IEFja2VkLWJ5OiBNYXNhbWkgSGly
YW1hdHN1IChHb29nbGUpIDxtaGlyYW1hdEBrZXJuZWwub3JnPg0KPiANCj4gRm9yIG90aGVyIHBh
dGNoZXMsIFNhc2hpa28gbm90ZWQgc29tZSBjb21tZW50cywgSSBuZWVkIHRvIGNoZWNrIGl0Lg0K
PiANCj4gVGhhbmsgeW91LA0KDQpSaWdodCwgSSBqdXN0IHJlYWxpemVkIHRoaXMgaXMgYSBiYWRs
eS1vcmRlcmVkIHNlcmllcy4gUGF0Y2ggOS85IHNob3VsZCANCmJlIG1lcmdlZCBmaXJzdCByZWdh
cmRsZXNzLCBvdGhlcndpc2Ugbm9pbnN0ciBpbiB0aGUgcmVzdCBvZiB0aGUgc2VyaWVzIA0Kc2lt
cGx5IHdvbid0IHdvcmsgYmVjYXVzZSBvZiB0aGVzZSBvdXRsaW5lZCBmdW5jdGlvbnMuDQoNCj4g
Wy4uLl0NCg==
