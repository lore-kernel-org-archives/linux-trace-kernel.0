Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.75.143
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795607961;
	b=IBaOcwhRcK1BtwLC0+FW5I9sqK1xOa2148yg1uoou6WskGfHD5KxsJTbwjJIMeAEBx9e
	 Zt3cszQtWwHKeuXpBtAYPFnDkHpl6pHqDgcodVgVPW1tQwxxBqMuxzRay2AgQ+5iEJzKB
	 q2dXgIvolTfzk8FKHILf8VYuxr+q5sG2n7/JeeK5zdJrCBHoS78yVKrzleZmUQCvDtHhf
	 5Bq+0Y6xlvwM3ZPcNSUaVj96iIh3HNYoPWc7rWbFpsz8HSQUZ+HdRso+LFrzUweD/RDdE
	 krrnZ6c6lXEZc76IhBQRx0rT6YSKFRD+icufQq/RvOfyABBJAzXB3MP7JyktHlRdIpQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795607961;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-traffictypediagnostic:x-ms-publictraffictype:client-request-id:
	 request-id:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=oME0BINlNDuourSn40yOsKYl74jCeIyPiB0Oq4NruqE=;
	b=3mAuh03vsk5u83Ne7n6KZ/q4L/qQxpK0qwH2s6GJr3m8cO2FEsZPrAGz9VnuA11XczGD
	 2ESw7RrUTLALJNIRhJII2LhFWtqAhhIRDCZCGhnjpAO+dFWd07TxlvXXDPZsw1j7be0yJ
	 YMDazN3iSONGDsYOZpp2w4xBz4WiJI/qzDK8ywS3vnvc5TChSaDk5DaGtldComVe5iLc/
	 gsxV86rIWC/zuxhApglNlLdmZcYRq3IZLUFtgMA6ZvvjBnvtuLyNRkG1850vrnKyouYyD
	 m4JhvaLbuZjOPOS8ET8urmLWmHRVaPXI1Y3A6PCBH3tHPJvBURK7hWKMvtM3aqIrr9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=transsion.com;
	spf=pass smtp.mailfrom=transsion.com;
	dkim=pass header.d=transsion.com header.i=@transsion.com header.a=rsa-sha256 header.s=selector1 header.b=muIRj7Nc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.75.143
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022143.outbound.protection.outlook.com [40.107.75.143])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CC2606A32E;
	Wed, 25 Nov 2026 11:59:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86CC2606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=transsion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=transsion.com header.i=@transsion.com header.a=rsa-sha256 header.s=selector1 header.b=muIRj7Nc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KWS8Uh9s8lAVp6SqfYd84cG3jWpjCXkChYCtvL6b5YQVbE4FUltrg6rCOQQXrPo6blKd/2U/+hnrNCkNiRGjsyl90tdv2pVXhpoF5Mjz966y4Y2Jg83xrxD5FDjb/NAvfxMGkszZAfpUy331aZXwWdRyv3Gz3LvKR1wz5KjyDnpVjQRvjZtsnhpK0KYxlHxbjpnshlQEx2mYBVtzFAkiPcxUjC3KfoFmgsqbICrbuIAYgs76NxtsxEh7jd7Ja6OsQNAKhIc6s3R4waEr6K9+giCfwxaPsJAECXfyB0QvAsA9iMhz/hZHvvC/3AUIMejYxnii3PxwsInTjIwsSnMiQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oME0BINlNDuourSn40yOsKYl74jCeIyPiB0Oq4NruqE=;
 b=MhMYElpSppVNZUghYCVz1sU4Hi9JvODL0TRcntHNnvbCMnMMvjBLNbMx55ZJF1kOFC/h3RiQ/wliqVu5/9nXozgrR0t0EtWhKCzP3qHCkpgIt3MzWIrG0G6dUD/OQ9mLugd3E/DAlsnZVMYFGjdqXFImzEKxwbT7xgqcEnRBA/PMd+v7Riq246w9wcYrA9kXrLF2EIvf9nG5CaBCxIAzcV+C73OS9tlswyBxtAustMQFADPD3SEkWui9kBnymbTOTVaZVSUaXlBt0cIulzpTsC/LEtQIXM2Umk9Uc8mqlG/tzTEUdZv2/hamVya1PpQnl+veooDPqI7znGrVbrZuvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oME0BINlNDuourSn40yOsKYl74jCeIyPiB0Oq4NruqE=;
 b=muIRj7NccGMvIVikuF8ibFSq3MK6jTL8LhTdwHMLGLHnPM2BV4Us2yjb4oIj5150/xnmI89sBsyDeyBd5LzzBUdULHQDUjato39dfWha4foC/4JEZUB9kdl5QqKijaKT7Sqb0XcNvU0qQ+ylHhHIDUWE0ugh7Ev4cIfRk2kWBTE=
