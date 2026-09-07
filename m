Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013049.outbound.protection.outlook.com [52.101.83.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED88F44238D;
	Mon,  7 Sep 2026 08:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788771332; cv=fail; b=PhNGbGgnZJGqFSoTXfXgEO5Uj46O8WdA39iEtAxMoahR5bepxdppqxDRae5f9ux7imFKQSyeLJalewom4Np/686thNo6PYHFcva0ouGOKJumdJXcP2zLAa6hiy2+WFDqW1sv9qKO+L3FRz006kuZjPXancFHHLjTSmP+IFPKERQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788771332; c=relaxed/simple;
	bh=Av1oNeFHCfNSrYrimkmBEFPexx4feCvlvuUyQhGgJ2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Vfx0GhOoZsZNHmLuCySLLH3pZPg9X3BIZgBIDVVqZOzc8lKy3GQt0ESRJHrkq7jURVHmPiNgA6j3lxJsXzxQIawzzS6uSimxsAkDld3hnMReS2VlKMBCgHCt64hggSXh/GOqebSkVA+B7HZub7KzOH1Gxcwkes8qAifx/R2cjm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=IZ96vfHE; arc=fail smtp.client-ip=52.101.83.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="IZ96vfHE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tbh1eVCKV/Slv6dy8impDH7qVae5pscwzAgsCQ0yjyVClN6gutGD4FcJpj3CtPW3n/s+i9TsNPYWxCN0RBkIsBpgRLU5FX2IhEw13MstkDxZBwEylV7z2AlDLl15rM30/4Nj7dS+010A+JE0qmYrlezLqEdg5w0NhSF/VNqqQ+3RuWQMH37KChDVJwA7aE9a9dRkETZHR2ieTsXCJMPkJGKCFZnna+GPFT0mmStKH4AEBo+7xkxIvHJ6YCQGkJ0Mi2bPoHKN5ozuZqSFLcSb1WdCPR7J4q6DiRuquMyeSjY7gzpTIzhj4uZNqi/WJguw4Oh2NqC10lk4ECp3TnIdtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lAVD/c/csLNSVc0ViI6jYfuyNHlDCUTyCJ4zaRXMRZ8=;
 b=Ba77cx0CJTfi/CK6hwWaf9TMwzABjLGKMOnkwahutvaPTvG5D+UX4z7dR912k3BZKbv8ZEeYEadC5r1+CgbyuSKJE4i2QudAVivppYnZ+NkgJfY3hsOpKoWHgibBCWW+y8lojUNQlwxvItdZkBBaGHuL3cq/J3LG2DmqL+EVBK3n+aQby8wT7SJxRpKjSbqFmTRncPHl6bVEHVKwWSUUIMh38cD1yEXHZ612wrqRFLQlvwL/4ScK2YhI3bfVxcCrUejKx1IEoXccwkQH3SU+e778mw0UeOfuzP1UusrXy1EA+9hK4R+iyFYLNu4Cm+4UbujKa6uOBNi3i2mVGfZL6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=oss.nxp.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAVD/c/csLNSVc0ViI6jYfuyNHlDCUTyCJ4zaRXMRZ8=;
 b=IZ96vfHEDd0DyBKGgkuhRfFmW5Cu6W/8jMuVkXFQJFQaXd5UUbWzv1w6tMIrVpvo061z8B00LpNEIWieliSrW/+ZC4Q87vuiKD0pUFCNSQUQB8j1R4JHTrrUnI1gtyJgzxm3I5mEuFfiiNroOsNbQeptIW4ehTJRPE3XFlSwuVapxPZ2vXB70V/Lyf9Ic8dF5wDr4hJBmCq5lNckR9zUAIlUsX3qMM2TNqAU3V+HNSzaGviPVy949tN295pD7tHpY/bqeXhqU8JMTjq1o7rbFOopmeHZnX0lMt1pEo7hSXd6PvJ2l6zbrNFZY0/Ft8Lejo+fjniaYswba2tzOEoppA==
Received: from ZR2P278CA0046.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:53::19)
 by AMDPR10MB992269.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:751::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 08:55:21 +0000
Received: from ZR1PEPF0000E6BB.eurprd07.prod.outlook.com
 (2603:10a6:910:53:cafe::25) by ZR2P278CA0046.outlook.office365.com
 (2603:10a6:910:53::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Mon, 7
 Sep 2026 08:55:21 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 ZR1PEPF0000E6BB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 08:55:20 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 7 Sep
 2026 11:01:07 +0200
Received: from [10.48.87.20] (10.48.87.20) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 7 Sep
 2026 10:55:05 +0200
Message-ID: <c79f42cf-43c4-4b5a-a6da-217052d40284@foss.st.com>
Date: Mon, 7 Sep 2026 10:55:04 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] dmaengine: add (dmaengine|vchan)_chan_dev() helper
To: <Frank.Li@oss.nxp.com>, Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung
	<schung@nuvoton.com>, Vinod Koul <vkoul@kernel.org>, Frank Li
	<Frank.Li@kernel.org>, Paul Cercueil <paul@crapouillou.net>, Eugeniy Paltsev
	<Eugeniy.Paltsev@synopsys.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Binbin Zhou <zhoubinbin@loongson.cn>,
	Patrice Chotard <patrice.chotard@foss.st.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Thierry Reding
	<thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, "Ludovic
 Desroches" <ludovic.desroches@microchip.com>, Viresh Kumar
	<vireshk@kernel.org>, Keguang Zhang <keguang.zhang@gmail.com>,
	=?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Manivannan Sadhasivam
	<mani@kernel.org>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang
	<haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, "Chen-Yu
 Tsai" <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, "Samuel
 Holland" <samuel@sholland.org>, Kelvin Cao <kelvin.cao@microchip.com>, "Logan
 Gunthorpe" <logang@deltatee.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Vignesh Raghavendra <vigneshr@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mips@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-trace-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-actions@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
	<imx@lists.linux.dev>, Frank Li <Frank.Li@nxp.com>
References: <20260904-dma-chan_dev-rename-v3-0-685601b0b788@nxp.com>
 <20260904-dma-chan_dev-rename-v3-3-685601b0b788@nxp.com>
Content-Language: en-US
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
In-Reply-To: <20260904-dma-chan_dev-rename-v3-3-685601b0b788@nxp.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR1PEPF0000E6BB:EE_|AMDPR10MB992269:EE_
X-MS-Office365-Filtering-Correlation-Id: c2e8d2f3-0001-489d-d4a2-08df0cbdbf59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|7416014|11063799006|6133799003|56012099006|4143699003|3023799007|10067099003|18002099003|22082099003|921020|41080700001;
X-Microsoft-Antispam-Message-Info:
	uGg2fRDq2B14c5+EgZqt4efLZBUphgW3yHdXcWXFhMFzJcwkdaQsa0/y4mFvt+YJo5zRNb72nH7rNKN0JVq8Uvkw9gL9YrYbHm3L21csVNE+yCuDrxHY7CDF5zRw0mZc55zg/Vho6nQIXHFWyNQRb9NKuY6VBnnuQ4osnmLVLP/FoXfrLkje0lqCmc1x9MUnZg9PFyCtk5A8H/fvMWfrVu0gFOkUyO3nXzrRAqPT+pR64pcLX+iaT8WdMDiyLvK03xfjjmBEpzwnIXHa1dQ5SMLlMxuxMlckJ6tSJpTYqwWN6YSs3zIQoWoFHwSfk9Yv/s8bgIKxJT619SgGBbyspWdWINoKsmN5YlFVJvdUYgIvpA+J4J3gvukRfpgjNdaHYpyr3xnZCgJMUdh7pm8sY2oNs1ru1RHMfd80IjSKe5Xs/MyNtHEUZTvIqrbXJn6hpmp4UFp6rmkjLbJ4P5aPfnas3i7gpyDs91cp1QDspuJkUuoo7aD/lBeS1EEmg1VrQ3eA+iVmRd+1i+mMBe3tTtfa4IEtYJXjdYnYUNQT4aEtE7VYfB1EQNXy13jPCIR/jETIwiPcYBcIaO/d9tfBdaQbsyWouY5aZPmUmRQbCEXv3KbPmY6l/KkF4b0DOBZsDDnjvPyQSOXdHerjIxNR0nJQZ2l9CwtmjFujQU8SbOA/dO2CFNsZ6MUmm/7MiQakCi4t+3IemR2AoKh3s2WCvYLIBOY03JW68MnUd7XGWhioZNrsBnio6MxJ8fjAbhBoow2jtYTnO680P9S3WMEKog==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(7416014)(11063799006)(6133799003)(56012099006)(4143699003)(3023799007)(10067099003)(18002099003)(22082099003)(921020)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Kpo0LAgs6DnY9zXJrcDuLMOreObmvpGRcAq3fViW7kKwjq33uRKf2rcDsaDT4cJl5rj2i7MlNhvmWvkKRy0SNkShNFO2H3nDToAxGwJv9NjzAEQ23MI0ZxLXCpLiIKboU7wLiCwSRCoHhwL+ssKdy+T1YISPlnfNuZHQHZAUcPWRvUXU13zkG2N9V+AxJWYhDparXhPs02CtrmrkCr9c0xWYVKEbvZdzxi/Vogxio3H8BDL391DkipF6i9kwfGYN4cP2tzb0N4S1+XwNWRk8X/8TS2zdbF3vK+mwNSkWK7BVmf9z+bfx4TdLoXxNTXJiOTmuwhAVBcXYplqJjVLq42g7j8HLoyGFgWgBbRpH4EFzfSpb/TvIOOifW3+mYE9MUKBIpTJiDaUq/e6vl15hRHpJv5ugQop/p3L8f6fZD5CxB6I9JyIg+zoHNIyPp2w4
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 08:55:20.8246
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e8d2f3-0001-489d-d4a2-08df0cbdbf59
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	ZR1PEPF0000E6BB.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR10MB992269

