Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2104.outbound.protection.outlook.com [40.107.135.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415C62836A
	for <linux-trace-kernel@vger.kernel.org>; Mon, 27 May 2024 07:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.135.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716795828; cv=fail; b=RMGqLGzk/R7wFISGeF2wOIgyVYkbPMwjy3JHKH7vp9aHerQfVQkY7mdtlQi3rz+N/EvB9C7R7W3nh0P35C6b/mh3SvSXxPma8LxgIJIYyzZd/ZyHn5ltZaHDbB7sbY8YhLByFkEN+0o6+ybKjdeWO4dJ8WSkFg8rf1p2XDtMHX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716795828; c=relaxed/simple;
	bh=7bNkyOgl64oOybV3DGyg+NG+r9Q5v3p/buCPSGf9dV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Jq8HmavMwQRJYqm1dp0jpQ43CYF56kGWFFmJ+ZXpflGsnB+tBvFjN6iWhRHgaIymVGirNAMAhejgCNRf1Z+HTNbIr1sKn1F6PHlmIyCEsp9fZ4voR0cHhewrS741k9nUusMfZcTgJfAegOuQyYE/b0o+IPn7rujrLyji+APdcTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eckelmann.de; spf=pass smtp.mailfrom=eckelmann.de; dkim=pass (1024-bit key) header.d=eckelmann.de header.i=@eckelmann.de header.b=1OcQPgCy; arc=fail smtp.client-ip=40.107.135.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eckelmann.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eckelmann.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eckelmann.de header.i=@eckelmann.de header.b="1OcQPgCy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVjs0Ktl4JDlJUNEUuBgxl3zKU4ddje3sDZXwpoVkn9cUYLnaZ1AvMhcXD+O2ajPcP1+fB9aONWQxPdl3TQxP6Rm6l2XblA8BtSMIUxNTJ5ZAFY/ykhgeK650bx+Q1JuRIdCP7HuuutmumdbC3K794FPN6J/onSNA+2fAEZNgYZHP15PrX1m1+1LwcQZNm6nVfIwcULyld/X/XWyY3cXUrgyP3fy4IgO/EE7vjHXoFS2JX0xL9mlfGwQwUNO1po1tqnYe4vvL9vESEtUG8SeW9DveO0OTHkGyacZaQafMU81vxYhaikwtn2y6lt1PvezvjCHfj3gtR6anXv2Wl8xhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0mRg+Iv/7hcHD/53uipQPdLlRHUChUq6P6B7Gydqiss=;
 b=BgHvASyi4510tGQfi1KViv5IN6KPICUddbxA83JvdN06/jpow2kgynVhp4LBvXy0T6/chwpQRhS8lbeD4Nnnxu11QbnPZKdagFhokR6PbYAhcUxlkD4G2NUO33H+U22XQlNbrRznCj2x3BqcJRXLE1p9BjWLkMqiiZkhnee9hgMwv0Zm3TvJmEX+/MuBk0Q/Cg0HR0W4PPaw7SXtWCLQbzQhLJ2gISTFi36sTqzATB+Mbr8cRuPq9IhzXoeBU/F/nxaHcFqKtx6pxNBwzWWnE4Nvfu5cJk3cZV1c41WlT6ao+tC9fEBKogUP296bT6NrpgHwy0l2Q4LTylI3Klf1/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eckelmann.de; dmarc=pass action=none header.from=eckelmann.de;
 dkim=pass header.d=eckelmann.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eckelmann.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mRg+Iv/7hcHD/53uipQPdLlRHUChUq6P6B7Gydqiss=;
 b=1OcQPgCy0Y3hNpiECCwTauVui0q2BwKX+j6a4FQFWIWazxVY2qcf6cKqc3zqUzp4y3Ndc3KOitpXwv/R96teEisTq9QsNZk/xH/u8n4zBaL0mTdOZSYCGy1vF7Wf3ChjlCZCn/3K0umieRMGWblSbHeP4MPCPwKG6aLyJ7Lg5Xk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eckelmann.de;
Received: from FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:da::13)
 by FR3P281MB1630.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.16; Mon, 27 May
 2024 07:43:42 +0000
