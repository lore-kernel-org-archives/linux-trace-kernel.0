Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7FF175AB;
	Mon, 22 Jul 2024 05:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721627725; cv=fail; b=T0JGhwpM0qvhmSnBa3FtCnCGpveyboCK0llUpmKbtoVdxe9psMCGHACDNvRfg/xbHpVp8b0VvakbgxsqqIjwyKm1gHZw2dgrYduAi09pL1XQbcJPd/euJULpkIvH6IKUvW/SZAtDxengBlJ0ZNBVAeUXJZ7Fa+eD2+9Mohp6sHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721627725; c=relaxed/simple;
	bh=hOwGQvrcrVddRJOkDpoaB/WxHY7sgtRCwcdjH3BlyKQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HGN3mck/crm+eXS0sx3vafL9/vqEKLXcHUD88+S4s8YTxqZtfRu3yyD2Oso57/JJ0BHN+HHUTb8fFk31F1qcW5PlkDZkDrlg/8GXulkB3zqhSWGgaKpE48IAi3vyWCU3ds4DuKgSw8FqA+gkQrmnT0Hnfvf6so9IKonzeI9Vg68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=irnE1sx2; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=u4ZMSXXK; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="irnE1sx2";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="u4ZMSXXK"
X-UUID: f6fa8d0e47ee11efb5b96b43b535fdb4-20240722
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=hOwGQvrcrVddRJOkDpoaB/WxHY7sgtRCwcdjH3BlyKQ=;
	b=irnE1sx2URsjRclC1jwSwtW0I/b/psBp249FXEIwH0IgeiODOGHX9jBblv5yACA1/diODInnrbthtT+ddy1XiGPB/mujDPJA0aQQN0yo4eT5apEegqN/+OkbnC78ivnISRIKNOHi6R6teAagueW3QMVdMe2HIEjptyBJFBNaIis=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:9f9d477b-e752-4ed0-a049-68d03e3e17c6,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:52289fd5-0d68-4615-a20f-01d7bd41f0bb,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: f6fa8d0e47ee11efb5b96b43b535fdb4-20240722
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <tze-nan.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1323051974; Mon, 22 Jul 2024 13:55:14 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 22 Jul 2024 13:55:14 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 22 Jul 2024 13:55:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WOakkfg/PWdHSFWG0YCmKsGrYolhl1+8jrMM7cDMRdA8H4/WPXD9h/4DJQXkwzl1b1TJSDok9bMK65GKvue3vwdp83IlElzjLId9yCDer06cpRpBdZ9B2DNVILyff6xh6o8cPBdk7/XODQrIWfQWTbBZ+k5dq0oPUFG3sHYSOPxNcsJrjIO4ibvWJcMGOQSQoUlsdr4LO9UAMOnG24c5gPVHEA2hE3b+TSpDw/y4L72U+/5FjgIF3UJAFxEhYXpm+mNdrxHSItS/PH+lqrHPF5QLYBf9/jw3mJYK2jdlpWBSKEAmjMUc5vpG0s6YscF+lwzR4uUKUCqxtVx6A6f6Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hOwGQvrcrVddRJOkDpoaB/WxHY7sgtRCwcdjH3BlyKQ=;
 b=u75OcgXolFIvXM4QX4yzFQ6I5hBJ2bnojQhy1vxIFVhyQ3ENy4ppd1uuHbQ+hJWBuhZWQ0c2uIxBuB3rtSA1xEMeoKbOrmzFwQRbTi4p6HEcA7Ha0oKlBqu7EIMC/xi6sIWXkbFkY9Oqgzo34wBUzAZBDbOdwngYynojSpFYcmnebQr3cjYbuLxcziQHGXUQ8+cKUEE7EeYTNtYjefat1TWxtGZDGaXZjSw3YJfmyE4AX6lnpaHNKaXAemUC1B4r+5TygahORm3R6+djxHCdZkXkW3OOZjlkoCk52jZakyo0/lu7DDQY87yYTCFQT2S3Yn7sRNPRy5ePosFVCj9L/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOwGQvrcrVddRJOkDpoaB/WxHY7sgtRCwcdjH3BlyKQ=;
 b=u4ZMSXXK84Ym1odBR+bTcOxLBzJvDZNs1UfwgjHeX5x/HSfjbaqFk7DNK6bxwsVti0OMDfapmx6E9cyiNhocxlSLb9jR1ZapggG5MkEnp9pERpm9r80oPm4eVfHPqZn+gxdwrh+e8rMVptrQG0MQZS4325BtunMfUOf7GLwhSGo=
