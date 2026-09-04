Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011059.outbound.protection.outlook.com [40.107.130.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DEA42E8FF;
	Fri,  4 Sep 2026 09:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788513067; cv=fail; b=VNgUH/v+y8wljiyr6jOCJGVcG/+7+giwi6l6ls5VSOp2B8yLJZf2ZAsScytj36tFE5+3T5ylQ5IuSiU2FSStpcbLdxi2hpec+AiMNYlLtrhLTIRXZBy7qz+oqSjLRE1FKIrRzOEycpn1uiVmuYwzTZHgDH511yEnEy8AsWhOaJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788513067; c=relaxed/simple;
	bh=nMSZjDawsFA/XM7w+rCsVn0SrsWvBmKh4K53kn0UUWI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=S2LyS1y9ZashlqIsRjMiAqSELTUwbPBKgkjy08MlwQ3FDQGNyNNziVta1KGDnEZc1W+WtzK+IBMNEibbkwDAHVBlQYhnnicWMZGAkUYExkspwUySzOVTdh3aAu57IcCsENXvMbVqqvtaAxi+jbiKKzUoQKHa0OSsvErNzDT9PNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=WShB0RDT; arc=fail smtp.client-ip=40.107.130.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="WShB0RDT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iijn9OV/3hEbS2LeNMnfgXqTvw9zbE7VY5WCvxnuibAmvCNheB3+5oapGmSHgy7QICL2aksBT5VTpuZBybA7s5QAj+/5dgNoDooDLXdDCldB48adomCSxzv152M366kDYDcpOf5Z9dWp3YGl9GbFQRxwgE9E70t/pdHLhTDF7UTH5JsJIzFiddZV96bEQBZj5aNc8KwNRFlxIX54xvSkoGSNX3Y3a8T4arYQ2W4Tef+nYWquJLq9BZWSH4ClaxUEci/HnL1KYT5kjiFhah/BBCAwNmZHEGYC3Fj3TVjvHCNu86ETBS57nPu3d/3QGWdLjvt412queHMSF4xXptl1LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKnd/NrrzMM1L+HbhJfTzGv/GuYL8PflnYH9A3PisGY=;
 b=m1sDws6uhGquPykV7O5Tz4CfuIfEqSfqndStRh4q53134BaSD3Tl3Qong2m5oL4ZQyuzfufa/xqKchbZr1lYkDCVR6A0ENVQpcQzyAXqM3W76XdiJyL8YdvYTAw3f/7Zk1bS9DaX8jRirWdgQwe5Nf3Ds1Op1sHimx6JAUYIuPHiE+jO3xRu7+LHzFpJRtq26F1L/3KDspShSzAXPTvK8gMElwS17cxoJAFTBoJXU+sbeKb5144TlxDx6gb4YQYynJ+Zkx0TE+atFLU2SYJ36UCl+IyLAMBlJ3IYxEgTCxFaQq7lqKfVpBntyx74s/zarRwuIp/rF8NsFPi6a3eM0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.88) smtp.rcpttodomain=oss.nxp.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKnd/NrrzMM1L+HbhJfTzGv/GuYL8PflnYH9A3PisGY=;
 b=WShB0RDT9vr0U0dv03ab4J+KxVmnvi74XvccqsGRjTSInDx9mnBbmTFLU0IHw+IEK8Ja163PYF1dVXJOagr8DrMvD1dJY9yA7kBYPQPbM67Bme/4jfQ6H6oExM4yoq/YpZR0BAlUHjPzRdSs2qzK/JBoNNl3AQfDADDtydf6dCh+s4GWNXLb1wXibj0D5D+ecrweGuSe0Dz6J6ZU4hz+u6uIdMT6se4k4yAfc6ya4rr7SFHRXWez/TYhA62asxgvP3Hoj04HemGf+FERBHWxTEe8bsGl6SAMAbzpru825Hl95cJuqTeAFGPuFDpOgqHbPSMwIjHNRC1NLdwhh0G3SA==
