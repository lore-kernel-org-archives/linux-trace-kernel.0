Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022122.outbound.protection.outlook.com [40.107.75.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E7C386C0A;
	Fri, 10 Jul 2026 06:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783665179; cv=fail; b=MR1jwK0xjt8B5tzzwRtnbj/dkjJPjgPPY8z/5rl140CJZweQpY/HiFU2E93pE1gtssmA1TZ/7zMht/W4voxzicD+40TfRJTKw1OWxKGo5tN1Ejtb21t5H6EXk0WiylFRkYUahCmmGJvVkq/Xy2MHbM+OnkMXORey9ZlMWKaf3E8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783665179; c=relaxed/simple;
	bh=unzF02AFuCtsiCaUvnCmEnIo/QPH97b2pSQ9IcGmSkw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iUTJ9hJMMEo92QrR7/Ly7ITB5M4k4FhydL/4NFVvtc4+Uw3jNFJsYOiBQzXbUSgpvcesJNdv8JN/1yvqkSsV9DA6gcghBpQqx7aOyMgkG68geDsNPZ602rjLKc5VsQbirYsG2Ok5JbHPdfEV6a8laA9fcBvVBN6gG5HUVVlNhpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com; spf=pass smtp.mailfrom=transsion.com; dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b=ooKhie/y; arc=fail smtp.client-ip=40.107.75.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=transsion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b="ooKhie/y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ynlWLsNgvhDFaZ56xEKVJkJdBlpmUWm8+d0ne+zHz/gVoAuDkv2OUBX0U4tHP88bC5SylfSpRbrcVigpEtoQa6OigHcvn8aMWQpDYReXANlvoOk4ADxExEkhXzhJCk2KJqVSBWkx4m+3kUbbdOVin2WVqNVzIK/xszgPhmE4jUV70pzsKGJVtXBuSzHCN3skzXeSRhKBtbcVjjv7SUnns9kKy7v494JSQUn9g1Xx2YffaK6URlJZ2mOCp9eqWFEWbl1O6BwC9c8sIBYTmqIJXsBidisVfIMyAi+nnA1s53DqeDlVrJe4vCITh6Q8iw2fPUKzIIpmxCfhqDfFp4HXsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unzF02AFuCtsiCaUvnCmEnIo/QPH97b2pSQ9IcGmSkw=;
 b=SDWEKKaq9HPOoFWkfHDe1WnsR3CdS/67muVgnJPP1Re1rpYwnAij4IgyDywuMg+wzaGg3r9WaWGFcTW4VQW7yGxUBUmHei0Gp5M4qnBtxabcvKEt7w3IKiUzShRiSHxp4tA+Pq4G0JelvYSGUUap0QU1cjimOBa7u9wbWBTi+eCIwxMKBYoazd6Nio/MH5yRvKs1dJBvAfIYgF5fApar4WAU3m70tWigLFZD9tlnUHTUv9rYRr3ISnRfdLTKYxAPQra/3BkwOpWPzwEXsuo1f/NAhNDz7HpGa3LacO3p/WtcaFBoqt5BAqypG5AQRHh7Zj9N5f+XCiCH+xuHTux1dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unzF02AFuCtsiCaUvnCmEnIo/QPH97b2pSQ9IcGmSkw=;
 b=ooKhie/yW+mSxgDO/JBkSmmineDV78kgOyyL2DzOhCc8Ej4Vxm/b1Z9skHHwU91ZG15iZLFcw6w6zNDCV5n9ThpggYAsBJlTyBCVGh8Muvr3mVLCEJhzkGjoX8mPQqwmT840lpa7dgBfKtzxp6hs0lnwXQtI+lL/NucIzaeKBg8=
Received: from SI2PR04MB5648.apcprd04.prod.outlook.com (2603:1096:4:1a4::11)
 by TY1PPFFF3893AB1.apcprd04.prod.outlook.com (2603:1096:408::ab3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 10 Jul
 2026 06:32:53 +0000
Received: from SI2PR04MB5648.apcprd04.prod.outlook.com
 ([fe80::8ce1:b82b:3b19:f79d]) by SI2PR04MB5648.apcprd04.prod.outlook.com
 ([fe80::8ce1:b82b:3b19:f79d%5]) with mapi id 15.21.0181.008; Fri, 10 Jul 2026
 06:32:53 +0000
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
Subject: [RFC v3 1/2] arm64: kprobes: Only handle faults originating from XOL
 slot
Thread-Topic: [RFC v3 1/2] arm64: kprobes: Only handle faults originating from
 XOL slot
Thread-Index: AQHdEDXvtytPb7j2ykeT9J1DXyz6xw==
Date: Fri, 10 Jul 2026 06:32:53 +0000
Message-ID: <20260710063242.228714-2-hupu@transsion.com>
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
x-ms-office365-filtering-correlation-id: 9e7bf137-9a8e-498c-3264-08dede4d1278
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|5023799004|11063799006|22082099003|3023799007|18002099003|56012099006|6133799003|38070700021;
x-microsoft-antispam-message-info:
 QFNUiyVb+ILKBGf+YHCc4YTllW+8lkllzQvr25Tea5SQaYhU8D2eDt+EH9gwoJiaxk8YLD1kb4pKgxe9AOJI/RnTFEz6vIljr0A9PHG88AfFhdMhAGJViZQiuiPo5tjMrClM1Jw7XxbmZUIWN7Z5JpkQnWkpHiCUpwydSifmLstsDSL9G2iD0SmHMWFF7YHgnoob3osA396FP0rRRaG9DRYXyFF1LJcOXp/Z8Mf3xVtltaYJrQHGXoYRafq7oTz0vcy2O7ZONvKEl0eaAws33kD6PTcM4bEXLsAPgvXziPcAChvuYeCB5/6R3UpsBUY8rkk4l3vtFWXooYtcK37VfiY8dwYDvRp9OjlU69rgHzfpoAo5KycFVjG/mM0borO0fwzQYvAu+yhTkPH6UyzoGAZhrXcMrceJ4u3n96FyfoOK5KbcShg0oNMGXxYEwhiKw8kDDwYKNto8C+j81jEg/DzH3y0yV4fy0Dc11AzPFy9sb9nu0tCixRdwHB5uO6Z/VuyJuPLKUa6K+nGQwj0fV+M5Rs1heYcXD1T95+xIPT1dKkQxf2kc3mCSHdzQkUbNuXIXL7hlLMCeILh99US73X7Ub1wSq3xpwlGKYYmna0XvDoLnEKH5TuDIpZC3cvdAHaFwK6qCrX9k5GCjL687A8kcOtBZCyql96gzyLfKEOn3Zmsv+t5zG1J45WqWpqUb4SVclBwszwbxmXKEqR/wO/3VhPPrIIoJKxhXq3y4puw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR04MB5648.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(5023799004)(11063799006)(22082099003)(3023799007)(18002099003)(56012099006)(6133799003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QVREVVBVM29Ka2NiUXd0YmtPR3c4bmRDRktjaXpzRmhUVlpjL0xoNzNrdENU?=
 =?utf-8?B?UW5QUjJzS0VsblBTQWl6ZzQ5dnJMVDl1SjhPSWEzcmh1Zk9SRndEQUtROWJ2?=
 =?utf-8?B?a1NPWmg0VHdhTS9ZQTUyaVN6ZnJ6SSttcmR3TkN0Y2xJYS9jeXNBb09TMDFD?=
 =?utf-8?B?OGFpZjBsUDNvQlY1SkltWVhlNWJJb2hSa0FBTmt6QkNTNWtML2dNT0tQMWJ2?=
 =?utf-8?B?dlZaWTUzb3gwUDhPSVRSVDUxVlc4Q1Y0bkJYK0xYQXpMN0lGNm5abVlnUUtY?=
 =?utf-8?B?ejBUYmcwRU5tN0dQS0JpTkZwc1JYUE5DQWtCTG1KYTRyeStCWVlPUHh4aTY0?=
 =?utf-8?B?UkI3L1BXb3JqWG9GOUFqUlFiZDZwWEc4OGwrSzRNVXdjQnhmd0Q4M0JzS3Bz?=
 =?utf-8?B?bzZwdGZ0STEyTDFBTUowVzFyOGtHR0Z5WUVpYlRWeEx5U1dtd3Nnd2VycUFn?=
 =?utf-8?B?Tzk1dkM3MDkyV0packJ5VkdObVJzd1B1aXJiTkRIRndxNkhzOVpMQjBzTUxZ?=
 =?utf-8?B?NUt0ejUzQUJWSE1oOVdhTnAzQ2ZQVlkwdXd4S0dkNDRIaXhoUTh3ajNRZDI1?=
 =?utf-8?B?cGFjMHJKYkxJS1E1NVRFaElJSWdkWStiVW5XU2REakJHaVF4Y05zSW91OGRN?=
 =?utf-8?B?Y0tzYUVGSzBvRDZOTk1OakFUc0lzcEozRW8zU1dpSmpIT0FxaW5xUEM3akpZ?=
 =?utf-8?B?Rmt5UHdnbE5mcWNjci9tWWk2VmthZU01UWFyMm1FSzFyT2lEd2JtdjNLM2NY?=
 =?utf-8?B?T0k4NlFCeGl0UjlubUhLM0g0ZDYwdzh3dklGV1Y3VGE3bjlSZ3d5a21Rc0Nq?=
 =?utf-8?B?T1hjcVFoSVQ4ZC9PMXd2UE1hYlF6UW1qRG05OTVHZTY3YzdsOVJjTXJibC9H?=
 =?utf-8?B?NWlhUVUyWDc1U1dSVS9icHFkMkk3UzRUSTRsMXczeFUvUlBMK0xZSURDQlFp?=
 =?utf-8?B?a1F3WEE5Z0kza3JXcHFidUJZM1VDajFhYlYxS1dKaytoUFI5dkZJTVZBU0tN?=
 =?utf-8?B?Q2xpZ3E5WkdQckF1NVRnVzVyVHV1aXBVamtJUUxBK01ndVovQXlJN2dGMGtP?=
 =?utf-8?B?TkhQZkhmK3VOUm1Td1ZJUGx3eGo4N1BxMU5SUXJZRzk5NUlpaVRrdVIzUVh2?=
 =?utf-8?B?dWpUOUo2TXRxcHlVVXVOcHoxOVFKUmJZYzhmK2phTjdPWFhOamQycEhnQXFC?=
 =?utf-8?B?Nm1pZEhNOEtKN3NtRkFXVWVKQzRyTnNwSVF6VU0yU2ZuQm9xZmIwWDlYRWM4?=
 =?utf-8?B?cWlQVTVUQVNYRjN5NXZLeE9UOU12U0VOcXNPdzd0dm15SHJUendQVGNIWEVm?=
 =?utf-8?B?MXdKa3ZaUEVrNlhMRFBUSDBtYmZ1SHhFaTVjZWlpdTFteUJvc2Y1Um1CTE96?=
 =?utf-8?B?NG1yOE5SN1dxNk9kRDBUSVpmR2lUbzNpS05sREV5elRMdTBXV25iS1I0ZUM4?=
 =?utf-8?B?bVpKdit0QVcwYjlHTjFCWjNIYStvVU5Ya0hVRVI5ME0vVDc2TUVKZlRzR3dN?=
 =?utf-8?B?ZmM2L2hHYU1CSXhkdFFxTWxWNjk1aFlFTEZteUpTdUNFTG9qVnJkWC9WdlFU?=
 =?utf-8?B?eWxwdFlNQ0VnSk16Sm4yRUllQkt4Ykk0YTh0VlRLeHAvcW83YlBJSXNBT1A4?=
 =?utf-8?B?N0E5azZXK3V3blV4Zk55OEpMK29wTU16NmJtRnF0UElzY3RjNnJsWlU2aUx2?=
 =?utf-8?B?R2JNWkFMa01sUWJVMGVhbEU0N2t2bW5kekptMHp4Mm05VWQvWlZROXM0MTh1?=
 =?utf-8?B?TW5hV056azZWck5HNFVYU2FQc2tWdU9FWFpsdUliVTJmbTF6Z3I0bUErZjdX?=
 =?utf-8?B?ZGFBU3kya2tIRFk5NGRET2VpZVZPWU4zZnRwMEUvNTVVS3BOUmxvdkQ1ek5z?=
 =?utf-8?B?OUVmL05mZEhMQnpUbytqdzZpaXRlNkNITmszRm9raW1mTlpqZXBacVo4NXd3?=
 =?utf-8?B?bmkvclZxRy9FMnNma2xpOUN4TXJOazF4bjU5TlhUczVScWVNZXZFcCtoR3VY?=
 =?utf-8?B?OGVMcW13RkJHQTkyc3Y0NXozcVNLZlRLalFydk1hUTQ5SzQwa0VFdWgyWjFo?=
 =?utf-8?B?WkQwdkxDaXN6TUl0N0xQZzJ5RTkvMEx4T2dzVVBoZi8ramIxTDJGUWZ1NmJ4?=
 =?utf-8?B?emovVlNEekVFWEFsaDErTFUvbVpDR2NTZTQyWGtxV0dnaFpSSU1LNTRvT2pY?=
 =?utf-8?B?YUo5YnF2eERYcDJqbFBOTUlrdzJldFFJVTlPS2g0YnlQUHhDSDF4UzlDc2VB?=
 =?utf-8?B?R0JJN29scnFYZU10N1VYbGk5dHpadndOTTN5NFpFQjZGZWxqaVptRlFjUnAr?=
 =?utf-8?Q?DICE5h306Pa879oU4M?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e7bf137-9a8e-498c-3264-08dede4d1278
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2026 06:32:53.6577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uLseAFq6Iy27Q2c74ch58svUx8Gg84/WgHQxeAgvNrfClZ/Z3Vi+5kM3l1TZXXUCX3o6gDF9LY77D73ri7UYbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPFFF3893AB1

RnJvbTogUHUgSHUgPGh1cHVAdHJhbnNzaW9uLmNvbT4KCmtwcm9iZV9mYXVsdF9oYW5kbGVyKCkg
Y3VycmVudGx5IHRyZWF0cyBhbnkgcGFnZSBmYXVsdCB0YWtlbiB3aGlsZSBpbgpLUFJPQkVfSElU
X1NTIG9yIEtQUk9CRV9SRUVOVEVSIHN0YXRlIGFzIGEga3Byb2JlIHNpbmdsZS1zdGVwIGZhdWx0
LiBUaGlzCmFzc3VtcHRpb24gZG9lcyBub3QgaG9sZDogcGVyZiBvciB0cmFjaW5nIGNvZGUgbWF5
IHJ1biBmcm9tIHRoZSBkZWJ1ZwpleGNlcHRpb24gcGF0aCBkdXJpbmcgdGhlIHNpbmdsZS1zdGVw
IHdpbmRvdyBhbmQgdGFrZSBpdHMgb3duIHBhZ2UgZmF1bHQuCgpXaGVuIHRoZSBmYXVsdCBpcyBo
YW5kbGVkIGFzIGEga3Byb2JlIGZhdWx0LCB0aGUgUEMgaXMgcmV3cml0dGVuIHRvIHRoZQpwcm9i
ZSBhZGRyZXNzLCBjb3JydXB0aW5nIHRoZSBleGNlcHRpb24gcmVjb3ZlcnkgY29udGV4dCBmb3Ig
dGhlIHJlYWwKZmF1bHQuIEEgdHlwaWNhbCByZXByb2R1Y2VyIGlzIHJ1bm5pbmcgcGVyZiB3aXRo
IHByZWVtcHRpcnEgdHJhY2Vwb2ludHMKYW5kIGR3YXJmIGNhbGxjaGFpbnMgd2hpbGUgYSBrcHJv
YmUgaXMgaW5zdGFsbGVkIG9uIGEgZnJlcXVlbnRseQpleGVjdXRlZCBmdW5jdGlvbi4KCkZpeCB0
aGlzIGluIHR3byBsYXllcnM6CgoxLiBBdCBmdW5jdGlvbiBlbnRyeSwgYmFpbCBvdXQgaW1tZWRp
YXRlbHkgZm9yIHNpbXVsYXRlZCBrcHJvYmVzCiAgIChhaW5zbi54b2xfaW5zbiA9PSBOVUxMKSwg
c2luY2UgdGhleSBoYXZlIG5vIFhPTCBzbG90IGFuZCBhbnkgZmF1bHQKICAgdGFrZW4gZHVyaW5n
IHRoZWlyIGV4ZWN1dGlvbiBjYW5ub3QgYmUgYSBzaW5nbGUtc3RlcCBmYXVsdC4KCjIuIEZvciBr
cHJvYmVzIHdpdGggYW4gWE9MIHNsb3QsIG9ubHkgaGFuZGxlIHRoZSBmYXVsdCB3aGVuIHRoZQog
ICBmYXVsdGluZyBQQyBtYXRjaGVzIHRoZSBYT0wgaW5zdHJ1Y3Rpb24gYWRkcmVzcy4gRmF1bHRz
IGZyb20gYW55CiAgIG90aGVyIFBDIGFyZSBsZWZ0IHRvIHRoZSBub3JtYWwgcGFnZSBmYXVsdCBo
YW5kbGVyLgoKVGhpcyBmb2xsb3dzIHRoZSBzYW1lIHByaW5jaXBsZSBhcyB0aGUgeDg2IGZpeCBp
biBjb21taXQgNjM4MWMyNGNkNmQ1Cigia3Byb2Jlcy94ODY6IEZpeCBwYWdlLWZhdWx0IGhhbmRs
aW5nIGxvZ2ljIikuCgpTaWduZWQtb2ZmLWJ5OiBQdSBIdSA8aHVwdUB0cmFuc3Npb24uY29tPgpT
aWduZWQtb2ZmLWJ5OiBIb25neWFuIFhpYSA8aG9uZ3lhbi54aWFAdHJhbnNzaW9uLmNvbT4KLS0t
CiBhcmNoL2FybTY0L2tlcm5lbC9wcm9iZXMva3Byb2Jlcy5jIHwgMjIgKysrKysrKysrKysrKysr
KysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9h
cmNoL2FybTY0L2tlcm5lbC9wcm9iZXMva3Byb2Jlcy5jIGIvYXJjaC9hcm02NC9rZXJuZWwvcHJv
YmVzL2twcm9iZXMuYwppbmRleCA0M2EwMzYxYThiZjAuLjc5OGU0YjA5MWQxYSAxMDA2NDQKLS0t
IGEvYXJjaC9hcm02NC9rZXJuZWwvcHJvYmVzL2twcm9iZXMuYworKysgYi9hcmNoL2FybTY0L2tl
cm5lbC9wcm9iZXMva3Byb2Jlcy5jCkBAIC0yODIsOSArMjgyLDMxIEBAIGludCBfX2twcm9iZXMg
a3Byb2JlX2ZhdWx0X2hhbmRsZXIoc3RydWN0IHB0X3JlZ3MgKnJlZ3MsIHVuc2lnbmVkIGludCBm
c3IpCiAJc3RydWN0IGtwcm9iZSAqY3VyID0ga3Byb2JlX3J1bm5pbmcoKTsKIAlzdHJ1Y3Qga3By
b2JlX2N0bGJsayAqa2NiID0gZ2V0X2twcm9iZV9jdGxibGsoKTsKIAorCS8qCisJICogU2ltdWxh
dGVkIGtwcm9iZXMgZXhlY3V0ZSBpbiB0aGUgZGVidWcgdHJhcCBjb250ZXh0IGFuZCBoYXZlIG5v
CisJICogWE9MIHNsb3QuIEFueSBwYWdlIGZhdWx0IHRha2VuIHdoaWxlIGEgc2ltdWxhdGVkIGtw
cm9iZSBpcyBpbgorCSAqIHByb2dyZXNzIGNhbm5vdCBoYXZlIGJlZW4gY2F1c2VkIGJ5IGtwcm9i
ZSBzaW5nbGUtc3RlcHBpbmcgYW5kCisJICogbXVzdCBiZSBsZWZ0IGFsb25lIGZvciB0aGUgbm9y
bWFsIHBhZ2UgZmF1bHQgaGFuZGxlciwgaW5jbHVkaW5nCisJICogZml4dXBfZXhjZXB0aW9uLgor
CSAqLworCWlmIChjdXIgJiYgIWN1ci0+YWluc24ueG9sX2luc24pCisJCXJldHVybiAwOworCiAJ
c3dpdGNoIChrY2ItPmtwcm9iZV9zdGF0dXMpIHsKIAljYXNlIEtQUk9CRV9ISVRfU1M6CiAJY2Fz
ZSBLUFJPQkVfUkVFTlRFUjoKKwkJLyoKKwkJICogQSBwYWdlIGZhdWx0IHRha2VuIHdoaWxlIGlu
IEtQUk9CRV9ISVRfU1Mgb3IKKwkJICogS1BST0JFX1JFRU5URVIgc3RhdGUgaXMgb25seSBhdHRy
aWJ1dGFibGUgdG8ga3Byb2JlCisJCSAqIHNpbmdsZS1zdGVwcGluZyBpZiB0aGUgZmF1bHRpbmcg
UEMgcG9pbnRzIHRvIHRoZQorCQkgKiBjdXJyZW50IGtwcm9iZSdzIFhPTCBpbnN0cnVjdGlvbi4g
SWYgdGhlIGZhdWx0IG9jY3VycmVkCisJCSAqIGVsc2V3aGVyZSAoZS5nLiBpbiBwZXJmIG9yIHRy
YWNpbmcgY29kZSBpbnZva2VkIGZyb20gdGhlCisJCSAqIGRlYnVnIGV4Y2VwdGlvbiBwYXRoKSwg
bGVhdmUgaXQgZm9yIHRoZSBub3JtYWwgcGFnZSBmYXVsdAorCQkgKiBoYW5kbGVyIHRvIHByb2Nl
c3MuCisJCSAqLworCQlpZiAoaW5zdHJ1Y3Rpb25fcG9pbnRlcihyZWdzKSAhPSAodW5zaWduZWQg
bG9uZyljdXItPmFpbnNuLnhvbF9pbnNuKQorCQkJYnJlYWs7CisKIAkJLyoKIAkJICogV2UgYXJl
IGhlcmUgYmVjYXVzZSB0aGUgaW5zdHJ1Y3Rpb24gYmVpbmcgc2luZ2xlCiAJCSAqIHN0ZXBwZWQg
Y2F1c2VkIGEgcGFnZSBmYXVsdC4gV2UgcmVzZXQgdGhlIGN1cnJlbnQKLS0gCjIuNDMuMAoK
