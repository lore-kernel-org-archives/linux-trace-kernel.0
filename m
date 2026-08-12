Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4BA2C027C;
	Wed, 12 Aug 2026 21:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786570446; cv=none; b=HdZVDxOaVQrxZKlHjMjdg3FR7jxbbb13UAbN/+1hw3bbFTSbsKrbut5lVExJXZtcnX9cUTmQ29Gk1kn9qmy8lGZoikTIvMDkRb8tMP2RDEnIib7d0FoU/3SvsadOJhX1JFIJwe4PfSuVFk52Wcr+X9yTbIm3JUYYtpBeEJBU/Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786570446; c=relaxed/simple;
	bh=dUhSg0IsMZzJIfbQxV82dJH/WN6upfByT6vGanZCpIg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CoMK4JuXaAGj/cDWxAtrBs7vEe82ow4J9HHCUfAG9iDu7OckXCqyPNcLVbkkE1jT4DNB8ObHkuHLW/4puX52iNXW7pDTeA640qd3eoJb10EiOMLXc8NOVIBzx+/wEBjM6H6D7bm4vicCv5btISCiClIl1vEz9mGfeFZz0MmkJhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LR6MI+uf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LR6MI+uf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B7D1F000E9;
	Wed, 12 Aug 2026 21:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786570444;
	bh=yc2VR9c/cg6mEtckhXeWdQEyiYWA9hMIUnd9LWPGWRo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LR6MI+ufbDbkzbI5zC0ng9Ql+pFoGPy+foqUUc2AJ2ePsmm36tqqA6nvXzGWy08A6
	 hkLjx6p6yN+aoW+U9Cb3ysBVDbBlJRkaDNaMxOdkXq9XNtKn7UjRV6/XS6t/cY80SR
	 I2i0kQLyqcCIZoKrUCD//q2wj88/hjD8o8PgkKyv9QM1Sv+xn7euoOLYfVO+0HCq7f
	 VRP/Npg/xkkcxw+jscTFWHHN8B0ah5+x0oH2U5BMWgUqSKamnqnPFC6ez+vS7Z5id9
	 NsG1NMOFbRKr/29JDqtGH3cX05eWSrveChQcsNl/ZWxReY4A1EMJMHHQNIY/scb2Mx
	 /nf2UJ/4s1dQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] dmaengine: use dma_chan_name() helper to get
 per-channel device name
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: imx@lists.linux.dev, Frank.Li@kernel.org, vkoul@kernel.org, linux-trace-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, dmaengine@vger.kernel.org
In-Reply-To: <20260812-dma-chan_dev-rename-v1-1-a67131f7d5c2@nxp.com>
References: <20260812-dma-chan_dev-rename-v1-0-a67131f7d5c2@nxp.com>
 <20260812-dma-chan_dev-rename-v1-1-a67131f7d5c2@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 21:34:03 +0000
Message-Id: <20260812213404.72B7D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Probe error path prematurely frees DMA channel structures and disa=
bles clocks before devm-managed IRQs are freed, leading to a Use-After-Free=
 and potential bus hang.
--

--- Patch [1]: [PATCH 1/2] dmaengine: use dma_chan_name() helper to get per=
-channel device name ---
commit 77ba32b52a0d71c14db9e5276f81ba0fa2896131
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: use dma_chan_name() helper to get per-channel device name

This patch uses the existing dma_chan_name() helper to obtain the
per-channel device name instead of open-coding it. This simplifies the
code and improves consistency.

[ ... ]

> diff --git a/drivers/dma/stm32/stm32-dma.c b/drivers/dma/stm32/stm32-dma.c
> index d3ad78562a140..4e3ecb6763036 100644
> --- a/drivers/dma/stm32/stm32-dma.c
> +++ b/drivers/dma/stm32/stm32-dma.c
> @@ -1668,7 +1668,7 @@ static int stm32_dma_probe(struct platform_device *=
pdev)
> =20
>  		ret =3D devm_request_irq(&pdev->dev, chan->irq,
>  				       stm32_dma_chan_irq, 0,
> -				       dev_name(chan2dev(chan)), chan);
> +				       dma_chan_name(&chan->vchan.chan), chan);

[Severity: High]
This is a pre-existing issue and was not introduced by the patch under
review, but doesn't the error path in stm32_dma_probe() in
drivers/dma/stm32/stm32-dma.c prematurely free DMA channel structures and
disable clocks before the devm-managed IRQs are freed?

In stm32_dma_probe(), IRQs are requested using devm_request_irq() and
passed dma_chan_name(&chan->vchan.chan) as the action name.

If a subsequent initialization step fails, the error path manually calls
dma_async_device_unregister(dd):

err_unregister:
	dma_async_device_unregister(dd);
clk_free:
	clk_disable_unprepare(dmadev->clk);

	return ret;

This frees the channel device structures, including the embedded name
string, and clk_disable_unprepare(dmadev->clk) stops the hardware clock.

Because the IRQs are devres-managed, they remain active until the probe
function returns and the devres framework unwinds. During this window, if
/proc/interrupts is read, the kernel accesses the freed action->name
string, potentially triggering a Use-After-Free.

Furthermore, if a spurious interrupt fires during this window, the handler
stm32_dma_chan_irq() will read hardware registers with the device clock
disabled, which could trigger a Data Abort kernel panic.

>  		if (ret) {
>  			dev_err(&pdev->dev,
>  				"request_irq failed with err %d channel %d\n",

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-dma-chan_d=
ev-rename-v1-0-a67131f7d5c2@nxp.com?part=3D1
