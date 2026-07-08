Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022131.outbound.protection.outlook.com [52.101.126.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B024137923;
	Wed,  8 Jul 2026 05:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783490254; cv=fail; b=h6zJMa12f3q3LZaHhi1OyK0qAGdpNpuKYRwxnurQpzmNkHbeuGrS6C1rTwU3dvcl1+4s0BHsIP9JV0y7ABtRFerBalQCvpP/3SYtE7os8c2nbb2bOlHf0SPmIc44RsM+mV/6M0hoAzEeqcr69KMP2SHRkTSpmGRKk3BrI/vege4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783490254; c=relaxed/simple;
	bh=wBiVOG59u2FCIj//3mEB8mbxRNS8zxXKHX7uksbwlgI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dw7pw457rzmjjZWnlQc6gwFh3gtjNu8Ndkzovx7HsuvtYOznqMilpOuJsQ78rn5Erj8A0xcYN7GhUmsprUd9+DYMwqo1HNP6Hb37HcmcFR2/n/TnH0SUivFoHBi5E+qYM7BHTZxcIJrhdTyf6HX6tPt+bwjGmkRVMcrpy6xm4sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com; spf=pass smtp.mailfrom=transsion.com; dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b=Ifxi+9xa; arc=fail smtp.client-ip=52.101.126.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=transsion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b="Ifxi+9xa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G4cJsdfN+EjCrdr4dP9M1BFwlKBCW0cz0MsMS5iZviWUjxesTjOUqc+nDsJPHPl9uXe1XydRwpwnQrE32Essh/gfCHDVt9jS6qd05RHYtWVt+4vqLrwc/hfzaVY+JJl1y6A+TBYUFHI9k576Kfq3jT7/FKsuHo4y0cIXsTO0VeS0d7w0CFN4vdkkQ0pV+vuB7Izrtq4Xxq/TY/LXb7XpI81kgdFRYtj/mKvWF5LO5LGRibO8SfVMS+WYciFNrU+NRwMDI/Qz3OTHQQemOiqe4ZK4a8brmtlZ3JElK6tSMf0GexDnn5Ntl+sa3slIDiEd9r7VP5643HtlyytxNszs/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBiVOG59u2FCIj//3mEB8mbxRNS8zxXKHX7uksbwlgI=;
 b=IPXxNCiKjd9QUG4pVKwBK6X78fV3i8ok6EBja+Tme+yxd3t6shmfzRdNZ4IMgqpx2K/97k/bcq+NkiyHa44Anh3TaZXWDR/hrs33CgUkxa1Sh3mz/k453cCzN4n1Vvx1PXGx7f3PnKEB5hEsgGYV838/qYCfhsVxYqKMBI4ieKgaQtX2EMmltE8jQYSAKLX08899dYtRXvb3Hqm8llnxcRS/f/V9ux6KpuJ0nBNvL4H4ieRMC5jtDY+HhOGB0UZoNqgL8k0z4pLmysWtlHxIlbLVgGF8uahaFPH20NzP0MLZF7iYAW4ctOw+nHHQtI409BqxYRgZ+QXTvxJTlaaHiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBiVOG59u2FCIj//3mEB8mbxRNS8zxXKHX7uksbwlgI=;
 b=Ifxi+9xaNVvQDhHKX2M2TLFiOlFfx1QicO38qEFSFY6ALwbWzkxLMSIhcksG/1Hg8FtFxBk0cLIJrlfWPYTj89vCRmosgwPn9XLfFT5hqccZIfw1mGXm13XKN/2ANwP2+PgFK4PnyZ0ID64tbgpkDAi6V56TptKlwoZ1wbfxq2o=
Received: from KL1PR0401MB6196.apcprd04.prod.outlook.com
 (2603:1096:820:c7::13) by KL1PR04MB6664.apcprd04.prod.outlook.com
 (2603:1096:820:df::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Wed, 8 Jul
 2026 05:57:27 +0000
Received: from KL1PR0401MB6196.apcprd04.prod.outlook.com
 ([fe80::f2ee:1e28:9022:99f3]) by KL1PR0401MB6196.apcprd04.prod.outlook.com
 ([fe80::f2ee:1e28:9022:99f3%3]) with mapi id 15.21.0181.010; Wed, 8 Jul 2026
 05:57:25 +0000
From: Hongyan Xia <hongyan.xia@transsion.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Pu Hu
	<hupu@transsion.com>
CC: "ada.coupriediaz@arm.com" <ada.coupriediaz@arm.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "davem@davemloft.net"
	<davem@davemloft.net>, Jiazi Li <jiazi.li@transsion.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>, "naveen@kernel.org"
	<naveen@kernel.org>, "will@kernel.org" <will@kernel.org>,
	"yang@os.amperecomputing.com" <yang@os.amperecomputing.com>
Subject: Re: [RFC 1/3] arm64: kprobes: Do not handle non-XOL faults as kprobe
 faults
Thread-Topic: [RFC 1/3] arm64: kprobes: Do not handle non-XOL faults as kprobe
 faults
Thread-Index: AQHdDSKWeYDuD+6wREWe1V8CS7jw5rZizCCAgABW2gA=
Date: Wed, 8 Jul 2026 05:57:24 +0000
Message-ID: <8cc07468-804e-4ee1-acad-77bc99af74c6@transsion.com>
References: <20260704234730.46d51c47d75e7d208e7bec9f@kernel.org>
 <20260706083636.159883-1-hupu@transsion.com>
 <20260706083636.159883-2-hupu@transsion.com>
 <20260708094623.9a1d40bed37bce3c7969ad20@kernel.org>
In-Reply-To: <20260708094623.9a1d40bed37bce3c7969ad20@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0401MB6196:EE_|KL1PR04MB6664:EE_
x-ms-office365-filtering-correlation-id: 7460c366-e4e1-4b13-a483-08dedcb5c8ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|4133799003|4143699003|56012099006|5023799004|11063799006|6133799003|22082099003|18002099003|38070700021|3023799007;
x-microsoft-antispam-message-info:
 mVT3IjSnmFRgGlWFUbd3jPqQcDn5VuPpVHuYH78b+fjJFIK6LRUEuySWpXly8Xk/nJs/flCwZOXmM7nzBvs/isVAr+/bt1CrMZCeH9ShFVTiMYLZS7WqT5P5GXQSk1gKfhy7gnqEiJl8xTMZKN3Slpb+Nk6z5l1RP9xGOIzyoeV5hYS2RAdKnvwVedFL/CNAlp4kAGx1wfNaaaBprXuSwSJfCYaCNCdmqv9vdDElaBHV3FbXHJnxVGekajRKfac4z3/bXnML74r3iu9cTz+GbF0/AX271mv2aRNNCuMWacMl3oqNO49WKEPSD0V9uHkXMadAcyH6fHd1HA9KecHqi24YrCMxj+oywevoWNjC8AY8war5Y9L16kucvcLtjCK/aoSTbT1V2sEgoZlKSNm2YcFDydKfvj85I7wOcNY/TWh6q1j+5dVAO7shJD5cSj5kVyXWQ4wzj1iSJhVtBChrfL5uWvf4AMIRB3ZholLzodYiW9TY0uppOKNK/NELjCZCX4dCQTyVVX0i6CE5wFfdZruhSlnFox/F7AJTLU2gQOxsMIwtLcPEd1NksmOYtpdCwnvR6RvZQHEy+ZkrU7QO/7rnHvqtbnCBE3CDoFguo5MDaWSPNLl9aX8TCjzo8RgcqPKTHfmpzqDxmwsOoTbHXEHL/1V4X6xrN1cSeWZ2pME=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0401MB6196.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(4133799003)(4143699003)(56012099006)(5023799004)(11063799006)(6133799003)(22082099003)(18002099003)(38070700021)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TGZYdE5OZW9sVTdCelowZ0ZGWnE5VHgwMFQzNXU3dVByTExyM1pORVE2aGF2?=
 =?utf-8?B?NVNvL3BvK2IwQzFBM1pQaU0weXh3MDlGK3VJTkR3MFQrblJqOUV2MkRuZEFI?=
 =?utf-8?B?bzNEcHZsZGZubmUvUWZvTG1XZmVxQnpneC9sQXZjVmhPdVFocU5oc2FJRnBn?=
 =?utf-8?B?a0xuN3FqUVZkNzB2R0Jwb0VyTm5jTUNzR3dadHA0ZE1aZGt1dkhkL2F1cElh?=
 =?utf-8?B?Yk5vSUFtVGNMdGZ6N0p6QWNJUDdWOUJEbkFOYzhVVWZJdUwxa2UvbXdzeVE4?=
 =?utf-8?B?T3JBcHR3dVJ4Sk1WYmlrSCtqSVQ3V05IVmw1MllNMndINmQwenh2UUFkSVAr?=
 =?utf-8?B?NEUrYlFQeEFCME9qK1RRRi9RbS9RdnpQRm5palhOK1IzRWlycWR0YzYwZGRJ?=
 =?utf-8?B?UURUS3NNbGRwWjVtNjFHZjE5Um1MSEdVTSs4SjlFdnp1WkF6VnNtMzRLS21S?=
 =?utf-8?B?dUZRT1BDdXZsTFl0SWRNRXRpeVpPLy9xSHdWRjJPdTVpMW4zOEE2NUVxY1lz?=
 =?utf-8?B?VHFZOHNBSzVoTHU3ZjRiaGxiV3hQbnArVWFNbjdkR25jemw5alpUbXB6SnV4?=
 =?utf-8?B?SjZsMS9Fc3Q0cnRRVGN5aW5MV2J2Sm12aHl6amNsbGxNbEFwaW5MMTRxOVBE?=
 =?utf-8?B?eFJaVnYyVFRKR1ZYNEpJakl5eDdyQmxncTIyMjNjV2o2SXYrSXkxcytSaXAv?=
 =?utf-8?B?UmpCb0lEYWVTbkdnSVJmdUtnWFMyZmxDakI2Zi9ta1VKZmMwZXk3ejZmYUk2?=
 =?utf-8?B?TEZaU01YYjhVUU5FUE9sKzJDN2wyYXJOazJoY0FDelowQWlsV2cyVmc4WmFp?=
 =?utf-8?B?MW12eDUvYk9Mb05yMGRYeE85QzZkNUVpMGE2Y255eWcxWjE5MmFHcmFkNVVt?=
 =?utf-8?B?RkdZY1lXQVpaVXdQMnh0cTJMWFJRUjZ0QzU1WHdLbStnbGlYa2N2QTMxQ2JL?=
 =?utf-8?B?Q0hPZDYwNG1acnc3TTRaVlVaWk1ScG11dXN0Vi9VSU9QQnZXYWVGRkJRRnE0?=
 =?utf-8?B?TmxUMy9ueGFmOVU4NXM3bHgwSjNQZzN1eC9CdW9PT1VTMFI1ZkEzR2xXZUpL?=
 =?utf-8?B?cXhheitOVDdsMXQ1aVNrbE05Rkl2bnBtczBKdVdINkp4TWlTd0hHYlFsQmdI?=
 =?utf-8?B?aERYOVVmRDJvYmNsUndodUt5ZEFtRkRmbU1vSkhUaWxxTEJnYlRqaG8xSlk0?=
 =?utf-8?B?RVNmV3ZSL0Y0dnVRbTh2eEZob0YyN0FVOXAvM2NadmVRRUtwQzN2RUpEN09x?=
 =?utf-8?B?Ly9nZmlpUkJZTWUrNDBiRTFIL1FxNmg3ZnRyTGxlR25VWUtkSDJMM001Y1lr?=
 =?utf-8?B?Y090TGZINUNzU3dqYS9lVWJOaFN4UVlpem1Hc2hNVWozVU5ENGhaMWFhZU1O?=
 =?utf-8?B?UUMvTkRZVFFLc2pLcXowOTNtbk04T2lCdnJteTcwZnZmY2k1TmdVZkYvaFFp?=
 =?utf-8?B?TTdRc1puRkRYbERhc1lOUXg3VXFmK2FIUHVIRWl4NGdBRWZ2RVEyZGFza25z?=
 =?utf-8?B?Q3FJcUc4eGYxbUk4eURCWTIvd0RGTEpSRTdlT09KdlliU0NsTk5ENUk4QVdw?=
 =?utf-8?B?SVltYXhGV1V3NGNQb2pCc3d3ckxMUDE3Q3JqVXV0WlJ3TXFJSmxwTUpOMDRS?=
 =?utf-8?B?WU1RdXpIZTBERmxIUDdKZzhiNDc5MVhHbW1aT3A5cW5Fa3Q0L1BXcDh1Rm1z?=
 =?utf-8?B?M0xVWE9vMmxwMjZ1eERILzhFNll6dmNLc3RoNHUyTjNzeDVoaXN6QXdFRlJV?=
 =?utf-8?B?ZFJkaWh0NWRacnRTQTdtV0hsUzhjd2xCYkRTZ0VpRGxTdnlJdzVseXRJZ3Vz?=
 =?utf-8?B?OEwwZUc4SGFyTVNNWGF1VjVEcUlNTlVwWnFQeGNyOVpEVHB1bUpKOHZsRHBz?=
 =?utf-8?B?U244NXlCVXNWaFhpUXBKUDFXc3dJcVhpdnR0SEE5NXA0aHM5akRVZ29GUWZa?=
 =?utf-8?B?TzV2NHZqTUZOdjZxUVVYandKTGFiUVh2Wi9lK0d5d0ZYeVRRNkZhcHNnMEJz?=
 =?utf-8?B?T2QwWWhEOEE2a01ocEI3eVplZVUzVWNVMzJ0SXFEcjgweGFhdjJDMHB2Si9q?=
 =?utf-8?B?b1pYSTlsdmNZVGNlOHRWd3h5NlFTSFFJbUF3ZVJVZlhhNUpDRnlnUXZGeVYy?=
 =?utf-8?B?NmZWNkx1ZVU2QldNK1hWU2gwU3dlZnBMdDFNdVBmREhpeml6RTlhaHlaVnln?=
 =?utf-8?B?VkdtWVdsZkl6RHIwdk5aQlFRWTBzeU9jZkU2d25ZWmFvMWMzcUJQWENCWkV1?=
 =?utf-8?B?Nkk3bVQ1Q0VqYkJGRnM2RmUwSnZQY09zMzNwZ3d0TUowemwxbExnVFFPQ3VO?=
 =?utf-8?B?QWg2Z0cvQWJnUkJ0WFlVMDdYbkV6NHRxQUxVRXRaakJkRGFVeXhuTUhuNFoy?=
 =?utf-8?Q?12xVmdaCr+QLOHW4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB9D949EBFD88847913732CF17BD6837@apcprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7460c366-e4e1-4b13-a483-08dedcb5c8ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 05:57:24.8830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2li/ysZp5hI8wSHYQraNOXfV+AvbDWNO6ouQbrU1U9DBjj+22SJ4ZIpNvzB5Jn6hwJHpfFg0ktx49woy2mqc7Rps8TZIW6PL1hQln8yV6Lk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB6664

SGkgTWFzYW1pLA0KDQpPbiA3LzgvMjAyNiA4OjQ2IEFNLCBNYXNhbWkgSGlyYW1hdHN1IHdyb3Rl
Og0KPiBPbiBNb24sIDYgSnVsIDIwMjYgMDg6MzY6NDggKzAwMDANCj4gUHUgSHUgPGh1cHVAdHJh
bnNzaW9uLmNvbT4gd3JvdGU6DQo+DQo+PiBGcm9tOiBQdSBIdSA8aHVwdUB0cmFuc3Npb24uY29t
Pg0KPj4NCj4+IGtwcm9iZV9mYXVsdF9oYW5kbGVyKCkgaGFuZGxlcyBmYXVsdHMgdGFrZW4gd2hp
bGUga3Byb2JlcyBpcyBpbg0KPj4gS1BST0JFX0hJVF9TUyBvciBLUFJPQkVfUkVFTlRFUiBzdGF0
ZSBhcyBmYXVsdHMgY2F1c2VkIGJ5IHRoZQ0KPj4gc2luZ2xlLXN0ZXBwZWQgaW5zdHJ1Y3Rpb24u
DQo+Pg0KPj4gVGhhdCBhc3N1bXB0aW9uIGlzIG5vdCBhbHdheXMgdHJ1ZS4gV2hpbGUgYSBrcHJv
YmUgaXMgcHJlcGFyaW5nIG9yDQo+PiBleGVjdXRpbmcgdGhlIG91dC1vZi1saW5lIHNpbmdsZS1z
dGVwIGluc3RydWN0aW9uLCBvdGhlciBjb2RlIG1heSBydW4NCj4+IGluIHRoYXQgd2luZG93LiBG
b3IgZXhhbXBsZSwgcGVyZiBvciB0cmFjZSBjb2RlIGNhbiBiZSBpbnZva2VkIGZyb20gdGhlDQo+
PiBkZWJ1ZyBleGNlcHRpb24gcGF0aCBhbmQgbWF5IHRha2UgYSBmYXVsdCBvZiBpdHMgb3duLiBJ
biB0aGF0IGNhc2UgdGhlDQo+PiBmYXVsdCBkaWQgbm90IGhhcHBlbiBvbiB0aGUga3Byb2JlIFhP
TCBpbnN0cnVjdGlvbiwgYnV0IHRoZSBrcHJvYmUgZmF1bHQNCj4+IGhhbmRsZXIgbWF5IHN0aWxs
IHRyeSB0byByZWNvdmVyIGl0IGFzIGEga3Byb2JlIHNpbmdsZS1zdGVwIGZhdWx0Lg0KPj4NCj4+
IFRoaXMgY2FuIGNvcnJ1cHQgdGhlIGV4Y2VwdGlvbiByZWNvdmVyeSBmbG93IGFuZCBsZWF2ZSB0
aGUgcmVhbCBmYXVsdCB0bw0KPj4gYmUgaGFuZGxlZCB3aXRoIGEgd3JvbmcgUEMuIEEgdHlwaWNh
bCByZXByb2R1Y2VyIGlzIHJ1bm5pbmcgc2ltcGxlcGVyZg0KPj4gd2l0aCBwcmVlbXB0aXJxIHRy
YWNlcG9pbnRzIGFuZCBkd2FyZiBjYWxsY2hhaW5zIHdoaWxlIGEga3Byb2JlIGlzDQo+PiBpbnN0
YWxsZWQgb24gYSBmcmVxdWVudGx5IGV4ZWN1dGVkIGtlcm5lbCBmdW5jdGlvbi4NCj4+DQo+PiBG
aXggdGhpcyBieSBoYW5kbGluZyBmYXVsdHMgaW4gS1BST0JFX0hJVF9TUy9LUFJPQkVfUkVFTlRF
UiBvbmx5IHdoZW4NCj4+IHRoZSBmYXVsdGluZyBQQyBwb2ludHMgYXQgdGhlIGN1cnJlbnQga3By
b2JlJ3MgWE9MIGluc3RydWN0aW9uLiBGYXVsdHMNCj4+IGZyb20gYW55IG90aGVyIFBDIGFyZSBs
ZWZ0IHRvIHRoZSBub3JtYWwgZmF1bHQgaGFuZGxpbmcgcGF0aC4NCj4+DQo+PiBUaGlzIGZvbGxv
d3MgdGhlIHNhbWUgaWRlYSBhcyB0aGUgeDg2IGZpeCBpbiBjb21taXQgNjM4MWMyNGNkNmQ1DQo+
PiAoImtwcm9iZXMveDg2OiBGaXggcGFnZS1mYXVsdCBoYW5kbGluZyBsb2dpYyIpLg0KPj4NCj4+
IFNpZ25lZC1vZmYtYnk6IFB1IEh1IDxodXB1QHRyYW5zc2lvbi5jb20+DQo+PiBTaWduZWQtb2Zm
LWJ5OiBIb25neWFuIFhpYSA8aG9uZ3lhbi54aWFAdHJhbnNzaW9uLmNvbT4NCj4+IC0tLQ0KPj4g
ICBhcmNoL2FybTY0L2tlcm5lbC9wcm9iZXMva3Byb2Jlcy5jIHwgMTQgKysrKysrKysrKysrKysN
Cj4+ICAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0
IGEvYXJjaC9hcm02NC9rZXJuZWwvcHJvYmVzL2twcm9iZXMuYyBiL2FyY2gvYXJtNjQva2VybmVs
L3Byb2Jlcy9rcHJvYmVzLmMNCj4+IGluZGV4IDQzYTAzNjFhOGJmMC4uZTRkMjg1MmNlMmZiIDEw
MDY0NA0KPj4gLS0tIGEvYXJjaC9hcm02NC9rZXJuZWwvcHJvYmVzL2twcm9iZXMuYw0KPj4gKysr
IGIvYXJjaC9hcm02NC9rZXJuZWwvcHJvYmVzL2twcm9iZXMuYw0KPj4gQEAgLTI4NSw2ICsyODUs
MjAgQEAgaW50IF9fa3Byb2JlcyBrcHJvYmVfZmF1bHRfaGFuZGxlcihzdHJ1Y3QgcHRfcmVncyAq
cmVncywgdW5zaWduZWQgaW50IGZzcikNCj4+ICAgICAgICBzd2l0Y2ggKGtjYi0+a3Byb2JlX3N0
YXR1cykgew0KPj4gICAgICAgIGNhc2UgS1BST0JFX0hJVF9TUzoNCj4+ICAgICAgICBjYXNlIEtQ
Uk9CRV9SRUVOVEVSOg0KPj4gKyAgICAgICAgICAgICAvKg0KPj4gKyAgICAgICAgICAgICAgKiBB
IGZhdWx0IHRha2VuIHdoaWxlIGEga3Byb2JlIGlzIHNpbmdsZS1zdGVwcGluZyBpcyBub3QNCj4+
ICsgICAgICAgICAgICAgICogbmVjZXNzYXJpbHkgY2F1c2VkIGJ5IHRoZSBpbnN0cnVjdGlvbiBp
biB0aGUgWE9MIHNsb3QuIEZvcg0KPj4gKyAgICAgICAgICAgICAgKiBleGFtcGxlLCB0cmFjaW5n
IG9yIHBlcmYgY29kZSBydW5uaW5nIGluIHRoaXMgd2luZG93IG1heSB0YWtlDQo+PiArICAgICAg
ICAgICAgICAqIGFuIHVucmVsYXRlZCBmYXVsdC4NCj4+ICsgICAgICAgICAgICAgICoNCj4+ICsg
ICAgICAgICAgICAgICogSGFuZGxlIHRoZSBmYXVsdCBoZXJlIG9ubHkgd2hlbiB0aGUgZmF1bHRp
bmcgUEMgaXMgdGhlIFhPTA0KPj4gKyAgICAgICAgICAgICAgKiBpbnN0cnVjdGlvbiBvZiB0aGUg
Y3VycmVudCBrcHJvYmUuIE90aGVyd2lzZSBsZXQgdGhlIG5vcm1hbA0KPj4gKyAgICAgICAgICAg
ICAgKiBmYXVsdCBoYW5kbGluZyBwYXRoIGRlYWwgd2l0aCBpdC4NCj4+ICsgICAgICAgICAgICAg
ICovDQo+PiArICAgICAgICAgICAgIGlmIChjdXItPmFpbnNuLnhvbF9pbnNuICYmDQo+PiArICAg
ICAgICAgICAgICAgICAgICAgaW5zdHJ1Y3Rpb25fcG9pbnRlcihyZWdzKSAhPSAodW5zaWduZWQg
bG9uZyljdXItPmFpbnNuLnhvbF9pbnNuKQ0KPj4gKyAgICAgICAgICAgICAgICAgICAgIGJyZWFr
Ow0KPg0KPiBDYW4geW91IGNoZWNrIFNhc2hpa28ncyBjb21tZW50c1sxXT8NCj4NCj4gWzFdIGh0
dHBzOi8vc2FzaGlrby5kZXYvIy9wYXRjaHNldC8yMDI2MDcwNjA4MzYzNi4xNTk4ODMtMS1odXB1
JTQwdHJhbnNzaW9uLmNvbT9wYXJ0PTENCj4NCj4gSXQgc2VlbXMgdGhhdCBpdCBjb21wbGFpbnMg
YWJvdXQgc2ltdWxhdGVkIGtwcm9iZSdzIGNhc2UuDQo+IEluIHRoYXQgY2FzZSwgY3VyLT5haW5z
bi54b2xfaW5zbiA9PSBOVUxMLiBUaGUgc2ltdWxhdGlvbiBzaG91bGQgYmUgZG9uZQ0KPiBpbiB0
aGUga3Byb2JlIGNvbnRleHQgKHdoaWNoIGlzIGEgZGVidWcgdHJhcCkuIEknbSBub3Qgc3VyZSB0
aGUgYXJtNjQNCj4gY2FuIGNhdXNlIE5NSSBpbiB0aGF0IGNvbnRleHQsIGJ1dCBpZiBpdCBoYXBw
ZW5zIGFuZCBjYXVzZXMgYSBmYXVsdCwNCj4gaXQgbWF5IGNhdXNlIGEgcHJvYmxlbS4NCj4NCj4g
U28gSSB0aGluayB3ZSBjYW4ganVzdCBpZ25vcmUgdGhlIGZhdWx0IG9uIHRoZSBzaW11bGF0ZWQg
a3Byb2Jlcy4NCj4NCj4gVG8gZW5zdXJlIHRoYXQsIHlvdSBjYW4ganVzdCBhZGQ6DQo+DQo+ICAg
ICAgICAgIGlmIChjdXIgJiYgIWN1ci0+YWluc24ueG9sX2luc24pDQo+ICAgICAgICAgICAgICAg
ICAgcmV0dXJuIDA7DQo+DQo+IGF0IHRoZSBlbnRyeSBvZiB0aGlzIGZ1bmN0aW9uLiAoYW5kIHJl
bW92ZSByZWR1bmRhbnQgY3VyLT5haW5zbi54b2xfaW5zbiBjaGVjaykNCg0KUmlnaHQsIGJvdGgg
Y2FzZXM6DQoNCjEuIHNpbmdsZS1zdGVwIFhPTA0KMi4gc2ltdWxhdGVkDQoNCmhhdmUgdGhpcyBw
cm9ibGVtIGFuZCB0aGlzIHBhdGNoIGZpeGVkIDEuIDIgcmVtYWlucyB1bmNoYW5nZWQuDQoNCklk
ZWFsbHkgd2Ugc2hvdWxkIGZpeCBib3RoLCBidXQgdGhlIHNpbXVsYXRlZCBjYXNlIHNlZW1zIG1v
cmUNCmNvbXBsaWNhdGVkLCBhbmQgYXQgbGVhc3Qgd2UgZGlkbid0IG1ha2UgdGhpbmdzIHdvcnNl
IGZvciAyLiBTbyBJIHdvbmRlcg0KaWYgd2UgY2FuIGFuYWx5emUgMiBtb3JlIHRob3JvdWdobHkg
YW5kIGZpeCBpdCBpbiBhIHNlcGFyYXRlIHBhdGNoLg0KDQo+IFRoYW5rIHlvdSwNCj4NCj4+ICsN
Cj4+ICAgICAgICAgICAgICAgIC8qDQo+PiAgICAgICAgICAgICAgICAgKiBXZSBhcmUgaGVyZSBi
ZWNhdXNlIHRoZSBpbnN0cnVjdGlvbiBiZWluZyBzaW5nbGUNCj4+ICAgICAgICAgICAgICAgICAq
IHN0ZXBwZWQgY2F1c2VkIGEgcGFnZSBmYXVsdC4gV2UgcmVzZXQgdGhlIGN1cnJlbnQNCj4+IC0t
DQo+PiAyLjQzLjANCj4+DQo+IC0tDQo+IE1hc2FtaSBIaXJhbWF0c3UgKEdvb2dsZSkgPG1oaXJh
bWF0QGtlcm5lbC5vcmc+DQoNCg==
