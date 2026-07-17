Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023127.outbound.protection.outlook.com [52.101.127.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB773ED5B9;
	Fri, 17 Jul 2026 11:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784287899; cv=fail; b=JJtiPQXTgzAJuW2hTr7KvO9noaw1jS+mdNrSJvnHOIS6Tcx0+m51Lj0HTqPTlGyHOhX0ER8VKTAhqx7f7hgVUPRgHI2jgaaZD+dbDhV+Sm0FMUb/FfcvoHKM0ZjH7ExGbZeWMNZTYICXD7cL9HyX26Hqrruv7NiWgJhskwpAekw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784287899; c=relaxed/simple;
	bh=rDhUEujbFy2aFbzpxVqyNfqvTKyX6GALvWRAZguRLmE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gpv+vKHiGYFXEz2GXnH5Tr1dKn65fsuJtSgbVUuTF5DwiTA/aO+/cfAFfTNyFeFhn62uMjfrwgEepOJZE5A2x+HkgSE9pbB4BPrf5N74FzU5LYiZuJs1DOm9fFbTPlo9UIunOwZOeVG7wd7fnON+atLPXr2HLVtYrRPNVGCWHKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com; spf=pass smtp.mailfrom=transsion.com; dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b=VQLHfIuO; arc=fail smtp.client-ip=52.101.127.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=transsion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b="VQLHfIuO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HrU7RuVkBUqHwKWXS+2sHypq9WXrobefSxej+cHvU/Anuc8kB9nxCVtHfrqTMy+q3OnmvZKjcJXATmkqmp/2HAHawavUxjh7tiUAa6+IohMDKVdwM8Tx1N+2+VkUicA5DIgAfCiVIbVgU8hushajwPvhyKGzgoXQVWExbDINbiZMrvFes4WqVa+nmkzbmXXiT9gphF8P4KEZv1iulwmYzYdwX/tqzoCC/blNFt2qKygTofP1q/xhzVf6eyJ5kdgRHmXgielOSaZva4zzuLatGHNP1DskakWigUfvtB9C0bT2rDTnAVmTI0eWNOOw9FGwWJ9Sx+o+md/TOtYONahtxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rDhUEujbFy2aFbzpxVqyNfqvTKyX6GALvWRAZguRLmE=;
 b=JpC6GwS52yMs3fKeYGR/l/ch7TLLJaUtU2JKPpkBGE/IsGHivQF6ZEBYilA2HvGNj/zNzb8ARU+y+ckUqTtAHa6IBqusNDQZow+H2dcSMBdVnINRSIKytdpX6fNiHE2JUvRnOd34o6iTn3dIMM/+TR7zCLRHLv5xjTH7vb4ZTBrBWD9Bxn4LsfY/Xyo7CT0YIp7pIMpALw/9jt4dJAvv1BzqWscozLkxSTtoWKzJG5dSaBCGM3/U6H8Q3ltGH2z+VFCafOnZ0Ju08Pyyb/AiTjmjoCCqncxDpe/USqWf1CCSan1FNcciay/zpws67n0Ataku7SOcqkt7mxlpwaNe1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDhUEujbFy2aFbzpxVqyNfqvTKyX6GALvWRAZguRLmE=;
 b=VQLHfIuOHZsiFyL1KyzR5F/VOloCMZmS0/5GRjRCGOBnWSGcxqzEfP0ThncXPeZBCymtlSiU3cRn/CmWrMCxn+6kk+PR4p8yCyrEDpV53l0zLAixvnP2VjwQKB1BWTAzMYdCyPqJ73VmXUywhVvT+S/Ea2qQCjd2/j/T7bsSYmo=
Received: from KL1PR0401MB6196.apcprd04.prod.outlook.com
 (2603:1096:820:c7::13) by SE3PR04MB8819.apcprd04.prod.outlook.com
 (2603:1096:101:2e5::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.4; Fri, 17 Jul
 2026 11:31:32 +0000
Received: from KL1PR0401MB6196.apcprd04.prod.outlook.com
 ([fe80::f2ee:1e28:9022:99f3]) by KL1PR0401MB6196.apcprd04.prod.outlook.com
 ([fe80::f2ee:1e28:9022:99f3%3]) with mapi id 15.21.0245.003; Fri, 17 Jul 2026
 11:31:31 +0000
From: Hongyan Xia <hongyan.xia@transsion.com>
To: Will Deacon <will@kernel.org>
CC: Pu Hu <hupu@transsion.com>, "mhiramat@kernel.org" <mhiramat@kernel.org>,
	"ada.coupriediaz@arm.com" <ada.coupriediaz@arm.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "davem@davemloft.net"
	<davem@davemloft.net>, Jiazi Li <jiazi.li@transsion.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>, "naveen@kernel.org"
	<naveen@kernel.org>, "yang@os.amperecomputing.com"
	<yang@os.amperecomputing.com>
Subject: Re: [RFC v3 2/2] arm64: kprobes: Allow reentering kprobes while
 single-stepping
Thread-Topic: [RFC v3 2/2] arm64: kprobes: Allow reentering kprobes while
 single-stepping
Thread-Index:
 AQHdEDXxWg6e3HuDfkaTSvkiR6Me8rZwLF+AgAAU4ACAAAuXgIAAsBUAgACZxoCAAAhcAA==
Date: Fri, 17 Jul 2026 11:31:31 +0000
Message-ID: <be182a18-4cea-445d-a319-1ed3a6c17598@transsion.com>
References: <20260710063242.228714-1-hupu@transsion.com>
 <20260710063242.228714-3-hupu@transsion.com>
 <aljbf_RmOd9U2KDT@willie-the-truck>
 <0f049d38-b7f6-47f0-a410-95ad2aee7fd4@transsion.com>
 <alj2uxE1M8mcMBhA@willie-the-truck>
 <e0e800f5-a6f8-48ae-b55c-5c3d928bf234@transsion.com>
 <aloLb0j8sg0usmAF@willie-the-truck>
In-Reply-To: <aloLb0j8sg0usmAF@willie-the-truck>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0401MB6196:EE_|SE3PR04MB8819:EE_
x-ms-office365-filtering-correlation-id: ed67d230-4930-46d6-f553-08dee3f6f33b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|10067099003|11063799006|56012099006|38070700021|3023799007|4143699003|6133799003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 NASP71xlVQ3lXWXX+Tibl24nbRp+MuD9sbeTPCaSznOfoW3b4Umuh0KwFdrAo1oXMySwuYEc2KkF+JXYr7ry+1FbvAQlbrL+5Lte2ELQSSy6LTHDNd8i6uBtY0qLaJTmILcAiGj/rWArqs49neYMMwQbxly8CJlHrpgntnVVPTOkjdWnCpvLaf3IO012oLjQPagBzk4FLe8rSgmrD54arGUIXJPLugTI7ZTcnZ0YwpvW1K3Qog8acnxGiASqlRtvWWigeiYErLI2ODZIFaUWu6KSv3TG5M5ht0JhacrC/YM1UAI92N/FanQwVoNu3vFLIPxXrwojwl+vSdoBogKMnWG9qedzGQd7j3OHvn+qWcWnWQrPf9I6HYz7feVm0zX4ciogi/OEx3dAcSm91yXCYcif7AHKniW2nseP+6BnPh+V31EQDSm4R+OnKvT63HHHiGcbNZUUjmXWKeEBY1OJYWCyGAXW6LhTD3IGubdSzDTOAcqtpOV4LIZ0aIhY4B5Ioa+907LNgwzpnaak7LmywxcggmFxiKARdIi++mu28MtCm1qcXSEKWmcNdRCw1eGrsHJU1tjviOZuCCgnnXB2zH2JcOReu5fEDf1GlzFzYO1/42X0W7q4UHQKXkqp2kHYn+Na5pl22tXi8XNdATUiyxPGrkVq5XDwVR78qdBe3GA+K2nhUDsH5bS2nI8HEM2wsAa5t43luEaKXXyGNqyOog==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0401MB6196.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(10067099003)(11063799006)(56012099006)(38070700021)(3023799007)(4143699003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YmY4Wm1mU3BvT3JzdVVQcjZYci80QzNDVFlmWFA3T2dkWHJ6Q2R1MFhrWHRW?=
 =?utf-8?B?WTFvbjFCdUUvZk14UGZvQjBsNUF1NlJTUnpjZWJKdXZ1aURsaHRJMk1HeDF3?=
 =?utf-8?B?elV0ODVxYTIyNUNmZkdQUlpNWFlLOVZTZ2VSUEhBaVd0Y3duVU1NdVZqQUwz?=
 =?utf-8?B?MlVkVHBtNVJsbkcwNjZLSnVtaEZOWC9qKytzUFFxTXI3Yk1Lb0lEblBPN0ZY?=
 =?utf-8?B?eFJmNmlUVDM4V0VZdkNDc2tqR2VWYWFNZXhFUEliUjBUVHJXdXlHUXoyNTJE?=
 =?utf-8?B?ZDFrcHlnbXRad0dYdEFURExkb3lGL0pDSHdITWtBUlBvd3QzV2lJclNSUzh6?=
 =?utf-8?B?cXo4LzBwZERxODUvQ3g3MjI1dERURjZqV0xubitIaFFFU2pySXBEVmtFazNK?=
 =?utf-8?B?V2F5aWNVdzl3bVcybTlmaUFsSHQxbjY0YTd3aDZjK216QmVBZmZFRmdGRkNI?=
 =?utf-8?B?R0xDRlVFS28yR2d4Z2FRRldVN3JIcHJvamhjeC8wb2NSVU83eFZqd1k4TlZE?=
 =?utf-8?B?dy9TMUt6UHFZSXZOYzVpTi8vOW1ud0NST04rZUgxLzcrdGcyK096a0JwM3A4?=
 =?utf-8?B?LzM5ejgvcm5Rb2RGakx6cWVnTEpXV2tBK0tnSXByUENCMDFNUUozbmJ3Y093?=
 =?utf-8?B?OUIrV005ZEt3WUVOQjZhaUl2YTdKRWh6N3lMamFSWXBPclZaY24yMGhqNThF?=
 =?utf-8?B?ZktrbW1YcS9HK3MxRW9rdXBkeHNsTGhEVDYvZmRxSjJQQW45ZnNpa3V4cDFY?=
 =?utf-8?B?MEpENjcyRjN3WmVZSnZMaXRPWjUwTzMyVit4MGxLZ2p5SE41SXRRdWpmVlVx?=
 =?utf-8?B?eFprOG1WUXNzaU9YcDUyVXl4cXdpV2NidjZ5WHpBdXhiUUZOMjA1aExJOXdO?=
 =?utf-8?B?d1N4SFVyeWNIbGZoakZuYS9WVDFZMlBwU0F0TzR2aCs0Vnc2bS94aWR2Q3d3?=
 =?utf-8?B?THlSVWU2SFZHcnY1TjNOTVZwNjBoMDRqTUEvbXBtS00xRVFnZGdtWmd4MkhV?=
 =?utf-8?B?ekpXd2VtaUpTOU83R0E2UkIvaldaaVR6T3RBUysvUUtqbHRObFdlQUJ3eUN3?=
 =?utf-8?B?Y1Y4Yk8yY3VDN2kyTU9ZZnhCYUFRbityOWQ2N2tKQ2tuN09aUGlDL1draFMw?=
 =?utf-8?B?NzVEN1ZYbW0vRGx6KzUxNmJIc0x0aUFKWlFZRlFiY1dQd09GcGtud3JGVlls?=
 =?utf-8?B?UWZINmtjN28xM1ZTZzNOcTBDQ1ErZVBFclkycDlkTGNqMEdJOVdaUEFJRUVX?=
 =?utf-8?B?S3hEam85cEZCUG5FYk5Dc1ZKaU11VXVoQWtLaHE5aW9FeTJWTGVlbmNCQlRO?=
 =?utf-8?B?UHptRi9QU0NwcXpPMEx0LzluZC8xYnZIaS9DcnV2cVZ5YW52cTlLUzNLeUtx?=
 =?utf-8?B?OElGcWgrRlVsR1dtWk9kbTllcmdPcEtYZDZUdGlxM2xGQlN0WTg5YVFBWFUw?=
 =?utf-8?B?SG9nOGpWQUMzK1ZOV2ZDUlVrOXN0VERNQitMaUNyQ3BWY3RjMDVXTExOdEVY?=
 =?utf-8?B?NlU5eFk4cldQbm4rNzNEQXkwSnl4QTVzSDNBNUFhdUlwWm9Ob1JSUW16a2pH?=
 =?utf-8?B?K0tYS21Qb2R5ditTNjdsQi94R2FLNkNPTWdHa2UvTWVSTVAvSXY2NC84cmFY?=
 =?utf-8?B?cUpLVlh0d3VPcGlRRjQ0RDlSa1dUN0s0bWlRSzJTSjVjbUYrVDNLMDlUNjFE?=
 =?utf-8?B?VXVrTm9XN0NobU9iVHJwTFVRVXRIbXFsRkVicmJLdUEzSTd3aGYzUEpSVjFn?=
 =?utf-8?B?VGZFQ2RqUDZMOU1vNHUxdVN1Wml6bUYvNkFMenJDVmQyV3RDYVFLWXZyUGdm?=
 =?utf-8?B?SGE4MFFUS1o5aG1URmRKWGlzdklEcU1EYUNzRjVJeFRJY1Z0MEh5ZS9XbzJx?=
 =?utf-8?B?SktxM29oN3FmSDk5Z3J3eEV4VjNyVlJRd1ArdjlIcUVTREh4UEIremk2TEdn?=
 =?utf-8?B?ZlB5bXVBNVZVNzR5Y3lMcUV6M0NhSytSbXNOYXMwRmltL20vdDg4KzhRYmhQ?=
 =?utf-8?B?UURTSzlXTXJrOE5rUmJtUndwS1VWZG9mZzBpMmtSYVoyWkVsWU4xRTQ2eTlD?=
 =?utf-8?B?Y29HczZBbjZYdlJueCtJdzVXbllDenhjc2tWbDZwQzRUQnJWWDRNSGt6SzEx?=
 =?utf-8?B?cCs4NDZLQXhPVk8rcVR1VVQ4MDRaMUk2WUJNRC9MSXdwa0JlUmwvTndnb2Ex?=
 =?utf-8?B?eVhJM2ZzekRKWWhlTVlBN3NEREl6RFNxKy8wWnZKRTZPTVpPQldkNTRVY1R0?=
 =?utf-8?B?Rm1WbzlqaHRDZ0hBVGMwTzZOOFlTNFFSSHF6WnU3cHNvUlM2dHhLL0s0Mk1E?=
 =?utf-8?B?c2EvUkVkWkE3ZVdaSWIrL0RETjJjMlkzOGt0Y3U4d0M2T2htQ2dnei9LWHds?=
 =?utf-8?Q?f9p80iwSB2F0C8EQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2526D916F4B5F84D8706BE31F01E4A89@apcprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: transsion.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0401MB6196.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed67d230-4930-46d6-f553-08dee3f6f33b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 11:31:31.4919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ArOK6afTpvY1saKNiW26qG+v2av26bKHr+9YxyYQ/e257gojVYGc/MFIStr1Nq/pkscAKWC06OQU+rNlBSfBwqi+SwRZZZZLqVd0UUp+0rg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR04MB8819

T24gNy8xNy8yMDI2IDc6MDEgUE0sIFdpbGwgRGVhY29uIHdyb3RlOg0KPiBPbiBGcmksIEp1bCAx
NywgMjAyNiBhdCAwMTo1MToxMkFNICswMDAwLCBIb25neWFuIFhpYSB3cm90ZToNCj4+IE9uIDcv
MTYvMjAyNiAxMToyMCBQTSwgV2lsbCBEZWFjb24gd3JvdGU6DQo+Pj4gT24gVGh1LCBKdWwgMTYs
IDIwMjYgYXQgMDI6Mzg6NThQTSArMDAwMCwgUHUgSHUgd3JvdGU6DQo+Pj4+IE9uIDcvMTYvMjAy
NiA5OjI0IFBNLCBXaWxsIERlYWNvbiB3cm90ZToNCj4+Pj4+IE9uIEZyaSwgSnVsIDEwLCAyMDI2
IGF0IDA2OjMyOjU1QU0gKzAwMDAsIFB1IEh1IHdyb3RlOg0KPj4+Pj4+IEZyb206IFB1IEh1IDxo
dXB1QHRyYW5zc2lvbi5jb20+DQo+Pj4+Pj4NCj4+Pj4+PiBBIGtwcm9iZSBjYW4gYmUgaGl0IHdo
aWxlIGFub3RoZXIga3Byb2JlIGlzIGluIEtQUk9CRV9ISVRfU1Mgc3RhdGUuIFRoaXMNCj4+Pj4+
PiBjYW4gaGFwcGVuIHdoZW4gdHJhY2luZyBvciBwZXJmIGNvZGUgcnVucyBmcm9tIHRoZSBkZWJ1
ZyBleGNlcHRpb24gcGF0aA0KPj4+Pj4+IHdoaWxlIHRoZSBmaXJzdCBrcHJvYmUgaXMgcHJlcGFy
aW5nIG9yIGV4ZWN1dGluZyBpdHMgb3V0LW9mLWxpbmUNCj4+Pj4+PiBzaW5nbGUtc3RlcCBpbnN0
cnVjdGlvbi4NCj4+Pj4+DQo+Pj4+PiBJIGRvbid0IHVuZGVyc3RhbmQgdGhpcyBwYXJ0LiBUaGUg
c2luZ2xlLXN0ZXAgcnVucyB3aXRoIGRlYnVnIGV4Y2VwdGlvbnMNCj4+Pj4+IGRpc2FibGVkIChr
cHJvYmVzX3NhdmVfbG9jYWxfaXJxZmxhZygpIHNldHMgUFNUQVRFLkQpIHNvIGhvdyBkbyB3ZSBl
bmQNCj4+Pj4+IHVwIHRha2luZyBvbmU/DQo+Pj4+DQo+Pj4+IFlvdSBhcmUgcmlnaHQgdGhhdCB0
aGUgc2luZ2xlLXN0ZXAgcnVucyB3aXRoIGRlYnVnIGV4Y2VwdGlvbnMgZGlzYWJsZWQuDQo+Pj4+
IEhvd2V2ZXIsIHRoZSBjYXNlIEkgd2FzIHJlZmVycmluZyB0byBpcyBub3QgYSBoYXJkd2FyZSBi
cmVha3BvaW50IG9yIGENCj4+Pj4gc29mdHdhcmUtc3RlcCBleGNlcHRpb24sIGJ1dCBhbm90aGVy
IEJyZWFrcG9pbnQgSW5zdHJ1Y3Rpb24gZXhjZXB0aW9uDQo+Pj4+IGdlbmVyYXRlZCBieSBleGVj
dXRpbmcgYSBCUksgaW5zdHJ1Y3Rpb24uIEEgQlJLIGluc3RydWN0aW9uIGV4Y2VwdGlvbiBpcw0K
Pj4+PiBub3QgbWFza2VkIGJ5IFBTVEFURS5ELCBzbyBpdCBjYW4gc3RpbGwgYmUgdGFrZW4gd2hp
bGUgaGFuZGxpbmcgYSBrcHJvYmUuDQo+Pj4+DQo+Pj4+IEFzIGZhciBhcyBJIHVuZGVyc3RhbmQg
dGhlIGFyY2hpdGVjdHVyZSwgdGhlcmUgYXJlIHR3byBkaWZmZXJlbnQgY2FzZXMgaGVyZToNCj4+
Pj4NCj4+Pj4gICAgICAtIEJyZWFrcG9pbnQgSW5zdHJ1Y3Rpb24gZXhjZXB0aW9ucywgZ2VuZXJh
dGVkIGJ5IGV4ZWN1dGluZyBhIEJSSw0KPj4+PiAgICAgICAgaW5zdHJ1Y3Rpb24uDQo+Pj4+ICAg
ICAgLSBCcmVha3BvaW50IGV4Y2VwdGlvbnMsIGdlbmVyYXRlZCBieSB0aGUgZGVidWcgbG9naWMs
IGZvciBleGFtcGxlIGJ5DQo+Pj4+ICAgICAgICBwcm9ncmFtbWVkIGJyZWFrcG9pbnQgcmVnaXN0
ZXJzLg0KPj4+Pg0KPj4+PiBQU1RBVEUuRCBtYXNrcyBkZWJ1ZyBleGNlcHRpb25zIHN1Y2ggYXMg
aGFyZHdhcmUgYnJlYWtwb2ludHMsDQo+Pj4+IHdhdGNocG9pbnRzIGFuZCBzb2Z0d2FyZS1zdGVw
IGV4Y2VwdGlvbnMsIGJ1dCBpdCBkb2VzIG5vdCBtYXNrDQo+Pj4+IEJyZWFrcG9pbnQgSW5zdHJ1
Y3Rpb24gZXhjZXB0aW9ucyBnZW5lcmF0ZWQgYnkgQlJLLiBUaGlzIGFsc28gc2VlbXMNCj4+Pj4g
Y29uc2lzdGVudCB3aXRoIHRoZSBwc2V1ZG9jb2RlIGZvciBCUkssDQo+Pj4+IEFyY2g2NC5Tb2Z0
d2FyZUJyZWFrcG9pbnQoaW1tMTYpLCB3aGljaCBkb2VzIG5vdCBhcHBlYXIgdG8gY2hlY2sNCj4+
Pj4gUFNUQVRFLkQgYmVmb3JlIHRha2luZyB0aGUgZXhjZXB0aW9uLg0KPj4+Pg0KPj4+PiBUaGVy
ZWZvcmUsIGV2ZW4gaWYga3Byb2Jlc19zYXZlX2xvY2FsX2lycWZsYWcoKSBzZXRzIFBTVEFURS5E
IHdoaWxlDQo+Pj4+IGhhbmRsaW5nIHRoZSBmaXJzdCBrcHJvYmUsIGlmIHRoZSBjb2RlIGV4ZWN1
dGVkIGZyb20gdGhhdCBwYXRoIHJlYWNoZXMNCj4+Pj4gYW5vdGhlciBpbnN0cnVjdGlvbiBwYXRj
aGVkIHdpdGggQlJLLCBpdCBjYW4gc3RpbGwgdGFrZSBhIEJyZWFrcG9pbnQNCj4+Pj4gSW5zdHJ1
Y3Rpb24gZXhjZXB0aW9uLiBJbiBvdGhlciB3b3JkcywgdGhlIG5lc3RlZCBjYXNlIEkgbWVudGlv
bmVkIGlzDQo+Pj4+IGFub3RoZXIga3Byb2JlIEJSSyBiZWluZyBoaXQsIG5vdCBhIGhhcmR3YXJl
IGRlYnVnIGV4Y2VwdGlvbiBvciBhDQo+Pj4+IHNvZnR3YXJlLXN0ZXAgZXhjZXB0aW9uLg0KPj4+
DQo+Pj4gWWVzLCB0aGF0J3MgY29ycmVjdCwgYnV0IGlmIHdlJ3JlIGRvaW5nIHRoZSBvdXQtb2Yt
bGluZSBzdGVwLCBob3cgZG8gd2UNCj4+PiBlbmQgdXAgZXhlY3V0aW5nIGEgQlJLPyBPciBhcmUg
eW91IHNheWluZyB0aGF0IGl0J3MgdGhlIGtwcm9iZXMNCj4+PiBCUks2NF9PUENPREVfS1BST0JF
U19TUyBpbnN0cnVjdGlvbiB0aGF0IHdlIHVzZSB0byBpbXBsZW1lbnQgdGhlDQo+Pj4gc2luZ2xl
LXN0ZXAgdGhhdCBpcyB0aGUgcHJvYmxlbT8gSWYgc28sIGhvdyBkb2VzIHRha2luZyB0aGF0IGV4
Y2VwdGlvbg0KPj4+IHJlc3VsdCBpbiB1cyBleGVjdXRpbmcgdHJhY2luZyBvciBwZXJmIGNvZGU/
DQo+Pj4NCj4+PiBTb3JyeSBmb3IgYWxsIHRoZSBxdWVzdGlvbnMsIEkganVzdCBoYXZlbid0IHVu
ZGVyc3Rvb2Qgd2hhdCdzIGdvaW5nIG9uDQo+Pj4gaGVyZSBmcm9tIHRoZSBjb21taXQgbWVzc2Fn
ZS4NCj4+DQo+PiBUaGUga2V5IGlzIHRoYXQsIHdoZW4geW91IHVzZSAncGVyZiAtLWNhbGwtZ3Jh
cGggZHdhcmYnIHRvIHNhbXBsZQ0KPj4gY2VydGFpbiBldmVudHMsIGtlcm5lbCBwZXJmIGNvZGUg
d2lsbCBzYW1wbGUgYSBwaWVjZSBvZiB1c2VyIHN0YWNrIGVhY2gNCj4+IHRpbWUgdGhvc2UgZXZl
bnRzIGFyZSBoaXQsIGFuZCBjb3B5X3RvL2Zyb21fdXNlcigpIHRyaWdnZXJzIHBhZ2UgZmF1bHRz
Lg0KPj4gU2F5IHlvdSBhcmUgcHJvZmlsaW5nIHByZWVtcHRfZW5hYmxlIGV2ZW50czoNCj4+DQo+
PiAxc3QgQlJLIC0+IHByZWVtcHRfZGlzYWJsZSgpIC0+IGRlYnVnX2V4Y2VwdGlvbigpIC0+IHNl
dCBTUyBzdGF0ZSAtPg0KPj4gcHJlZW1wdF9lbmFibGUoKSAtPiB0cmlnZ2VycyBwZXJmIC0+IHBl
cmZfc2FtcGxlKCkgLT4gc2FtcGxlIHVzZXIgc3RhY2sNCj4+IHVzaW5nIGNvcHlfdG8vZnJvbV91
c2VyKCkgLT4gcGFnZSBmYXVsdCBvciAybmQgQlJLIG9uIHRoZSBwYWdlIGZhdWx0IHBhdGguDQo+
Pg0KPj4gVGhlIGtleSBpcyBwZXJmIHNhbXBsaW5nIHRoZSB1c2VyIHN0YWNrIHdoaWxlIHRoZSAx
c3QgQlJLIGlzIHN0aWxsDQo+PiBydW5uaW5nLiBXaGVuIGEgcGFnZSBmYXVsdCBpcyBoaXQsIGEg
Y2FuIG9mIHdvcm1zIGlzIHJlbGVhc2VkLCBpbmNsdWRpbmcNCj4+IGEgcG9zc2libGUgMm5kIEJS
Sy4NCj4gDQo+IFRoYW5rcy4gU28gcGVyZiBpcyBydW4gc3luY2hyb25vdXNseSBmcm9tIHRoZSBk
ZWJ1ZyBleGNlcHRpb24gZW50cnkgcGF0aCwNCg0KWWVzLCBleGFjdGx5Lg0KDQo+IHJhdGhlciB0
aGFuIGJlY2F1c2Ugb2YgYSBzZWNvbmQgZXhjZXB0aW9uIHRha2luZyBwbGFjZS4gR290IGl0LiBC
dXQgdGhlbg0KPiBpdCBzb3VuZHMgbGlrZSB3ZSBzaG91bGQgcmVhbGx5IG1ha2UgdGhlIGRlYnVn
IGV4Y2VwdGlvbiBoYW5kbGluZyBwYXRoIChhdA0KPiBsZWFzdCwgdGhlIHBhcnQgdGhhdCBydW5z
IGZvciBoYW5kbGluZyB0aGUga3Byb2JlIHN0ZXApIG5vaW5zdHIgdG8gYXZvaWQNCj4gZ2V0dGlu
ZyBpbnRvIHRoaXMgc3RhdGUgdG8gYmVnaW4gd2l0aC4gSXMgdGhhdCBwcmFjdGljYWw/DQoNCk5v
dCBzdXJlIGFib3V0IG1ha2luZyB0aGUgd2hvbGUgcGF0aCBub2luc3RyIChATWFzYW1pIG1pZ2h0
IGhhdmUgYSANCmJldHRlciBvcGluaW9uIG9uIHRoaXMgdGhhbiBtZSkuIFBlcnNvbmFsbHkgSSBk
b24ndCBtaW5kIGVpdGhlciANCmRpc2FsbG93aW5nIGl0IG9yIG1ha2luZyBpdCBjb3JyZWN0Lg0K
DQpCdXQgaXQgbWlnaHQgYmUgYSBnb29kIGlkZWEgbm90IHRvIGRpdmVyZ2UgdG9vIG11Y2ggYmV0
d2VlbiBJU0FzLiBUaGlzIA0KcGF0Y2ggaXMgcHJldHR5IG11Y2ggbWlycm9yaW5nIHdoYXQgdGhl
IHg4NiBzaWRlIGhhbmRsZXMgdGhpcyBzaXR1YXRpb24uDQoNCj4gDQo+IFdpbGwNCg==
