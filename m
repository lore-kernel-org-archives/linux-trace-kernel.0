Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022076.outbound.protection.outlook.com [40.107.75.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7487233946;
	Fri, 17 Jul 2026 01:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784253078; cv=fail; b=cQtxj4ICLft/N5iMiW1409rftpGIj1kE5ce2RDfn6ehs2apmUHx96GB6j1T+jVVFqT9w4I2casHz9KSJ0prxgDDnM23+MRu8eo2LWZ/G7H9uqnchn+03/cZ3fdzVQNFn1TYwtrD51h4iLe7Z9SABYRvWXpE/ixda56/r4vHOd4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784253078; c=relaxed/simple;
	bh=ehdwnKH0KnfO1t0hmFD4xMehdeUzLLr4CJXWoLCPvvw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vkx3x49kKUahOeQuI6rDEJ5TXR73Uh4y9mA3ThZdeLaFYCnuTD5tw0GWdLPhT2vWvDLoBn/jjTjzMAeSHsx/FTwy6xaGoaT6kmuqg99TKMRwIvR6Zm21gk7r4/Z5G8xu2Aszes5YUhdK4/9hyBzSgr2eIRH27zVTurUv+fU/C7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com; spf=pass smtp.mailfrom=transsion.com; dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b=GrDyCMKb; arc=fail smtp.client-ip=40.107.75.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=transsion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b="GrDyCMKb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PtUke2ZMZU4f8+WFzWuMDFu26Gbb6RUlxSr31/k1vmm7LmvG1CzT/jQbBbnZ+hsmRVb3ediGgjX1FJUe0189AaP+leBbnRpmAXyp51ChVVjhK5Yjiomr0sqGDJ6fJdIXPyDWMUONN1h/fuVbtdRdqrxQ+OA2kVXiyfqLFmbBZcl5QLWewTSUH1qnmVbN0nduYQHPNMVqS7qXou0jWqYprM+Yc0ifJOL9CS9t5lmeB0RX+wjlJS3uThNelGP/wQ3CxKhx/lsUdaKKc1/ai9LwkbCUEJ8Nj1RSQSBpqlx/eCodbPnQ1ko1VSQ51JUm2igUA9fB1M2SaIoTzJQ92Ct+pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehdwnKH0KnfO1t0hmFD4xMehdeUzLLr4CJXWoLCPvvw=;
 b=SW9yFXj8MYUpnMLj+l1CQ3wI537Y+xhuWjDRDpRjR3pXqNFBRUorHU/7cpgD9hq0vioVY5K4s+1joPPwlyOIw4BS4W6hWZjNKAgFDO0AS+Mc+mKshjuMpETb/1muL++QpITndgc6fnA8MIoCIwoGCEUwqYnBOyFrqTIrUrAzmGvQWF71Htp/6xp4FrB/AazM4sDrFODFv9BU9yqaX6lQ3e4xQ4g7qIZu0/ICAdnurJBeqJqnmHZL/1slmnwBnOirviCjrFimu4z97j5rOXp4LxvbFvJBqMe2qY4cwdr+VXIDXLWlcijvbJOAIrxOH/nXYgB2igYbzyiT5YFyMHeokQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehdwnKH0KnfO1t0hmFD4xMehdeUzLLr4CJXWoLCPvvw=;
 b=GrDyCMKbnJJ9KvjiJajF420TsjRBPOj9tW1eHXI5+s0Upyb1umQvTjwububeDqFxA8O8MoKuDnGMjOvHaEjsK3xBHjLJksSC4kkSJQQbN3WzvItAVyYP9slhVfdwT0ik9re+YbvhdQ+SJ0vMTV0OLaga2eisnx02auHgC2vjlfA=
Received: from KL1PR0401MB6196.apcprd04.prod.outlook.com
 (2603:1096:820:c7::13) by OS8PR04MB8325.apcprd04.prod.outlook.com
 (2603:1096:604:2b3::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.5; Fri, 17 Jul
 2026 01:51:13 +0000
Received: from KL1PR0401MB6196.apcprd04.prod.outlook.com
 ([fe80::f2ee:1e28:9022:99f3]) by KL1PR0401MB6196.apcprd04.prod.outlook.com
 ([fe80::f2ee:1e28:9022:99f3%3]) with mapi id 15.21.0245.003; Fri, 17 Jul 2026
 01:51:12 +0000
From: Hongyan Xia <hongyan.xia@transsion.com>
To: Will Deacon <will@kernel.org>, Pu Hu <hupu@transsion.com>
CC: "mhiramat@kernel.org" <mhiramat@kernel.org>, "ada.coupriediaz@arm.com"
	<ada.coupriediaz@arm.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "davem@davemloft.net" <davem@davemloft.net>, Jiazi
 Li <jiazi.li@transsion.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>, "naveen@kernel.org"
	<naveen@kernel.org>, "yang@os.amperecomputing.com"
	<yang@os.amperecomputing.com>
Subject: Re: [RFC v3 2/2] arm64: kprobes: Allow reentering kprobes while
 single-stepping
Thread-Topic: [RFC v3 2/2] arm64: kprobes: Allow reentering kprobes while
 single-stepping
Thread-Index: AQHdEDXxWg6e3HuDfkaTSvkiR6Me8rZwLF+AgAAU4ACAAAuXgIAAsBUA
Date: Fri, 17 Jul 2026 01:51:12 +0000
Message-ID: <e0e800f5-a6f8-48ae-b55c-5c3d928bf234@transsion.com>
References: <20260710063242.228714-1-hupu@transsion.com>
 <20260710063242.228714-3-hupu@transsion.com>
 <aljbf_RmOd9U2KDT@willie-the-truck>
 <0f049d38-b7f6-47f0-a410-95ad2aee7fd4@transsion.com>
 <alj2uxE1M8mcMBhA@willie-the-truck>
In-Reply-To: <alj2uxE1M8mcMBhA@willie-the-truck>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0401MB6196:EE_|OS8PR04MB8325:EE_
x-ms-office365-filtering-correlation-id: df2f8e08-c53f-45a7-fb31-08dee3a5e1aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|3023799007|11063799006|6133799003|10067099003|56012099006|4143699003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 5KTa0oBzuOFVg1d9F3mz+aHZste1wuHOqrX054hD6ZzgPe33P9bQ+DKMbGW8zxAHDo+/s+Almnj3XkCE0zEVhuAfnqNqiTFDBsM+XXKHkxE1XPSgCm+De/mYOHt54APDS8fvRNpe3uMq/zP3hcLuvHQ+xJounPS+use85GhbOj4m3Sj2R+or0jm39GL6jxiqWfu5in+nFlfnDR2Rt2hETNJPtEiptbeHNHCIkA4fwnqtTRaO1xF/bp3L1EQQbKLBrwv0lZunmSO2G+L5AtPES2ZRNpUw5tHlQf3M6BxtVI6jrFoNkERg2AW/G6Ooz/UihMbtRgZzwA6ufVrxuG0wFll/lA1Xyz+TkPbxcauCtbAJvQUbVIotoVNve6mU2Tvy8S8wqEUp0Fmf9ts1CMzyjK8XYSzOE3Jqa0Tu/zqMilOQhSaawshq/Y4Ei8Y+KyPb6d9FyBr9msHIt1Kju77kBuYA0rRW59u40oL6lu9fmAH56Ug8o4oYf2ZeOuz4CCY5KzEU/I4NRVgu50n8NpGhHmSdp71RML5JyUvvbulZwFi9bkenmhjTS+bQrh4KOPw3b4qz9cuDtTVIog1C3DLxRW0WO1ICevAyf5yyVqFkTdJE7YAMnJHkwsi5Uh6bUGzfzP/yGJur1fhErWvSvpgAfIUMOUNNK227sYRAHalUDurxwa1rQWYk6VeR6VG9ZkL5NJuLbVLYsaq9/Dfx2rfYZw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0401MB6196.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(3023799007)(11063799006)(6133799003)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YmRsWGNQeEFWQVN2Lzl4ZzFsNVBHZWVpRTVzUVlBa1pUWlplK1EveFMvSVlM?=
 =?utf-8?B?alZyckNSM0FaUW04bC9sTi8zOU92cVJYeTFwOC9GWldiQUlHaDJwWUlEc2Fm?=
 =?utf-8?B?WkdSUzBuV1hvcGhMa0tFVkl5MnBIRWlSMkRQTkQ1TXNuT2xEbzRGWnFQa0ow?=
 =?utf-8?B?VkFHUjNoaS9Zait2ZkVCS3Q2Q01tNzByYmRuZW1TUmxmWUwreXUxek5QS3d2?=
 =?utf-8?B?RFI1cjRidnJRK05qRDd6aGt2d21QbkZIb0o1MU1CV0kwZlVVOWp1cVNtMzRW?=
 =?utf-8?B?czVleTc1cDA0bUlhWEY3dm9GMWtCMExyY3Z6TGZzR09kOE9ic01DaHNZYmZT?=
 =?utf-8?B?cERTdU52azh5d2w0b1h0SnZSSGNyZkhrODdpdWJ5b1J2TGMreUdWeTJNR3Q1?=
 =?utf-8?B?VC9YYkYxZktaYUswQkcyRVJicnVYeEZielluZGhURDZKRjNGdXlQS25GZDYv?=
 =?utf-8?B?amhMT3krYUw0NDBtSTF3U1o3REM3aUZvRmhmU1I4NmZScWFpL1Q2all3QUVy?=
 =?utf-8?B?aTZxUFRSUWttM2tQNjBmUmhUMGdGWThaQTRKVEhrZERMR0xCdWw1NWovZTFp?=
 =?utf-8?B?R25uZ2t4WjJLeURaMGRxeEQ3V3dQVENFdU9oTFRTM01RSHdubGV4aUl2RE83?=
 =?utf-8?B?Y09QMmJvbThVT2NZVW1CeTFkVlI5dFl2OVcwQ3hxZld4MU5JUmtqeUtPVHpK?=
 =?utf-8?B?N3FOeGJiUEcwaS96aUtRVVRmamdvbkZOMk4zZytsM28yOGtMVEZKd3NpdENI?=
 =?utf-8?B?eGdJUlRuYjRXQ3NPT1lXb0c1Tndib3JMWnRZQ0xFcXpCakxCbE5rYUdNSUIw?=
 =?utf-8?B?WWZhTUhLTHhnLzVxL1cweDdqcFZoY05LSk5YbnB3N0FWdGM0czk1L2cvRjd5?=
 =?utf-8?B?bGMySno2VUk3S2lSQ0tEMXdYM01BNjZpdE14VE13VW9VTlBVaXNhcENDU0Mw?=
 =?utf-8?B?UGV5YVl6UkszcHo1dU5uSCtPMGRPeTZFSHpnTWZTS1VUOWo5bTZXRWhvRG1t?=
 =?utf-8?B?OFBrRkE2UHo0Z0Z1WTlZTmVNV21PK0prV3RoSU9kT2ovZEVGTnRxWDc5VHhR?=
 =?utf-8?B?ckUvMUxLd2syaGdLbW9rMEJjS1ZYUEx6Kzhnem1jMWxwcFUxUjhFTDJQNC81?=
 =?utf-8?B?dUhORzRKSnNZSE9nSXdEMnpkWTd5VzFsZnJ1bFdpWmpOMTJoVWMwZGxDNGRY?=
 =?utf-8?B?Ny9ORkFPUjBYakJXc0ZNTkJIZG1CazlMbEdIclIxYWU0VXVMb1J2bWpmRm1l?=
 =?utf-8?B?b2NOMHh3R0VyQnJKR0VGUzdnbldZd3ljVUxxeEZPNjZrT0xkS1lKQjlQZ1ZK?=
 =?utf-8?B?cDlOelV0aVhzbDBOaFJjYi9XTDlOVVhneTVGMUJqWkUrQmVlMVMvUmJjUzly?=
 =?utf-8?B?NGlqREEvcHNrODJVVEtrcW1EbkFSZXZWVG9NU1FSb0o0QkJrU0VvL2gzUTB4?=
 =?utf-8?B?RmdlaHJaR0tNZ3pmekE4VXd1a2VqLzR6dFE2cFl0a05IVEtjcm1iM0pEWmtq?=
 =?utf-8?B?bU9SNjZXRTNFNFUxckx1UkJrcmVKUHBIT1hJaVNKb1RIYk5GU0QrVGpCcHVB?=
 =?utf-8?B?MXZLWHpTQ0IxRUVtRnVoSGhxL0xWcCtJY1Vna0lxZkdYRm1IcHZtMkxCazNh?=
 =?utf-8?B?WGJFcEd0akpyK3U3QVpQUmF5R1h2dFptUTcxN2tBNnJHY2RPbGpkVDdVNzh5?=
 =?utf-8?B?ZjVKL29iaTEvMGdRSHJ3M0JxbG85K2x5NDZTVDZVOGV3TUxxNE9ZNDFPaUJZ?=
 =?utf-8?B?cXRxUzZOOHdraWRYTnBTNkUvakRaL0p6L011N1RVWHh6SE0xM0R4YmxDTnhv?=
 =?utf-8?B?dGhUNGdwazNZaEFDMm0wRWFVK1NjTUQ5M2RoQVJWRmVyUGNDS3Y3bEJEeXdn?=
 =?utf-8?B?WmY3U3U3OW1aVlRENHh0T1laRFAxTmlUSkNyWFVwVktKWUpqRmxhaEwzNVF0?=
 =?utf-8?B?djFXZkdnVkMzVDFvYndsTVFDQTVQV0FyYkZZNTQyallWTllnNWxVbXMrWkcz?=
 =?utf-8?B?dWRqQ3A4bEFiMmE3OVRURjY2L3pYR2FKYzIyNTlpdEUvdlZhckM3UC9rYUZN?=
 =?utf-8?B?VTNvTzNqYThaazhoY1Y4Qnd4V3FYR21hS0RhZXZiWXB4Qk9LalZxcXZDcnBR?=
 =?utf-8?B?dmtRTFF3T0Q4U3I0bVhGTWRQK3UySVhNaXMzRUdMQVNuV2s3YXd6aDJwQkdy?=
 =?utf-8?B?OUZZRk0razZwUS82MCsxWlZ3U2RiQllydW5saUNTa1g5aTFKSXNnWWRtdFBY?=
 =?utf-8?B?ZFlTQlZkcUJvVjA4eXVlck9reFZWbGRBOVRKN2NvYnBFMitqcWxnWVg3TUFy?=
 =?utf-8?B?WWVwUjJ2eVBIYkgwUnEra01qcS9qR2FIaFpHQ0svVEszM2dEdW9aN3ZadWZk?=
 =?utf-8?Q?Ol0iJqgv/PD2PxEY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE5F8ABF5EE7A54C91BC129467D06E39@apcprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: df2f8e08-c53f-45a7-fb31-08dee3a5e1aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 01:51:12.8229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vLU8aEHP92N3ctssKpH42XRIVQZQzzo78zEnFtG5DrZ+sG3gA3yw34H3+aoNd8SyhKIh6fNgd0bzHv7N0bCU82vmRWDgWWvHGrrckSEF7Cg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS8PR04MB8325

T24gNy8xNi8yMDI2IDExOjIwIFBNLCBXaWxsIERlYWNvbiB3cm90ZToNCj4gT24gVGh1LCBKdWwg
MTYsIDIwMjYgYXQgMDI6Mzg6NThQTSArMDAwMCwgUHUgSHUgd3JvdGU6DQo+PiBPbiA3LzE2LzIw
MjYgOToyNCBQTSwgV2lsbCBEZWFjb24gd3JvdGU6DQo+Pj4gT24gRnJpLCBKdWwgMTAsIDIwMjYg
YXQgMDY6MzI6NTVBTSArMDAwMCwgUHUgSHUgd3JvdGU6DQo+Pj4+IEZyb206IFB1IEh1IDxodXB1
QHRyYW5zc2lvbi5jb20+DQo+Pj4+DQo+Pj4+IEEga3Byb2JlIGNhbiBiZSBoaXQgd2hpbGUgYW5v
dGhlciBrcHJvYmUgaXMgaW4gS1BST0JFX0hJVF9TUyBzdGF0ZS4gVGhpcw0KPj4+PiBjYW4gaGFw
cGVuIHdoZW4gdHJhY2luZyBvciBwZXJmIGNvZGUgcnVucyBmcm9tIHRoZSBkZWJ1ZyBleGNlcHRp
b24gcGF0aA0KPj4+PiB3aGlsZSB0aGUgZmlyc3Qga3Byb2JlIGlzIHByZXBhcmluZyBvciBleGVj
dXRpbmcgaXRzIG91dC1vZi1saW5lDQo+Pj4+IHNpbmdsZS1zdGVwIGluc3RydWN0aW9uLg0KPj4+
DQo+Pj4gSSBkb24ndCB1bmRlcnN0YW5kIHRoaXMgcGFydC4gVGhlIHNpbmdsZS1zdGVwIHJ1bnMg
d2l0aCBkZWJ1ZyBleGNlcHRpb25zDQo+Pj4gZGlzYWJsZWQgKGtwcm9iZXNfc2F2ZV9sb2NhbF9p
cnFmbGFnKCkgc2V0cyBQU1RBVEUuRCkgc28gaG93IGRvIHdlIGVuZA0KPj4+IHVwIHRha2luZyBv
bmU/DQo+Pg0KPj4gWW91IGFyZSByaWdodCB0aGF0IHRoZSBzaW5nbGUtc3RlcCBydW5zIHdpdGgg
ZGVidWcgZXhjZXB0aW9ucyBkaXNhYmxlZC4NCj4+IEhvd2V2ZXIsIHRoZSBjYXNlIEkgd2FzIHJl
ZmVycmluZyB0byBpcyBub3QgYSBoYXJkd2FyZSBicmVha3BvaW50IG9yIGENCj4+IHNvZnR3YXJl
LXN0ZXAgZXhjZXB0aW9uLCBidXQgYW5vdGhlciBCcmVha3BvaW50IEluc3RydWN0aW9uIGV4Y2Vw
dGlvbg0KPj4gZ2VuZXJhdGVkIGJ5IGV4ZWN1dGluZyBhIEJSSyBpbnN0cnVjdGlvbi4gQSBCUksg
aW5zdHJ1Y3Rpb24gZXhjZXB0aW9uIGlzDQo+PiBub3QgbWFza2VkIGJ5IFBTVEFURS5ELCBzbyBp
dCBjYW4gc3RpbGwgYmUgdGFrZW4gd2hpbGUgaGFuZGxpbmcgYSBrcHJvYmUuDQo+Pg0KPj4gQXMg
ZmFyIGFzIEkgdW5kZXJzdGFuZCB0aGUgYXJjaGl0ZWN0dXJlLCB0aGVyZSBhcmUgdHdvIGRpZmZl
cmVudCBjYXNlcyBoZXJlOg0KPj4NCj4+ICAgICAtIEJyZWFrcG9pbnQgSW5zdHJ1Y3Rpb24gZXhj
ZXB0aW9ucywgZ2VuZXJhdGVkIGJ5IGV4ZWN1dGluZyBhIEJSSw0KPj4gICAgICAgaW5zdHJ1Y3Rp
b24uDQo+PiAgICAgLSBCcmVha3BvaW50IGV4Y2VwdGlvbnMsIGdlbmVyYXRlZCBieSB0aGUgZGVi
dWcgbG9naWMsIGZvciBleGFtcGxlIGJ5DQo+PiAgICAgICBwcm9ncmFtbWVkIGJyZWFrcG9pbnQg
cmVnaXN0ZXJzLg0KPj4NCj4+IFBTVEFURS5EIG1hc2tzIGRlYnVnIGV4Y2VwdGlvbnMgc3VjaCBh
cyBoYXJkd2FyZSBicmVha3BvaW50cywNCj4+IHdhdGNocG9pbnRzIGFuZCBzb2Z0d2FyZS1zdGVw
IGV4Y2VwdGlvbnMsIGJ1dCBpdCBkb2VzIG5vdCBtYXNrDQo+PiBCcmVha3BvaW50IEluc3RydWN0
aW9uIGV4Y2VwdGlvbnMgZ2VuZXJhdGVkIGJ5IEJSSy4gVGhpcyBhbHNvIHNlZW1zDQo+PiBjb25z
aXN0ZW50IHdpdGggdGhlIHBzZXVkb2NvZGUgZm9yIEJSSywNCj4+IEFyY2g2NC5Tb2Z0d2FyZUJy
ZWFrcG9pbnQoaW1tMTYpLCB3aGljaCBkb2VzIG5vdCBhcHBlYXIgdG8gY2hlY2sNCj4+IFBTVEFU
RS5EIGJlZm9yZSB0YWtpbmcgdGhlIGV4Y2VwdGlvbi4NCj4+DQo+PiBUaGVyZWZvcmUsIGV2ZW4g
aWYga3Byb2Jlc19zYXZlX2xvY2FsX2lycWZsYWcoKSBzZXRzIFBTVEFURS5EIHdoaWxlDQo+PiBo
YW5kbGluZyB0aGUgZmlyc3Qga3Byb2JlLCBpZiB0aGUgY29kZSBleGVjdXRlZCBmcm9tIHRoYXQg
cGF0aCByZWFjaGVzDQo+PiBhbm90aGVyIGluc3RydWN0aW9uIHBhdGNoZWQgd2l0aCBCUkssIGl0
IGNhbiBzdGlsbCB0YWtlIGEgQnJlYWtwb2ludA0KPj4gSW5zdHJ1Y3Rpb24gZXhjZXB0aW9uLiBJ
biBvdGhlciB3b3JkcywgdGhlIG5lc3RlZCBjYXNlIEkgbWVudGlvbmVkIGlzDQo+PiBhbm90aGVy
IGtwcm9iZSBCUksgYmVpbmcgaGl0LCBub3QgYSBoYXJkd2FyZSBkZWJ1ZyBleGNlcHRpb24gb3Ig
YQ0KPj4gc29mdHdhcmUtc3RlcCBleGNlcHRpb24uDQo+IA0KPiBZZXMsIHRoYXQncyBjb3JyZWN0
LCBidXQgaWYgd2UncmUgZG9pbmcgdGhlIG91dC1vZi1saW5lIHN0ZXAsIGhvdyBkbyB3ZQ0KPiBl
bmQgdXAgZXhlY3V0aW5nIGEgQlJLPyBPciBhcmUgeW91IHNheWluZyB0aGF0IGl0J3MgdGhlIGtw
cm9iZXMNCj4gQlJLNjRfT1BDT0RFX0tQUk9CRVNfU1MgaW5zdHJ1Y3Rpb24gdGhhdCB3ZSB1c2Ug
dG8gaW1wbGVtZW50IHRoZQ0KPiBzaW5nbGUtc3RlcCB0aGF0IGlzIHRoZSBwcm9ibGVtPyBJZiBz
bywgaG93IGRvZXMgdGFraW5nIHRoYXQgZXhjZXB0aW9uDQo+IHJlc3VsdCBpbiB1cyBleGVjdXRp
bmcgdHJhY2luZyBvciBwZXJmIGNvZGU/DQo+IA0KPiBTb3JyeSBmb3IgYWxsIHRoZSBxdWVzdGlv
bnMsIEkganVzdCBoYXZlbid0IHVuZGVyc3Rvb2Qgd2hhdCdzIGdvaW5nIG9uDQo+IGhlcmUgZnJv
bSB0aGUgY29tbWl0IG1lc3NhZ2UuDQoNClRoZSBrZXkgaXMgdGhhdCwgd2hlbiB5b3UgdXNlICdw
ZXJmIC0tY2FsbC1ncmFwaCBkd2FyZicgdG8gc2FtcGxlIA0KY2VydGFpbiBldmVudHMsIGtlcm5l
bCBwZXJmIGNvZGUgd2lsbCBzYW1wbGUgYSBwaWVjZSBvZiB1c2VyIHN0YWNrIGVhY2ggDQp0aW1l
IHRob3NlIGV2ZW50cyBhcmUgaGl0LCBhbmQgY29weV90by9mcm9tX3VzZXIoKSB0cmlnZ2VycyBw
YWdlIGZhdWx0cy4gDQpTYXkgeW91IGFyZSBwcm9maWxpbmcgcHJlZW1wdF9lbmFibGUgZXZlbnRz
Og0KDQoxc3QgQlJLIC0+IHByZWVtcHRfZGlzYWJsZSgpIC0+IGRlYnVnX2V4Y2VwdGlvbigpIC0+
IHNldCBTUyBzdGF0ZSAtPiANCnByZWVtcHRfZW5hYmxlKCkgLT4gdHJpZ2dlcnMgcGVyZiAtPiBw
ZXJmX3NhbXBsZSgpIC0+IHNhbXBsZSB1c2VyIHN0YWNrIA0KdXNpbmcgY29weV90by9mcm9tX3Vz
ZXIoKSAtPiBwYWdlIGZhdWx0IG9yIDJuZCBCUksgb24gdGhlIHBhZ2UgZmF1bHQgcGF0aC4NCg0K
VGhlIGtleSBpcyBwZXJmIHNhbXBsaW5nIHRoZSB1c2VyIHN0YWNrIHdoaWxlIHRoZSAxc3QgQlJL
IGlzIHN0aWxsIA0KcnVubmluZy4gV2hlbiBhIHBhZ2UgZmF1bHQgaXMgaGl0LCBhIGNhbiBvZiB3
b3JtcyBpcyByZWxlYXNlZCwgaW5jbHVkaW5nIA0KYSBwb3NzaWJsZSAybmQgQlJLLg0KDQpIb25n
eWFuDQo=
