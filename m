Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2123.outbound.protection.outlook.com [40.107.135.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924F5645
	for <linux-trace-kernel@vger.kernel.org>; Tue, 28 May 2024 04:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.135.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716871970; cv=fail; b=qy7Rw9xtuoDswYcCQKw6S2yHqgEHfImO+stTAf9yD1R/GV4x0hlOGjTnUI8EabxkVtIwE1nFqDAjZv4U4HRWg1zGe3RW5IpFesKYvpj5M8r2CZK94tgLTuPEXWx/3j1wIlYhc5X4YxYmjbIh6pNc1FvOKQSPnCI27Vk3L/WfFUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716871970; c=relaxed/simple;
	bh=9NPgXmhCoEUihgwA0xzHOV57o/vGfjERC2yRZfKifZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FQn7CnAvvA7/v3GO+JeVFPU+YA3gtU71u6Is6N8cRLBbkYOz60Daa1Bc0X95Ls9/hc+adc4vZ8bjZVZ/E8BM+oHyNil5+um8Bqxc4hxCWTN0CO9cRjT5VBf/S+WUZCud6DZzzEsF/BvMLO/EZKPhANSZsjSnputMGird6FyiScU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eckelmann.de; spf=pass smtp.mailfrom=eckelmann.de; dkim=pass (1024-bit key) header.d=eckelmann.de header.i=@eckelmann.de header.b=WkMyxcAW; arc=fail smtp.client-ip=40.107.135.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eckelmann.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eckelmann.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eckelmann.de header.i=@eckelmann.de header.b="WkMyxcAW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBOvGKYhGurNnbDck2X9v6ZrkmgCS90H1/QjRd7lLqPWVOXVZKSv3sfatqjo/olEBgWi9u89fX78aMTmh+hAeUBh/hdGbCqBRPLu74GEoDuRWo/eIn2qM5/+ZeWbDCpsIx8bYTIfp5xLspTtXJDMVW9+tOwxhuICHYNcfN0DKf6gUlGCXSr80VRG5epvYO6oelEKaQnBqGc7+ecXPIj//WVHlZ3V8tRPslbnHJdeUWBDG/oNQbV4dKaiquTg+xT17USdQEoXwPhAdNU1/KUMqfcvy99GR+p0aI4X1uad2UzUT2Gg3jmtCSzrK1acJvdQ7F4az+HHduqtzffKtF7ntw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OnKYXKYSUSjfTG8joZ/VnXFrfJr5mr4A7QPBCKwS+Yk=;
 b=W1bPUCRws5Vgic9gwAPE0aRii3R/Nwc6USuRE0mZ0zLQsm249lbPIPt8qcfEEDxeHwIGLZu3DmWNoCEh1tbZeqIV+kag4pemq999pEkOcj0+R/AKmQNjKDtwvrwf3o3rllerYmFa9aBKu8PLTGCwookx72H5VYk+gfA1G+9C64qwbLDiUxW2Ux7LlTdEJpPFZPN1GhSd5EtfQbRUlZFnJFFRnFbLK5WnkPOKaJMhuEn4gcENd49K7nUo8CB+zAHibUhZ71Y8grnEfteQu9CUJRuBbyo+H54eOjf+wZ18IsuOL7rbaIlBLPLPhmRqFWHk80hChrHUmMaIqeUWzB95Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eckelmann.de; dmarc=pass action=none header.from=eckelmann.de;
 dkim=pass header.d=eckelmann.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eckelmann.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OnKYXKYSUSjfTG8joZ/VnXFrfJr5mr4A7QPBCKwS+Yk=;
 b=WkMyxcAWO5n8Z0pXys1/t17cwdjzBNcKULh0IGol+kxG3KpCBPRydOeVWckHWTrn3mu3sOjq/DEEEVip1C+W5JDEkrIAtIKYlCGUQQ4yv4+uDsNm23A0ZuG3ru6ACPs6ToIqyEKESFT1uH2oRNTvruwoRcmfQgKiTLwc5z8aCz0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eckelmann.de;
Received: from FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:da::13)
 by FR2P281MB1544.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:91::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.16; Tue, 28 May
 2024 04:52:44 +0000
Received: from FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
 ([fe80::3927:fe99:bb4:1aa7]) by FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
 ([fe80::3927:fe99:bb4:1aa7%6]) with mapi id 15.20.7633.001; Tue, 28 May 2024
 04:52:44 +0000
