Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022140.outbound.protection.outlook.com [52.101.126.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C0E331220;
	Thu,  9 Jul 2026 14:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783606951; cv=fail; b=lNJM7QHkXFsK38lg1sWCssfFe0FKBclVKsQnwpvv8ljucgy40PN4v1G5hiM89wKobC4GotWUzwV20e7Ay2ZCrAftOfMAIgFWKHUopLEBWXCu1noChzYRktwRJUZpDcDuwBRGv7sSq4DF+Zukhbvmpgt692iL0U9u02NAunvxjYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783606951; c=relaxed/simple;
	bh=sgy7E2OZkO+H9PyA74fUzxxqdicE8cyvRbsGS/K9RLc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VXHOTxFBklBWkvm08OlJj9Plr//Nm1Z9m/QJyh0+RhifFDwCwlY52GS6NgX3oqsiMfgFJWKeFbZRd5eb8iR9kpiDDUIggK+ewN1Qs9EYrS8ktuf9jFfB4CpfcNegcub3FyQFaTTJDHXG67rfZthtn+L0UgYjn8Sre0GbLNWLhQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com; spf=pass smtp.mailfrom=transsion.com; dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b=WZQaZpxH; arc=fail smtp.client-ip=52.101.126.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=transsion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b="WZQaZpxH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ksg8b4TzyCIinr71KqEoj5gOFIVxb23bwxMGCEBi8kI4trZS51Mzjhi+x0oVY++qXQA8rb7Zmi2Kb0U0dYAcbODUq8hKBaMZOZQMP41GWzw9jrSkJN0rdPDVQi6k6BvRTtwl9JNaa3147NEOQQ7DUQ1CRuwqsPkssFGWGeGnkXC1wFTx31XGRssbU2/faVYQOWvjQ6qxmyCCShIlOckw+fRTrPWKiziopz/SDVtAfFwBladrwsvdqrnjT4mAgXRdpQVKsItq2EB34Nb/+qxvLPWC9dONQyWVyqexjbBX7ZeMa2Z6vPK5B7ZnAgN9oKxfY5C1g9yQhVxClROT3e3VFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgy7E2OZkO+H9PyA74fUzxxqdicE8cyvRbsGS/K9RLc=;
 b=RM11xfs61ov+ih3T4ckex1J0FtrR4iN4BMGFFBU3QQDIP+4caq79R2g6bgaczX5fFR7guA/tLCklzVdeED6xNgrf7ph7XzT9CppZ9ZtI2l0DeCecOcff3tQnYI+QYJ9QiS4GtIyvJ0pTv8qELlLO+WhBRjqRu8Dv3ye+IJzbg7dxH9FSqoK05F1aq/nV259hb8RXoJ5DwR2t3GDp2Wl1x/9fcPYhaQmVGDS/wd5L52Uv94WqskVuv64WTnrjAWrKoy1RaD1kz4pEXgsTtOV/Rka1a+XWe/PrXCh4Gjfk2ZBoQdg8CrerC/qN/ENJedjRL51BoB39h+e11nvjMBBkJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgy7E2OZkO+H9PyA74fUzxxqdicE8cyvRbsGS/K9RLc=;
 b=WZQaZpxHiV01+UimA2qFovSTadFlmmxtHfKb2ySTEPB8Qz/5zJc5UPMDzYwrRfrxPeuqwBiDm+tTLEB6aavQPiA9+Aym1IGlIvmz3EiK2lNdgedgraTZcaVR9iyIqqA1WCu9hk2DmJyfOjRUMP3C037ABfVfpRgiGRAgPE4uxt0=
Received: from SI2PR04MB5648.apcprd04.prod.outlook.com (2603:1096:4:1a4::11)
 by JH0PR04MB7844.apcprd04.prod.outlook.com (2603:1096:990:9b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Thu, 9 Jul
 2026 14:22:25 +0000
Received: from SI2PR04MB5648.apcprd04.prod.outlook.com
 ([fe80::8ce1:b82b:3b19:f79d]) by SI2PR04MB5648.apcprd04.prod.outlook.com
 ([fe80::8ce1:b82b:3b19:f79d%5]) with mapi id 15.21.0181.008; Thu, 9 Jul 2026
 14:22:25 +0000
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
Subject: [RFC v2 2/3] arm64: kprobes: Allow reentering kprobes while
 single-stepping
Thread-Topic: [RFC v2 2/3] arm64: kprobes: Allow reentering kprobes while
 single-stepping
Thread-Index: AQHdD65dtlWwozfAw0OlEAyKRHtrcA==
Date: Thu, 9 Jul 2026 14:22:25 +0000
Message-ID: <20260709142215.226872-3-hupu@transsion.com>
References: <20260709142215.226872-1-hupu@transsion.com>
In-Reply-To: <20260709142215.226872-1-hupu@transsion.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR04MB5648:EE_|JH0PR04MB7844:EE_
x-ms-office365-filtering-correlation-id: 3c111b18-a49d-4458-ba5d-08deddc57fc6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|3023799007|56012099006|22082099003|6133799003|11063799006|18002099003|38070700021;
x-microsoft-antispam-message-info:
 GhX2TDt3rQyLJ3jIbSfOKoRdtEn51Mlrrdv2BFaW+pocJcDJuuU1n9snxLaXGIxLFZ/kvtEPfAyn9e1yV6y5qURydJpH3Pi9bs0Yn9/Iw9UJWRdT65/OPYNgaJMZiFwUfDbW/4bBKUCuEehGytI5iveU5OROAuYyov4oRIRgDIjGj6sAW4FQY2IxZV6V+3RrGRn4D6rzo7HR9cKPDc4DeqWag2+24pSVFKDCmgNAooY7pgSU0F78chStwylBv5moN0jvT51qOFbL3s0S8sEPcly3AG8CmnYTtE1obv0BlNNXmxxgDAk4qGsTJYWerZQCZqi75Drcnq61Fh6GYSS6LUF7oXGyTYBuISd5qYYslH30Lg9gH4fA0INby3HcJVsh0sl+Ai6AFdYPoPXi5H9GWCRTpWT2XFnM8RimGZTuHLsliqM6bRj5RJ+GfTLw0+/Df8x0gEexTbDrp61IOFHgKMHcV+4oQ3kwhkEocKMBG8PGJlpBL1GsKUye4/rwCSm5d0m9j7npCBdH6dPUxS2CobG9A9P3ACyCSU9KuoIFHE4Y9okZUzeN/ecv38sXV6qq2cZLXVU2FAW9qfwoO1y8tDtZcMLkY9WcrROJERtSqfJa6STpACMHKLpbDHHjGRMRpvnjwRRA2ZoBHZNwuHcbWKb+I1TArn+ZAw9MjDnXfga/bIIh5Es0fPoSI6oMAvaA70wg18dyQ7v3IGN964jj+oml8d12Fh2pMgymc6fjkpQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR04MB5648.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(3023799007)(56012099006)(22082099003)(6133799003)(11063799006)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NkRRY0lla0QycXk1MDZmaWlyWUs1b0QvZWdQTjFhUml2eE5neUI1WURPVTRP?=
 =?utf-8?B?aTlBSS9OVk05d3pheWdJMDUveVBKTzBhSkx5MjlhQVB2dVNFdzM0SWpOMktV?=
 =?utf-8?B?U0FwME9uQk95anZlTUJGUGpSeHlXc2FiZjdWaVBYSU1uOXVvOXdwTTBmNCtt?=
 =?utf-8?B?SU42QlNxSkw4ZC9iRW1XMDc0SjZiNStPUU5ReW16bHVUVDBKWHdDc2cxZ0x1?=
 =?utf-8?B?d3h0dVFiMkNVdEowZWxwekRjcWZLekhvbVRLT0ozcC9nV2hQaFE0NmxIVEZK?=
 =?utf-8?B?T2lDU3g0TFpTbGw2bkJ2VWlraU1mcng5K3E4dUJqcU56Q20yWnJDU1RYRkps?=
 =?utf-8?B?dE1hZU1YdmxzdGY0c1NBeFEyMXpSRzhwQzVuTlRhT3E4Q2d2SllmMHNCWjVn?=
 =?utf-8?B?ZWxwTEY1UnVsSWVZUE45ZHJmekNSbytnTXFYSExmOHRSOE1VQnBMQmZsU2RJ?=
 =?utf-8?B?RkZseng3WG0vanhYUXRDQjNrM0UrbEtkanU5RTExNGVReWEvTi9xMHRPdUJ3?=
 =?utf-8?B?bnp6UlIzdkE5TFloZStON2R1UlN2QWpzdUVhTkxDZmlyaTRoWVhuTFZ2ek1t?=
 =?utf-8?B?RkZFQ2NsVFA4WkJZWVd1dk95N1RONktNRkt4N0kyWHFNQkJjemNkU0U4ZjRq?=
 =?utf-8?B?NldDTUx3TWhGNWllSVVaNytZNThUUWJBZ2dHMUVzOU5TRWJIOEZFUTd1Z1BT?=
 =?utf-8?B?UXdCUlF2OEs0UW5jUnNQVXRySmFDSEQyOWQvR1poVng1bTI3bXh1MDl1UWF6?=
 =?utf-8?B?YlpIMGJUbUFVcTFjTDExb2Y2SnIrems3RkJsenNzd1A4SUpnK2RnbVFmYlJu?=
 =?utf-8?B?aUV6SlZuT3pHTXk4WkxPQzYvU3Ivc052Ky8xODZiS2lHdEYvNEhvZElLTC9u?=
 =?utf-8?B?bWFUNkxkaXRoNzhQOTl4anRIY04vc0Jla0w4YjYzaXJobEg2VVFoTXBJNTh3?=
 =?utf-8?B?NGFNMXFJbmJJcUJ3NzVZSVhHMTZITnBBYWtxVi9iNVdWS0JoQnBUQlkrSE1T?=
 =?utf-8?B?UitycTR4OE1TSlphbi8vOFdaazhCTnlMT3pzSEZEZmtQdFhhY09aUUpIdGJr?=
 =?utf-8?B?Q0M5NmNBZExKeUIrRDlNRUg1c0ZOV212bitXMXRMbGJPQnBPS2ZsMkIrS2xQ?=
 =?utf-8?B?ZzllVnJ2N0N6RXdTTXdJWXlZZVV6S1NFYjBPTm41aDZuUXR1VVduVXJBWEpT?=
 =?utf-8?B?RTFZOUdIbGp4RitqdFpkVUZKWGVJaHNrNlNLZ0dxa2I0djRuVmMwazBsV1BF?=
 =?utf-8?B?WHBJMERtRVJDMXY3TTVtV3hLY0ZYdUJQZlZtcEhzSUYxcWxxTmhTclVvZWov?=
 =?utf-8?B?VzJHQ1BmMzk3VXZhMWNsbHRXRU9JaGs4ZmdBSFFrelBicFJyemRQeUZ5dWx6?=
 =?utf-8?B?L3pTR1FSNndSbGFmYjBpdnliSU1WRWtIM2czbmRDUUhDMDYyRlAyRmIzYlRt?=
 =?utf-8?B?SlJvWFIyRlZTbDkyc2VwYmRlZ0d5RVJCVWlRN0xFdklMMExmY0ttbXZzR2dj?=
 =?utf-8?B?dDJJMFhydWV6T3VpVlpjbm94LzlyZDJMdEZQOVhlcG9ZczFTL1dBMXQwdkRj?=
 =?utf-8?B?NWl3bm11ZVVLODc5MlNwWUFwZzFsbWFOZ1FlOVl4NlYrS3NpbkdPd1lldVJz?=
 =?utf-8?B?VWJFc1N3cUdoYkJTTGJaT21rN2hLMkdQMUErZTZsdFBkSWQxL2thZ0piYkha?=
 =?utf-8?B?Mlk3cEZFenhEUUMzVWhkOTVnU1NMQTdFUkZGeEJEenFwM0ZXMkRyWEQrT0lw?=
 =?utf-8?B?VmVHaGJCYmRDaUFyTENKSVBxMTRNUkQvTElIT1hoUmJZQ2JmVDhQSGRMTmcv?=
 =?utf-8?B?S2p4NDliQzFLRWd5WXZUV09wOWpRR05PWnVJZmhzV1NRNHAreUlVS0NCVENQ?=
 =?utf-8?B?d0pkV0piOUJiRWVYeWlPbHB0OVFJZVdXSk1IUGF3Ti81Ulc4UlpwWktQVksw?=
 =?utf-8?B?V3hvek1RZTA1aUdQUWI3TnBEVFhrN0lna3hkNHREWGRlSDA2WVl5b2FtWWI4?=
 =?utf-8?B?c0ZacXU0OFBZOG9KaTVJbDgzNDlRd1p3aU0yRGRLYktVTTF3NE1RMTBOZkxB?=
 =?utf-8?B?QjNwTFhsazkyMytEdkg5Umtwdm9lUlc4cExaL2VBaVBwQVVFQXF1UDYxZzVy?=
 =?utf-8?B?Wjc2MzEwRmE4ZE94NHRpUTVOK3BnaHI0RWhOcnRzcGNweE5rc0R5TTJza2Zm?=
 =?utf-8?B?eWFsV0d0NGhLUThTUUhmWTdXWDZRay9GQTM5YXI2Rjh5ZzUxNk9vRUZxdnNX?=
 =?utf-8?B?dFJ4WDZsZVord1dWZ1gwd1ovVmVKcHh1dll6ankrVnNDZktuWnphR0J2REc2?=
 =?utf-8?Q?18wnBv2vZ/1eDFMHfk?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c111b18-a49d-4458-ba5d-08deddc57fc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 14:22:25.4601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zr35re+VHqq6i8ol7VDuRFIhOaxMqETyLaIaSu5vNl79IBvGvJZdP8NpPQaWctgxIteUFLTRCY+44PXGq6hxlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB7844

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
cm02NC9rZXJuZWwvcHJvYmVzL2twcm9iZXMuYwppbmRleCA3OThlNGIwOTFkMWEuLjJjYTU5MTZl
Y2EyZiAxMDA2NDQKLS0tIGEvYXJjaC9hcm02NC9rZXJuZWwvcHJvYmVzL2twcm9iZXMuYworKysg
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