Received: from PR1P264CA0083.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:345::14)
 by VI3PR10MB756752.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:377::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 09:10:57 +0000
Received: from ZR1PEPF0000E6B5.eurprd07.prod.outlook.com
 (2603:10a6:102:345::4) by PR1P264CA0083.outlook.office365.com
 (2603:10a6:102:345::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Fri, 4
 Sep 2026 09:10:57 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.88)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.88 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.88; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.88) by
 ZR1PEPF0000E6B5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 09:10:56 +0000
Received: from ENXDAG1NODE4.st.com (10.75.129.197) by smtpo365.st.com
 (10.250.44.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 4 Sep
 2026 11:08:13 +0200
Received: from [10.48.87.20] (10.48.87.20) by ENXDAG1NODE4.st.com
 (10.75.129.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 4 Sep
 2026 11:10:54 +0200
Message-ID: <a4be2ef7-8987-481a-a329-52c809bbddb3@foss.st.com>
Date: Fri, 4 Sep 2026 11:10:54 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Linux-stm32] [PATCH v2 1/3] dmaengine: vchan: add
 vchan_chan_name() to get channel device name
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
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
CC: <imx@lists.linux.dev>, Frank Li <Frank.Li@nxp.com>,
	<linux-actions@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-mips@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<dmaengine@vger.kernel.org>, <linux-sunxi@lists.linux.dev>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-trace-kernel@vger.kernel.org>
References: <20260903-dma-chan_dev-rename-v2-0-0db305b6c716@nxp.com>
 <20260903-dma-chan_dev-rename-v2-1-0db305b6c716@nxp.com>
 <4e3a2f00-ec1d-426e-b71b-fcd9fabe6b86@foss.st.com>
Content-Language: en-US
In-Reply-To: <4e3a2f00-ec1d-426e-b71b-fcd9fabe6b86@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To ENXDAG1NODE4.st.com
 (10.75.129.197)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR1PEPF0000E6B5:EE_|VI3PR10MB756752:EE_
X-MS-Office365-Filtering-Correlation-Id: 72641aa2-d6b6-4e01-7cc6-08df0a646def
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|7416014|13003099007|921020|22082099003|18002099003|11063799006|56012099006|4143699003|10067099003|41080700001;
X-Microsoft-Antispam-Message-Info:
	hkhJ19OyXulv8Xh99h/xuMwKJ2h0ajYi0fQvNsIIKAZtYsMyhWrOlyN+rJrFxJQMVg7L4MKIhVr4ZnMcnHhgklA6aeRDXyBwhl30hP/KqKAxpK5KZns5fiRCE+5DNArivbwvaTqf6aSDt1E7GZ0/AjjMqkviDpscluExruw88jRybYFZN4+xXvvF6QQMdXTzR9rqnahanb8rkx0KYL1dwNbsjTa4CulG7oFOQtxOQ9HYhhdOn/BLxGnCnvWQnIoByRP3G0Dr8Ybx1bQpoaC+xbzng3EFfqDMaRAf2Iy8lZH2krvsCezNx0ZrDYhp8kIKYa6T6EpICNQexDg7cCxsWXCPJU5FH9BGVpdf84uawvL7XFRGkI7S5Ym3im4tBlWKkOCAFRgQvUpKpk5niE7gVP59v/AVBDcLZI3zD0JicRI7pN1DGBTDQLWhaTvi+YeCB0S7nwhA/lXbOTakh4KUV1cy3ateybqCFVlEkhmfki1hxyFnppbAwdS7ti8qoDeq5zG3OasfdQ330niyOEaw+djiG1NVP1MtAbB4cwsSGR0GEvjVaocMDyQbWiwM5wL/b+/wNMN6Auqk7vphMtZz8+VPorcuu2M+w/yrwdF88a6ThN7OWxnPTc7WtSXgUwGMrNPTyUJR2+PqQR32MDqOd+8VFRI1GIv+UQg7zMDecZbOBwtWuwyWn/QUo86e0DoW
X-Forefront-Antispam-Report:
	CIP:164.130.1.88;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(7416014)(13003099007)(921020)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003)(10067099003)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YYh4pdgkdzU87tRyjQQvuvz20nvXo49VEjT/MveM6K3Cq2IuXuJiYRxvIgOipIqUUYNeXnTPPy4D/HOJSjnsD7Hps3pIJ/iKDU0RI+zwEVn2R6LI4Rfl4MdvpDdyNwJU2G85Zy7Aj6zWfUaeLS9np+uxRvVeusgGuOP2VbOLW/MqbMUZbesBU9rTLk5+toniC4XtsPUE74lVzZFItXUzEKXt4csHttFvKqdQyP8mDAoBLsDkkhMnFdL+IaBS46O9WgezJ3A/eYChK0K7mIkJUpIdAnYIckI3Z+Q7W+vrScCf5vCOf+PcQP8HqJnYPVdQW7mGisCOwKemhB4mjo+naZlvAgNemhapt6DvrSZzXL0g5zMvJNsdtCWIo49BdqvoDWSiYc+HbtLEdKMUV5U2UZtCJLWJwW1V182bob1zhKPfbnE3L4upyvpVW+Lu0Jga
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 09:10:56.6350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72641aa2-d6b6-4e01-7cc6-08df0a646def
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.88];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	ZR1PEPF0000E6B5.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI3PR10MB756752

