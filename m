Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C84D3A5433;
	Fri,  4 Sep 2026 22:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788559457; cv=none; b=NAF2oXHhd6Jf6/ltBEIRlDOFn7gZJtIvLty7eSdvu3b6lj6DCsId2YZnnTRj3KliCxktO1Yrv6UC21uYyM+9EuJ3IF4qO6YvNcPdQ8yYllYcIe7oY10ERXwe8G/rdD9psjSNj6QzjMG2ZXh1wWCMBQccai1amFpLxL3sOHQDc78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788559457; c=relaxed/simple;
	bh=6LddOKo6iwGB/fKC5RDLnjF5/4bWFUC5eFZNhQvKyvI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RXscIafjEM5oir1Qn/jvo6uzXqAVQqbIJUiFR56u5oaRFO1FwM3NtOyjCTMXEjnN41JSKqOtWFBa+KPvEP7eH8SUIULwPXM0HKh+7Xd8zUeh0i2jkrNRnfpNTxxUulva8K3qp1qZa5lCKIrFRXN5dyJ0emWf9zpx1+rEKOSF3kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fG+YHILn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fG+YHILn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589911F00A3D;
	Fri,  4 Sep 2026 22:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788559455;
	bh=DJ4sjzcRhC9scvg7Ji+CQKEGwnyrhjsmr8Y6m4CzLPk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fG+YHILnL41NE6vxPuB8rghV3xD/ONpXEsb22PPk3uazjXegpxbhFmkYbRFqUNv4w
	 h8MhxCqtRl7JCvYLJwmZkcEHg0FEJaRIbFjOvc+CzouI5QTlOIOYm3zuqN/YJYo5c/
	 SEk51eNBoG0Us4QtqOIhmI45Hqv3CVBJJAkhsmhK7lj95yr/DLQ1v6ZCTuSb1/j1uB
	 wjR6g5OGSgsGrxlwGPYE1/aP4pUndaQTZrzZ4QyT3nzn83BT4x59G15WvJGDFlMyD7
	 U/rc3H2oAGV1mn6gpv/GPoz2JoxAFWFDQHsydSp4o7ff3P6lGsJr5LYifLyplXY+KY
	 W+lITC13C+2dw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] dmaengine: vchan: add vchan_chan_name() to get
 channel device name
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: imx@lists.linux.dev, vkoul@kernel.org, linux-trace-kernel@vger.kernel.org, Frank.Li@kernel.org, linux-sunxi@lists.linux.dev, dmaengine@vger.kernel.org
In-Reply-To: <20260904-dma-chan_dev-rename-v3-1-685601b0b788@nxp.com>
References: <20260904-dma-chan_dev-rename-v3-0-685601b0b788@nxp.com>
 <20260904-dma-chan_dev-rename-v3-1-685601b0b788@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 22:04:14 +0000
Message-Id: <20260904220415.589911F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Inverted devres teardown order in stm32_dma_probe error path cause=
s a Use-After-Free of the DMA channel name.
--

commit 7119ae3e70ddf3efdd1474a7d8b5fbb1ec66bf04
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: vchan: add vchan_chan_name() to get channel device name

This commit introduces the vchan_chan_name() helper to obtain the DMA chann=
el
device name. It updates various drivers to use this helper instead of direc=
tly
accessing dma_chan::dev, ensuring they remain unaffected by upcoming struct
member renames.

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
This isn't a bug introduced by this patch, but is it possible this exposes a
pre-existing use-after-free of the DMA channel name in the probe error path?

The dynamically allocated name from vchan_chan_name() is passed to
devm_request_irq(), binding the IRQ action's name pointer to the string.
If stm32_dma_probe() fails later (for example, if of_dma_controller_registe=
r()
fails), it jumps to the error label:

err_unregister:
	dma_async_device_unregister(dd);
clk_free:
	clk_disable_unprepare(dmadev->clk);

Calling dma_async_device_unregister() here manually frees the DMA channels
and their associated kobject names. However, because the IRQs were requested
using devm_request_irq(), they remain active and are not freed until later
when the probe function returns and devres unwinds.

Could this inverted teardown sequence create a window where the IRQ subsyst=
em
holds a dangling pointer to the freed name string, potentially leading to
memory corruption or a kernel oops if /proc/interrupts is read?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-dma-chan_d=
ev-rename-v3-0-685601b0b788@nxp.com?part=3D1