Date: Tue, 28 May 2024 06:52:43 +0200
From: Thorsten Scherer <T.Scherer@eckelmann.de>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	mark.rutland@arm.com, Florian Fainelli <florian.fainelli@broadcom.com>, 
	rostedt@goodmis.org, Justin Chen <justin.chen@broadcom.com>, 
	Doug Berger <doug.berger@broadcom.com>, mhiramat@kernel.org, kernel@pengutronix.de, ardb@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-trace-kernel@vger.kernel.org
Subject: Re: ARM Ftrace Function Graph Fails With UNWINDER_FRAME_POINTER
Message-ID: <ox2tlnjbv4sapcmrhdtd522hs6w4pdyhk5y7237eeq5gmgp6sq@itslmlvhvpp2>
References: <d870c149-4363-43de-b0ea-7125dec5608e@broadcom.com>
 <z42qu35nuybho36bwjdoatqp3skwm7w2l4apd75ubzaezyvxef@f6yrdlgltlaf>
 <ZlQ8oDh/Kgkm1+WE@shell.armlinux.org.uk>
 <czbbd3mvqanerbcqgycy3bnvmfnbu5fhyzfujk2ijo2vnngnkn@6ldafursohkn>
 <ZlSB5eEsxlKZfjDv@shell.armlinux.org.uk>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZlSB5eEsxlKZfjDv@shell.armlinux.org.uk>
