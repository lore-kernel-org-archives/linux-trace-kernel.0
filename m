Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023100.outbound.protection.outlook.com [40.107.44.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384043AB29D;
	Wed,  8 Jul 2026 08:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783500945; cv=fail; b=STOFAF+1mBj38MwFvhiGgApcHb8OlfM5xCpGkSmPhDny1iWeS0NQDsbw5Xnm+eE0+czSNx1xAy0OJd4TGpOkgZkEQuzQ6vWelNSzBJqJJeHLL8GuSx2jb//XKit02g0Ip0lRLWHkljkdFjyCKF34Z8cz+YlDVKCfwoNUWQoWWrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783500945; c=relaxed/simple;
	bh=+6Vt21AsOHlA83gCYarHWnf/dU9DGsvShFv44erfBJ4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=svVMiQudm7IenoCVFIl9QBndacQBv3Oe/HKWss6ot2a7nPpXJ/sg7xWYXQbr/4/WUmLDXNWNjHo40tK36u5o580+WeIIDCNdD9HDbPPuA4hEOZdjSrzEp1JMlmGBEx9e5WYUqFG0Wkkkg3Ppd0ntKJjL+PXpI4o5FUDLstsDLAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com; spf=pass smtp.mailfrom=transsion.com; dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b=vaZF7KCN; arc=fail smtp.client-ip=40.107.44.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=transsion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b="vaZF7KCN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tGYICAm9wfPRqTf7+3JqJiUI3+uO19TetyzuaFQK33fkBM4qoY6iQ+euDwc66PBb1Tv6sxFd9+g10qgEdWNCtuPf3hjIKIvBitb73F1FbZkpvXB540a3K6fC1lbUopOfhGOn4BecxS90LhPSwWPoKavoVODEyDc6pR0jB9naAKggv+xu7OZtatmT8Bgs+yv+Rfdx+l84HLmDhPXvZnJZlYYyxttWcBpIWoLmaRkOoGoaVjUKpHPZQju0/xggBsJVNfWR7RUCieGnqRM8iFEOZC42IB8473S/UqGJnqhKrLxGuhyrFHiZM6lobNl2JMFQbv59C7P6/i2j0+oCtWhMTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+6Vt21AsOHlA83gCYarHWnf/dU9DGsvShFv44erfBJ4=;
 b=eSDx6gpSyZxR/RPYMcp5ePtDHGH6XCi7VRlNiIZeOWmslT3JFY0X8BqZXPvPoffi5+Zt3GR25RYFuVoMPCzyLOz1K/iE8kei0qfMgfEeGCZvah7cAvPcrS8aHnPoDC/5awO2FWYuF2juUcMVcLcN9hAtLO4jQY0jNVVEhU2D1awpFn7dQfVsHY+qwZSZlCQC9vjqDC4XRo/HXGEsO1Fy4wxGkMhWPwBes5xwr/rHBPdEdZoi8U5sOT7xjcfbmXlUdmEgoydiFSPTzm6BOirLzKwqf490EbjH3v1B8gT59tdkr1fOh4vdePWarweFVUaxFHHmPnDUzkp2kS2mxci+vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6Vt21AsOHlA83gCYarHWnf/dU9DGsvShFv44erfBJ4=;
 b=vaZF7KCNOq4WFGWwxhDZlxliKsFAlPtBhSqGfMDxfw9xNwbtq8TB8zmo8YUZjuSQHQj45c2oD+8qHbvoyVJMRewUyRMjsu/uL2HtOmJnRMY0JObhOqaFUsHSlJgGrUuJOcWWevLlV9p6dDgfw7iYNjFcwiw4hsi9gR+N7YDLBo4=
Received: from KL1PR0401MB6196.apcprd04.prod.outlook.com
 (2603:1096:820:c7::13) by SEYPR04MB7025.apcprd04.prod.outlook.com
 (2603:1096:101:173::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 08:55:38 +0000
Received: from KL1PR0401MB6196.apcprd04.prod.outlook.com
 ([fe80::f2ee:1e28:9022:99f3]) by KL1PR0401MB6196.apcprd04.prod.outlook.com
 ([fe80::f2ee:1e28:9022:99f3%3]) with mapi id 15.21.0181.010; Wed, 8 Jul 2026
 08:55:37 +0000
From: Hongyan Xia <hongyan.xia@transsion.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
CC: Pu Hu <hupu@transsion.com>, "ada.coupriediaz@arm.com"
	<ada.coupriediaz@arm.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "davem@davemloft.net" <davem@davemloft.net>, Jiazi
 Li <jiazi.li@transsion.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>, "naveen@kernel.org"
	<naveen@kernel.org>, "will@kernel.org" <will@kernel.org>,
	"yang@os.amperecomputing.com" <yang@os.amperecomputing.com>
Subject: Re: [RFC 1/3] arm64: kprobes: Do not handle non-XOL faults as kprobe
 faults
Thread-Topic: [RFC 1/3] arm64: kprobes: Do not handle non-XOL faults as kprobe
 faults
Thread-Index: AQHdDSKWeYDuD+6wREWe1V8CS7jw5rZizCCAgABW2gCAAB1iAIAAFDgA
Date: Wed, 8 Jul 2026 08:55:37 +0000
Message-ID: <c33043c2-f931-4687-ad16-2d60ab12faca@transsion.com>
References: <20260704234730.46d51c47d75e7d208e7bec9f@kernel.org>
 <20260706083636.159883-1-hupu@transsion.com>
 <20260706083636.159883-2-hupu@transsion.com>
 <20260708094623.9a1d40bed37bce3c7969ad20@kernel.org>
 <8cc07468-804e-4ee1-acad-77bc99af74c6@transsion.com>
 <20260708164224.c080a1e834f02ac953007e5c@kernel.org>
In-Reply-To: <20260708164224.c080a1e834f02ac953007e5c@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0401MB6196:EE_|SEYPR04MB7025:EE_
x-ms-office365-filtering-correlation-id: f794989a-ba46-48b8-1e9f-08dedcceae3a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|23010399003|376014|1800799024|38070700021|6133799003|56012099006|4143699003|11063799006|5023799004|18002099003|22082099003|3023799007|4133799003;
x-microsoft-antispam-message-info:
 Zx1jqp+svofwpezqw5cmeMSKr8kMeJYMuFGjZwwO5SOCNqDR58DDDSRy2zkOtsRAlnCYW89JVYYPkgW5m12hMvwJYurAvs1RXdWVbJfiuQvp6hEEY3VPydn1PNe41NQsHd2U+ngEe5e1brZvmlIQLhSsc3xM6BECZ8khDrBmTJhD6YgEqhumWQ/UX4+ZTXmsY9S0DlHrHjcgWOlmsmSnbGlkqZ54DiFabD5xjHAI+GYL64s7JRH6l9iIalsOvhHdfWjsEkR1JDNvV071wEqv2Zx4/QO7lA7vjAY31iQVd4f1ZaqW6zxd6BmVxKF60urzGSXM1uis8R7rXUDQSU5vqbilqWdZ4r/sq/yxfR2IFelxLs1DWethxofMsGpLdLpE8AjRy3Da0RUkHgEK1TU+fUVtt8G0RPp4naRqT+ahrvFBASbeR0K9CIoXCe4FQk39dMs6K4uwodvwayz3e+WxNbrFZ/LEl6tdVjOf5M6Gi4I5O6wQrGfPcFa2p9YnOMVh85j+zxOJSEVjpFEVl6AMEF3XQ+BQ6UDfWnYlEFVQh5ACQoivTWoqo7JNIjU5Q87m67eOQ2n+Q9Yc59HrHU0eSeWoDHsdRHqVja9opdwhq/Xq9GDQz8frfn4jzVGWI9U8vYYj/PdhZ91U8r7Pjy/2ZdLePihDeZUvAGQcgVGVyOM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0401MB6196.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(23010399003)(376014)(1800799024)(38070700021)(6133799003)(56012099006)(4143699003)(11063799006)(5023799004)(18002099003)(22082099003)(3023799007)(4133799003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QXlubkNud0UvY09SVUdlNy9zalQzNGY3QmNtMnJJRmJlN21hZWxMbHd1bW1R?=
 =?utf-8?B?T0l2NGJaOThSMytpUjRCNzFBRkJCRnpVckRNWmJ1Y005Z1ZkQk53RlF0eERX?=
 =?utf-8?B?NWMzQlpRZXJTWUxtcVUvNzdKdWNUak1VQVNyd0Yvc29SUXNsUGJxVXd2OUVR?=
 =?utf-8?B?WEJxZlorL3pRN1RSaTRsbnovdHpwUWEwN1k0SVkzNkFpRWdOY3owbjVMTG5t?=
 =?utf-8?B?MGw5b056bGN1akE4dFp2VWtmZDB1UnFvTnViU1ZIeUdzWUFtNGtQVll1NTN3?=
 =?utf-8?B?TkdqbGMzcyt4K214UHdDa0lNeGhuOG8wZitiV2R1dURtRkpYWXZwdWdZSi80?=
 =?utf-8?B?aTZDK29VV3lQMklWQk1zYWV4eXhoMXNycHZPUG8rc2xZR0NEblI5NWNXQURl?=
 =?utf-8?B?Zmh2QjgyUUVZRmxzRHhpdXhKbjdJMEdYUlJucWJ5dEltQlIxMUtWYkZGNEV6?=
 =?utf-8?B?QWVVc3VLekZuK1hPRVpnOVRMMDFJbDR5ZWtybmJ6V2V3dzZ2ZldRb1ZWRllh?=
 =?utf-8?B?V3JyMEtNRU5jZmxqTFFWTWk2YnB4TEN0eTRrdFpUYlI1eWI5VkFkNU41aGIr?=
 =?utf-8?B?U0lGVytoTWpSdnllR3FYdGVCZFFWU0k3NFFOSHB3WDJZSlcvVG9HckZJUk9O?=
 =?utf-8?B?QzdXUFluR1ltQk96UGxMOGY2RkhyOHNLd0toanhheTF1N2lsVmdvdkNNSllE?=
 =?utf-8?B?OHd0dEdWUUx2Z2lid0hhdk0rSmFVNlMvMjQxTCsyYnpuOStHMkV1VlBkRkdM?=
 =?utf-8?B?M3lwcFlsK3UySUd1WW02Mmh3bnpscUlJU3RKMUtDYnh6WTdFRU9DM253UFgv?=
 =?utf-8?B?OWhWQ3NIdUQwMzdZNzFrd0ZUNVI1NGJtN0ZrOWtSd0piWEM2OC84K2xJUWNq?=
 =?utf-8?B?bk8yOHM0YUpyRHh4eERiYm12OUxOUGFETU9YOVN1dnB6U2drUGNaSlo4N2Zi?=
 =?utf-8?B?ajVVUjdOTTErZGdxbU5WOUp6YkZpaWp0NEx5bCszazJtWjBMeG5JVlNQbjdt?=
 =?utf-8?B?T1JkTElVVnFndjNVWXNkdDcwU3BIeE9SRXZRTW1SakRhOEVmQWxJRFJBL3Ra?=
 =?utf-8?B?aWdrNlBBRC9hTkFhQ09GRDlmRDREbGUrcUs4WVJtZFkzT1BWWXZSc1hyWDVB?=
 =?utf-8?B?OERQL1k3OXhlV2VsbmpxSmM5MmtqWk0wa25pbVNTamJUWGxuWCtramh6TkUr?=
 =?utf-8?B?eWt6LzlFZ05BV3p6MUtyWHJSeFI2TDhKcE4xWitXZm5CNVVubENOQUpweWRK?=
 =?utf-8?B?WGRMRDBkeitKak50WHBNQlBmY2RwK29GUmRSQmJkL3hPMGtYaHhxMlMwbG4x?=
 =?utf-8?B?K0w3Z0NmUHllSXdQb0hGa0hFRmdaNFpJazVPeWI5VC85NEtCOGsyNFlHMDI4?=
 =?utf-8?B?TEoyMWxQVU1NZGJIaEw0S0RPSHhROWZlTDdBSHZSSFppRXZNZXp2bkxYT0U2?=
 =?utf-8?B?d2lHUlJlbkNpMmhrbTVUQVpLTzkvOGpZOVFoSy81dDRCcFdkaS8zbldKQ1NC?=
 =?utf-8?B?NVRWVEJQUjdrVUdjK0s3dDRhdElHMk1NeC93N0FyL2c5eEladlYyN0lDQXJC?=
 =?utf-8?B?NEtDMVd0cFBYTU1BOHoranVRb3NHMUw3Rk5JVjQyUUZ4M3g3N01VdTZJUm9G?=
 =?utf-8?B?YXNlcldmRTFOeEhvQndPVGpIMUpoL1kvRXM4OGRiVXRFdHF0bnJWZ3kyaVho?=
 =?utf-8?B?QytIb1hxNjVUWjdKVnhJdE9TT01URHlXTEp3b041SnJ5WW44aGFKbnY4a3E1?=
 =?utf-8?B?WjBCalRIc0JsUGJoMk80N0g1ZVJweG01VDRNdUF6YWJZMWZ1UStRTnR1dXhu?=
 =?utf-8?B?ZDFHUTNPR0F6VDkxc1JaU1RTb2s5TTVVODVkSG9lcUF0VlNNY0t6KzBWMzhT?=
 =?utf-8?B?eVdMY3dSNWI4T2IxVHhPOUZkMW40RnZCSjFJaVZEemJ0L2dTVXczSHNmbnli?=
 =?utf-8?B?VTZYZ2FzZmdqMG1TQ2pkTXZ4M0VaYWdqSTJTYWdSdi9lOHJXV3hLbmE1VTFI?=
 =?utf-8?B?bWhNNzBJRGZJQ3FwaVVhRGU2YmlRYzkwZ1RqMkNoa0NZMUtzb0xJOU1nWnla?=
 =?utf-8?B?ZFBDVzcwbjFQaVN3cVJtbW1CeG5LWFE2YnNmMkwzcE9kYk1FL3FwdXlVT09V?=
 =?utf-8?B?Vm1UWnBqK1VYSlN5akhSOTFOMUpGTlFQcWZUZHpPZ1lwdmpJQ0FIT3lTT295?=
 =?utf-8?B?aS9uRjM5RytyWXZmNjFKQTloaTNVU3JQd25UN3orNzIwUHVPbHlBZWlxQ0Yz?=
 =?utf-8?B?bFB2Q29zRTl5dk1XSllOaWZ6cmorVUVQSVJtSlV2Qk9hODVER2dHZFR3VWgy?=
 =?utf-8?B?UTFva1NWcXVlUGFWZHBFR2RQL3MrdldTOXhxaXBoTEhLcjRDVFNBQWYvRURw?=
 =?utf-8?Q?AxT/ENBlcRKRB9es=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B273D7FD266A444AB004403AB1F99057@apcprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f794989a-ba46-48b8-1e9f-08dedcceae3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 08:55:37.7024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HdVFVedSRqkGqg14dBBRuWayfLLSrhXVvGoqPzxzQgb+R/tIfYUdp3qvWKBAr3zOjCIGx3Jr0Ouv1nag/rRGkScaEqeApSRQHkU4o2Eq+9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB7025

T24gNy84LzIwMjYgMzo0MiBQTSwgTWFzYW1pIEhpcmFtYXRzdSB3cm90ZToNCj4gT24gV2VkLCA4
IEp1bCAyMDI2IDA1OjU3OjI0ICswMDAwDQo+IEhvbmd5YW4gWGlhIDxob25neWFuLnhpYUB0cmFu
c3Npb24uY29tPiB3cm90ZToNCj4NCj4+IEhpIE1hc2FtaSwNCj4+DQo+PiBPbiA3LzgvMjAyNiA4
OjQ2IEFNLCBNYXNhbWkgSGlyYW1hdHN1IHdyb3RlOg0KPj4+IE9uIE1vbiwgNiBKdWwgMjAyNiAw
ODozNjo0OCArMDAwMA0KPj4+IFB1IEh1IDxodXB1QHRyYW5zc2lvbi5jb20+IHdyb3RlOg0KPj4+
DQo+Pj4+IEZyb206IFB1IEh1IDxodXB1QHRyYW5zc2lvbi5jb20+DQo+Pj4+DQo+Pj4+IGtwcm9i
ZV9mYXVsdF9oYW5kbGVyKCkgaGFuZGxlcyBmYXVsdHMgdGFrZW4gd2hpbGUga3Byb2JlcyBpcyBp
bg0KPj4+PiBLUFJPQkVfSElUX1NTIG9yIEtQUk9CRV9SRUVOVEVSIHN0YXRlIGFzIGZhdWx0cyBj
YXVzZWQgYnkgdGhlDQo+Pj4+IHNpbmdsZS1zdGVwcGVkIGluc3RydWN0aW9uLg0KPj4+Pg0KPj4+
PiBUaGF0IGFzc3VtcHRpb24gaXMgbm90IGFsd2F5cyB0cnVlLiBXaGlsZSBhIGtwcm9iZSBpcyBw
cmVwYXJpbmcgb3INCj4+Pj4gZXhlY3V0aW5nIHRoZSBvdXQtb2YtbGluZSBzaW5nbGUtc3RlcCBp
bnN0cnVjdGlvbiwgb3RoZXIgY29kZSBtYXkgcnVuDQo+Pj4+IGluIHRoYXQgd2luZG93LiBGb3Ig
ZXhhbXBsZSwgcGVyZiBvciB0cmFjZSBjb2RlIGNhbiBiZSBpbnZva2VkIGZyb20gdGhlDQo+Pj4+
IGRlYnVnIGV4Y2VwdGlvbiBwYXRoIGFuZCBtYXkgdGFrZSBhIGZhdWx0IG9mIGl0cyBvd24uIElu
IHRoYXQgY2FzZSB0aGUNCj4+Pj4gZmF1bHQgZGlkIG5vdCBoYXBwZW4gb24gdGhlIGtwcm9iZSBY
T0wgaW5zdHJ1Y3Rpb24sIGJ1dCB0aGUga3Byb2JlIGZhdWx0DQo+Pj4+IGhhbmRsZXIgbWF5IHN0
aWxsIHRyeSB0byByZWNvdmVyIGl0IGFzIGEga3Byb2JlIHNpbmdsZS1zdGVwIGZhdWx0Lg0KPj4+
Pg0KPj4+PiBUaGlzIGNhbiBjb3JydXB0IHRoZSBleGNlcHRpb24gcmVjb3ZlcnkgZmxvdyBhbmQg
bGVhdmUgdGhlIHJlYWwgZmF1bHQgdG8NCj4+Pj4gYmUgaGFuZGxlZCB3aXRoIGEgd3JvbmcgUEMu
IEEgdHlwaWNhbCByZXByb2R1Y2VyIGlzIHJ1bm5pbmcgc2ltcGxlcGVyZg0KPj4+PiB3aXRoIHBy
ZWVtcHRpcnEgdHJhY2Vwb2ludHMgYW5kIGR3YXJmIGNhbGxjaGFpbnMgd2hpbGUgYSBrcHJvYmUg
aXMNCj4+Pj4gaW5zdGFsbGVkIG9uIGEgZnJlcXVlbnRseSBleGVjdXRlZCBrZXJuZWwgZnVuY3Rp
b24uDQo+Pj4+DQo+Pj4+IEZpeCB0aGlzIGJ5IGhhbmRsaW5nIGZhdWx0cyBpbiBLUFJPQkVfSElU
X1NTL0tQUk9CRV9SRUVOVEVSIG9ubHkgd2hlbg0KPj4+PiB0aGUgZmF1bHRpbmcgUEMgcG9pbnRz
IGF0IHRoZSBjdXJyZW50IGtwcm9iZSdzIFhPTCBpbnN0cnVjdGlvbi4gRmF1bHRzDQo+Pj4+IGZy
b20gYW55IG90aGVyIFBDIGFyZSBsZWZ0IHRvIHRoZSBub3JtYWwgZmF1bHQgaGFuZGxpbmcgcGF0
aC4NCj4+Pj4NCj4+Pj4gVGhpcyBmb2xsb3dzIHRoZSBzYW1lIGlkZWEgYXMgdGhlIHg4NiBmaXgg
aW4gY29tbWl0IDYzODFjMjRjZDZkNQ0KPj4+PiAoImtwcm9iZXMveDg2OiBGaXggcGFnZS1mYXVs
dCBoYW5kbGluZyBsb2dpYyIpLg0KPj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBQdSBIdSA8aHVw
dUB0cmFuc3Npb24uY29tPg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBIb25neWFuIFhpYSA8aG9uZ3lh
bi54aWFAdHJhbnNzaW9uLmNvbT4NCj4+Pj4gLS0tDQo+Pj4+ICAgIGFyY2gvYXJtNjQva2VybmVs
L3Byb2Jlcy9rcHJvYmVzLmMgfCAxNCArKysrKysrKysrKysrKw0KPj4+PiAgICAxIGZpbGUgY2hh
bmdlZCwgMTQgaW5zZXJ0aW9ucygrKQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02
NC9rZXJuZWwvcHJvYmVzL2twcm9iZXMuYyBiL2FyY2gvYXJtNjQva2VybmVsL3Byb2Jlcy9rcHJv
YmVzLmMNCj4+Pj4gaW5kZXggNDNhMDM2MWE4YmYwLi5lNGQyODUyY2UyZmIgMTAwNjQ0DQo+Pj4+
IC0tLSBhL2FyY2gvYXJtNjQva2VybmVsL3Byb2Jlcy9rcHJvYmVzLmMNCj4+Pj4gKysrIGIvYXJj
aC9hcm02NC9rZXJuZWwvcHJvYmVzL2twcm9iZXMuYw0KPj4+PiBAQCAtMjg1LDYgKzI4NSwyMCBA
QCBpbnQgX19rcHJvYmVzIGtwcm9iZV9mYXVsdF9oYW5kbGVyKHN0cnVjdCBwdF9yZWdzICpyZWdz
LCB1bnNpZ25lZCBpbnQgZnNyKQ0KPj4+PiAgICAgICAgIHN3aXRjaCAoa2NiLT5rcHJvYmVfc3Rh
dHVzKSB7DQo+Pj4+ICAgICAgICAgY2FzZSBLUFJPQkVfSElUX1NTOg0KPj4+PiAgICAgICAgIGNh
c2UgS1BST0JFX1JFRU5URVI6DQo+Pj4+ICsgICAgICAgICAgICAgLyoNCj4+Pj4gKyAgICAgICAg
ICAgICAgKiBBIGZhdWx0IHRha2VuIHdoaWxlIGEga3Byb2JlIGlzIHNpbmdsZS1zdGVwcGluZyBp
cyBub3QNCj4+Pj4gKyAgICAgICAgICAgICAgKiBuZWNlc3NhcmlseSBjYXVzZWQgYnkgdGhlIGlu
c3RydWN0aW9uIGluIHRoZSBYT0wgc2xvdC4gRm9yDQo+Pj4+ICsgICAgICAgICAgICAgICogZXhh
bXBsZSwgdHJhY2luZyBvciBwZXJmIGNvZGUgcnVubmluZyBpbiB0aGlzIHdpbmRvdyBtYXkgdGFr
ZQ0KPj4+PiArICAgICAgICAgICAgICAqIGFuIHVucmVsYXRlZCBmYXVsdC4NCj4+Pj4gKyAgICAg
ICAgICAgICAgKg0KPj4+PiArICAgICAgICAgICAgICAqIEhhbmRsZSB0aGUgZmF1bHQgaGVyZSBv
bmx5IHdoZW4gdGhlIGZhdWx0aW5nIFBDIGlzIHRoZSBYT0wNCj4+Pj4gKyAgICAgICAgICAgICAg
KiBpbnN0cnVjdGlvbiBvZiB0aGUgY3VycmVudCBrcHJvYmUuIE90aGVyd2lzZSBsZXQgdGhlIG5v
cm1hbA0KPj4+PiArICAgICAgICAgICAgICAqIGZhdWx0IGhhbmRsaW5nIHBhdGggZGVhbCB3aXRo
IGl0Lg0KPj4+PiArICAgICAgICAgICAgICAqLw0KPj4+PiArICAgICAgICAgICAgIGlmIChjdXIt
PmFpbnNuLnhvbF9pbnNuICYmDQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICBpbnN0cnVjdGlv
bl9wb2ludGVyKHJlZ3MpICE9ICh1bnNpZ25lZCBsb25nKWN1ci0+YWluc24ueG9sX2luc24pDQo+
Pj4+ICsgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4+Pg0KPj4+IENhbiB5b3UgY2hlY2sg
U2FzaGlrbydzIGNvbW1lbnRzWzFdPw0KPj4+DQo+Pj4gWzFdIGh0dHBzOi8vc2FzaGlrby5kZXYv
Iy9wYXRjaHNldC8yMDI2MDcwNjA4MzYzNi4xNTk4ODMtMS1odXB1JTQwdHJhbnNzaW9uLmNvbT9w
YXJ0PTENCj4+Pg0KPj4+IEl0IHNlZW1zIHRoYXQgaXQgY29tcGxhaW5zIGFib3V0IHNpbXVsYXRl
ZCBrcHJvYmUncyBjYXNlLg0KPj4+IEluIHRoYXQgY2FzZSwgY3VyLT5haW5zbi54b2xfaW5zbiA9
PSBOVUxMLiBUaGUgc2ltdWxhdGlvbiBzaG91bGQgYmUgZG9uZQ0KPj4+IGluIHRoZSBrcHJvYmUg
Y29udGV4dCAod2hpY2ggaXMgYSBkZWJ1ZyB0cmFwKS4gSSdtIG5vdCBzdXJlIHRoZSBhcm02NA0K
Pj4+IGNhbiBjYXVzZSBOTUkgaW4gdGhhdCBjb250ZXh0LCBidXQgaWYgaXQgaGFwcGVucyBhbmQg
Y2F1c2VzIGEgZmF1bHQsDQo+Pj4gaXQgbWF5IGNhdXNlIGEgcHJvYmxlbS4NCj4+Pg0KPj4+IFNv
IEkgdGhpbmsgd2UgY2FuIGp1c3QgaWdub3JlIHRoZSBmYXVsdCBvbiB0aGUgc2ltdWxhdGVkIGtw
cm9iZXMuDQo+Pj4NCj4+PiBUbyBlbnN1cmUgdGhhdCwgeW91IGNhbiBqdXN0IGFkZDoNCj4+Pg0K
Pj4+ICAgICAgICAgICBpZiAoY3VyICYmICFjdXItPmFpbnNuLnhvbF9pbnNuKQ0KPj4+ICAgICAg
ICAgICAgICAgICAgIHJldHVybiAwOw0KPj4+DQo+Pj4gYXQgdGhlIGVudHJ5IG9mIHRoaXMgZnVu
Y3Rpb24uIChhbmQgcmVtb3ZlIHJlZHVuZGFudCBjdXItPmFpbnNuLnhvbF9pbnNuIGNoZWNrKQ0K
Pj4NCj4+IFJpZ2h0LCBib3RoIGNhc2VzOg0KPj4NCj4+IDEuIHNpbmdsZS1zdGVwIFhPTA0KPj4g
Mi4gc2ltdWxhdGVkDQo+Pg0KPj4gaGF2ZSB0aGlzIHByb2JsZW0gYW5kIHRoaXMgcGF0Y2ggZml4
ZWQgMS4gMiByZW1haW5zIHVuY2hhbmdlZC4NCj4+DQo+PiBJZGVhbGx5IHdlIHNob3VsZCBmaXgg
Ym90aCwgYnV0IHRoZSBzaW11bGF0ZWQgY2FzZSBzZWVtcyBtb3JlDQo+PiBjb21wbGljYXRlZCwg
YW5kIGF0IGxlYXN0IHdlIGRpZG4ndCBtYWtlIHRoaW5ncyB3b3JzZSBmb3IgMi4gU28gSSB3b25k
ZXINCj4+IGlmIHdlIGNhbiBhbmFseXplIDIgbW9yZSB0aG9yb3VnaGx5IGFuZCBmaXggaXQgaW4g
YSBzZXBhcmF0ZSBwYXRjaC4NCj4NCj4gT0ssIGJ1dCBiYXNpY2FsbHkgdGhpcyBmYXVsdCBoYW5k
bGVyIGlzIG9ubHkgZm9yIHRoZSBTUyBYT0wsDQo+IG5vdCBmb3Igc2ltdWxhdGVkIG9uZSAoYXMg
c2FtZSBhcyB4ODYpLiBTbyBqdXN0IHNraXAgdGhlDQo+IHNpbXVsYXRlZCBjYXNlIGlzIGVub3Vn
aCBpbiB0aGlzIHBhdGNoLg0KPiAoTm90ZSB0aGF0IHg4NiBhbHNvIGhhdmUgc2ltdWxhdGVkIHBh
dGgsIGFuZCB0aGF0IGlzIG5vdCBoYW5kbGVkDQo+IGJ5IHRoZSBmYXVsdCBoYW5kbGVyKQ0KDQpI
bW0sIHdoYXQgaGFwcGVucyBpZiB0aGUgb3JpZ2luYWwgUEMgaXMgYSBzaW11bGF0ZWQgaW5zdHJ1
Y3Rpb24gdGhhdCBoYXMNCmEgcmVjb3ZlcmFibGUgZXhfdGFibGUgZW50cnkgdGhhdCBoYW5kbGVz
IHBvdGVudGlhbCBwYWdlIGZhdWx0LCBhbmQgdGhpcw0KUEMgYWxzbyBoYXMgYW4gYXR0YWNoZWQg
a3Byb2JlPyBUaGVuIHRoZSBzaW11bGF0ZWQgY2FzZSBzaG91bGQgYmUgYWJsZQ0KdG8gZW50ZXIg
a3Byb2JlX2ZhdWx0X2hhbmRsZXIoKT8NCg0KLmV4X3RhYmxlOg0KICAgICAgICBpbnNuIGZvbywg
aGFuZGxlciBiYXINCg0KZm9vOg0KICAgICAgICBMRFIgc3ltYm9sICMgTG9hZCBQQy1yZWxhdGl2
ZS4gU2ltdWxhdGVkLiBLcHJvYmUgYXR0YWNoZWQuDQogICAgICAgIHJldA0KDQpXaGVuIGZvbyBp
cyBjYWxsZWQgYW5kIHRoZSBrcHJvYmUgZmlyZXMsIGl0IGVudGVycyBzaW11bGF0ZWQgcGF0aCBi
dXQNCnRoZW4gTERSIHRyaWdnZXJzIGEgcGFnZSBmYXVsdC4gSXQgdGhlbiBlbnRlcnMga3Byb2Jl
X2ZhdWx0X2hhbmRsZXIoKSB0bw0KZml4dXAgdGhlIFBDLiBUaGVuIHRoZSBmaXh1cF9leGNlcHRp
b24oKSBvZiB0aGUgbm9ybWFsIHBhZ2UgZmF1bHQgZmluZHMNCnRoZSBleF90YWJsZSBlbnRyeSBh
bmQgdGhpcyBjYXNlIGlzIHN1Y2Nlc3NmdWxseSBoYW5kbGVkPw0KDQpMb29rcyBsaWtlIHRoaXMg
aGFuZGxlciBjYW4gYmUgZW50ZXJlZCBieSBzaW11bGF0ZWQgaW5zdHJ1Y3Rpb25zPyBPcg0KdGhp
cyBpcyBvbmx5IHRoZW9yZXRpY2FsIGFuZCB3aG9ldmVyIGFycmFuZ2UgY29kZSBsaWtlIHRoaXMg
c2hvdWxkIGJlDQpmaXJlZCBpbW1lZGlhdGVseT8NCg0KPg0KPiBUaGFuayB5b3UsDQo+DQo+Pg0K
Pj4+IFRoYW5rIHlvdSwNCj4+Pg0KPj4+PiArDQo+Pj4+ICAgICAgICAgICAgICAgICAvKg0KPj4+
PiAgICAgICAgICAgICAgICAgICogV2UgYXJlIGhlcmUgYmVjYXVzZSB0aGUgaW5zdHJ1Y3Rpb24g
YmVpbmcgc2luZ2xlDQo+Pj4+ICAgICAgICAgICAgICAgICAgKiBzdGVwcGVkIGNhdXNlZCBhIHBh
Z2UgZmF1bHQuIFdlIHJlc2V0IHRoZSBjdXJyZW50DQo+Pj4+IC0tDQo+Pj4+IDIuNDMuMA0KPj4+
Pg0KPj4+IC0tDQo+Pj4gTWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKSA8bWhpcmFtYXRAa2VybmVs
Lm9yZz4NCj4+DQo+DQo+DQoNCg==
