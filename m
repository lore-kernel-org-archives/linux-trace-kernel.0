Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A278F35E1B8;
	Fri,  4 Sep 2026 22:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788559293; cv=none; b=P3JGZeiPKn6YkLnLfzI2GyRHnIcomT6NtKQqa1xmzq89bVQ5D2lYGqULPmqq27eRTVenejjFs0IAODoaTh8js4hC/MbOyBYEcK4M+uyroAF6pewyzpTWv+soumugvs2nd52LPiG4b/MURmcfWgcFzTBN5vPTZtqEozFHF2Y8umM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788559293; c=relaxed/simple;
	bh=vHNoLk2zJSm35IC0+3iIo8WY333/NscunDJQKlumXyU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rIcNYzndqeAhHRl4h1dE35/kRiFCMDN9YS2JnihpCZhRS7QvCTDw7RksGkvEsLG3xeEGZBJ/1SqdcqukaHMOL+5HVMQzzGgJYdxGb6jgCArgROFP48lxrCNQFnmCG0wy77dbeczc92lk5gTQaKLJtV9cql2BG5slZ6Bm/P9GEV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTj53qZr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTj53qZr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C0A71F00A3D;
	Fri,  4 Sep 2026 22:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788559287;
	bh=Cz2kXaJ4DnWPyb/HwFM4psXPdhuGHHP/ewJJjuWfhLs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jTj53qZrVZDlXDSyejJlL6N5P5Rd9DmWVMhPPFvANsaV/0SqnKvWbLt0soyr+D7dh
	 EnISS8DgAC8D9ky8BGWBH1q/jPISiWYfbmWBIRVkrwpy6vShkSbSbAWglTog6/x1Fo
	 MiB/7uacxMqE8U+4nWlOxPuG5MFzX/+bBmQ1Yaq75h3Pp/1PEqNmUDZQ1WMbX0YmK6
	 +5n9xNEtUaWWOMxCOT0uYhX/5PmXb4/6T++7GJn4Z3adrR4irAEyxwksu6K4HP0Fbg
	 oDNyqvf1QryqPRfX3TgB7nER/C1K1y2VCryc+G0O4+hQvssU5qcHwK1ydtTQjtMH+/
	 cR0Bn9dSHF54Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] dmaengine: add union chan_dev for dma_chan::dev
 for clarity
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: linux-sunxi@lists.linux.dev, Frank.Li@kernel.org, vkoul@kernel.org, imx@lists.linux.dev, dmaengine@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260904-dma-chan_dev-rename-v3-4-685601b0b788@nxp.com>
References: <20260904-dma-chan_dev-rename-v3-0-685601b0b788@nxp.com>
 <20260904-dma-chan_dev-rename-v3-4-685601b0b788@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 22:01:27 +0000
Message-Id: <20260904220127.7C0A71F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing put_device() on device_register() failure leads to resourc=
e leak and potential Use-After-Free.
- [High] Modifying device bus after registration circumvents the device cor=
e lifecycle and causes mismatched bus notifications.
- [High] Missing synchronize_rcu() in DMA device unregistration path leads =
to Use-After-Free in dma_issue_pending_all().
--

commit 99f7cae9d62138cb68f0b59f43bd77ab9e9bb860
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: add union chan_dev for dma_chan::dev for clarity

The current dma_chan structure contains both "device" and "dev", which
increases reader confusion. Add union dma_chan::chan_dev to make its
purpose explicit and clearly identify it as the per-channel device.

> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index a7ac2729e4d9d..bb30a9aa54d3f 100644
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

[Severity: High]
This is a pre-existing issue, but is it correct to use kfree() directly on =
the
device structure here instead of put_device() after device_register() fails?

In __dma_async_device_channel_register(), if device_register() fails (e.g.
due to memory pressure or name collision), the error path jumps to
err_free_dev. Using kfree() directly circumvents the device core reference
counting.

Does this leak the device structure's associated resources, such as its
allocated name? Also, if the device's kobject was already linked into sysfs
ksets, can this lead to a Use-After-Free?

[ ... ]

> diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dm=
a.c
> index b3327aa35de40..e76c58f213d84 100644
> --- a/drivers/dma/tegra186-gpc-dma.c
> +++ b/drivers/dma/tegra186-gpc-dma.c
> @@ -1554,7 +1554,7 @@ static int tegra_dma_probe(struct platform_device *=
pdev)
>  				return dev_err_probe(chdev, -EINVAL,
>  					   "Failed to get stream ID for channel %d\n", tdc->id);
> =20
> -			chan->dev->chan_dma_dev =3D true;
> +			chan->chan_dev->chan_dma_dev =3D true;
>  		}

[Severity: High]
This is a pre-existing issue, but does modifying the device bus after
registration circumvent the device core lifecycle and cause mismatched bus
notifications?

During device probe in tegra_dma_probe(), the channels are registered via
dmaenginem_async_device_register(), and then chdev->bus =3D pdev->dev.bus
is set manually in this use_iommu_map block:

drivers/dma/tegra186-gpc-dma.c:tegra_dma_probe() {
    ...
		if (use_iommu_map) {
			chdev->bus =3D pdev->dev.bus;
    ...
}

Does bypassing bus_add_device() during initialization but later triggering
bus_remove_device() on teardown lead to missing add notifications? During
driver unbind or probe rollback, device_del() sees the non-NULL bus and bli=
ndly
triggers bus_remove_device(). Can this crash or corrupt listeners such as t=
he
IOMMU subsystem that expect properly ordered device lifecycle notifications?

While reviewing this patch, I also noticed a pre-existing issue in
drivers/dma/dmaengine.c that isn't directly touched by this commit:

[Severity: High]
This is a pre-existing issue, but can the missing synchronize_rcu() in the
DMA device unregistration path lead to a Use-After-Free in
dma_issue_pending_all()?

When a DMA controller is unbound, dma_async_device_unregister() puts the
device reference. Then dma_device_release() unlinks the device using
list_del_rcu(&device->global_node) but fails to wait for an RCU grace period
before allowing devres to automatically free the backing memory:

drivers/dma/dmaengine.c:dma_device_release() {
    ...
	list_del_rcu(&device->global_node);
	dma_channel_rebalance();
    ...
}

Concurrently, the RCU reader iterates over the list in dma_issue_pending_al=
l()
and accesses the freed device memory:

drivers/dma/dmaengine.c:dma_issue_pending_all() {
    ...
	list_for_each_entry_rcu(device, &dma_device_list, global_node) {
		if (dma_has_cap(DMA_PRIVATE, device->cap_mask))
    ...
}

Could concurrent RCU readers dereferencing the freed device pointer here
experience memory corruption or a kernel panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-dma-chan_d=
ev-rename-v3-0-685601b0b788@nxp.com?part=3D4
