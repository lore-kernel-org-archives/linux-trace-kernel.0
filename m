Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E3C42E43B;
	Thu,  3 Sep 2026 21:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788469516; cv=none; b=ax8iI7AiKcuTqMrwiVcCAf+jEh4UvTcT0OaABu8wedge4+mrIgPpYj3uh9mSaHS2+rYKK9RvANP89x+iq6zvSbMPVWdOVOrzAEuLVFO42rgJQ5fyqDYgLRPb4oDsrQ4grO1VjG7VdExdWfeHeFyAUC5wk0Sa+Jrqmt+MfPvrvJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788469516; c=relaxed/simple;
	bh=h6aU+GI/NNBMe45yjlTzbFuwmdjgMJ/60CUJrOHFlxM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XjWbQ5MrVoaWw46UMtzU4g9naxP55ZQwFnMygNfOM9Ng8beRezQJhzSSG/tkTqIoskNa/yXkNmZ9kn+kkDo4DPVuAKIbr7CJvdVAmD0btsKc2KZLyYF5EBbdXPc3q0EiaT8W8t0RwR+6r7H8iCZldhts69krW92QbsuYsQQAyRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SN0VQquj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SN0VQquj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6571A1F000E9;
	Thu,  3 Sep 2026 21:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788469512;
	bh=uPGbhKaL9I8pugMbLO9ZOWj7e7M7/4AZuGgPzXdmBSw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SN0VQquj1q5kPtEp0guv3Z4pENUbTCd6qb1p1PE97EN2KPDVXzuOhQ7gC2eXngpwa
	 sY6vITh63TURz4Q16b0lkZGezxnYRgE7WicPMCM6kU3aQ6s7f/2bsf0rC0CSdsa5uc
	 1ILIb5PH0xdHTimeYSM/ms4k8P66cQ7YfBgFVYNjrX9p0Tl2cpvQeAiyLWnSdyMV3y
	 Y9ivPwapNl1iSR/cHUpQsd9k5yqXV3zBXWoWjtHTR3iwMT/oKnBcpoCxbe/7yWCsSK
	 NvrmJ7yIX8eSuxnaSro4TUM1pCgf9NDA6sguKsTq9CqIW/CQ1TopkID/eHOJwIGkuL
	 r01gGCXNSvxRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] dmaengine: use dma_chan_name() helper to get
 per-channel device name
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: imx@lists.linux.dev, linux-sunxi@lists.linux.dev, linux-trace-kernel@vger.kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260903-dma-chan_dev-rename-v2-2-0db305b6c716@nxp.com>
References: <20260903-dma-chan_dev-rename-v2-0-0db305b6c716@nxp.com>
 <20260903-dma-chan_dev-rename-v2-2-0db305b6c716@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 21:05:12 +0000
Message-Id: <20260903210512.6571A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Tasklets created for DMA channels are not killed during driver rem=
oval, risking use-after-free panics if scheduled after devm allocations are=
 freed.
--

commit fe57b7262d586b3f961d1d34cf7a9a0acf70d3c7
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: use dma_chan_name() helper to get per-channel device name

This commit updates various DMA engine drivers to use the existing
dma_chan_name() helper instead of open-coding the per-channel device name
retrieval. The change simplifies the code and improves consistency across
the subsystem without altering functionality.

[ ... ]

> diff --git a/drivers/dma/loongson/loongson2-apb-dma.c b/drivers/dma/loong=
son/loongson2-apb-dma.c
> index aceb069e71fca..7c3d7c3273955 100644
> --- a/drivers/dma/loongson/loongson2-apb-dma.c
> +++ b/drivers/dma/loongson/loongson2-apb-dma.c
> @@ -282,7 +282,7 @@ static int ls2x_dma_alloc_chan_resources(struct dma_c=
han *chan)
>  	struct ls2x_dma_chan *lchan =3D to_ldma_chan(chan);
> =20
>  	/* Create a pool of consistent memory blocks for hardware descriptors */
> -	lchan->pool =3D dma_pool_create(dev_name(chan2dev(chan)),
> +	lchan->pool =3D dma_pool_create(dma_chan_name(chan),
>  				      chan->device->dev, PAGE_SIZE,
>  				      __alignof__(struct ls2x_dma_hw_desc), 0);
>  	if (!lchan->pool) {

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a pre-existing
issue in ls2x_dma_remove() missing tasklet cleanup.

Should ls2x_dma_remove() iterate over the channels and call
tasklet_kill(&chan->vchan.task) before returning?

The driver relies on devm allocations for channel memory, which are
automatically freed immediately after remove() completes. If the DMA driver
is unbound shortly after an interrupt fires, the interrupt handler schedules
the channel's tasklet. If this scheduled tasklet executes after the memory
is freed, can it dereference invalid memory and cause a use-after-free
panic?

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
This isn't a bug introduced by this patch, but there appears to be a similar
pre-existing issue in mmp_pdma_remove().

Does mmp_pdma_remove() also need a loop over the channels to call
tasklet_kill(&chan->tasklet)?

Like the Loongson driver, this driver also uses devm allocations for
channel structures and could experience a use-after-free panic if a tasklet
runs after mmp_pdma_remove() finishes and the memory is freed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903-dma-chan_d=
ev-rename-v2-0-0db305b6c716@nxp.com?part=3D2
