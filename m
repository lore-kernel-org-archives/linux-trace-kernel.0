Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022140.outbound.protection.outlook.com [52.101.126.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D817331ED8;
	Thu,  9 Jul 2026 14:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783606949; cv=fail; b=oHKdl3nlWgtY5IuulhSr6u7E5mVq2LHtoCwpCzsmZmiFTjhV5I+SrzIyiqoCavoW/7uEH09QrV+K/bStNX4s/O8xjnWjPFsPgTxF2zK/kANh5YyQAFe8Pl5e2XNDPs7l/G9972yqTjNFZW9ZqZbJT0tjmQHhV4kaVpAI411WSjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783606949; c=relaxed/simple;
	bh=unzF02AFuCtsiCaUvnCmEnIo/QPH97b2pSQ9IcGmSkw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mW6cnCPbEPeOs5L6zk7yyXSNKYq5qo29N9n+hzMXBnoSJWekjogtU3tx37XXQ7owiLGUGH9hLSrJZSO3Lc5/NMj9BCz8zXfxaUtPujhN22YzOBvEsZJacwQSsnJUhqY88E9C8vfhggvG16Dlj0K8tig+9mwjO0eGkaUAUlcm0rg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com; spf=pass smtp.mailfrom=transsion.com; dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b=BBDD8P+4; arc=fail smtp.client-ip=52.101.126.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=transsion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b="BBDD8P+4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cz+aloDBgpHVbVBz/9y4cqgcRFSSTBtSv/2Hnu5Ai9pMwS7ilxzF2j4jccBGWw217jhhIlEMB3OIGUfoWKTpDyAlgrV1n7NG6Vq2dYwmjDzvlaOrn4Wij53dhD9UwLZbg1AyZ+N643JKZZxo6RKbk976cJsi/qarLWLtkbD2OdWNcZeGisZeLgnExjI3LZlCZJoHnVGSQ9i1M99yHPcGd64USTJVtGvFegPE4NvpVtwsRatvOjrTMO1U/YGpAI+nfiFlAj3Hxc29G4eEPTPWqqj9wMB0e3xdqi9Yqa2HJnQftbE86vT5j0lcaILnpXPNpsFCBirpljyl+8MPW2Z7Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unzF02AFuCtsiCaUvnCmEnIo/QPH97b2pSQ9IcGmSkw=;
 b=ct5o/jqxd1wrwFMIUSERy+ECr6zpc/7LodPQ+TaLZDKFLe+WAXJYGsGO6Dcpg4g/TQJubbo4DSEIKsQNxba4qXl5WlkOFI5J7/EBCvvfdNY2SX0ACzjf9BucwIaBvcV0cuUzL/wDsOKYYMNQhBg/bp41EqocVnCXKFA1zKB9Zkrf8KXaFuJzzrFdsg1MhDpnJ/asVBUoyORb3xQKL53SQqc2YtG0RDaq3INrj/sHtDMSb077W7VUuE6vL/7Sa83bdhFBp/nNG4GErWp85eveXtw8LfwmPD4+BGimXNLHZWhFLM2NWqikjfon9z0JwAS1R37GsphYblmmsFgYhPgUqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unzF02AFuCtsiCaUvnCmEnIo/QPH97b2pSQ9IcGmSkw=;
 b=BBDD8P+4Wrg57CtwWuHJLLrYyHIBpwRbAxBd6+eXX1Pghi7jRCqZKnt+0waAnyH5KneeEGbd9BQxLvHcwZ37q1+3RpSPh/nLsPli21Es2NH3eRFWUXEIeGdSZxMbrjisAidYT/mRWHIfgWddvKUyDOJfwP6e+bgs21BgsA00uOs=
Received: from SI2PR04MB5648.apcprd04.prod.outlook.com (2603:1096:4:1a4::11)
 by JH0PR04MB7844.apcprd04.prod.outlook.com (2603:1096:990:9b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Thu, 9 Jul
 2026 14:22:24 +0000
Received: from SI2PR04MB5648.apcprd04.prod.outlook.com
 ([fe80::8ce1:b82b:3b19:f79d]) by SI2PR04MB5648.apcprd04.prod.outlook.com
 ([fe80::8ce1:b82b:3b19:f79d%5]) with mapi id 15.21.0181.008; Thu, 9 Jul 2026
 14:22:24 +0000
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
Subject: [RFC v2 1/3] arm64: kprobes: Only handle faults originating from XOL
 slot
Thread-Topic: [RFC v2 1/3] arm64: kprobes: Only handle faults originating from
 XOL slot
Thread-Index: AQHdD65czXHWc2M4qEmsnu+vAweSHg==
Date: Thu, 9 Jul 2026 14:22:23 +0000
Message-ID: <20260709142215.226872-2-hupu@transsion.com>
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
x-ms-office365-filtering-correlation-id: 64953fbc-4c94-46fe-9211-08deddc57edf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|3023799007|56012099006|22082099003|5023799004|6133799003|11063799006|18002099003|38070700021;
x-microsoft-antispam-message-info:
 2bOtLBu4wU+ZiWF50bUBua6hLwrj64jYY5j12149WS9J2rRBYtm727IREf3s3gg7DnqyYSxbel74glgZqjf7GfNioz4+UmXj4flP3+FgpGSmwAS/y9UyJ1CEX2b41hRggmfcdZ1MpuAkIfxJMWvlz7xJzyhKGviRnJI5chAhQjvqu2YfLyhk3XowxD+xHFhhcUPHkidiVDAnIEajnANeA7ylr2jpYqbW1gYgWwyYtzNy73S8N4fa7GDvSmPSB0wU+7b0N7XjBWKaB9QICap166cnhtUbwG+521fXWNkDpHAKQtgtF350GVNc+znovmO462N74rRrEldSqbe4BI1Oz/zYzRUVcI6csSKY5waYBesTvbQI9Lq5WZTJUTYRYy2hT5+E8pI0ng0do5pGuniEuwhlwqxsy/IhapcMSt66h3+ml+BG97saBEmeKYf51wMeSH1RhgBPY+gEm0K5gVYhh0NtvH9aCCv3FED8CFsvqYRYqCZhhVwe5Ynrs3D87niDUzqSZ0T+5WYK43YQQFUM+Nw4VqhCkcVWK/JnP6FAB7wV4h2duLuUPHURuSYed6guGkyNF0lmsyZphxUxJ+ZyOgHc6iRXN1mK3tjKlgAVO7iTWjQekzXMCLSuh0SzAwZlcmFKrmZVCLPXwYxStqStLmdJ4TZOkCFC0czUfRuCcphTmWxkFdt7A1iRWOcGoV5g58vRmRxOua/PnCFwgo9Ext7L0Z4gbv7cESoFIae3Z4M=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR04MB5648.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(3023799007)(56012099006)(22082099003)(5023799004)(6133799003)(11063799006)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aFJZYVVSTFZ5S1BLSzFsVFl2S2hOUkRtbWMzMWpzanJZY0hoVmt0M0dpaHB5?=
 =?utf-8?B?aCt6WDJ1dzRiWlVBOEk0YnVMMEp0OWVHVFZRRmNoS1FNY0U5dzN3U2xSaFRl?=
 =?utf-8?B?VGZIZGpEaUM0SG1HaHZDeWVDRm1IVlByUy9HTXVTK0twVGpva0xnK2Q0emI3?=
 =?utf-8?B?bEFJMENscHk3TGpQdmRGN04yTTFmb0VQeEtIT0dqSG9LQlM2M1MxaVAxUWtZ?=
 =?utf-8?B?amVtMHl6YklFdUF2R2tZdTBQOTR5UkpWNDFzVUZmU1kzR254ODFwWmxtcTUv?=
 =?utf-8?B?S2h3bUEwcHJ2N1pqUnFOR01vMkpuWDI4NW9uaWI3R3pENSt0TTJUb0x3VWtM?=
 =?utf-8?B?UDNyd01iQm8xOWVmcG5wcGhvK0JjM2dWSEE3Rk10R0ZqeEdpb3IzZUJKMHFu?=
 =?utf-8?B?S1VPMW9LNjhza05wTmNlQUlUL2l6elpoZ01yVG1pbTlBZzBMT0FpKzRranE1?=
 =?utf-8?B?U2NlRkk2M2FLb0dTdmsrMlk1WXdXVTRQZVhnN3dVNHRIa20yNFBrNlZaVzZs?=
 =?utf-8?B?RzNUbnJEMWNPY290ck82bUxFV3c4N2JjY3IrSnNUanJEaXhCZlRXcThDQnBT?=
 =?utf-8?B?UWo0cVJFbnBHbWFxRno0RDZnL0FJQlJHSSt5QktKWmhtdEJuOUt4Qk1QVTJT?=
 =?utf-8?B?VUoza1dGWXpTNFphdC9hYmM1MTBlT01HNElvWVMyS2hiQ1FSTlUvUHFRS2Ji?=
 =?utf-8?B?bVhjWFk2UERSZTNUdVppN0hJL0dHREJwdWNBaUZ2M1BabzlTbFFqc2psV2cw?=
 =?utf-8?B?OHhlMHhSZ1ZDNERCaWNlK2NpbDE5dVVTZUgyakhKa0kzM3BoMFcwUUtLeS85?=
 =?utf-8?B?SXgxQnMwU2toQzFLY1duWU9UTlhqd0Q5Q1d1N2NxTkI4c3A1VnpSaWx1ZTcz?=
 =?utf-8?B?eURZSUZGVkNvM0g1ZlNqdWt0c2g2MW1iNmtyTUxEcm5ZKzNMT09MOHVuOUl5?=
 =?utf-8?B?S0Uyczl5M2YzRnFGYjV1dHVML3hQTXlmQ3F4QlJXS3orQ1dXSGRzTmVvNDY1?=
 =?utf-8?B?QWUzcTBwb0wvVlFiekhORHpSSWViQjVFS1NRZThad1JFU3Z6T2FJNmYyRkI5?=
 =?utf-8?B?c1JQcTBJYzZvUjFLZko4T2h4Wjh4c3JlQmlMckU1bXlMY2xUUmpJTUpXUVhS?=
 =?utf-8?B?b0NFV1l3TkFqUi8yc3FCVk5YZEJmVlFVVXlpamJEblUwd29wTTVmdGtxVkxD?=
 =?utf-8?B?UnpJeU1kdWVJcWtGUXI3NFNkMzBzVEdtTUx5YnhaNVpCYjlZRUV6Y1VXeDZN?=
 =?utf-8?B?cURldTJ4WWxFNDROeTVocXVxZWpBbG9LNnR2RmNRYmZySGF4Q01iQnRtN3gr?=
 =?utf-8?B?V09yVUFyMHpKNVB0RDdhaHVLVDNtUmNtM29BcW1nVW1hUzZab20xSWV3ZjQy?=
 =?utf-8?B?OWIrNGpacjV0RHIzYmJBMXlQRmZzdUxLWG1hQ3lLR0M2WUtFMlM4OVBpTGtx?=
 =?utf-8?B?OFl2T3JZcWFneG9sL2Z2Z2VsOHl6KzcrZkVFZHpGNUl0MjJ6ZGNmTy9NdE1z?=
 =?utf-8?B?eGxHYlhuQ09JUXlXaU5CVjFpSjkycnlWSk5wK1dFdGlLYng2UmFpRkplakNx?=
 =?utf-8?B?UzFMTnAwaVVGYitWZnBlNFhBbXE5WVVTUDdIS2dIajhaeHZyd3pxUXduZlRx?=
 =?utf-8?B?UEFVMVk4TUhuZ0kzUEI0YWhCSXBQQ2pXQU00K0dmZVU4cXVoTHZ3dytHY0Z2?=
 =?utf-8?B?djhEWS9wQUVSS2NtSVBGb1NRQnJtZHFIU1M2SlpwY01qYy9SY3hTOTZjeWtL?=
 =?utf-8?B?OHNLMFE1YnRyNHhOT0NIVytVSFhoc1A1aDRqdDZEVGY0UmJZUzBoL2dhWWZs?=
 =?utf-8?B?QWNSTnA3YVVkMEpaQW5uRlBNK1hEQUtVRG9La1BXUXZNUy9OK1lNbGdvU1Vm?=
 =?utf-8?B?ZThwYzJrQkQ2K0xLc2hEWmJxOUpodFNNc3BqZTlHdi8xdFRhTkhxOUxDdUN3?=
 =?utf-8?B?U09kdk5VMXBnakN5YXJUMVNUQ09DcUNEbS9Qd3ZDbFJMWTZlY2gyL2c3S2dE?=
 =?utf-8?B?SkxuT08yUlQyUWpOYlhGcXdLdmNMSUhqNEJJVEY3aUdPVEo2MnhDN1NyT3o5?=
 =?utf-8?B?cGVob2pIUDNRQnpyM1Q3N0Y0alNkWVpPRjNqVEsyVFNSTldxcTdKS3Z0cG9s?=
 =?utf-8?B?Q1NPb1YwaG1sa1pYdURCRTFYQitVYmk2SUIzSkZtM3F6aFkxMWFaVStLenhj?=
 =?utf-8?B?ZTg3ZnJDcDNmV3M2RWxzdW01ZnJvNTZMU05xVHZReGdaVW9qM1U0VENUN3d3?=
 =?utf-8?B?c1krVWFSdmwvN2JqdFBDcDdiWm1hbXBJZUVHbVp3dW9COVpKSlA5a2Vham96?=
 =?utf-8?Q?QUYG8w/vcsFVFFPzgC?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 64953fbc-4c94-46fe-9211-08deddc57edf
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 14:22:23.9933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bz8DAR8KeLG1nQQyWE5IEO2/donrYmHvGsMiQrTVn3sSYKo6fSCEFKP325OshQmRdbMFyFtuNo2DxkWnolvNvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB7844

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
