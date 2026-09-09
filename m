Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471A557C9F;
	Wed,  9 Sep 2026 05:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788931390; cv=none; b=FJblEErXb+lcmRb3y8u16PbuofKh7RqzXzYuRNtLSI8Oos38eljqEUuN5J6e/s4rKa4/Zp2nfvaqAk0Wl1C9vnp4kInfMKYdWXToaPcEHKbTNyU3QmxElD5QcJo30xBhN+6K6nyLwbBK3imWp+U276ZVfnG4Bnh9OGJYJXldlkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788931390; c=relaxed/simple;
	bh=m3VyOJdfEt4CBBiIc/oklURgJpvvE8vpsqAJdcPDoME=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UWvKsrpiQ6Jtryb+Lozga0F/fTfSNeIXz6CdlqTGjJ8D+Wej0diN+rX/OXX+s6J+8xxnuGSw+27eWk3eyN0VzIj8HCMMJKZn9zXqi3ndp9unK5Yz/2DCFUqkUvwaqN1/kkksZSl/BPCMZPzo8JNjT3zUyjg4BwixU/o8dh4BkFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8ZWJuLD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8ZWJuLD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27C41F00A3A;
	Wed,  9 Sep 2026 05:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788931388;
	bh=bBGI5+0TaCJ5LUAwyqXocT8JVAJ0iIwwH3Wb66JKBzg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z8ZWJuLD0eTfZi+HXdwHHdrJYQHbw1y0uXXmPmdpjh02AYyYK41Bg9UcglPYqLpHz
	 ZPft/+SpNfazmkjBxI00/dqO5xnbDUj3KcMf3dSx3QWMEAEBVpH2/DumvpnvAAtPmi
	 ylRyfenDmOl/deAHg7pe3pWeL5XJ4mG+AXmxP5ST580FOJhnscDdJ6UCirwGGFoFXt
	 3HRvEEn1COMoR1oVXfPuhLqOXNxt8XwDjzRGUHI2oQukdxFKe3mImOFJIj3EayIE1t
	 ouNAyBIlnF/+1FOhPZXWR3qlvJ/PiqQ7Flsbz7WetiwiFj8ZmIg7ICif0XuDi189Dc
	 LxhnBvsl6ln7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] dmaengine: qcom: gpi: Add trace event support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Praveen Talari" <praveen.talari@oss.qualcomm.com>
Cc: Frank.Li@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260909-add-trace-support-gpio-v2-2-01f81739bb88@oss.qualcomm.com>
References: <20260909-add-trace-support-gpio-v2-0-01f81739bb88@oss.qualcomm.com>
 <20260909-add-trace-support-gpio-v2-2-01f81739bb88@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 05:23:08 +0000
Message-Id: <20260909052308.A27C41F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [Medium] The `gpi_irq_status` tracepoint is only called before the interr=
upt processing loop, silently omitting back-to-back interrupts.

Pre-existing issues:
- [High] Tasklet Use-After-Free due to incorrect teardown order in gpi_free=
_chan_resources.
- [High] Incorrect channel cleanup in gpi_ch_init error path.
- [High] Leak of transfer ring DMA memory when gpi_ch_init fails.
- [High] Missing dma_wmb() barrier before writing to the channel doorbell r=
egister, which may cause the hardware to read stale descriptors.
- [High] Missing dma_rmb() barrier before reading event ring descriptors, r=
isking processing of stale event data.
--

commit 4cf86dc6d78f8720092d0dce56c8bcfee50f39a4
Author: Praveen Talari <praveen.talari@oss.qualcomm.com>

    dmaengine: qcom: gpi: Add trace event support
   =20
    Wire up the qcom_gpi tracepoints into the GPI DMA engine driver to
    provide runtime visibility into driver behavior without requiring
    invasive debug patches.

> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> index a5055a6273af6..b09354a73b46e 100644
> --- a/drivers/dma/qcom/gpi.c
> +++ b/drivers/dma/qcom/gpi.c

[ ... ]

