Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022126.outbound.protection.outlook.com [52.101.126.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A7C480DFC;
	Wed,  1 Jul 2026 12:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782908103; cv=fail; b=bEcLWBQmPg968fWZK53rz61CuSqpI60wbvxeMYNyYShKSl7lCYzvNFw+UsYTfNVSUD6t2507t7WybV8nA5be49thK+FRIxVXKy/sJntpsy9HoD4JFNedCIjmHLaEjJ92JVmaQEXnu8Cy17qeLyr3wVaYL4HCJ0KrjktqOHilO2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782908103; c=relaxed/simple;
	bh=p7LL+UH1pxky9qkgFzGCJFSfg6/JBr0TmZ/gr8Rfs6I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a6fps2RooXFdJN+Z8n9A2v7Y1MTBtLCLlSPFLUunHY6Z0sGeLmDBM17EtG5cLq22kCGYHDJI0dLQHjX+mxsXYqM3XKqvIfKcC2s0cQvGFIy1gy8SOd14V38KbKp1QvfF/64Uke3+mTaRD8FACSz/FJHFI6ksF4MHq9aQ4ari8Bg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com; spf=pass smtp.mailfrom=transsion.com; dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b=pohTzn5e; arc=fail smtp.client-ip=52.101.126.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=transsion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b="pohTzn5e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BnJWv6Rzy5x0ccurbjj/3UHO3eZ7jAJS6o22YibKl+COcW7Ta/BEV6Y1S3ccwV1IKT4FvZzsqGaoQJlqGTxeGKWzjJaH4qFJTohuLvyDLWcmm/lq4zdqIM5bFpS/8tYVWdYoWGl7iW42KnJz7hiNLCXMVGJzYaq6qz24TiH9nNq9JIOdWFU5amgAG77DjwK39a7Ij2h80b7309hHKgsq28n4b6jlk7o7FJYg17ggzEO4ey52P6n1sEvIj4m2QayinawdEyd///DnqwR3bP1M8qLeq0KVF6hHJwCW+SZMTf48dXWxMcWt7VkdQzNgCsp0wkagm2EpUTuMGzSM+7/OVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rX6zEZqjg3zKRdyG6wFITd5nI4c5fuTdwUtE1qN2EkA=;
 b=NdAdQLUO1NE4SlY+L/xRoB4WYDuLwyUiEmAV/Q1yt1mJ6DDvTrqJC663WCbL8d/9iYL9KOgn0sZC1z+cAQEdR9Q65Z7Cg8ozD9Iyr6NoLRioPX6Rs2MsxCbpadoQuaK8R8jIFnGcIa5wsHffcjkbrsX64tg+xYIWo84UQzSeOJCjHsOZHmIlebVn0vXNaeMm4OXDMgJa4jw9CEpi9+/bVQT3YhjyTVNUtblxCT30u839Uhw9S/FImBZg9PqLpL8jcVtzwrJ8XBpjKwEivkHWrAkyStcDsHYuZSacYZ5fiK2LlbyeouiGMkgVPrJExYn7KhndaKRZKWApvzZfZA0Jlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rX6zEZqjg3zKRdyG6wFITd5nI4c5fuTdwUtE1qN2EkA=;
 b=pohTzn5eey/JQ6mYeeqvDkQzC9WY2mSgc7rocC0MDk1UJA9liBdssGbgxK/bWz+Lp7woTWlPl8lSZE/4abKUrOWLG59+DdhoOI4otVu4FwMMSzWMK4T7cQ3XIKM9Ei/CfFF2Fl9FOgf56RxoeLxKuklA6q44lDZ/3cvaMT73nH4=
Received: from SI2PR04MB5648.apcprd04.prod.outlook.com (2603:1096:4:1a4::11)
 by SEZPR04MB6573.apcprd04.prod.outlook.com (2603:1096:101:ad::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 12:15:00 +0000
Received: from SI2PR04MB5648.apcprd04.prod.outlook.com
 ([fe80::8ce1:b82b:3b19:f79d]) by SI2PR04MB5648.apcprd04.prod.outlook.com
 ([fe80::8ce1:b82b:3b19:f79d%5]) with mapi id 15.21.0159.018; Wed, 1 Jul 2026
 12:15:00 +0000
From: Pu Hu <hupu@transsion.com>
To: "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org"
	<will@kernel.org>, "naveen@kernel.org" <naveen@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "mhiramat@kernel.org"
	<mhiramat@kernel.org>, "yang@os.amperecomputing.com"
	<yang@os.amperecomputing.com>, Hongyan Xia <hongyan.xia@transsion.com>, Jiazi
 Li <jiazi.li@transsion.com>, "ada.coupriediaz@arm.com"
	<ada.coupriediaz@arm.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>
CC: Pu Hu <hupu@transsion.com>
Subject: [RFC 2/2] arm64: kprobes: Allow reentering kprobes while
 single-stepping
Thread-Topic: [RFC 2/2] arm64: kprobes: Allow reentering kprobes while
 single-stepping
Thread-Index: AQHdCVM8Mvt95BVvG06XAHiJOFFWAg==
Date: Wed, 1 Jul 2026 12:15:00 +0000
Message-ID: <20260701121448.3926-3-hupu@transsion.com>
References: <20260701121448.3926-1-hupu@transsion.com>
In-Reply-To: <20260701121448.3926-1-hupu@transsion.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR04MB5648:EE_|SEZPR04MB6573:EE_
x-ms-office365-filtering-correlation-id: eeeb1785-0920-4c92-2194-08ded76a5f79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|921020|18002099003|22082099003|38070700021|3023799007|56012099006|11063799006|6133799003;
x-microsoft-antispam-message-info:
 k7TZsUtnaiuczqr2/p2R2WsatCMgaCZUXldrZ65Ueu6J31E8xGr8PZ6MbtyxflaG8kq7EvOfeMBMUZsZ1yuHhySiAuFPoXc8bXYo76Gaj3OeHrn4NADQQJdoB7yZCYEufGTgQV+umAbCK3B0YtAjARi6avoK3y5ZlxZVzgOjrLKzOYdZ1fbfkcmTAdb/b5RVDPJLjZ3IxQlt4Nj1tvAHH1Ye66HlnDBm+Vi8JxqOdq1Jn/kd5Q7RqtkbtkpuBfnhxcbgPhTW3yVtcyyKEmT2UeosOIoGOCwiSqdgXDzkU7bdl1KaXVB6fdhzxPaKXAftY0kuqHqsUqZymJfh5L39AUJUayp4M/aTOjelBIU+HPXgQrsu7Lie+jEzVDrdR5bB7jYjuHRKadRyyvtxVnu5yATQRUbixZBt5s/9GdC0HDGvO0ImJHOrMV7UqlVBGN4V6G3eS6XwfOfiHnV+xqNc3+tT4dU8cFLPXr6ZYM5WMa70UCLtZkDs9461WHqhf67fB/uT6vGiECcJ3V+G6fZdwv3jWGFCc7u2xOsMygasb3gP+9TTfoAcJllO15SqHse8QHLJbqE/uy75jnN+VGs7LQBU5nq/7i0OxrJFpKxKvBCjOCdg4WdCyMKd7cAYEV8BqXBLbA4FzM666wK2a2Wab2VtOf74hTYHXWdWb3R2zdnxwGHXWRJfU98MT0eEVrubRwBhC6KK4n+LhFsl19cW1w0YBNNBPUIKHcL4TfahDYLcqBrL+ag1rEpyQ8bnVTIG
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR04MB5648.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(921020)(18002099003)(22082099003)(38070700021)(3023799007)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?6jiad91giz/YEotYYi8cCu8BP8g6l7Q9N4U1KtZoCEJBT1EhYg6Zf0al49?=
 =?iso-8859-1?Q?RbzSQaXDjiFSnfwSvFm7vGSX8Ux1UQjEQlFaVDPxsoQeZnVE1mdu4S5cnQ?=
 =?iso-8859-1?Q?LzPDks1sT+3nWqwyPTUbkk8U82SlTuyScedYw0Pa0kr3wB/INjIDcwVyDU?=
 =?iso-8859-1?Q?k+CrZdslVoDcvdkpB0WFcXFPCU2hzCQRzcMkocVq01qiNGwCu4thK++ZDA?=
 =?iso-8859-1?Q?PMEncm0LcIOniITZVbUG62qe4+k64c+Lsd3SdLiA2AboJuz+d5KSQUtztC?=
 =?iso-8859-1?Q?Clnfz2XmO8iTq1gtl7oc1fUMctJva1CR19JIOjjW4X70hdYzWqw+1Gw7Vw?=
 =?iso-8859-1?Q?mFXuC+ZDIlPYz6PEF05if4rmTsTq4sFvA5tLznXgNle/aeDAfX4geSV11z?=
 =?iso-8859-1?Q?dJMQBvyMS1Bj1LB2ZwQcJOvStNlk5ScGUYj9bZVEHwVZCQ2YrIrIRylN2a?=
 =?iso-8859-1?Q?a4BLEONs4Fo+lW71g6a4RfpZNj3J3/JXgIfrKwE8d1E5Fb+c94YpoGML+H?=
 =?iso-8859-1?Q?cgocwqkHdpUOhzK/wR9akd5qX/B3dZuC1K/MpV4SwAxib1CVamDod4ipAc?=
 =?iso-8859-1?Q?pgGnxJ/p4g2JhUFt+OwuRoA8396V82JHfV1PC85RiBVfDVvhZmts1lP4Zj?=
 =?iso-8859-1?Q?6BURngMnngA+uT1IuOorsW++FQCEEhNTMq1ChJk+hY3zYXy82s5zMtWFAi?=
 =?iso-8859-1?Q?6NP46VwIAcaCZIoOgCgp99VZZbW37h2KL2M2M+m5y4ncQ6S9MR8MFyz0jF?=
 =?iso-8859-1?Q?QNOw2iAvfUKYNPv0OU1nkqLQxjr2UzF5aVC8NEQ7EYMq/xHGHBM/rLYOTS?=
 =?iso-8859-1?Q?b6hOg4CB6gqpvsRfUl3vvgdr+iensyph171ShZg4qx3csDdEyXRrKH9MEY?=
 =?iso-8859-1?Q?Vp/58cVTDjfca5TgQKJ91c9/BUG3xyLTdE1K99zXiMoO+Fy8rDzJgBTI03?=
 =?iso-8859-1?Q?ONORp4eCaeTjLZDuSQ/UYljDrmM3gJYXTfglDG9dFkE+JkirwZwQxz9kjP?=
 =?iso-8859-1?Q?spPv9puBQr8rmvn6FfBFy4mhwKcJ922wUHULBqGjYMEIzdKLSLkDuRi/1z?=
 =?iso-8859-1?Q?m8Wbs1b8I7SAGmyeNWOYa6Wp9Js+px2RVWm/55so1j9WwDHZp2tHljDnc+?=
 =?iso-8859-1?Q?00c4IUVVeASzcHIKEHYTQ8s+09yfssRbqhOJ1ix7pycYKks3F+Xh5WEQYv?=
 =?iso-8859-1?Q?dVZWXn7HNWkKwLVqH4p+K7/5sPO2t+qAi2gP/4I50VC0tn7tIRLZgN9pF9?=
 =?iso-8859-1?Q?+G5Tem6dm2OwRN4a+sKLJlDjC6RKrN0OWe7qgmlLgcNiInOzlflXrPc48U?=
 =?iso-8859-1?Q?SzIlVBk3RuqIUzW7No3atDS1XcTmcCgSkaP3LoEMmkgqqialpnHqOEYvkX?=
 =?iso-8859-1?Q?gwgyRz+kowiqtKd/h64bgKR5BjShYik9z4KDYuSdYxKmWVj3htahhJ28Ds?=
 =?iso-8859-1?Q?l8nIYOMslDB7vzDjjxfAawjIZdYoWyvxDQ5DdB1zQIsphcG4LKG6GK8m/2?=
 =?iso-8859-1?Q?HvhIWa+CE3EJAFLphpDh3OWQmMt2A4MMEu/IhCXZP7usaZ+Cli+SxlmrHb?=
 =?iso-8859-1?Q?EYTaYjAN426l0dSo24DKojTXF+ZF10O/SfAtgCGn64ZZS90bGdrb1duzbo?=
 =?iso-8859-1?Q?9VMEG4T2GuBKp5Aykvg5F9NITNXXje3iA0cYgjkz1CaYypGictI0EZECED?=
 =?iso-8859-1?Q?1zhucxGyVW80ja3LT8ARdj7KKA4ZuzDrI3wCGH2mXfTcoqKLcqGq/9BPsB?=
 =?iso-8859-1?Q?4cvvtEY0DAIyziMUMldbKyQPjGOH205gaVeXCjE4x+t0ip?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: transsion.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR04MB5648.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeeb1785-0920-4c92-2194-08ded76a5f79
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2026 12:15:00.0982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2rEfzrzzjGX6/mUtHHPggm07U54F5jchinqSriOwxgPIiCTG/aJl6fwg5nBNcHoD5GKP2O44q5rpBGD2u7vVzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB6573

From: hupu <hupu@transsion.com>=0A=
=0A=
A kprobe can be hit while another kprobe is in KPROBE_HIT_SS state. This=0A=
can happen when tracing or perf code runs from the debug exception path=0A=
while the first kprobe is preparing or executing its out-of-line=0A=
single-step instruction.=0A=
=0A=
Currently arm64 treats a kprobe hit in KPROBE_HIT_SS as unrecoverable,=0A=
the same as a hit in KPROBE_REENTER. This is too strict. A hit in=0A=
KPROBE_HIT_SS is still a one-level reentry and can be handled by saving=0A=
the current kprobe state and setting up single-step for the new probe,=0A=
just like reentry from KPROBE_HIT_ACTIVE or KPROBE_HIT_SSDONE.=0A=
=0A=
The truly unrecoverable case is hitting another kprobe while already in=0A=
KPROBE_REENTER, because the reentry save area has already been consumed.=0A=
=0A=
Move KPROBE_HIT_SS to the recoverable reentry cases and leave=0A=
KPROBE_REENTER as the unrecoverable nested reentry case.=0A=
=0A=
This mirrors the x86 fix in commit 6a5022a56ac3=0A=
("kprobes/x86: Allow to handle reentered kprobe on single-stepping").=0A=
=0A=
Signed-off-by: hupu <hupu@transsion.com>=0A=
Signed-off-by: Hongyan Xia <hongyan.xia@transsion.com>=0A=
---=0A=
 arch/arm64/kernel/probes/kprobes.c | 8 +++++++-=0A=
 1 file changed, 7 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/=
kprobes.c=0A=
index e4d2852ce2fb..764b2228cca0 100644=0A=
--- a/arch/arm64/kernel/probes/kprobes.c=0A=
+++ b/arch/arm64/kernel/probes/kprobes.c=0A=
@@ -240,10 +240,16 @@ static int __kprobes reenter_kprobe(struct kprobe *p,=
=0A=
 	switch (kcb->kprobe_status) {=0A=
 	case KPROBE_HIT_SSDONE:=0A=
 	case KPROBE_HIT_ACTIVE:=0A=
+	case KPROBE_HIT_SS:=0A=
+		/*=0A=
+		 * A probe can be hit while another kprobe is preparing or=0A=
+		 * executing its XOL single-step instruction. This is still a=0A=
+		 * recoverable one-level reentry, so handle it in the same way as=0A=
+		 * reentry from KPROBE_HIT_ACTIVE or KPROBE_HIT_SSDONE.=0A=
+		 */=0A=
 		kprobes_inc_nmissed_count(p);=0A=
 		setup_singlestep(p, regs, kcb, 1);=0A=
 		break;=0A=
-	case KPROBE_HIT_SS:=0A=
 	case KPROBE_REENTER:=0A=
 		pr_warn("Failed to recover from reentered kprobes.\n");=0A=
 		dump_kprobe(p);=0A=
-- =0A=
2.43.0=0A=
=0A=
