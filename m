Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C04836E46F;
	Mon, 31 Aug 2026 19:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788203972; cv=none; b=hjFLl6XGaTxHHNrNRzmI58RRFtQceJ3N3XkysNVqipJnezYgHbIONcv0uzPUxzKl7oJwL3lGPBBLEYFbvJeHiYg+dZ2lqWmWH710r4tnaTpcgZVP4PQNSdtUr5Zqq3JzuSNle0cMLQaIZlHxQT+uQjclPZ80o2ve5Ki5/wR5lp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788203972; c=relaxed/simple;
	bh=oADQxERzCWV3nFLA3R1Zlv+1tuHJEIeVrQmZSHeoF1k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IeK2UsUKssXX3o7hzcdZO5z8lsvy2PicAo9r+7HShvHXcQuCGJnuBuILHq1R7uwdm0xjW1DhZs95tYXC0cZOcHIxg6QSbgXR8rUZm3vhYeoDmBdeK5sDtkzcOHiywaazsxwnmubybOthFtBT/EtGd88TfvXs3M6kAWu+N5J7yak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+c5F2QV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+c5F2QV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C921F000E9;
	Mon, 31 Aug 2026 19:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788203970;
	bh=FN+0js56QVS79ROQbKL4+wxx4QQ8rzCAZKUO6JQCGaU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e+c5F2QV/odCrqL6tw9PB+Df61wvFNvyhymWXJRwwYRRNKHWfCC6jDyEB01lr4dn7
	 NnpS/S/UEsfBdH7qnF+0FaJOyTdMtbfxHSGhcqiNXuwniz2pCYnhH4YMuuvBeurOmG
	 R8OZmsllbOSkIPC/AOLCn1SbXVrT704/8bGnt7aak658/f8fdnFE+k/nUi26t6WJNo
	 N8obnjcvHraUNqreqhHBNlBi9C7g+xJSb6jeFkoiA4MTxb1lWE+zKd9o5DNotFSqtH
	 6TqR4SWBKnfsK9tRPdo2QHG0VpJzpkW4OHl4rYnGqD8TmrFgZmNN2VjVAnDHgLEdf2
	 EFafBIMLW05SA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] dmaengine: qcom: gpi: Add trace event support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Praveen Talari" <praveen.talari@oss.qualcomm.com>
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260831-add-trace-support-gpio-v1-2-7b0fd0d0ddb3@oss.qualcomm.com>
References: <20260831-add-trace-support-gpio-v1-0-7b0fd0d0ddb3@oss.qualcomm.com>
 <20260831-add-trace-support-gpio-v1-2-7b0fd0d0ddb3@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 19:19:29 +0000
Message-Id: <20260831191929.F2C921F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] gpi_issue_pending only queues the last submitted descriptor to har=
dware, abandoning earlier batched descriptors and causing data corruption/h=
angs.
- [High] The tasklet `gpi_ev_tasklet` acquires a read_lock without disablin=
g interrupts, leading to a 3-way rwlock deadlock with hardirq and writers.
- [High] Tasklet is killed prematurely during channel teardown, allowing an=
 in-flight IRQ to reschedule it after its resources are freed.
--

commit 174e7255a0bfd5a904a8fadea83aa5cb881dc7b3
Author: Praveen Talari <praveen.talari@oss.qualcomm.com>

dmaengine: qcom: gpi: Add trace event support

This patch wires up qcom_gpi tracepoints into the GPI DMA engine driver.
It supplements existing debug logs with tracepoints for better runtime
visibility into driver behavior.

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

[Severity: High]
This is a pre-existing issue, but does gpi_ev_tasklet() risk a 3-way rwlock
deadlock with gpi_handle_irq() and writers?

gpi_ev_tasklet() acquires the rwlock in softirq without disabling local
interrupts:

	read_lock(&gpii->pm_lock);

If a writer calls a function like gpi_pause() and takes
write_lock_irq(&gpii->pm_lock), it spins and blocks new readers due to
qrwlock fairness.

If an interrupt then arrives on the tasklet's CPU, gpi_handle_irq() will ru=
n:

	read_lock_irqsave(&gpii->pm_lock, flags);

The hardirq spins waiting for the writer, the writer spins waiting for the
tasklet, and the tasklet is preempted by the hardirq, causing a total system
deadlock. Should gpi_ev_tasklet() use read_lock_irqsave() instead?

[Severity: High]
This isn't a bug introduced by this patch, but is the tasklet killed too
early in gpi_free_chan_resources(), allowing it to be rescheduled?

In gpi_free_chan_resources(), the tasklet is killed before disabling
interrupts:

	tasklet_kill(&gpii->ev_task);

	/* send command to de allocate event ring */
	if (cur_state =3D=3D ACTIVE_STATE)
		gpi_send_cmd(gpii, NULL, GPI_EV_CMD_DEALLOC);

	gpi_free_ring(&gpii->ev_ring, gpii);

	/* disable interrupts */
	if (cur_state =3D=3D ACTIVE_STATE)
		gpi_disable_interrupts(gpii);

If a final interrupt arrives (e.g., from the GPI_EV_CMD_DEALLOC command),
gpi_handle_irq() can process it and call tasklet_hi_schedule(&gpii->ev_task=
).

Meanwhile, gpi_free_chan_resources() frees and zeroes the event ring. The
rescheduled tasklet will then run gpi_process_events(), dereferencing the
zeroed ev_ring->rp pointer and causing a kernel panic. Should interrupts be
disabled before killing the tasklet?

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
This isn't a bug introduced by this patch, but does gpi_issue_pending()
handle batched descriptors correctly?

If a client driver batches two or more descriptors using vchan_tx_submit()
before calling dma_async_issue_pending(), vchan_issue_pending() moves all
submitted descriptors (e.g., A and B) to desc_issued.

gpi_issue_pending() fetches only the last submitted descriptor:

	vd =3D list_last_entry(&gchan->vc.desc_issued,
			     struct virt_dma_desc, node);
	gpi_desc =3D to_gpi_desc(vd);
	trace_gpi_queue_xfer(gpii->gpi_dev->dev, gchan->chid,
			     gpi_desc->num_tre);

This queues B to the hardware, abandoning A.

When B completes, gpi_process_xfer_compl_event() completes the first
descriptor in the list:

	vd =3D vchan_next_desc(&gchan->vc);

Thus, A is erroneously reported as completed successfully (though it never
ran), and B remains in the list forever without completion, leading to sile=
nt
DMA data corruption and channel hangs. Can this logic be fixed to support
DMA batching properly?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-add-trace-=
support-gpio-v1-0-7b0fd0d0ddb3@oss.qualcomm.com?part=3D2
