Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1012A43B6F5;
	Fri,  4 Sep 2026 21:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788559122; cv=none; b=dXYDQD5NrLzaaFbmWsjyPm6m8atxuvHh4X9ZeH44yfkWJ9S4x5TVOTVwPATQtBmqmzAt2+8WiLqJrgsszVYDx6lmntt0IsjSs78ROEjxR7N8ofNfMsHxzvtonyxRBNve5zFJq4ez5xjXvG2lAh0fn+868HvRIfUT88f9+Q2/Vbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788559122; c=relaxed/simple;
	bh=at8CIRZ0TNBVpctp8dT90vBugok053GV4sw0O8B29QE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ikg09ESgpiEWCyI/Z84b0lttTrRqmXN5TDTlNkWUfoctg3FBhJSY3E01m9Vg9hgFaGfWfFpPBCBglgU8QmSq3vTU4Wj1aZQkNWyz44m2LRH6sNiO3Jzq7Xsxm4sG1ILWNFlx4QnYFJwZrCCh1Z7s+X5X+MMA8Gd/CUG8Veob2CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpKUck+N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpKUck+N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB4601F00A3D;
	Fri,  4 Sep 2026 21:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788559116;
	bh=P3XEYP2Kj9qLv57nmXAVEL7Jr+Q9ZqbVqPeyqeUWlI0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kpKUck+N2fwby+5laqfz5//Z2TjsJOLhJCf0BlI47ANcsEx+kXLtskEqKIu4jjNBT
	 O3qImJCOZTx3DzMAhZ79TtciIDK5UqMG8od/L1ajK2cYsaWhf+DnEtGrz68tkpMdi+
	 KM4ydGHo+n+nqjA150VuhLbWCXNBHM0E4Sxi9JKxmAKrboBfeTNhrSjZSLbtVa1Lbu
	 ClYpHPZc6tltwSW2kyij2BCY5vC602ytoU7WZhNpaBsQtIeaf1GSdxWd7+B/2OgfBY
	 VRB23WzQ2ZROdZZap8A2yZylyVKuUWJbzrzsPUHILBDANU7IrzuRAYcCcWzFjfLPMT
	 3M6k1jzK/JITQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] dmaengine: use dma_chan_name() helper to get
 per-channel device name
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, imx@lists.linux.dev, Frank.Li@kernel.org, linux-trace-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20260904-dma-chan_dev-rename-v3-2-685601b0b788@nxp.com>
References: <20260904-dma-chan_dev-rename-v3-0-685601b0b788@nxp.com>
 <20260904-dma-chan_dev-rename-v3-2-685601b0b788@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 21:58:35 +0000
Message-Id: <20260904215835.CB4601F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing tasklet_kill() in driver removal path leads to Use-After-F=
ree.
- [High] Devres pool leak in error path of channel resource allocation.
--

commit 46c4d3dece5bd1126d02c64f04aca18a9510a860
Author: Frank Li <Frank.Li@nxp.com>
dmaengine: use dma_chan_name() helper to get per-channel device name

This patch updates several DMA engine drivers to use the dma_chan_name() he=
lper
instead of open-coding the channel name logic. This improves consistency and
simplifies the code across the subsystem.

[ ... ]

> diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
> index 386e85cd4882a..6b29e15b0616c 100644
> --- a/drivers/dma/mmp_pdma.c
> +++ b/drivers/dma/mmp_pdma.c
> @@ -565,7 +565,7 @@ static int mmp_pdma_alloc_chan_resources(struct dma_c=
han *dchan)
>  	if (chan->desc_pool)
>  		return 1;
> =20
> -	chan->desc_pool =3D dma_pool_create(dev_name(&dchan->dev->device),
> +	chan->desc_pool =3D dma_pool_create(dma_chan_name(dchan),
>  					  chan->dev,
>  					  sizeof(struct mmp_pdma_desc_sw),
>  					  __alignof__(struct mmp_pdma_desc_sw),

[Severity: High]
This is a pre-existing issue, but while reviewing this file's DMA resource
management, I noticed a potential use-after-free during driver unbind.

In mmp_pdma_chan_init(), a tasklet is initialized for each DMA channel using
tasklet_setup(&chan->tasklet, dma_do_tasklet), and the channel structures a=
re
allocated via devm_kzalloc().

However, mmp_pdma_remove() unregisters the DMA engine but does not call
tasklet_kill() to cancel pending tasklets. Because there is no explicit
teardown of the tasklets, will pending or executing tasklets continue runni=
ng
after devres automatically frees the channel memory, resulting in a
use-after-free if the driver is unbound while a tasklet is scheduled?

[ ... ]

> diff --git a/drivers/dma/stm32/stm32-mdma.c b/drivers/dma/stm32/stm32-mdm=
a.c
> index e3bbdc9ee36ed..c274638e919c2 100644
> --- a/drivers/dma/stm32/stm32-mdma.c
> +++ b/drivers/dma/stm32/stm32-mdma.c
> @@ -1484,7 +1484,7 @@ static int stm32_mdma_alloc_chan_resources(struct d=
ma_chan *c)
>  	struct stm32_mdma_device *dmadev =3D stm32_mdma_get_dev(chan);
>  	int ret;
> =20
> -	chan->desc_pool =3D dmam_pool_create(dev_name(&c->dev->device),
> +	chan->desc_pool =3D dmam_pool_create(dma_chan_name(c),
>  					   c->device->dev,
>  					   sizeof(struct stm32_mdma_hwdesc),
>  					  __alignof__(struct stm32_mdma_hwdesc),

[Severity: High]
This isn't a bug introduced by this patch, but looking at the error handling
path immediately following this pool creation, is there a devres leak here?

When dmam_pool_create() is called, it binds the devres release action to the
DMA controller device (c->device->dev), rather than the channel lifecycle.

If the subsequent pm_runtime_resume_and_get() call or stm32_mdma_disable_ch=
an()
fail, stm32_mdma_alloc_chan_resources() returns an error without destroying
the newly allocated pool via dmam_pool_destroy().

Since the DMA engine core assumes the allocation function cleans up after
itself on failure, will repeated allocation failures endlessly leak devres =
pool
entries and memory on the controller device until the driver is unloaded?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-dma-chan_d=
ev-rename-v3-0-685601b0b788@nxp.com?part=3D2
