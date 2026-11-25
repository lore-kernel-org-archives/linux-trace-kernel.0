Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.126.109
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795608033;
	b=bGkPauH2WE3xGDCtqTHH9ppmunurmvFl3m/2LarniBZ5MmmGr/ANIouxfuVzbNGTzknP
	 2bQzr4vLIgjT16wVJmDRRQ+hfBP7q8SZJvtsvvlTs0OAja6P5WFJnNnUlfayqF1s0OA/d
	 cK/wY/l3ZbsxPc1oXYKR1X9JYG7hNb2hbIvqSr02pPFeBfGu+nFKU0FYWHbUceUOKpADm
	 ABeN3yOhvYrUjLzicSmFFyZoVWdLnJxsaELfsGKqEPNVKZ55GuzAP4ttU4dJ7BEGPvA3T
	 aClLBP7vio+Sh2Kz4TZRpfbCcsWAXB2j6HoJzkFdmIMfNX42cC89gXBsdWFKAG6gyxw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608033;
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
	bh=FF/3HdVcICm6DqCAvFBQD7kD3KykCgRURGOMGyaj0vQ=;
	b=3pQe+M/F70VYfSBMNanCAKP3T+wIS7DNculXTYlPRpuRLP8UJovasw6x2pykIMxuiSyL
	 4xfX/501gjX3MF0Ws4p4VXOY7ekUafkaxj6QI5ZHyMmIygPvtpaxEMQ+E6j+sJtUZfSVn
	 olsINqeYLVGeAzU64mww+Roouk498xYZVjOnkRpE8mfAbWsHcWgsO5yGjvj1I/XJPg0hY
	 Q/gYCMkSWVF1pAcRAAWLJM7c6wkseapoEivQ4uCoYgf4JeqV3xqPCOTpS70HG4pl7gPlj
	 fCyJHgzpvRTCX3JTXPFXI/H+crEKbxkzlmmOQL5bStDPxqFyHQYD0iv2Z7KgFEX4cJQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=transsion.com;
	spf=pass smtp.mailfrom=transsion.com;
	dkim=pass header.d=transsion.com header.i=@transsion.com header.a=rsa-sha256 header.s=selector1 header.b=ro2j4Jvn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.126.109
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022109.outbound.protection.outlook.com [52.101.126.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAD7606A32C;
	Wed, 25 Nov 2026 12:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CAD7606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=transsion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=transsion.com header.i=@transsion.com header.a=rsa-sha256 header.s=selector1 header.b=ro2j4Jvn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UyXCvq+p0H3Cr+5DgL/ZZzhuVM7nMMlrkpPLsXKudZx60uO5PEJRCEvZYs5K7qs0i+kFAJjEaTGw28mgzOTxE2DXdetnojsfKOeL+Q6cHZQrQNR62u7ricA8Qox1wRwU+XeelpC35YLJv5r3XWsvuugH424+nLNEWq9+WnwoDgRuAYq2NsJ1a6g5Mr3KsazuU0BG9c2xTM7/iISedGVKgYgvsE0pvfEbWk2OaNPj5EMv30yF7SLbKKxSzQ/CMYhOdFWRAW9AKl9dqfqsSuQoqjRzg6+xc/CHp/84Tqm11Ojx4wUZYhd8yilpu4clvzYMofrPtBGXKrVvi//vhdDQ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FF/3HdVcICm6DqCAvFBQD7kD3KykCgRURGOMGyaj0vQ=;
 b=VAfmCRlPRjDzzhomxN/U1aMJcISXr/Usc7QsdDacQcK2okF7xvl0Xz/YW9vQvPm26vA+gTnvElUFuA66rrASj2lTk3Kg7PxE+Vb3h9JwD37Y4YxbZH6ygkPr6AqsyvcLwLtfNE5mVkr6utfVNsCTicGTwBRnqYXFg2KxEloyAffKotyd1ImTBW96ktr0fPHJnqje2614/u61uxQWFWxJwMd9a95Ta271N7WfE4M3AOrrN8bn/ZU/F8ub1pSfm9yACSVLKaQyHB4wzChRFCYxFFjsemi4ud4sIPcOZNviW+CQnOQuMA/wJDe+thOp+yBHzV6sYRJpLWjmLp8zND3lJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FF/3HdVcICm6DqCAvFBQD7kD3KykCgRURGOMGyaj0vQ=;
 b=ro2j4JvnR6saqjc+5w3AEAOerG7n85f+hb2Mp3/5BRp3Nta7PXCe8riCQS8499TdTZmpsqUG0QIWaQ7TTRO+at+AdFbJ9A0QtouPDhx15P5hNb0co9qSEv+nVfldNBHCUaQaaz2+maJAzUDlXlGI2jIwwTadVA50qIpQYVKtJbw=
Received: from KL1PR0401MB6196.apcprd04.prod.outlook.com
 (2603:1096:820:c7::13) by OSNPR04MB9452.apcprd04.prod.outlook.com with HTTP
 via P2P; Wed, 25 Nov 2026 12:00:29 +0000
Received: from KL1PR0401MB6196.apcprd04.prod.outlook.com
 ([fe80::f2ee:1e28:9022:99f3]) by KL1PR0401MB6196.apcprd04.prod.outlook.com
 ([fe80::f2ee:1e28:9022:99f3%5]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 12:00:29 +0000
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
Subject: Re: [PATCH 2/3] arm64: Always inline preempt count and reschedule
 checks
Thread-Topic: [PATCH 2/3] arm64: Always inline preempt count and reschedule
 checks
Thread-Index: AQHddZ/FQp+z479p5EueOefibnQF5rc+vb2A
Date: Wed, 25 Nov 2026 12:00:29 +0000
Message-ID: <d3556c8e-75b2-4c4d-85a9-f79e0cb58819@transsion.com>
References: <cover.1794814699.git.kmehltretter@gmail.com>
 <80d8bdd8995a4b31a44e65bb9347b41c5be5226c.1794814699.git.kmehltretter@gmail.com>
In-Reply-To:
 <80d8bdd8995a4b31a44e65bb9347b41c5be5226c.1794814699.git.kmehltretter@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-traffictypediagnostic: KL1PR0401MB6196:EE_|OSNPR04MB9452:EE_
x-ms-publictraffictype: Email
client-request-id: 8c9f583f-84d9-4ff2-afd6-54649bebe48e
request-id: fcaac27e-6e30-4c79-f6c3-08df4aebb353
x-ms-office365-filtering-correlation-id: fcaac27e-6e30-4c79-f6c3-08df4aebb353
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|7416014|18002099003|6133799003|22082099003|11063799006|261021121427099003|56012099006|261102123227099003|261022105027099003|261026140227099003|261009223027099003|261021123027099003|261022075727099003|38070700021|4143699003|261028144727099003|10067099003;
x-microsoft-antispam-message-info:
 QGbrolQC70r626dzHKa8HpRDcwhESzBbfZAmc0Dp93fXJM26KC+guoHifEeQve/R2X45byCev3bSOkDrz1e8+hmfDDx1cL08UKTqk78sjmNn38MZ38igvql9wmbrOHenNQH1Ads0deMbfIIvJ1wX3FX+lZ2OZ5TUFBn57z+jfZQn6mYUOonJbU0KOnfEV02zb9vdkQvcb98f12K+mFYPo+LwqVJgXKMZtvEbg3+PYcUJhYHnY5PsaYKCBv0q8Bx0DL2wPv9M03HE3jmZWnLCaFxjNBPjBeP9jpVFl9UcxRgf8JK4lCBmoU9zjd27Zkk2usB4TjjDXtc4Up77N0PnvPm5XQB4kMCaq8eNDXiaNnJn3ln/yRSzrBe8K4YhiY/+VKe8t5+A6oDX6x4FGLBgYeoB1bQmAhDv5v75OOXPC+bENWWI+tZR9QBT3DBBOa3l4HaWe/WrN/9oD+7XdoqS295GuYjmcC3qqvoEicfygvJbu+rWEAPlRML6A3yrhsHg7LEFmk4fH2CF+0bU8Tf4zVE2unyOCzLZt6LbUj0+87M6rFVF80fA47awAoaff4+qYr9yZHssmBdQOTzXN19FYk0LyY+6Ju0xRJCtGERzJ3groZ6zeHW1ab0oCEEpV0LEunsWGMDUwCulQppW0B2zivcrgRVUVTua9OoC837Hj2lOKXBDM0vQ7uqqQxKxDt5OI+AFxESKRaihdw6HU5w1zNVgW78+Bz+h6W9Zeo4raEU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(7416014)(18002099003)(6133799003)(22082099003)(11063799006)(261021121427099003)(56012099006)(261102123227099003)(261022105027099003)(261026140227099003)(261009223027099003)(261021123027099003)(261022075727099003)(38070700021)(4143699003)(261028144727099003)(10067099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZXhER0FDaVgrQTlHaVlKSy9ENUxKd2NaQ2RoeEZEZlB0NGlyTGNFNHNQa3FV?=
 =?utf-8?B?ZnlZcmMxeUxsRG5tZlF4N1RacW5LTkp6dGgrdS9mTDZCZC9jdVhiVW9MU01Z?=
 =?utf-8?B?MmZ4WFRhMWdldzk3WW5RNzhOcXFWcmJYRWhVblp3T1owRnVRZ1FFVWlTL0pM?=
 =?utf-8?B?bm1pakpZVDR1VGptSE5VRUg3Z0pxclRTSEhnZWNISktiYWE4MERiRDlDR2t6?=
 =?utf-8?B?YXQvelM0MzlTYkFLUlVCN1NrR21nSks4ZEw4MVltMHJaTmZ0bWRQVFdJa0s3?=
 =?utf-8?B?VDB4NTNxUjB6SHRMRllDNU5LalNDRHRUaHlnWkxnUXNqbVIvNVJiZS9WVXpV?=
 =?utf-8?B?RHZOVFFhc0RyMklJYmJ5d1ArS0NnTGkxRmZJZ0gyeU11dnhlc1R4NFBySzll?=
 =?utf-8?B?V280VS8zd3RaYXJqbTFCU1RxNnR0anVyelVITStsZXJvVFNmSkxEd2lYTFEz?=
 =?utf-8?B?OFcyOUU5OVBocEVYVGVOK3ZMZktYM1Z4bDZXTFdIV2JoSktlOXdSUGMzL09E?=
 =?utf-8?B?M2NHeVhPK3VvQU5LUWpEWVlyY01EUkVCS2k3cjA5cHF4UjlDQkt4VlFkcVNR?=
 =?utf-8?B?bHhVbUp2Q3ArbkgzaW9lQ25mSStZdTErVUhzNUpmLzlnWURHcUt3Vkgyanhn?=
 =?utf-8?B?RXpyS1NBVTF5RXJtcjh0K011MytFdzFyZEYzNDh1TEhuc1EyQWlMTkQ5NkEy?=
 =?utf-8?B?SEZLR1pCZE9oYnh1cEdmbEpMWDQ4TWpZeGNMcTM1STFWNmo4L0RpdVZQRFor?=
 =?utf-8?B?R1lvSzQ0UDRicFZKVUFrelQ4RVVlbER0UExzbGFGS0YzN0VTaG5oejJNMGVw?=
 =?utf-8?B?cHhteWxacTBRUldzZ1VYM3pwYkxsTGVodUM0WWc3QUlCblVaYUk3RWJUdWZk?=
 =?utf-8?B?MG9mbUZEaGJBQ3R6dTV0TlFBdHdRbU1NcHNYWDNyd00zcjUzLzdMcXVDS1VC?=
 =?utf-8?B?KzRSNnZKZlZDbERTSzJveGJnS09MT2FqLzNnZStSVFVNOFNONUtDTUdzZ0E5?=
 =?utf-8?B?QVRzbTdUWXpzTkpGWXE5RHEwNmZVck1WbVVmbERPbWZnMk41WmlRUXhrWG8x?=
 =?utf-8?B?THdHS0MwUzJZa2padGFndWVLMEdta213WDg2VUxrb0g2QlJ3aXF0RmNwOWMv?=
 =?utf-8?B?THVObEY1VldocTNOOUVTUzMrZEVrWk5EejY0S0xkS1ljVjE2WmRWd0p6b1VC?=
 =?utf-8?B?c1RsWm9hUkRXNVdEYmd4cnhHY3pDZG5mL1dGVlkwY1BUUzA3MWc5dm1vYXR5?=
 =?utf-8?B?dXkrcld6VCtHSXVWN0pMUFlCcU4vdmpocWJESWtabEI2am16SGxBRzlHeWth?=
 =?utf-8?B?TDdPMDJUdjd4dFVQL0Nsck9LMjQwdGpadmJpWFF4UW5FRXNTL2xYU1kvM0Js?=
 =?utf-8?B?RHhlY1daNUwrUkN2QmlndWJydTZkTjJHcWtFUlFabXNoUEI0VFMrbHQyM2FH?=
 =?utf-8?B?eC82WEZ5bTZJK2NINFJOL2NHbE45bWdmR0NPNDdrOFQzTG9Ka1lKQzVpOG1V?=
 =?utf-8?B?RnBHSW9oSlFoQVlCZGVBdmFpU0hWU1psempySCtHc1JWSHNETWttUjdQYlIr?=
 =?utf-8?B?Z2RteXowL0MvenBsUmhsZDdBWm42TWpYRHcxdjhQVWwrMkVEZ25LZmtCTHRu?=
 =?utf-8?B?WDFVVlBMZVFVUEVaYjdDM3hYbG1XaEZVMjJtUEVSUStSc1o5bW9iRm5McDVq?=
 =?utf-8?B?UTQ2b2FJanVONFVaeGJpb1AvY3oyeVFGMW5rWUFnYXdEZGxpL1FCYUtTeWpr?=
 =?utf-8?B?OXBrUkV5MGswOG5JMDJ5bjNMNlJZU0d1c1M0dmJtUnVvV3phclJLbGtaS0t0?=
 =?utf-8?B?MzlsTXV4bUxORG9BeTY3SUZLVjlQUW1YVjdkMmNZYXpNSFZKSS9WOHF3aW1Q?=
 =?utf-8?B?aXl1b21pOVNTU2dreWxkTUVwR2NuTUJOYlIwaXZWQVRzK3NsK213WlNxZnNZ?=
 =?utf-8?B?bmdsc0dvT0wwVEJlc2FPb2pjbmcrNmJaWVhjU2dObTN3L1krQnBJUUVpcm9G?=
 =?utf-8?B?M3dvcDlXcXJjdTdibnRlWDdSK24xRFV4NDErYTFDblBYWjdyS29FUENhTis0?=
 =?utf-8?B?ZVZkZVE2Zks1eFNJTmNBWEE0R1dzNm5QRXlGRmxQckZoeWVQUFNaTEpQQVJY?=
 =?utf-8?B?MHBwSEpDM0xlbkJ3MHpsL3Z1Vnhrb3RLeHB2TmltWER3cGIzS2Q4ek5aR3RU?=
 =?utf-8?B?UnhzZGljUGtWRUo4a2Y3aUE5ZUxoM25MdjEzTW5yNzlCZzJ6Z01iMUpjOUtK?=
 =?utf-8?B?VkJGclhEYXhUVEF2TklvczdYM2xpc3Z2bnRnMEQ2WEU1RHRXay9jYVM0ajdx?=
 =?utf-8?B?NDlxNzZLMm9xaVBEOVR0dGlPdlRIbnkvVzJhRjY0dUNKTHQ2aHZiWmlyRDEr?=
 =?utf-8?Q?/5ns1htR8hrLJlIM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <48E344D46C03B344907ACCAC10679DB0@apcprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fcaac27e-6e30-4c79-f6c3-08df4aebb353
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 12:00:29.6241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8mdXPxsX4CC4Vt+tN2XwFDvBgKAiX/Nwu5/lV1oLa/7pFq/gW38cMovWFiYIaifLGNpeTGVrgOKjDNSINTe9TAMnxgXujYXhnCjk8aSOCS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR04MB9452

T24gMTEvMTYvMjAyNiAzOjU0IFBNLCBLYXJsIE1laGx0cmV0dGVyIHdyb3RlOg0KPiBUaGUgcHJl
ZW1wdCBjb3VudCBhbmQgcmVzY2hlZHVsZSBjaGVja3MgYXJlIHBsYWluIGlubGluZSBmdW5jdGlv
bnMsDQo+IHdoaWNoIHBlcm1pdHMgb3V0LW9mLWxpbmUgY29waWVzIGluIGluc3RydW1lbnRhYmxl
IHRleHQuIFRoZSBjaGVja2VkDQo+IG5vdHJhY2UgaGVscGVycyBhZGRlZCBieSB0aGUgZm9sbG93
aW5nIHBhdGNoIHVzZSBwcmVlbXB0X2NvdW50KCksIHdoaWxlDQo+IHByZWVtcHRfZW5hYmxlX25v
dHJhY2UoKSB1c2VzIHNob3VsZF9yZXNjaGVkKCkgd2l0aA0KPiBDT05GSUdfREVCVUdfUFJFRU1Q
VCBhbmQgX19wcmVlbXB0X2NvdW50X2RlY19hbmRfdGVzdCgpIHdpdGhvdXQgaXQuDQo+IA0KPiBG
b3JjZSBhbGwgdGhyZWUgb3BlcmF0aW9ucyBpbmxpbmUgc28gbm9pbnN0ciBjYWxsZXJzIGtlZXAg
dGhlbSBpbiB0aGVpcg0KPiBvd24gc2VjdGlvbi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEthcmwg
TWVobHRyZXR0ZXIgPGttZWhsdHJldHRlckBnbWFpbC5jb20+DQo+IC0tLQ0KPiAgIGFyY2gvYXJt
NjQvaW5jbHVkZS9hc20vcHJlZW1wdC5oIHwgNiArKystLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwg
MyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gv
YXJtNjQvaW5jbHVkZS9hc20vcHJlZW1wdC5oIGIvYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9wcmVl
bXB0LmgNCj4gaW5kZXggZjNhNWMyY2QxOTM2ZC4uODA1ZjdiMzNiYWYwOSAxMDA2NDQNCj4gLS0t
IGEvYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9wcmVlbXB0LmgNCj4gKysrIGIvYXJjaC9hcm02NC9p
bmNsdWRlL2FzbS9wcmVlbXB0LmgNCj4gQEAgLTcsNyArNyw3IEBADQo+ICAgI2RlZmluZSBQUkVF
TVBUX05FRURfUkVTQ0hFRAlCSVQoMzIpDQo+ICAgI2RlZmluZSBQUkVFTVBUX0VOQUJMRUQJKFBS
RUVNUFRfTkVFRF9SRVNDSEVEKQ0KPiAgIA0KPiAtc3RhdGljIGlubGluZSBpbnQgcHJlZW1wdF9j
b3VudCh2b2lkKQ0KPiArc3RhdGljIF9fYWx3YXlzX2lubGluZSBpbnQgcHJlZW1wdF9jb3VudCh2
b2lkKQ0KPiAgIHsNCj4gICAJcmV0dXJuIFJFQURfT05DRShjdXJyZW50X3RocmVhZF9pbmZvKCkt
PnByZWVtcHQuY291bnQpOw0KPiAgIH0NCj4gQEAgLTc1LDEzICs3NSwxMyBAQCBzdGF0aWMgaW5s
aW5lIGludCBfX3ByZWVtcHRfY291bnRfc3ViX3JldHVybihpbnQgdmFsKQ0KPiAgIAlyZXR1cm4g
cGM7DQo+ICAgfQ0KPiAgIA0KPiAtc3RhdGljIGlubGluZSBib29sIHNob3VsZF9yZXNjaGVkKGlu
dCBwcmVlbXB0X29mZnNldCkNCj4gK3N0YXRpYyBfX2Fsd2F5c19pbmxpbmUgYm9vbCBzaG91bGRf
cmVzY2hlZChpbnQgcHJlZW1wdF9vZmZzZXQpDQo+ICAgew0KPiAgIAl1NjQgcGMgPSBSRUFEX09O
Q0UoY3VycmVudF90aHJlYWRfaW5mbygpLT5wcmVlbXB0X2NvdW50KTsNCj4gICAJcmV0dXJuIHVu
bGlrZWx5KHBjID09IHByZWVtcHRfb2Zmc2V0KTsNCj4gICB9DQo+ICAgDQo+IC1zdGF0aWMgaW5s
aW5lIGJvb2wgX19wcmVlbXB0X2NvdW50X2RlY19hbmRfdGVzdCh2b2lkKQ0KPiArc3RhdGljIF9f
YWx3YXlzX2lubGluZSBib29sIF9fcHJlZW1wdF9jb3VudF9kZWNfYW5kX3Rlc3Qodm9pZCkNCj4g
ICB7DQo+ICAgCS8qDQo+ICAgCSAqIFdlIG11c3QgbG9hZCB0aGUgY29tYmluZWQgJ3ByZWVtcHRf
Y291bnQnIGFmdGVyIGRlY3JlbWVudGluZw0KDQpSZXZpZXdlZC1ieTogSG9uZ3lhbiBYaWEgPGhv
bmd5YW4ueGlhQHRyYW5zc2lvbi5jb20+DQo=