X-ClientProxiedBy: FR0P281CA0215.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::19) To FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:da::13)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FR4P281MB3510:EE_|FR2P281MB1544:EE_
X-MS-Office365-Filtering-Correlation-Id: 84458f07-34ab-47e8-3a86-08dc7ed2032d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|7416005|376005;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?hr2kUQPfcQBOAqyyPWwD+obB29vY5BQ1kiR8n0DQn6ytRuBNkL/IYrxFZf?=
 =?iso-8859-1?Q?lAqpvRk+p+Xwep08LgeBuCSERcgdfFvBgvyxpFJewrr1EI2Z9LzWk3nEKa?=
 =?iso-8859-1?Q?wJheZ7MtlI600JdQ1rjKicRpFRRRxMZJ39FbeN+90OvAGNP+FSx/cxL5vj?=
 =?iso-8859-1?Q?6C8cmS7ywRwpxK12ROlTSz09pfvyqmiB2WABcMx4EdlBrONgikgoNnLp2E?=
 =?iso-8859-1?Q?1uxE3dBxUFdyJH90cCbRVCefpex+14UKFCt/c6Z3nhhJKxsQZEYx9k7jLp?=
 =?iso-8859-1?Q?zFl40blNzmQLRDGiqOX5ThdaHSYKuB+gw/ESSfLEsI5wSyMiuMGq/ocAjX?=
 =?iso-8859-1?Q?j12a/osduRvgX6kCTk+5sCggtDZ0Qn95Aie6nkpbL6XYiZox5HOsHCBcQS?=
 =?iso-8859-1?Q?BIb3Kl4q+Ld+kB+3G5EiPBc/HIYu/DtbSLAN1gjXzzX10d7LpYATQfkz93?=
 =?iso-8859-1?Q?nqx9Y6GWA55RPoyKRlVV3e4sxBNJbonAI7x8X52ryUe0/VgbXDaZSSQu5Z?=
 =?iso-8859-1?Q?k8BKDkiVgaaDoxrmLRMApX+ZtEOGgf6LgRNxkNk1sn+3rjOI96gFqG4/0y?=
 =?iso-8859-1?Q?EEH7EI1S5wK1Z5vBWwG5wL7k/SAQvMe7TNIyGnoFh0Fm4GkZXQDWnFZ3I0?=
 =?iso-8859-1?Q?Hxne0Pjdw7R3FyfVIjsUiyCnL/SRDrMFLzP5Ce9RDJsipB/sXjkrDaPYGA?=
 =?iso-8859-1?Q?IQoECfZ9y0Co6HH2I+hVienrYQof9A44RqgL4thhAV/MU57TYN4jpx8B46?=
 =?iso-8859-1?Q?aQUI8qT/LxU3kBcUAp12jQ76trDoudYC/p1rsndIMKuTkoNDY4LfWpFX9P?=
 =?iso-8859-1?Q?7uNcpu1PkB646c4X/6ZQQR56v+bSwf5OAw74RE5sNMq3w2Ex/3B3+M9jeF?=
 =?iso-8859-1?Q?eEBV2A06iL28D89ViN2DcQIEw02PL7synB3b+X9gIz48wi4SDzvxtQmU2Y?=
 =?iso-8859-1?Q?OBbyxYKyHLXAAOoVNprqlDbA6ihc86OAC03mwPtsuRQNP9XVaHLJeG6H1g?=
 =?iso-8859-1?Q?wnAQitBgHIBqV3rFAaXnlnASm55VrsyF+S7E2qs5FUqgC0LEfjjGDIwCYT?=
 =?iso-8859-1?Q?epvJr8RaEBHBm3sKTpeI7BLkbZPUSN3c8xe4vVdhduwh5viR/QmvE90OT/?=
 =?iso-8859-1?Q?L70wZF0kaigtnfiRpQgN86+9eRoqj/R0MK5VOXat7ZWigWDkzQwXCYIhOF?=
 =?iso-8859-1?Q?WMb+xv0hn/y24PFGHTBSa0TEGXv3LwGqTMRx0tDjAUqZwwikkK8k04edDy?=
 =?iso-8859-1?Q?/8Gvh2zl06FItRexiYoiRecUU7JZYtKb8fXvQfCFQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?+aBqTvZggyQVf54lhTSkbby3B6J5TIG6u8/oK4/MHTqWDngl9rCKR3reZK?=
 =?iso-8859-1?Q?Riko9dlaEHVoq18jN7Agy46AI2DImSWgFOEEdyHFbYCu4yhDdSRK4iOVGS?=
 =?iso-8859-1?Q?vdviIYbtFGHllqWyy5Hx3VeRXTSFiME3r8nC7EeGJ5CJVy1F7kTQx9mRue?=
 =?iso-8859-1?Q?IP0kjM05jLz3doFMQ1VhwB2OgTF53UZNOmDheCMx9QZRVJ7iPvRZqlhLnY?=
 =?iso-8859-1?Q?w8aDV+09JgUR52AIdkCiqcyBTP5ndvubXzYKrqNUTNapgkk6FFpgdCON8l?=
 =?iso-8859-1?Q?vo2d8ZiZ1WXg9uFwZZs7KkrQy/4wA1WoY3uSLEre+YwLG0TeNIlqlaYt9H?=
 =?iso-8859-1?Q?dMGRsw5Ns+/10Xmka9Uj1FMi3GHPmorYsavvsrTsAyqIK9T0Uh39ziYHMj?=
 =?iso-8859-1?Q?HxN7t7CVtbVCZx0kK8zyz93DtK1MIC0BUTWwrM69rzt/vP1nmMkS7Nv/Nq?=
 =?iso-8859-1?Q?BhBcZt3PJoPfcVHQ8vUrfmzvW5zBVlNwyYLHQAB5bggobBe3QcqrCLli97?=
 =?iso-8859-1?Q?W2LbTkc7M9hrRvs/As78Ho100VGVH4nxDDpFqOQRJsoT4Avd0tRarvjfGb?=
 =?iso-8859-1?Q?4tuMukEqt/W/MTnbbdE43g6CSh0iSLtwKBiMBernlzxgHlL6ut6g2FfvMb?=
 =?iso-8859-1?Q?3ItGRqea2yYhfHaZz8lMAibggXGJKe+At4kjMBY8PFgvotG0XoGgPWdCKg?=
 =?iso-8859-1?Q?mA8Ha0VwbB+nxSyGxJ8nTqxz7hpRrEF3MTGo8p5b7t1OmGbuN3ZRbRkzo8?=
 =?iso-8859-1?Q?ov32GUuyxzr5g8/qwp1mOwGgfS96vBqOXr0XybuQmGmWd92TTqIXhR7Lz5?=
 =?iso-8859-1?Q?OnZkk8yfia2UPJz+RcDxK+e+e2a7VvrwZ/m69SWo8RFBslENIw/8s3AVtF?=
 =?iso-8859-1?Q?SVAIKGe1AJMDvNoLObJPUnKQcGcf0RpG1lOYBU55q1QKefLVw0oQi9zjPk?=
 =?iso-8859-1?Q?sVpsV3XOROGmWOt+uiqnINBm6IbNpdkdEehwdQeNVi/nBy+Z1MSSMmf2/A?=
 =?iso-8859-1?Q?XUqftiy4+PGIXswL+juQXYsdsnlVeQh880En+gT0zcne12evI4KznW8G6O?=
 =?iso-8859-1?Q?QKuKjMbz+rJtclrct5bnIjsX49s8QgAr0CSfCklFyhFitH9yGTX6/i67k3?=
 =?iso-8859-1?Q?tV8HqlhJ9in14MU+bXNm0tBRMvZ52Fy/qInXj4oCUVEyoifQSezn1y5Bdu?=
 =?iso-8859-1?Q?kSJH8mRvRSn5dwWNdIMD4RG//o9HDcwLs7eh83LixmHQf/ZyvDlTnSUYFw?=
 =?iso-8859-1?Q?wp0TYZTuJCOM9wlTz59AB2gytaRnyuzsKC0VmAsEIzDo6ha/001hCVe/Px?=
 =?iso-8859-1?Q?LTCPj1WdIAJNPE8fb7PsYnn7saUDb0XkWmWR6mc61lZ8xOTn/o5JvjP5Ga?=
 =?iso-8859-1?Q?6nKzCo6i1bzS4JjphbJPLuWPBiMb3+JQnJdW7PHMflpNLJl4M25HMtimLb?=
 =?iso-8859-1?Q?qCj5M3zKmA8kmGdQ1472dRUSkUB2cMh5zBJcHv71JU4l1AqUkjYEkysOTQ?=
 =?iso-8859-1?Q?wLCpD364EoEgyAFuMbVJCN41hgTsqJP0+1ofuQBIXWU8uUv+Q0pqmH6RDg?=
 =?iso-8859-1?Q?G68dOS6MFbFzSaqRG1ncEndBsDCa13gEXeYXymp97kGKYg2VSqV9IhijR9?=
 =?iso-8859-1?Q?TpyHod6I7Ea+NwlnocmqfIoP2Ud94N19vx?=
