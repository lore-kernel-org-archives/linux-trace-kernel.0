Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022122.outbound.protection.outlook.com [40.107.75.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D293B19B9;
	Fri, 10 Jul 2026 06:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783665180; cv=fail; b=u+iN2ZRQYpa88ob6Eiq8UKUUwb18kDz8DB71fIpErX5t5NFVSi4YP6X6ZFYJkV5tm/uRPdgrJ6ATCPKHHFWZRJ9dGren/mhsy0BsE9IaU4Eu0Lo0AgCWqCi/9BW9UXK6ySgEE7/X6NzuknDPnN0VlXSEwscQtuC7NUNcEVTga1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783665180; c=relaxed/simple;
	bh=wmJ+d3cJ0tJ2Tyavn2QOg9HO1ZeNuFGp9y8uDVfqGL4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y1hDOWenHBVsR6000QanZx5S3/6f4+pwTffFuvk8H2NVahcIyTSLZlstzjpuMNiF8H6pBsDbTTbUKTzN1UrdE4ln4oHu7FKSmW0IpHg+duTuigz/Z+KTc+TIO6yg+JWQe+RWuLLu+eaLzEYx+S0aay/ZfROigXNOVcAjC/NP10g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com; spf=pass smtp.mailfrom=transsion.com; dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b=juc6K3bY; arc=fail smtp.client-ip=40.107.75.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=transsion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b="juc6K3bY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FaxGPi0G53gb3Ych0rOJf95RLLibCtS2M8+xCXOqlG4xB1LuN2JfV5hnRwBfT3bbpUTHAeHwWl0UPulluxxicqTasiQMbiUAb5JjmL/p5KJ5mm4zQqGru20HeiHJ3yyan+eAhMRTDn517pOdRpI72KWozBzh4rbnCik73ojprMNN2NWLZ1w2XoxT0fe3wyr/avIGrRk912/MmgWOLEB8d11dTLxDvGEXWCjj76sMoxGf9GqWDpCwnCIT4XrX1Q4rTrfFRXjoLrDcWU787DX8dMlNuMultZcuuIyRPg8aAvFVwM4cWipZirFLHV6jaE8p7Wmu3izwy3MEYBom+zGRaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmJ+d3cJ0tJ2Tyavn2QOg9HO1ZeNuFGp9y8uDVfqGL4=;
 b=U43pBLEZYNhALnV+nAQRJdvFQ+OeTyJq5soi4pP9/N5/RIB1xSAcs3yaXKIvf+8O7C4b1T7mpUwNP1g0FKkwaEKDVO5aR301iMfXuX03cOUPlv0m2sjlFd6vv21SiouJXpoOQUPrR9t2CwnInCndy4zJS+Wv33UuuQVd0WlGKP5FEGg/u4e/n/Vy4zvruwx9zIVa2fQ2YVDMJwozxY1GAcvM2HReBn3M2+xzDWSm+6t5HF++KfBlezDwprlt/N6ESzTDLxnz+E8K/2+n6rYgv8bsuQlVc4B7tJ/NKPf0Kr90QciEzczpo5mcSuz9FfdFs/z2XoPqqsQwrZPh8oWn6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmJ+d3cJ0tJ2Tyavn2QOg9HO1ZeNuFGp9y8uDVfqGL4=;
 b=juc6K3bYD9Rh0/uU7lX7TJCiR1wOBNCX2fRtZEW8MBUpX63mQMHfkzmsX+xKNFt4vxpEDJMsgcQgmdwIffGPJqcUt9oq5yTVJpSgyOzHxNB2rI0vV0v3e5nbatTzIsV4dduPUSt984lQbUOzVqVmwDSUb5VyJ2dZ6Sh1EIkOeh0=
Received: from SI2PR04MB5648.apcprd04.prod.outlook.com (2603:1096:4:1a4::11)
 by TY1PPFFF3893AB1.apcprd04.prod.outlook.com (2603:1096:408::ab3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 10 Jul
 2026 06:32:55 +0000
Received: from SI2PR04MB5648.apcprd04.prod.outlook.com
 ([fe80::8ce1:b82b:3b19:f79d]) by SI2PR04MB5648.apcprd04.prod.outlook.com
 ([fe80::8ce1:b82b:3b19:f79d%5]) with mapi id 15.21.0181.008; Fri, 10 Jul 2026
 06:32:55 +0000
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
Subject: [RFC v3 2/2] arm64: kprobes: Allow reentering kprobes while
 single-stepping
Thread-Topic: [RFC v3 2/2] arm64: kprobes: Allow reentering kprobes while
 single-stepping
Thread-Index: AQHdEDXw7507o/wC2EuRGyt7eMVEuw==
Date: Fri, 10 Jul 2026 06:32:55 +0000
Message-ID: <20260710063242.228714-3-hupu@transsion.com>
References: <20260710063242.228714-1-hupu@transsion.com>
In-Reply-To: <20260710063242.228714-1-hupu@transsion.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR04MB5648:EE_|TY1PPFFF3893AB1:EE_
x-ms-office365-filtering-correlation-id: 277e8139-d229-4e1e-7feb-08dede4d1359
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|11063799006|22082099003|3023799007|18002099003|56012099006|6133799003|38070700021;
x-microsoft-antispam-message-info:
 bqUphiy2FJe/DMCLFgBlDaZ68tmo3XdKeorKNriD2WWecEyFRQqZlRZHfKQXe8JJprv8qPulCKu9n82Rsea5g+i5SmALNb4rMR4+92p2iNl64HtfUD4ew1nzbJiSmRZ47lmItPVWXKZnL8DgpEqxYOKd3p2QNWfbBZx20LOA67+3qngpQGihqa8odqPeE6LYaH32/Ao5pa6fUomUIJK+StyVpVGvzmfSC4DfcgZowpkHBP4HZUqLWi3+lgORnRsdAESeBNeKCIvU5YdknVDgfPV/mEIgtsuaJXyZjJ8meengTdcXL0Y3BL5mtSY/kZqVzc5NfYJrS9SqMog73SOn/XGYQ6w720J3ayW4OrVLbenRZsWiIr/r3a8GlEndB5LCYyYsaan4OkTdpj64v+yGs+w47g6QwgN1qNvs1FodD+I3Khg7VQDOinl1qpXTn4ZU2F0X6muAPjSLsvY+JkyZ8aJcrH3L4h8z5S/rsze/T+VBOncRoGmRqEX3UM7dOaksq4G5o9seYFQaDbxw0T3eclsEKUkBh7Yq6WS78E+Dg5QMAzAcKD/dLiHw3awRdQOBHt8HDKX/TRoUb+8xqVS2vK7MSDrFznkwIovZ6WvIws/zLF/Ph6TPFIYGVslTcX2RrY2o6lQWQkUBOzcOfcp+BjIXReB4zI3goIh8UO8tDzQPZFdcM2MxWMCpMFqrQHRAk3Jz8T/zjRfQAZAPkuVZ6kofLvlvouSbvpzVv16Kb8E=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR04MB5648.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(11063799006)(22082099003)(3023799007)(18002099003)(56012099006)(6133799003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YWd4M2RaMjVzdndwU1Z5Ynl4cjJHMy81NU5oTU54czJOa3Zad2pBUmw0K1RQ?=
 =?utf-8?B?YkpVNlYzak5FSWVFcGl3WFdscHBrNmlTaTRBSG1OdWpnM2JFaHRRVzkyRHJV?=
 =?utf-8?B?cmlVYVlDTU0wRGhkZXRpeWZ2MXJWcHJEWlIyT3AxZjhwSWpVS3RuV0RERTFM?=
 =?utf-8?B?VEhMZjZwUmQ2RDVYL280Y1dKcnNpd0FOZ0NPeHFXMlpyTk0xVXhoSFZHcDl6?=
 =?utf-8?B?WXRZdFJxaWZtKzBLQ1FNVlliQUM1QStEV3BqdXpvLzMzdGRrcjlLODBYVjdv?=
 =?utf-8?B?Y3EzSjRNekQ2ZDhIai9QTkdOV0xURXNCaVF5UzFxdko1UURqQ3VVYXIwenRD?=
 =?utf-8?B?VkxZSjMzckFQeC9PWnBweThRR0lydjZYNHMvclJrMXJHaFFEMmlLZTFmbHA1?=
 =?utf-8?B?QWhrZ09Rc1phbFBGd0w4WGw5V3pJZjFNY0dDR01aRUFRNEVCV0JFVmcwRXpY?=
 =?utf-8?B?WTlzUDR5SkF6eWNURXB0emZSa2k0cmIwaDhNZzVSOHdqdGdVeDhhQUlneDFt?=
 =?utf-8?B?aFVKVmlSSVlmMTlHcmc4WW5adWdLYWpWcTZjYktWV0JMY0lnbDdqUVNLRVJk?=
 =?utf-8?B?K2w2RFM5eE1UTk9IRmNhSEI3OCtrSjRRbUdOZnlDZ0V5VFNnRTBXQWh2Q2tL?=
 =?utf-8?B?ZU5FOVZxUlZQbWpGV2xNQ3BxUTVUMnpVVzV1VDVyaU1JaGNMdlhId1QrcTE1?=
 =?utf-8?B?czZXMnNBUGdvY0pIMncwRjRhb2hwWEttaWhiZTFJcGRPTzZReVVHM2ZhTDBy?=
 =?utf-8?B?L0FXS1F6MThtcHJwN1k4cHk4M2RpMHEyT1BnZUQrSzJqOXFCM2J3MjRtc1l6?=
 =?utf-8?B?RXV4eFhaSytmVUdPWElvVTlFT3lld3hScmphUDRxY3dXOVVoQ0p4K0xiYklz?=
 =?utf-8?B?YVZxMlc2N3RpWEx2UjZ1N1VkUFhxaE5UckJFbHJvN0V4aDBxNlpuQTVzWG1v?=
 =?utf-8?B?a255THhNTWM3S0g4V3JuTWIvRXVydE5NcHBydDREV0ZuSkJiT0Q5c0l3d1c5?=
 =?utf-8?B?YXdRWit5RmFFdEZyMVdUSmdoQjc4TVd0azkxNzF4NGc2VFhPa083UGVDVEEv?=
 =?utf-8?B?L2JpdDZodElYSGxlNC96MzZnd3IzT1NTN0wxdEJyaGxIdHNXTW9ZbmJiQ1Zl?=
 =?utf-8?B?d3dKRUNxY0I4NjJwNkhCVzZXK2g5OXl0dmhoRmVNcHQwUHRiY2F2Z2paQnM2?=
 =?utf-8?B?UEJoNnRKNjZMZ2paekF0amFrRnUvZVp6L1JVbUNKZjBUei9Hd1lVUE14RUcx?=
 =?utf-8?B?cU1IdGl0Y2NyRCtiWktnQmMzanllSEhwQ2tsMzA2Z25nMUtJZTJ3SEZIQzZ4?=
 =?utf-8?B?MmMzaTlJSEI5YVdvYzZFNkZPR1F2d1p2ZGtpU1RCdFZXd1RaTlJYRDA3Ulg0?=
 =?utf-8?B?VG5Zc3Fxc1lqOEpVUkdwcjcrZ0xPVERCMStmWnBNNWJ4Z3dkRmRkaWxXd0U5?=
 =?utf-8?B?MEZIbitETU8xN3BrU25jR2F0MnRJWFk0NGk5MDJXaEtySVpBUGJ1MFFTczFC?=
 =?utf-8?B?ME1GcVJ4cG12T2ZRd2dOeVdKTnBKeEhobSsrTVJQZTNnT1FxdEtxWGg2QVdR?=
 =?utf-8?B?RXdvYjFuemtYb1o1c21rY05GeDhHNG5IRVlEZ2ZObzhvQUUyVXFveFgwdHRG?=
 =?utf-8?B?VjNZdGQ1RGpjcEdNNnViT0MyUTArOVc0UmVRcFRIOVVDQ2RJb1JoeXBUb2RY?=
 =?utf-8?B?b1EvR29tNWFIaGppNDZjOE52djVFUVN0a0FldlowRmJqVlByZWVmZGtTdjY4?=
 =?utf-8?B?aHUzbWJXYlRVWHRkdWdteUIwRExXbmNmVnp5S285Yi9SR2x2b0s3RkwzZFFH?=
 =?utf-8?B?cmZxeUpPS0d0a0M5RVBCMTJ3cXhPaUlqcEljNE5OaWdydTlmQWRqUkx2MVZE?=
 =?utf-8?B?bzVFOFc3NHI3cmVEQmZRYWFNdGlYaVJGK2Nid3kyOWIzOUVsV2owSmpsREhG?=
 =?utf-8?B?TWhYNHovYUJSUnhVam9EQnEyd3BuaEZzdi9qY3dNdjM1ejg2V3hSSXBoVjhv?=
 =?utf-8?B?OHpaK0VlZERHRlJvbi9TN0w1VEhHRmRuNW0vWG1OKzcyYkdITHFveWlVSFNO?=
 =?utf-8?B?aUlreEFBRWM4MnpCdUIybFhVWjNhRktjaDh2eUE0NktKelk5VlRDRWtDT0dW?=
 =?utf-8?B?WXdqRVI1R2pTUTRWZ3VzYnl1ZEg1SHRsdFJMbUN3VHhadWhqOVJqeVJrZmZ3?=
 =?utf-8?B?Y1JWb0tuTWlzS3JieFU2dW1zSVJ6MWdCR1h1bnVlaUwwUVNJSFZiYkpxK3l6?=
 =?utf-8?B?dk5tUENCellUTmxQTUtLTDJqTjMxR21teEFwcmo2aUovWklrK3ltSXNNejRj?=
 =?utf-8?Q?T6uPpXHdozb/usLV0q?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 277e8139-d229-4e1e-7feb-08dede4d1359
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2026 06:32:55.1155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3MmcW4/rC+YPMHqSt1aLxSmpAqtL/NuQhc56xroMhXMfwq00OqanLjdViJFiTMV8D8K4b2Wejcoi3sHyyTwlgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPFFF3893AB1

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
bGUgbmVzdGVkIHJlZW50cnkgY2FzZS4KClRoaXMgY2hhbmdlIGFsc28gcmVxdWlyZXMgc2F2aW5n
IHNhdmVkX2lycWZsYWcgaW4gc3RydWN0IHByZXZfa3Byb2JlLgpXaGVuIGEgbmVzdGVkIGtwcm9i
ZSBjYWxscyBrcHJvYmVzX3NhdmVfbG9jYWxfaXJxZmxhZygpLCBpdCBvdmVyd3JpdGVzCmtjYi0+
c2F2ZWRfaXJxZmxhZyB3aXRoIHRoZSBjdXJyZW50bHkgbWFza2VkIERBSUYgdmFsdWUsIGxvc2lu
ZyB0aGUKb3V0ZXIga3Byb2JlJ3Mgb3JpZ2luYWwgREFJRiBzdGF0ZS4gV2l0aG91dCB0aGlzIGZp
eCwgd2hlbiB0aGUgb3V0ZXIKa3Byb2JlJ3Mgc2luZ2xlLXN0ZXAgZmluaXNoZXMsIGtwcm9iZXNf
cmVzdG9yZV9sb2NhbF9pcnFmbGFnKCkgYXBwbGllcwp0aGUgd3JvbmcgREFJRiBtYXNrIGFuZCBs
ZWF2ZXMgaW50ZXJydXB0cyBwZXJtYW5lbnRseSBkaXNhYmxlZC4KCkV4dGVuZCBzdHJ1Y3QgcHJl
dl9rcHJvYmUgd2l0aCBhIHNhdmVkX2lycWZsYWcgZmllbGQgYW5kIHNhdmUvcmVzdG9yZSBpdAph
bG9uZ3NpZGUga3AgYW5kIHN0YXR1cy4gVGhpcyBlbnN1cmVzIHRoZSBvdXRlciBrcHJvYmUncyBv
cmlnaW5hbAppbnRlcnJ1cHQgc3RhdGUgaXMgcHJlc2VydmVkIGFjcm9zcyByZWVudHJ5LgoKVGhp
cyBtaXJyb3JzIHRoZSB4ODYgZml4IGluIGNvbW1pdCA2YTUwMjJhNTZhYzMKKCJrcHJvYmVzL3g4
NjogQWxsb3cgdG8gaGFuZGxlIHJlZW50ZXJlZCBrcHJvYmUgb24gc2luZ2xlLXN0ZXBwaW5nIiku
CgpTaWduZWQtb2ZmLWJ5OiBQdSBIdSA8aHVwdUB0cmFuc3Npb24uY29tPgpTaWduZWQtb2ZmLWJ5
OiBIb25neWFuIFhpYSA8aG9uZ3lhbi54aWFAdHJhbnNzaW9uLmNvbT4KLS0tCiBhcmNoL2FybTY0
L2luY2x1ZGUvYXNtL2twcm9iZXMuaCAgIHwgIDYgKysrKysrCiBhcmNoL2FybTY0L2tlcm5lbC9w
cm9iZXMva3Byb2Jlcy5jIHwgMjMgKysrKysrKysrKysrKysrKysrKysrKy0KIDIgZmlsZXMgY2hh
bmdlZCwgMjggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2FyY2gv
YXJtNjQvaW5jbHVkZS9hc20va3Byb2Jlcy5oIGIvYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9rcHJv
YmVzLmgKaW5kZXggZjI3ODI1NjA2NDdiLi4zNWNlMmM5NDA0MGUgMTAwNjQ0Ci0tLSBhL2FyY2gv
YXJtNjQvaW5jbHVkZS9hc20va3Byb2Jlcy5oCisrKyBiL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20v
a3Byb2Jlcy5oCkBAIC0yNiw2ICsyNiwxMiBAQAogc3RydWN0IHByZXZfa3Byb2JlIHsKIAlzdHJ1
Y3Qga3Byb2JlICprcDsKIAl1bnNpZ25lZCBpbnQgc3RhdHVzOworCisJLyoKKwkgKiBUaGUgb3Jp
Z2luYWwgREFJRiBzdGF0ZSBvZiB0aGUgb3V0ZXIga3Byb2JlLCBzYXZlZCBoZXJlIGJlZm9yZQor
CSAqIGEgbmVzdGVkIGtwcm9iZSBvdmVyd3JpdGVzIGtjYi0+c2F2ZWRfaXJxZmxhZyBkdXJpbmcg
cmVlbnRyeS4KKwkgKi8KKwl1bnNpZ25lZCBsb25nIHNhdmVkX2lycWZsYWc7CiB9OwogCiAvKiBw
ZXItY3B1IGtwcm9iZSBjb250cm9sIGJsb2NrICovCmRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2tl
cm5lbC9wcm9iZXMva3Byb2Jlcy5jIGIvYXJjaC9hcm02NC9rZXJuZWwvcHJvYmVzL2twcm9iZXMu
YwppbmRleCA3OThlNGIwOTFkMWEuLjRlMGVmYWQ1Y2FmMiAxMDA2NDQKLS0tIGEvYXJjaC9hcm02
NC9rZXJuZWwvcHJvYmVzL2twcm9iZXMuYworKysgYi9hcmNoL2FybTY0L2tlcm5lbC9wcm9iZXMv
a3Byb2Jlcy5jCkBAIC0xNzQsMTIgKzE3NCwyNyBAQCBzdGF0aWMgdm9pZCBfX2twcm9iZXMgc2F2
ZV9wcmV2aW91c19rcHJvYmUoc3RydWN0IGtwcm9iZV9jdGxibGsgKmtjYikKIHsKIAlrY2ItPnBy
ZXZfa3Byb2JlLmtwID0ga3Byb2JlX3J1bm5pbmcoKTsKIAlrY2ItPnByZXZfa3Byb2JlLnN0YXR1
cyA9IGtjYi0+a3Byb2JlX3N0YXR1czsKKworCS8qCisJICogU2F2ZSB0aGUgb3V0ZXIga3Byb2Jl
J3Mgb3JpZ2luYWwgREFJRiBmbGFncyBiZWZvcmUgdGhlIG5lc3RlZAorCSAqIGtwcm9iZSBjYWxs
cyBrcHJvYmVzX3NhdmVfbG9jYWxfaXJxZmxhZygpIGFuZCBvdmVyd3JpdGVzCisJICoga2NiLT5z
YXZlZF9pcnFmbGFnLiBXaXRob3V0IHRoaXMsIHRoZSBvdXRlciBrcHJvYmUgd2lsbCByZXN0b3Jl
CisJICogdGhlIHdyb25nIERBSUYgc3RhdGUgYW5kIGxlYXZlIGludGVycnVwdHMgcGVybWFuZW50
bHkgbWFza2VkLgorCSAqLworCWtjYi0+cHJldl9rcHJvYmUuc2F2ZWRfaXJxZmxhZyA9IGtjYi0+
c2F2ZWRfaXJxZmxhZzsKIH0KIAogc3RhdGljIHZvaWQgX19rcHJvYmVzIHJlc3RvcmVfcHJldmlv
dXNfa3Byb2JlKHN0cnVjdCBrcHJvYmVfY3RsYmxrICprY2IpCiB7CiAJX190aGlzX2NwdV93cml0
ZShjdXJyZW50X2twcm9iZSwga2NiLT5wcmV2X2twcm9iZS5rcCk7CiAJa2NiLT5rcHJvYmVfc3Rh
dHVzID0ga2NiLT5wcmV2X2twcm9iZS5zdGF0dXM7CisKKwkvKgorCSAqIFJlc3RvcmUgdGhlIG91
dGVyIGtwcm9iZSdzIHNhdmVkX2lycWZsYWcgc28gdGhhdCB3aGVuIGl0cworCSAqIHNpbmdsZS1z
dGVwIGNvbXBsZXRlcywga3Byb2Jlc19yZXN0b3JlX2xvY2FsX2lycWZsYWcoKSB1c2VzCisJICog
dGhlIGNvcnJlY3Qgb3JpZ2luYWwgREFJRiB2YWx1ZS4KKwkgKi8KKwlrY2ItPnNhdmVkX2lycWZs
YWcgPSBrY2ItPnByZXZfa3Byb2JlLnNhdmVkX2lycWZsYWc7CiB9CiAKIHN0YXRpYyB2b2lkIF9f
a3Byb2JlcyBzZXRfY3VycmVudF9rcHJvYmUoc3RydWN0IGtwcm9iZSAqcCkKQEAgLTI0MCwxMCAr
MjU1LDE2IEBAIHN0YXRpYyBpbnQgX19rcHJvYmVzIHJlZW50ZXJfa3Byb2JlKHN0cnVjdCBrcHJv
YmUgKnAsCiAJc3dpdGNoIChrY2ItPmtwcm9iZV9zdGF0dXMpIHsKIAljYXNlIEtQUk9CRV9ISVRf
U1NET05FOgogCWNhc2UgS1BST0JFX0hJVF9BQ1RJVkU6CisJY2FzZSBLUFJPQkVfSElUX1NTOgor
CQkvKgorCQkgKiBBIHByb2JlIGNhbiBiZSBoaXQgd2hpbGUgYW5vdGhlciBrcHJvYmUgaXMgcHJl
cGFyaW5nIG9yCisJCSAqIGV4ZWN1dGluZyBpdHMgWE9MIHNpbmdsZS1zdGVwIGluc3RydWN0aW9u
LiBUaGlzIGlzIHN0aWxsIGEKKwkJICogcmVjb3ZlcmFibGUgb25lLWxldmVsIHJlZW50cnksIHNv
IGhhbmRsZSBpdCBpbiB0aGUgc2FtZSB3YXkgYXMKKwkJICogcmVlbnRyeSBmcm9tIEtQUk9CRV9I
SVRfQUNUSVZFIG9yIEtQUk9CRV9ISVRfU1NET05FLgorCQkgKi8KIAkJa3Byb2Jlc19pbmNfbm1p
c3NlZF9jb3VudChwKTsKIAkJc2V0dXBfc2luZ2xlc3RlcChwLCByZWdzLCBrY2IsIDEpOwogCQli
cmVhazsKLQljYXNlIEtQUk9CRV9ISVRfU1M6CiAJY2FzZSBLUFJPQkVfUkVFTlRFUjoKIAkJcHJf
d2FybigiRmFpbGVkIHRvIHJlY292ZXIgZnJvbSByZWVudGVyZWQga3Byb2Jlcy5cbiIpOwogCQlk
dW1wX2twcm9iZShwKTsKLS0gCjIuNDMuMAoK