Received: from KL1PR0401MB6196.apcprd04.prod.outlook.com
 (2603:1096:820:c7::13) by SEZPR04MB8173.apcprd04.prod.outlook.com with HTTP
 via P2P; Wed, 25 Nov 2026 11:59:16 +0000
Received: from KL1PR0401MB6196.apcprd04.prod.outlook.com
 ([fe80::f2ee:1e28:9022:99f3]) by KL1PR0401MB6196.apcprd04.prod.outlook.com
 ([fe80::f2ee:1e28:9022:99f3%5]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 11:59:16 +0000
From: Hongyan Xia <hongyan.xia@transsion.com>
To: Karl Mehltretter <kmehltretter@gmail.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Song Liu <song@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent
 Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] arm64: Always inline raw preempt count updates
Thread-Topic: [PATCH 1/3] arm64: Always inline raw preempt count updates
Thread-Index: AQHddZ/Bw4qwmOGaCk22mrb62LAtZ7c+vWWA
Date: Wed, 25 Nov 2026 11:59:16 +0000
Message-ID: <7132a6df-c191-46e1-88f7-41bb30b9f17d@transsion.com>
References: <cover.1794814699.git.kmehltretter@gmail.com>
 <23dc25d010cfeb8eddde12be5212fd73bf1cd5c4.1794814699.git.kmehltretter@gmail.com>
In-Reply-To:
 <23dc25d010cfeb8eddde12be5212fd73bf1cd5c4.1794814699.git.kmehltretter@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-traffictypediagnostic: KL1PR0401MB6196:EE_|SEZPR04MB8173:EE_