Received: from FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
 ([fe80::3927:fe99:bb4:1aa7]) by FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
 ([fe80::3927:fe99:bb4:1aa7%6]) with mapi id 15.20.7633.001; Mon, 27 May 2024
 07:43:42 +0000
Date: Mon, 27 May 2024 09:43:41 +0200
From: Thorsten Scherer <T.Scherer@eckelmann.de>
To: ardb@kernel.org
Cc: rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com, 
	linux@armlinux.org.uk, linux-trace-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Justin Chen <justin.chen@broadcom.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Doug Berger <doug.berger@broadcom.com>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, kernel@pengutronix.de, Thorsten Scherer <T.Scherer@eckelmann.de>
Subject: Re: ARM Ftrace Function Graph Fails With UNWINDER_FRAME_POINTER
Message-ID: <z42qu35nuybho36bwjdoatqp3skwm7w2l4apd75ubzaezyvxef@f6yrdlgltlaf>
References: <d870c149-4363-43de-b0ea-7125dec5608e@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d870c149-4363-43de-b0ea-7125dec5608e@broadcom.com>
X-ClientProxiedBy: FR3P281CA0144.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::15) To FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:da::13)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FR4P281MB3510:EE_|FR3P281MB1630:EE_
X-MS-Office365-Filtering-Correlation-Id: dec0bbb5-2789-48ab-9ad8-08dc7e20bafe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3dTbJNXkPStMGdol1EBN/il/6lJuMyp0WrFWgVIjSnGQIH5nXHpTs7S9FLEF?=
 =?us-ascii?Q?voVBZkMrTwky63X0CVfihDKVyZe/F3+ebcwS6z1ZcQ4+7qnwed9SCX2mp21z?=
 =?us-ascii?Q?bbdJbyq6iZ+5GeN/8V7vxqTvsoZwwiJ/ph5cEJZGAkYmF0WLQe1MODeUf1u5?=
 =?us-ascii?Q?A46iygMKUhvbvbkdvhEXPysN2LVKNv8ThkM/3AcxhgJNTONykgv/9llJF8qw?=
 =?us-ascii?Q?bZVfg36Yl7faMRYFfjV9Sl2jTjM+0Cz4RgKrKHmKWn4lfoI9IOywVagO9JXS?=
 =?us-ascii?Q?plDRBURaDjFXvbuNfCkMK4opdvkzJQXTN+hFqUwPs5X8K1pb97TDvdppch9s?=
 =?us-ascii?Q?LqWiu4suf6CWYMvEzhZ4CdO5IgcybxkH/2Nr+OeYdqxwtRuxH/Rva4SyVwqp?=
 =?us-ascii?Q?TQVjgYaqwNnZwJxV2gaagcWYdv6jW9/2zIT+hIjGkMkNXzawf/v9FLQs9VnL?=
 =?us-ascii?Q?bHG/l0Xc6eXXaEAhLS8B23ABIWzv7wbf04mYYG1aAwGGrdB/xnKtsREYLqgn?=
 =?us-ascii?Q?k999C5+zYz7jrTuvYeqdbz5NY0GnBRtonLBCnVBGRGtbPS6tAcfB9q0ztwYT?=
 =?us-ascii?Q?6gMkogBGtYgV8zal4qO9oZFw1OUcpKPKyILgdUIhzGx/dljPv0fSTzGK4eXb?=
 =?us-ascii?Q?SW9Ub+rxrZhko7tBdNo8zdg67N52QoO3K/ZkgFKVFGM6uIcdGTWWXvzWRU70?=
 =?us-ascii?Q?9a/4jwQEvKzFSChnEPVKDl0tcife19Qe/E2mXJUVUUTBplS3E4L5kU9BxgQN?=
 =?us-ascii?Q?BOMroL2wK7n3VORj3Z4+ons9Tl8UKCwEIeUkYzlx10GoFbmWLlr7OFvscUm3?=
 =?us-ascii?Q?NSxZnyNIPgw0wZvOxnBpcp85mSAmP72f+UkzMt2cL0ZvMG65rf5ukbf7CAPQ?=
 =?us-ascii?Q?T42lvEZYlUmsREbT+a9+pTt5OSi+nc0sYFnADv60RbZzb5zltTFb1MxZPJDd?=
 =?us-ascii?Q?jQ7g1PqnS3GgJoD7yH938Yl635hTjdWF5knao6jNPWmyzyb0JYdTzBsapMqR?=
 =?us-ascii?Q?aggeKQfT0b0SGccuBAdrxxFMqxCnOdGFFdFHD02wZSuV2nWLlGAcmKRVLx1O?=
 =?us-ascii?Q?AbbDZpgYx6EUPFiI4Ur4+zj4QtWO6G3wQeDK1thAiIjbHNOC4Sx0XrgtRq0/?=
 =?us-ascii?Q?qfQIUAqm1DMFiYJSL00pZqWs+1y0lRQfKqHU07xik47oOycr1Tsxz5l2BIPc?=
 =?us-ascii?Q?1NLowlMXY8pMvAUgft5pOVniLspdNivARU/eUQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MpeoqKGftAOrWOA8K88LzUQ8Nrfx81RFXKgguozHfYf4kNZCWhf0Xtoi1Eig?=
 =?us-ascii?Q?3KcqQEf6MDSLs5FJtgwDl1I1Vir5/8N8EBTjUXAKw8kYg23ZvUTWvcb+zJTh?=
 =?us-ascii?Q?iTUMHB8kkZen2951uBOPKdttPWZoN2o4tQGPu6bLP4JtCbejlhdqqswAOC0S?=
 =?us-ascii?Q?LEEpetjTLJFttkMfV/eAh+HfPamki+dM2dgEn8J2fay6CCu0u6LB8UvN4KeN?=
 =?us-ascii?Q?RPggoTA/fiMfZZ+s0P/uZtv+J+ztglSdcNvug4I9sxLIcwCGCOlih54M0XGY?=
 =?us-ascii?Q?flPSAJ/b6YhaD+FQSGBRyZJOFOl51zzPkfOb7Lxnom3IGRzn+AM560fXVhmS?=
 =?us-ascii?Q?pe9yoyIA/H5X8ILssHx6Eyxg0vNYnpI8lCOcNjQC6MeQstC9kmHoGud1Yjnl?=
 =?us-ascii?Q?iA3eia6eUuy16UW0eo2QMMrees0C5pMNl0qwdGiN//Lp2iB5Ogfay8vR8xSU?=
 =?us-ascii?Q?qPjoB0314qtINs3GID1AVp61/abmsnyZWWaVBG6ymEj5Armg3zQkIPxrzaFA?=
 =?us-ascii?Q?JsItZUnnkwDepziA1BrkMFZZqfGjWHqxmaF1eC8yLdusHivihq23n+Kb2z1C?=
 =?us-ascii?Q?8DSnL5/93VJGPUIVfrDtC93y36DHl2sJIJaltrqGfYiLNPbCKT74YtJkdt02?=
 =?us-ascii?Q?BQjZXIOWjRqv+L8fAYjzHxNCXQby1MIjXXNjBMs+Y5YFanShSOppaDeeAlGL?=
 =?us-ascii?Q?1F6/ISWjhwuGiTLp1lnrmK9we/ebWEaGF2p62Epi7Awtp+voRaybDe1a+v+C?=
 =?us-ascii?Q?W3VkcfbNyieuUi/UiUCxH3ofFVgc2sWJC+n8TJ33+mbE85X9+cyFQ8pSbFvq?=
 =?us-ascii?Q?WQYt5wws9WdNhokebZXmjdxkZO8CoVJQPFdVqPl1R+BEI4f3FmiE151wlhMt?=
 =?us-ascii?Q?VmgHXgxgENmzqKBX9GS75Z5V4SJt5Z03WKKCNTJrM9QwdE1OxqPDYv2uhx8j?=
 =?us-ascii?Q?LkydsnItTNsqPJbUrpRsvOVO2ax+1budkCbv063a3CeMpLW0FRDiFilvhjJ/?=
 =?us-ascii?Q?4fhiSl01FRR6IZRf9ayguNiibhKzG7HnADTslLIuhRilVM8yF/FZIv1qM1cW?=
 =?us-ascii?Q?1czUBERTHECynE0nMJzzcTHRYBCWOA25iv5Ca5pP0aQKspNIzSwPZPcHpPkj?=
 =?us-ascii?Q?xoVFrQxHtiN7wa0T8pekKRF9lCSn5wkKYXhUE5VC30KuPze0EaDuo6DR1WHv?=
 =?us-ascii?Q?DSjNK37uEHSFxuCmplBE2sZMEm65SlWMG9dTAEqqzfS7nIoO75CmsrCOQhaV?=
 =?us-ascii?Q?pUqcH/UAZMz52frISO0SJstydZrvgymlqcrX/sHwQeAM2V0v0ms7n2kKKa8w?=
 =?us-ascii?Q?P2eN0tNS1SVRkyQjX8kZzqGXnFTyi8Bd5qjtJNhew0OLWjIIo8wPCFpVx/hC?=
 =?us-ascii?Q?LB2kX3V3t2cZfnYegHct31Yu/GoZ3MEowHS8C+oKti18Oj1ebMcULXf2aTkA?=
 =?us-ascii?Q?qv7oXyLjQPMS5XYRf2viXEE+oBk0iWF1r/+3de4ZbHtf57D6S6zziXVmg5CE?=
 =?us-ascii?Q?FkU/+jkMdlUXPvZOT5VBNiXqYI3d8K/rbvS0qQGAx6uvEh1dWVPeAErtmsUR?=
 =?us-ascii?Q?dc4R5JUwypTTvawKhpfQfsvFY2WpvXZMRNvBa1I/H37uRwgGtjlFPZ8/Qzz9?=
 =?us-ascii?Q?XV9/z9pFbiYm9QJ+kRK3O8CXfajzCABKMMPFBgQu8hqScB1Laby9O+Qxrze+?=
 =?us-ascii?Q?thr14A=3D=3D?=
