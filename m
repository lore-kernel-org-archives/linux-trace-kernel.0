Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022125.outbound.protection.outlook.com [52.101.126.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1C42E8DEC;
	Tue, 28 Jul 2026 02:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785204220; cv=fail; b=dtn8uv2v4MCXuo/cYAv5J0s6/+qh3AiWeLnTYRszOSgtnYvjkKrNby7NvJr9AUrHrwyJzaUMTRRjJSGkGHsOZcFwqIXRiK7bjdr/WfDEY4FcO0wVjHmlYf+fZubi9j/8PYcnaBVr1JLgG/W7tvPCNeKp/+1BHo8wjYl0cWv4Z0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785204220; c=relaxed/simple;
	bh=5QXqv47OcFSVhhb3ld5qD42PCvPkJu1cY86UID8FXuI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LCDwlQhb4TaEc14kzqdT2/4nYgdn1lFen2kbIVjJffmCrlSaFszMnkud2CoiyQTLbGH55zwvoS/EjSBW/Pye0zQpbSMGQpJ4PTjYuGLJ/aXxAZplQJXN4lSz8aq1fRinm/uCkub5EsPSOnvzF3dfyYpkxp79+7dZjhuPRdOPCr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com; spf=pass smtp.mailfrom=transsion.com; dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b=DP7dBjPF; arc=fail smtp.client-ip=52.101.126.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=transsion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b="DP7dBjPF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hf1pC8gR511j2IOTqDT57gkYCodQOe/f8vHHw5y460wA7vOc1CvfBHjQw3m55X0B/kwrZgTht4VeUG9m4g8L4IswemfkpYeqdB/ARje+HFW+D83ra/iADc4An/hrG8TuChJeLwEuadjUYykRmdDihatiS0t2Zh+n6hkmRsJGagu+pBwZpC+gu5n55znqPVoTK2rCBg+2FI9HObyKw60Nv3y60DRdhSOTEGN8tNb6/neQ0+waS8PwWnkgg6yyTDSgNCfpF/+zJVRbXAg6KiP3qeXDKKkk099rKLKI2TLwVW2aOfSdYKXQQDPocTZkgh/BraRpjbf29BsxRZ0LG4UjPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5QXqv47OcFSVhhb3ld5qD42PCvPkJu1cY86UID8FXuI=;
 b=xP6hWtqWn3gzAH97PHbuZZUqL3q28SQr1emw1lY2aMy7zWCyUORAv+yCowYq8DEE94h2gZPDf/fo4O22izZMP6xUq2XU2T2noD6eQ8vbOWfM2iF852gUrk7uL/XPFDxOk2h7RoyOlDcRw6a72C32SMDrLN1LYfBASzJ5OVQeKJLqOaWv3PD56iqPUzULMYv8VNw1/N1fI/B9wylfVnltJUjtszh+VOmAXKCwIlYh+cVEgkc//r7a+0VUDdUx7L2c7Pt0oWufeuvXipgqvGSUOo1uTJYlB2rpNNthG++tHUySg8e2BhT/XBzRaFePtAYoeL0Lm2ySFdkJEGfLzOYD7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QXqv47OcFSVhhb3ld5qD42PCvPkJu1cY86UID8FXuI=;
 b=DP7dBjPFtM9DeAd5JJUTXQvEnN1V2zcYe8+nnF++OwiylkQqAg7bamOFBWT+pzysrG/CesmHa4rA45EffrOw87+FZw4d5HgOOkKpcnbRtD7B5Hv6LSLc9G6A3RkjKDa90OjC8whF5C9aEQ5+gfKTKqrR8chw5sVMy0mOpf6B6eA=
Received: from KL1PR0401MB6196.apcprd04.prod.outlook.com
 (2603:1096:820:c7::13) by KL1PR0401MB6228.apcprd04.prod.outlook.com
 (2603:1096:820:9b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 02:03:34 +0000
Received: from KL1PR0401MB6196.apcprd04.prod.outlook.com
 ([fe80::f2ee:1e28:9022:99f3]) by KL1PR0401MB6196.apcprd04.prod.outlook.com
 ([fe80::f2ee:1e28:9022:99f3%3]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 02:03:33 +0000
From: Hongyan Xia <hongyan.xia@transsion.com>
To: Nick Desaulniers <ndesaulniers@google.com>
CC: Will Deacon <will@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>, Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, Oleg Nesterov
	<oleg@redhat.com>, Naveen N Rao <naveen@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Nathan Chancellor <nathan@kernel.org>, Bill Wendling
	<morbo@google.com>, Justin Stitt <justinstitt@google.com>, Jiazi Li
	<jiazi.li@transsion.com>, Pu Hu <hupu@transsion.com>,
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
Thread-Index: AQHdHcMO39AcF/TaiUWqS0RapTlJlbaBvwQAgABv3wA=
Date: Tue, 28 Jul 2026 02:03:33 +0000
Message-ID: <fc1ca700-64f1-4edd-bf44-44c0d3e422a7@transsion.com>
References: <cover.1785153469.git.hongyan.xia@transsion.com>
 <eb38b41ae1b3216ec69fb45555ef5df57efd7b8d.1785153469.git.hongyan.xia@transsion.com>
 <CAKwvOd=HeG=z1j2qB-SX3NQ=62ERr=KpQNZyqqp2Qy4kZ54RLw@mail.gmail.com>
In-Reply-To:
 <CAKwvOd=HeG=z1j2qB-SX3NQ=62ERr=KpQNZyqqp2Qy4kZ54RLw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0401MB6196:EE_|KL1PR0401MB6228:EE_
x-ms-office365-filtering-correlation-id: 9a57573a-6168-4299-3c64-08deec4c6db8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|23010399003|376014|1800799024|38070700021|6133799003|5023799004|11063799006|56012099006|4143699003|10067099003|4133799003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 M2RERLvF36NcqliEvbIELJ+QQnTaR9nIKm2qcMKnCQrTykne4/MCKTKwjEKwU82ZcUpF4kOpPXdIX1Z6Pnik9sVtquQcNltZ7XagJe55Ehcl4FaI9K6soHxlx5hbuc5675zbD+Z3CVaMY739zOsu2fifg4NchmGgVyp6hc5aC7Jd53dAT/sU39TJz6om25fW0ilkYVUComDmVBpwKnaJsoTlpvTiIX2LONt6Sr+9i+Ik3b8pYgrMon2k6U6WS2QgYK0QbZcGyBh1aTglfUTfy/thrtULvbN6Tt8L0wqsH/i9aswTNZRwdiOztDc8OO/w/Ztwxce5rjDmwj7cMMpWQs39gR6Mk5gbCjarrFuk0V/5PsFpDTl6UC8bWDqZOLE5/93ITAz5S9jCVNwm/ik0vlgOTWRAwtg5/X9svFu6Fuw9G2WzHYePf9ivjXbUcn3Y+JiVbbdL34SOM/s1GfNp5ilU24bEJ7ln82ZsUJCDa26DWcDoXRW8rk6rhvpfAypTdTwKiPEFk6IZlbNdik2BMvJIgVebUwN8S9mJTSv9aao9mQBGSFR2fywR/IwtwBt9yRs+zZfeHTGr87c20dznV1cDZ6ag/0GTZkFJG+8E2hrTxT707pbBRO4exSg2uQzbsy7GGTwwQKU+idzPft7QGuhSU+/ilw9U5BtyG7c1m8rfxr20D4zpBnhk6RkvfSXl8XiqmeCG/vEKq75E2RBLXCpm/4N7XuwrUMIMYx3I/aM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0401MB6196.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(23010399003)(376014)(1800799024)(38070700021)(6133799003)(5023799004)(11063799006)(56012099006)(4143699003)(10067099003)(4133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aFB1cThsVE1XOEpmanBFUE9nU2FaWnZqem82NTBMcmVIWTRsWWxVV0JzcHNn?=
 =?utf-8?B?QzVMRTBaOCtrbkR2UVRSSTFpem9MaGd2WjdOREpOMFpvaHIwNnFDbUhJbmdM?=
 =?utf-8?B?STljQ0pPNUM2ZTAwVUxrcWg5QThBampKQlJnQm5zMURNRTVzbnZNSHdnREc4?=
 =?utf-8?B?L1ZsZjVyWW1ubjZxWVpSekJJYjkvMSthb2QwdDNvMVlZRjBFTkp2dndmY2dJ?=
 =?utf-8?B?MC82SWtDSHpiQXZQcC8xSFBJTDIxWVZXdjF2dU5RL1hWWXhOUmhMRmFKa3lC?=
 =?utf-8?B?aW1YTHJ2WUZ5aStzemlIaEUvMGN0QXZPMnJiNlBaVFlqbE1yaWtMOXFDcytN?=
 =?utf-8?B?bVhSMkJkQi9VYXpIU2NUR2RhR0VLOTVHbkE1dFFUYzdvbUJ5bWdPYUFDaStX?=
 =?utf-8?B?Sk9PSGg2c052YTRqdXlXSGhIZm1tY0pZT25nL0NieCs3V2xCNnhHejUvTGV2?=
 =?utf-8?B?aloyZGxJWXFjWklkZ0Vad1pxSGFVYi9iUW84dXlGdDFsR1dMQlRYN2FHVEtN?=
 =?utf-8?B?SDhxcmFTUnFWWXFsQmlicWU4ZVQzdjBSWTZ2VkxId3hNdkVIK3Q0ZXBQQUQ2?=
 =?utf-8?B?VEFmcXRvLzIrSUw3UEk5YUVoVFMvS1JHeTVsd29BT0traXZ1Z29HVk0yazQ2?=
 =?utf-8?B?Y0J2ZThQS3B3MzBBNnNzOXFtbTBFdTJFcTZsWDFBNTJtbTZpWnlqWkx2MDdO?=
 =?utf-8?B?WUV6aG43TG1IL0c4M05URm1ia29XdC9rNFd1QnI3aG44VVp0TFdyeVBnNVBs?=
 =?utf-8?B?eXVKN3NvZllxNzY2eDR2V2p3VWYxS1krNTkzVGxQS0g4Ny9zNm5tcHkyU0hT?=
 =?utf-8?B?SnJXSkNMcWY2ditLTnQ4S2ZZOXBJUTNpWGRteGhNM1hmckZOTDZzaEpNdjV3?=
 =?utf-8?B?TEppTEs1ZFhneU9BUnRHZ0ZBVnZ0RFF0UTFKVXo3ZnZSL0x5czl5bzRBbVlJ?=
 =?utf-8?B?QUxUb1BvL3grdXlMWFFXbEF2eTZDOEtLcFhuMllOaWwzSmQ4ZEU0Q3k0b0J6?=
 =?utf-8?B?WVlHRlFjWUNLVzlrVE9YMXFIbTJGbzluS001QUJ5RVJ2bCtOYlpjK0dZWnNL?=
 =?utf-8?B?eVo3WUZtaGE5Y2xmdEVRVEQ3L1kweTFUa3VpT21NSm1yQlpTTFZ3REdZWE1q?=
 =?utf-8?B?QWRqRkZVWTRPNVpZZ3plcHJQempwUllnNE0xcDVOVWdqSnc2TVdxWXZ5UExr?=
 =?utf-8?B?TXJ3OFl1Z1ZaRU9LWGl6TCtJeExsekpvUS9nUCs3bzI2eHlnNUhnMVBlNGt3?=
 =?utf-8?B?Nm03b2V1WDhoS1pCcENCTFk1SkluNnI4d0VTZm5YdU5Tcy9Jem40NzVhUzVz?=
 =?utf-8?B?cHZqMGhZZDFQL0tDcmlDT1RqbHR5UEJac2JSNUpiM2xGMmpvNXpiZGJCZEZ5?=
 =?utf-8?B?cXlGYkxDNm1zbW1zb3oycHBJdTNJeHBzMHZ3eVpKc202Ukt1NVVNY2hIL0ln?=
 =?utf-8?B?T2hRbVd3NEdkZG1QSWZGbGdYSmwzdEV5VHdyck1FSFBSZFVyQkhEZ292Ymlo?=
 =?utf-8?B?TzFpbU1jYkY4dzZFNXBCMEg2eHBIeDFvcldadHhlaGJWemV6aUt0RXBtV2x0?=
 =?utf-8?B?QTRCNmtUd2daVXBXYmxzNVp0bi9palUwTW5ZQno4QXBoc0orbEdXQ3hHUlJC?=
 =?utf-8?B?T2ZvZGpyOHRROGN4SVYzaFhWNjdTTmcvTVpHelVPb3gyZzNzVGdPbmkvV2Y5?=
 =?utf-8?B?S1Nma2Z6TUdsdnRZdE5zeEpFYUY0MExhN1EybkRBSm5YZTZ3SGpKK0pSa3NQ?=
 =?utf-8?B?K3RGVnZZcFNmUlFrbXNyTVpSVXcrR3ZiUHJHQUdFNkhaM2JTR1hlY3hNU2U0?=
 =?utf-8?B?UnRVcm5rTlM1UVRmMDVhaXVzSndRcHErYitxWjkrYXFKOWxXQXlKYitjQ0Jz?=
 =?utf-8?B?OGM1Mmk1VzhOTWxWa3ZnN1l0YXl1WGZjSThnTjNzblErY0wvZ3ZqZnJnSklw?=
 =?utf-8?B?RkovMWhUbzBVVVhsUWY1RGJnQlFQWXcxc2dDVjlrQ0RnMzZkVXFDaEdnMjFI?=
 =?utf-8?B?WVRzN1pUd2ZqZGtRSVRRNFM2UkZrdjFseWlmZkZidS9CTmcrM1psTlNIenJ1?=
 =?utf-8?B?T3l6aExsR0NWNFZFN0xSUzVqaEQ2QUF0aU5EWWc2bWpNNzBUQy9IWThxckpp?=
 =?utf-8?B?K3pKVm11cGxpOHhkM0c3dlZaMjVoaE92b1ZsY1NOQzNuMk5lZ0dXWjFjQWNr?=
 =?utf-8?B?OUNXRTRTVjhEQ0VRaVFuem8zc2l6eUd0MU96ZGZEZ0hMUWpXWXpxNWxLQUMr?=
 =?utf-8?B?S2tsQm81cWRBVFZWWXFXRExTOE1NUkg3cWc1MzVuWWVuUklXbTluZERISFQ5?=
 =?utf-8?B?QU52ejd4aUdUZDV0dnFKdUdpNFNpSWRaK1ZBUVQ1RzhPVFZkbm5QUGJhd0M5?=
 =?utf-8?Q?uTfm4cfHLwOhEMPc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D1B5343B2466A40BF7F09CC80402663@apcprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a57573a-6168-4299-3c64-08deec4c6db8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2026 02:03:33.5142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MGdWo1cy1G0yhsjWrBUH3rWyvat8HqIFd8nP9/2BWDfo2v/lyglBOjfY5cCWqNFoE8s/TgZbxKIP3DBxMR5evqoKJzQ+2xp/MkTbFHNAmEo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0401MB6228

T24gNy8yOC8yMDI2IDM6MjIgQU0sIE5pY2sgRGVzYXVsbmllcnMgd3JvdGU6DQo+IE9uIE1vbiwg
SnVsIDI3LCAyMDI2IGF0IDU6MjXigK9BTSBIb25neWFuIFhpYSA8aG9uZ3lhbi54aWFAdHJhbnNz
aW9uLmNvbT4gd3JvdGU6DQo+Pg0KPj4gRnJvbTogSG9uZ3lhbiBYaWEgPGhvbmd5YW4ueGlhQHRy
YW5zc2lvbi5jb20+DQo+Pg0KPj4gU3RhdGljIGlubGluZSBzaG91bGQgYmUgZW5vdWdoIHRvIGFj
dHVhbGx5IGlubGluZSBmdW5jdGlvbnMgZm9yIG1vc3QNCj4+IGNvbXBpbGVycywgYnV0IG15IENs
YW5nLTE5IHNvbWVob3cgdGhpbmtzIGl0J3MgYmV0dGVyIHRvIG91dGxpbmUgdGhlbS4NCj4+IFRo
ZXNlIHRpbnkgaGVscGVycyB0aGVuIGxpdmUgaW4gbm9ybWFsIC50ZXh0IHNlY3Rpb25zIGluc3Rl
YWQgb2YNCj4+IC5ub2luc3RyIHNlY3Rpb25zLCB2aW9sYXRpbmcgbm9pbnN0ci4NCj4NCj4gQW55
dGhpbmcgc3BlY2lhbCBhYm91dCB5b3VyIGJ1aWxkIG9yIGNvbmZpZz8gIEZvciBleGFtcGxlLCB3
ZSd2ZSBzZWVuDQo+IGEgcmVjZW50IGluZmx1eCBvZiBidWdzIGFyb3VuZCBBdXRvRkRPIG5vdCBp
bmxpbmluZyBmdW5jdGlvbnMgKGRlc3BpdGUNCj4gY29uc3RhbnQgcHJvcGFnYXRpbmcgaW5pdGRh
dGEgY29uc3RhbnRzIGludG8gdGhlbSkgbGVhZGluZyB0byBtb2Rwb3N0DQo+IGVycm9ycy4NCg0K
SSBkb3VidCB0aGVyZSdzIGFueXRoaW5nIHNwZWNpYWwuIFRoZSBjb21waWxlciBpcyBEZWJpYW4g
Y2xhbmcgdmVyc2lvbg0KMTkuMS43ICgzK2IxKSBpbnN0YWxsZWQgdGhyb3VnaCBhcHQgaW5zdGFs
bCBpbiB2YW5pbGxhIHg4Nl82NCBEZWJpYW4NClRyaXhpZSwgY29tcGlsZWQgd2l0aCAnbWFrZSBM
TFZNPTEgQVJDSD1hcm02NCBJbWFnZScuDQoNCj4gQ2FuIHlvdSBwZXJoYXBzIHNoYXJlIHlvdXIg
Y29uZmlnIHNvIHRoYXQgc29tZW9uZSBlbHNlIGNvdWxkIHJlcHJvIGFuZA0KPiB0YWtlIGEgbG9v
az8NCg0KU3VyZS4gTm90IHN1cmUgaG93IEkgY2FuIHNoYXJlIHRoZSBnaWFudCBjb25maWcgd2l0
aG91dCBib21iYXJkaW5nIGFsbA0KdGhlIHJlY2lwaWVudHMuIExldCBtZSBqdXN0IHNlbmQgdG8g
eW91IHByaXZhdGVseSBmaXJzdC4NCg0KPiBIYXBweSB0byBmb2xsb3cgdXAgaW4gb3VyIGlzc3Vl
IHRyYWNrZXIsIHRvby4NCj4gaHR0cHM6Ly9naXRodWIuY29tL0NsYW5nQnVpbHRMaW51eC9saW51
eC9pc3N1ZXMNCj4NCj4+DQo+PiBNYXJrIHRoZW0gX19hbHdheXNfaW5saW5lIHNvIHRoZSBjb21w
aWxlciBjYW4gbmV2ZXIgb3V0bGluZSB0aGVtLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEhvbmd5
YW4gWGlhIDxob25neWFuLnhpYUB0cmFuc3Npb24uY29tPg0KPj4gLS0tDQo+PiAgIGFyY2gvYXJt
NjQvaW5jbHVkZS9hc20vZXNyLmggICAgICAgfCAyICstDQo+PiAgIGFyY2gvYXJtNjQvaW5jbHVk
ZS9hc20vcGVyY3B1LmggICAgfCAyICstDQo+PiAgIGFyY2gvYXJtNjQvaW5jbHVkZS9hc20vcHJl
ZW1wdC5oICAgfCA0ICsrLS0NCj4+ICAgYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9wdHJhY2UuaCAg
ICB8IDQgKystLQ0KPj4gICBhcmNoL2FybTY0L2tlcm5lbC9kZWJ1Zy1tb25pdG9ycy5jIHwgMiAr
LQ0KPj4gICBpbmNsdWRlL2xpbnV4L2twcm9iZXMuaCAgICAgICAgICAgIHwgOCArKysrLS0tLQ0K
Pg0KPiBJdCBtaWdodCBub3QgYmUgYXBwcm9wcmlhdGUgZm9yIHRoZSBjaGFuZ2VzIHRvIGtwcm9i
ZXMuaCB0byBnbyB0aHJvdWdoDQo+IHRoZSBhcm02NCB0cmVlLCBidXQgbWF5YmUgaXQgaXM/DQoN
Ckkgc2VlIFdpbGwgaGFzIHJlcGxpZWQsIHNvIHRoaXMgbWlnaHQgYmUgYSBxdWVzdGlvbiBmb3Ig
S3Byb2JlDQptYWludGFpbmVycy4gSSBkbyB3b25kZXIgdGhhdCwgaWYgSSBzZWUgdGhpcyBpbiBj
bGFuZy0xOSBjb21waWxpbmcgZm9yDQphcm02NCB3aXRob3V0IGFueSBzcGVjaWFsIGNvbmZpZ3Ms
IGV2ZW50dWFsbHkgaXQgbWlnaHQgaGFwcGVuIGZvciBvdGhlcg0KcGVvcGxlIGFmdGVyIG1vdmlu
ZyB0byBjbGFuZy0xOT8NCg==
