Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012015.outbound.protection.outlook.com [52.101.66.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3FD3A7593;
	Fri,  4 Sep 2026 08:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788510961; cv=fail; b=Xa7cO9aVmpKCmogUQykXNDGfhugeM9xKxxfNS1NiVWoBbDerRmABJY/dCiLHsF12h4iCIZUCfPT5Fx6Ne8xZ6NQ0yJUjdbfnlaxNuAQv9iniiFjPzltpoDflFqV20NqdmpRfU5K6U35m9edK9hnUI31+Ry1jgoJGD7IUL1SEtSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788510961; c=relaxed/simple;
	bh=oL6ruZ/1cOimsyCFaz/3CkgoXoGKGeEB2l/1nV8a2PE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ctM+OvZkPZRvh2ZkFkctwPhlHvfTgqOuNj80oLXMoKYdGWM2iGJVPznZTYHq64Uq+XdxI/fkb8VCdDOKh7rdvbS7td/sdg4USc9hWl2vfLUDuttkFENWc8eaYAPZreUzXpPElViyMNM4TzqGQ+6Hf2eSFsFRRUCxU//CdRqoZUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=YryKQFes; arc=fail smtp.client-ip=52.101.66.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="YryKQFes"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uDaPrdLquTJ/BGG/W6YxkcjbRJdGAgm0aeWcaIo/Qg7SfDIkNkt4T5z3tp4VrDkKUPqpcsx1QHcdeXa2wlfZV1YVJx7QrCHs50jJIX8k49uRdMVef4TlwTOqrrCuPyjenrxGKvyA5276vMkeeMqEHB2lhX0DY4n0ib9UsRcocTf7VHjXXgO8fyllNJwjEUnUNWb224O7aOousX666Rg/i+uIpqrpkOXhhJmPwkXNG42QzUwZeRQQhlZ/X5XqJZxfY/M8+IJgRikQnsIXjwXPXv+KxQDJoxeAOjJoFlQwFacmP716+2sMwqBp0iv6bbkfttB9dtpZIU80fS7t941LOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qXBaOeGDE9CIr0w1l+6Z/32ykDFbrDHVuTkJtZS1G7s=;
 b=jVyzeL+2xaWiuOGJzbg1h1TcRBK05POH2/1NfY62gOvSug991FkyQCkPXgiD4KbKKr2il+M9iR9BPRDzWpA+1c/qByc3MTbCAToPoJmsaAnQ+uHWFLb92PGMKmvUf0BUnYlUHsOdOmKoTRJFcCTDktzPONciVTsDi6cTGk88a8sgDT8YSvcMNXWyBTeCle+zAvoUyd3BBUwVb6aEsztlJBZR2ZOx14377Ch9lhcjHXQnXnsJZNy8E0m5JoOjKNV0PaKd0KiMVKHwKKO6DmAqE46QdXmQwzRO/WWU1rkcpw/2AkZjThQ8xN6F4IWbvlb5Q10p6PnMsjMdRgqTur3V2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.88) smtp.rcpttodomain=oss.nxp.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXBaOeGDE9CIr0w1l+6Z/32ykDFbrDHVuTkJtZS1G7s=;
 b=YryKQFes0AqftsnRRitantV98OOZks2Lb5z4yiQe+//1q3Vbob6LPbbVDudotRxoreEzX1jg8tbN9u5lRPvxHyOEJg1cTyEXeNNmuuinETN0PbgLQ9yGOw//WblBb0m+Ldt1Af54dti5soTFo18LIM9tW4KVZOBcK0jzo9wIAnZ4m9Sm5uK6mbjiH+D4TnW6ysEv+8b+B2TSro+XqOemcP1eXscW1wZHHdeuuhW8bazOvNKWi+hW1yifDLhmB3sXep3p5OwXaL4xS0DMF6Ea1VdENL/cOvR9B5x1NEQZZQYKqqwxZF2c5YQC51JG3axzzZI4rRySRgyxWoqd8CRewA==
Received: from AS4PR10CA0013.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5dc::20)
 by VI1PR10MB3615.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:139::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 08:35:49 +0000