x-ms-publictraffictype: Email
client-request-id: e3fdb06f-2ba2-4e86-afb3-f8f5c758a27d
request-id: b69497a3-5b3f-4333-fa54-08df4aeb87a7
x-ms-office365-filtering-correlation-id: b69497a3-5b3f-4333-fa54-08df4aeb87a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|261021121427099003|11063799006|38070700021|260925022911599003|260925021911599003|261009223027099003|260925021311599003|4143699003|56012099006|261021123027099003|261102123227099003|10067099003|261026121527099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info:
 NifI1Qrm2dE+62xVptgAs74Jl7OaVIpL6XTtu8LzWe+aX/XFt5YQ+q42n3T5r/tj02ePxwWkJ9Z81PWLWA172mmBipAO9k3L7WC0xQizPg7/cQi71+oent7+meBOcaYPT/8vPvMuda6FHWPk8jaB03dYHtu/zFYUU1MduGPfKmpdVFv9NNEBro4zJ8W+hvAhZNYDwRsqDPPpT4tLsGvWwIxH9tQtos0tyDe3YHoZjrehupi0cgT6W/V0XyAOnZE7KMtcoTwiPw2W6k8yWHN7GlUUNpEUTeJjbR79dKllLmNiV8uWUKw7EMXryJ87eNWRYvfYR5XTWOtlk6eLbWEx3UHUYaOZNLV6tIh/uv7/XizJ5QOzZRHM+ndyQmtr6kDArOWIKwTPKLf8+zC4I18SWcvwCkNksKcLm//cHX0MSiBYpID0Bu43+PF1yrgO1JGcxPOe6+V5UPC3q/6l/5cszT5iFEWSeBZWieSOZPeTBgbUsxz1Jm/T56yAwiPKl1S/dZF7T2udHddv/cHrgoWwTBqKWmtbjuexLcy/DW/BK9IY2N0SJAL6sMmAbYy4tAjPUpOiU4fga0js1mX197KF1gVLxaOmVSWdcf/gHn2rFXxSdnUmCnWOYupqCiI6MKEIDxW5QrCAXzBYP5rMA5jvDoybE35x9o0pC9mPPzguNLY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(261021121427099003)(11063799006)(38070700021)(260925022911599003)(260925021911599003)(261009223027099003)(260925021311599003)(4143699003)(56012099006)(261021123027099003)(261102123227099003)(10067099003)(261026121527099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bUUyZXZtTFpkbmJCdVJETXF5THBobVBTNTRCc0djOHZGNE53bGt6Slp0VDhp?=
 =?utf-8?B?MGVsSGluenl4T2xoZ2ZUYnVwRWdQK1pNM0thcjkwRWJoVi9uM1dibUtDRUxr?=
 =?utf-8?B?dW1remtGS3hHN3NVbWhjbFp1RjVtcTVGYTBSNTlqdVYzekVENHhDSzhCUGo0?=
 =?utf-8?B?VTZTRHVtWHFrNFNJeGdwQ1FpZytoNUdRNzJpMldQMGNKc0dWcDR0c1V4NGtz?=
 =?utf-8?B?aGIzL0JKWDlkd2k0dXp5TUtWWkw0Y0VBMlJpYWZKK2JDZ1RNV0dTekVkQVc1?=
 =?utf-8?B?UmlZMGZUSW01M3FDcm9QUXEyaklUWEdrTkNYZTJyU3doMjZUa1RBOHdRM3JZ?=
 =?utf-8?B?NjY5MzBuZEtyVDNFUWxMZk56ZytoWHgyTjBrZ205MS9pWXY3Qmg3SUgvU1A3?=
 =?utf-8?B?ckEzNDF6bTYxTE9sZWh4R21LanZTdnZYeHpibktOVWwvelZxeFlXM2x0NTNl?=
 =?utf-8?B?c0ljTXFuY3Z6OERyZzBmREN1bUpKQXJGZ2U3Nzd1WXRSNEx0K3JHdkFoVUcv?=
 =?utf-8?B?Q2tiejg3OGZ1VU5Kd0YwdE9zUmFIWlJ2bEl2ZnllWUVTNEdBOTY1UjV1eGRG?=
 =?utf-8?B?TEJreFFWMnhvZUdPRzVJOWtLYUZ0d3JyRmVlUFpSanIzY0JGbVlHRzh6anRI?=
 =?utf-8?B?bkJjajB4ak5nMzRZQ3dBeW82VEpsZUZJaGpUQk5XY3pZR1BmUmI3TFFpT0Fp?=
 =?utf-8?B?V2ZXRUZoa0tLS3htUWJCTzR2OEtMcWd6VFQ0aGh5bERFZXlETXU3ZlVvWUU1?=
 =?utf-8?B?QWIvWnhvK2dIckVkTE42dEdPWkVWRmhDU3Riay9QZ0srZldQdmhFZ1dydk00?=
 =?utf-8?B?TlEweU5GQVY5MXVSS3VxRmtwMGhaVzZteHBLWTlwcmVYREJnUWw2WVgvc3lK?=
 =?utf-8?B?elRIVTRtY0pWUTNyK2hYb1R5ZHZ4NjJBQUVka0JNanFPNHhUcW1GV0tnYm14?=
 =?utf-8?B?bTlnVEpCRUtsbE9TSmVoL21rK1pKYlVrWUFGdzJRcDNab2c2Sy90UDJoMXNk?=
 =?utf-8?B?MVZrM25IYVRSYXZqWWJaVzJhM1daVTlqUEpXei9sYnppZHJVQk9JbWxhaTFl?=
 =?utf-8?B?NzIyZmxucFR3cG1rR3FYUjI5T2d4UWNzZ3QyQnkrd0NXMDY2OXFmZVhQaEhy?=
 =?utf-8?B?MThnR1lGZU1SQlJjbU5ZZUQrd3I3NVJIbGhhdVJIMkRYL2ZUWklCcENiTEJ4?=
 =?utf-8?B?NDJ6dzhtVlhhNlQ5Q1NQaGZRK0F5RHZ4WEtWRXlKS3N0WlZsWWd0Q2lKM3Yv?=
 =?utf-8?B?NGJnOVpIWVMxYlVBKytFcFl0Q2NySWtBQnA4bm5aMFh5bUZHQ0FCSjBCelJ4?=
 =?utf-8?B?Q3h5Wjd3QnExeFlzK1hBUWlXMktVVXNzOG5BTHdPdjR2aVJPcG9uUGE0RlRx?=
 =?utf-8?B?dnRhNkxMNVpLVkxERFVMZDlyRmMzOGUrRHEvTktITXB3d1N5L2dxOU8yZzBE?=
 =?utf-8?B?N3VXTG1ZdVhqNDJ0RWNRam94MDBuQ04xQlNzZjFiNFkxWEN5Tk5RTkRnQlho?=
 =?utf-8?B?UFJaZ1JsTzRyZUZ1cC84eE5vMk1HTktJNnQrMm93UjQ0NFVETjQvQjhtSUNm?=
 =?utf-8?B?aEJwNEJrVVIzd1BLcGNZbThjYmdHMVBkSjMrblVzWjhQeW5NZzhnN2dESmtN?=
 =?utf-8?B?L1BwdmJERXZEYjNpdTl3eVc2QnZ5ckIxZWszK0kwajJFOWw2Mlo2RXUvM055?=
 =?utf-8?B?QjIwbUVDSExMZlBDcDdEbVVLbnVaOVJYQkVuZFNUZVgwL0oxeVUrYy9qRjhN?=
 =?utf-8?B?Vlp4WkxhVWZrK2NjZmx6d3VERVdHdDJoNzlCMHFBNFN4OTc0VXJUMDdpQ0U0?=
 =?utf-8?B?RGZrUGtUZ0FuUkxidS9Fb3lMQzM0bktLd2xQS0NEenRkNjFES0hjQkp2NUJX?=
 =?utf-8?B?ZWdDdGFGRTRIN2F6UkczalhyUEZZd1JIN3dVOGRROTJWaVkzT1NrSWhVRFdm?=
 =?utf-8?B?NGdPRnlzRkloelFYdWp6SFRCU1I0TW1IMTdGc2RyZmd0emtkL09BWmFCQ2RX?=
 =?utf-8?B?VVkwYkszMlM1Q1VHWUNCbjBMYkdpL0IxNlBJUlVURVJUQ01oNEhXeU1SK0lH?=
 =?utf-8?B?RDVYMUlWdU52K2RuUnFZS2VlbTlqbFpEaFZUMGY3czZIck0xVWo5djNmYkdZ?=
 =?utf-8?B?bm5hY3ZqNFFkV1VJUFR1SGpERWVudVdCWkJ3TCtwR01HeVhVdnNFS0Ftakk5?=
 =?utf-8?B?N2t0WjRWUHpkOXlhcmUrT1Rsdjk3S0hDQWcwZDJGSlNPRnRPNFN3ZXB3cU5q?=
 =?utf-8?B?MmhuZFh3NGpLaVljU3J4dFdqOUpLZ0QzRVBBaTRVZFA0WksxUy92VnVkTlly?=
 =?utf-8?B?OW1acDViaTN4Vit3MDE0RjhiWWNkTDUzRkVmZEFzdlYwUWdJcGVEUjU1YzFF?=
 =?utf-8?Q?CfqUC6m6u/Otu7Cg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <51BCB10AF41F974DAB0132F05319ED4B@apcprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: transsion.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0401MB6196.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b69497a3-5b3f-4333-fa54-08df4aeb87a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 11:59:16.3150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vMQRf4+oQxrwy9/CkKGonqJq01uW+es3MA4hTtfdCW4iSKZZtJBgrdVCT5T9QQoeJ0XEiGBliF/MQpvksszk4T702EUTL1jGydzRQynPj+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB8173

