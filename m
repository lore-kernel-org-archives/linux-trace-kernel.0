Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E566448B9A;
	Thu,  3 Sep 2026 21:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788469426; cv=none; b=rVCk0SQyVGCkyN+fJvIA12IuJv+r6JFUpFbcchvlu80zg6ZTdXpifS6p7gTlCUmIQlsfYN6Q1/ApOlhL4J708j4+T7/8K5mIMSvybZBHhMxuv5L/FoJszwz4hGZL7MMxrHniwtxLmxqHIk3xe60FWGKidMpZTGtzSuckVqVPYzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788469426; c=relaxed/simple;
	bh=zO7XkX/IBu2M0T+EEwFFClogJ700KsT8LN/v70d1GEM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RDA8AsXLgA8KOMPEvnU3kePSkjgbfQmQMS600nDxMwkVUq2GN7RXdetXWkAVuDgog++o+0JJqUzaouK3XFagTN3cpJCioonx7nYXxy4kTw5SaDd7rAVh9aMNxzj6/fY+1KVJ6QUGsw78lsYG3hIuUjF8laIhlso7FSUzmwWj3LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S22ioQ0H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S22ioQ0H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121171F000E9;
	Thu,  3 Sep 2026 21:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788469415;
	bh=+YYXGNTuce4x39+daTCOq+spB2eBgkILUHrCTw2GJbk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S22ioQ0HxlTFgdprjZ2+G6+ywfjaJo8FZW/NZqfFucuzMRxnUbBOrR50xiC3ucleW
	 bVhlBfVMiX+VuLGBwcsmBiOoMJ43GHj90LDTMy9NzEdqh8aiB2Y/wfpnqY6JEuzJW6
	 0In8nyyElWHU4N4z8bTWgSAOZiTcjlYikNYel2az5ry5hrF7h9bJtbNTIec4zqSgO1
	 /CxlgBpWd0Wiw0Ft4fyVzWzpT3vXvrLtu0TKwHYHR209PCOPHpSEX5mBCd5RK+muQF
	 OeM3SFmX08lQ0if4jKnNrBoP5TykHeXQlAjGFYAGTNhlTwKxQUweT5WEem/H4KzO75
	 6lXNllo1RIV2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] dmaengine: add union chan_dev for dma_chan::dev
 for clarity
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: linux-trace-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev, vkoul@kernel.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20260903-dma-chan_dev-rename-v2-3-0db305b6c716@nxp.com>
References: <20260903-dma-chan_dev-rename-v2-0-0db305b6c716@nxp.com>
 <20260903-dma-chan_dev-rename-v2-3-0db305b6c716@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 21:03:34 +0000
Message-Id: <20260903210335.121171F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Improper cleanup on `device_register()` failure leads to memory le=
aks and potential Use-After-Free.
- [High] Missing `ida_free()` in the error teardown path of `dma_async_devi=
ce_register()` leads to permanent leakage of the device ID and successfully=
 registered channel IDs.
- [High] Channel devices are modified after they have been globally registe=
red and exposed to the system.
--

commit bdff887fbc44608c64e51be1b2c615d4ee5aaa43
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: add union chan_dev for dma_chan::dev for clarity

This commit introduces a union chan_dev in the dma_chan structure to
explicitly separate the per-channel device from the DMA engine device. It
updates various DMA drivers to use chan_dev instead of dev to improve
clarity, with no intended functional changes.

> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 6ffd8bd82154a..c00641366c4dc 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c

[ ... ]

> @@ -1122,7 +1122,7 @@ static int __dma_async_device_channel_register(stru=
ct dma_device *device,
>   err_out_ida:
>  	ida_free(&device->chan_ida, chan->chan_id);
>   err_free_dev:
> -	kfree(chan->dev);
> +	kfree(chan->chan_dev);
>   err_free_local:
>  	free_percpu(chan->local);

[Severity: High]
This isn't a bug introduced by this patch, but does this error path properly
surrender the device reference?

If device_register() fails earlier in __dma_async_device_channel_register(),
the driver core API requires calling put_device() to surrender the initiali=
zed
reference.

Instead, the error path jumps to err_free_dev and directly calls kfree() on
the structure. Can this leak resources allocated during initialization, such
as the device name string, or risk a use-after-free if other subsystems
obtained a temporary reference?

[ ... ]

> @@ -1290,9 +1290,9 @@ int dma_async_device_register(struct dma_device *de=
vice)
>  		if (chan->local =3D=3D NULL)
>  			continue;
>  		mutex_lock(&dma_list_mutex);
> -		chan->dev->chan =3D NULL;
> +		chan->chan_dev->chan =3D NULL;
>  		mutex_unlock(&dma_list_mutex);
> -		device_unregister(&chan->dev->device);
> +		device_unregister(&chan->chan_dev->device);
>  		free_percpu(chan->local);
>  	}
>  	return rc;

[Severity: High]
This is a pre-existing issue, but does the error teardown path in
dma_async_device_register() completely release the IDAs?

If channel registration fails after registering at least one channel, the
error path triggers with device->chancnt > 0. This bypasses the earlier blo=
ck
that calls ida_free(&dma_ida, device->dev_id).

Furthermore, this loop unregisters previously successful channels but appea=
rs
to miss calling ida_free(&device->chan_ida, chan->chan_id). Might this
permanently leak the device ID and successfully registered channel IDs?

> diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dm=
a.c
> index 64cedef1050ae..e36111e8a76dc 100644
> --- a/drivers/dma/tegra186-gpc-dma.c
> +++ b/drivers/dma/tegra186-gpc-dma.c
> @@ -1537,7 +1537,7 @@ static int tegra_dma_probe(struct platform_device *=
pdev)
>  	 * the channels available and registered for the DMA device are used.
>  	 */
>  	list_for_each_entry(chan, &tdma->dma_dev.channels, device_node) {
> -		chdev =3D &chan->dev->device;
> +		chdev =3D &chan->chan_dev->device;
>  		tdc =3D to_tegra_dma_chan(chan);
> =20
>  		if (use_iommu_map) {

[Severity: High]
This is a pre-existing issue, but is it safe to modify fundamental device
properties after the device has already been published to the system?

In tegra_dma_probe(), dmaenginem_async_device_register() is called prior to
this loop, which globally registers the channel devices via device_register=
().

Here in the loop, when the devices are already visible to sysfs, udev, and
the driver core, chdev->bus is modified and the IOMMU is configured. Could
this create a race condition where the driver core or userspace might
interact with a partially initialized device?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903-dma-chan_d=
ev-rename-v2-0-0db305b6c716@nxp.com?part=3D3