> @@ -841,6 +846,7 @@ static irqreturn_t gpi_handle_irq(int irq, void *data)
> =20
>  	offset =3D GPII_n_CNTXT_TYPE_IRQ_OFFS(gpii->gpii_id);
>  	type =3D gpi_read_reg(gpii, gpii->regs + offset);
> +	trace_gpi_irq_status(gpii->gpi_dev->dev, gpii_id, type);
> =20
>  	do {
>  		/* global gpii error */

[Severity: Medium]
Will this tracepoint miss subsequent back-to-back interrupts?

In drivers/dma/qcom/gpi.c:gpi_handle_irq(), the hardware can trigger
back-to-back interrupts. The function reads the type register before the
loop, traces it, and then processes the interrupt. It reads the type
register again at the end of the loop and finds another interrupt, but
continues the loop without invoking trace_gpi_irq_status() for the newly
read type.

[ ... ]

> @@ -1887,6 +1897,7 @@ static void gpi_issue_pending(struct dma_chan *chan)
>  	}
> =20
>  	gpi_desc =3D to_gpi_desc(vd);
> +	trace_gpi_queue_xfer(gpii->gpi_dev->dev, gchan->chid, gpi_desc->num_tre=
);
>  	for (i =3D 0; i < gpi_desc->num_tre; i++) {
>  		tre =3D &gpi_desc->tre[i];
>  		gpi_queue_xfer(gpii, gchan, tre, &wp);

[Severity: High]
This is a pre-existing issue, but is there a missing dma_wmb() barrier
before writing to the channel doorbell register?

After the loop populates descriptors in
drivers/dma/qcom/gpi.c:gpi_issue_pending(), the doorbell is rung:

	gpi_desc->db =3D ch_ring->wp;
	gpi_write_ch_db(gchan, &gchan->ch_ring, gpi_desc->db);

Since gpi_write_ch_db() uses writel_relaxed(), without a preceding
dma_wmb(), could the CPU reorder the relaxed MMIO doorbell write before
the main memory TRE writes become globally visible, causing the hardware
to process uninitialized or stale descriptors?

[Severity: High]
This isn't a bug introduced by this patch, but does
gpi_free_chan_resources() in drivers/dma/qcom/gpi.c have a race
condition that could lead to a use-after-free?

	tasklet_kill(&gpii->ev_task);

	/* send command to de allocate event ring */
	if (cur_state =3D=3D ACTIVE_STATE)
		gpi_send_cmd(gpii, NULL, GPI_EV_CMD_DEALLOC);

	gpi_free_ring(&gpii->ev_ring, gpii);

	/* disable interrupts */
	if (cur_state =3D=3D ACTIVE_STATE)
		gpi_disable_interrupts(gpii);

The tasklet is killed and the ring is freed before the interrupt is
disabled. If a delayed or spurious hardware interrupt occurs in this
window, the interrupt handler will read pm_state as PREPARE_TERMINATE,
and could schedule the tasklet again. The tasklet would then run and
access the freed ev_ring.

[Severity: High]
This is a pre-existing issue, but does gpi_ch_init() in
drivers/dma/qcom/gpi.c have an incorrect channel cleanup in its
error path?

error_start_chan:
	for (i =3D i - 1; i >=3D 0; i--) {
		gpi_stop_chan(&gpii->gchan[i]);
		gpi_send_cmd(gpii, gchan, GPI_CH_CMD_RESET);
	}
	i =3D 2;
error_alloc_chan:
	for (i =3D i - 1; i >=3D 0; i--)
		gpi_reset_chan(gchan, GPI_CH_CMD_DE_ALLOC);

If initialization fails, it jumps to the error path. The loop iterates
over i, but it erroneously passes the single argument gchan to
gpi_stop_chan(), gpi_send_cmd(), and gpi_reset_chan() instead of
&gpii->gchan[i]. Could this repeatedly reset the same channel while
abandoning the other channel in a partially initialized state?

[Severity: High]
This isn't a bug introduced by this patch, but does
gpi_alloc_chan_resources() in drivers/dma/qcom/gpi.c leak the transfer
ring DMA memory when gpi_ch_init() fails?

	ret =3D gpi_alloc_ring(&gchan->ch_ring, CHAN_TRES,
			     sizeof(struct gpi_tre), gpii);
	if (ret)
		goto xfer_alloc_err;

	ret =3D gpi_ch_init(gchan);

	mutex_unlock(&gpii->ctrl_lock);

	return ret;

When gpi_ch_init() returns an error, the function exits without calling
gpi_free_ring() to release the locally allocated gchan->ch_ring.

[Severity: High]
This is a pre-existing issue, but is there a missing dma_rmb() barrier
before reading event ring descriptors in
drivers/dma/qcom/gpi.c:gpi_process_events()?

	cntxt_rp =3D gpi_read_reg(gpii, gpii->ev_ring_rp_lsb_reg);
	rp =3D to_virtual(ev_ring, cntxt_rp);

	do {
		while (rp !=3D ev_ring->rp) {
			gpi_event =3D ev_ring->rp;

The CPU reads the hardware progress register via gpi_read_reg() which
uses readl_relaxed(). It then immediately reads the corresponding DMA
memory at ev_ring->rp. Without an intervening dma_rmb(), could the CPU
speculatively fetch the descriptors from memory before the progress
pointer read completes, reading stale events?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-add-trace-=
support-gpio-v2-0-01f81739bb88@oss.qualcomm.com?part=3D2
