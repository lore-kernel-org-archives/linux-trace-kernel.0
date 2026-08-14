Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013036.outbound.protection.outlook.com [52.101.83.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257F335C684;
	Fri, 14 Aug 2026 16:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786724150; cv=fail; b=EUk3aWb90BOBb577sdqQEjF9rflUbVVH/8Aq3yfOcAHX4WwBt48YS3qQQEBQMrNKM4njBtovR8nukAAO+A4aKCeMhM+DgxIDCgsEgIGbmj4BkvG21o4qOjbch6Y6ne7VOe2aY44RdtpKJW11XSwtxrDOW//OPSJCEIXVuw5L78s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786724150; c=relaxed/simple;
	bh=mE8XgGqssSBC1pmb5jnWtmQeT6S+6DSReM6YsQTnDZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cEQ3/TVeMFxaYmcR6l2CYTbt2i1s4DGWNSwV6f6cwoXs/Z6cklYp0KDh2MZWJkvyPEPj8W6SwR5w1tGCa67zGMvi+Ht6RdGmn/2BkR7CYdXC9drW7UYos/Q7AzlXcoozqVDJsYOS0nXqLfUEOb3gNj+RAV3pyNIA3iilI0wM24o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Tpv6KW56; arc=fail smtp.client-ip=52.101.83.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Tpv6KW56"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dMwf73WRT2o6vvMyS57Cn5DD1RsV7G97PIMWi6ofHv5nazAr59Vcqzxr7r0tFky38v+14gdk6qbSE0RxNSQu24VFq30EYE7CT+eEj+x/qacKf8mDpu2PmEwhg7BQHgKfKYPl8K6Sjnb/V+bXTJ1q/ulPSF8u51meIa91dVZgLqfvyMFxdAW2JTeD/tIXxnxGfzlPt83qytoT8h61hSTBifkmbMUtYRpWXsnvAAZsmRMy17i3UwqL9s3N1DNnsBJgXamQl+K9unj9eBL4AQj4GPOBJd4YbD4rdhpgi7Vx3/N0pxfE8t7JnYF+0VdhB7gV/4erD8kbjdP4/4XckfCLWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XI9+EGkuGODUHnoPhTZyUJtRwVkpUWiqN+luTTD5pBY=;
 b=Kmznjg5WciNQfJ6gg4Ef5iEc3Lq2wt3M4JkqMedEHaXAa+VNUYkg0+S8aJNqSCxG24UROBZpLZJU/e4nchpFQc4F8iN+FCleWjL1Gcdi5ls+QGgPzS4tIa3+jh92JDACd+yB8qE8oYxYJRFHbjLhrZSw3eNGWnBy4DgL5wLNKqbWeLmk+C7fO9E/8Y6GuMbWuVuAr/7sJzXKmnbWNk451q27IVeUbXn7Phr84IDAPgUQawwdftZp+tXcP3cIqk8lP0yYGrcafCzYbUqwasabnULd7ez5cFfDZkVcn1DOm7Mm4E/qp3eksNxz28hAjo9TgZM7UQFOt39s2VWBlg3MZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XI9+EGkuGODUHnoPhTZyUJtRwVkpUWiqN+luTTD5pBY=;
 b=Tpv6KW56mf8SQazu3qrswyx8wJ5teGEyR+GvbmKcC8WidgGa9A6/VRccIGbmEQatLfzJRwTkB4B6VVFduuWXWallE23Ds4wAxnGmRYFgri9c6aE7xwxAvHQrhsHX8JJQfKA0MNfpyvI81L2EXgl2NUNtQGvesSQyBELl/+8D1FXc2dwOcRQ1AOHkbK3bfuRj/92gNbZNEDIcy1DMsxHXJyCQ9ErPb1JZt0f+tFH+ZjnlaafND79Cf/EuRexZ0uWp2X6+0glbT70qW5rnXt9n3GE35wyYeYZt2TwAXjkS0O+bznQMukCi215w+C3WK2s3wwD2Y0HzAz/mTJmKizXojw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com (2603:10a6:10:623::11)
 by DU2PR04MB8808.eurprd04.prod.outlook.com (2603:10a6:10:2e3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 16:15:38 +0000
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de]) by DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de%5]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 16:15:38 +0000
Date: Fri, 14 Aug 2026 11:15:24 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	=?iso-8859-1?Q?Am=E9lie?= Delaunay <amelie.delaunay@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Ludovic Desroches <ludovic.desroches@microchip.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Keguang Zhang <keguang.zhang@gmail.com>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Kelvin Cao <kelvin.cao@microchip.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-trace-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-actions@lists.infradead.org, linux-sunxi@lists.linux.dev,
	imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 1/2] dmaengine: use dma_chan_name() helper to get
 per-channel device name
