Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C96446C848;
	Thu,  3 Sep 2026 21:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788469413; cv=none; b=a1jbLApnUo6vtnbh2/UKKLI/pTpksaHRmW9/pgUZh2PTy+Wifczgn+7NGc+gr7uMLFNY8P8Y+Oa1uq1WJ7xH5ZRw4ccgiQIjuLg40MRRXdRxckz1GbF1n8RKgbKbUp/+ghULT+yMvZNtNes1t6e8ZTiq5Vr9fgTHNb/oTFw0BFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788469413; c=relaxed/simple;
	bh=uGCcg7D6Y68DkTE+be4UHUAHurdqCcDaiY6/nHUvyQs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ihCM4HhWwEW57BnSaE0H2yK6XFn6vY8Xy3+roPd58NWLpV9HWIuxfouAguHHRerA1sbyjbPsL/r+QUsBivyJ798uKZ0q2cLU9tzuurhrSvZbm94uKtjmvEGi2HZiZSA8Uoby2VssKTqIu2VlQNcKGMBxK2GyC17WCOXMQBThGJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOAhxjCS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOAhxjCS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC1891F000E9;
	Thu,  3 Sep 2026 21:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788469404;
	bh=9fPy6AMWggeENC0mYNY8l2+U1qk8DES41DLB1PIhhDQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FOAhxjCSix7HqKSfRX6w0eg/tUONVsUxxA+Qgp3VOo6Bt4B7ROWypfavN21j2l1Fo
	 tiHbSkX7MQDNJEq98Dzkbj4N1vjPbsE39eqTtJ89q9TN2spDmfHS5DP3TmVrTGnvuB
	 J7oHXr8P1Dse9gF6nlVMPx0KXjb9xxoSp8YxqmUDGd4IBARKaMkt4GjtqzgRt7p2GX
	 oYajoyBLYCHS+oHjf/x97/e2iTiW2PXZOPX0p0Tf/wY8n9NBioX2toN08690AaZcTM
	 hlOrLbp6xn75hObqHQLbCIk9REzgzSUoHQ/6R2/RCHxCoi0ZJ2uiJLRXEvQx2Jp/No
	 sRjyK8qIwZ+wg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] dmaengine: vchan: add vchan_chan_name() to get
 channel device name
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: Frank.Li@kernel.org, imx@lists.linux.dev, vkoul@kernel.org, dmaengine@vger.kernel.org, linux-sunxi@lists.linux.dev, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260903-dma-chan_dev-rename-v2-1-0db305b6c716@nxp.com>
References: <20260903-dma-chan_dev-rename-v2-0-0db305b6c716@nxp.com>
 <20260903-dma-chan_dev-rename-v2-1-0db305b6c716@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 21:03:23 +0000
Message-Id: <20260903210323.EC1891F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but there is a preex=
isting Use-After-Free of the channel name string in the IRQ handler registr=
ation on the probe error path.
--

commit 33984ca85ddf2f8f41c22000aad40c8fceb5f946
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: vchan: add vchan_chan_name() to get channel device name

Introduce vchan_chan_name() to obtain the DMA channel device name.
Use a dedicated helper instead of directly accessing dma_chan::dev
so callers remain unaffected by an upcoming rename of the struct member.

[ ... ]

> diff --git a/drivers/dma/stm32/stm32-dma.c b/drivers/dma/stm32/stm32-dma.c
> index d3ad78562a140..3e8151e2ad75a 100644
> --- a/drivers/dma/stm32/stm32-dma.c
> +++ b/drivers/dma/stm32/stm32-dma.c
> @@ -1668,7 +1668,7 @@ static int stm32_dma_probe(struct platform_device *=
pdev)
> =20
>  		ret =3D devm_request_irq(&pdev->dev, chan->irq,
>  				       stm32_dma_chan_irq, 0,
> -				       dev_name(chan2dev(chan)), chan);
> +				       vchan_chan_name(&chan->vchan), chan);

[Severity: High]
This isn't a bug introduced by this patch, but is there a preexisting
Use-After-Free of the channel name string in the IRQ handler registration on
the probe error path?

In stm32_dma_probe(), the driver successfully registers the DMA device using
dma_async_device_register(), then iteratively allocates devres-managed IRQs
using devm_request_irq() with the channel name pointer from vchan_chan_name=
().

If a subsequent operation fails (e.g. of_dma_controller_register()), the er=
ror
handling path manually calls dma_async_device_unregister(dd). This frees the
DMA device and its dynamically allocated channel name string immediately.

However, the devres-managed IRQs remain active until the probe function ret=
urns
and devres cleanup runs. During this window, the IRQ subsystem holds a dang=
ling
pointer to the freed channel name.

Could this race window be triggered by unprivileged users concurrently read=
ing
/proc/interrupts, or if an interrupt fires during this time?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903-dma-chan_d=
ev-rename-v2-0-0db305b6c716@nxp.com?part=3D1
