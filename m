Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023090.outbound.protection.outlook.com [40.107.44.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D6825B2F4;
	Wed,  1 Jul 2026 13:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782914223; cv=fail; b=OKwmuMaJsYWeOklqMdhgFePSRavbgdcy4QNdKT93zVNAr1AJSXbSs3SmxJdkHAMyg4LWAyr/JHxUVxADWqTRqe3sx2KwJ86hkkTEuIjreeYTYVTu4Yv4QnvSSCLE1CWfmTD8b2Xsfls/4fjmAvi1R5RSI5m+7n6vDsns+PtcD/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782914223; c=relaxed/simple;
	bh=QPlz1j4lDp/U9RBeREXmlGm4xvDNQHrS1W3kbrrrs04=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lsssBo278Y9uaDG7QadAc+LJGhtWOhOBwf9llnn/cyvbhD+SRFkbS2F57bVawwAuODof5/0+0uTqTo5dwg00ulhPajUVatmye9E0oGfeAX1cmYz2mUMGw3MOmmBhRRqYSSR6p8/XfHTeTWoNDf8Mbrb2r4Or3lm0XDoAkmS6xMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com; spf=pass smtp.mailfrom=transsion.com; dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b=XFutFDuy; arc=fail smtp.client-ip=40.107.44.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=transsion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b="XFutFDuy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xhqXAdaPnnPoSuGf8itbITa/5eYr8jpLTzWkzET+QYIyrFBvJqmmhmp6wC3P5po0PJ/WQXAgEgCbpdd6aEL4yUZcPT2BnjNL6Iwwz3ApedvsT1Hp/nabdmfpz9etdKNVr+kPgRMPtL+kZG5RPUusrAhs1UM+X7EU6Scuc59b9nBcOy2iqr3Vf9SIRnbFwIbc1OzMOtqdUkZvF8P0f/MXqSmzapPt7ClvTsXkqn5bpky+xCHv/X585Zd9ctJNdBqRWmFD/EvZVaP42L6YZLzGpZCGQLZCK/Fgpjbp5Wb3063DMggJqw6n1DvmI9kBnTZd1XbxUK/2zMDgMXs1kgoYcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPlz1j4lDp/U9RBeREXmlGm4xvDNQHrS1W3kbrrrs04=;
 b=TK/bdFrmxTVqdx2HhJBbMJHwyBMBUOJmaxUhKy86IabIlHgqrRPIucjWXqXMNIqShs4bS5+G7WZUHuAP4sra5hZxHeLFu7a6ov7IO9DWn3GtUUNfu7rYttj//Riq5IEF63ImfavCR+8yHihqduNDJetfOXuhh/DWat7VhVsn6RivnoyM03R+aQFGP79SdmCguf0IR50fQUa0dlN4Gz1uFH0goTIOp3YOUDeES7Id9p9jGsL4PUlaH9T/z9r12I/UDQKC+uAvSJM0IvpcgGVe6T7OYoDhBO5lRbvuPzUcGgIa1zAltGBG/PxH+2NtumLosIaFmpFczmsV8IZoCTWTPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPlz1j4lDp/U9RBeREXmlGm4xvDNQHrS1W3kbrrrs04=;
 b=XFutFDuy76Bgo7pgNlFbmOUtNpv122P8/3LTitTWOf7H21aVzteDO9MPZbX+jp4JYakrStIZ6Wl0NU37tKTBtNjK/Nz8qsjmgxR5cCzrZcw3zjcuS/tkMceD5cNQ4b7lwaKEOuyt3wbhkP5eGwspg8DMeHEq/QqwrM4EYtAW8cM=
Received: from SI2PR04MB5648.apcprd04.prod.outlook.com (2603:1096:4:1a4::11)
 by TYZPR04MB7508.apcprd04.prod.outlook.com (2603:1096:405:40::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 13:56:58 +0000
Received: from SI2PR04MB5648.apcprd04.prod.outlook.com
 ([fe80::8ce1:b82b:3b19:f79d]) by SI2PR04MB5648.apcprd04.prod.outlook.com
 ([fe80::8ce1:b82b:3b19:f79d%5]) with mapi id 15.21.0159.018; Wed, 1 Jul 2026
 13:56:58 +0000
From: Pu Hu <hupu@transsion.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
CC: "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org"
	<will@kernel.org>, "naveen@kernel.org" <naveen@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "yang@os.amperecomputing.com"
	<yang@os.amperecomputing.com>, Hongyan Xia <hongyan.xia@transsion.com>, Jiazi
 Li <jiazi.li@transsion.com>, "ada.coupriediaz@arm.com"
	<ada.coupriediaz@arm.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>
Subject: Re: [RFC 0/2] arm64: kprobes: Fix single-step fault and reentry
 handling
Thread-Topic: [RFC 0/2] arm64: kprobes: Fix single-step fault and reentry
 handling
Thread-Index: AQHdCVM5llIetQ2+U0epMS9G7bPoC7ZYrJ+AgAADkAA=
Date: Wed, 1 Jul 2026 13:56:57 +0000
Message-ID: <ec11e9ca-ae7c-49c3-ae7b-47a70e9f86af@transsion.com>
References: <20260701121448.3926-1-hupu@transsion.com>
 <20260701224345.c3a215ece3660a0cbae67645@kernel.org>
In-Reply-To: <20260701224345.c3a215ece3660a0cbae67645@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR04MB5648:EE_|TYZPR04MB7508:EE_
x-ms-office365-filtering-correlation-id: 63c08f6a-a64d-4b13-0c9e-08ded7789dfa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|18002099003|22082099003|38070700021|6133799003|3023799007|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info:
 MVs8ubcG80QvusIdskNwVxXC8Us7gu0fJFcdBkSznw7mMhtnARwyEIARLEFdYPaD+5eJDV/+Ux1DYcPRwuXUymyVR+o0ZdIpSPN5jeRW74jaJfksykkI4Z1mu//8n4rNG/eZOfUpPaYa3Ysl/xzMlGid2kkQV3yH5O4As0+ixNkD+RhaziSSDhUUbmznrrDqDAzWS9fuBiIelvG3ZGzqCX1M40YwG4hffXydrUVotuRGTXqt7BPqDngCGu3HJaNCo6lnkbyaq2gjFTkZolOkoKkYGzBlmBEyjRjG31XkBqg91fcZxjc19BhekYAYQ600vfwhm8O00keQwgLVhm2nM/jl5QTjEVpSIEQpOr3SkEW7/h2FgMyzw2WsAALnbW57Ei0yavS4gms4jZ/XT6GGNIcGlM5vcWTt64g8ejulyCXrVMDQBBEpse/4vcVGrdOTeZO++KExZUOosI61pdYwVwZ15ZwFPnNr2ekLwJhgVFMR+/gmplGVbKyaQATRt2aQPd85DrAqJSxax51E+cv5AKRR3PMFdCwk/VB+6cOILQfX6rY9BAa5Q6tl7IhlvVooarJpjDdDqJ01gadqUZA3EcJhJCHcHXEZYwIPmC1RbEFMZn8XI5BCQLdXF1INw4uR27wFVcNjxKUVu+hRQva2Vo9RHkAulFTODgn8p16r86brnvknkDbQW5QKBsL4+v4juQkpQjteoHYq0MBLiJ6/63BL8OMYHuZOjHxAU71toWk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR04MB5648.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(18002099003)(22082099003)(38070700021)(6133799003)(3023799007)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VGx3Rlo1R2pFZm16dzZ3WkFyQUxCcFhLK00zNGsvZWRnaHNOTnBzVTZPSmhW?=
 =?utf-8?B?cUlYUUNlb0Zsak5zL09zMGZxV0JtR2ZvYnBIRWJhZWJHekplby9mNTc1a3N2?=
 =?utf-8?B?bHJwbWFxKzRJN3N4aGRPUlNWTHFaM3VqeFEreDhpQVVDK1pFWjVUSnV4VTE5?=
 =?utf-8?B?UExRdUZzVUZOSCt6N0hURUk2RGhzK0FzZG0wTlFwT251ZWtxZXQvUW54K0xh?=
 =?utf-8?B?WkJTdC9sY1JSVEFOSi8zQyt6RVo4R0ZEallRNFZWSmlVUzI1RWx3bWZtZXpD?=
 =?utf-8?B?dU5XSllCdXJtdThtSmN5TzZyMmtVaEVES2Z4Wjhid2k2WUx1aGxvb0JnaFJ5?=
 =?utf-8?B?dlNkcmt6T2hqOTAzT3dsUnY5TFdURFdnV2lzNmp4dHFib1BPWnJPeWg1QXRL?=
 =?utf-8?B?K2o4SlNIdERkMWRBVDBadjBYS0xyeGZaTm1VNGtRUVhLSjM4TDBQS3FkMWZ1?=
 =?utf-8?B?V24wVzl3MXo5MFpZNWRTc0xCOUU3UWJnMmM2WXB2WjNKQ2dwcXRqR0gyS0gy?=
 =?utf-8?B?QkZZNDJ6V1NVVXhUazRwWmtpcmY2b3A2YU10d2VwSnVQODc2M0tPYzZtVGVl?=
 =?utf-8?B?RTlsNkcxTUp6L0NPUGo2R0lrbXJwRE5Wc2J3UnJob1Y1cTl6RW83UmovQjFN?=
 =?utf-8?B?VDAwSEppZURhQncwZFJQaTkwZFZKck1vbVR0UDdnWTNqUDkvVVZNREVJSTEz?=
 =?utf-8?B?bEtqQUpJZ3E2T0V1WFkrR1dsRGgvT3pBR1ZTak5oT1FjY01aK3l1Q3VreFdD?=
 =?utf-8?B?bUVEYTZ1c2RSTXA4UGxpR0pUNnN6bWlERi9zRHVuM1dtZnoxSE54bDdacXJD?=
 =?utf-8?B?V2FaSnVHZkdNeWxVUm02YUtuS0tlcFF3M3hpWFlnV2JSV2U1dGdONTZ4OHRp?=
 =?utf-8?B?TTZ3c3ptcW1TSC9za1VmSG8ySEFFSEZ0UFM3N1N2UlBEdm1nZ283clVQWkc2?=
 =?utf-8?B?K3JsbVljTmVKMDd0SmY0Q1NEMjFMd1RBdG5nY3ZDRldxYUwyUjcvN1pZdDhP?=
 =?utf-8?B?Q3ZDalVoTXI2YjJoNkZpaXBpSzhXZjNvRFM0MU9MbU9BNHNLSnBWSGxVVWxB?=
 =?utf-8?B?akIzNFlnZm83eXd5b0htSVRyc04zQ1BGUWdVUExQUUdrRDM1ZjkzbkhJVUsy?=
 =?utf-8?B?c3o1cGY3YXgwLzIrQk9UNDNadnk2NExWU1ZqaFl5dFBhMzhRSEtkQ2NKRU5R?=
 =?utf-8?B?TERXZHpDdWU0RW5yYUhiTGl2bTdTa3lzZDhvUkg1YXVGZHFPMnVSV3hvUyth?=
 =?utf-8?B?N1FGdVl2Zmw0VmJRdmpvRGZEazBlamR0RmExRkFaTFFWTWRCVHEyYUJLM0V3?=
 =?utf-8?B?Y2JUUUIrRVBoNFhiRHRnMnJQaitPOG5IVklWd2NTNHF1OHdud09jNTlIZnFT?=
 =?utf-8?B?Tk0wZ3h1ZjVLam5LbnBpT3BTd2dqWEpwQVJPUklYbjE0eElLL1Y0dUZMRHpP?=
 =?utf-8?B?K3lKMDBjOTdYMjRQM2g3RjNqRVExRXJZbWoyUjhnaE5VcVRUTzdSMVhmMEps?=
 =?utf-8?B?VVBxV2k1Z2pXZWkrcGZaYmdTZzljZExDbDcvL1hEOFJ4cDNpdHN6Q3c4UTM0?=
 =?utf-8?B?Z3IrQXU0OHA0NFFvcmJBeDdnKzlrSVV6WFVYTlowdVpoTzgwbFFiQ1g3ejNM?=
 =?utf-8?B?SEdBVGQ1ZUVlUGw4ZnppZXlBZFpXbTNjMFV6R29sL1FBZTcvdlJieFBjUHpF?=
 =?utf-8?B?dXd2ZWdYQXFSdzVqeGZ1dCs0N090Y3ByNjFXdHlFcDNUUWQzdUxSK2dGNmxv?=
 =?utf-8?B?WXJMR3YrdVlmYlRJT3hKQktLLy9saklTZTBOTkFMdjJRU3I1Q09GanRnajRU?=
 =?utf-8?B?MEcxWUdubytMSC96UncvS2ljM2wvRFJ0MktIVlEyVWttLzVtSHYxUFRuOVZY?=
 =?utf-8?B?cFU3amlaOXpkM0R1ck0zdWJMeTRHOGxDYkJmZmhJWk1EV3U2bEprVk1yM0FI?=
 =?utf-8?B?d2hTUU0rU1RpN1ZwTXpaTURFaENVRjNtN0Q3ZW81WU05YXN3TjByYi84RUNU?=
 =?utf-8?B?dUd1Q1V0ZEd2U1JHbUdiL05hV2M3OWpnN01CTmJ5NGhiNExieElURjJZcUdF?=
 =?utf-8?B?MWY2Uk10d2xrOStBTjhnUkZOK1Fya3krTEdEeFVBSzBsQys4RTJqd2ErYzdw?=
 =?utf-8?B?OFVUWGZWcmdMcmFsajMwcTByVCtuYXB1ZitYU2FZaWlYWTlEelhiK3hvYjJW?=
 =?utf-8?B?MGNkNy9EMjFxQk1lZUdNa3B0d2tNcWNyNUg4ODRNaDY0TVJETDZjRXoyR0FI?=
 =?utf-8?B?NGFYSzF1NEFRSE4vZkpJNkRTVzNvSEltd1oyMFZBT29ONXNsT0R6Qlc3d0pL?=
 =?utf-8?B?dVRPdEpHNHdXNnJzcWFZVlAwbGtFaUVGM0I0RkRTNjdjZ0dSang0QT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F96EB83D26EA54AAC14489EEB8C3456@apcprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: transsion.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR04MB5648.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63c08f6a-a64d-4b13-0c9e-08ded7789dfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2026 13:56:57.9436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J0lxLa/b6YHbgpHpG9Z2AvppRgwlp/Yty9ANz9o7gzz62Cns6cLQeBhMOVi8OjsIxiXyGRe/NQTtdveAgJIPdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB7508

T24gNy8xLzIwMjYgOTo0MyBQTSwgTWFzYW1pIEhpcmFtYXRzdSB3cm90ZToNCj4gT24gV2VkLCAx
IEp1bCAyMDI2IDEyOjE0OjU0ICswMDAwDQo+IFB1IEh1IDxodXB1QHRyYW5zc2lvbi5jb20+IHdy
b3RlOg0KPiANCj4+IEZyb206IGh1cHUgPGh1cHVAdHJhbnNzaW9uLmNvbT4NCj4+DQo+PiBUaGlz
IHNlcmllcyBmaXhlcyB0d28gYXJtNjQga3Byb2JlcyBpc3N1ZXMgb2JzZXJ2ZWQgd2hlbiBydW5u
aW5nDQo+PiBzaW1wbGVwZXJmIHdpdGggcHJlZW1wdGlycSB0cmFjZXBvaW50cyBhbmQgZHdhcmYg
Y2FsbGNoYWlucyB3aGlsZSBhDQo+PiBrcHJvYmUgaXMgYWN0aXZlIG9uIGEgZnJlcXVlbnRseSBl
eGVjdXRlZCBrZXJuZWwgZnVuY3Rpb24uDQo+Pg0KPj4gVGhlIGNyYXNoIGhhcHBlbnMgaW4gdGhl
IGtwcm9iZSBkZWJ1ZyBleGNlcHRpb24gcGF0aC4gV2hpbGUgYSBrcHJvYmUgaXMNCj4+IHByZXBh
cmluZyBvciBleGVjdXRpbmcgaXRzIFhPTCBzaW5nbGUtc3RlcCBpbnN0cnVjdGlvbiwgcGVyZi90
cmFjZSBjb2RlDQo+PiBjYW4gcnVuIGluIHRoZSBzYW1lIHdpbmRvdy4gVGhhdCBjb2RlIG1heSBl
aXRoZXIgdGFrZSBhIGZhdWx0IG9mIGl0cyBvd24NCj4+IG9yIGhpdCBhbm90aGVyIGtwcm9iZS4N
Cj4+DQo+PiBQYXRjaCAxIG1ha2VzIGtwcm9iZV9mYXVsdF9oYW5kbGVyKCkgaGFuZGxlIGEgZmF1
bHQgaW4NCj4+IEtQUk9CRV9ISVRfU1MvS1BST0JFX1JFRU5URVIgb25seSB3aGVuIHRoZSBmYXVs
dGluZyBQQyBwb2ludHMgYXQgdGhlDQo+PiBjdXJyZW50IGtwcm9iZSdzIFhPTCBpbnN0cnVjdGlv
bi4gT3RoZXJ3aXNlIHRoZSBmYXVsdCBpcyBsZWZ0IHRvIHRoZQ0KPj4gbm9ybWFsIGZhdWx0IGhh
bmRsaW5nIHBhdGguDQo+Pg0KPj4gUGF0Y2ggMiBhbGxvd3MgYSBrcHJvYmUgaGl0IGluIEtQUk9C
RV9ISVRfU1MgdG8gYmUgaGFuZGxlZCBhcyBhDQo+PiByZWNvdmVyYWJsZSBvbmUtbGV2ZWwgcmVl
bnRyeS4gT25seSBhIGhpdCB3aGlsZSBhbHJlYWR5IGluDQo+PiBLUFJPQkVfUkVFTlRFUiByZW1h
aW5zIHVucmVjb3ZlcmFibGUuDQo+Pg0KPj4gVGhpcyBmb2xsb3dzIHRoZSBzYW1lIGxvZ2ljIGFz
IHRoZSBleGlzdGluZyB4ODYgZml4ZXM6DQo+PiAgICA2MzgxYzI0Y2Q2ZDUgKCJrcHJvYmVzL3g4
NjogRml4IHBhZ2UtZmF1bHQgaGFuZGxpbmcgbG9naWMiKQ0KPj4gICAgNmE1MDIyYTU2YWMzICgi
a3Byb2Jlcy94ODY6IEFsbG93IHRvIGhhbmRsZSByZWVudGVyZWQga3Byb2JlIG9uIHNpbmdsZS1z
dGVwcGluZyIpDQo+IA0KPiBHb29kIGNhdGNoISENCj4gVGhlIHNlcmllcyBsb29rcyBnb29kIHRv
IG1lLg0KPiANCj4gQWNrZWQtYnk6IE1hc2FtaSBIaXJhbWF0c3UgKEdvb2dsZSkgPG1oaXJhbWF0
QGtlcm5lbC5vcmc+DQo+IA0KPiBCdXQgaXQgc2hvdWxkIGJlIHJldmlld2VkIGJ5IGFybTY0IG1h
aW50YWluZXJzIHRvby4NCj4gDQo+IEJUVywgaWYgeW91IGFyZSAiUHUgSHUiLCB0aGUgU2lnbmVk
LW9mZi1ieSB0YWcgc2hvdWxkIGJlDQo+ICJQdSBIdSA8Li4uPiIgaW5zdGVhZCBvZiAiaHVwdSA8
Li4uPiIuDQo+IA0KDQpIaSBNYXNhbWksDQoNClRoYW5rIHlvdSBmb3IgeW91ciByZXBseSBhbmQg
QWNrZWQtYnkuDQoNClllcywgdGhhbmtzIGZvciBwb2ludGluZyB0aGlzIG91dC4gSSB3aWxsIGZp
eCB0aGUgYXV0aG9yIG5hbWUgYW5kIHRoZQ0KU2lnbmVkLW9mZi1ieSB0YWdzIHRvIHVzZSBhIGNv
bnNpc3RlbnQgbmFtZSBpbiB0aGUgbmV4dCB2ZXJzaW9uIG9mIHRoZQ0KcGF0Y2hzZXQuDQoNClRo
YW5rcywNCmh1cHUNCg0K
