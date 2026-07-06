Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023120.outbound.protection.outlook.com [40.107.44.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2196A39182F;
	Mon,  6 Jul 2026 08:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783327021; cv=fail; b=rHh+f97mGCx+R2wAdMHvNQVCsq0suhYTidew6M7FPokNr9ATQjWvVGsi7XR/qD/a0eUZCNKd23AiHxWtkuYhhdvoepbEUziPURSUb2xK/Pud6jq45oin0cxqfeGlyqJsZamI7HfgHGupJwJtSUqAzZFu62x614tYY4FSqdzYNOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783327021; c=relaxed/simple;
	bh=ffpiIMLML6ylw/tz+4M9SudHBDmybHdFUOlZmkCSujE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EPK2GfevrCnnPYtV/BFbdEE395NHmZGe72jOIiIvcqYWN+lwwWcosUqjV80pb8J/vmZ7N0jwbMN3g9UYmOmFEuT2/2TuPxvY+IHHXgjKOEMLxptE+4VlHaKPjdkh+5NzBEN0+SI3GUnB+bEgzp0g3sKGVvqMNft6mLx1tDldT14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com; spf=pass smtp.mailfrom=transsion.com; dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b=h+lqpbXd; arc=fail smtp.client-ip=40.107.44.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=transsion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b="h+lqpbXd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EBXTdbHAkpr6yN8i03naUWAWZpMXRhd2dFXFzdUBVlFJBEyRx8qeeqPjRDYMR5CkFoqj2vbfUzrUqIVsKASssvjznZyfu6obT4cNWJMfbs5DQjwTsrDNsMOObYxo6AYPQlw47ncRY3QpAJ7eFVU6X74nKHccBwQk6EYOgEq0d0O1EtaEsJogPMU4ea/QZqUCkkdc3txfMvalEQRWi6kvAsJykbvO7ioP+IgOkWQKAr3enojaZS+FlMKtEmrOcsM0CWsJP43q2x/fcsXRSxQsFMIwv8mUH2VHdkSQq9Vxe/Utd96PgzONJQ79qj3XnoienETDgLEOMCJgdEYjKMClCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffpiIMLML6ylw/tz+4M9SudHBDmybHdFUOlZmkCSujE=;
 b=hlwaJAUtgnnOQJq8k5Nzgo6pNbWNEgEP3WcbZdvD8KAUpOQi4eDczUYm/oDOHNeMBdt5U/+nT2u60CUFNqumRtCSNFhtFYHEFtfxsp0T6xgJH0cIyh5FrvJNwCsAouHwiDsxVjNPK7Q/r7EB8mVCHj0JnjibrnNaxUASDLx/duw2GitWZTsRdxbvTmfqS6CNb/DcSIWw7D6SSexDiT7xCt/w1MJg63OJDLn2Qv5s+7dNPBGYR+wwoNeDlSuOK3lpkNNyy1QT8PdoQow2Kzz9F7mWfS6x89KYWYhUOW5f1WwYLCd9YZ6Ch+ckNUaJhPeK7YcZCt+DXcHb9RB408IaMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffpiIMLML6ylw/tz+4M9SudHBDmybHdFUOlZmkCSujE=;
 b=h+lqpbXd2A7TZvrs+Oz2Mkn+qp1VfCOJzCwXkq4QYD+2Ih+zUcvP+LF6sxsTH72xm25NwWh8aX96EYmecvQd/+kma6w6pfmVuTNKd/SrSFpL3cVnixf0N6ixviusa3wwksptws21GN31ov/18x0syCR8MD4eRln+ig+QB8OfyKE=
Received: from SI2PR04MB5648.apcprd04.prod.outlook.com (2603:1096:4:1a4::11)
 by TYZPR04MB7280.apcprd04.prod.outlook.com (2603:1096:400:44f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 08:36:48 +0000
Received: from SI2PR04MB5648.apcprd04.prod.outlook.com
 ([fe80::8ce1:b82b:3b19:f79d]) by SI2PR04MB5648.apcprd04.prod.outlook.com
 ([fe80::8ce1:b82b:3b19:f79d%5]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 08:36:48 +0000
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
Subject: [RFC 1/3] arm64: kprobes: Do not handle non-XOL faults as kprobe
 faults
Thread-Topic: [RFC 1/3] arm64: kprobes: Do not handle non-XOL faults as kprobe
 faults
Thread-Index: AQHdDSKVlCmiSnJh4kOzbIHc67X2KA==
Date: Mon, 6 Jul 2026 08:36:48 +0000
Message-ID: <20260706083636.159883-2-hupu@transsion.com>
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
x-ms-office365-filtering-correlation-id: dffe615e-b758-42fc-784b-08dedb39b856
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|3023799007|5023799004|11063799006|4143699003|56012099006|6133799003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 cWKule04JebHx5YMbAD2pJu2GSezstZc2J4PPVwUszXLjYIoMVO76VcPfVSrH4xrLzbEpWk6bKzzs8m7n6oFCVKBDKfhocgCY82EFdSykAoKXSFdVqQbf20g1VsvkTMrLCAwyGv0kaaM5eeR9XJGZFwPZkZZj4X8oLKV+eIyxs0jfyqmGVRSD26wQREfzrqSxX/fD3IcD7Oag9s7LZUD6SOuPG/c5vfVkS9jht4q9049r7ke0EM3OpYGxInUU5IYZKczcux7iIZtnpbMMcjx2EkG60W2tRlpdcQCy25kI1/64t2OvUQpKtwbbT6ll0KCy++o36mIchaOdzHiJQW1ExFzy8AnU2MoSj2vugQdka2KHducf7kL+ns7NHQ/H+YFZDNAjrBfOcQtWK7StK8VJK5dg7VpEF3MGkX+cfOjSUWt0jehTPwUXQ13lN4vFDgMOO/gVLhBiQv9d5eXLJB+TMw9M1CtLE9GIUa7tS/HvgXTi5bZyVXasL+DKQzI3mnTuntLYSBDDKw1I9PRyEhoQwZYzTgIRj9WxKhWqj459o0g7xQK60OLL9KH8Lx3jnwI5FNmjRopUATitMfgkmwSmeMy9cGvMPKVcdK9/71icFB9p/qEr/VV6EromseSuCVVzu8wqVVbddmSoLtiH1UL5M2upjUscYd4rOvdFTxPwQV7R3LlJ36c3UFLMU0FicWoRk5qbzwsL9chF8SQpviv+YttZhuJG6MfzaG7BHOyW+k=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR04MB5648.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(3023799007)(5023799004)(11063799006)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NVB1ajVPcWVsbmlpVHdSazZHTGJkeXlJemowOXBGTEh3TjFkUTlQYm9rTjZq?=
 =?utf-8?B?Rnpzb2FjY2x0T01vY1AzSlp6N3pYbnlOcllTTFRjcVphOFdVZFV3clhRWkFM?=
 =?utf-8?B?eTJSUEt1REc2SGNJYnU3c0N5K1lCanpjWThkZjFOdlZPMk5LOWVJVVRiQVVE?=
 =?utf-8?B?MGR4Nk4zb1hBUTdYS1pScDRNSGcxOFdDV0M1aUNPR1VQNWlVNEZxTUg3WEZz?=
 =?utf-8?B?TXF6T2NhRXZNRVdETlVvcDR3MWRFNjNYWTQyb09FMm4zNnJYQXdTM1FvYUpx?=
 =?utf-8?B?LzF0cHBINXBmeFNIVW9ORUFzRTVBV3MyN0lvRUk1Q1RwMFVGWEU0RkFra3NB?=
 =?utf-8?B?L01ER1pOYk1iOVVmeWNMMDlSTGVNbTR0bmovK04yRThyNVhFMkNNdEJnR3RI?=
 =?utf-8?B?VXdNbnowWSthNDVNNHQvZ0R4SE1aSUpQTzY5QjUvZTA5Qy9VWWVERUlYMkg3?=
 =?utf-8?B?VjU4Y0Nld1U3RWp1Y1NZeFJkdWJEZVNkc3dRYVpZWHgrRjRMOEpyVWFNSGtZ?=
 =?utf-8?B?eXc5cW9oSHROb0lHUU1ZWWdwbGh3UDdvYitrYm94VnNGYXZRZkh6MnVlKzJK?=
 =?utf-8?B?WCtVaUdpWWczdHR1dXhaZ0I1cDBhTEFrMXJpbllyTWlXdSt3YzM2NndkTGZh?=
 =?utf-8?B?T3FCcDF4RTF4OHpvbkdKbHRkOFFSUXg0OXVKRHhSOHI0ZFBFSHRYNks0UGpk?=
 =?utf-8?B?a3RYN3lKVzA0K1ArRFN1WnJTY3RPUVBqNVZZZkRzdkJQZkNablJ4QzE1QnM4?=
 =?utf-8?B?cEI5SVZGcjhIQWVzTGdGODFCRTNUYnNhOGVyOFBZcCt4OExLcngyWll6UitQ?=
 =?utf-8?B?Zzd6VFgzdS9vdmlwSnpvZmx6aFNzSHRETkRvcmlrS1pHdk8zVitHWk1IMlZK?=
 =?utf-8?B?d3IrTGRIUU9uNlk1SEtHdXdtUmZCcXNxdkdnNFZHUDZrS2g4VjZNN1JENUMx?=
 =?utf-8?B?bmRsN2dSdUFjR2IrdDFNdGg2NFdudTI5VCsySnNBTzJCVXJoV2xlOGMyMWpR?=
 =?utf-8?B?U3ZYblpQaWFzTDN6VHFWcUR4UklYUnVKc21jS20zUE1WZFFKYzVZWjhEOHR3?=
 =?utf-8?B?M04xaFROVGI1OCt2UCtVT2VyYWtLNG1DR2hSRzh2SE5RbUk3QkZGTHU4clNW?=
 =?utf-8?B?aXltcG1UdzlSWXZBQWYwS2xlMzZabGZqVWc3NHhqTXZraFVyOXZSdlJ1VEdC?=
 =?utf-8?B?UTRvNUk3cEl6N3E3Yjh6d25NVjExdWI1MWxXdWlEb2xVam1acWRIdHgvZFpl?=
 =?utf-8?B?bzJraXpNSW81QzhITUpQS21pN2JKN0NlQWN1dWtBZlJjL1Q3Ynl6Nkp0ZVZ0?=
 =?utf-8?B?VzNzNVVXQmtiR1U1SlhFTTgzOHpYMUkxdW1xcmNhKzJ6TDZ2alhwL21hdkZU?=
 =?utf-8?B?bXFIU3U2eDZ6bGRzTWM1SnRzSTR0cWJzTGpvNVFyYjNLNExsNUErZ2tBSUNH?=
 =?utf-8?B?L2s2MUFMbjkrQWVESUtyT0NCbjJ3NC83Wjd0bk5XS1dxci9UcUQwYWhSRzRs?=
 =?utf-8?B?MU44SS8wR3JnbklxZ2JvVHU2U2JGUSsydUlKTTJGU21UUXBvRWtsTkUyclRu?=
 =?utf-8?B?RTlvaHgwWXRubi9weVlUQ3A4Y0I3bEhaM2RUYnphQ1dSTG4zekJpaUtTMkVM?=
 =?utf-8?B?YTlMTEIrVnk2SjFTTWFCMFV1VXNSM2o3U0VPMmVTcGFDTTczUFM0Yk5EVXli?=
 =?utf-8?B?SFRVa3I3SmNmYWRBcU0yeld0YUFMeW5UeDNDNzZqaU44MENQQVRsYVpvV0d4?=
 =?utf-8?B?elNLc1JyUnVLK1J1SUVGUUhZME5RdzhwakdMQmo4U3VWQ2s2UUU4WnBNK3Rn?=
 =?utf-8?B?a1NnWFFBS3l3V3ZLWTV0TU5DajBocUFXS1ZkZUFPdDBsM0Y3cFl4cHIvV0p1?=
 =?utf-8?B?Z0JGMWZUT24ybStNWGxQUGxySnZLT3IxT2N2cUdmTms5ZkJ4dlo4R3lYbFVP?=
 =?utf-8?B?VmRiTXMxVGY2VXdsZTIvN21UenJUb3kxeEhGNFZMVHdOWFlrNVlnWjEzUEZ5?=
 =?utf-8?B?RHlrR3dKSnE1cll3OUZTd1duRnFOL3BOZk10d21KazFMa3lTYXBaZlVWM3JC?=
 =?utf-8?B?V1ptQm9KR3pGQXB2emhvOHVKd042anEzYzRvb0pxTDhkMENYYkROZlVBa3ha?=
 =?utf-8?B?cUVwamdUTG5hSFIrMkhUL2s2MWwwSHZ1OVNpdFR4VjVLdTBUbndzRmZSeFZV?=
 =?utf-8?B?SzUrTklJOEJnMncrd2x2blZqOFUxWTgrWDJxY3dLekg3QWRnR1lyTjIvN0pa?=
 =?utf-8?B?eDVwVWxVL3hwc2ZieG5GdStWRkY3bjhJWGxSR0NEOUhML2xzRUhzRXRxeEdX?=
 =?utf-8?Q?c1pFlpzYCve5YggRWt?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dffe615e-b758-42fc-784b-08dedb39b856
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 08:36:48.5103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PtUch5Hl9sNojbDNHxrcQSv35sfIeK4GKNj38E85L3rbgDXRCVW3AtoHxwqoJWxb7NFjkROYBMv4AP5eMUB8Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB7280

RnJvbTogUHUgSHUgPGh1cHVAdHJhbnNzaW9uLmNvbT4KCmtwcm9iZV9mYXVsdF9oYW5kbGVyKCkg
aGFuZGxlcyBmYXVsdHMgdGFrZW4gd2hpbGUga3Byb2JlcyBpcyBpbgpLUFJPQkVfSElUX1NTIG9y
IEtQUk9CRV9SRUVOVEVSIHN0YXRlIGFzIGZhdWx0cyBjYXVzZWQgYnkgdGhlCnNpbmdsZS1zdGVw
cGVkIGluc3RydWN0aW9uLgoKVGhhdCBhc3N1bXB0aW9uIGlzIG5vdCBhbHdheXMgdHJ1ZS4gV2hp
bGUgYSBrcHJvYmUgaXMgcHJlcGFyaW5nIG9yCmV4ZWN1dGluZyB0aGUgb3V0LW9mLWxpbmUgc2lu
Z2xlLXN0ZXAgaW5zdHJ1Y3Rpb24sIG90aGVyIGNvZGUgbWF5IHJ1bgppbiB0aGF0IHdpbmRvdy4g
Rm9yIGV4YW1wbGUsIHBlcmYgb3IgdHJhY2UgY29kZSBjYW4gYmUgaW52b2tlZCBmcm9tIHRoZQpk
ZWJ1ZyBleGNlcHRpb24gcGF0aCBhbmQgbWF5IHRha2UgYSBmYXVsdCBvZiBpdHMgb3duLiBJbiB0
aGF0IGNhc2UgdGhlCmZhdWx0IGRpZCBub3QgaGFwcGVuIG9uIHRoZSBrcHJvYmUgWE9MIGluc3Ry
dWN0aW9uLCBidXQgdGhlIGtwcm9iZSBmYXVsdApoYW5kbGVyIG1heSBzdGlsbCB0cnkgdG8gcmVj
b3ZlciBpdCBhcyBhIGtwcm9iZSBzaW5nbGUtc3RlcCBmYXVsdC4KClRoaXMgY2FuIGNvcnJ1cHQg
dGhlIGV4Y2VwdGlvbiByZWNvdmVyeSBmbG93IGFuZCBsZWF2ZSB0aGUgcmVhbCBmYXVsdCB0bwpi
ZSBoYW5kbGVkIHdpdGggYSB3cm9uZyBQQy4gQSB0eXBpY2FsIHJlcHJvZHVjZXIgaXMgcnVubmlu
ZyBzaW1wbGVwZXJmCndpdGggcHJlZW1wdGlycSB0cmFjZXBvaW50cyBhbmQgZHdhcmYgY2FsbGNo
YWlucyB3aGlsZSBhIGtwcm9iZSBpcwppbnN0YWxsZWQgb24gYSBmcmVxdWVudGx5IGV4ZWN1dGVk
IGtlcm5lbCBmdW5jdGlvbi4KCkZpeCB0aGlzIGJ5IGhhbmRsaW5nIGZhdWx0cyBpbiBLUFJPQkVf
SElUX1NTL0tQUk9CRV9SRUVOVEVSIG9ubHkgd2hlbgp0aGUgZmF1bHRpbmcgUEMgcG9pbnRzIGF0
IHRoZSBjdXJyZW50IGtwcm9iZSdzIFhPTCBpbnN0cnVjdGlvbi4gRmF1bHRzCmZyb20gYW55IG90
aGVyIFBDIGFyZSBsZWZ0IHRvIHRoZSBub3JtYWwgZmF1bHQgaGFuZGxpbmcgcGF0aC4KClRoaXMg
Zm9sbG93cyB0aGUgc2FtZSBpZGVhIGFzIHRoZSB4ODYgZml4IGluIGNvbW1pdCA2MzgxYzI0Y2Q2
ZDUKKCJrcHJvYmVzL3g4NjogRml4IHBhZ2UtZmF1bHQgaGFuZGxpbmcgbG9naWMiKS4KClNpZ25l
ZC1vZmYtYnk6IFB1IEh1IDxodXB1QHRyYW5zc2lvbi5jb20+ClNpZ25lZC1vZmYtYnk6IEhvbmd5
YW4gWGlhIDxob25neWFuLnhpYUB0cmFuc3Npb24uY29tPgotLS0KIGFyY2gvYXJtNjQva2VybmVs
L3Byb2Jlcy9rcHJvYmVzLmMgfCAxNCArKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDE0
IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2tlcm5lbC9wcm9iZXMva3By
b2Jlcy5jIGIvYXJjaC9hcm02NC9rZXJuZWwvcHJvYmVzL2twcm9iZXMuYwppbmRleCA0M2EwMzYx
YThiZjAuLmU0ZDI4NTJjZTJmYiAxMDA2NDQKLS0tIGEvYXJjaC9hcm02NC9rZXJuZWwvcHJvYmVz
L2twcm9iZXMuYworKysgYi9hcmNoL2FybTY0L2tlcm5lbC9wcm9iZXMva3Byb2Jlcy5jCkBAIC0y
ODUsNiArMjg1LDIwIEBAIGludCBfX2twcm9iZXMga3Byb2JlX2ZhdWx0X2hhbmRsZXIoc3RydWN0
IHB0X3JlZ3MgKnJlZ3MsIHVuc2lnbmVkIGludCBmc3IpCiAJc3dpdGNoIChrY2ItPmtwcm9iZV9z
dGF0dXMpIHsKIAljYXNlIEtQUk9CRV9ISVRfU1M6CiAJY2FzZSBLUFJPQkVfUkVFTlRFUjoKKwkJ
LyoKKwkJICogQSBmYXVsdCB0YWtlbiB3aGlsZSBhIGtwcm9iZSBpcyBzaW5nbGUtc3RlcHBpbmcg
aXMgbm90CisJCSAqIG5lY2Vzc2FyaWx5IGNhdXNlZCBieSB0aGUgaW5zdHJ1Y3Rpb24gaW4gdGhl
IFhPTCBzbG90LiBGb3IKKwkJICogZXhhbXBsZSwgdHJhY2luZyBvciBwZXJmIGNvZGUgcnVubmlu
ZyBpbiB0aGlzIHdpbmRvdyBtYXkgdGFrZQorCQkgKiBhbiB1bnJlbGF0ZWQgZmF1bHQuCisJCSAq
CisJCSAqIEhhbmRsZSB0aGUgZmF1bHQgaGVyZSBvbmx5IHdoZW4gdGhlIGZhdWx0aW5nIFBDIGlz
IHRoZSBYT0wKKwkJICogaW5zdHJ1Y3Rpb24gb2YgdGhlIGN1cnJlbnQga3Byb2JlLiBPdGhlcndp
c2UgbGV0IHRoZSBub3JtYWwKKwkJICogZmF1bHQgaGFuZGxpbmcgcGF0aCBkZWFsIHdpdGggaXQu
CisJCSAqLworCQlpZiAoY3VyLT5haW5zbi54b2xfaW5zbiAmJgorCQkJaW5zdHJ1Y3Rpb25fcG9p
bnRlcihyZWdzKSAhPSAodW5zaWduZWQgbG9uZyljdXItPmFpbnNuLnhvbF9pbnNuKQorCQkJYnJl
YWs7CisKIAkJLyoKIAkJICogV2UgYXJlIGhlcmUgYmVjYXVzZSB0aGUgaW5zdHJ1Y3Rpb24gYmVp
bmcgc2luZ2xlCiAJCSAqIHN0ZXBwZWQgY2F1c2VkIGEgcGFnZSBmYXVsdC4gV2UgcmVzZXQgdGhl
IGN1cnJlbnQKLS0gCjIuNDMuMAoK
