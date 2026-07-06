Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023120.outbound.protection.outlook.com [40.107.44.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCCE3EFFB4;
	Mon,  6 Jul 2026 08:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783327037; cv=fail; b=nGyFGxYm8r1EG/U+cYxPgzuyohdfQnnvzAeESdcbj+yNN810BkN2LwSVd46qGv4j86Vfg4FtXuRAp6kmQZ7MAJG2FAX/tpDCI5lbqJy8mjPKH9xQSt+WNJZCwq+p4v05/DdzL9OCkxvP59WpjteUObFcAoDWD0eyhx1DAbfUcNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783327037; c=relaxed/simple;
	bh=w594UFmti3v08F8ARhw5wF9hd94Rvjy3NBXCK9g+j8c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j5qfJYxxD3zYSbqqKROk84W4bj5YEXpTP3Ok4tP5Fg2tKj3fwBwrhHyOHSr62jggkSRZY+daXpgTpXp/OqUAbgMN524E5/sKYUerMQtuf5JCN0HArqSmLfVZqbeTOQGGAV4JW6BWVhB9PQpPUUnWaK1lhQ2JkdcenObKJEKLxCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com; spf=pass smtp.mailfrom=transsion.com; dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b=IV+orLQK; arc=fail smtp.client-ip=40.107.44.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=transsion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b="IV+orLQK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d7aQY0YejhNhHGNQK6t8fpPbrOpYuBswaPpIcNyroDjlKG2S9r5pNvQeIiOCtl2MKW5y4u9wym3mGSc59wPbRnoegu1JP82zMIZJO7X7W1nqY+okFzCFFTA80HxGr8xiwtOHJL2Z51TqPcmxHlQEGGXW/IoUKdSHshYmHIt1NRDcNWz105gL3Vvm0a95jJLKTHweA6o6hAU9OvBIT1K5nPxBEk3mraStHJtVhBG40W/Pd51dZuBftT/SvXF/HiXMVShSJENr/Z6ZFMBx9JcfLQh7k3JVpXpHnJuYcAtcd079geq5RZvBDCjOYw3v7mBg+/cFYc0y181gBsM8AIhqDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w594UFmti3v08F8ARhw5wF9hd94Rvjy3NBXCK9g+j8c=;
 b=O6Jbjb3a2e4YrTLpgdkcU7V/jXV5h1Ie6OmENPIbAqpI2fHR286XGcbjnvQaMPRZV8TGAxUWjGQZealtN4Y/NtMaHBIglIKQDFcvwNbe3WLM/pXdngH7nZIuG8ZPPZQBKGtXudkxf7FZ3Nld8hAxbJ/K+sVMtiUSLw86ZVH20DKuLZ1LuyuuDdNvAxQWWEgbsZB8swIycZb8uMgEL8wgk+asAwnEkbbD+lDy1zdvSW9NMwSNSu3odFXMtQTmd1CZxSQR7avsfS7w7rLxRZ9vWaofTt0vJ+08JGzDWlQTc1B76gKPTtmsYQ8eP1bJsZDaavf6eKDX5KgJEg8q55Nywg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w594UFmti3v08F8ARhw5wF9hd94Rvjy3NBXCK9g+j8c=;
 b=IV+orLQKb6CRZ4wjvCiReH9NbHmKdB6XiAk0gCCcHecEc76hKR0Hqs+UVPe42I63Ezxb0LvUavQMaXLLT3PTuvs1m2PXwfffIy3VhLGy1P9QOQe4HEintLbvrrvP6S6rjt6p8Azv1S4MDoK+a8AhiPAzlSHvoTKt6Le5vHK6Sig=
Received: from SI2PR04MB5648.apcprd04.prod.outlook.com (2603:1096:4:1a4::11)
 by TYZPR04MB7280.apcprd04.prod.outlook.com (2603:1096:400:44f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 08:36:49 +0000
Received: from SI2PR04MB5648.apcprd04.prod.outlook.com
 ([fe80::8ce1:b82b:3b19:f79d]) by SI2PR04MB5648.apcprd04.prod.outlook.com
 ([fe80::8ce1:b82b:3b19:f79d%5]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 08:36:49 +0000
From: Pu Hu <hupu@transsion.com>
To: "mhiramat@kernel.org" <mhiramat@kernel.org>
CC: "ada.coupriediaz@arm.com" <ada.coupriediaz@arm.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "davem@davemloft.net"
	<davem@davemloft.net>, Hongyan Xia <hongyan.xia@transsion.com>, Pu Hu
	<hupu@transsion.com>, Jiazi Li <jiazi.li@transsion.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>, "naveen@kernel.org"
	<naveen@kernel.org>, "will@kernel.org" <will@kernel.org>,
	"yang@os.amperecomputing.com" <yang@os.amperecomputing.com>
Subject: [RFC 2/3] arm64: kprobes: Allow reentering kprobes while
 single-stepping
Thread-Topic: [RFC 2/3] arm64: kprobes: Allow reentering kprobes while
 single-stepping
Thread-Index: AQHdDSKW4bd+sdqfx0eg6rCsNVHfEQ==
Date: Mon, 6 Jul 2026 08:36:49 +0000
Message-ID: <20260706083636.159883-3-hupu@transsion.com>
References: <20260704234730.46d51c47d75e7d208e7bec9f@kernel.org>
 <20260706083636.159883-1-hupu@transsion.com>
In-Reply-To: <20260706083636.159883-1-hupu@transsion.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR04MB5648:EE_|TYZPR04MB7280:EE_
x-ms-office365-filtering-correlation-id: 577845f4-c3b8-4300-f356-08dedb39b905
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|3023799007|11063799006|4143699003|56012099006|6133799003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 xvKmnMF7I8eRKOdIWi5YEF8CQCKI9NU1qXg83jof0DPaTh8cTUYl55vre5lkktbgE3HoLsgB2aHI3mzeZFc9B9IHyWjgNGCMG9MT3TPn1F+jzuhQf5DOB35IYW3lfLw8K+YYkmxQOJhzqN0wfjrOZ8cbDQlL+uUd3rHgjxszzMr5i+iGX/e5RBAN3Adl6UOwdAp/rOXSnR23OuM8UJ2wy/hoJJH4RjZG4MSORwvUdTCpIqh5j9pWle7xm1lm2iMSwVx7ecyJoLi0x8zHDvZNeEojUktBIz/Jp42u1AkUNBGCUX3JiPOahkQo8B7IP2cx3nLEUryLpsL6h5jYb7C4BKdES7Xyx2m+wWXiTsITkHPNsMDWJ84Ea4Q/mEnl7SZOQyO5k1yzxy1BduhqhY4RML9OqWdiNbis+uzJ4IdoGyn1TIBu6HcBK76QOnrjp9aiA3oG5YE4hi5prqzHEANQt9ml7GLX7eq8wQkC4niZM7Bf7YfqZ07smyHbOB2JJ7vMJc9VzUgHurMbLAVjam/uW4KYTvR97ygonTM4oN6ThLMz4C3YQmEwmxlnks4u2XwK7awh/f1xePsBXdxWEjLH1KzfEtQIP/Gi6NgtuXpNjs+eSFAh/x+/vEiOhGqQ7BZ6FsujZvfyn3vPSWHoAuI/RaR57o4J4S2ncIb8cZvlcpg5/ZR4j9tTl5F+Ma8NDzWFuKJJrjEGx+IESL+xY6yqKwPU9Buur8vvJ96FkRVFedA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR04MB5648.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(3023799007)(11063799006)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MkhVWjFSSy9JWjR0OEh3elJyOFUzSFVWUWZqTDc3ck9KMXFTaklkczB3YXMw?=
 =?utf-8?B?ZUVzWEE0eCtJRnZhd2xSS0FzRTVDbG9ncFBmMXd3Z2s4ZkNacVE4ZmFxNThR?=
 =?utf-8?B?WG92dkRGemwwV2xkeUczUzV2K21oaHRzRThwdFRFVmpHK1pnemNFWDRxMVUy?=
 =?utf-8?B?K2JjMHovcUVvaVcwc0ZhVVFQOEZrb1JPQzZPdDdTZ0krdk9hWjloS3puNWhQ?=
 =?utf-8?B?dHFxdVBiM0pSSSt5amRRcmR1TWRkTGwvT1ZDUGxkNFhkclpXb2hTd2xvbFUw?=
 =?utf-8?B?WHBLWHlOMXV0QmZ5MWVqRE1FaElydUp3dlNDTWNva3EvaTA1enZJQU9vamIw?=
 =?utf-8?B?RyswSGd2cVR5cy91cVB4aXdtTEwrNlNCN2d4RVE4MHQzaGtIUktOOW10Vnlr?=
 =?utf-8?B?S29xd0JIc1FXQXBsUE4zVEZCN3Z1YXBzbjJ1Y2JUTjc1WmsyK0xzekxaaDIx?=
 =?utf-8?B?V3E4SEQxOCtrdVQxMHI0d25xbmN4dTIwVEk3VmJrSU5WZC9CSXRpbmdsYlk3?=
 =?utf-8?B?dFhnNEZaS3cxMzJKdi96eUZGNGdTR1hsU3BXWDZUdTRoeWFKY204dVc1R09n?=
 =?utf-8?B?cmpRenIxVG1HSm9ubkFESDYzQlBsb3ZNSUpHK2NKakVUb2xtdFZtZnNIejhU?=
 =?utf-8?B?SUlQNXdXR1lsNWgvdFpPSkIwNlpDSFdSMTZScktQaWVKTVRrbXBZQUZnUlU1?=
 =?utf-8?B?alJZM0p1cG5KcWkrcThlSUg0aXhDZXVmMXVuNmJ5NS9kQ0VHTGJQam1ISE5m?=
 =?utf-8?B?Sytsam1rL1hCS0RsN0MvZWU5dHBRY2FXMlRRVGRpTG5ObXhsWk1CYkxaTzlk?=
 =?utf-8?B?V3ZrWFRpTW5qanRrUEQvOTdoaVNCRHpKOHhPMUlMMTZXWVFrbDB5WHJ5Ly9X?=
 =?utf-8?B?bVBIbEtqNUprT2kvYWRqWDdSTFh3WjlqemRmd2FiK2NCWXJhRTFIMjZsSXBU?=
 =?utf-8?B?OC9EN3VPdEhjTW5LSUlOVitaVks4N0EyVytHWjdxTzJkSVVKazdlZXFRNUpP?=
 =?utf-8?B?bFlKUlVKRytHalBYUXVSYjQzRWRFUVY5ZTkrYm1WMkV2aGIwZGJUaE8zTkY4?=
 =?utf-8?B?VnJCdDBCNDhwTW8zbWpKZkpJZzV1TFdReW4xSHUyVXZxZFVmc2NNdFNBeFho?=
 =?utf-8?B?MFYvMy9nRzU5azE3SFBmM1VDQlBobnlhd3YyTkY0amh4VjYvNzdnRHpJZ3Vk?=
 =?utf-8?B?cjhxRkkxbFFVM2MrOFk3UEhNRXVaNGhlWFJ4blYrUU1uUmd6WHNKYS9SY29Z?=
 =?utf-8?B?RjZMWWliQ0Jmb0pLb0V6emw4ZHFpdmI3ODRTbkRqdmFLNlZLckFrTUhNaUdI?=
 =?utf-8?B?L0xqYkp6ZHpXV2txS1cwZkJ5SkQ5WUE3OUFkUGJNbzRackVPSFM3Zkg5R0tE?=
 =?utf-8?B?VG9Ya21lMFhkY2RGT0VlSUMwWGlyWEhoV1g3NmhzTTdHMk9HMkYyN0dCaEhN?=
 =?utf-8?B?Y1dUM0I5WVRsVWhjbGR4a21Pc3VCYSs5b3lxTndnYlNTaThkWjB2RDYyL29j?=
 =?utf-8?B?eGlJT2F1VmNTZnBIc2FtclEzRTVVaFdOVEc0eFNpd0Z1SHlGZ1dackJycWxu?=
 =?utf-8?B?OWt0M2JIYkZiMXYwYlhLMndNTXJEZVVpL040TkFOZHBCS0Zoem41SVdyb0pE?=
 =?utf-8?B?QithZDJjczdCamhUaWY5NjVGWSt6cEs3UzFOVUVhUytHalVyR0xUdWtPcC9n?=
 =?utf-8?B?Vy92ZWxmUTMzS2Z0Zmg3V0dOaExkSzZIZTFTRFZzWHBwU053cUNlbnJuR1Nr?=
 =?utf-8?B?M1FMT0EzVFBWY1QrcEFzeGZncWludU84bVhJWkUzL1JRWDY1Wm1jeTNwR2wv?=
 =?utf-8?B?L1pucnYwNGRFQmxqQ0Nsckh1U2xrRVZ4RXhRaGp5T3lmRG5pUGNHRk0yeUhr?=
 =?utf-8?B?MG84cHFnWFhHNXp2b2t6NE8xU1Q0Z2RMdEVKZDllMXFGZ2dwekZvbVkrM3Fz?=
 =?utf-8?B?OVVTWkQrRVRaWWMva2trdUg5WXc4YTBTeXgzWStuY0Z1ZVRGMHJRYmVXKytW?=
 =?utf-8?B?Rk9jMTZTcUdlUXZ2ODhzSkNOR2l6R0tlOXFJS3I0R1Z0U0ZhemdIKzNHZlFU?=
 =?utf-8?B?aUxtWGtjWGtYV2dTdHlSK0NrZnU5aDRjK3crVmRDQWFySE5xVEF1WU52d3c1?=
 =?utf-8?B?eVQvMUVOQnFYM3VaV0xJU2U4ZE5BRVplZE81NXZick13SWlZRWVqZEtVVjhu?=
 =?utf-8?B?NTVMOGVFeUd0aWw1enA3eXZkSjgyZUVETFdwUzArK1lmU3VDNUJLZ2FlRGUr?=
 =?utf-8?B?TEJTRmZyT1VOVitzYlFUM1FFbHFGVGt3Zk1pTG1UK3llS2lzVlpqZ1N1eVJO?=
 =?utf-8?Q?5WVIhtbyK3tMF51JnD?=
Content-Type: text/plain; charset="utf-8"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 577845f4-c3b8-4300-f356-08dedb39b905
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 08:36:49.6522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O+ypMQxqxaHHyMU95Q/dm6cA6kjcE/GYKw1fnZLRT44eQrAZqdNT1XKcWoLFsNSd9StSMYRgThX1RKzUU8lEFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB7280

RnJvbTogUHUgSHUgPGh1cHVAdHJhbnNzaW9uLmNvbT4KCkEga3Byb2JlIGNhbiBiZSBoaXQgd2hp
bGUgYW5vdGhlciBrcHJvYmUgaXMgaW4gS1BST0JFX0hJVF9TUyBzdGF0ZS4gVGhpcwpjYW4gaGFw
cGVuIHdoZW4gdHJhY2luZyBvciBwZXJmIGNvZGUgcnVucyBmcm9tIHRoZSBkZWJ1ZyBleGNlcHRp
b24gcGF0aAp3aGlsZSB0aGUgZmlyc3Qga3Byb2JlIGlzIHByZXBhcmluZyBvciBleGVjdXRpbmcg
aXRzIG91dC1vZi1saW5lCnNpbmdsZS1zdGVwIGluc3RydWN0aW9uLgoKQ3VycmVudGx5IGFybTY0
IHRyZWF0cyBhIGtwcm9iZSBoaXQgaW4gS1BST0JFX0hJVF9TUyBhcyB1bnJlY292ZXJhYmxlLAp0
aGUgc2FtZSBhcyBhIGhpdCBpbiBLUFJPQkVfUkVFTlRFUi4gVGhpcyBpcyB0b28gc3RyaWN0LiBB
IGhpdCBpbgpLUFJPQkVfSElUX1NTIGlzIHN0aWxsIGEgb25lLWxldmVsIHJlZW50cnkgYW5kIGNh
biBiZSBoYW5kbGVkIGJ5IHNhdmluZwp0aGUgY3VycmVudCBrcHJvYmUgc3RhdGUgYW5kIHNldHRp
bmcgdXAgc2luZ2xlLXN0ZXAgZm9yIHRoZSBuZXcgcHJvYmUsCmp1c3QgbGlrZSByZWVudHJ5IGZy
b20gS1BST0JFX0hJVF9BQ1RJVkUgb3IgS1BST0JFX0hJVF9TU0RPTkUuCgpUaGUgdHJ1bHkgdW5y
ZWNvdmVyYWJsZSBjYXNlIGlzIGhpdHRpbmcgYW5vdGhlciBrcHJvYmUgd2hpbGUgYWxyZWFkeSBp
bgpLUFJPQkVfUkVFTlRFUiwgYmVjYXVzZSB0aGUgcmVlbnRyeSBzYXZlIGFyZWEgaGFzIGFscmVh
ZHkgYmVlbiBjb25zdW1lZC4KCk1vdmUgS1BST0JFX0hJVF9TUyB0byB0aGUgcmVjb3ZlcmFibGUg
cmVlbnRyeSBjYXNlcyBhbmQgbGVhdmUKS1BST0JFX1JFRU5URVIgYXMgdGhlIHVucmVjb3ZlcmFi
bGUgbmVzdGVkIHJlZW50cnkgY2FzZS4KClRoaXMgbWlycm9ycyB0aGUgeDg2IGZpeCBpbiBjb21t
aXQgNmE1MDIyYTU2YWMzCigia3Byb2Jlcy94ODY6IEFsbG93IHRvIGhhbmRsZSByZWVudGVyZWQg
a3Byb2JlIG9uIHNpbmdsZS1zdGVwcGluZyIpLgoKU2lnbmVkLW9mZi1ieTogUHUgSHUgPGh1cHVA
dHJhbnNzaW9uLmNvbT4KU2lnbmVkLW9mZi1ieTogSG9uZ3lhbiBYaWEgPGhvbmd5YW4ueGlhQHRy
YW5zc2lvbi5jb20+Ci0tLQogYXJjaC9hcm02NC9rZXJuZWwvcHJvYmVzL2twcm9iZXMuYyB8IDgg
KysrKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkK
CmRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2tlcm5lbC9wcm9iZXMva3Byb2Jlcy5jIGIvYXJjaC9h
cm02NC9rZXJuZWwvcHJvYmVzL2twcm9iZXMuYwppbmRleCBlNGQyODUyY2UyZmIuLjc2NGIyMjI4
Y2NhMCAxMDA2NDQKLS0tIGEvYXJjaC9hcm02NC9rZXJuZWwvcHJvYmVzL2twcm9iZXMuYworKysg
Yi9hcmNoL2FybTY0L2tlcm5lbC9wcm9iZXMva3Byb2Jlcy5jCkBAIC0yNDAsMTAgKzI0MCwxNiBA
QCBzdGF0aWMgaW50IF9fa3Byb2JlcyByZWVudGVyX2twcm9iZShzdHJ1Y3Qga3Byb2JlICpwLAog
CXN3aXRjaCAoa2NiLT5rcHJvYmVfc3RhdHVzKSB7CiAJY2FzZSBLUFJPQkVfSElUX1NTRE9ORToK
IAljYXNlIEtQUk9CRV9ISVRfQUNUSVZFOgorCWNhc2UgS1BST0JFX0hJVF9TUzoKKwkJLyoKKwkJ
ICogQSBwcm9iZSBjYW4gYmUgaGl0IHdoaWxlIGFub3RoZXIga3Byb2JlIGlzIHByZXBhcmluZyBv
cgorCQkgKiBleGVjdXRpbmcgaXRzIFhPTCBzaW5nbGUtc3RlcCBpbnN0cnVjdGlvbi4gVGhpcyBp
cyBzdGlsbCBhCisJCSAqIHJlY292ZXJhYmxlIG9uZS1sZXZlbCByZWVudHJ5LCBzbyBoYW5kbGUg
aXQgaW4gdGhlIHNhbWUgd2F5IGFzCisJCSAqIHJlZW50cnkgZnJvbSBLUFJPQkVfSElUX0FDVElW
RSBvciBLUFJPQkVfSElUX1NTRE9ORS4KKwkJICovCiAJCWtwcm9iZXNfaW5jX25taXNzZWRfY291
bnQocCk7CiAJCXNldHVwX3NpbmdsZXN0ZXAocCwgcmVncywga2NiLCAxKTsKIAkJYnJlYWs7Ci0J
Y2FzZSBLUFJPQkVfSElUX1NTOgogCWNhc2UgS1BST0JFX1JFRU5URVI6CiAJCXByX3dhcm4oIkZh
aWxlZCB0byByZWNvdmVyIGZyb20gcmVlbnRlcmVkIGtwcm9iZXMuXG4iKTsKIAkJZHVtcF9rcHJv
YmUocCk7Ci0tIAoyLjQzLjAKCg==
