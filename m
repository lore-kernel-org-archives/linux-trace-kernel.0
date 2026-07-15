Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022085.outbound.protection.outlook.com [52.101.126.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53ED31716D;
	Wed, 15 Jul 2026 13:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784123824; cv=fail; b=gTZ7z/uLJoXHeyKKETVtsxYV41aBCmFTVgrsnICNRSVeswXPcOC2dOFivmdejBwoNK9ZNVmMlDgcagQ95bveq7OliCTFdZCoU9nvW4PyllRoPxyiMzAIxCL7co4qFFw7NYZMZHTN0NkncQ9ckjzo5CKwl9BbUAnAdkHN6V67aOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784123824; c=relaxed/simple;
	bh=HPlTHYH/z5TGkfDACptbNlNm1pJS5NVbaMT4G+gM0yU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Mvwr+e6fr8qz0KOXseBQt1Nwvb5g295aQcJqUzKqAPA/+kkhQ0oLn+oyIiSvfh9krrV/q7qoIyG31TqK9Ud+EUPSTJc0T8v6S08g/Q0Nm5TjJ4wZk5XSiIesLAO+j40LGcNXnD49EgRWYiL43cS4yqkPB81hIUdxgEisvoTCNiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com; spf=pass smtp.mailfrom=transsion.com; dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b=YJ3TIslm; arc=fail smtp.client-ip=52.101.126.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=transsion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b="YJ3TIslm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XsY8AWRICaWatGO7ruTBu7WNtYP6nxj91MvaGaBcleJc6W0Rxmj/MVSFl/s93ijtd5b9kb+MY0r4JVoXhRk90l7I26tHjOB4wZZlSq/pq02Sk5RLHX8e+jQnq4gVvmAp0egjCkb1GBNCZJbmlrXz81YQjwNi8u9DA3IAukJ5jIRGWYdl4d8G6XV7YOwyg+AilbXkzqPD8iymF5SzjiOkUgsqqfwA+Ur3MNxP4+22a6PEBCYQeduOHmVlgyZKZcJnTvQx4FuLur/XK0NIaWGSVQG+qQGpiPtVq0ld1/UEjo8iqTCAdtSFeplS4sqxLatHvzlrDXpNdFOs/FdmGP3hww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPlTHYH/z5TGkfDACptbNlNm1pJS5NVbaMT4G+gM0yU=;
 b=TbD/ayszIKGvYkrMST286hag7TqcUjnBJq93FgIH4wvfTsOUJ7Jybgn61dw6/2rOLNyaMYmozbcc8gbZbqb1bRvwRfR9HsxdN1Uso5a/w4xrbRUedwazpbJIhCSnTy85ZrGH6NRV9Ogx2N4asKjbtGjmhIMYgLd67w7flKI/cyFanfzJsvwmKJXmYKwc+dPi0g3Rss4yT7z1qwTC//9Ed4MnqQ12GZwx39RuKw+9x4uBaIqn65ByINWq8SVxuXwEdAISk1iv/7REM2IpKf93+xfcO9clrxZWkmaET7+Zm7+qEBAS3M+rNnBUxjMMHftVBZjeHvhKlUT3oM+inxGMzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPlTHYH/z5TGkfDACptbNlNm1pJS5NVbaMT4G+gM0yU=;
 b=YJ3TIslmIsSLoN/KhUQ9b1CUReTSGC/1C69JvBDb3JikQqCtRLHdW/kSLouAcZlF2nLLvetwJdBe7sxCTWpvTaPVfTfMUQlldTlFpmXKU4psOhKSwkZG3a+dABm8gSYEkNsIiXr1uTzY3cOzfoRFzgnFyrRp/bLsc/4BdmGccv0=
Received: from SI2PR04MB5648.apcprd04.prod.outlook.com (2603:1096:4:1a4::11)
 by PUZPR04MB6626.apcprd04.prod.outlook.com (2603:1096:301:e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.3; Wed, 15 Jul
 2026 13:56:59 +0000
Received: from SI2PR04MB5648.apcprd04.prod.outlook.com
 ([fe80::8ce1:b82b:3b19:f79d]) by SI2PR04MB5648.apcprd04.prod.outlook.com
 ([fe80::8ce1:b82b:3b19:f79d%5]) with mapi id 15.21.0181.008; Wed, 15 Jul 2026
 13:56:58 +0000
From: Pu Hu <hupu@transsion.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, "will@kernel.org"
	<will@kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>
CC: "ada.coupriediaz@arm.com" <ada.coupriediaz@arm.com>, "davem@davemloft.net"
	<davem@davemloft.net>, Hongyan Xia <hongyan.xia@transsion.com>, Jiazi Li
	<jiazi.li@transsion.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>, "naveen@kernel.org"
	<naveen@kernel.org>, "yang@os.amperecomputing.com"
	<yang@os.amperecomputing.com>
Subject: Re: [RFC v3 2/2] arm64: kprobes: Allow reentering kprobes while
 single-stepping
Thread-Topic: [RFC v3 2/2] arm64: kprobes: Allow reentering kprobes while
 single-stepping
Thread-Index: AQHdEDXw7507o/wC2EuRGyt7eMVEu7Zmf2+AgAgjlwA=
Date: Wed, 15 Jul 2026 13:56:57 +0000
Message-ID: <d380f90a-2eca-40ed-845f-b3b9b321a51e@transsion.com>
References: <20260710063242.228714-1-hupu@transsion.com>
 <20260710063242.228714-3-hupu@transsion.com>
 <20260710183857.176dc60026ea9fcbe4984b1d@kernel.org>
In-Reply-To: <20260710183857.176dc60026ea9fcbe4984b1d@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR04MB5648:EE_|PUZPR04MB6626:EE_
x-ms-office365-filtering-correlation-id: 02461f89-21e1-4229-ec2f-08dee278efc4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|366016|38070700021|4143699003|3023799007|10067099003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 dj2urROiubvFV6mhj0mMdlTgy07oh75K+EkqvseDppqXj120v7DcB2sn4bKUR0czQP35ZWDhq6LHznWrwr5PYJiZOAhq5PqSCMDg7Hr4uX/1R7I1nrCeKohszXkPIDnuPvjEO/RJeod0OBxcJtdfHtf6AYFP/kYbiWboEbMTB7ksSZLAicBjiDq6s/0r9t67IWHCvtpjPDw/Qi8DXNn9m/AiygTia3Hl/uDPDA+wVuJwLwisBnVUsOESUkrp4/MlLwNiMwwJqElJtJM8rFsgOwJHc0eB9DMXc047M+cCh4VXcVv0rXtc0oXSlfb+ASOgjSbh5wWc/OMxzgO7CgwYxmF0mug5/cUJ9Xx+UFU0wakk6d87r1rI38BDpQZ0lPKz7Pq4wWT4P5qBWLed7pEiFvPji3t+BuF/pBbE7j1cvs7pjxaWXe+Gx596M0gXeaznV4saM1BWaijde15rrEigUhAwtoQk4VKVYRVwknwd9rf2VUGduuYjtEWhUrnQrjyKxEbUbeV8q07I1FUCb65mSk89AOYc0vnYYVRzB3k9Cs2FcvGC/qvd8S5UICcjsGihKyR1Il0DtsX9lcLHOa0RqzlqPJspw5RFy/7pObWAcJxORHPUg8cdnrDDu1tSRCVSYH8Hg1T/LCz149zT2Yqx+hflQO5zzoDxFma52rhmjw4bF9XbtBcEKg/Ck840ENE3rsOJyOVUkomK3rvtsDmHyhlcTmXi80u7w8nxaSYiQx8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR04MB5648.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(38070700021)(4143699003)(3023799007)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SUx2aVhzQkoyOGtCSXNFak11UWswTUkwVExFUWxzNUE3WTB6WDZ2SU9LNTc3?=
 =?utf-8?B?Y2ZkcncxUkh3bTdIejFvZ2RMWGUvSnUrKzExY24wTEphMXRrUUlPbFpuMWlC?=
 =?utf-8?B?b09mQ29qNHU1RFBxeUxqdm8rUUt4V2MzQThLMjAwNVZCa3JCeWtMYmxCaUJM?=
 =?utf-8?B?dHZuTjJmL2h2ZGZIZUlsektXSW5MKzNsQXFjRWdDVTB4QnBuVzhuVnNyaW5t?=
 =?utf-8?B?WER5YUFYUnZBdmZMckRVY0NqNFJ3VWk1bGhPd3FtUzZCWmNRUDV0ek1JZ1A0?=
 =?utf-8?B?UEE3ay92WDVLVDREU2JnTVZoTDU5ZVFma3M1aForN1BOMGNTcFMrb21yS1BW?=
 =?utf-8?B?UTc1Sk9qVFN6bUVESHBJNDBxb2RqdzYwRXN2L0dDamw2SzJtRnBtdmFuZU1H?=
 =?utf-8?B?b2NOZGcwcVF0dk43VWpkZTJyNjJDVGhnWjU4d0Q1akV0Ry9LT3ByTEIrSHA0?=
 =?utf-8?B?M29rZXBiNDFUWHM0ZWJubWxDNUQwUy8xVDJjL3FuRkhTWHN2SUZWVWZadnF4?=
 =?utf-8?B?UHBOQmdsQzdCQkRLclJnSUk2REIzRGJQOTdCcmQ2dXV1TFhsMXNCL0o2YXBi?=
 =?utf-8?B?WjdobnhxMXpSYWQxSXVBV3V4U2FrQmZHVWR1QlJQWjFSanprc1hKM1VhS3RL?=
 =?utf-8?B?cUZtQnJXbkszdDJ4bU5rSjFLV25BSkh6OVJESE53d3ovQnRWdHJvOVFHZHdS?=
 =?utf-8?B?cHlEbUxtNlhzeUlRQmJlUEtReXJBa1FFZG01eU13RG8xLzJueXpoZHhub25y?=
 =?utf-8?B?Z0wrTkFQV3pZMlpGUmFMenhwaEtlUkNscjJpWFpMLzdoQmd6TlQxUS9zVFdJ?=
 =?utf-8?B?bVZ5cTlJaXlMd2N0QUVscG9JMnpQOEhNb1ZTOG9oME5IQTMrdDZ1aDVaNEtH?=
 =?utf-8?B?NVphTzB2K0JpcmI4RFN0Z3FzSS9yeFFQOUJEZzlmdEJJUTdlYUFRd0FuNk5u?=
 =?utf-8?B?K3Jtb0dsdDFCVVFFWGM0WStTSFlCSnZPakh1cFpvc0hONzlPMUJ0akxRZHcx?=
 =?utf-8?B?TDJtRHpGTzArOFB2dTJyOGhNcG9FYTVYZWJ6QnRobHk1Ym5uZlRyenhhWlND?=
 =?utf-8?B?ck8vMUc2Z3BVanUvTGEydWZjQ0FQaVh2OFRlVGJoM2VtY2V0MmdkUDI0aTR0?=
 =?utf-8?B?VEtOMEZXcUc2Szd3cDBiTDg4cmZZZDZjeVBmQzExZi9iUFRIUW45VEV4K3NJ?=
 =?utf-8?B?M1I5NlBlVlhiWXhTVXNTUE8ydkJkZ0YrZTRJVjJCNXRFQ1c5WENTblFDb3dU?=
 =?utf-8?B?aXc4WmFubnNaeHVhSjNyeDRsZHZva1hFcjdueW9xUG1mK3ZQeDJWM3FZV1Bp?=
 =?utf-8?B?UlM0TzVXRGFWRGp4MEpkb0JxU1lEd2pDWDRBS01mVHdiTlFweXl4STRhYVJq?=
 =?utf-8?B?K0pSazFqbS9CbFRzd2dkQml3RzlGZ05DSk8wRXF3RmdKTjJ1RUtZL2dhcDBE?=
 =?utf-8?B?WnlXWCtWZC9URzlWREk0dW5BSHBGUEU0QUh1SzVlNkg0RTlHQzdSa2dCTkg2?=
 =?utf-8?B?Qkh2TURMeU02S0g0NHd2NDJCaEhKYU1YbkR5K2tzd0N2U0VvUWxBa0F2S2Vh?=
 =?utf-8?B?Y0FVeWsybXI1WVlvZHd3b3JJcWEwWGJqcHVoSDEya1FDUkNvTllaNmhnQnVC?=
 =?utf-8?B?WGdlcEt2akowdDV2TGNKbTVSUy9hN2pJV2NJTGhGeTNjYnRERTVMeUM1NEdn?=
 =?utf-8?B?cXAzMWxYdFhDTU1MamtwUUhNWjVvKy9QK0hBUmdRUkxOdEsxN2NVMHFBVnJs?=
 =?utf-8?B?dGQrYUUxUGZjTTFHaitrcHFFN0tqUXhIOUlUdkROMUlQL3drcUZRaVpUemgv?=
 =?utf-8?B?aklUdHFLbHc5Y1JYcWVSUExacStwcVF6YkcyZnBhUlJoakk3WWNZNGFrOWky?=
 =?utf-8?B?QW5SU3hycTBrd2s1K1N4cEV1R1JHaXFCamJ2WFBzMXU2WW5OT3hqWHhqQ0tJ?=
 =?utf-8?B?Skc0akI1MzllaWVwUVBIZnpNY1VQaXdvZUtkdjVneGxpaTQzcmJTcjVEVkdj?=
 =?utf-8?B?eXBLcXZCT2NTUGJ3cGYwTklVdElSSW9oaWpsaXErZXlxb3hPVDdIdmh5ZlFC?=
 =?utf-8?B?SmJ6TXhiVXowQjFNQjV3V1NPUTZvc3VWNnIwb0J2WWFiam1pd2poM3BUMVFw?=
 =?utf-8?B?czgxRmxPQUpJRDNBZjdCa21aS3I2cXdyQ211WEc3a3l1TlNZSnJXQ3hSbm55?=
 =?utf-8?B?TWxCTDhXK2dHUjdHalZ3azBrbDhVZ0I1SVM2NVdIcGtXYVc0RXg4MWFmdjhR?=
 =?utf-8?B?ZmlMcy90bzdTclliYzlpdHI3YXlQS0Jia1FqTU5wZ3Ard25SYjZURGRQeEVv?=
 =?utf-8?B?Qm4xY2ZTc3V5Nm1Sc3lzZkoyTFB3cVIzZ3FpOWNQQVVMejJaVU9uQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A3A1D44A1CAF943A43A157D883AB480@apcprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 02461f89-21e1-4229-ec2f-08dee278efc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 13:56:57.9476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1ehVuPTZZci7fAy5kCGlYY6KTX8atyMjSgmlyNiVylQo/MuvEE8AaLfy4GfOTdGY0+8RY6yBtkd13aL45Kf/4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR04MB6626

T24gNy8xMC8yMDI2IDU6MzggUE0sIE1hc2FtaSBIaXJhbWF0c3Ugd3JvdGU6DQo+IE9uIEZyaSwg
MTAgSnVsIDIwMjYgMDY6MzI6NTUgKzAwMDANCj4gUHUgSHUgPGh1cHVAdHJhbnNzaW9uLmNvbT4g
d3JvdGU6DQo+IA0KPj4gRnJvbTogUHUgSHUgPGh1cHVAdHJhbnNzaW9uLmNvbT4NCj4+DQo+PiBB
IGtwcm9iZSBjYW4gYmUgaGl0IHdoaWxlIGFub3RoZXIga3Byb2JlIGlzIGluIEtQUk9CRV9ISVRf
U1Mgc3RhdGUuIFRoaXMNCj4+IGNhbiBoYXBwZW4gd2hlbiB0cmFjaW5nIG9yIHBlcmYgY29kZSBy
dW5zIGZyb20gdGhlIGRlYnVnIGV4Y2VwdGlvbiBwYXRoDQo+PiB3aGlsZSB0aGUgZmlyc3Qga3By
b2JlIGlzIHByZXBhcmluZyBvciBleGVjdXRpbmcgaXRzIG91dC1vZi1saW5lDQo+PiBzaW5nbGUt
c3RlcCBpbnN0cnVjdGlvbi4NCj4+DQo+PiBDdXJyZW50bHkgYXJtNjQgdHJlYXRzIGEga3Byb2Jl
IGhpdCBpbiBLUFJPQkVfSElUX1NTIGFzIHVucmVjb3ZlcmFibGUsDQo+PiB0aGUgc2FtZSBhcyBh
IGhpdCBpbiBLUFJPQkVfUkVFTlRFUi4gVGhpcyBpcyB0b28gc3RyaWN0LiBBIGhpdCBpbg0KPj4g
S1BST0JFX0hJVF9TUyBpcyBzdGlsbCBhIG9uZS1sZXZlbCByZWVudHJ5IGFuZCBjYW4gYmUgaGFu
ZGxlZCBieSBzYXZpbmcNCj4+IHRoZSBjdXJyZW50IGtwcm9iZSBzdGF0ZSBhbmQgc2V0dGluZyB1
cCBzaW5nbGUtc3RlcCBmb3IgdGhlIG5ldyBwcm9iZSwNCj4+IGp1c3QgbGlrZSByZWVudHJ5IGZy
b20gS1BST0JFX0hJVF9BQ1RJVkUgb3IgS1BST0JFX0hJVF9TU0RPTkUuDQo+Pg0KPj4gVGhlIHRy
dWx5IHVucmVjb3ZlcmFibGUgY2FzZSBpcyBoaXR0aW5nIGFub3RoZXIga3Byb2JlIHdoaWxlIGFs
cmVhZHkgaW4NCj4+IEtQUk9CRV9SRUVOVEVSLCBiZWNhdXNlIHRoZSByZWVudHJ5IHNhdmUgYXJl
YSBoYXMgYWxyZWFkeSBiZWVuIGNvbnN1bWVkLg0KPj4NCj4+IE1vdmUgS1BST0JFX0hJVF9TUyB0
byB0aGUgcmVjb3ZlcmFibGUgcmVlbnRyeSBjYXNlcyBhbmQgbGVhdmUNCj4+IEtQUk9CRV9SRUVO
VEVSIGFzIHRoZSB1bnJlY292ZXJhYmxlIG5lc3RlZCByZWVudHJ5IGNhc2UuDQo+Pg0KPj4gVGhp
cyBjaGFuZ2UgYWxzbyByZXF1aXJlcyBzYXZpbmcgc2F2ZWRfaXJxZmxhZyBpbiBzdHJ1Y3QgcHJl
dl9rcHJvYmUuDQo+PiBXaGVuIGEgbmVzdGVkIGtwcm9iZSBjYWxscyBrcHJvYmVzX3NhdmVfbG9j
YWxfaXJxZmxhZygpLCBpdCBvdmVyd3JpdGVzDQo+PiBrY2ItPnNhdmVkX2lycWZsYWcgd2l0aCB0
aGUgY3VycmVudGx5IG1hc2tlZCBEQUlGIHZhbHVlLCBsb3NpbmcgdGhlDQo+PiBvdXRlciBrcHJv
YmUncyBvcmlnaW5hbCBEQUlGIHN0YXRlLiBXaXRob3V0IHRoaXMgZml4LCB3aGVuIHRoZSBvdXRl
cg0KPj4ga3Byb2JlJ3Mgc2luZ2xlLXN0ZXAgZmluaXNoZXMsIGtwcm9iZXNfcmVzdG9yZV9sb2Nh
bF9pcnFmbGFnKCkgYXBwbGllcw0KPj4gdGhlIHdyb25nIERBSUYgbWFzayBhbmQgbGVhdmVzIGlu
dGVycnVwdHMgcGVybWFuZW50bHkgZGlzYWJsZWQuDQo+Pg0KPj4gRXh0ZW5kIHN0cnVjdCBwcmV2
X2twcm9iZSB3aXRoIGEgc2F2ZWRfaXJxZmxhZyBmaWVsZCBhbmQgc2F2ZS9yZXN0b3JlIGl0DQo+
PiBhbG9uZ3NpZGUga3AgYW5kIHN0YXR1cy4gVGhpcyBlbnN1cmVzIHRoZSBvdXRlciBrcHJvYmUn
cyBvcmlnaW5hbA0KPj4gaW50ZXJydXB0IHN0YXRlIGlzIHByZXNlcnZlZCBhY3Jvc3MgcmVlbnRy
eS4NCj4+DQo+PiBUaGlzIG1pcnJvcnMgdGhlIHg4NiBmaXggaW4gY29tbWl0IDZhNTAyMmE1NmFj
Mw0KPj4gKCJrcHJvYmVzL3g4NjogQWxsb3cgdG8gaGFuZGxlIHJlZW50ZXJlZCBrcHJvYmUgb24g
c2luZ2xlLXN0ZXBwaW5nIikuDQo+Pg0KPiANCj4gT0ssIHRoaXMgbG9va3MgZ29vZCB0byBtZS4N
Cj4gDQo+IFJldmlld2VkLWJ5OiBNYXNhbWkgSGlyYW1hdHN1IChHb29nbGUpIDxtaGlyYW1hdEBr
ZXJuZWwub3JnPg0KPiANCj4gZm9yIHRoaXMgc2VyaWVzLg0KPiANCj4gV2lsbCwgQ2F0YWxpbiwg
Y2FuIHlvdSBwaWNrIHRoaXMgc2VyaWVzPw0KPiANCj4gVGhhbmtzIQ0KPiANCg0KSGkgV2lsbCwg
Q2F0YWxpbiwNCg0KSnVzdCBhIGdlbnRsZSBwaW5nIG9uIHRoaXMgc2VyaWVzLg0KDQpNYXNhbWkg
aGFzIGtpbmRseSByZXZpZXdlZCBpdCBhbmQgcHJvdmlkZWQgaGlzIFJldmlld2VkLWJ5IHRhZy4N
Ckkgd2FzIHdvbmRlcmluZyBpZiB5b3UgaGFkIGEgY2hhbmNlIHRvIHRha2UgYSBsb29rLCBvciBp
ZiB0aGVyZSBpcw0KYW55dGhpbmcgZWxzZSBJIHNob3VsZCBhZGRyZXNzIGJlZm9yZSBpdCBjYW4g
YmUgcGlja2VkIHVwLg0KDQpObyBydXNoLCBhbmQgYXBvbG9naWVzIGZvciB0aGUgcmVtaW5kZXIg
aWYgdGhpcyBpcyBhbHJlYWR5IG9uIHlvdXIgcmFkYXIuDQoNClRoYW5rcyBhIGxvdCBmb3IgeW91
ciB0aW1lIQ0KDQpUaGFua3MsDQpQdSBIdQ0KDQo=