T24gMTEvMTYvMjAyNiAzOjU0IFBNLCBLYXJsIE1laGx0cmV0dGVyIHdyb3RlOg0KPiBGcm9tOiBI
b25neWFuIFhpYSA8aG9uZ3lhbi54aWFAdHJhbnNzaW9uLmNvbT4NCj4gDQo+IFJhdyBwcmVlbXB0
IGNvdW50IHVwZGF0ZXMgY2FuIGJlIGVtaXR0ZWQgb3V0IG9mIGxpbmUgYnkgdGhlIGNvbXBpbGVy
Lg0KPiBGb3IgYSBub2luc3RyIGNhbGxlciwgdGhhdCBwdXRzIHRoZSB1cGRhdGUgaW4gb3JkaW5h
cnkgaW5zdHJ1bWVudGFibGUNCj4gdGV4dC4gRm9yY2UgX19wcmVlbXB0X2NvdW50X2FkZCgpIGFu
ZCBfX3ByZWVtcHRfY291bnRfc3ViKCkgaW5saW5lIHNvDQo+IHRoZWlyIGNvZGUgc3RheXMgaW4g
dGhlIGNhbGxlcidzIHNlY3Rpb24uDQo+IA0KPiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9hbGwvYzNhOTAzNjhkZDZjMDk2YWY5ZDkxOGUwMzZhMjc3Mjg2OTZmYjhhNC4xNzg2NjAzMTY4
LmdpdC5ob25neWFuLnhpYUB0cmFuc3Npb24uY29tLw0KPiBTaWduZWQtb2ZmLWJ5OiBIb25neWFu
IFhpYSA8aG9uZ3lhbi54aWFAdHJhbnNzaW9uLmNvbT4NCj4gW2ttZWhsdHJldHRlcjogc3BsaXQg
b3V0IHRoZSBhcm02NCBwcmVlbXB0LmggaHVuayBhbmQgcmV3cml0ZSB0aGUgY2hhbmdlbG9nXQ0K
PiBTaWduZWQtb2ZmLWJ5OiBLYXJsIE1laGx0cmV0dGVyIDxrbWVobHRyZXR0ZXJAZ21haWwuY29t
Pg0KPiAtLS0NCj4gICBhcmNoL2FybTY0L2luY2x1ZGUvYXNtL3ByZWVtcHQuaCB8IDQgKystLQ0K
PiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9wcmVlbXB0LmggYi9hcmNoL2Fy
bTY0L2luY2x1ZGUvYXNtL3ByZWVtcHQuaA0KPiBpbmRleCA3NWE1OTJiN2Y0N2Y3Li5mM2E1YzJj
ZDE5MzZkIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL3ByZWVtcHQuaA0K
PiArKysgYi9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL3ByZWVtcHQuaA0KPiBAQCAtNDEsMTQgKzQx
LDE0IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCB0ZXN0X3ByZWVtcHRfbmVlZF9yZXNjaGVkKHZvaWQp
DQo+ICAgCXJldHVybiAhY3VycmVudF90aHJlYWRfaW5mbygpLT5wcmVlbXB0Lm5lZWRfcmVzY2hl
ZDsNCj4gICB9DQo+ICAgDQo+IC1zdGF0aWMgaW5saW5lIHZvaWQgX19wcmVlbXB0X2NvdW50X2Fk
ZChpbnQgdmFsKQ0KPiArc3RhdGljIF9fYWx3YXlzX2lubGluZSB2b2lkIF9fcHJlZW1wdF9jb3Vu
dF9hZGQoaW50IHZhbCkNCj4gICB7DQo+ICAgCXUzMiBwYyA9IFJFQURfT05DRShjdXJyZW50X3Ro
cmVhZF9pbmZvKCktPnByZWVtcHQuY291bnQpOw0KPiAgIAlwYyArPSB2YWw7DQo+ICAgCVdSSVRF
X09OQ0UoY3VycmVudF90aHJlYWRfaW5mbygpLT5wcmVlbXB0LmNvdW50LCBwYyk7DQo+ICAgfQ0K
PiAgIA0KPiAtc3RhdGljIGlubGluZSB2b2lkIF9fcHJlZW1wdF9jb3VudF9zdWIoaW50IHZhbCkN
Cj4gK3N0YXRpYyBfX2Fsd2F5c19pbmxpbmUgdm9pZCBfX3ByZWVtcHRfY291bnRfc3ViKGludCB2
YWwpDQo+ICAgew0KPiAgIAl1MzIgcGMgPSBSRUFEX09OQ0UoY3VycmVudF90aHJlYWRfaW5mbygp
LT5wcmVlbXB0LmNvdW50KTsNCj4gICAJcGMgLT0gdmFsOw0KDQpGb3IgS2FybCdzIGNoYW5nZXMs
DQoNClJldmlld2VkLWJ5OiBIb25neWFuIFhpYSA8aG9uZ3lhbi54aWFAdHJhbnNzaW9uLmNvbT4N
Cg0KSSB0aGluayBvYmp0b29sIChvciBzb21ldGhpbmcgZWxzZSkgc2hvdWxkIGFsc28gY29kZSBj
aGVjayB0aGF0IG5vaW5zdHIgDQpwYXRocyBoYXZlIGFsbCBpbmxpbmUgZnVuY3Rpb25zIGZvcmNl
LWlubGluZWQsIG90aGVyd2lzZSB3ZSBrZWVwIGRvaW5nIA0KdGhpcyB3aGFjay1hLW1vbGUgZ2Ft
ZSBldmVyeSB0aW1lIHdlIGZpbmQgYSBjb21waWxlciB0aGF0IGRvZXNuJ3QgcmVhbGx5IA0KZG8g
c3RhdGljIGlubGluZS4NCg==