Received: from TYZPR03MB7183.apcprd03.prod.outlook.com (2603:1096:400:33a::11)
 by JH0PR03MB7983.apcprd03.prod.outlook.com (2603:1096:990:3d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Mon, 22 Jul
 2024 05:55:12 +0000
Received: from TYZPR03MB7183.apcprd03.prod.outlook.com
 ([fe80::5a8:982:e044:3350]) by TYZPR03MB7183.apcprd03.prod.outlook.com
 ([fe80::5a8:982:e044:3350%4]) with mapi id 15.20.7784.016; Mon, 22 Jul 2024
 05:55:12 +0000
From: =?utf-8?B?VHplLW5hbiBXdSAo5ZCz5r6k5Y2XKQ==?= <Tze-nan.Wu@mediatek.com>
To: "rostedt@goodmis.org" <rostedt@goodmis.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?Q2hlbmctSnVpIFdhbmcgKOeOi+ato+edvyk=?=
	<Cheng-Jui.Wang@mediatek.com>, =?utf-8?B?RXJpYy1ZSyBXdSAo5ZCz6IKy6JG1KQ==?=
	<eric-yk.wu@mediatek.com>, wsd_upstream <wsd_upstream@mediatek.com>,
	=?utf-8?B?Qm9idWxlIENoYW5nICjlvLXlvJjnvqkp?= <bobule.chang@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "mathieu.desnoyers@efficios.com"
	<mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Fix overflow in get_free_elt()
Thread-Topic: [PATCH] tracing: Fix overflow in get_free_elt()
Thread-Index: AQHa0qpf22nVOPpfRUCHcXPJHksJELICUhiA
Date: Mon, 22 Jul 2024 05:55:12 +0000
Message-ID: <b8a07b3e60ea173bdb1362dbe8e7034b4a1f25b6.camel@mediatek.com>
References: <20240710091908.7030-1-Tze-nan.Wu@mediatek.com>
In-Reply-To: <20240710091908.7030-1-Tze-nan.Wu@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7183:EE_|JH0PR03MB7983:EE_
x-ms-office365-filtering-correlation-id: e0ea325f-db30-44aa-abda-08dcaa12d9fb
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QW9wRHdvWnBaNUNPZGc3ZkFFeTkwSExGM2hPZm9PS2o1NjJPZVVmSXU2c1JO?=
 =?utf-8?B?YmlGNVk0NTBRY1Z5em4raTFVODhRQmMvVCtvQmZrU2xKb2tqM09kc0dVT1k4?=
 =?utf-8?B?eEpoc3VOSG5TM0J0QnhmaVVqWm9BOVh2NFdQUjBaQXVwV3YzRklTMHRUK25j?=
 =?utf-8?B?K0JtYjh6M2NxN21XNEZNRzk5a2kza2h5bE55NVQ2NE9lb09mdS95T0liNEdO?=
 =?utf-8?B?MDFSeXJlZXdnL3h3dEkvcGtGdVpTL0pzOUpIY2tLdTNTcjVaYmFZTDFEOUth?=
 =?utf-8?B?b3dGYjE0akRKZC8zME15TC9aZDRrc0lkNWpHM1VqOXpibk1sdUdnU1I4ZUVN?=
 =?utf-8?B?dy9DaVkvdWxETDdaVUxuYXpibjM1TFRtVFRwRnhYV0JJelJXWkZUTUF1aFN5?=
 =?utf-8?B?Z1NsbXRPcTVOaTV1Y1g4dHg4c3JXOVRlRXQxcU1iMWdJMWVWMXZBbEl2NEx3?=
 =?utf-8?B?RmxleVpwWHJ1T2EySXVnbkp3dWhSckVZOFdyT29QVmNsVFJzUnd2NGFnclpy?=
 =?utf-8?B?SmtyOUFIWFI5cDVsZFluSkxVSVpBeUpNaUJKbTFzdGlZYnpubnJmemZDT3dk?=
 =?utf-8?B?bFJFWHBpSFJ4ZUJqdnQ4bk53amdMd2lwRGF6YzRUKy9iMUdCMk5uNVFNaG5t?=
 =?utf-8?B?RkQ4cnkrckd6ZjJLcUZwRnFBMW5Vc1AwaUZtaFl5cGRPbUpUbUJTbmYyMk8r?=
 =?utf-8?B?VHRUNCtnMHBlNzluS3huQ1l4VSt6K1BlTko5NGdWVmk2RnE2TVRLUnh3UjZO?=
 =?utf-8?B?aEtwVXY0ZGxiNmVsRk1JL056WGxZVjFSbFA1SGh4U3hIOHh3SmxEVUhFZGxy?=
 =?utf-8?B?RGxlVGtSSHk3c3Vna09WRjlqRFlEbUdVTzVOUXM3RktvZGZYL3h5Mmg1UCtD?=
 =?utf-8?B?cVhRcDhaK2lLUU45Tzg4L09WZUppdUhnczl0ejZUUGRUd1c2cWRHbDlaNElo?=
 =?utf-8?B?bkd3UzdQVnZmNHlmRnY3SWlsTGZzeHhaU1BjSXFJQklEbWFoWkwvY3ovT29m?=
 =?utf-8?B?TytydUtWakpLckFPd1NvVU8yS1NyR3hYNmE0Y1IraEZjM1NtNTBUZFZtdEpM?=
 =?utf-8?B?TE1OT3k5V1YzNk5renptNWVFaS9waGkxRDR5VWtPMnpqWE1veTk3aHE5Ukti?=
 =?utf-8?B?SGxZT05VUVlYVHVGSXJuOGFxTVE2UHorWElaelNrRUVxZFpDSmROV3d2ODZ6?=
 =?utf-8?B?UlhyTzcwRlhZMFp2N0tZUWxxbmw3WXpOaXdWanZnZkwva1pxSTN6aTZSOCtn?=
 =?utf-8?B?YjBrbjNlTDREWjduc2VJNzJGakkrZUZnSktlMWNZTThGMllOK1E2VVlvTC9h?=
 =?utf-8?B?SjJJa3ZtbXVXT01KZHJrUXJZV3pnUTZTcng2azBsTWxpMHZVMFJZUWI2YWZa?=
 =?utf-8?B?ZU9Qek82SjQ4WmY5aXVoN1h2cmFtVlhJdmtlelljNzdmVW5zVUhFeW9lRGVn?=
 =?utf-8?B?ZUJ5bHBkdzZJMXpSS0tJbW9jVDhoVWJiTzQ2KzJjR2tjdUhxV3BPNDdUMnBS?=
 =?utf-8?B?VUhiWmI3Q3p6UXJMVVJHVld4SUIxSlJPOEYyM1M4Q2J2ZHd6WVZqM3J6b0x1?=
 =?utf-8?B?UDFhMVlBVzhUMktzbTNLR2M1YXV3eU9VVkRlYnRXL3pZQVd1TlFWbFM5Ungz?=
 =?utf-8?B?N3ZlK1kvb0NCOHV3M3lCbERpYWlQQURnUk1lbVlIUWRqb3NFRUpNRjU5S28y?=
 =?utf-8?B?dUxTejVlNWxKZjB2dnUwS3Bra1YzTnFXVzh2WjJCR1FhOGRUeUhJbjdMYlRz?=
 =?utf-8?B?bHJCQ2YvMFVjYXNMMUcxREhpZjM2T2g4YVhKYXMvME1vQ0IxOTFIUHZrRTkv?=
 =?utf-8?B?REU3MWFPYWhsRkJpM2JNYWFuTUJRT3E1MWNDK1V4anA5SlRabVlUUjlleEpI?=
 =?utf-8?B?dHgzUGljT2s2ZUFndWkxSmI2TGNuV251M2FuUW1SNm4rSnc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7183.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3MrUjNpcVRBaWJwemQ4czVZS3BQdC8waWQ4VjA2TFgvY3Fqa3Mxb3FZWE5H?=
 =?utf-8?B?V3c1T1JhUjNVZUc3LzUvZ3Y2RmhFT2Myc09vbmkxdVZlOHpyTEJHalpJWHdJ?=
 =?utf-8?B?T3BQY0xnYjQrOC9MMWt5OEFubnBCTExrTmNsRmZGclQyOFhNSWtiajFFbnpj?=
 =?utf-8?B?TzdSa1dPb255YVFyQ1YxNVl6dzRYTWhic1ZlamY2ejRZcitreTJvMlQ1dmdC?=
 =?utf-8?B?c1BrVENHaXRKL2lNUnVHVHp1ZmNYbWo1K1Y5aHZKbmRGbDRkNm9XZmFMMHFT?=
 =?utf-8?B?R1p3cVlpWGlUQ0tjaDdhbm1XdWJUaUV0cXJ4N29DQTNCazJxdkNEcDJ4Ujdh?=
 =?utf-8?B?Mk1pZTVBMnFEaHF2UzR5MHk1elkrOFdWN3hXdE83V2oyaHlPY3lkeXlxeHhh?=
 =?utf-8?B?ZEhCSFdCT2VXK1lPT2wxZldjWmUyY1ZONUpObUplRzE4QWxRY2NOQVRGRUNB?=
 =?utf-8?B?UmQyK3JRVnFvRExVYldzQXNIS3I4bWk1dkRRbndSdnRPREhZRW9LNGRSYUZz?=
 =?utf-8?B?SW0zTGZodERrSXlxQ2wxY093S2ZIMTd0VVhJVnZEb2RrS052c1lNbGtKVUY5?=
 =?utf-8?B?WnhTWm93eCt5bEZXc21TNVYyaXYrN1RhOTI3NnBhSWhEYzBYbmFtWWZPY3hP?=
 =?utf-8?B?a1V1SlZqdkZKMXZIWTlqeXhJaTIyQ3p2VkRudy92M3QvSkIxeXNuTnd1cGFH?=
 =?utf-8?B?U0JPL2czV0U2K0Q5RmVYWlZIbCtUTzJNQmFMUStNUjNibXcxOEhTSnlnWEtx?=
 =?utf-8?B?L1Z5NHUyeWdkY2UyWUJvdGRwa1FMVXRNTkFUZE9Benc1WnBYTUZWMFJXOStE?=
 =?utf-8?B?TlBlRi94ckh5MmZTbmJzRHpzNU1XS3ExdndrcEFFRGdBVitOWWw3MnYyQ0Jo?=
 =?utf-8?B?UmlRZnoycmlTYXhKUHZEYXdMeTlsK3pabThxb2NzdGl2TTFLSmpHUkRnZVU5?=
 =?utf-8?B?SWFsMnUzRVUrZUFBU20wOXFLWFduTVh4SUxRTlBCTDY1V3NGYmVxTTIyYTE1?=
 =?utf-8?B?dERsVnowS2crbU5LQlppZy9JZFEwNURLeFRuM2tVdFUrbGJ1L0p5dDFveW1Z?=
 =?utf-8?B?RENITWZsWVNEUVEzRmNRNEE3bWUzOTNhSUtSaGF2eGl4NE5zZFRxVDl3cmlS?=
 =?utf-8?B?TmhudElsNFBUSDhZcDlHVmtmWHcyeHVza09OWmtQOWgzYjlySVBPcldzcFBM?=
 =?utf-8?B?WjNTaXVPbkNYaVloekhwVVFISG1xWnloTlB2c2RFaHZqRGptekR3cXM2ZVZW?=
 =?utf-8?B?STN1dytWRGVGTlFzeXJnR2t5SUdhRWNjTnZMS0VQYldZVzN3VGcwWmhvMVc1?=
 =?utf-8?B?K0RYMllXR1NSSitqYU8yZ3dRY1kxM0FPemJoYXZ6MWlBN0FQcTJPWm9YelRu?=
 =?utf-8?B?YWZwRXNmRVdUOW5SbHMwMTM3ejhqa1J3MkdCb0w3ZDJidHV5d3ZRYkpGTFJl?=
 =?utf-8?B?UEVNazBrV000M1dnejUvQ0N0SnQvUk5xeER5ZEFHcjlubGk3azl6MVRGWVNN?=
 =?utf-8?B?MThNU1BDOHhmeEs1T2RicWFnbWF2cHprYUZ5UUJlalZpM3p5WjRZUkQ2VVJy?=
 =?utf-8?B?U0htQllWV28zbGNSd3ZBUitZMnZiaktCZkNwLy9EL0crb2ZwV0gwMW1teGpM?=
 =?utf-8?B?YTd6NWpHeEp3NVNVWDJ2QWFJaWFldUhJbUVMOG1nWHl5OVgzTENqbEdCbU9r?=
 =?utf-8?B?Ri9kSFZaVkZFMENZZmhJRVpSa1VTeFI3MUlxbCtaWDVoV25GRmtRRjlmL2pP?=
 =?utf-8?B?Sjl0amlFSGRNUEdjK1dwOURGWHJkQ0F2UHl0OHUramd1UXpLVTVWcnBlcWJN?=
 =?utf-8?B?QzZQQUgydmtTK3N2MW1iZ1NaaDI4QXJYTFA5VCtvRlNBMFRLSy9NU0xyazlU?=
 =?utf-8?B?VUdndVYrS3BiTis3UVdLZms4d2FOdGRvVXBiQWZ6cS9IRzR5aDBLakhuTzkz?=
 =?utf-8?B?dzhQU3FWYVdMM1BCLzJnckl0Qk1HMVpXSTAvR1NoSVdtVm1PZjQvWmRKTWsv?=
 =?utf-8?B?YUdGVkVMN3RLQmcraCs4MVpNRjB2MndqVWFGaTBlc2lDdkcrRWRHbnBpWnJa?=
 =?utf-8?B?QlVMRnB4RDN5TzIwemhQTldhQndWTjVxeS85ZmNNZUVUWThTNG9FYUlxeVhx?=
 =?utf-8?B?ZC9aaFJVcGFnR3dsaWJLQkZTY2hlb2FjTXZOL3ExRkR4VTRQRWZGcC9uMGdB?=
 =?utf-8?B?REE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <25616A5402691247AA5B5D87528C0502@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7183.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ea325f-db30-44aa-abda-08dcaa12d9fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2024 05:55:12.2968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ETBr1Kes96W9KUL8CtlMFSGt8fxM4a9ZEl4IXxA1e6N+JhP2EKYvfD4I0O0COrhL28gt1F5PZ74cNP+GWSLYCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7983

T24gV2VkLCAyMDI0LTA3LTEwIGF0IDE3OjE5ICswODAwLCBUemUtbmFuIFd1IHdyb3RlOg0KPiAi
dHJhY2luZ19tYXAtPm5leHRfZWx0IiBpbiBnZXRfZnJlZV9lbHQoKSBpcyBhdCByaXNrIG9mIG92
ZXJmbG93aW5nLg0KPiANCj4gT25jZSBpdCBvdmVyZmxvd3MsIG5ldyBlbGVtZW50cyBjYW4gc3Rp
bGwgYmUgaW5zZXJ0ZWQgaW50byB0aGUNCj4gdHJhY2luZ19tYXANCj4gZXZlbiB0aG91Z2ggdGhl
IG1heGltdW0gbnVtYmVyIG9mIGVsZW1lbnRzIChgbWF4X2VsdHNgKSBoYXMgYmVlbg0KPiByZWFj
aGVkLg0KPiBDb250aW51aW5nIHRvIGluc2VydCBlbGVtZW50cyBhZnRlciB0aGUgb3ZlcmZsb3cg
Y291bGQgcmVzdWx0IGluIHRoZQ0KPiB0cmFjaW5nX21hcCBjb250YWluaW5nICJ0cmFjaW5nX21h
cC0+bWF4X3NpemUiIGVsZW1lbnRzLCBsZWF2aW5nIG5vDQo+IGVtcHR5DQo+IGVudHJpZXMuDQo+
IElmIGFueSBhdHRlbXB0IGlzIG1hZGUgdG8gaW5zZXJ0IGFuIGVsZW1lbnQgaW50byBhIGZ1bGwg
dHJhY2luZ19tYXANCj4gdXNpbmcNCj4gYF9fdHJhY2luZ19tYXBfaW5zZXJ0KClgLCBpdCB3aWxs
IGNhdXNlIGFuIGluZmluaXRlIGxvb3Agd2l0aA0KPiBwcmVlbXB0aW9uDQo+IGRpc2FibGVkLCBs
ZWFkaW5nIHRvIGEgQ1BVIGhhbmcgcHJvYmxlbS4NCj4gDQo+IEZpeCB0aGlzIGJ5IHByZXZlbnRp
bmcgYW55IGZ1cnRoZXIgaW5jcmVtZW50cyB0byAidHJhY2luZ19tYXAtDQo+ID5uZXh0X2VsdCIN
Cj4gb25jZSBpdCByZWFjaGVzICJ0cmFjaW5nX21hcC0+bWF4X2VsdCIuDQo+IA0KPiBDby1kZXZl
bG9wZWQtYnk6IENoZW5nLUp1aSBXYW5nIDxjaGVuZy1qdWkud2FuZ0BtZWRpYXRlay5jb20+DQo+
IFNpZ25lZC1vZmYtYnk6IENoZW5nLUp1aSBXYW5nIDxjaGVuZy1qdWkud2FuZ0BtZWRpYXRlay5j
b20+DQo+IFNpZ25lZC1vZmYtYnk6IFR6ZS1uYW4gV3UgPFR6ZS1uYW4uV3VAbWVkaWF0ZWsuY29t
Pg0KPiAtLS0NCj4gIGtlcm5lbC90cmFjZS90cmFjaW5nX21hcC5jIHwgNiArKystLS0NCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KSnVzdCBh
IGdlbnRsZSBwaW5nLiBBbnkgY29tbWVudHMgb24gdGhpcyBwYXRjaCB3aWxsIGJlIGFwcHJlY2lh
dGVkLg0KQWN0dWFsbHkgd2UgaGF2ZSBlbmNvdW50ZXJlZCB0aGlzIGlzc3VlIGludGVybmFsbHkg
YWZ0ZXIgZW5hYmxpbmcgdGhlDQp0aHJvdHRsZV9yc3Nfc3RhdCBmZWF0dXJlIGluIFBlcmZldHRv
IGZvciBhbiBleHRlbmRlZCBkdXJhdGlvbiwgZHVyaW5nDQp3aGljaCB0aGUgcnNzX3N0YXQgdHJh
Y2Vwb2ludCB3YXMgaW52b2tlZCBvdmVyIDJeMzIgdGltZXMuDQpUaGVuIHRoZSBDUFUgY291bGQg
aGFuZyBpbiBmdW5jdGlvbiAiX190cmFjaW5nX21hcF9pbnNlcnQoKSIgYWZ0ZXIgdGhlDQp0cmFj
aW5nX21hcCBsZWZ0IG5vIGVtcHR5IGVudHJ5Lg0KDQp0aHJvdHRsZV9yc3Nfc3RhdCBpcyBsaXRl
cmFsbHk6DQoxLiAkZWNobyAicnNzX3N0YXRfdGhyb3R0bGVkIHVuc2lnbmVkIGludCBtbV9pZCB1
bnNpZ25lZCBpbnQgY3VyciBpbnQNCm1lbWJlciBsb25nIHNpemUiID4+IC9zeXMva2VybmVsL3Ry
YWNpbmcvc3ludGhldGljX2V2ZW50cw0KMi4gJGVjaG8NCidoaXN0OmtleXM9bW1faWQsbWVtYmVy
OmJ1Y2tldD1zaXplLzB4ODAwMDA6b25jaGFuZ2UoJGJ1Y2tldCkucnNzX3N0YXRfDQp0aHJvdHRs
ZWQobW1faWQsY3VycixtZW1iZXIsc2l6ZSknID4NCi9zeXMva2VybmVsL3RyYWNpbmcvZXZlbnRz
L2ttZW0vcnNzX3N0YXQvdHJpZ2dlcg0KDQo+IGRpZmYgLS1naXQgYS9rZXJuZWwvdHJhY2UvdHJh
Y2luZ19tYXAuYyBiL2tlcm5lbC90cmFjZS90cmFjaW5nX21hcC5jDQo+IGluZGV4IGE0ZGNmMGYy
NDM1Mi4uM2E1NmU3YzhhYTRmIDEwMDY0NA0KPiAtLS0gYS9rZXJuZWwvdHJhY2UvdHJhY2luZ19t
YXAuYw0KPiArKysgYi9rZXJuZWwvdHJhY2UvdHJhY2luZ19tYXAuYw0KPiBAQCAtNDU0LDcgKzQ1
NCw3IEBAIHN0YXRpYyBzdHJ1Y3QgdHJhY2luZ19tYXBfZWx0DQo+ICpnZXRfZnJlZV9lbHQoc3Ry
dWN0IHRyYWNpbmdfbWFwICptYXApDQo+ICAJc3RydWN0IHRyYWNpbmdfbWFwX2VsdCAqZWx0ID0g
TlVMTDsNCj4gIAlpbnQgaWR4Ow0KPiAgDQo+IC0JaWR4ID0gYXRvbWljX2luY19yZXR1cm4oJm1h
cC0+bmV4dF9lbHQpOw0KPiArCWlkeCA9IGF0b21pY19mZXRjaF9hZGRfdW5sZXNzKCZtYXAtPm5l
eHRfZWx0LCAxLCBtYXAtDQo+ID5tYXhfZWx0cyk7DQo+ICAJaWYgKGlkeCA8IG1hcC0+bWF4X2Vs
dHMpIHsNCj4gIAkJZWx0ID0gKihUUkFDSU5HX01BUF9FTFQobWFwLT5lbHRzLCBpZHgpKTsNCj4g
IAkJaWYgKG1hcC0+b3BzICYmIG1hcC0+b3BzLT5lbHRfaW5pdCkNCj4gQEAgLTY5OSw3ICs2OTks
NyBAQCB2b2lkIHRyYWNpbmdfbWFwX2NsZWFyKHN0cnVjdCB0cmFjaW5nX21hcCAqbWFwKQ0KPiAg
ew0KPiAgCXVuc2lnbmVkIGludCBpOw0KPiAgDQo+IC0JYXRvbWljX3NldCgmbWFwLT5uZXh0X2Vs
dCwgLTEpOw0KPiArCWF0b21pY19zZXQoJm1hcC0+bmV4dF9lbHQsIDApOw0KPiAgCWF0b21pYzY0
X3NldCgmbWFwLT5oaXRzLCAwKTsNCj4gIAlhdG9taWM2NF9zZXQoJm1hcC0+ZHJvcHMsIDApOw0K
PiAgDQo+IEBAIC03ODMsNyArNzgzLDcgQEAgc3RydWN0IHRyYWNpbmdfbWFwICp0cmFjaW5nX21h
cF9jcmVhdGUodW5zaWduZWQNCj4gaW50IG1hcF9iaXRzLA0KPiAgDQo+ICAJbWFwLT5tYXBfYml0
cyA9IG1hcF9iaXRzOw0KPiAgCW1hcC0+bWF4X2VsdHMgPSAoMSA8PCBtYXBfYml0cyk7DQo+IC0J
YXRvbWljX3NldCgmbWFwLT5uZXh0X2VsdCwgLTEpOw0KPiArCWF0b21pY19zZXQoJm1hcC0+bmV4
dF9lbHQsIDApOw0KPiAgDQo+ICAJbWFwLT5tYXBfc2l6ZSA9ICgxIDw8IChtYXBfYml0cyArIDEp
KTsNCj4gIAltYXAtPm9wcyA9IG9wczsNCg==