X-OriginatorOrg: eckelmann.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 84458f07-34ab-47e8-3a86-08dc7ed2032d
X-MS-Exchange-CrossTenant-AuthSource: FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 04:52:44.2596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 62e24f58-823c-4d73-8ff2-db0a5f20156c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WcWcE1Rc6HTSvGkyTbCUSPdg/gRdcHTLhjEGMDQeu0wiOf+Rbv1JpzebstxrsNlzBOsMB/Z9glzZUuC1lcDFpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB1544

Hello,

On Mon, May 27, 2024 at 01:51:49PM +0100, Russell King (Oracle) wrote:
> On Mon, May 27, 2024 at 02:28:59PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Mon, May 27, 2024 at 08:56:16AM +0100, Russell King (Oracle) wrote:
> > > On Mon, May 27, 2024 at 09:43:41AM +0200, Thorsten Scherer wrote:
> > > > Hello,
> > > >=20
> > > > in the context of a panic on an i.MX25 based v6.9 kernel [1] Uwe po=
inted me to
> > > > this thread.  With the proposed code change applied the procedure
> > > >=20
> > > >     # set to some known good (randomly guessed) filter function and=
 enable function_graph
> > > >     echo mtdblock_open > set_ftrace_filter
> > > >     echo function_graph > current_tracer
> > > >=20
> > > >     # walk available filter funcs
> > > >     cat available_filter_functions | while read f; do echo $f | tee=
 -a set_ftrace_filter; sleep 1; done