On 9/4/26 10:35, Amelie Delaunay wrote:
> Hi Frank,
> 
> On 9/3/26 22:53, Frank.Li@oss.nxp.com wrote:
>> From: Frank Li <Frank.Li@nxp.com>
>>
>> Introduce vchan_chan_name() to obtain the DMA channel device name.
>>
>> Use a dedicated helper instead of directly accessing dma_chan::dev
>> so callers remain unaffected by an upcoming rename of the struct member.
>>
>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
>> ---
>>   drivers/dma/arm-dma350.c                     |  2 +-
>>   drivers/dma/loongson/loongson2-apb-cmc-dma.c |  2 +-
>>   drivers/dma/stm32/stm32-dma.c                |  2 +-
>>   drivers/dma/stm32/stm32-dma3.c               |  4 ++--
> 
> Could you move the driver updates from this patch to the next one? I 
> don’t understand why the drivers above are modified here, while others 
> are deferred to "[PATCH v2 2/3] dmaengine: use dma_chan_name() helper to 
> get per-channel device name".
> 

Oh, okay — my bad. I've just looked at v1, and I now understand that you 
split the vchan_chan_name() and dma_chan_name() updates.
I didn’t catch that at first glance because your cover letter hasn’t 
changed between v1 and v2.
"1st patch: use the existing helper dma_chan_name() to reduce rename 
differences.
2nd patch: rename drivers/dma"

