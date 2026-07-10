Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023112.outbound.protection.outlook.com [40.107.44.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E03E3B14D5;
	Fri, 10 Jul 2026 06:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783663999; cv=fail; b=uhSuIyLZ3rzqFXpn+AhJJYVjbS3aaOcb6ehwuDqMZjW8e47Hcq+bg86Gxa10OS4CCRlaq0e+sc76B244goKEccSuyLqKbAiwhaal6kVO9FmlFPpyGVy+YQ300JQ99Ykx1ZppJu6QLbiClYJj7k0R7IapAJPwkKINEtJJjm7XPaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783663999; c=relaxed/simple;
	bh=qgmcl0AEZkgt/Z87anqt7tRsWQd4iWCwHCdYk0/4GXo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YvVSdlm5kspjWHL0PhVWaHwdKFI9zcjrzS+QdoEFq9SutlROHIsQGsY6WVc5iDMLovypiLWIecPs9Kvt+mfJOkdF1fFcx8QqNlUnabzdvnWKTTz/+C+yS7PzuTpih9oV/G8nsuu/FfmOaghOzI3cJ5pDioCZeCGCOwHtD/sx1/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com; spf=pass smtp.mailfrom=transsion.com; dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b=wwbRgED1; arc=fail smtp.client-ip=40.107.44.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=transsion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b="wwbRgED1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nrJZpdahFweiaD8mHs5d5P5kH3SG06OY+NDF5RW01K/qAL/epKqcuuYgMvDqrNk3kJzPYRkaUExdI1iyiGQ3d48Igc/BZ1wAai9Hs25mKc96jde3/zhgcBSCIvrvlKL/tq1RyuJlYcy55JWms2fL8I1TVmSzWtdxphHUYWzA55AjCrZJSEiL6oJL+oxohtZRmgpy0sUab6lgM6CkOOZKoyCzOdu9J6cDBs9WQYQZZVUUEITmW4GNYn5LzHBAFpbdj/6NEP61Hm9GOEHxg8D3JEw0FUbLlCkQiuVlUoc4mLTYTc6e7WSnlz/AsraJck78SHc2rwP1Zd2bpt9wuLDBAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qgmcl0AEZkgt/Z87anqt7tRsWQd4iWCwHCdYk0/4GXo=;
 b=dgiXMXEaAN1d7KGpOjBP2MdsgS5LQ0MAtcjSkpskEGw+tTMIYxcrPfAaJqoYGFbOPAeNHzI+O1AcCNl8KlDXF2DFma1Xx99klTJmhzs89Uy2g60L5KaS60d85jvfznkOHo5AioWOMn2Im+p0I8rVKXHRvVl4JKPEk/kKXSbl3UpR82U7hDj6646kRjeYaU8Cy7LP2mKHSqTvuD+vk9Dw6ikBDRgaQVsYsXKagkQH7Rle8k9IRScZITw9Iuhs7QUJ6TD9KI/FmOYEtIuz958pr44EVtsOlhzBxN8rARlgiJhy9L5lwZBs9aSkhfPEaiFCvLo+1vCyeKG+53bviZUBsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qgmcl0AEZkgt/Z87anqt7tRsWQd4iWCwHCdYk0/4GXo=;
 b=wwbRgED1t8HkN9LZeQcBQ0Ex0Q69xPFIXTLR97g7SGAGHytCWpim1VqQroxSO3u5FPZ9+aJiT8qUHhzUas12m5qJMY0KyZx5D0yfi46aN5nspioFXG7Lo+DU4gwxUnZ8VSj3ySmPiyrOtA5St7fBeBpXKBhQ6aslcFUNYhas5eQ=
Received: from SI2PR04MB5648.apcprd04.prod.outlook.com (2603:1096:4:1a4::11)
 by TY0PR04MB5658.apcprd04.prod.outlook.com (2603:1096:400:1be::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 10 Jul
 2026 06:13:12 +0000
Received: from SI2PR04MB5648.apcprd04.prod.outlook.com
 ([fe80::8ce1:b82b:3b19:f79d]) by SI2PR04MB5648.apcprd04.prod.outlook.com
 ([fe80::8ce1:b82b:3b19:f79d%5]) with mapi id 15.21.0181.008; Fri, 10 Jul 2026
 06:13:12 +0000
From: Pu Hu <hupu@transsion.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
CC: "ada.coupriediaz@arm.com" <ada.coupriediaz@arm.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "davem@davemloft.net"
	<davem@davemloft.net>, Hongyan Xia <hongyan.xia@transsion.com>, Jiazi Li
	<jiazi.li@transsion.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>, "naveen@kernel.org"
	<naveen@kernel.org>, "will@kernel.org" <will@kernel.org>,
	"yang@os.amperecomputing.com" <yang@os.amperecomputing.com>
Subject: Re: [RFC v2 2/3] arm64: kprobes: Allow reentering kprobes while
 single-stepping
Thread-Topic: [RFC v2 2/3] arm64: kprobes: Allow reentering kprobes while
 single-stepping
Thread-Index: AQHdD65dtlWwozfAw0OlEAyKRHtrcLZmNT0AgAARoIA=
Date: Fri, 10 Jul 2026 06:13:12 +0000
Message-ID: <e97c0b94-aef2-4d55-93a0-12d38f095f6f@transsion.com>
References: <20260709142215.226872-1-hupu@transsion.com>
 <20260709142215.226872-3-hupu@transsion.com>
 <20260710140936.8788416564452e490c71634c@kernel.org>
In-Reply-To: <20260710140936.8788416564452e490c71634c@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR04MB5648:EE_|TY0PR04MB5658:EE_
x-ms-office365-filtering-correlation-id: 8258c2c6-b4fd-4b6e-5eac-08dede4a5228
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|23010399003|376014|1800799024|38070700021|56012099006|11063799006|4143699003|22082099003|18002099003|4133799003|3023799007;
x-microsoft-antispam-message-info:
 871UQASLi8g3N79gA7RjPM/bf20RYOgtukiAbHS6hgL6KSNrLJmBVHWMzBwqfu+CcRLqEOQglSDWN7VHCfNiGcIbCMThQyHVcNjjIVyQgKKIiyjxLBIC3++vWrVLZDmAqUZy15z5VQalp0uBWEfeoh33R9TRaKTTPAyPtjIRNGtp7DH9nGuFoLyyS8hW0s5wU+sVRkCqW1uc8fALjhGIKoD2IUCfvpbELYzX9NcF7RpaouuVKixuSxYof5byuQal02SAzo2wlGKG1MYIkbHuJWuOKhmd+Qoq8/fOIHj9Z/VXauI841R6uT3KYNVksLlnJw15XF1RGsU9OhX5e7OORUJLUsY9NRWWLw6EhdO2ylNGyEOA/edZUt+e96JWsA70G1JjIZDLGanBIrjEFwNwImjSIyNr8wnICOs5Xl8NI3U0T1ZRtCVVW2XsVn1rCDxRsaf3xfTKquGX7ZpV/9bWSVou2Xv9qkEDIAmY7boTYUCzE/972aWk5RyZW+4qWRtw74cvNX+HH3zr5mK3U2dh5TXTW7TP/SUZc2+YHEnrshfvxP4l0E62NBu6L9h4nZ6kls8zYzA1UC2UPPSQMNbqn0rRpEF4X9q7a2FS+wDg7VkcMPoJlZ16MXJ4yUaLPfzz5oMAVWcJJ0xQEUfzKobOZSgeA+op8En4N+hj8gX4tTw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR04MB5648.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(23010399003)(376014)(1800799024)(38070700021)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(4133799003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c09hd3lsUjB3QlJiOVpadjJncFJBVHZLaHl5enFITmh0NjNjZjRtUkRrdGRv?=
 =?utf-8?B?Yjd3cHlqeVRpcGRUeUNvSGg2cWdBT0VieHBPbmh2bGVvU2hJSmNaUFRJMFF4?=
 =?utf-8?B?WFFidlVSQnZVMUpvN1pvVkllMUZZQUFvOGtyS2VpVGhrdXgrOU9VMjNWbi8x?=
 =?utf-8?B?ZGkvWkdYZTF3TWFvdHRSTEN0RmxLVnM5bGZTTGMxUlJUWHpPZlNqWnlib1k4?=
 =?utf-8?B?SXR5RWZiUjFPNTh5WUpzKzdkZ2RFbUNxaFJubFZGdnYrckY0VFlXWlFFcXUw?=
 =?utf-8?B?Yzh6ZDFXSWY1bWh0WmtKc0ZXbGJsM0IyVXB6b2M5QkpjK0N0TzJreGM5RVhI?=
 =?utf-8?B?NWdoSVpGNWRkMllnUWNPSG1UY2tVeGU4enY4eTJqTzhxcE9qK2FKaU1jeStW?=
 =?utf-8?B?SDJIaExabEVXYVMwRkdQZGdqWWFuWjd6c1BnTCtUYXZodEI5YjZjaVg4c2VS?=
 =?utf-8?B?M1ZXT0g5MzczcGNzQW1NRGZlbE54Y0dGellhWkh2SGxCNmp6S0ZMeFdKZzlJ?=
 =?utf-8?B?dmxHRjFMWVI5cnlCR1BZSlhXd3grdmNBK2NzRFhmL01qZlQ3UU8yMWJPTjRK?=
 =?utf-8?B?S2RmdW9RR3BGQ01BVUVCblYvTWhEaUdlNDd4UGRIRktFaytnSU9yUy9yeXhv?=
 =?utf-8?B?azN3U01GUTFOWlZVdjZwZVFYYjBzN0V0U0VRUnVlN2grRE83ZW1iOWtpSWsr?=
 =?utf-8?B?ZHRJaWc5VHBBbjd5UGgvcGNwaFJhNWdrOGt1aHp4NFRaTWZaRVF5aks1TGtT?=
 =?utf-8?B?RENqQ1hNNllnK2Vjb0o1cDd1Z3hjd3FRUzgvS2NHNnpEMXJVVC9LSXFMeFUx?=
 =?utf-8?B?M0F4NGt4SzZSeGduMldCYlhOZ1BvWGdHVXlYWlBKQ2lqOVBMWWlNWkhoTGFJ?=
 =?utf-8?B?Z1prRTJsSHk5eDI5RVp4WnNObVJoaHhDZzVFQ0UwK0xBMElvenQ2ZHAwUnZp?=
 =?utf-8?B?YlJTbFdIK29KTk11UytWS0s2OEk2cG83TlQrTnh3RlJwRnBxSXdOMk42LzV2?=
 =?utf-8?B?cGFZWElsd1pMSFF2YWJQMWJOQXNjZlIrRFZ3endXejJXZ0lTSm1hNnREVjhk?=
 =?utf-8?B?ZWRFWGMxL1d3dFY1Z29wTXh1SjRMTGFPMUg3S01tTTZST3ppWk00OTR4R1lM?=
 =?utf-8?B?WTEyTTBnVC9xNWJnRkFoamVBa1AvVUxvMkZycnY5MFJNcUtibmZyNk1sejRJ?=
 =?utf-8?B?RmhJMjRPV2dYMkdTL1h2OGZvZFV4TUhxcDBpRG1TaTA0MVdidXBPNFhTcUNw?=
 =?utf-8?B?UXpCK1dlTDNRK0xVY2xNd29ISGJyOUlWU1RzWloxR0w2anhhMGt4aGEwRmFk?=
 =?utf-8?B?QUpZc3N2VElNSGZmTzFTSEZUcEZBSlRUVDRhR0ZWYkVlMFk2WXRYbFY5MHVm?=
 =?utf-8?B?S2dJdXFrVFFWT2FHRjRXVDNlMis1TmRTSXNnL0hDN2Vpb1BkWVdLMlpGaWt6?=
 =?utf-8?B?U3dXZ1BHbUVQYjNPNk9zOE1RY3F4QnhLbXNhRGMwZy9TQ2JwVGc0YitrNzNS?=
 =?utf-8?B?ajRhTmFMNDFoSFZYSGVFZldOUmhTdlk5TTRNdmFXM0hXMmVVdmZ0VnRJN3BF?=
 =?utf-8?B?MTVYaWlCYnFBeWV5ODlLbTNFMTR6YmN0UEl6YTBaOFdsRUNqT2d0ZEVQTG96?=
 =?utf-8?B?ZkZ0b2s5bGJOTDA4N3VzSHU0Y0plTnkvbWkvUmllNjVRRDNYaXhJdHJvdU8w?=
 =?utf-8?B?bjJSZzI4d29ueDd0eWo5b21VUHpmUjVTTVBORS9nR2dCMG5vR3JubFpYTDNu?=
 =?utf-8?B?RUdiM25xZEhOVkMxeG1mTDVkOVNLRWRvVE95Z0JCYWxoSDI1VGloVk44dy8v?=
 =?utf-8?B?UTBSWXA0Ny9qb2ZGd09GYllMZlJHckFXRmdWYnZFb2hMaTJKZnRmbzFldDlS?=
 =?utf-8?B?SWo4VnN5bHJ0RW9GYjBnU0RmN0ZtTWtxWGtxMUJSaWJOaGF0VFBzSUtjU01G?=
 =?utf-8?B?NGxHd0ZBcStkbkdrdFZsbDArWUQ5VjdLWnJwZENrUVhNcGZsTFJQaDk1ZHFE?=
 =?utf-8?B?QTU5QjZCTzJ5bmU0K0VXNEtXZXlxTEZEWWFZdnJ2blpldUUwY1NYb2NQWExm?=
 =?utf-8?B?Yjl1WTZiKzVVbkhxMC9qaU44bVJTNUNmR3pOQ0dELy9GR2kwV29ueWhuZmJV?=
 =?utf-8?B?ODZWaC90MXJRWWd1ZnBkMGowSHZKOUsvNU8wN3k0ekxPZnZxOUp2THo0dURl?=
 =?utf-8?B?TWVxZlBSaWRhS2hUVzRuYWZMcVdYZjliNWt1LzVzbjQ2OHpiMWJBMDc5ZFNJ?=
 =?utf-8?B?elJZakprNTUwNFBFQVpIZUxzaHdDWENMN3AxWjMwdDExSk1GSVcxMUE5RVJF?=
 =?utf-8?B?M0xMMWZzT0M3UXM4enBnZDMvNUpmNXB4VWFTQkdQQmFQZXJRaGVJdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C1E4461FCB8F745B038DC889598F7ED@apcprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8258c2c6-b4fd-4b6e-5eac-08dede4a5228
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2026 06:13:12.0453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sboli5VeE4ODkCSkXhsBYIOTOFBpy/5jAwdLIgSskZl0RgCee0K9JAa+DwDV2q/bBi1jBD43pWq9cicWBW3FWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR04MB5658

T24gNy8xMC8yMDI2IDE6MDkgUE0sIE1hc2FtaSBIaXJhbWF0c3Ugd3JvdGU6DQo+IE9uIFRodSwg
OSBKdWwgMjAyNiAxNDoyMjoyNSArMDAwMA0KPiBQdSBIdSA8aHVwdUB0cmFuc3Npb24uY29tPiB3
cm90ZToNCj4NCj4+IEZyb206IFB1IEh1IDxodXB1QHRyYW5zc2lvbi5jb20+DQo+Pg0KPj4gQSBr
cHJvYmUgY2FuIGJlIGhpdCB3aGlsZSBhbm90aGVyIGtwcm9iZSBpcyBpbiBLUFJPQkVfSElUX1NT
IHN0YXRlLiBUaGlzDQo+PiBjYW4gaGFwcGVuIHdoZW4gdHJhY2luZyBvciBwZXJmIGNvZGUgcnVu
cyBmcm9tIHRoZSBkZWJ1ZyBleGNlcHRpb24gcGF0aA0KPj4gd2hpbGUgdGhlIGZpcnN0IGtwcm9i
ZSBpcyBwcmVwYXJpbmcgb3IgZXhlY3V0aW5nIGl0cyBvdXQtb2YtbGluZQ0KPj4gc2luZ2xlLXN0
ZXAgaW5zdHJ1Y3Rpb24uDQo+Pg0KPj4gQ3VycmVudGx5IGFybTY0IHRyZWF0cyBhIGtwcm9iZSBo
aXQgaW4gS1BST0JFX0hJVF9TUyBhcyB1bnJlY292ZXJhYmxlLA0KPj4gdGhlIHNhbWUgYXMgYSBo
aXQgaW4gS1BST0JFX1JFRU5URVIuIFRoaXMgaXMgdG9vIHN0cmljdC4gQSBoaXQgaW4NCj4+IEtQ
Uk9CRV9ISVRfU1MgaXMgc3RpbGwgYSBvbmUtbGV2ZWwgcmVlbnRyeSBhbmQgY2FuIGJlIGhhbmRs
ZWQgYnkgc2F2aW5nDQo+PiB0aGUgY3VycmVudCBrcHJvYmUgc3RhdGUgYW5kIHNldHRpbmcgdXAg
c2luZ2xlLXN0ZXAgZm9yIHRoZSBuZXcgcHJvYmUsDQo+PiBqdXN0IGxpa2UgcmVlbnRyeSBmcm9t
IEtQUk9CRV9ISVRfQUNUSVZFIG9yIEtQUk9CRV9ISVRfU1NET05FLg0KPj4NCj4+IFRoZSB0cnVs
eSB1bnJlY292ZXJhYmxlIGNhc2UgaXMgaGl0dGluZyBhbm90aGVyIGtwcm9iZSB3aGlsZSBhbHJl
YWR5IGluDQo+PiBLUFJPQkVfUkVFTlRFUiwgYmVjYXVzZSB0aGUgcmVlbnRyeSBzYXZlIGFyZWEg
aGFzIGFscmVhZHkgYmVlbiBjb25zdW1lZC4NCj4+DQo+PiBNb3ZlIEtQUk9CRV9ISVRfU1MgdG8g
dGhlIHJlY292ZXJhYmxlIHJlZW50cnkgY2FzZXMgYW5kIGxlYXZlDQo+PiBLUFJPQkVfUkVFTlRF
UiBhcyB0aGUgdW5yZWNvdmVyYWJsZSBuZXN0ZWQgcmVlbnRyeSBjYXNlLg0KPj4NCj4+IFRoaXMg
bWlycm9ycyB0aGUgeDg2IGZpeCBpbiBjb21taXQgNmE1MDIyYTU2YWMzDQo+PiAoImtwcm9iZXMv
eDg2OiBBbGxvdyB0byBoYW5kbGUgcmVlbnRlcmVkIGtwcm9iZSBvbiBzaW5nbGUtc3RlcHBpbmci
KS4NCj4+DQo+DQo+IEhpLCBhcyBTYXNoaWtvIGNvbW1lbnRlZCwgd2UgaGF2ZSB0byBzYXZlIHRo
ZSBzYXZlZF9pcnFmbGFnIHRvDQo+IHByZXZfa3Byb2JiZS4NCj4NCj4gaHR0cHM6Ly9zYXNoaWtv
LmRldi8jL3BhdGNoc2V0LzIwMjYwNzA5MTQyMjE1LjIyNjg3Mi0xLWh1cHUlNDB0cmFuc3Npb24u
Y29tP3BhcnQ9Mg0KPg0KPiBUaGFuayB5b3UsDQo+DQoNCkhpIE1hc2FtaSwNCg0KV2UgYWxyZWFk
eSBhZGRlZCB0aGUgc2F2ZWRfaXJxZmxhZyBzdXBwb3J0IGluIFBhdGNoIDMgb2YgdGhpcyBzZXJp
ZXM6DQoNCiAgIGFybTY0OiBrcHJvYmVzOiBTYXZlIGFuZCByZXN0b3JlIHNhdmVkX2lycWZsYWcg
aW4gcHJldl9rcHJvYmUNCg0KSG93ZXZlciwgSSBzZWUgdGhlIGlzc3VlLiBQYXRjaCAyIGFuZCBQ
YXRjaCAzIGFyZSBzZXBhcmF0ZSBjb21taXRzLA0Kc28gUGF0Y2ggMiBhbG9uZSBpcyBub3QgYmlz
ZWN0YWJsZS4gSSdsbCBwcmVwYXJlIGEgdjMgdGhhdCBmb2xkcyB0aGVtDQp0b2dldGhlciwgc28g
dGhlIHJlZW50cnkgbG9naWMgYW5kIHRoZSBzYXZlZF9pcnFmbGFnIHByZXNlcnZhdGlvbiBsYW5k
DQppbiBhIHNpbmdsZSBjb21taXQuDQoNClRoYW5rcyBmb3IgcG9pbnRpbmcgdGhpcyBvdXQuDQoN
ClRoYW5rcywNClB1IEh1DQoNCg0K