Hi Frank,

On 9/4/26 23:49, Frank.Li@oss.nxp.com wrote:
[...]

I don't think removing chan2dev() function from the STM32 DMA drivers is 
an improvement, since the parameter is a `stm32` chan, not a `dma_chan`. 
chan2dev() was meant to expose the channel device behind the `stm32` 
wrapper and keep logging concise.

> diff --git a/drivers/dma/stm32/stm32-dma.c b/drivers/dma/stm32/stm32-dma.c
> index 3e8151e2ad75a..4688cebaf7f7a 100644
> --- a/drivers/dma/stm32/stm32-dma.c
> +++ b/drivers/dma/stm32/stm32-dma.c
> @@ -248,11 +248,6 @@ static struct stm32_dma_desc *to_stm32_dma_desc(struct virt_dma_desc *vdesc)
>   	return container_of(vdesc, struct stm32_dma_desc, vdesc);
>   }
>   
> -static struct device *chan2dev(struct stm32_dma_chan *chan)
> -{
> -	return &chan->vchan.chan.dev->device;
> -}
> -

I would rather keep it as:

static struct device *chan2dev(struct stm32_dma_chan *chan)
{
	return vchan_chan_dev(&chan->vchan);
}

and then drop all further updates.

>   static u32 stm32_dma_read(struct stm32_dma_device *dmadev, u32 reg)
>   {
>   	return readl_relaxed(dmadev->base + reg);
> @@ -274,7 +269,7 @@ static int stm32_dma_get_width(struct stm32_dma_chan *chan,
>   	case DMA_SLAVE_BUSWIDTH_4_BYTES:
>   		return STM32_DMA_WORD;
>   	default:
> -		dev_err(chan2dev(chan), "Dma bus width not supported\n");
> +		dev_err(vchan_chan_dev(&chan->vchan), "Dma bus width not supported\n");
>   		return -EINVAL;
>   	}
>   }
> @@ -374,7 +369,7 @@ static int stm32_dma_get_burst(struct stm32_dma_chan *chan, u32 maxburst)
>   	case 16:
>   		return STM32_DMA_BURST_INCR16;
>   	default:
> -		dev_err(chan2dev(chan), "Dma burst size not supported\n");
> +		dev_err(vchan_chan_dev(&chan->vchan), "Dma burst size not supported\n");
>   		return -EINVAL;
>   	}
>   }
> @@ -487,7 +482,7 @@ static void stm32_dma_stop(struct stm32_dma_chan *chan)
>   	/* Clear interrupt status if it is there */
>   	status = stm32_dma_irq_status(chan);
>   	if (status) {
> -		dev_dbg(chan2dev(chan), "%s(): clearing interrupt: 0x%08x\n",
> +		dev_dbg(vchan_chan_dev(&chan->vchan), "%s(): clearing interrupt: 0x%08x\n",
>   			__func__, status);
>   		stm32_dma_irq_clear(chan, status);
>   	}
> @@ -536,12 +531,12 @@ static void stm32_dma_dump_reg(struct stm32_dma_chan *chan)
>   	u32 sm1ar = stm32_dma_read(dmadev, STM32_DMA_SM1AR(chan->id));
>   	u32 sfcr = stm32_dma_read(dmadev, STM32_DMA_SFCR(chan->id));
>   
> -	dev_dbg(chan2dev(chan), "SCR:   0x%08x\n", scr);
> -	dev_dbg(chan2dev(chan), "NDTR:  0x%08x\n", ndtr);
> -	dev_dbg(chan2dev(chan), "SPAR:  0x%08x\n", spar);
> -	dev_dbg(chan2dev(chan), "SM0AR: 0x%08x\n", sm0ar);
> -	dev_dbg(chan2dev(chan), "SM1AR: 0x%08x\n", sm1ar);
> -	dev_dbg(chan2dev(chan), "SFCR:  0x%08x\n", sfcr);
> +	dev_dbg(vchan_chan_dev(&chan->vchan), "SCR:   0x%08x\n", scr);
> +	dev_dbg(vchan_chan_dev(&chan->vchan), "NDTR:  0x%08x\n", ndtr);
> +	dev_dbg(vchan_chan_dev(&chan->vchan), "SPAR:  0x%08x\n", spar);
> +	dev_dbg(vchan_chan_dev(&chan->vchan), "SM0AR: 0x%08x\n", sm0ar);
> +	dev_dbg(vchan_chan_dev(&chan->vchan), "SM1AR: 0x%08x\n", sm1ar);
> +	dev_dbg(vchan_chan_dev(&chan->vchan), "SFCR:  0x%08x\n", sfcr);
>   }
>   
>   static void stm32_dma_sg_inc(struct stm32_dma_chan *chan)
> @@ -613,7 +608,7 @@ static void stm32_dma_start_transfer(struct stm32_dma_chan *chan)
>   	reg->dma_scr |= STM32_DMA_SCR_EN;
>   	stm32_dma_write(dmadev, STM32_DMA_SCR(chan->id), reg->dma_scr);
>   
> -	dev_dbg(chan2dev(chan), "vchan %p: started\n", &chan->vchan);
> +	dev_dbg(vchan_chan_dev(&chan->vchan), "vchan %p: started\n", &chan->vchan);
>   }
>   
>   static void stm32_dma_configure_next_sg(struct stm32_dma_chan *chan)
> @@ -630,12 +625,12 @@ static void stm32_dma_configure_next_sg(struct stm32_dma_chan *chan)
>   	if (dma_scr & STM32_DMA_SCR_CT) {
>   		dma_sm0ar = sg_req->chan_reg.dma_sm0ar;
>   		stm32_dma_write(dmadev, STM32_DMA_SM0AR(id), dma_sm0ar);
> -		dev_dbg(chan2dev(chan), "CT=1 <=> SM0AR: 0x%08x\n",
> +		dev_dbg(vchan_chan_dev(&chan->vchan), "CT=1 <=> SM0AR: 0x%08x\n",
>   			stm32_dma_read(dmadev, STM32_DMA_SM0AR(id)));
>   	} else {
>   		dma_sm1ar = sg_req->chan_reg.dma_sm1ar;
>   		stm32_dma_write(dmadev, STM32_DMA_SM1AR(id), dma_sm1ar);
> -		dev_dbg(chan2dev(chan), "CT=0 <=> SM1AR: 0x%08x\n",
> +		dev_dbg(vchan_chan_dev(&chan->vchan), "CT=0 <=> SM1AR: 0x%08x\n",
>   			stm32_dma_read(dmadev, STM32_DMA_SM1AR(id)));
>   	}
>   }
> @@ -676,7 +671,7 @@ static void stm32_dma_handle_chan_paused(struct stm32_dma_chan *chan)
>   
>   	chan->status = DMA_PAUSED;
>   
> -	dev_dbg(chan2dev(chan), "vchan %p: paused\n", &chan->vchan);
> +	dev_dbg(vchan_chan_dev(&chan->vchan), "vchan %p: paused\n", &chan->vchan);
>   }
>   
>   static void stm32_dma_post_resume_reconfigure(struct stm32_dma_chan *chan)
> @@ -728,7 +723,7 @@ static void stm32_dma_post_resume_reconfigure(struct stm32_dma_chan *chan)
>   	dma_scr |= STM32_DMA_SCR_EN;
>   	stm32_dma_write(dmadev, STM32_DMA_SCR(chan->id), dma_scr);
>   
> -	dev_dbg(chan2dev(chan), "vchan %p: reconfigured after pause/resume\n", &chan->vchan);
> +	dev_dbg(vchan_chan_dev(&chan->vchan), "vchan %p: reconfigured after pause/resume\n", &chan->vchan);
>   }
>   
>   static void stm32_dma_handle_chan_done(struct stm32_dma_chan *chan, u32 scr)
> @@ -775,16 +770,16 @@ static irqreturn_t stm32_dma_chan_irq(int irq, void *devid)
>   		if (sfcr & STM32_DMA_SFCR_FEIE) {
>   			if (!(scr & STM32_DMA_SCR_EN) &&
>   			    !(status & STM32_DMA_TCI))
> -				dev_err(chan2dev(chan), "FIFO Error\n");
> +				dev_err(vchan_chan_dev(&chan->vchan), "FIFO Error\n");
>   			else
> -				dev_dbg(chan2dev(chan), "FIFO over/underrun\n");
> +				dev_dbg(vchan_chan_dev(&chan->vchan), "FIFO over/underrun\n");
>   		}
>   	}
>   	if (status & STM32_DMA_DMEI) {
>   		stm32_dma_irq_clear(chan, STM32_DMA_DMEI);
>   		status &= ~STM32_DMA_DMEI;
>   		if (sfcr & STM32_DMA_SCR_DMEIE)
> -			dev_dbg(chan2dev(chan), "Direct mode overrun\n");
> +			dev_dbg(vchan_chan_dev(&chan->vchan), "Direct mode overrun\n");
>   	}
>   
>   	if (status & STM32_DMA_TCI) {
> @@ -803,9 +798,9 @@ static irqreturn_t stm32_dma_chan_irq(int irq, void *devid)
>   
>   	if (status) {
>   		stm32_dma_irq_clear(chan, status);
> -		dev_err(chan2dev(chan), "DMA error: status=0x%08x\n", status);
> +		dev_err(vchan_chan_dev(&chan->vchan), "DMA error: status=0x%08x\n", status);
>   		if (!(scr & STM32_DMA_SCR_EN))
> -			dev_err(chan2dev(chan), "chan disabled by HW\n");
> +			dev_err(vchan_chan_dev(&chan->vchan), "chan disabled by HW\n");
>   	}
>   
>   	spin_unlock(&chan->vchan.lock);
> @@ -820,7 +815,7 @@ static void stm32_dma_issue_pending(struct dma_chan *c)
>   
>   	spin_lock_irqsave(&chan->vchan.lock, flags);
>   	if (vchan_issue_pending(&chan->vchan) && !chan->desc && !chan->busy) {
> -		dev_dbg(chan2dev(chan), "vchan %p: issued\n", &chan->vchan);
> +		dev_dbg(vchan_chan_dev(&chan->vchan), "vchan %p: issued\n", &chan->vchan);
>   		stm32_dma_start_transfer(chan);
>   
>   	}
> @@ -922,7 +917,7 @@ static int stm32_dma_resume(struct dma_chan *c)
>   
>   	spin_unlock_irqrestore(&chan->vchan.lock, flags);
>   
> -	dev_dbg(chan2dev(chan), "vchan %p: resumed\n", &chan->vchan);
> +	dev_dbg(vchan_chan_dev(&chan->vchan), "vchan %p: resumed\n", &chan->vchan);
>   
>   	return 0;
>   }
> @@ -1059,7 +1054,7 @@ static int stm32_dma_set_xfer_param(struct stm32_dma_chan *chan,
>   		break;
>   
>   	default:
> -		dev_err(chan2dev(chan), "Dma direction is not supported\n");
> +		dev_err(vchan_chan_dev(&chan->vchan), "Dma direction is not supported\n");
>   		return -EINVAL;
>   	}
>   
> @@ -1092,12 +1087,12 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_slave_sg(
>   	int i, ret;
>   
>   	if (!chan->config_init) {
> -		dev_err(chan2dev(chan), "dma channel is not configured\n");
> +		dev_err(vchan_chan_dev(&chan->vchan), "dma channel is not configured\n");
>   		return NULL;
>   	}
>   
>   	if (sg_len < 1) {
> -		dev_err(chan2dev(chan), "Invalid segment length %d\n", sg_len);
> +		dev_err(vchan_chan_dev(&chan->vchan), "Invalid segment length %d\n", sg_len);
>   		return NULL;
>   	}
>   
> @@ -1129,7 +1124,7 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_slave_sg(
>   
>   		nb_data_items = desc->sg_req[i].len / buswidth;
>   		if (nb_data_items > STM32_DMA_ALIGNED_MAX_DATA_ITEMS) {
> -			dev_err(chan2dev(chan), "nb items not supported\n");
> +			dev_err(vchan_chan_dev(&chan->vchan), "nb items not supported\n");
>   			goto err;
>   		}
>   
> @@ -1164,17 +1159,17 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_dma_cyclic(
>   	int i, ret;
>   
>   	if (!buf_len || !period_len) {
> -		dev_err(chan2dev(chan), "Invalid buffer/period len\n");
> +		dev_err(vchan_chan_dev(&chan->vchan), "Invalid buffer/period len\n");
>   		return NULL;
>   	}
>   
>   	if (!chan->config_init) {
> -		dev_err(chan2dev(chan), "dma channel is not configured\n");
> +		dev_err(vchan_chan_dev(&chan->vchan), "dma channel is not configured\n");
>   		return NULL;
>   	}
>   
>   	if (buf_len % period_len) {
> -		dev_err(chan2dev(chan), "buf_len not multiple of period_len\n");
> +		dev_err(vchan_chan_dev(&chan->vchan), "buf_len not multiple of period_len\n");
>   		return NULL;
>   	}
>   
> @@ -1185,7 +1180,7 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_dma_cyclic(
>   	 * terminating the DMA.
>   	 */
>   	if (chan->busy) {
> -		dev_err(chan2dev(chan), "Request not allowed when dma busy\n");
> +		dev_err(vchan_chan_dev(&chan->vchan), "Request not allowed when dma busy\n");
>   		return NULL;
>   	}
>   
> @@ -1196,7 +1191,7 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_dma_cyclic(
>   
>   	nb_data_items = period_len / buswidth;
>   	if (nb_data_items > STM32_DMA_ALIGNED_MAX_DATA_ITEMS) {
> -		dev_err(chan2dev(chan), "number of items not supported\n");
> +		dev_err(vchan_chan_dev(&chan->vchan), "number of items not supported\n");
>   		return NULL;
>   	}
>   
> @@ -1478,7 +1473,7 @@ static void stm32_dma_free_chan_resources(struct dma_chan *c)
>   	struct stm32_dma_device *dmadev = stm32_dma_get_dev(chan);
>   	unsigned long flags;
>   
> -	dev_dbg(chan2dev(chan), "Freeing channel %d\n", chan->id);
> +	dev_dbg(vchan_chan_dev(&chan->vchan), "Freeing channel %d\n", chan->id);
>   
>   	if (chan->busy) {
>   		spin_lock_irqsave(&chan->vchan.lock, flags);
> diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma3.c
> index 6ee7a1435efb6..4fe226541efa4 100644
> --- a/drivers/dma/stm32/stm32-dma3.c
> +++ b/drivers/dma/stm32/stm32-dma3.c
> @@ -328,11 +328,6 @@ static inline struct stm32_dma3_swdesc *to_stm32_dma3_swdesc(struct virt_dma_des
>   	return container_of(vdesc, struct stm32_dma3_swdesc, vdesc);
>   }
>   
> -static struct device *chan2dev(struct stm32_dma3_chan *chan)
> -{
> -	return &chan->vchan.chan.dev->device;
> -}
> -

ditto here:
static struct device *chan2dev(struct stm32_dma3_chan *chan)
{
	return vchan_chan_dev(&chan->vchan);
}

and below, keep chan2dev() instead

>   static struct device *ddata2dev(struct stm32_dma3_ddata *ddata)
>   {
>   	return ddata->dma_dev.dev;
> @@ -341,7 +336,7 @@ static struct device *ddata2dev(struct stm32_dma3_ddata *ddata)
>   static void stm32_dma3_chan_dump_reg(struct stm32_dma3_chan *chan)
>   {
>   	struct stm32_dma3_ddata *ddata = to_stm32_dma3_ddata(chan);
> -	struct device *dev = chan2dev(chan);
> +	struct device *dev = vchan_chan_dev(&chan->vchan);
>   	u32 id = chan->id, offset;
>   
>   	offset = STM32_DMA3_SECCFGR;
> @@ -381,21 +376,21 @@ static void stm32_dma3_chan_dump_hwdesc(struct stm32_dma3_chan *chan,
>   	for (i = 0; i < swdesc->lli_size; i++) {
>   		hwdesc = swdesc->lli[i].hwdesc;
>   		if (i)
> -			dev_dbg(chan2dev(chan), "V\n");
> -		dev_dbg(chan2dev(chan), "[%d]@%pad\n", i, &swdesc->lli[i].hwdesc_addr);
> -		dev_dbg(chan2dev(chan), "| C%dTR1: %08x\n", chan->id, hwdesc->ctr1);
> -		dev_dbg(chan2dev(chan), "| C%dTR2: %08x\n", chan->id, hwdesc->ctr2);
> -		dev_dbg(chan2dev(chan), "| C%dBR1: %08x\n", chan->id, hwdesc->cbr1);
> -		dev_dbg(chan2dev(chan), "| C%dSAR: %08x\n", chan->id, hwdesc->csar);
> -		dev_dbg(chan2dev(chan), "| C%dDAR: %08x\n", chan->id, hwdesc->cdar);
> -		dev_dbg(chan2dev(chan), "| C%dLLR: %08x\n", chan->id, hwdesc->cllr);
> +			dev_dbg(vchan_chan_dev(&chan->vchan), "V\n");
> +		dev_dbg(vchan_chan_dev(&chan->vchan), "[%d]@%pad\n", i, &swdesc->lli[i].hwdesc_addr);
> +		dev_dbg(vchan_chan_dev(&chan->vchan), "| C%dTR1: %08x\n", chan->id, hwdesc->ctr1);
> +		dev_dbg(vchan_chan_dev(&chan->vchan), "| C%dTR2: %08x\n", chan->id, hwdesc->ctr2);
> +		dev_dbg(vchan_chan_dev(&chan->vchan), "| C%dBR1: %08x\n", chan->id, hwdesc->cbr1);
> +		dev_dbg(vchan_chan_dev(&chan->vchan), "| C%dSAR: %08x\n", chan->id, hwdesc->csar);
> +		dev_dbg(vchan_chan_dev(&chan->vchan), "| C%dDAR: %08x\n", chan->id, hwdesc->cdar);
> +		dev_dbg(vchan_chan_dev(&chan->vchan), "| C%dLLR: %08x\n", chan->id, hwdesc->cllr);
>   	}
>   
>   	if (swdesc->cyclic) {
> -		dev_dbg(chan2dev(chan), "|\n");
> -		dev_dbg(chan2dev(chan), "-->[0]@%pad\n", &swdesc->lli[0].hwdesc_addr);
> +		dev_dbg(vchan_chan_dev(&chan->vchan), "|\n");
> +		dev_dbg(vchan_chan_dev(&chan->vchan), "-->[0]@%pad\n", &swdesc->lli[0].hwdesc_addr);
>   	} else {
> -		dev_dbg(chan2dev(chan), "X\n");
> +		dev_dbg(vchan_chan_dev(&chan->vchan), "X\n");
>   	}
>   }
>   
> @@ -411,7 +406,7 @@ static struct stm32_dma3_swdesc *stm32_dma3_chan_desc_alloc(struct stm32_dma3_ch
>   	 * addressed, so abort the allocation.
>   	 */
>   	if ((count * 32) > CLLR_LA) {
> -		dev_err(chan2dev(chan), "Transfer is too big (> %luB)\n", STM32_DMA3_MAX_SEG_SIZE);
> +		dev_err(vchan_chan_dev(&chan->vchan), "Transfer is too big (> %luB)\n", STM32_DMA3_MAX_SEG_SIZE);
>   		return NULL;
>   	}
>   
> @@ -438,7 +433,7 @@ static struct stm32_dma3_swdesc *stm32_dma3_chan_desc_alloc(struct stm32_dma3_ch
>   	return swdesc;
>   
>   err_pool_free:
> -	dev_err(chan2dev(chan), "Failed to alloc descriptors\n");
> +	dev_err(vchan_chan_dev(&chan->vchan), "Failed to alloc descriptors\n");
>   	while (--i >= 0)
>   		dma_pool_free(chan->lli_pool, swdesc->lli[i].hwdesc, swdesc->lli[i].hwdesc_addr);
>   	kfree(swdesc);
> @@ -468,7 +463,7 @@ static void stm32_dma3_chan_vdesc_free(struct virt_dma_desc *vdesc)
>   static void stm32_dma3_check_user_setting(struct stm32_dma3_chan *chan)
>   {
>   	struct stm32_dma3_ddata *ddata = to_stm32_dma3_ddata(chan);
> -	struct device *dev = chan2dev(chan);
> +	struct device *dev = vchan_chan_dev(&chan->vchan);
>   	u32 ctr1 = readl_relaxed(ddata->base + STM32_DMA3_CTR1(chan->id));
>   	u32 cbr1 = readl_relaxed(ddata->base + STM32_DMA3_CBR1(chan->id));
>   	u32 csar = readl_relaxed(ddata->base + STM32_DMA3_CSAR(chan->id));
> @@ -579,7 +574,7 @@ static int stm32_dma3_chan_prep_hw(struct stm32_dma3_chan *chan, enum dma_transf
>   	u32 sap = FIELD_GET(STM32_DMA3_DT_SAP, tr_conf), sap_max_dw;
>   	u32 dap = FIELD_GET(STM32_DMA3_DT_DAP, tr_conf), dap_max_dw;
>   
> -	dev_dbg(chan2dev(chan), "%s from %pad to %pad\n",
> +	dev_dbg(vchan_chan_dev(&chan->vchan), "%s from %pad to %pad\n",
>   		dmaengine_get_direction_text(dir), &src_addr, &dst_addr);
>   
>   	sdw = chan->dma_config.src_addr_width ? : get_chan_max_dw(sap, chan->max_burst);
> @@ -589,12 +584,12 @@ static int stm32_dma3_chan_prep_hw(struct stm32_dma3_chan *chan, enum dma_transf
>   
>   	/* Following conditions would raise User Setting Error interrupt */
>   	if (!(dma_device.src_addr_widths & BIT(sdw)) || !(dma_device.dst_addr_widths & BIT(ddw))) {
> -		dev_err(chan2dev(chan), "Bus width (src=%u, dst=%u) not supported\n", sdw, ddw);
> +		dev_err(vchan_chan_dev(&chan->vchan), "Bus width (src=%u, dst=%u) not supported\n", sdw, ddw);
>   		return -EINVAL;
>   	}
>   
>   	if (ddata->ports_max_dw[1] == DW_INVALID && (sap || dap)) {
> -		dev_err(chan2dev(chan), "Only one master port, port 1 is not supported\n");
> +		dev_err(vchan_chan_dev(&chan->vchan), "Only one master port, port 1 is not supported\n");
>   		return -EINVAL;
>   	}
>   
> @@ -602,7 +597,7 @@ static int stm32_dma3_chan_prep_hw(struct stm32_dma3_chan *chan, enum dma_transf
>   	dap_max_dw = ddata->ports_max_dw[dap];
>   	if ((port_is_ahb(sap_max_dw) && sdw == DMA_SLAVE_BUSWIDTH_8_BYTES) ||
>   	    (port_is_ahb(dap_max_dw) && ddw == DMA_SLAVE_BUSWIDTH_8_BYTES)) {
> -		dev_err(chan2dev(chan),
> +		dev_err(vchan_chan_dev(&chan->vchan),
>   			"8 bytes buswidth (src=%u, dst=%u) not supported on port (sap=%u, dap=%u\n",
>   			sdw, ddw, sap, dap);
>   		return -EINVAL;
> @@ -659,7 +654,7 @@ static int stm32_dma3_chan_prep_hw(struct stm32_dma3_chan *chan, enum dma_transf
>   			_ctr1 |= FIELD_PREP(CTR1_PAM, CTR1_PAM_PACK_UNPACK);
>   			/* Should never reach this case as ddw is clamped down */
>   			if (len & (ddw - 1)) {
> -				dev_err(chan2dev(chan),
> +				dev_err(vchan_chan_dev(&chan->vchan),
>   					"Packing mode is enabled and len is not multiple of ddw");
>   				return -EINVAL;
>   			}
> @@ -695,7 +690,7 @@ static int stm32_dma3_chan_prep_hw(struct stm32_dma3_chan *chan, enum dma_transf
>   			_ctr1 |= FIELD_PREP(CTR1_PAM, CTR1_PAM_PACK_UNPACK);
>   			/* Should never reach this case as ddw is clamped down */
>   			if (len & (ddw - 1)) {
> -				dev_err(chan2dev(chan),
> +				dev_err(vchan_chan_dev(&chan->vchan),
>   					"Packing mode is enabled and len is not multiple of ddw\n");
>   				return -EINVAL;
>   			}
> @@ -740,7 +735,7 @@ static int stm32_dma3_chan_prep_hw(struct stm32_dma3_chan *chan, enum dma_transf
>   			_ctr1 |= FIELD_PREP(CTR1_PAM, CTR1_PAM_PACK_UNPACK);
>   			/* Should never reach this case as ddw is clamped down */
>   			if (len & (ddw - 1)) {
> -				dev_err(chan2dev(chan),
> +				dev_err(vchan_chan_dev(&chan->vchan),
>   					"Packing mode is enabled and len is not multiple of ddw");
>   				return -EINVAL;
>   			}
> @@ -752,7 +747,7 @@ static int stm32_dma3_chan_prep_hw(struct stm32_dma3_chan *chan, enum dma_transf
>   		break;
>   
>   	default:
> -		dev_err(chan2dev(chan), "Direction %s not supported\n",
> +		dev_err(vchan_chan_dev(&chan->vchan), "Direction %s not supported\n",
>   			dmaengine_get_direction_text(dir));
>   		return -EINVAL;
>   	}
> @@ -761,7 +756,7 @@ static int stm32_dma3_chan_prep_hw(struct stm32_dma3_chan *chan, enum dma_transf
>   	*ctr1 = _ctr1;
>   	*ctr2 = _ctr2;
>   
> -	dev_dbg(chan2dev(chan), "%s: sdw=%u bytes sbl=%u beats ddw=%u bytes dbl=%u beats\n",
> +	dev_dbg(vchan_chan_dev(&chan->vchan), "%s: sdw=%u bytes sbl=%u beats ddw=%u bytes dbl=%u beats\n",
>   		__func__, sdw, sbl_max, ddw, dbl_max);
>   
>   	return 0;
> @@ -807,7 +802,7 @@ static void stm32_dma3_chan_start(struct stm32_dma3_chan *chan)
>   
>   	chan->dma_status = DMA_IN_PROGRESS;
>   
> -	dev_dbg(chan2dev(chan), "vchan %p: started\n", &chan->vchan);
> +	dev_dbg(vchan_chan_dev(&chan->vchan), "vchan %p: started\n", &chan->vchan);
>   }
>   
>   static int stm32_dma3_chan_suspend(struct stm32_dma3_chan *chan, bool susp)
> @@ -871,7 +866,7 @@ static void stm32_dma3_chan_set_residue(struct stm32_dma3_chan *chan,
>   					struct dma_tx_state *txstate)
>   {
>   	struct stm32_dma3_ddata *ddata = to_stm32_dma3_ddata(chan);
> -	struct device *dev = chan2dev(chan);
> +	struct device *dev = vchan_chan_dev(&chan->vchan);
>   	struct stm32_dma3_hwdesc *hwdesc;
>   	u32 residue, curr_lli, csr, cdar, cbr1, cllr, bndt, fifol;
>   	bool pack_unpack;
> @@ -921,7 +916,7 @@ static void stm32_dma3_chan_set_residue(struct stm32_dma3_chan *chan,
>   	/* Get current hwdesc and cumulate residue of pending hwdesc BNDT */
>   	ret = stm32_dma3_chan_get_curr_hwdesc(swdesc, cllr, &residue);
>   	if (ret < 0) {
> -		dev_err(chan2dev(chan), "Can't get residue: current hwdesc not found\n");
> +		dev_err(vchan_chan_dev(&chan->vchan), "Can't get residue: current hwdesc not found\n");
>   		return;
>   	}
>   	curr_lli = ret;
> @@ -957,7 +952,7 @@ static void stm32_dma3_chan_set_residue(struct stm32_dma3_chan *chan,
>   
>   skip_fifol_update:
>   	if (fifol) {
> -		dev_dbg(chan2dev(chan), "%u byte(s) in the FIFO\n", fifol);
> +		dev_dbg(vchan_chan_dev(&chan->vchan), "%u byte(s) in the FIFO\n", fifol);
>   		dma_set_in_flight_bytes(txstate, fifol);
>   		/*
>   		 * Residue is already accurate for DMA_MEM_TO_DEV as BNDT reflects data read from
> @@ -987,7 +982,7 @@ static int stm32_dma3_chan_stop(struct stm32_dma3_chan *chan)
>   		/* Suspend the channel */
>   		ret = stm32_dma3_chan_suspend(chan, true);
>   		if (ret)
> -			dev_warn(chan2dev(chan), "%s: timeout, data might be lost\n", __func__);
> +			dev_warn(vchan_chan_dev(&chan->vchan), "%s: timeout, data might be lost\n", __func__);
>   	}
>   
>   	/*
> @@ -1034,7 +1029,7 @@ static irqreturn_t stm32_dma3_chan_irq(int irq, void *devid)
>   	}
>   
>   	if (csr & CSR_USEF && ccr & CCR_USEIE) {
> -		dev_err(chan2dev(chan), "User setting error\n");
> +		dev_err(vchan_chan_dev(&chan->vchan), "User setting error\n");
>   		chan->dma_status = DMA_ERROR;
>   		/* CCR.EN automatically cleared by HW */
>   		stm32_dma3_check_user_setting(chan);
> @@ -1042,14 +1037,14 @@ static irqreturn_t stm32_dma3_chan_irq(int irq, void *devid)
>   	}
>   
>   	if (csr & CSR_ULEF && ccr & CCR_ULEIE) {
> -		dev_err(chan2dev(chan), "Update link transfer error\n");
> +		dev_err(vchan_chan_dev(&chan->vchan), "Update link transfer error\n");
>   		chan->dma_status = DMA_ERROR;
>   		/* CCR.EN automatically cleared by HW */
>   		stm32_dma3_chan_reset(chan);
>   	}
>   
>   	if (csr & CSR_DTEF && ccr & CCR_DTEIE) {
> -		dev_err(chan2dev(chan), "Data transfer error\n");
> +		dev_err(vchan_chan_dev(&chan->vchan), "Data transfer error\n");
>   		chan->dma_status = DMA_ERROR;
>   		/* CCR.EN automatically cleared by HW */
>   		stm32_dma3_chan_reset(chan);
> @@ -1087,13 +1082,13 @@ static int stm32_dma3_get_chan_sem(struct stm32_dma3_chan *chan)
>   		goto bad_cid;
>   
>   	chan->semaphore_taken = true;
> -	dev_dbg(chan2dev(chan), "under CID1 control (semcr=0x%08x)\n", csemcr);
> +	dev_dbg(vchan_chan_dev(&chan->vchan), "under CID1 control (semcr=0x%08x)\n", csemcr);
>   
>   	return 0;
>   
>   bad_cid:
>   	chan->semaphore_taken = false;
> -	dev_err(chan2dev(chan), "not under CID1 control (in-use by CID%d)\n", ccid);
> +	dev_err(vchan_chan_dev(&chan->vchan), "not under CID1 control (in-use by CID%d)\n", ccid);
>   
>   	return -EACCES;
>   }
> @@ -1105,7 +1100,7 @@ static void stm32_dma3_put_chan_sem(struct stm32_dma3_chan *chan)
>   	if (chan->semaphore_taken) {
>   		writel_relaxed(0, ddata->base + STM32_DMA3_CSEMCR(chan->id));
>   		chan->semaphore_taken = false;
> -		dev_dbg(chan2dev(chan), "no more under CID1 control\n");
> +		dev_dbg(vchan_chan_dev(&chan->vchan), "no more under CID1 control\n");
>   	}
>   }
>   
> @@ -1130,7 +1125,7 @@ static int stm32_dma3_alloc_chan_resources(struct dma_chan *c)
>   					  sizeof(struct stm32_dma3_hwdesc),
>   					  __alignof__(struct stm32_dma3_hwdesc), SZ_64K);
>   	if (!chan->lli_pool) {
> -		dev_err(chan2dev(chan), "Failed to create LLI pool\n");
> +		dev_err(vchan_chan_dev(&chan->vchan), "Failed to create LLI pool\n");
>   		ret = -ENOMEM;
>   		goto err_put_sync;
>   	}
> @@ -1366,7 +1361,7 @@ static struct dma_async_tx_descriptor *stm32_dma3_prep_slave_sg(struct dma_chan
>   	}
>   
>   	if (count != sg_len && chan->tcem != CTR2_TCEM_CHANNEL)
> -		dev_warn(chan2dev(chan), "Linked-list refactored, %d items instead of %d\n",
> +		dev_warn(vchan_chan_dev(&chan->vchan), "Linked-list refactored, %d items instead of %d\n",
>   			 count, sg_len);
>   
>   	/* Enable Error interrupts */
> @@ -1401,12 +1396,12 @@ static struct dma_async_tx_descriptor *stm32_dma3_prep_dma_cyclic(struct dma_cha
>   		return NULL;
>   
>   	if (!buf_len || !period_len || period_len > STM32_DMA3_MAX_BLOCK_SIZE) {
> -		dev_err(chan2dev(chan), "Invalid buffer/period length\n");
> +		dev_err(vchan_chan_dev(&chan->vchan), "Invalid buffer/period length\n");
>   		return NULL;
>   	}
>   
>   	if (buf_len % period_len) {
> -		dev_err(chan2dev(chan), "Buffer length not multiple of period length\n");
> +		dev_err(vchan_chan_dev(&chan->vchan), "Buffer length not multiple of period length\n");
>   		return NULL;
>   	}
>   
> @@ -1428,7 +1423,7 @@ static struct dma_async_tx_descriptor *stm32_dma3_prep_dma_cyclic(struct dma_cha
>   		ret = stm32_dma3_chan_prep_hw(chan, DMA_DEV_TO_MEM, &swdesc->ccr, &ctr1, &ctr2,
>   					      src, dst, period_len);
>   	} else {
> -		dev_err(chan2dev(chan), "Invalid direction\n");
> +		dev_err(vchan_chan_dev(&chan->vchan), "Invalid direction\n");
>   		ret = -EINVAL;
>   	}
>   
> @@ -1502,7 +1497,7 @@ static int stm32_dma3_pause(struct dma_chan *c)
>   
>   	chan->dma_status = DMA_PAUSED;
>   
> -	dev_dbg(chan2dev(chan), "vchan %p: paused\n", &chan->vchan);
> +	dev_dbg(vchan_chan_dev(&chan->vchan), "vchan %p: paused\n", &chan->vchan);
>   
>   	return 0;
>   }
> @@ -1515,7 +1510,7 @@ static int stm32_dma3_resume(struct dma_chan *c)
>   
>   	chan->dma_status = DMA_IN_PROGRESS;
>   
> -	dev_dbg(chan2dev(chan), "vchan %p: resumed\n", &chan->vchan);
> +	dev_dbg(vchan_chan_dev(&chan->vchan), "vchan %p: resumed\n", &chan->vchan);
>   
>   	return 0;
>   }
> @@ -1540,7 +1535,7 @@ static int stm32_dma3_terminate_all(struct dma_chan *c)
>   	spin_unlock_irqrestore(&chan->vchan.lock, flags);
>   	vchan_dma_desc_free_list(&chan->vchan, &head);
>   
> -	dev_dbg(chan2dev(chan), "vchan %p: terminated\n", &chan->vchan);
> +	dev_dbg(vchan_chan_dev(&chan->vchan), "vchan %p: terminated\n", &chan->vchan);
>   
>   	return 0;
>   }
> @@ -1593,7 +1588,7 @@ static void stm32_dma3_issue_pending(struct dma_chan *c)
>   	spin_lock_irqsave(&chan->vchan.lock, flags);
>   
>   	if (vchan_issue_pending(&chan->vchan) && !chan->swdesc) {
> -		dev_dbg(chan2dev(chan), "vchan %p: issued\n", &chan->vchan);
> +		dev_dbg(vchan_chan_dev(&chan->vchan), "vchan %p: issued\n", &chan->vchan);
>   		stm32_dma3_chan_start(chan);
>   	}
>   
> diff --git a/drivers/dma/stm32/stm32-mdma.c b/drivers/dma/stm32/stm32-mdma.c
> index c274638e919c2..e125921bf9533 100644
> --- a/drivers/dma/stm32/stm32-mdma.c
> +++ b/drivers/dma/stm32/stm32-mdma.c
> @@ -276,11 +276,6 @@ static struct stm32_mdma_desc *to_stm32_mdma_desc(struct virt_dma_desc *vdesc)
>   	return container_of(vdesc, struct stm32_mdma_desc, vdesc);
>   }
>   
> -static struct device *chan2dev(struct stm32_mdma_chan *chan)
> -{
> -	return &chan->vchan.chan.dev->device;
> -}
> -


ditto here:
static struct device *chan2dev(struct stm32_mdma_chan *chan)
{
	return vchan_chan_dev(&chan->vchan);
}

and below, keep chan2dev() instead.

>   static struct device *mdma2dev(struct stm32_mdma_device *mdma_dev)
>   {
>   	return mdma_dev->ddev.dev;
> @@ -334,7 +329,7 @@ static struct stm32_mdma_desc *stm32_mdma_alloc_desc(
>   	return desc;
>   
>   err:
> -	dev_err(chan2dev(chan), "Failed to allocate descriptor\n");
> +	dev_err(vchan_chan_dev(&chan->vchan), "Failed to allocate descriptor\n");
>   	while (--i >= 0)
>   		dma_pool_free(chan->desc_pool, desc->node[i].hwdesc,
>   			      desc->node[i].hwdesc_phys);
> @@ -364,7 +359,7 @@ static int stm32_mdma_get_width(struct stm32_mdma_chan *chan,
>   	case DMA_SLAVE_BUSWIDTH_8_BYTES:
>   		return ffs(width) - 1;
>   	default:
> -		dev_err(chan2dev(chan), "Dma bus width %i not supported\n",
> +		dev_err(vchan_chan_dev(&chan->vchan), "Dma bus width %i not supported\n",
>   			width);
>   		return -EINVAL;
>   	}
> @@ -422,7 +417,7 @@ static int stm32_mdma_disable_chan(struct stm32_mdma_chan *chan)
>   				dmadev->base + STM32_MDMA_CISR(id), cisr,
>   				(cisr & STM32_MDMA_CISR_CTCIF), 10, 1000);
>   		if (ret) {
> -			dev_err(chan2dev(chan), "%s: timeout!\n", __func__);
> +			dev_err(vchan_chan_dev(&chan->vchan), "%s: timeout!\n", __func__);
>   			return -EBUSY;
>   		}
>   	}
> @@ -444,7 +439,7 @@ static void stm32_mdma_stop(struct stm32_mdma_chan *chan)
>   	/* Clear interrupt status if it is there */
>   	status = stm32_mdma_read(dmadev, STM32_MDMA_CISR(chan->id));
>   	if (status) {
> -		dev_dbg(chan2dev(chan), "%s(): clearing interrupt: 0x%08x\n",
> +		dev_dbg(vchan_chan_dev(&chan->vchan), "%s(): clearing interrupt: 0x%08x\n",
>   			__func__, status);
>   		stm32_mdma_set_bits(dmadev, STM32_MDMA_CIFCR(chan->id), status);
>   	}
> @@ -513,7 +508,7 @@ static int stm32_mdma_set_xfer_param(struct stm32_mdma_chan *chan,
>   	/* Check burst size constraints */
>   	if (src_maxburst * src_addr_width > STM32_MDMA_MAX_BURST ||
>   	    dst_maxburst * dst_addr_width > STM32_MDMA_MAX_BURST) {
> -		dev_err(chan2dev(chan),
> +		dev_err(vchan_chan_dev(&chan->vchan),
>   			"burst size * bus width higher than %d bytes\n",
>   			STM32_MDMA_MAX_BURST);
>   		return -EINVAL;
> @@ -521,7 +516,7 @@ static int stm32_mdma_set_xfer_param(struct stm32_mdma_chan *chan,
>   
>   	if ((!is_power_of_2(src_maxburst) && src_maxburst > 0) ||
>   	    (!is_power_of_2(dst_maxburst) && dst_maxburst > 0)) {
> -		dev_err(chan2dev(chan), "burst size must be a power of 2\n");
> +		dev_err(vchan_chan_dev(&chan->vchan), "burst size must be a power of 2\n");
>   		return -EINVAL;
>   	}
>   
> @@ -658,7 +653,7 @@ static int stm32_mdma_set_xfer_param(struct stm32_mdma_chan *chan,
>   		break;
>   
>   	default:
> -		dev_err(chan2dev(chan), "Dma direction is not supported\n");
> +		dev_err(vchan_chan_dev(&chan->vchan), "Dma direction is not supported\n");
>   		return -EINVAL;
>   	}
>   
> @@ -672,16 +667,16 @@ static int stm32_mdma_set_xfer_param(struct stm32_mdma_chan *chan,
>   static void stm32_mdma_dump_hwdesc(struct stm32_mdma_chan *chan,
>   				   struct stm32_mdma_desc_node *node)
>   {
> -	dev_dbg(chan2dev(chan), "hwdesc:  %pad\n", &node->hwdesc_phys);
> -	dev_dbg(chan2dev(chan), "CTCR:    0x%08x\n", node->hwdesc->ctcr);
> -	dev_dbg(chan2dev(chan), "CBNDTR:  0x%08x\n", node->hwdesc->cbndtr);
> -	dev_dbg(chan2dev(chan), "CSAR:    0x%08x\n", node->hwdesc->csar);
> -	dev_dbg(chan2dev(chan), "CDAR:    0x%08x\n", node->hwdesc->cdar);
> -	dev_dbg(chan2dev(chan), "CBRUR:   0x%08x\n", node->hwdesc->cbrur);
> -	dev_dbg(chan2dev(chan), "CLAR:    0x%08x\n", node->hwdesc->clar);
> -	dev_dbg(chan2dev(chan), "CTBR:    0x%08x\n", node->hwdesc->ctbr);
> -	dev_dbg(chan2dev(chan), "CMAR:    0x%08x\n", node->hwdesc->cmar);
> -	dev_dbg(chan2dev(chan), "CMDR:    0x%08x\n\n", node->hwdesc->cmdr);
> +	dev_dbg(vchan_chan_dev(&chan->vchan), "hwdesc:  %pad\n", &node->hwdesc_phys);
> +	dev_dbg(vchan_chan_dev(&chan->vchan), "CTCR:    0x%08x\n", node->hwdesc->ctcr);
> +	dev_dbg(vchan_chan_dev(&chan->vchan), "CBNDTR:  0x%08x\n", node->hwdesc->cbndtr);
> +	dev_dbg(vchan_chan_dev(&chan->vchan), "CSAR:    0x%08x\n", node->hwdesc->csar);
> +	dev_dbg(vchan_chan_dev(&chan->vchan), "CDAR:    0x%08x\n", node->hwdesc->cdar);
> +	dev_dbg(vchan_chan_dev(&chan->vchan), "CBRUR:   0x%08x\n", node->hwdesc->cbrur);
> +	dev_dbg(vchan_chan_dev(&chan->vchan), "CLAR:    0x%08x\n", node->hwdesc->clar);
> +	dev_dbg(vchan_chan_dev(&chan->vchan), "CTBR:    0x%08x\n", node->hwdesc->ctbr);
> +	dev_dbg(vchan_chan_dev(&chan->vchan), "CMAR:    0x%08x\n", node->hwdesc->cmar);
> +	dev_dbg(vchan_chan_dev(&chan->vchan), "CMDR:    0x%08x\n\n", node->hwdesc->cmdr);
>   }
>   
>   static void stm32_mdma_setup_hwdesc(struct stm32_mdma_chan *chan,
> @@ -739,7 +734,7 @@ static int stm32_mdma_setup_xfer(struct stm32_mdma_chan *chan,
>   
>   	for_each_sg(sgl, sg, sg_len, i) {
>   		if (sg_dma_len(sg) > STM32_MDMA_MAX_BLOCK_LEN) {
> -			dev_err(chan2dev(chan), "Invalid block len\n");
> +			dev_err(vchan_chan_dev(&chan->vchan), "Invalid block len\n");
>   			return -EINVAL;
>   		}
>   
> @@ -797,7 +792,7 @@ stm32_mdma_prep_slave_sg(struct dma_chan *c, struct scatterlist *sgl,
>   	 * for allowing another request.
>   	 */
>   	if (chan->desc && chan->desc->cyclic) {
> -		dev_err(chan2dev(chan),
> +		dev_err(vchan_chan_dev(&chan->vchan),
>   			"Request not allowed when dma in cyclic mode\n");
>   		return NULL;
>   	}
> @@ -858,18 +853,18 @@ stm32_mdma_prep_dma_cyclic(struct dma_chan *c, dma_addr_t buf_addr,
>   	 * for allowing another request.
>   	 */
>   	if (chan->desc && chan->desc->cyclic) {
> -		dev_err(chan2dev(chan),
> +		dev_err(vchan_chan_dev(&chan->vchan),
>   			"Request not allowed when dma in cyclic mode\n");
>   		return NULL;
>   	}
>   
>   	if (!buf_len || !period_len || period_len > STM32_MDMA_MAX_BLOCK_LEN) {
> -		dev_err(chan2dev(chan), "Invalid buffer/period len\n");
> +		dev_err(vchan_chan_dev(&chan->vchan), "Invalid buffer/period len\n");
>   		return NULL;
>   	}
>   
>   	if (buf_len % period_len) {
> -		dev_err(chan2dev(chan), "buf_len not multiple of period_len\n");
> +		dev_err(vchan_chan_dev(&chan->vchan), "buf_len not multiple of period_len\n");
>   		return NULL;
>   	}
>   
> @@ -954,7 +949,7 @@ stm32_mdma_prep_dma_memcpy(struct dma_chan *c, dma_addr_t dest, dma_addr_t src,
>   	 * to allow another request
>   	 */
>   	if (chan->desc && chan->desc->cyclic) {
> -		dev_err(chan2dev(chan),
> +		dev_err(vchan_chan_dev(&chan->vchan),
>   			"Request not allowed when dma in cyclic mode\n");
>   		return NULL;
>   	}
> @@ -1116,25 +1111,25 @@ static void stm32_mdma_dump_reg(struct stm32_mdma_chan *chan)
>   {
>   	struct stm32_mdma_device *dmadev = stm32_mdma_get_dev(chan);
>   
> -	dev_dbg(chan2dev(chan), "CCR:     0x%08x\n",
> +	dev_dbg(vchan_chan_dev(&chan->vchan), "CCR:     0x%08x\n",
>   		stm32_mdma_read(dmadev, STM32_MDMA_CCR(chan->id)));
> -	dev_dbg(chan2dev(chan), "CTCR:    0x%08x\n",
> +	dev_dbg(vchan_chan_dev(&chan->vchan), "CTCR:    0x%08x\n",
>   		stm32_mdma_read(dmadev, STM32_MDMA_CTCR(chan->id)));
> -	dev_dbg(chan2dev(chan), "CBNDTR:  0x%08x\n",
> +	dev_dbg(vchan_chan_dev(&chan->vchan), "CBNDTR:  0x%08x\n",
>   		stm32_mdma_read(dmadev, STM32_MDMA_CBNDTR(chan->id)));
> -	dev_dbg(chan2dev(chan), "CSAR:    0x%08x\n",
> +	dev_dbg(vchan_chan_dev(&chan->vchan), "CSAR:    0x%08x\n",
>   		stm32_mdma_read(dmadev, STM32_MDMA_CSAR(chan->id)));
> -	dev_dbg(chan2dev(chan), "CDAR:    0x%08x\n",
> +	dev_dbg(vchan_chan_dev(&chan->vchan), "CDAR:    0x%08x\n",
>   		stm32_mdma_read(dmadev, STM32_MDMA_CDAR(chan->id)));
> -	dev_dbg(chan2dev(chan), "CBRUR:   0x%08x\n",
> +	dev_dbg(vchan_chan_dev(&chan->vchan), "CBRUR:   0x%08x\n",
>   		stm32_mdma_read(dmadev, STM32_MDMA_CBRUR(chan->id)));
> -	dev_dbg(chan2dev(chan), "CLAR:    0x%08x\n",
> +	dev_dbg(vchan_chan_dev(&chan->vchan), "CLAR:    0x%08x\n",
>   		stm32_mdma_read(dmadev, STM32_MDMA_CLAR(chan->id)));
> -	dev_dbg(chan2dev(chan), "CTBR:    0x%08x\n",
> +	dev_dbg(vchan_chan_dev(&chan->vchan), "CTBR:    0x%08x\n",
>   		stm32_mdma_read(dmadev, STM32_MDMA_CTBR(chan->id)));
> -	dev_dbg(chan2dev(chan), "CMAR:    0x%08x\n",
> +	dev_dbg(vchan_chan_dev(&chan->vchan), "CMAR:    0x%08x\n",
>   		stm32_mdma_read(dmadev, STM32_MDMA_CMAR(chan->id)));
> -	dev_dbg(chan2dev(chan), "CMDR:    0x%08x\n",
> +	dev_dbg(vchan_chan_dev(&chan->vchan), "CMDR:    0x%08x\n",
>   		stm32_mdma_read(dmadev, STM32_MDMA_CMDR(chan->id)));
>   }
>   
> @@ -1187,7 +1182,7 @@ static void stm32_mdma_start_transfer(struct stm32_mdma_chan *chan)
>   
>   	chan->busy = true;
>   
> -	dev_dbg(chan2dev(chan), "vchan %p: started\n", &chan->vchan);
> +	dev_dbg(vchan_chan_dev(&chan->vchan), "vchan %p: started\n", &chan->vchan);
>   }
>   
>   static void stm32_mdma_issue_pending(struct dma_chan *c)
> @@ -1200,7 +1195,7 @@ static void stm32_mdma_issue_pending(struct dma_chan *c)
>   	if (!vchan_issue_pending(&chan->vchan))
>   		goto end;
>   
> -	dev_dbg(chan2dev(chan), "vchan %p: issued\n", &chan->vchan);
> +	dev_dbg(vchan_chan_dev(&chan->vchan), "vchan %p: issued\n", &chan->vchan);
>   
>   	if (!chan->desc && !chan->busy)
>   		stm32_mdma_start_transfer(chan);
> @@ -1220,7 +1215,7 @@ static int stm32_mdma_pause(struct dma_chan *c)
>   	spin_unlock_irqrestore(&chan->vchan.lock, flags);
>   
>   	if (!ret)
> -		dev_dbg(chan2dev(chan), "vchan %p: pause\n", &chan->vchan);
> +		dev_dbg(vchan_chan_dev(&chan->vchan), "vchan %p: pause\n", &chan->vchan);
>   
>   	return ret;
>   }
> @@ -1261,7 +1256,7 @@ static int stm32_mdma_resume(struct dma_chan *c)
>   
>   	spin_unlock_irqrestore(&chan->vchan.lock, flags);
>   
> -	dev_dbg(chan2dev(chan), "vchan %p: resume\n", &chan->vchan);
> +	dev_dbg(vchan_chan_dev(&chan->vchan), "vchan %p: resume\n", &chan->vchan);
>   
>   	return 0;
>   }
> @@ -1422,10 +1417,10 @@ static irqreturn_t stm32_mdma_irq_handler(int irq, void *devid)
>   	if (!(status & ien)) {
>   		spin_unlock(&chan->vchan.lock);
>   		if (chan->busy)
> -			dev_warn(chan2dev(chan),
> +			dev_warn(vchan_chan_dev(&chan->vchan),
>   				 "spurious it (status=0x%04x, ien=0x%04x)\n", status, ien);
>   		else
> -			dev_dbg(chan2dev(chan),
> +			dev_dbg(vchan_chan_dev(&chan->vchan),
>   				"spurious it (status=0x%04x, ien=0x%04x)\n", status, ien);
>   		return IRQ_NONE;
>   	}
> @@ -1433,7 +1428,7 @@ static irqreturn_t stm32_mdma_irq_handler(int irq, void *devid)
>   	reg = STM32_MDMA_CIFCR(id);
>   
>   	if (status & STM32_MDMA_CISR_TEIF) {
> -		dev_err(chan2dev(chan), "Transfer Err: stat=0x%08x\n",
> +		dev_err(vchan_chan_dev(&chan->vchan), "Transfer Err: stat=0x%08x\n",
>   			readl_relaxed(dmadev->base + STM32_MDMA_CESR(id)));
>   		stm32_mdma_set_bits(dmadev, reg, STM32_MDMA_CIFCR_CTEIF);
>   		status &= ~STM32_MDMA_CISR_TEIF;
> @@ -1468,9 +1463,9 @@ static irqreturn_t stm32_mdma_irq_handler(int irq, void *devid)
>   
>   	if (status) {
>   		stm32_mdma_set_bits(dmadev, reg, status);
> -		dev_err(chan2dev(chan), "DMA error: status=0x%08x\n", status);
> +		dev_err(vchan_chan_dev(&chan->vchan), "DMA error: status=0x%08x\n", status);
>   		if (!(ccr & STM32_MDMA_CCR_EN))
> -			dev_err(chan2dev(chan), "chan disabled by HW\n");
> +			dev_err(vchan_chan_dev(&chan->vchan), "chan disabled by HW\n");
>   	}
>   
>   	spin_unlock(&chan->vchan.lock);
> @@ -1490,7 +1485,7 @@ static int stm32_mdma_alloc_chan_resources(struct dma_chan *c)
>   					  __alignof__(struct stm32_mdma_hwdesc),
>   					   0);
>   	if (!chan->desc_pool) {
> -		dev_err(chan2dev(chan), "failed to allocate descriptor pool\n");
> +		dev_err(vchan_chan_dev(&chan->vchan), "failed to allocate descriptor pool\n");
>   		return -ENOMEM;
>   	}
>   
> @@ -1511,7 +1506,7 @@ static void stm32_mdma_free_chan_resources(struct dma_chan *c)
>   	struct stm32_mdma_device *dmadev = stm32_mdma_get_dev(chan);
>   	unsigned long flags;
>   
> -	dev_dbg(chan2dev(chan), "Freeing channel %d\n", chan->id);
> +	dev_dbg(vchan_chan_dev(&chan->vchan), "Freeing channel %d\n", chan->id);
>   
>   	if (chan->busy) {
>   		spin_lock_irqsave(&chan->vchan.lock, flags);

Regards,
Amelie