X-OriginatorOrg: eckelmann.de
X-MS-Exchange-CrossTenant-Network-Message-Id: dec0bbb5-2789-48ab-9ad8-08dc7e20bafe
X-MS-Exchange-CrossTenant-AuthSource: FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 07:43:42.3329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 62e24f58-823c-4d73-8ff2-db0a5f20156c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rNPb4PW2gIyQoWWeysLQqHhxxOZUD2KTFC7bfFNQwBspDaCKywMQJiAUJhpgXN7Vy9ME9+nCqCSKnO8A74Ig1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB1630

Hello,

in the context of a panic on an i.MX25 based v6.9 kernel [1] Uwe pointed me to
this thread.  With the proposed code change applied the procedure

    # set to some known good (randomly guessed) filter function and enable function_graph
    echo mtdblock_open > set_ftrace_filter
    echo function_graph > current_tracer

    # walk available filter funcs
    cat available_filter_functions | while read f; do echo $f | tee -a set_ftrace_filter; sleep 1; done

produces the following output

[  159.832173] Insufficient stack space to handle exception!
[  159.832241] Task stack:     [0xc8e44000..0xc8e46000]
[  159.842701] IRQ stack:      [0xc8800000..0xc8802000]
[  159.847712] Overflow stack: [0xc1934000..0xc1935000]
[  159.852726] Internal error: Oops - BUG: 0 [#1] PREEMPT ARM
[  159.858273] Modules linked in: capture_events_imxgpt ti_ads7950 industrialio_triggered_buffer kfifo_buf capture_events_irq capture_events iio_trig_hrtimer industrialio_sw_trigger industrialio_configfs dm_mod
[  159.876948] CPU: 0 PID: 199 Comm: sh Not tainted 6.9.0 #3
[  159.882412] Hardware name: Freescale i.MX25 (Device Tree Support)
[  159.888547] PC is at prepare_ftrace_return+0x4/0x7c
[  159.893520] LR is at ftrace_graph_caller+0x1c/0x28
[  159.898376] pc : [<c010dd44>]    lr : [<c010d988>]    psr: 60000093
[  159.904690] sp : c8e44018  ip : c8e44018  fp : c8e4403c
[  159.909959] r10: c0c09e78  r9 : c35e9bc0  r8 : c010d9bc
[  159.915227] r7 : 00000001  r6 : 00000004  r5 : c8e44064  r4 : c8e440ac
[  159.921800] r3 : c8e44030  r2 : c8e4403c  r1 : c010eb9c  r0 : c8e44038
[  159.928376] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
[  159.935652] Control: 0005317f  Table: 83074000  DAC: 00000051
[  159.941436] Register r0 information: 2-page vmalloc region starting at 0xc8e44000 allocated at kernel_clone+0xa8/0x408
[  159.952253] Register r1 information: non-slab/vmalloc memory
[  159.957988] Register r2 information: 2-page vmalloc region starting at 0xc8e44000 allocated at kernel_clone+0xa8/0x408
[  159.968791] Register r3 information: 2-page vmalloc region starting at 0xc8e44000 allocated at kernel_clone+0xa8/0x408
[  159.979592] Register r4 information: 2-page vmalloc region starting at 0xc8e44000 allocated at kernel_clone+0xa8/0x408
[  159.990391] Register r5 information: 2-page vmalloc region starting at 0xc8e44000 allocated at kernel_clone+0xa8/0x408
[  160.001187] Register r6 information: non-paged memory
[  160.006303] Register r7 information: non-paged memory
[  160.011415] Register r8 information: non-slab/vmalloc memory
[  160.017139] Register r9 information: slab kmalloc-32 start c35e9bc0 pointer offset 0 size 32
[  160.025718] Register r10 information: non-slab/vmalloc memory
[  160.031530] Register r11 information: 2-page vmalloc region starting at 0xc8e44000 allocated at kernel_clone+0xa8/0x408
[  160.042422] Register r12 information: 2-page vmalloc region starting at 0xc8e44000 allocated at kernel_clone+0xa8/0x408
[  160.053315] Process sh (pid: 199, stack limit = 0x68fc3abb)
[  160.058955] Stack: (0xc8e44018 to 0xc8e46000)

and points me to copy_from_kernel_nofault_allowed.

    Disassembly of section .text:

    c010eb8c <copy_from_kernel_nofault_allowed>:
    c010eb8c:       e1a0c00d        mov     ip, sp
    c010eb90:       e92dd800        push    {fp, ip, lr, pc}
    c010eb94:       e24cb004        sub     fp, ip, #4
    c010eb98:       e52de004        push    {lr}            ; (str lr, [sp, #-4]!)
    c010eb9c:       ebfffb4f        bl      c010d8e0 <__gnu_mcount_nc>
    c010eba0:       e35004bf        cmp     r0, #-1090519040        ; 0xbf000000
    c010eba4:       3a000003        bcc     c010ebb8 <copy_from_kernel_nofault_allowed+0x2c>
    c010eba8:       e0900001        adds    r0, r0, r1
    c010ebac:       33a00001        movcc   r0, #1
    c010ebb0:       23a00000        movcs   r0, #0
    c010ebb4:       e89da800        ldm     sp, {fp, sp, pc}
    c010ebb8:       e3a00000        mov     r0, #0
    c010ebbc:       e89da800        ldm     sp, {fp, sp, pc}


In the time given I couldn't make sense of the issue, so I am passing this
hopefully useful information to you.

Best regards
Thorsten

#regzbot introduced: 953f534a7ed6b725d4f101d2949393acc9262880 ^

[1] https://lore.kernel.org/all/alp44tukzo6mvcwl4ke4ehhmojrqnv6xfcdeuliybxfjfvgd3e@gpjvwj33cc76/