Message-ID: <an8_HLw4qZX-tjlj@SMW015318>
References: <20260812-dma-chan_dev-rename-v1-0-a67131f7d5c2@nxp.com>
 <20260812-dma-chan_dev-rename-v1-1-a67131f7d5c2@nxp.com>
 <an7L5D_9aGMkLiEw@ashevche-desk.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <an7L5D_9aGMkLiEw@ashevche-desk.local>
X-ClientProxiedBy: SA1PR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::20) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4PR04MB11791:EE_|DU2PR04MB8808:EE_
X-MS-Office365-Filtering-Correlation-Id: ebf17e81-b88a-477f-fec7-08defa1f46cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|19092799006|56012099006|10067099003|4143699003|11063799006|18002099003|22082099003|41080700001;
X-Microsoft-Antispam-Message-Info:
	zURzL9v6A9f6KIUoq5g1a4q1ZmEzyQFtRyCsz8JE7hKxZ5Xr/aibw2+cnq6MautbTEXCWkfrW0yfLIo7QaM+HB4IeQeosaCm1JIaS5FmH6vZr+5cdWm/Tf7em5IyvTF7t6NTpvrwr0Oyq0LcLBuP3D1gWoW3kMgYBL5S/KPegtSyoUFnWMpK96/wULINSOxhOJ/vaEv55LoNqQ+/UwEijhTem6ReqXF7bT/2+70lt3FzFFVsKVNgFCrJKXOrqmFASy90Hkk9r9HRIWgg7fkMqsXWxAnOKmkoe6l2QGjmJd9K4+35Nol+XzA8egbb6E6gthO8vTTE9zlP1NCzlsGJD5nTEXOVLakMlir3vnGB+IcMws37XeXH8mXyG4KYOJ8LFfJlwhmAN6LWhlbab08sVkaGgwtQMu9Wt92dYGKYdHo/F3THhruWYYI8Ou/ZobxhVeZpl8qJWJwzy8OeMJKZM3zFOKws7ciwOX3LkVGB1xEZ+5kCvBDaGG1luReyBJS1MloyaZ5itbyzlYI0++qUtw8ZrwBtnshD50k/EoKMdYgeQeBUTW0PoGEC+i8lKzw/8wns8DW7fnPiOZe4U046fd1gChRXfRP22fZHUUSvEZxBw0bugHvswRneBJOjYrUwq/6D4jfm00D6wgAbjQ93Mtd44yTc/K73JcPfSUOwDmDLE42a2nQEB6NebSvQRO87+HI8jSKTq95jdNfi0QL0/A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4PR04MB11791.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(19092799006)(56012099006)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8JV9LihFf7dDvzzMRhpOTraxqIZd6jsFiEncjaJPBN+PqTho9Ovdnw3RjtJk?=
 =?us-ascii?Q?5w8HLZZeOLGEQZn+2p/cgF6osl36VLtq0SOXcS4Lv6RJ6zZ/Qs/oGkZcdK+H?=
 =?us-ascii?Q?PkrxOzpehWrWex2K2Ib2YcPVDo58rGaGCMuvy/GCjU160Fi7oTjRzbrfxHpR?=
 =?us-ascii?Q?TZ+f9kUgqgm2Bztw98HJeWjEiFtT3YlGQUJ1Bapk7/V7yYbIqFqL3ef76/kV?=
 =?us-ascii?Q?XBOCKsD4+X9+zXuLcAafxfMhvQWyLv7Qvxfyl8JLNjIjQmUszYef21kYb5wp?=
 =?us-ascii?Q?IKmPxxWek+fQyvYuap7NjWLCutxvKLY+ipSCV96oM5aHMdIIh7cDmS6xktMU?=
 =?us-ascii?Q?3y55sSko6Ex+1stCoB2QcBUQFXkVUjjkwn4jXVZ49jqsRq1IA/ECyzr5ej+I?=
 =?us-ascii?Q?CYHbn4EMGGf891MiFRnSkcp4A2GPUk2AjeAVOTwb06R8ida9fEcG19UaeXDl?=
 =?us-ascii?Q?adrFbQwA3BUSLHb/c7gqPlOGOrugpUBXc2+bwjn1AtyIqJN8Ne4kAgMNy1c5?=
 =?us-ascii?Q?WSu8EnjfPNOI/CmeGFub7CQ46FzrFdhRWl72Gv5abn0DttSAdeg98bMHgT2I?=
 =?us-ascii?Q?RLXROh/O0b8w6h0ALyeGc2s/imAGjhhK2IN9/kQabmgOtxk7UvXJOhio+pwc?=
 =?us-ascii?Q?wg2JATpT3jRuiXYYW894GRxNy1QeJtM0CG9do1ut4fAj4YEApqtHiB5SfptO?=
 =?us-ascii?Q?wD7rwOUBIv7OyabyTChrljrEw+Vrc4oMnvaujPNXzMeP8/VizUvrh7ekyLfc?=
 =?us-ascii?Q?+nbsPd7oKqV3hsgjjA/BEU8wwA0ezTA85IkQB4PS4T8pqkxhu3h3knKknnak?=
 =?us-ascii?Q?xw3Kj/YrXTfnasAEdWQbHeVgYN88My4H489pRLQoFovhp2J1vQ6aRRLcrmfW?=
 =?us-ascii?Q?ZVAuzhe5VUG0V5YTGfWKRD5r+xowhr0Akzc88XNHII4w9B7MKFdteZBxSqPb?=
 =?us-ascii?Q?w8+5cy5v7q9tCtT+rblgVCEUOaO0Qsw7BWxVMmpNK9awadrXR4J1tf7RxTB2?=
 =?us-ascii?Q?brrNHeSzTbsLx0VJgypzj+IIahXhNGoxgs6JOjt86nViPfqHG9GyEIUDMTc5?=
 =?us-ascii?Q?YWpjdMrZdG0fh2ZRiKBgwKmpLBIOzoWXjED4V/c1Bo6bZBFsYZfwuH88QZWz?=
 =?us-ascii?Q?XD+rEo3TkaXvIzGQeBOMrk2+M9hYrVVj89hPBPFf787j8e7oR2Q2zxChQVEC?=
 =?us-ascii?Q?SmHUdEQLCfY43idHMd6lctTUZMMslVKQogNvVJG6gf4MnF0TdGmi6UCMna4K?=
 =?us-ascii?Q?fiRkietoL9E0wrRed+H6rlhKEM6qy8dGgODdzUzXgtE9ht3qpsUXarB37fFL?=
 =?us-ascii?Q?6ALIBddzW6IG8iA/aG7F6yR6ZPp0eXco21zmIwHi8LcbeMdCNsz2JxhJRHhX?=
 =?us-ascii?Q?AqQbyt+Ek7pJbqXeq10Bd0cxaTQ2v272F0b3tSaHHoJI3zSJE3R0anqc/ME4?=
 =?us-ascii?Q?ZKMK0WRJR3kb4Fd+U9bI396aj350Rk0HDt9/1/UZcMLN/alIfibFrW3gaYkL?=
 =?us-ascii?Q?bHctrfmumvlz9vGCyE5mjMbjq+IU+OvNrPFXDv9updsliQUahAelv6qsdyK7?=
 =?us-ascii?Q?P32nwkGvJN3Wj2bOp7Tt4MvvtUl+++B9pQjJz3u1wFDIazNJ0NM0ENJMqzeX?=
 =?us-ascii?Q?yS0cLy+IbxLVY6rS592Nz4WptD8PSNjHkrWfBgwgth2fYuVxgzXg/6DdlfIi?=
 =?us-ascii?Q?fbXrGeIKsVwilPKm7n4gpRnM8f6hOH2tU2TnMQrJewBFpQQJhUgKwm8fczZZ?=
 =?us-ascii?Q?YgvlTzdjhTu+/YLO5F1OQVFbClw6S831T9Xk6dGaP35Vuc0O2q2j?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf17e81-b88a-477f-fec7-08defa1f46cc
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 16:15:38.0159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CVtX7IctrHaTzlLiVYjqvwy5KRqaGlLp5Fi0qzjYbXlttoLmIvkYYWcaAOezIA+VrwK1dBkGqnamzWqj9p9+2FYvdWA7LrsJ7gstbGrcLXcMtPwXOJU+UpSAz2VVoq5a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8808

On Fri, Aug 14, 2026 at 11:03:48AM +0300, Andy Shevchenko wrote:
> On Wed, Aug 12, 2026 at 05:24:08PM -0400, Frank.Li@oss.nxp.com wrote:
>
> > Use the existing dma_chan_name() helper to obtain the per-channel device
> > name instead of open-coding: dev_name(chan->dev->device) /
> > dev_name(chan2dev())
> >
> > Simplify the code and improve consistency.
> >
> > No functional change intended.
>
> ...
>
> >  		ret = devm_request_irq(dev, lchan->irq, loongson2_cmc_dma_chan_irq, IRQF_SHARED,
> > -				       dev_name(chan2dev(lchan)), lchan);
> > +				       dma_chan_name(&lchan->vchan.chan), lchan);
>
> Depending on the amount of users (and I expect there is a number), I would
> expect specific API for virt-dma case.

Make sense, I consider it before. Let's wait for while for patch2's comments

Frank
>
> >  		if (ret)
> >  			return ret;
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
