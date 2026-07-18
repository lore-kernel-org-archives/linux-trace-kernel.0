Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022131.outbound.protection.outlook.com [52.101.126.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491FF18C933;
	Sat, 18 Jul 2026 03:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784344677; cv=fail; b=kV9miFjFVIOz21fR5BcEH5Ha6xzDvKPQkVStRwYaBeJ5w/qbDHmjiACDOuaaEKPFSTXp24YSrhdDfw48L0uaEhXqAelNSnAyRtrcSm/6hTwjB6lHBR6t19osypiGc9HfCEKLSgUdlxs0+bVPO5Q+YKCgKAYPyZaPwWWT28hBWSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784344677; c=relaxed/simple;
	bh=pPhZtUio0W6jdIt8volg2d3fugcUgIy4Rc66/vOazQc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rUaOKMGQqdEouQwi9PqmLxQ+Y9Yz/LLjbYopK1UOwrPn69A1vhTIOxjKa6tXshKj2MHu59w0w8TOhko1OOaJhrSCgzOdpKhEwK3dMVnqsxoAUS9gKvashKto6ltefxV42hzkwBHdBi/QeTmuHjr6B00y0OKfjfsH0/jyNS/vRvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com; spf=pass smtp.mailfrom=transsion.com; dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b=GOVL+L12; arc=fail smtp.client-ip=52.101.126.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=transsion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b="GOVL+L12"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sSf0qFk+GVUJ5vzix+kGQTcHvF/z74my92V4+umeYdeJtgdstEI9IKGBB1p4DRTrFh9IIMXx2cUjK922h/O8NRa7vrOkSqBXsyT4PvrsOAQZrPBUjdz8OhmGNhN0nnSFBecTxfHsDVGjroeYHWujJ6mq+bUCW9jxLspyhS2wUbVDsSMncE5dPSZcI+gmiWQ+B6Z9K+KHSUpsgKvJHLIRepBT219FnMvVAI8ehGtfdHWLcN5uy1z9MEyD5l+ltD+0J9ku0XFc3Y9W12MlieP4pU851yHVdYvpHjZkLkRPD2q6kARxH/PDsUGqFaHah7U9kRqw3RXKktI82iduX6EU2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPhZtUio0W6jdIt8volg2d3fugcUgIy4Rc66/vOazQc=;
 b=AaRbFLS/Ji2wTtPf4FUAPobzhc2mDgSCURS5w2e9OID463dlIv/LFLSDdEZySzbEEjBjUnlQ6RIw4nL++8wTEldn+3W8tX+lUMOZUukWzi+CBFx1Eu4J2ft2TaE5LlzMK1XobrSPh9Qcb0O8tofYl64n1t9Hy+GXM70uRgDw1BFocZY5yiTMP2e/qJE9k2mKHLjm7LW3ao01KizJURcTAAIhD915Ho+R3LdYLUO288vmsvQB9wpm4ES0eLz/N8V88dh05v/n761PyQk1TB63JaXGycnyNlaiflDRQZLVsXBbzGqforC3uZ8GbblxVJhBEgpxs1iC+K2ayvpkf6CXeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPhZtUio0W6jdIt8volg2d3fugcUgIy4Rc66/vOazQc=;
 b=GOVL+L12sgnBYjImpCaSOVFgfavAJiX2lOOJYPAP96lLzSX8VApoBxoX5dTHBdZxBYfLUv3BWA9fmtaVwsyTWhpM2MfBWw3oNpu24hAyyEiIwvEGjobMy/CZ52VstNh5+jzE2cB/ImKjMctQUBXd6HzOYYjaJWx5sqVLgw8jHMQ=
Received: from KL1PR0401MB6196.apcprd04.prod.outlook.com
 (2603:1096:820:c7::13) by TYPPR04MB9137.apcprd04.prod.outlook.com
 (2603:1096:405:385::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.4; Sat, 18 Jul
 2026 03:17:52 +0000
Received: from KL1PR0401MB6196.apcprd04.prod.outlook.com
 ([fe80::f2ee:1e28:9022:99f3]) by KL1PR0401MB6196.apcprd04.prod.outlook.com
 ([fe80::f2ee:1e28:9022:99f3%3]) with mapi id 15.21.0245.006; Sat, 18 Jul 2026
 03:17:52 +0000
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
 AQHdEDXxWg6e3HuDfkaTSvkiR6Me8rZwLF+AgAAU4ACAAAuXgIAAsBUAgACZxoCAAAhcAIAAbVyAgACbCwA=
Date: Sat, 18 Jul 2026 03:17:52 +0000
Message-ID: <ff0e5a26-8ff6-49e5-ade2-33875ae0174c@transsion.com>
References: <20260710063242.228714-1-hupu@transsion.com>
 <20260710063242.228714-3-hupu@transsion.com>
 <aljbf_RmOd9U2KDT@willie-the-truck>
 <0f049d38-b7f6-47f0-a410-95ad2aee7fd4@transsion.com>
 <alj2uxE1M8mcMBhA@willie-the-truck>
 <e0e800f5-a6f8-48ae-b55c-5c3d928bf234@transsion.com>
 <aloLb0j8sg0usmAF@willie-the-truck>
 <be182a18-4cea-445d-a319-1ed3a6c17598@transsion.com>
 <alpuL10h7-OK2hFb@willie-the-truck>
In-Reply-To: <alpuL10h7-OK2hFb@willie-the-truck>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0401MB6196:EE_|TYPPR04MB9137:EE_
x-ms-office365-filtering-correlation-id: e3387863-548a-44c8-bf8c-08dee47b271e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|18002099003|22082099003|4143699003|11063799006|38070700021|10067099003|56012099006;
x-microsoft-antispam-message-info:
 IyaS8GxsMG2dJd0G46HXXUJlxwWHRQGSvwdOAsMuM/dsZx7KA4pz9TfXkaMiLQzHrMgonUjNkz6xHe9Wi6fTr0RUXAu5otQayWlFr9YcSyUrIEG/C0G63b7UKR5PC2s/PkQ1llrHu9mwjio7j1X1uCb3QduwSI4SLdnNjumMO99fbKhQO3dWBtWZs4n27ut8wvaNsxpqxv5RJrXp4fAnSuuAQCdvysPyxQ8lJ/NhGud3qgi/6QZHse+oC6ilrKiPFNeIKaZVVb8ZNk/dtYF9MmYhTOG8QS0P5LdpTBsVvZ3kNApoUdFjKCb6QwONUWYxIOUDi4tuExn8gzGl7FB5gzExnG2AEtVzQFWIUXU8RsRc5FHPK9kJeyf0BiZ3l+fbGfHSV7cgYpbKjxNT+BGhDU6cgJuANeAMFRPRMhC9sxNDoKP/DZFHsFThIP7yj0Y1r7QXOtIfMyrDvDGYzUZ1BXfhAobaBkhtezTqmpROoEN3CypQ6mw9oKTGiqj+i2dQM/P4MIZ+sV2pXwS+tL8AZbysIyVK+1FqZL2XLK4bVLWZ4k2JocNzMTUniMOKxh6pnmxLNwsKWoZXOebYQ6fAuxcb0/Dp5FPO4xw8uxOGmEyeQM/LpmOOGwbnaX/fdc3LcDouhD1NAG883c/k7Kjptltdhft60W+dNOuroEd61HepjK0IJesBLS4eTpYgs3XsdN4oarZLQgLf00LHFag5TwD7i9ic74PCHILolOQtAEM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0401MB6196.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(18002099003)(22082099003)(4143699003)(11063799006)(38070700021)(10067099003)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U1pBeG13d2hrZVE0b1FFQlFJdE5QaDhtUnpCWmI1MjBvZlMrV3VoY1V3NWZi?=
 =?utf-8?B?c3VDd3kzelZGcXBCUGV0SlNRSFZsQmluQkFsT095TXN3Y3duSFZ2M2FTWHJ4?=
 =?utf-8?B?UzhyRVQ0MFd6cVhiMTgrQnRFZmN2cFMvNDdIRUVyUHMwWFlVMDVDdkxWMjc2?=
 =?utf-8?B?V3dwN0VGN29MYlpLWWR2ZEtZNVBNOVF6YXBoR2NTMW5CL0x5SGxCbisxTXA4?=
 =?utf-8?B?dXVsbFl1YTY2TVlUbVplMzE2ZWhZR0NOVmZ4R1grOWM1WW14WTVoOUlWbDN3?=
 =?utf-8?B?STBSMVpIUE1lVTRkL0lnbXUyeFdsVkxUOXE3VFhNcWZ6K3pObTJ3b3ZEUmJW?=
 =?utf-8?B?REZLWUVmVjZlNC85UWs3eWI4WkVWRGFDUm1pM3cvUnNSSGpuUmIvYVpXUTVv?=
 =?utf-8?B?SEVNY1R5VEY2UDhIYmZ6QVp0WDdlRFBqTzF2QkRiNVZhc1RlSDlqNHhjOTZo?=
 =?utf-8?B?cUZzSGorVDQ1eWN0Q3lLWDltY1pWMlVWR2JjMEJ0THpLcTJGYVpiWVovYlN1?=
 =?utf-8?B?WGdkbnphMU0rYWNPclA3VjNZM2lIY2xaVGs0TGVOQUt4c0hVY1JYWjFnUDdx?=
 =?utf-8?B?bkJNYlRNZ244ZHhFSnVsN2U1NVdNbVM4SjJHOERFN1JVMkVoc3VvZ1RrbDFz?=
 =?utf-8?B?QmtIVVdsWlAyeVZQZUtybmtGZklkNnpUZmc5QWtlZjQzcHQ2L0xScTMxa2Ey?=
 =?utf-8?B?MUhXQVZVMXFOVkNDWmFnYksxRUcyQ0ZoUFNnb0R5MHhZRWI2SjJvOHlyN0tM?=
 =?utf-8?B?ZFdOdzVjMHUxdGlOaktqU3AxbDZQRGE3dXdySUdSQXo3UTVKU09tdEJjSWVq?=
 =?utf-8?B?bFJ4K2RRSE5pR0FhVzNGR21wTVFkQVpVeGxYOHpwUnl6bFNZdEwrY3F4dzlM?=
 =?utf-8?B?L04wUThhUlUwSERESUJVY296azJVcno3bEJkZFdzRTdqWkRMZ3R6NHpDUWtG?=
 =?utf-8?B?d2xrT1J5cHNWN2dnWlppMFlWU0pWVVpRSWpVNWx1N1ZiMFh0T3prazRwYWtU?=
 =?utf-8?B?U09FVUp5SXh4anBCNmloWUJkd0syanZmL05CclZUSC85b3p3dy8wdTljRU9P?=
 =?utf-8?B?QlF2WlJwWUtzL2FZaVR0SUhqckpIMjAydkNOUWxhUnVkN0FnRFlURmROM2py?=
 =?utf-8?B?Mlc0dkZML05rTTVOcXVwOTN0bzFuVHM5T08yOVlwZmV0ZzdMVDBPNHh3bUxj?=
 =?utf-8?B?WGdEZlpGZWQ4a05ReVlLemdONVhFRTFXamExVzVjdjdVM093VHhIMFc1aFhn?=
 =?utf-8?B?UHVMQXIwczE0R1g1azNUaUtENEhlUUpLdk1CTXR3UGRnaUtXT1k2UHRMbVVI?=
 =?utf-8?B?OXhwdUdmc2ZkQTROOVpvc3JVVFlGSU42d1ozK1c4T0VqakhIdUNWMmlNZisy?=
 =?utf-8?B?cjByWWRsVlBTVms1TWJoSDQ2ZDhTVi9nbzRNdmVzMVlDaWFyWEhUbGg4ckpC?=
 =?utf-8?B?anBvdkZjdkFuMS9Mc25ZRStWNzdhNEVLUlkxZ3ZpMHJJN0xWMkEvVXhoWWpV?=
 =?utf-8?B?bSt6M2Rqay9vRThiMjJzK2pKMVZSWWxFR011ODlnUGNVblEwSEF3TXdMdTQ1?=
 =?utf-8?B?T29uV0xzbmhidFJ3dy9WcW40RFFBYm1uYU0xN1RNNUtnVENQb0tCQit1YmtN?=
 =?utf-8?B?NWIwT3ZqbXdJVkpDNWZ1VVhaK2g3WUlKVzA4K0c1MFk4MGhJWmY4dGx4UUt5?=
 =?utf-8?B?T3UrU1JsNFNVTWtKWkUxZEFwT29JN3lMNERreDVmQ05EOFMzVHpOQ215YzdZ?=
 =?utf-8?B?VlY5c0xVTDFsM2JLZlZnY3AvUVUxU1IvcjdFbjJ1OWUrQno4K1VLMXdtWkY0?=
 =?utf-8?B?b3NXcWFlQlVEOExucEZZd0FqR1c5RDkzVmZHKzBQajFPZHFEakJYYUp5R0Vr?=
 =?utf-8?B?c1RJNmhJbXVKWTlMNUZWMkhUVkQ4L3hMamNEMmplYmRKQkk1WEQ1K0dNOG53?=
 =?utf-8?B?cFVQaHdnUENvdS9zb1dMOUdTQkFIVnNxSW9HdFBtMEhMZzBCUm85WmFwbits?=
 =?utf-8?B?QzByOTZiRU1tYnpsU2dQOVZ6TytOaGIvZFp6dWgwT1hTVVpOWXo1WTJnZHNh?=
 =?utf-8?B?K0pLMmswNXBRMk4vbHlwOW9qbW8zZU1VU3BzT1lIckdHRTNVQzFMVkNnTHIr?=
 =?utf-8?B?cGVPdU1YaGM1R0FBZkZDbHdFeEQveDJvdnRNTHNnSjJBSmRqMHJ1ZVcxMWty?=
 =?utf-8?B?QjJScFVkNE1mcS85SG5qbzdEeFBvWVlJZ2p4TUphN0owWlhOTkpWWU9xRWpy?=
 =?utf-8?B?S3VDK01YbjFkRURRUklRaVZ6SWFCMDZ3NzVYaEd0Nk1xQVAycko5ZU5tQ0lU?=
 =?utf-8?B?clhvZ3ZGVUZlS0FQbW5XYzUrbTBUMEVMeDJsMHBsKysvYXlzQUpTRmVwMDBr?=
 =?utf-8?Q?xhVOpB+txaHA9h9Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C0CCD5C1C1AC664292ED1B18049E7DB5@apcprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e3387863-548a-44c8-bf8c-08dee47b271e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2026 03:17:52.1432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tzPTQAVBD5VkCLV5bqpCBFMeslbvMDqctgMm3t0LFdL+6bo7BgIC7L7P3e4tPHlMdyUUs9gUJrz7m8wMS4iTMJYkPQtMsaPDhXefs/w3dq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR04MB9137

T24gNy8xOC8yMDI2IDI6MDIgQU0sIFdpbGwgRGVhY29uIHdyb3RlOg0KPiBPbiBGcmksIEp1bCAx
NywgMjAyNiBhdCAxMTozMTozMUFNICswMDAwLCBIb25neWFuIFhpYSB3cm90ZToNCj4+IE9uIDcv
MTcvMjAyNiA3OjAxIFBNLCBXaWxsIERlYWNvbiB3cm90ZToNCj4+PiBUaGFua3MuIFNvIHBlcmYg
aXMgcnVuIHN5bmNocm9ub3VzbHkgZnJvbSB0aGUgZGVidWcgZXhjZXB0aW9uIGVudHJ5IHBhdGgs
DQo+Pg0KPj4gWWVzLCBleGFjdGx5Lg0KPj4NCj4+PiByYXRoZXIgdGhhbiBiZWNhdXNlIG9mIGEg
c2Vjb25kIGV4Y2VwdGlvbiB0YWtpbmcgcGxhY2UuIEdvdCBpdC4gQnV0IHRoZW4NCj4+PiBpdCBz
b3VuZHMgbGlrZSB3ZSBzaG91bGQgcmVhbGx5IG1ha2UgdGhlIGRlYnVnIGV4Y2VwdGlvbiBoYW5k
bGluZyBwYXRoIChhdA0KPj4+IGxlYXN0LCB0aGUgcGFydCB0aGF0IHJ1bnMgZm9yIGhhbmRsaW5n
IHRoZSBrcHJvYmUgc3RlcCkgbm9pbnN0ciB0byBhdm9pZA0KPj4+IGdldHRpbmcgaW50byB0aGlz
IHN0YXRlIHRvIGJlZ2luIHdpdGguIElzIHRoYXQgcHJhY3RpY2FsPw0KPj4NCj4+IE5vdCBzdXJl
IGFib3V0IG1ha2luZyB0aGUgd2hvbGUgcGF0aCBub2luc3RyIChATWFzYW1pIG1pZ2h0IGhhdmUg
YQ0KPj4gYmV0dGVyIG9waW5pb24gb24gdGhpcyB0aGFuIG1lKS4gUGVyc29uYWxseSBJIGRvbid0
IG1pbmQgZWl0aGVyDQo+PiBkaXNhbGxvd2luZyBpdCBvciBtYWtpbmcgaXQgY29ycmVjdC4NCj4+
DQo+PiBCdXQgaXQgbWlnaHQgYmUgYSBnb29kIGlkZWEgbm90IHRvIGRpdmVyZ2UgdG9vIG11Y2gg
YmV0d2VlbiBJU0FzLiBUaGlzDQo+PiBwYXRjaCBpcyBwcmV0dHkgbXVjaCBtaXJyb3Jpbmcgd2hh
dCB0aGUgeDg2IHNpZGUgaGFuZGxlcyB0aGlzIHNpdHVhdGlvbi4NCj4gDQo+IE9rLCBzbyBob3cg
YWJvdXQgdGhpcy4gSSdsbCB0YWtlIHRoZXNlIGZpeGVzIGZvciBub3csIGJ1dCBsZXQncyB0cnkg
dG8NCj4gbWFrZSB0aGVzZSBwYXRocyBub2luc3RyIGluIHRoZSBmdXR1cmU/IFRoYXQncyBhIG11
Y2ggYmlnZ2VyIGpvYiwgYnV0IEkNCj4gZG8gd29ycnkgdGhhdCB3ZSdyZSBnb2luZyB0byBvdGhl
cndpc2UgZW5kIHVwIGFkZGluZyBzcGVjaWFsIGxvZ2ljIGV2ZXJ5DQo+IHRpbWUgd2UgcnVuIGlu
dG8gYW4gdW5leHBlY3RlZCByZS1lbnRyYW50IGNhc2UuDQoNClN1cmUsIHRoYW5rcy4gSW4gb3Vy
IGNhc2UsIHN1cmVseSBpZiBzb21lb25lIHdhbnRzIHRvIHRyYWNlIGNlcnRhaW4gDQpldmVudHMg
bGlrZSBwcmVlbXB0X29uL29mZiAod2hpY2ggaXMgd2hhdCB3ZSBhcmUgZG9pbmcgd2l0aCBwZXJm
KSwgDQpldmVudHMgb3V0c2lkZSBkZWJ1ZyBleGNlcHRpb25zIHNob3VsZCBiZSBlbm91Z2guIEhl
IG9yIHNoZSBtaWdodCBub3QgYmUgDQpzbyBrZWVuIG9uIGV2ZW50cyBpbnNpZGUgZGVidWcgZXhj
ZXB0aW9ucywgYW5kIG5vaW5zdHIgc2hvdWxkbid0IGh1cnQuDQoNCldlIHdpbGwgZ2l2ZSBpdCBh
IHRob3VnaHQgYW5kIHNlZSBpZiB3ZSBjYW4gY29tZSB1cCB3aXRoIHNvbWUgUkZDcyBsYXRlci4N
Cg0KPiANCj4gV2lsbA0K