Received: from AMS0EPF00000567.eurprd02.prod.outlook.com
 (2603:10a6:20b:5dc:cafe::90) by AS4PR10CA0013.outlook.office365.com
 (2603:10a6:20b:5dc::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Fri, 4
 Sep 2026 08:35:49 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.88)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.88 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.88; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.88) by
 AMS0EPF00000567.mail.protection.outlook.com (10.167.242.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 08:35:49 +0000
Received: from ENXDAG1NODE4.st.com (10.75.129.197) by smtpo365.st.com
 (10.250.44.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 4 Sep
 2026 10:33:06 +0200
Received: from [10.48.87.20] (10.48.87.20) by ENXDAG1NODE4.st.com
 (10.75.129.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 4 Sep
 2026 10:35:47 +0200
Message-ID: <4e3a2f00-ec1d-426e-b71b-fcd9fabe6b86@foss.st.com>
Date: Fri, 4 Sep 2026 10:35:47 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dmaengine: vchan: add vchan_chan_name() to get
 channel device name
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
References: <20260903-dma-chan_dev-rename-v2-0-0db305b6c716@nxp.com>
 <20260903-dma-chan_dev-rename-v2-1-0db305b6c716@nxp.com>
Content-Language: en-US
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
In-Reply-To: <20260903-dma-chan_dev-rename-v2-1-0db305b6c716@nxp.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To ENXDAG1NODE4.st.com
 (10.75.129.197)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000567:EE_|VI1PR10MB3615:EE_
X-MS-Office365-Filtering-Correlation-Id: 2065755b-6d7b-4a40-5e68-08df0a5f85f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|23010399003|36860700016|921020|10067099003|4143699003|56012099006|22082099003|18002099003|11063799006|41080700001;
X-Microsoft-Antispam-Message-Info:
	ieZZLa80x4vz4cYuxvA8oTLJIwQNPGSQa2J8I+XvITdrICEOfEbWdpxtA5u7LYRu3qCxXwoZx6ArfVYcjYzSzrpX5nu4JVMsB1dO+tZ8tzx9SopOev/0tBWXrTJb/Z3ZiQDOVQXzO7eXdSZfqBiJBrfrn3+CBV6VATxKx/aS9vi4iXeTA9fYWWIgx8lfuGlhuxISwq0QyS6Num/Cx0CkBiTeg0AFC3VtfSN/2B+yfxuGypF7riWEwz89H7/j35qNa4N53ilEF3ofhfTbEdJT2xKq6SRMrDlD/aqMSkgCkpNDP8gJ8iL6/BRzgdS8WKt4JkhtadEKizt1otphHzrDz9u/BTRz9Zw0Umr+LV3BBcSB+ejpSIp8SzWRmDcqzYEF2QqVEmXdhaSTaYPmsG00xMkEHbltI+jyjgslBfXhKRx75IrI9sfFnSNxH3SpLwVbarb+bYXODhTUtkFZpvpzq2+oZZmvClbGc4Zpg08bKEpfqSy+bU0Tr4bk5kAX7z7FoDjsL/fHwV6ZchFQlJLdbIAEP2VmnZqpb2SZ1xpTj9nBA869w7NoeIUAapzxWt51xAy71F9WUTRsboGk8UAkp6EL8MLymtuuwZ73Xu0dzX7vTE9pz0CSOiAp2KAZKYOWvl4xwsOmi7VoAD3DH7SM0+mREdWmQWDLr/oN2Xjk/U/C7W2rPE27DFFGcnEBAnRtl+aE1SBtRJcAMyOo7nSm+WLlst+deYBUZh5KLa97tpYf7d4qqNvc0w9ABiBn3itS
X-Forefront-Antispam-Report:
	CIP:164.130.1.88;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(23010399003)(36860700016)(921020)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003)(11063799006)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7Nu1x+BgUG32rkucRghRc8xYBseh5qbrNgvot1CwJuv2PToQVkBcPNfeoQwaz/GOE2cqdRh3I4XsPW+Mb+IlxAVAU3Pzdcy8S3RtIvjEYr2AgQwfWXf/xQSR0EX7sfe7dda3AgErZNZffWn4MEthtGZu0X5fxXjXxstCKFNgHOH+KPaVyrw3cIOMMn6P/8BGNzvBylRuRBxy7ZZ1rMPouKDOSmNIiR/dfXmJ2toknKgyhh0vKxxyxhgnZLONklwiMDFIfyyYUV8o3sxPuzXPLbEQPQID5VpxCHx4jmhQaBOx9jy1J16asPej6ib2U3tAvZegzO7sxYgROqsEFTkykwYmZgLwF5BTWrsQoEST77zh4SzyTnbf7vDHEHdhxVePWhmeEQw0PVIHjy8Q83rPOji1tP0vrSTQGllXzPe3yUuz3yFPHcRttunYvUZ/nX/M
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 08:35:49.4973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2065755b-6d7b-4a40-5e68-08df0a5f85f5
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.88];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000567.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3615

Hi Frank,

On 9/3/26 22:53, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Introduce vchan_chan_name() to obtain the DMA channel device name.
> 
> Use a dedicated helper instead of directly accessing dma_chan::dev
> so callers remain unaffected by an upcoming rename of the struct member.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>   drivers/dma/arm-dma350.c                     |  2 +-
>   drivers/dma/loongson/loongson2-apb-cmc-dma.c |  2 +-
>   drivers/dma/stm32/stm32-dma.c                |  2 +-
>   drivers/dma/stm32/stm32-dma3.c               |  4 ++--

Could you move the driver updates from this patch to the next one? I 
don’t understand why the drivers above are modified here, while others 
are deferred to "[PATCH v2 2/3] dmaengine: use dma_chan_name() helper to 
get per-channel device name".

Regards,
Amelie

>   drivers/dma/virt-dma.h                       | 11 +++++++++++
>   5 files changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/arm-dma350.c b/drivers/dma/arm-dma350.c
> index 09403aca8bb06..52f5242ea3327 100644
> --- a/drivers/dma/arm-dma350.c
> +++ b/drivers/dma/arm-dma350.c
> @@ -512,7 +512,7 @@ static int d350_alloc_chan_resources(struct dma_chan *chan)
>   {
>   	struct d350_chan *dch = to_d350_chan(chan);
>   	int ret = request_irq(dch->irq, d350_irq, IRQF_SHARED,
> -			      dev_name(&dch->vc.chan.dev->device), dch);
> +			      vchan_chan_name(&dch->vc), dch);
>   	if (!ret)
>   		writel_relaxed(CH_INTREN_DONE | CH_INTREN_ERR, dch->base + CH_INTREN);
>   
> diff --git a/drivers/dma/loongson/loongson2-apb-cmc-dma.c b/drivers/dma/loongson/loongson2-apb-cmc-dma.c
> index 1c9a542edc859..2f1c8c4fd0654 100644
> --- a/drivers/dma/loongson/loongson2-apb-cmc-dma.c
> +++ b/drivers/dma/loongson/loongson2-apb-cmc-dma.c
> @@ -678,7 +678,7 @@ static int loongson2_cmc_dma_probe(struct platform_device *pdev)
>   			return lchan->irq;
>   
>   		ret = devm_request_irq(dev, lchan->irq, loongson2_cmc_dma_chan_irq, IRQF_SHARED,
> -				       dev_name(chan2dev(lchan)), lchan);
> +				       vchan_chan_name(&lchan->vchan), lchan);
>   		if (ret)
>   			return ret;
>   	}
> diff --git a/drivers/dma/stm32/stm32-dma.c b/drivers/dma/stm32/stm32-dma.c
> index d3ad78562a140..3e8151e2ad75a 100644
> --- a/drivers/dma/stm32/stm32-dma.c
> +++ b/drivers/dma/stm32/stm32-dma.c
> @@ -1668,7 +1668,7 @@ static int stm32_dma_probe(struct platform_device *pdev)
>   
>   		ret = devm_request_irq(&pdev->dev, chan->irq,
>   				       stm32_dma_chan_irq, 0,
> -				       dev_name(chan2dev(chan)), chan);
> +				       vchan_chan_name(&chan->vchan), chan);
>   		if (ret) {
>   			dev_err(&pdev->dev,
>   				"request_irq failed with err %d channel %d\n",
> diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma3.c
> index 4724e7fa0008e..1ee1bd22703fb 100644
> --- a/drivers/dma/stm32/stm32-dma3.c
> +++ b/drivers/dma/stm32/stm32-dma3.c
> @@ -1892,10 +1892,10 @@ static int stm32_dma3_probe(struct platform_device *pdev)
>   		chan->irq = ret;
>   
>   		ret = devm_request_irq(&pdev->dev, chan->irq, stm32_dma3_chan_irq, 0,
> -				       dev_name(chan2dev(chan)), chan);
> +				       vchan_chan_name(&chan->vchan), chan);
>   		if (ret) {
>   			dev_err_probe(&pdev->dev, ret, "Failed to request channel %s IRQ\n",
> -				      dev_name(chan2dev(chan)));
> +				      vchan_chan_name(&chan->vchan));
>   			goto err_clk_disable;
>   		}
>   	}
> diff --git a/drivers/dma/virt-dma.h b/drivers/dma/virt-dma.h
> index 59d9eabc8b674..dd023a3831209 100644
> --- a/drivers/dma/virt-dma.h
> +++ b/drivers/dma/virt-dma.h
> @@ -209,6 +209,17 @@ static inline void vchan_free_chan_resources(struct virt_dma_chan *vc)
>   	vchan_dma_desc_free_list(vc, &head);
>   }
>   
> +/**
> + * vchan_chan_name - Return vchan DMA channel device name
> + * @vc: virtual channel
> + *
> + * Return: The name of the DMA channel device
> + */
> +static inline const char *vchan_chan_name(struct virt_dma_chan *vc)
> +{
> +	return dma_chan_name(&vc->chan);
> +}
> +
>   /**
>    * vchan_synchronize() - synchronize callback execution to the current context
>    * @vc: virtual channel to synchronize
> 