> > > >=20
> > > > produces the following output
> > > >=20
> > > > [  159.832173] Insufficient stack space to handle exception!
> > > > [  159.832241] Task stack:     [0xc8e44000..0xc8e46000]
> > > > [  159.842701] IRQ stack:      [0xc8800000..0xc8802000]
> > > > [  159.847712] Overflow stack: [0xc1934000..0xc1935000]
> > > > [  159.852726] Internal error: Oops - BUG: 0 [#1] PREEMPT ARM
> > > > [  159.858273] Modules linked in: capture_events_imxgpt ti_ads7950 =
industrialio_triggered_buffer kfifo_buf capture_events_irq capture_events i=
io_trig_hrtimer industrialio_sw_trigger industrialio_configfs dm_mod
> > > > [  159.876948] CPU: 0 PID: 199 Comm: sh Not tainted 6.9.0 #3
> > > > [  159.882412] Hardware name: Freescale i.MX25 (Device Tree Support=
)
> > > > [  159.888547] PC is at prepare_ftrace_return+0x4/0x7c
> > > > [  159.893520] LR is at ftrace_graph_caller+0x1c/0x28
> > > > [  159.898376] pc : [<c010dd44>]    lr : [<c010d988>]    psr: 60000=
093
> > > > [  159.904690] sp : c8e44018  ip : c8e44018  fp : c8e4403c
> > > > [  159.909959] r10: c0c09e78  r9 : c35e9bc0  r8 : c010d9bc
> > > > [  159.915227] r7 : 00000001  r6 : 00000004  r5 : c8e44064  r4 : c8=
e440ac
> > > > [  159.921800] r3 : c8e44030  r2 : c8e4403c  r1 : c010eb9c  r0 : c8=
e44038
> > > > [  159.928376] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM=
  Segment none
> > > > [  159.935652] Control: 0005317f  Table: 83074000  DAC: 00000051
> > > > [  159.941436] Register r0 information: 2-page vmalloc region start=
ing at 0xc8e44000 allocated at kernel_clone+0xa8/0x408
> > > > [  159.952253] Register r1 information: non-slab/vmalloc memory
> > > > [  159.957988] Register r2 information: 2-page vmalloc region start=
ing at 0xc8e44000 allocated at kernel_clone+0xa8/0x408
> > > > [  159.968791] Register r3 information: 2-page vmalloc region start=
ing at 0xc8e44000 allocated at kernel_clone+0xa8/0x408
> > > > [  159.979592] Register r4 information: 2-page vmalloc region start=
ing at 0xc8e44000 allocated at kernel_clone+0xa8/0x408
> > > > [  159.990391] Register r5 information: 2-page vmalloc region start=
ing at 0xc8e44000 allocated at kernel_clone+0xa8/0x408
> > > > [  160.001187] Register r6 information: non-paged memory
> > > > [  160.006303] Register r7 information: non-paged memory
> > > > [  160.011415] Register r8 information: non-slab/vmalloc memory
> > > > [  160.017139] Register r9 information: slab kmalloc-32 start c35e9=
bc0 pointer offset 0 size 32
> > > > [  160.025718] Register r10 information: non-slab/vmalloc memory
> > > > [  160.031530] Register r11 information: 2-page vmalloc region star=
ting at 0xc8e44000 allocated at kernel_clone+0xa8/0x408
> > > > [  160.042422] Register r12 information: 2-page vmalloc region star=
ting at 0xc8e44000 allocated at kernel_clone+0xa8/0x408
> > > > [  160.053315] Process sh (pid: 199, stack limit =3D 0x68fc3abb)
> > > > [  160.058955] Stack: (0xc8e44018 to 0xc8e46000)
> > >=20
> > > No backtrace? No Code: line? I'm guessing there was an attempt to ftr=
ace
> > > a function involving the ftrace tracing infrastructure, which is why =
8KB
> > > of stack has been gobbled up. It could be
> > > copy_from_kernel_nofault_allowed() but it would be useful to have at
> > > least some extract of the backtrace showing the recursive cycle to
> > > confirm, otherwise there is nothing in your report to confirm. As I'm
> > > not a ftrace user myself, this isn't something I'd test for, so havin=
g
> > > a full report would be useful.
> >=20
> > Is not having a backtrace related to ftrace_return_address() returning
> > NULL, as Arnd pointed out in
> > https://lore.kernel.org/linux-arm-kernel/36cd10de-c51c-40ff-90e8-714954=
06019d@app.fastmail.com/
> > ?
>=20
> Unlikely - the stack and code lines are also missing. I think the
> submitter truncated the oops which is highly likely given that it
> would've dumped all 8kB of the stack in hex, and the trace and
> code lines would be after that.

sorry for causing additional friction by my imprecise description.
Indeed, this was the whole oops before the machine restarted.  I double
checked that.

I see that this [1] thread contains a patch.  Will test it on my machine.
> --=20
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

Best regards
Thorsten

[1] https://lore.kernel.org/all/20240527161236.313448-2-ardb+git@google.com=
/
