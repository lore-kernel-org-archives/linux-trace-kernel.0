Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C712155D865;
	Wed,  9 Sep 2026 16:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788971803; cv=none; b=uZBPMifcqjqNPRjVIDlQKsBLK77D79/e7QeTgdf9bciLVwgaxsLGeZdx9lKsDDQU5qQG+QSSJRUDDzny151R5iKHaZ45XLywwtqi9j3PmBdexefWnPTekeR4cPnPUQOnelIG3Nz9p63yFtDLVfnQx5JU6Qw+ug2ee+8xoyIgDMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788971803; c=relaxed/simple;
	bh=ivQODqGc8KFRbT+CDhnacTUmIisuYelCOQ7C8DxNKCM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j2uIUfN4r9fEKL1vK8q0P/sfasC170plCnZGFVgaByDwi+e3aszxCDQzvLZaIi3hviI2MOZtNLhVI6deBcXAzIycyRH6h9O1gxkT53SiB/dy/XM+v6dly3axnvJ9sLHEoYlknSDu/bW6xlImtzgFG1HiOjWMiAJ/pVgxiK0LWD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dx70I1I+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dx70I1I+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E26281F00893;
	Wed,  9 Sep 2026 16:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788971801;
	bh=nDQ3BlVROek4PxaLywwCvD6/LeA/synqwhaOMOah7lE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dx70I1I+8UJyr/VBOxcjZH9n5kihC+kb27i9VnPrDp1ipyea5JH6DRYBTXNJ3aHJY
	 tK/lTlLld6Mvv7CaO7FT8M6c5n1GYf9rlDfs9yhitsA/IXKiamVj7l1M3n8UHZJ5IL
	 m7z4Moz1bEehf5qcj1SHdImqffS1Cu1dM14AYN4P9z184AZ+ga7ltA5bZ1z3wI57G4
	 EeU31nzGMeRyayLgVWtVu4tewA7jtJa5PaPmpdPh8+X2MyFDHES2XPpzl75tdtpAMC
	 vqtNyPXNE76OqzpHTp0UaEJFZjHyS0j1zW12o+fRCKt/82SUkmevuYH1JhPAXvRx1u
	 xAViDSWb1GEHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/4] dmaengine: vchan: add vchan_chan_name() to get
 channel device name
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: linux-sunxi@lists.linux.dev, imx@lists.linux.dev, linux-trace-kernel@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260909-dma-chan_dev-rename-v4-1-d8fb6892a70f@nxp.com>
References: <20260909-dma-chan_dev-rename-v4-0-d8fb6892a70f@nxp.com>
 <20260909-dma-chan_dev-rename-v4-1-d8fb6892a70f@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 16:36:40 +0000
Message-Id: <20260909163640.E26281F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free of DMA channel name in probe error path due to devm=
/manual cleanup mismatch
--

commit 6477701933e50dc5df4ddb73cea43b46ef1b83f8
Author: Frank Li <Frank.Li@nxp.com>

    dmaengine: vchan: add vchan_chan_name() to get channel device name
   =20
    Introduce vchan_chan_name() to obtain the DMA channel device name.
   =20
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
>  		if (ret) {
>  			dev_err(&pdev->dev,
>  				"request_irq failed with err %d channel %d\n",

[Severity: High]
This is a pre-existing issue, but in drivers/dma/stm32/stm32-dma.c at
stm32_dma_probe(), devm_request_irq() stores the dynamically allocated DMA
channel name (vchan_chan_name()) as the IRQ name.

If a subsequent initialization step fails, such as a failure in
of_dma_controller_register(), the code jumps to err_unregister:

drivers/dma/stm32/stm32-dma.c:stm32_dma_probe() {
    ...
err_unregister:
	dma_async_device_unregister(dd);
    ...
}

Because dma_async_device_unregister() is called manually, it frees the DMA
device and its associated channel name string immediately. However, since t=
he
IRQ is managed by devm, its cleanup is deferred until devres runs after pro=
be
returns.

Could this create a use-after-free window where the IRQ subsystem retains a
dangling pointer to the freed string? If an interrupt fires or if a user
reads /proc/interrupts concurrently during this window, could this lead to =
an
oops or memory corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-dma-chan_d=
ev-rename-v4-0-d8fb6892a70f@nxp.com?part=3D1
