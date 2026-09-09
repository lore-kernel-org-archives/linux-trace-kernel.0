Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAF32D2381;
	Wed,  9 Sep 2026 05:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788931325; cv=none; b=cTMrYNSb2c0QTbFj9XwbNGiGbSv0xT/TczF6fUSMhFVG4nSwnuOmAH8ZREM9JvBcBzTziAPP9FXIEUscnf6TUzcyGPZqnMVlkN9adVmZ2XJGNRXYGCKN5Vrsf+492omLxGWSkZZtBnkhkl+co3ipj03w7gl1xyAU+DKkEdyICGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788931325; c=relaxed/simple;
	bh=pz5BhKY/ECpTf9EJPq9cOsCi6Xqkgcsc2NTpHlgsUMc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AnRsxi0ypprk1qVkRYhICKdUTFYE010DH0+26WcAw3axEORz0YGOyHbTg9fqVH6dezEXJFHRpDJPKcr86FUQs+ZVniOcllHGCaituL1gcvhjpoWBw8c/+qVt9og3nkSGyQMz8XfQAaHCXMvPtxlqAdczxduFlAj7rLJ890vCaU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iw80Jzz0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iw80Jzz0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D88341F00A3A;
	Wed,  9 Sep 2026 05:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788931323;
	bh=cRDbDqmQDY+8mI7kYexJ/h4pJNZ14bCsb9IsoF9Ora0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iw80Jzz0mUqDeyZw0tiwJ2acwpXPSINBtO2HgqxwkmFQ/po6tW0gpZ2YrqSXNHMfk
	 iThSq89sXPo7oBPPKOBQ1O/F/vNd83CZQhIOyKxDrtPeXxidvQTMDvHta6IGHrG1cp
	 hV/Dtjsl90OqKdcZ5z0yxYo5q3pBbCP0otO+4UVk3Xt1aVzwhhJBJSioM9PNb9zBGx
	 IllH64gCwNwNBovSXzCb2TwHCgE7MJ+OQPT/E0nHFBsDwtjsyeScS1qXfmnwPc/GAH
	 TQaYSltmcKwuYAD1ZPxlh2OzHgYQwUIHzOsx/ZLCcfnqRN4UK3AV0LCcDUHxeTBGmp
	 bvBYer2yb/jWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] dmaengine: qcom: gpi: Convert dev_dbg() calls to
 tracepoints
Reply-To: sashiko-reviews@lists.linux.dev
To: "Praveen Talari" <praveen.talari@oss.qualcomm.com>
Cc: vkoul@kernel.org, linux-trace-kernel@vger.kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260909-add-trace-support-gpio-v2-3-01f81739bb88@oss.qualcomm.com>
References: <20260909-add-trace-support-gpio-v2-0-01f81739bb88@oss.qualcomm.com>
 <20260909-add-trace-support-gpio-v2-3-01f81739bb88@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 05:22:02 +0000
Message-Id: <20260909052202.D88341F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unvalidated hardware event 'chid' used as an array index.
- [High] Unvalidated hardware event 'tre_index' leads to out-of-bounds memo=
ry read.
- [High] The driver drops gchan->vc.lock while a DMA descriptor remains on =
the virt-dma issued list, leading to a race with channel termination and a =
use-after-free.
- [High] Error path in gpi_resume() leaves the hardware IRQ enabled while t=
he software state remains paused, leading to unbalanced IRQ enables upon re=
try.
- [High] The driver does not validate the physical address (`ptr`) returned=
 in a DMA completion event, allowing untrusted input to corrupt ring buffer=
 pointers.
- [High] Missing dma_rmb() before reading the DMA event ring buffer.
- [High] Missing memory barrier before ringing the event doorbell in gpi_pr=
ocess_events().
- [High] Missing dma_wmb() before writing to the channel doorbell in gpi_is=
sue_pending().
--

commit 1bf9fce9a4cdb676de685f3966a35631e5323808
Author: Praveen Talari <praveen.talari@oss.qualcomm.com>

dmaengine: qcom: gpi: Convert dev_dbg() calls to tracepoints

Replace the remaining dev_dbg() based debug logging in the GPI DMA
driver with the qcom_gpi tracepoints, providing structured runtime
visibility into GPI DMA behavior without requiring invasive debug
patches. dev_err() calls are left untouched.

> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> index b09354a73b46e..8e7d25a461475 100644
> --- a/drivers/dma/qcom/gpi.c
> +++ b/drivers/dma/qcom/gpi.c
> @@ -945,17 +940,10 @@ static void gpi_process_imed_data_event(struct gcha=
n *gchan,
>  		struct gpi_tre *gpi_tre;
> =20
>  		spin_unlock_irqrestore(&gchan->vc.lock, flags);
> -		dev_dbg(gpii->gpi_dev->dev, "event without a pending descriptor!\n");
>  		gpi_ere =3D (struct gpi_ere *)imed_event;
> -		dev_dbg(gpii->gpi_dev->dev,
> -			"Event: %08x %08x %08x %08x\n",
> -			gpi_ere->dword[0], gpi_ere->dword[1],
> -			gpi_ere->dword[2], gpi_ere->dword[3]);
>  		gpi_tre =3D tre;
> -		dev_dbg(gpii->gpi_dev->dev,
> -			"Pending TRE: %08x %08x %08x %08x\n",
> -			gpi_tre->dword[0], gpi_tre->dword[1],
> -			gpi_tre->dword[2], gpi_tre->dword[3]);
> +		trace_gpi_ev_no_desc(gpii->gpi_dev->dev, imed_event->chid,
> +				     gpi_ere->dword, gpi_tre->dword);
>  		return;
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but does this code lead to an
out-of-bounds memory read?

drivers/dma/qcom/gpi.c:gpi_process_imed_data_event() {
    ...
    void *tre =3D ch_ring->base + (ch_ring->el_size * imed_event->tre_index=
);
    ...
    gpi_tre =3D tre;
    trace_gpi_ev_no_desc(gpii->gpi_dev->dev, imed_event->chid,
                         gpi_ere->dword, gpi_tre->dword);
}

The tre_index is read from imed_event->tre_index without a bounds check aga=
inst
ch_ring->elements. If it exceeds the ring size, will the tracepoint derefer=
ence
out-of-bounds memory?

[ ... ]

> @@ -1064,11 +1052,10 @@ static void gpi_process_xfer_compl_event(struct g=
chan *gchan,
>  		dev_err(gpii->gpi_dev->dev, "Error in Transaction\n");
>  		result.result =3D DMA_TRANS_ABORTED;
>  	} else {
> -		dev_dbg(gpii->gpi_dev->dev, "Transaction Success\n");
>  		result.result =3D DMA_TRANS_NOERROR;
>  	}
>  	result.residue =3D gpi_desc->len - compl_event->length;
> -	dev_dbg(gpii->gpi_dev->dev, "Residue %d\n", result.residue);
> +	trace_gpi_xfer_result(gpii->gpi_dev->dev, chid, result.result, result.r=
esidue);
> =20
>  	dma_cookie_complete(&vd->tx);
>  	dmaengine_desc_get_callback_invoke(&vd->tx, &result);

[Severity: High]
This is a pre-existing issue, but does this driver validate the physical ad=
dress
returned in a DMA completion event?

drivers/dma/qcom/gpi.c:gpi_process_xfer_compl_event() {
    ...
    void *ev_rp =3D to_virtual(ch_ring, compl_event->ptr);
    ...
}

The compl_event->ptr is a physical address provided by the hardware DMA eve=
nt,
and to_virtual() converts it without bounds checking. If the hardware yield=
s an
invalid ptr outside the physical bounds of the ring buffer, can this corrup=
t the
ring pointer tracking by assigning a bogus virtual pointer to ch_ring->rp?

[Severity: High]
This isn't a bug introduced by this patch, but can this code race with chan=
nel
termination and cause a use-after-free?

drivers/dma/qcom/gpi.c:gpi_process_xfer_compl_event() {
    ...
gpi_free_desc:
    spin_lock_irqsave(&gchan->vc.lock, flags);
    list_del(&vd->node);
    spin_unlock_irqrestore(&gchan->vc.lock, flags);
    kfree(gpi_desc);
}

The interrupt handler drops gchan->vc.lock earlier after getting the descri=
ptor
via vchan_next_desc(), without removing it from the desc_issued list.

If a concurrent vchan_terminate_all() acquires the lock, removes, and frees=
 the
descriptor, the IRQ handler will then resume, modify the freed descriptor
(dma_cookie_complete), and call list_del(&vd->node) on freed memory.

This also applies to gpi_process_imed_data_event() where the same pattern e=
xists.

[ ... ]

> @@ -1100,11 +1087,8 @@ static void gpi_process_events(struct gpii *gpii)
>  			chid =3D gpi_event->xfer_compl_event.chid;
>  			type =3D gpi_event->xfer_compl_event.type;
> =20
> -			dev_dbg(gpii->gpi_dev->dev,
> -				"Event: CHID:%u, type:%x %08x %08x %08x %08x\n",
> -				chid, type, gpi_event->gpi_ere.dword[0],
> -				gpi_event->gpi_ere.dword[1], gpi_event->gpi_ere.dword[2],
> -				gpi_event->gpi_ere.dword[3]);
> +			trace_gpi_process_event(gpii->gpi_dev->dev, chid, type,
> +						gpi_event->gpi_ere.dword);
> =20
>  			switch (type) {
>  			case XFER_COMPLETE_EV_TYPE:
>  				gchan =3D &gpii->gchan[chid];

[Severity: High]
This isn't a bug introduced by this patch, but is a dma_rmb() missing before
reading the DMA event ring buffer?

drivers/dma/qcom/gpi.c:gpi_process_events() {
    cntxt_rp =3D gpi_read_reg(gpii, gpii->ev_ring_rp_lsb_reg);
    rp =3D to_virtual(ev_ring, cntxt_rp);

    do {
        while (rp !=3D ev_ring->rp) {
            gpi_event =3D ev_ring->rp;
    ...
}

Because gpi_read_reg() wraps readl_relaxed(), it provides no ordering guara=
ntees
against normal memory reads. Can the CPU speculatively fetch from the DMA-m=
apped
event ring before the register read completes and confirms there is new dat=
a?

[Severity: High]
This is a pre-existing issue, but does this code use an unvalidated hardware
event chid as an array index?

drivers/dma/qcom/gpi.c:gpi_process_events() {
    ...
    chid =3D gpi_event->xfer_compl_event.chid;
    type =3D gpi_event->xfer_compl_event.type;

    trace_gpi_process_event(gpii->gpi_dev->dev, chid, type,
                            gpi_event->gpi_ere.dword);

    switch (type) {
    case XFER_COMPLETE_EV_TYPE:
        gchan =3D &gpii->gchan[chid];
    ...
}

If the hardware is compromised or fails and sends a chid value greater than=
 or
equal to MAX_CHANNELS_PER_GPII, indexing gpii->gchan[chid] will read out of
bounds. Can this corrupt adjacent memory or crash the kernel?

[ ... ]

> @@ -1121,11 +1104,8 @@ static void gpi_process_events(struct gpii *gpii)
>  							    &gpi_event->immediate_data_event);
>  				break;
>  			case QUP_NOTIF_EV_TYPE:
> -				dev_dbg(gpii->gpi_dev->dev, "QUP_NOTIF_EV_TYPE\n");
>  				break;
>  			default:
> -				dev_dbg(gpii->gpi_dev->dev,
> -					"not supported event type:0x%x\n", type);
>  			}
>  			gpi_ring_recycle_ev_element(ev_ring);
>  		}

[Severity: High]
This is a pre-existing issue, but is a memory barrier missing before ringing
the event doorbell?

drivers/dma/qcom/gpi.c:gpi_process_events() {
    ...
            gpi_ring_recycle_ev_element(ev_ring);
        }
        gpi_write_ev_db(gpii, ev_ring, ev_ring->wp);
    ...
}

The gpi_write_ev_db() wraps writel_relaxed(). The smp_wmb() inside
gpi_ring_recycle_ev_element() only orders normal memory writes, not prior m=
emory
reads against subsequent MMIO writes. Does this mean the hardware might
overwrite the DMA event ring descriptor before the CPU actually finishes re=
ading
it? A full mb() or rmb() is typically required before the doorbell.

[ ... ]

> @@ -1578,7 +1554,7 @@ static int gpi_resume(struct dma_chan *chan)
> =20
>  	mutex_lock(&gpii->ctrl_lock);
>  	if (gpii->pm_state =3D=3D ACTIVE_STATE) {
> -		dev_dbg(gpii->gpi_dev->dev, "channel is already active\n");
> +		trace_gpi_already_state(gpii->gpi_dev->dev, gpii->gpii_id, gpii->pm_st=
ate);
>  		mutex_unlock(&gpii->ctrl_lock);
>  		return 0;
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but does this error path leave t=
he
hardware IRQ enabled while the software state remains paused?

drivers/dma/qcom/gpi.c:gpi_resume() {
    ...
    enable_irq(gpii->irq);

    for (i =3D 0; i < MAX_CHANNELS_PER_GPII; i++) {
        ret =3D gpi_send_cmd(gpii, &gpii->gchan[i], GPI_CH_CMD_START);
        if (ret) {
            dev_err(gpii->gpi_dev->dev, "Error starting chan, ret:%d\n", re=
t);
            mutex_unlock(&gpii->ctrl_lock);
            return ret;
        }
    ...
}

If gpi_send_cmd() fails, it returns without disabling the IRQ, and pm_state
remains PAUSE_STATE. On the next resume attempt, will it bypass the active =
state
check and call enable_irq() a second time, resulting in an unbalanced IRQ e=
nable
and a kernel warning?

[Severity: High]
This is a pre-existing issue, but is a dma_wmb() missing before writing to =
the
channel doorbell?

drivers/dma/qcom/gpi.c:gpi_issue_pending() {
    for (i =3D 0; i < gpi_desc->num_tre; i++) {
        tre =3D &gpi_desc->tre[i];
        gpi_queue_xfer(gpii, gchan, tre, &wp);
    }

    gpi_desc->db =3D ch_ring->wp;
    gpi_write_ch_db(gchan, &gchan->ch_ring, gpi_desc->db);
}

Descriptors are written to the DMA ring using memcpy() in gpi_queue_xfer(),=
 and
then the doorbell is rung via gpi_write_ch_db(), which wraps writel_relaxed=
().
Since writel_relaxed() does not order against prior normal memory writes, c=
an
the doorbell write reach the device before the memcpy() is visible in RAM?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-add-trace-=
support-gpio-v2-0-01f81739bb88@oss.qualcomm.com?part=3D3