> Regards,
> Amelie
> 
>>   drivers/dma/virt-dma.h                       | 11 +++++++++++
>>   5 files changed, 16 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/dma/arm-dma350.c b/drivers/dma/arm-dma350.c
>> index 09403aca8bb06..52f5242ea3327 100644
>> --- a/drivers/dma/arm-dma350.c
>> +++ b/drivers/dma/arm-dma350.c
>> @@ -512,7 +512,7 @@ static int d350_alloc_chan_resources(struct 
>> dma_chan *chan)
>>   {
>>       struct d350_chan *dch = to_d350_chan(chan);
>>       int ret = request_irq(dch->irq, d350_irq, IRQF_SHARED,
>> -                  dev_name(&dch->vc.chan.dev->device), dch);
>> +                  vchan_chan_name(&dch->vc), dch);
>>       if (!ret)
>>           writel_relaxed(CH_INTREN_DONE | CH_INTREN_ERR, dch->base + 
>> CH_INTREN);
>> diff --git a/drivers/dma/loongson/loongson2-apb-cmc-dma.c b/drivers/ 
>> dma/loongson/loongson2-apb-cmc-dma.c
>> index 1c9a542edc859..2f1c8c4fd0654 100644
>> --- a/drivers/dma/loongson/loongson2-apb-cmc-dma.c
>> +++ b/drivers/dma/loongson/loongson2-apb-cmc-dma.c
>> @@ -678,7 +678,7 @@ static int loongson2_cmc_dma_probe(struct 
>> platform_device *pdev)
>>               return lchan->irq;
>>           ret = devm_request_irq(dev, lchan->irq, 
>> loongson2_cmc_dma_chan_irq, IRQF_SHARED,
>> -                       dev_name(chan2dev(lchan)), lchan);
>> +                       vchan_chan_name(&lchan->vchan), lchan);
>>           if (ret)
>>               return ret;
>>       }
>> diff --git a/drivers/dma/stm32/stm32-dma.c b/drivers/dma/stm32/stm32- 
>> dma.c
>> index d3ad78562a140..3e8151e2ad75a 100644
>> --- a/drivers/dma/stm32/stm32-dma.c
>> +++ b/drivers/dma/stm32/stm32-dma.c
>> @@ -1668,7 +1668,7 @@ static int stm32_dma_probe(struct 
>> platform_device *pdev)
>>           ret = devm_request_irq(&pdev->dev, chan->irq,
>>                          stm32_dma_chan_irq, 0,
>> -                       dev_name(chan2dev(chan)), chan);
>> +                       vchan_chan_name(&chan->vchan), chan);
>>           if (ret) {
>>               dev_err(&pdev->dev,
>>                   "request_irq failed with err %d channel %d\n",
>> diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32- 
>> dma3.c
>> index 4724e7fa0008e..1ee1bd22703fb 100644
>> --- a/drivers/dma/stm32/stm32-dma3.c
>> +++ b/drivers/dma/stm32/stm32-dma3.c
>> @@ -1892,10 +1892,10 @@ static int stm32_dma3_probe(struct 
>> platform_device *pdev)
>>           chan->irq = ret;
>>           ret = devm_request_irq(&pdev->dev, chan->irq, 
>> stm32_dma3_chan_irq, 0,
>> -                       dev_name(chan2dev(chan)), chan);
>> +                       vchan_chan_name(&chan->vchan), chan);
>>           if (ret) {
>>               dev_err_probe(&pdev->dev, ret, "Failed to request 
>> channel %s IRQ\n",
>> -                      dev_name(chan2dev(chan)));
>> +                      vchan_chan_name(&chan->vchan));
>>               goto err_clk_disable;
>>           }
>>       }
>> diff --git a/drivers/dma/virt-dma.h b/drivers/dma/virt-dma.h
>> index 59d9eabc8b674..dd023a3831209 100644
>> --- a/drivers/dma/virt-dma.h
>> +++ b/drivers/dma/virt-dma.h
>> @@ -209,6 +209,17 @@ static inline void 
>> vchan_free_chan_resources(struct virt_dma_chan *vc)
>>       vchan_dma_desc_free_list(vc, &head);
>>   }
>> +/**
>> + * vchan_chan_name - Return vchan DMA channel device name
>> + * @vc: virtual channel
>> + *
>> + * Return: The name of the DMA channel device
>> + */
>> +static inline const char *vchan_chan_name(struct virt_dma_chan *vc)
>> +{
>> +    return dma_chan_name(&vc->chan);
>> +}
>> +
>>   /**
>>    * vchan_synchronize() - synchronize callback execution to the 
>> current context
>>    * @vc: virtual channel to synchronize
>>
> 
> _______________________________________________
> Linux-stm32 mailing list
> Linux-stm32@st-md-mailman.stormreply.com
> https://st-md-mailman.stormreply.com/mailman/listinfo/linux-stm32

