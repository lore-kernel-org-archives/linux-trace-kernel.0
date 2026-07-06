Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023120.outbound.protection.outlook.com [40.107.44.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DF83F99EA;
	Mon,  6 Jul 2026 08:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783327026; cv=fail; b=HgkS8smJ05wU9lkuhydU70PPKPQXD6HODcdvF3HcHMYQy4LYtjK/m9idM6wT0sXLdtMINRcbe81lM7ZCVKKDRvzCF1NMrvTZ2FOREizzdANNuxC5CPJnRmCYGFtSA49PfiNV8IM99Rr5o6S6B99pLSbTIa3jFNs53gEQzzlGfjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783327026; c=relaxed/simple;
	bh=aSgQsao0Uc/e3TnXtnfPQHEIqJdp+nTd2ZK9xbvueDM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sZcpluXizcMsnY0m8411LFeP2IRx40HYDNi3ZoYxEt0t+D87fCTeiahc27tfQL2EE67xKvNq5zAuqq8vzqEpA9BJP2hm5rF0NmguVioqdCWtPHPATxvq5Rp+foeWv55Stq6OH3klh8zn1xzX1OOuWhpLu7F0d847VXcwcJcjpKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com; spf=pass smtp.mailfrom=transsion.com; dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b=MDMoX5xN; arc=fail smtp.client-ip=40.107.44.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=transsion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b="MDMoX5xN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EWD86DCqjVAJhPXEnGupcOkl13iv5G+P6kMCsF87qzLJXHGNz0U3aU6FxfKQXPIse94vtCtmVY0uuKyTn+Ok6ACXzC8XnDQFffuor5ThJNKSeB79fkGBMi729tks1wRv1alTbdDBUxu7qhqAu0ysqEi3E4eEL7WbJxKQJiRZXfP1MTNgzvE/e70Kl7K43/qHbJCa7cMiDezI6eGKYJ8hevuACHIG8nWhAGAgIHpJdUWMLP7B1nwFHRq9m+fqh8Yb0kPE0IhNtEx4muvsfCoZKdMdRBgX5/efAAg0sghjB1t8ejO7rXy2gX2Hvs+5rmLEI0WJboI+WJ1D8/K9deUOqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aSgQsao0Uc/e3TnXtnfPQHEIqJdp+nTd2ZK9xbvueDM=;
 b=fshdCZOqIqTFFUqEUbSuYsafZG79WcTniDhq1iDC18TvvHsro2k9XA7zBGUiWxdrmLqAtQP5gWVh2Ebpx4z4XH9etUCdBEKDpol7iC+vJ/IiDhHqGzLoIaeOWS35KdjKffOk3SuTkDIw38wjBoQfe6AJkqZbMLaoIuuvuYqrVJ1cpi2e5eokJnTrQPOXgJeKKEZ3hZ/SdS49QJSuRVxQQmPrpqaWpanBrko+AUsDaNfb+5KyQDT9xbgb/d53ymdZ3GA21j477qg5bYZJYcMco9jcTrANdBK48coqUeNwA5nZrHuwLwF7BtREYE9LkrlsmXgs0DwT77C2kJPj9oYWPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSgQsao0Uc/e3TnXtnfPQHEIqJdp+nTd2ZK9xbvueDM=;
 b=MDMoX5xN+WYLM2SOqOj+pQ5GYbLuibdRygSu2yHY8kkJ0O3ETXzUgMxg6fMChH0tiyshJsKJa0/QbMG4IsKJ1ic8hiT+9BD6LwyVgvdSz3yr+GBM/sTD/hap2EqiTXIlWT+X0AGgArwWMcGEeFE8SFhmIaZcg6EkYckOYyPVeKE=
Received: from SI2PR04MB5648.apcprd04.prod.outlook.com (2603:1096:4:1a4::11)
 by TYZPR04MB7280.apcprd04.prod.outlook.com (2603:1096:400:44f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 08:36:47 +0000
Received: from SI2PR04MB5648.apcprd04.prod.outlook.com
 ([fe80::8ce1:b82b:3b19:f79d]) by SI2PR04MB5648.apcprd04.prod.outlook.com
 ([fe80::8ce1:b82b:3b19:f79d%5]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 08:36:47 +0000
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
Subject: [RFC 0/3] arm64: kprobes: Fix single-step fault and reentry handling
Thread-Topic: [RFC 0/3] arm64: kprobes: Fix single-step fault and reentry
 handling
Thread-Index: AQHdDSKUJXKpnQVbM0+1R0h7jaRVmA==
Date: Mon, 6 Jul 2026 08:36:46 +0000
Message-ID: <20260706083636.159883-1-hupu@transsion.com>
References: <20260704234730.46d51c47d75e7d208e7bec9f@kernel.org>
In-Reply-To: <20260704234730.46d51c47d75e7d208e7bec9f@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR04MB5648:EE_|TYZPR04MB7280:EE_
x-ms-office365-filtering-correlation-id: a1784742-f15c-45f4-cb4d-08dedb39b76e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|3023799007|11063799006|56012099006|6133799003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 Etc67n6dwk2xMQPDPIApI0ECUvdXqwqcJyUzo6vHcLSodlBJPTl2a0sMqFVk1dFczF6SuWIx1Ka0s7HKvDhFCu8bA/maXHjQAG8sV79cJaqRj+yQ53ROPKtzF17GsdxvYxxTHeaVrIjrbjk/VRIPxcgbcgvmLoKyIi7bI00+MkIMP4Xa9DK/nNwPXjfAiLcX7i7wi4laynKEMBq8GrRUHEJoHgW5MepCZrF/oO7qN5ILiWV3OED6bGGGvcrSEizBlYdccJCSi1vN9pxAoIKBbtrzhcAliKE6QC1YIXv/Fa4h/6hmShXeC0ekcJp5CYc4njwad2urw4nsQYEwddPeviXLIQw6DgU3APZYgoKDl13Yk1Snl4+LGfp9uxpCI7N8um4Rar1sM6BTqRXjgnGgbX/usCgaSVZvqxc2PIxGYycqNA8TOTFO2Cmf7XMYOcWaOb39RxwC8hdkHKdOeMm9oZUzyqMNPSvkKBTAOO9KZ9Y9oBcqxQ0PTeov6F3eM88W4RZBMCUx11Wkv/wbsY7bX2eiBxAlID//gi5WVeD9mVCtkcMaNy8FJ3hTbrO/9Sv937duBvQNkPpUkEjUcLQw1Jcd6YBar6UwTpatE8STuWXWWiHrRko5lDflPkFme9F2uD5qzi9jjAqxI8E95CVgreZUMcwZ7NetbQ4rQhfevCW9qJZyrBYJZEh9H8HkXyHdMbcR76FbnLbk2OZZNHNpLKobv0tiaw4/t2wAA9P8fEE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR04MB5648.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(3023799007)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eDJ4cjgveVd4alN5WHI4OGVVaDFDSTFsQ2JGRFZUNVIzVDRjQTZVZS9IK24w?=
 =?utf-8?B?KzIzMmpwRUYzTGZueWFwcWFBWDNuZEhFYTNJMlJnVjVUZGlhY2tHa0YrNEhR?=
 =?utf-8?B?S0pZZHpuQi9uRmxac3IwNzZwRTFFdFNBSDVzdEtCQlptL1VGdEM4NXY1c3Nr?=
 =?utf-8?B?YTJ3Y2w1MnFoNEwydGlwVnc2N1IyUWpBRVpjYjQ5US85TjA2WVI2YnA3Y0ta?=
 =?utf-8?B?Ni9RdHc4RCtCRUYzTmpTc2hxWHZyMkxVeDBZUzZHRlFpM2JQUFNNNzVYRCti?=
 =?utf-8?B?SGQ3Nm9vSkI5MlVLUEhMa252blQvbU9RY1ZmeXhjNENUVWVFTHdpM1h1WnVV?=
 =?utf-8?B?bkxucVBOSkcyUGIxVHNxbzdCaEFRZlU1R1dQdUN3NTlEb1J1cHoyV2I3Vm1W?=
 =?utf-8?B?WlFTS0E1YXZMQVZ2SmhoR2pwR05jeGo5OXFkSmtKeUxsMDlYM3NtVTRrVWI5?=
 =?utf-8?B?UDBxL3YxR3NYSi9yMmU2dnVTeXpCWnBwN1BwZng3S3FMbU5qNVQ4NTFqUzE3?=
 =?utf-8?B?OWtuR25EZDFwUjllUy81cTU4L3ordnRkSXJNamdISndrWEtmeWRuNXBZc0NX?=
 =?utf-8?B?MFBiQ1JYMEs0Z0dXR0tRL1JKL0ZTT3FzdjBGTklETjYwUDRuMkJlTE43aVVl?=
 =?utf-8?B?MDZQb1h2V0J1UnJlNEhrSnpLSnZ0eHM1SklhSFlpWThZQjArWUtoQmo5Witz?=
 =?utf-8?B?MGNxM2FYSk9EU2FiY3gzUDc3RFEwY3ZROHd3a2swMU5HY1Nxd0dNYW9BVkxi?=
 =?utf-8?B?azVnOW5qdTBBNlUrS28wK0lCazlQVlkxZklwdGhyK0hNQWppOFdjSHZnRjVw?=
 =?utf-8?B?Qm9hTHMwZnZlbzNHakE2Z04zbW0xWVo0MGo5RUkwL0JLSS9kZ3czOU52RE5W?=
 =?utf-8?B?ZHd3a0loRGZVYk81ODU3SUhxS2hVWVdnYWsyUUx6bEVhVnA5d0dMYzZCY0xG?=
 =?utf-8?B?VjNrTnoxN2lFTWRibzhDMkpKamZldE1JNzhpSHNFT3dXWWNab3VZNVRtMGtq?=
 =?utf-8?B?MnBYTjBLbWh2dlhzS29SdTJaN0JReUVzMHJHZnMrckVQOHNLWEpLSDhYM3Rq?=
 =?utf-8?B?dWNPb2E3eE9nS2daMmFaU2g3V0paZW1DNVRWVzNsaU42TFBOSjNhMTZicUl0?=
 =?utf-8?B?ZS9DbDJlWThUeFMvSDRkdCtvOXhqelRNcDlnY2h2Y3VhUUk3WW01OE1pYmFD?=
 =?utf-8?B?SEc5dXNuWUlaZkdiN2NSNUQ2ajcxU29YQU90bXlueVFjSGNmNTR6WGRoTkdp?=
 =?utf-8?B?dUpDNnA1eVlwQnorOW05NHZKdnZOT1U2NHVBaTZuWGo4UnBBcGRJSVFHUEFo?=
 =?utf-8?B?a1lLQzhabHpWVUtSSUVMdGwyaE1EWDBtblhyNFBmckhTQjRERVp4UldKWVpm?=
 =?utf-8?B?a3Y4NGpnTDFHSHZxM2JFRVZ2WXQvakFZUWJPaFpDdDZ0cXE1di9rV2liRldw?=
 =?utf-8?B?U3lydUdGVjZCQkJMZ0IzSm5JZWo3eDdadWdzbzFYL2w2TDFJQ2pVbmV4L3pS?=
 =?utf-8?B?allRUnJEdUw4NkYvUmJnTFRzbDh2OE54UEVoYTZwYTlMc2s1NjJPZG9Bd1lT?=
 =?utf-8?B?Z2xWbE1XM0k4WENHbXR2aFhQKzhsZzJzRkFNVFRDdy9ucXJyamswNzNTdmQv?=
 =?utf-8?B?bGVwZXFjaEs2WFozZk5NUndoQTJaRytmTU4yRnlUWm13RythSnh0QVV4anpL?=
 =?utf-8?B?d084RG9kT3lkVTlpRkh2WXA3VG9Ma21PdjA5VUtVVFBoN25nTmJQUE8vbzgz?=
 =?utf-8?B?QzJxR0NIc3ZmTnJHRERlZjh2SG1UNG5KbGZ0d1BmTU5pYU9oZ2w2eDRCMjlZ?=
 =?utf-8?B?THcvZ0JXOGhRdUlNaEwwZUVvSGhhUlNBbWxkbGVhTklFQkU1MFlSdTUxbysx?=
 =?utf-8?B?NWJFM002UFJwdFZOQWJsT3lHcENHcHNOVGY2Zm9SaWNWU1ZvY0RlSncyMzZ6?=
 =?utf-8?B?YnFNRVBHcTk3MnpzWFg3SzJNMEltK1p0dEw5ZUJaRFBVMEpnMUUzdmZmTjJs?=
 =?utf-8?B?VTJLYUlramxZZHpvb2dXQlhENDFlSHQ1UFM0bXo5RU85cCtyRnEvUkZIcURN?=
 =?utf-8?B?Q2p5T3pxRHR6WnFVUzlZRFFQdUVEMng2TWVOd2IzQ1BsVVFLTlRtM25CYXNQ?=
 =?utf-8?B?U0c1VDJ1Wk1QeHJYS0o0OEgrZXB1VVlwQzM5dkFnM25DNHAvSkJRc0wyS1VL?=
 =?utf-8?B?K2pLWHVXdlhDSEgyazlKeHFkWmRaOFFDdldtMDkwQ1FVOWdPV3hFTmozeXFO?=
 =?utf-8?B?WnY5RU9aRFA3R3E1a0tOTk5VU0E0TTR5Z3NaeWFjbEJvT0RQcFJ1cEcza2NH?=
 =?utf-8?Q?EtnQSqf5pzRK2SxcHG?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a1784742-f15c-45f4-cb4d-08dedb39b76e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 08:36:46.9858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bvPU44na506t9tlpDOFZDmg5cBVA1IntbrXI/ltS76KqVOxTaRAmjHe/Q61cFxdW3jysw+AbgaykIx0RkWR4ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB7280

RnJvbTogUHUgSHUgPGh1cHVAdHJhbnNzaW9uLmNvbT4KClRoaXMgc2VyaWVzIGZpeGVzIHR3byBh
cm02NCBrcHJvYmVzIGlzc3VlcyBvYnNlcnZlZCB3aGVuIHJ1bm5pbmcKc2ltcGxlcGVyZiB3aXRo
IHByZWVtcHRpcnEgdHJhY2Vwb2ludHMgYW5kIGR3YXJmIGNhbGxjaGFpbnMgd2hpbGUgYQprcHJv
YmUgaXMgYWN0aXZlIG9uIGEgZnJlcXVlbnRseSBleGVjdXRlZCBrZXJuZWwgZnVuY3Rpb24uCgpU
aGUgY3Jhc2ggaGFwcGVucyBpbiB0aGUga3Byb2JlIGRlYnVnIGV4Y2VwdGlvbiBwYXRoLiBXaGls
ZSBhIGtwcm9iZSBpcwpwcmVwYXJpbmcgb3IgZXhlY3V0aW5nIGl0cyBYT0wgc2luZ2xlLXN0ZXAg
aW5zdHJ1Y3Rpb24sIHBlcmYvdHJhY2UgY29kZQpjYW4gcnVuIGluIHRoZSBzYW1lIHdpbmRvdy4g
VGhhdCBjb2RlIG1heSBlaXRoZXIgdGFrZSBhIGZhdWx0IG9mIGl0cyBvd24Kb3IgaGl0IGFub3Ro
ZXIga3Byb2JlLgoKUGF0Y2ggMSBtYWtlcyBrcHJvYmVfZmF1bHRfaGFuZGxlcigpIGhhbmRsZSBh
IGZhdWx0IGluCktQUk9CRV9ISVRfU1MvS1BST0JFX1JFRU5URVIgb25seSB3aGVuIHRoZSBmYXVs
dGluZyBQQyBwb2ludHMgYXQgdGhlCmN1cnJlbnQga3Byb2JlJ3MgWE9MIGluc3RydWN0aW9uLiBP
dGhlcndpc2UgdGhlIGZhdWx0IGlzIGxlZnQgdG8gdGhlCm5vcm1hbCBmYXVsdCBoYW5kbGluZyBw
YXRoLgoKUGF0Y2ggMiBhbGxvd3MgYSBrcHJvYmUgaGl0IGluIEtQUk9CRV9ISVRfU1MgdG8gYmUg
aGFuZGxlZCBhcyBhCnJlY292ZXJhYmxlIG9uZS1sZXZlbCByZWVudHJ5LiBPbmx5IGEgaGl0IHdo
aWxlIGFscmVhZHkgaW4KS1BST0JFX1JFRU5URVIgcmVtYWlucyB1bnJlY292ZXJhYmxlLgoKUGF0
Y2ggMyBhZGRzIGEga3Byb2JlcyBzZWxmdGVzdCB3aGljaCByZWdpc3RlcnMgYSBrcHJvYmUgb24g
YSBmcmVxdWVudGx5CmV4ZWN1dGVkIGZpbGVtYXAgZmF1bHQgcGF0aCBhbmQgZHJpdmVzIHJlcGVh
dGVkIGZpbGUtYmFja2VkIHBhZ2UgZmF1bHRzCmZyb20gdXNlcnNwYWNlLiBUaGlzIHByb3ZpZGVz
IGEgc21hbGxlciByZXByb2R1Y2VyIGZvciB2YWxpZGF0aW5nIHRoZQpmYXVsdCBoYW5kbGluZyBm
aXguCgpUaGlzIGZvbGxvd3MgdGhlIHNhbWUgbG9naWMgYXMgdGhlIGV4aXN0aW5nIHg4NiBmaXhl
czoKICA2MzgxYzI0Y2Q2ZDUgKCJrcHJvYmVzL3g4NjogRml4IHBhZ2UtZmF1bHQgaGFuZGxpbmcg
bG9naWMiKQogIDZhNTAyMmE1NmFjMyAoImtwcm9iZXMveDg2OiBBbGxvdyB0byBoYW5kbGUgcmVl
bnRlcmVkIGtwcm9iZSBvbiBzaW5nbGUtc3RlcHBpbmciKQoKUmVwcm9kdWNlcjoKCiAgc2ltcGxl
cGVyZiByZWNvcmQgLXAgPHBpZD4gLWYgMTAwMDAgXAogICAgLWUgcHJlZW1wdGlycTpwcmVlbXB0
X2Rpc2FibGUgXAogICAgLWUgcHJlZW1wdGlycTpwcmVlbXB0X2VuYWJsZSBcCiAgICAtLWR1cmF0
aW9uIDkgLS1jYWxsLWdyYXBoIGR3YXJmIFwKICAgIC1vIC9kYXRhL2xvY2FsL3RtcC9wZXJmLmRh
dGEKClRoZSBuZXcgc2VsZnRlc3QgY2FuIGJlIGJ1aWx0IGZyb20gdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMva3Byb2JlLyBhbmQKdXNlZCB0byBleGVyY2lzZSB0aGUgcGFnZSBmYXVsdCBoYW5kbGlu
ZyBwYXRoIHdpdGggdGhlIHRlc3Qga3Byb2JlCm1vZHVsZSBsb2FkZWQuCgpCZWZvcmUgdGhpcyBz
ZXJpZXMsIHRoZSBjcmFzaCByZXByb2R1Y2VkIGZyZXF1ZW50bHkuIFdpdGggYm90aCBwYXRjaGVz
CmFwcGxpZWQsIGl0IHdhcyBubyBsb25nZXIgcmVwcm9kdWNlZCBpbiBvdXIgdGVzdGluZy4KCgpQ
dSBIdSAoMyk6CiAgYXJtNjQ6IGtwcm9iZXM6IERvIG5vdCBoYW5kbGUgbm9uLVhPTCBmYXVsdHMg
YXMga3Byb2JlIGZhdWx0cwogIGFybTY0OiBrcHJvYmVzOiBBbGxvdyByZWVudGVyaW5nIGtwcm9i
ZXMgd2hpbGUgc2luZ2xlLXN0ZXBwaW5nCiAgc2VsZnRlc3RzL2twcm9iZXM6IEFkZCBrcHJvYmUg
c3RyZXNzIHRlc3QgZm9yIHBhZ2UgZmF1bHQgaGFuZGxpbmcKCiBhcmNoL2FybTY0L2tlcm5lbC9w
cm9iZXMva3Byb2Jlcy5jICAgICAgICAgICAgfCAgMjIgKysrLQogdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMva3Byb2JlLy5naXRpZ25vcmUgICAgIHwgICAyICsKIHRvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL2twcm9iZS9NYWtlZmlsZSAgICAgICB8ICA3NSArKysrKysrKysrKysrCiB0b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy9rcHJvYmUvZmF1bHRfc3RyZXNzLmMgfCAxMDUgKysrKysrKysrKysrKysr
KysrCiAuLi4vc2VsZnRlc3RzL2twcm9iZS9rcHJvYmVfZm9saW9fc3RyZXNzLmMgICAgfCAgNzAg
KysrKysrKysrKysrCiA1IGZpbGVzIGNoYW5nZWQsIDI3MyBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pCiBjcmVhdGUgbW9kZSAxMDA2NDQgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMva3Byb2Jl
Ly5naXRpZ25vcmUKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9r
cHJvYmUvTWFrZWZpbGUKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9rcHJvYmUvZmF1bHRfc3RyZXNzLmMKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9rcHJvYmUva3Byb2JlX2ZvbGlvX3N0cmVzcy5jCgotLSAKMi40My4wCgo=
