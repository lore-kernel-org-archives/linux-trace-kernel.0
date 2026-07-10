Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022122.outbound.protection.outlook.com [40.107.75.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CD323392B;
	Fri, 10 Jul 2026 06:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783665177; cv=fail; b=aF3dnoREHIVzcJvAKrxfmte1Bs/GZKUMqL+CETYEYA9VBOe9xx26cjcdHCBkYkXlDicWiImDoUoEwxY7KDkflsJFDMwZj0DeXpRxW06B189m3kBMnnOA4sxlv0Ptkyl1PARKU0W+yl4fKE87MbJ/JfBe/fEQ8ZHw155joC9D9Ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783665177; c=relaxed/simple;
	bh=Ku0IKNEzFFY/Z1UIwslbvX/Sx9gv2ahWSZ5E/hww6RM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UdFKv/c3xkutgMckD7/1YrYNn6c0CfZzRNIGeCUyNioOQX15nTcMXKTTcjLF9QMi3w8k5Pls0kbMuy4t2RiK6Xs4X6N8ffy00jrjPa0s6ccifRl+DyOm1dPdflqqT5DJbO92TTEAl2BaQ9FU87S64/ma6csTYIuZRSKI9mz9ihg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com; spf=pass smtp.mailfrom=transsion.com; dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b=vA1ABjuv; arc=fail smtp.client-ip=40.107.75.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=transsion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b="vA1ABjuv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NAc02I029uDriz9M4gEQKHXdc/irD5e8YMg/NclivS7MktSpW/n0CdDJGHT7f/qo0OfvrePkRkXDoP8Wkx/Mtmkq911HvU+GxiORrvvFICR4cbcOUC/HFm8cZ0JyXlgFmE1RJO8DDj8cMPnCc9s5uZAhSNFh+NumMu8WtaaaTrwdS5znqS/NuzEzhxkj5aeTdcI93eOHAHnUFRqs1sHNy7Ay8uuS8AsWOArrjxBOL1UCwBtfnPMmwoy+eNKYqBiydR9Z1fZFbvfjgg75eqKSDxYl7mUGkJ2D1y+SG2Xrddy335p+w17jGYyt+xQEvB9R5+Bm0EDk0gyjy7KK1EmB8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ku0IKNEzFFY/Z1UIwslbvX/Sx9gv2ahWSZ5E/hww6RM=;
 b=xKjRuDiRhAxYE6fc1/GiHQmeGRq7o+Ufr0QJIFH87E2hKbQWvAJHFKsedHkzU8n5DuUeI0GS0soMhZdSCYAi9tit/lRfiFG/WoZB55DR3+bMdssb9hjbDCxOu7pcK/C7tnaa4vg7wyoSRtdlbY/lU9o8ZjMp6fdWCHj/0yd2GN0BrXVvpwxYW4ZxuUJ0o9uCxHe89PeBYrnzcy7MwtBE3Z5yzsd+jYWUDkaz2wDsah21wAlRIamrpi45ZF5sii+ssWD2hoD6T8xpfWu/mu5d4Ne4Btb39G0cjGNVEm8+A7p3hXTCICErgrrIHuqCO/AQVe2H0+vwddAuLVTz5AAdrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ku0IKNEzFFY/Z1UIwslbvX/Sx9gv2ahWSZ5E/hww6RM=;
 b=vA1ABjuvLRdGVBCLLiqCLjN5IuLiCJ/wJbv5wPDJdW1kW019AozvUKEZpHZXju28rlDNpRZNtBNC4BRZVKE+qe7zNoaNIMLf3JZyXUaETalDBXupe5zCn9saQOEGEK93kU+KdddiA+e6Rm6pKeUE3Z29Mzz2iS4+CwueEepcj/k=
Received: from SI2PR04MB5648.apcprd04.prod.outlook.com (2603:1096:4:1a4::11)
 by TY1PPFFF3893AB1.apcprd04.prod.outlook.com (2603:1096:408::ab3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 10 Jul
 2026 06:32:52 +0000
Received: from SI2PR04MB5648.apcprd04.prod.outlook.com
 ([fe80::8ce1:b82b:3b19:f79d]) by SI2PR04MB5648.apcprd04.prod.outlook.com
 ([fe80::8ce1:b82b:3b19:f79d%5]) with mapi id 15.21.0181.008; Fri, 10 Jul 2026
 06:32:52 +0000
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
Subject: [RFC v3 0/2] rm64: kprobes: Fix single-step fault and reentry
 handling
Thread-Topic: [RFC v3 0/2] rm64: kprobes: Fix single-step fault and reentry
 handling
Thread-Index: AQHdEDXvAxoNV+1f9k+a9AwSj4Ubjw==
Date: Fri, 10 Jul 2026 06:32:52 +0000
Message-ID: <20260710063242.228714-1-hupu@transsion.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR04MB5648:EE_|TY1PPFFF3893AB1:EE_
x-ms-office365-filtering-correlation-id: ccf0f18a-a2bf-4869-01b5-08dede4d11a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|11063799006|3023799007|18002099003|56012099006|6133799003|38070700021;
x-microsoft-antispam-message-info:
 OAlE8W6ibU+QCxiWckBJ6bjKNZalMmEIHdYsTHeCEKoYFs/yCLsebztRw8pS/ve9qUKOQqid4c0LM2mHgL3OtgwgVVElV2kPSQWNIT5NyLIM2YKIBcDEfLi9hu5r7P5KLoP3t8p3gYA0nPbiR1KWxDurtRz6y3DFvhR0bbTzMlp4Ab7ChQ/N6/hgL6aIvYFPp7ZaRHCWRaTYtg8N03svB+vpZMXI3RIuTemz85pqkrE2lbozFNOAZr/NaxkGOKgI49Kgu5ew7yROo94v5xYhB8DlfI1O2UylHALS6muDbVyQGAgLJZQ9FTlIBuuCRKUsiXKKIAalhSAj+gzkfnXVwYScCP9wcInrYDYNq3UeaccWIlHYr2k+B1vQkb1BlHJMJdVtDzu4bmCcGXud8qtImA/2HczqjBcW6nplpPpdsoi9E8wGXXgVYVJYcDDNzwpuyAY9B7nh2bPxc8gzfPxoYI8YRERl55t2nXXG0GtxNuga8WxXodOZCa1uJ4a1wkWDahleS72TKDiaiAlPNFyg9vbyfE5Oh8PunW+/UnQabEpBXM8LpVD7kuNGySvNtLbGQzPWDZt0RF3VEvcwh5bBtH0pyTNdxndm6BOs68wDf41OshoSbLIeciCLwt7LsL/XC6afOJxHLgZY/Kf3NVFDbW8xRQvL1hAtEyfcKwQb71bGUkSNhMDE/AYBbmhJ1APfcAiYX4Rq23sLn1R2Kh0qJvkvjQmwe+3EvhWglbWP6YQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR04MB5648.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(11063799006)(3023799007)(18002099003)(56012099006)(6133799003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dG1LWWxNSlg0MFpRSUR6T0pseCs0dWVNRHR6N0UxN2c4WnJhQkEwMzAra2ds?=
 =?utf-8?B?TkpYYXR3NmpKZi9GWXQ2Wk9kbEEwd2Y0TW5acy93dk5iM1lucEhCUTI2Ynpv?=
 =?utf-8?B?aURmN3lkRVo4eU9kU3UzMmFrV1k5azlVSkd6anN0SFR1STFIY2R5Sy9RUFlp?=
 =?utf-8?B?ZUF3akR5eTdYdlRVc3B1SGhOVUxUQUNGWmtvYVYwT0VqaXkzNHVMckVPZVB1?=
 =?utf-8?B?QVgrOU9haUVCRmVlZ3hmd0JMRHpONXZ1M0M5QWNGQnB2czNTRlA4TGczWDkz?=
 =?utf-8?B?Q1dEaEpQMzNmRnFBQmpkNHBRMWtOVTZjVWtZdmNqN2UwZW10aENDWk1keHNO?=
 =?utf-8?B?d0J0R21GRG01OEJyZDdIYnNmT3NMSWxwUXhkak9ReGY2RXV1RnE5cU1kWFBo?=
 =?utf-8?B?L2dudzhrZlFmRldwT09NK2dxUEdpeTBwdzBlck5DQmlVejFBM2FjQkhrL3Jq?=
 =?utf-8?B?RU1SRlhNR1lVRXpCSVJCM0orK3QxNHQ2KzI2MlMyYWlVSTR6d1hZcGcxWGdZ?=
 =?utf-8?B?QlVkaElvRjZwaGJKaFYrRDhBZS9FTWZnM2FEZncyOVN6ak13bU1qRE9IcmVj?=
 =?utf-8?B?UjdDWVdIZVZISWs0ZEw0WU5WVUVCaHdzTGNOODFmRzcwTlFjbHI0SVhmNHZT?=
 =?utf-8?B?dGdtUWZjTUJZMGlzL0U0ZitMeXVLeDZzMFJwRlArZnAvNjZzR3F1bFIzRnlJ?=
 =?utf-8?B?Y1cvRU80alZjeUdZVFlwVWMxZmhBZU92QW4zc2FRSSt2bnp6NjVVTFBaKzFJ?=
 =?utf-8?B?bG5JV0VYNk9uaDk2TDhHZjBJK0VKUi9FWThuTmxOTGJDU0gveTdQSko0ZmJp?=
 =?utf-8?B?U2hkMGJES2w3RmJpdnZTR0Z0NURsRzBtVHdNK2diTzN4OGpXeC9YY1hVVUhO?=
 =?utf-8?B?S0FPRm5rTElSV2lEN3Ewb0IvZU5hTWpuUTR4ODRNMkRpRE9kL1Jmd0FqbFo5?=
 =?utf-8?B?N0dtVTduR3Q5U1F0RDFtN09wU0FiRXVkVXc1cmZDK29KTUh2NWtVS09NU0g0?=
 =?utf-8?B?TFFpSXNpZHJwZjFPU3Vpa2xONXl3K3d2Z2taOWx6NEZtdWMrRzdQV2Jja25W?=
 =?utf-8?B?cDJtWVJtQWlYTStFMmpRdW01WXhpN3RLM0tYU1JvYXNHQzUxT0I3bkpNSHRJ?=
 =?utf-8?B?ZWh0d2JpOVMzTThMUU5mOEM1emJoK3M0VVQrQUVUTmI1QUlVY1VhYVpIQjNK?=
 =?utf-8?B?RThGV2xNOWxOU29TaU9GNzZyTVdpVXBIVmFjamlPNVZTSTgySUN4VXhzTk4r?=
 =?utf-8?B?dnR3RC9PSm01a01lYnFWZEE1blFRQk5VZk9mTjcwNUNFUGwyS0xjejcyRTRV?=
 =?utf-8?B?bVNtWEpXVytCL2VSS1ZPejFWcUx4RlRCT2FNT0JwOThMcFNRRDB0bUVJT0h5?=
 =?utf-8?B?aktvWXB1NkFybjlSa0ZmNVhxWVVXUUhIMVUyamZSNFdBencyVG8rbFJTbHR6?=
 =?utf-8?B?VU1lMlpyOU5McEQrOUZXZ0hBY3lCTlQ2OUQ4VlF3ejdUZ2pjTjlGaDltd0xP?=
 =?utf-8?B?TmIxYUNFWjlSNFR3R2RKMlIyTllQb2VKVWhSUDNKTlZTN1VrcmRCeWlKUVM1?=
 =?utf-8?B?dUxuSzJpaTgvQ1RhTmVyYnZpVDV1Y1J6M0JOSDJYK0tyWVF0cSswb0JiUVNh?=
 =?utf-8?B?SmdEb0hLak9JWXI4T24zWlhsVGRqTVJQRytPOGduZUhWOGV5WXJ6ZUNIeWtB?=
 =?utf-8?B?Zzk0WDE3MGR1WDExb2IydTBhQXcwT0dwdzBVbTVSYVpyeStJeUdTTDVjM29w?=
 =?utf-8?B?b3lsQ1dLOVBOZStuNG5XVFJ4cEV4aCtwcDJ2L1MrRnAweExLNEZEQVhWSjVj?=
 =?utf-8?B?aHZQdUZNZDZBRENzQ0NDT3VNYk5BZ0xneUkreUJZWmVhYlJVT1kzNjZET0F0?=
 =?utf-8?B?dnVtOFgxQzBkK2VCRGtrYmx0a3BRb25VWWh2R1loTlkvR1puaE5jbHE4RHZP?=
 =?utf-8?B?K2JKbDV5NDBMaE1HSktPZC9ySUJTOEVkZzkvTE9vcG1FYzRUNW5KUkRkQTBV?=
 =?utf-8?B?ekp0WlFQNWRIUVdBaTVKTzYzbTM4bmI0QU8zaEx6Z05SbUsrRExqRmFoeG1K?=
 =?utf-8?B?ck5PK3NjTFBUeVp6WFQ1QWdwd3g3dm1XRUhmZEc1VWUrNDIwdnFGakRMUnQ5?=
 =?utf-8?B?REU4c1NqendqNjRMYUZPQVJBbWwySnpRVVV0cUZCR2ZGMjVjTVk3VVY4L2ZN?=
 =?utf-8?B?eWc2UXI2NjlCY25QR1FwK2JDbGZmZmhlU2lzQTFEbjhQNUVrV3FwbTVPbUNk?=
 =?utf-8?B?djd1bjJpejlWOG1sM3lhYkR3T3h1d0VMRGZVeFl1aUY3UWVLZGViQk1kYjhR?=
 =?utf-8?Q?aGjvuOQT2bt9Uv2cyA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf0f18a-a2bf-4869-01b5-08dede4d11a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2026 06:32:52.2565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alXl+P7yOQcaGMd+75QPhdzmHERLQD97olgsEirsGVzpOGW7G4mypB0F3yyufcwkWDWeDOJsZbhsP6sOCZXIfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPFFF3893AB1

RnJvbTogUHUgSHUgPGh1cHVAdHJhbnNzaW9uLmNvbT4KClRoaXMgc2VyaWVzIGZpeGVzIHR3byBh
cm02NCBrcHJvYmVzIGlzc3VlcyBvYnNlcnZlZCB3aGVuIHJ1bm5pbmcKc2ltcGxlcGVyZiB3aXRo
IHByZWVtcHRpcnEgdHJhY2Vwb2ludHMgYW5kIGR3YXJmIGNhbGxjaGFpbnMgd2hpbGUgYQprcHJv
YmUgaXMgYWN0aXZlIG9uIGEgZnJlcXVlbnRseSBleGVjdXRlZCBrZXJuZWwgZnVuY3Rpb24uCgpU
aGUgY3Jhc2ggaGFwcGVucyBpbiB0aGUga3Byb2JlIGRlYnVnIGV4Y2VwdGlvbiBwYXRoLiBXaGls
ZSBhIGtwcm9iZSBpcwpwcmVwYXJpbmcgb3IgZXhlY3V0aW5nIGl0cyBYT0wgc2luZ2xlLXN0ZXAg
aW5zdHJ1Y3Rpb24sIHBlcmYvdHJhY2UgY29kZQpjYW4gcnVuIGluIHRoZSBzYW1lIHdpbmRvdy4g
VGhhdCBjb2RlIG1heSBlaXRoZXIgdGFrZSBhIGZhdWx0IG9mIGl0cyBvd24Kb3IgaGl0IGFub3Ro
ZXIga3Byb2JlLgoKUGF0Y2ggMSBmaXhlcyBrcHJvYmVfZmF1bHRfaGFuZGxlcigpIHNvIHRoYXQg
aXQgb25seSBoYW5kbGVzIGEgZmF1bHQKdGFrZW4gaW4gS1BST0JFX0hJVF9TUyBvciBLUFJPQkVf
UkVFTlRFUiBzdGF0ZSB3aGVuIHRoZSBmYXVsdGluZyBQQwpwb2ludHMgYXQgdGhlIGN1cnJlbnQg
a3Byb2JlJ3MgWE9MIGluc3RydWN0aW9uLiBTaW11bGF0ZWQga3Byb2JlcywKd2hpY2ggaGF2ZSBu
byBYT0wgc2xvdCBhdCBhbGwsIGFyZSBmaWx0ZXJlZCBvdXQgYXQgZnVuY3Rpb24gZW50cnkgc28K
dGhhdCB0aGUgbm9ybWFsIHBhZ2UgZmF1bHQgaGFuZGxlciAoaW5jbHVkaW5nIGZpeHVwX2V4Y2Vw
dGlvbikgY2FuCnByb2Nlc3MgYW55IGZhdWx0IHdpdGhvdXQgaW50ZXJmZXJlbmNlLgoKClBhdGNo
IDIgYWxsb3dzIGEga3Byb2JlIGhpdCBpbiBLUFJPQkVfSElUX1NTIHRvIGJlIGhhbmRsZWQgYXMg
YQpyZWNvdmVyYWJsZSBvbmUtbGV2ZWwgcmVlbnRyeSwgaW5zdGVhZCBvZiB0cmVhdGluZyBpdCBh
cyB1bnJlY292ZXJhYmxlLgpUaGlzIGlzIHNhZmUgYmVjYXVzZSB0aGUgcmVlbnRyeSBzYXZlIGFy
ZWEgaGFzIG5vdCB5ZXQgYmVlbiBjb25zdW1lZCBhdAp0aGF0IHBvaW50LiBPbmx5IGEgaGl0IHdo
aWxlIGFscmVhZHkgaW4gS1BST0JFX1JFRU5URVIgcmVtYWlucwp1bnJlY292ZXJhYmxlLiBUaGUg
c2FtZSBwYXRjaCBhbHNvIGV4dGVuZHMgc3RydWN0IHByZXZfa3Byb2JlIHdpdGggYQpzYXZlZF9p
cnFmbGFnIGZpZWxkIHNvIHRoYXQgdGhlIG91dGVyIGtwcm9iZSdzIG9yaWdpbmFsIERBSUYgc3Rh
dGUgaXMKcHJlc2VydmVkIGFjcm9zcyByZWVudHJ5LiBXaXRob3V0IHRoaXMsIHRoZSBuZXN0ZWQg
a3Byb2JlIHdvdWxkCm92ZXJ3cml0ZSBrY2ItPnNhdmVkX2lycWZsYWcsIGFuZCB0aGUgb3V0ZXIg
a3Byb2JlIHdvdWxkIHJlc3RvcmUgdGhlCndyb25nIERBSUYgbWFzayBvbiBjb21wbGV0aW9uLCBw
b3RlbnRpYWxseSBsZWF2aW5nIGludGVycnVwdHMKcGVybWFuZW50bHkgZGlzYWJsZWQuCgpUaGlz
IGZvbGxvd3MgdGhlIHNhbWUgbG9naWMgYXMgdGhlIGV4aXN0aW5nIHg4NiBmaXhlczoKCiAgNjM4
MWMyNGNkNmQ1ICgia3Byb2Jlcy94ODY6IEZpeCBwYWdlLWZhdWx0IGhhbmRsaW5nIGxvZ2ljIikK
ICA2YTUwMjJhNTZhYzMgKCJrcHJvYmVzL3g4NjogQWxsb3cgdG8gaGFuZGxlIHJlZW50ZXJlZCBr
cHJvYmUgb24gc2luZ2xlLXN0ZXBwaW5nIikKCnYyIC0+IHYzOgogIC0gUGF0Y2ggMTogdW5jaGFu
Z2VkLgogIC0gRm9sZGVkIFBhdGNoIDMgaW50byBQYXRjaCAyIHNvIHRoZSBzYXZlZF9pcnFmbGFn
IGZpeCBsYW5kcyBpbiB0aGUKICAgIHNhbWUgY29tbWl0IGFzIHRoZSByZWVudHJ5IGNoYW5nZSwg
a2VlcGluZyB0aGUgc2VyaWVzIGJpc2VjdGFibGUuCgp2MSAtPiB2MjoKICAtIFBhdGNoIDE6IG1v
dmVkIHNpbXVsYXRlZCBrcHJvYmUgY2hlY2sgdG8gZnVuY3Rpb24gZW50cnkgKHBlcgogICAgbWFp
bnRhaW5lciByZXZpZXcpOyByZW1vdmVkIHJlZHVuZGFudCB4b2xfaW5zbiBOVUxMIGNoZWNrIGZy
b20KICAgIHRoZSBpbm5lciBicmFuY2guCiAgLSBQYXRjaCAyOiB1bmNoYW5nZWQuCiAgLSBQYXRj
aCAzOiBuZXcgaW4gdjI7IGZpeGVzIHRoZSBJUlEgZmxhZyBzYXZlL3Jlc3RvcmUgZ2FwIHRoYXQK
ICAgIFBhdGNoIDIgZXhwb3Nlcy4KICAtIFJlbW92ZWQgdGhlIHNlbGZ0ZXN0IHBhdGNoIChvbGQg
UGF0Y2ggMykgZnJvbSB0aGlzIHNlcmllcy4KICAtIEZpeGVkIFNpZ25lZC1vZmYtYnkgdG8gdXNl
IGZ1bGwgbmFtZSAoUHUgSHUpIGluc3RlYWQgb2YgdXNlcm5hbWUKICAgIChodXB1KS4KICAtIFVw
ZGF0ZWQgY29tbWVudHMgYW5kIGNvbW1pdCBtZXNzYWdlcyBhY3Jvc3MgYWxsIHBhdGNoZXMuCgpS
ZXByb2R1Y2VyOgogIHNpbXBsZXBlcmYgcmVjb3JkIC1wIDxwaWQ+IC1mIDEwMDAwIFwKICAgIC1l
IHByZWVtcHRpcnE6cHJlZW1wdF9kaXNhYmxlIFwKICAgIC1lIHByZWVtcHRpcnE6cHJlZW1wdF9l
bmFibGUgXAogICAgLS1kdXJhdGlvbiA5IC0tY2FsbC1ncmFwaCBkd2FyZiBcCiAgICAtbyAvZGF0
YS9sb2NhbC90bXAvcGVyZi5kYXRhCgpCZWZvcmUgdGhpcyBzZXJpZXMsIHRoZSBjcmFzaCByZXBy
b2R1Y2VkIGZyZXF1ZW50bHkuIFdpdGggYm90aCBwYXRjaGVzCmFwcGxpZWQsIGl0IHdhcyBubyBs
b25nZXIgcmVwcm9kdWNlZCBpbiBvdXIgdGVzdGluZy4KClB1IEh1ICgyKToKICBhcm02NDoga3By
b2JlczogT25seSBoYW5kbGUgZmF1bHRzIG9yaWdpbmF0aW5nIGZyb20gWE9MIHNsb3QKICBhcm02
NDoga3Byb2JlczogQWxsb3cgcmVlbnRlcmluZyBrcHJvYmVzIHdoaWxlIHNpbmdsZS1zdGVwcGlu
ZwoKIGFyY2gvYXJtNjQvaW5jbHVkZS9hc20va3Byb2Jlcy5oICAgfCAgNiArKysrCiBhcmNoL2Fy
bTY0L2tlcm5lbC9wcm9iZXMva3Byb2Jlcy5jIHwgNDUgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKystCiAyIGZpbGVzIGNoYW5nZWQsIDUwIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkK
Ci0tIAoyLjQzLjAKCg==
