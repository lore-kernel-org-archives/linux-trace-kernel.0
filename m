Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A5A376A01;
	Mon, 31 Aug 2026 19:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788204750; cv=none; b=lk6o4/VOEe0rnN3mb4Xne9H9p60wRFXuiAsmdUQuj+i3SwYacbZd5uHgZIaN7agXs0ZYuHJnGcYUkZH9WlChkjThomulKFQS/wsBwtKPvP4aZTzZlMxntzVwYa9h94qpQ22Qag8476HLAQN7Oe7WU5kwmtC+Q9LNtgbRL3DR7dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788204750; c=relaxed/simple;
	bh=driLGGu/vRIcMWNJrm1xOMcClYi2yprJ99y9oSf5GN8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bRO5CyNOfUcsVf6AHkkRvslDC43Ui/dGv99rcYjBsQDA1Ltxo7HBRrtAUi3iIHSiiN5B8ijnDtDvzGP15yB/4VDnZ2PaWg7GvCKWyT7UlBgaisz+KEyipdD3q0EOI+tfQby3LOb/hgVpa3OW+oH4bs7lom/gIfC/8ANNN4Hof/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOUUB1pz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOUUB1pz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94FEF1F000E9;
	Mon, 31 Aug 2026 19:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788204748;
	bh=AnRlovmuQCNlccWo0meZZ0bCdq4AXObp1tyNp9pT4GI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aOUUB1pzqz9M4gE8ys+QMSk/IYM/REKdOGH9ZWuqE6xHQdrGqqi0bLO/cGq/Z9ilm
	 bCiOO7n3KCHLHrSR3U+BTxcRQ8X0OsU3Esjw5Rc8dq0K69mYnJk59ZrcS9mRauJL4Q
	 MIZV37JNC7pQD7+RgGR+JnemhG/if/HP00OHZzLh/io7s+AreaamYHupTZhkYJZG81
	 hvvIH/f+TmR397/uWCPAloyR632i4wbcfLtuWT9mlgr7I18JrjrBXQE9STGslTQh/v
	 yWfg7EXob99ImcE8FpqVTvAq+og7YNbnZWS2ksthatpEZt1wenkXM2zkLouJ8xYOdH
	 1Xw848EyX1d0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] dmaengine: qcom: gpi: Convert dev_dbg() calls to
 tracepoints
Reply-To: sashiko-reviews@lists.linux.dev
To: "Praveen Talari" <praveen.talari@oss.qualcomm.com>
Cc: dmaengine@vger.kernel.org, linux-trace-kernel@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260831-add-trace-support-gpio-v1-3-7b0fd0d0ddb3@oss.qualcomm.com>
References: <20260831-add-trace-support-gpio-v1-0-7b0fd0d0ddb3@oss.qualcomm.com>
 <20260831-add-trace-support-gpio-v1-3-7b0fd0d0ddb3@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 19:32:28 +0000
Message-Id: <20260831193228.94FEF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver invokes the DMA client callback while the transfer desc=
riptor is still on the vchan `desc_issued` list, leading to a double-free a=
nd use-after-free list corruption if the channel is terminated concurrently.
- [High] Missing dma_rmb() when reading event ring elements allows speculat=
ive reads of stale DMA memory.
- [High] Missing dma_wmb() before writing to the channel doorbell register =
allows the device to fetch stale transfer ring elements (TREs).
--

commit 69c40ab9cf4118765a807f48c1fc907c907c1667
Author: Praveen Talari <praveen.talari@oss.qualcomm.com>

    dmaengine: qcom: gpi: Convert dev_dbg() calls to tracepoints

    Replace the remaining dev_dbg() based debug logging in the GPI DMA
    driver with the qcom_gpi tracepoints, providing structured runtime
    visibility into GPI DMA behavior without requiring invasive debug
    patches. dev_err() calls are left untouched.

> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> index a5055a6273af6..8e7d25a461475 100644
> --- a/drivers/dma/qcom/gpi.c
> +++ b/drivers/dma/qcom/gpi.c
[ ... ]
> @@ -1043,6 +1039,8 @@ static void gpi_process_xfer_compl_event(struct gch=
an *gchan,
>  	smp_wmb();
> =20
>  	chid =3D compl_event->chid;
> +	trace_gpi_ev_process(gpii->gpi_dev->dev, chid, XFER_COMPLETE_EV_TYPE,
> +			     compl_event->code, compl_event->status, compl_event->length);
>  	if (compl_event->code =3D=3D MSM_GPI_TCE_EOT && gpii->ieob_set) {
>  		if (chid =3D=3D GPI_RX_CHAN)
>  			goto gpi_free_desc;
> @@ -1054,11 +1052,10 @@ static void gpi_process_xfer_compl_event(struct g=
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
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
This isn't a bug introduced by this patch, but does invoking the DMA client
callback here while the descriptor is still on the vchan desc_issued list
create a use-after-free risk?

If a client concurrently aborts the transfer (e.g., on a timeout) by calling
dmaengine_terminate_all(), gpi_terminate_all() will extract all descriptors
from the vchan lists (including this vd) and free them. When the tasklet
resumes, it drops the lock, executes this callback, and then hits the
gpi_free_desc path:

gpi_free_desc:
	spin_lock_irqsave(&gchan->vc.lock, flags);
	list_del(&vd->node);
	spin_unlock_irqrestore(&gchan->vc.lock, flags);
	kfree(gpi_desc);

Could this result in a double-free and list corruption? The identical
vulnerable pattern also exists in gpi_process_imed_data_event().

[ ... ]
> @@ -1090,11 +1087,8 @@ static void gpi_process_events(struct gpii *gpii)
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

[Severity: High]
This is a pre-existing issue, but does gpi_process_events() need a dma_rmb()
before accessing the event ring elements?

The hardware event ring read pointer is read using gpi_read_reg() which
wraps readl_relaxed(). Because readl_relaxed() doesn't provide memory
ordering guarantees, could the CPU speculatively read the DMA memory for
gpi_event before the register read completes, resulting in stale DMA memory
being read?

[ ... ]
> @@ -1887,6 +1871,7 @@ static void gpi_issue_pending(struct dma_chan *chan)
>  	}
> =20
>  	gpi_desc =3D to_gpi_desc(vd);
> +	trace_gpi_queue_xfer(gpii->gpi_dev->dev, gchan->chid, gpi_desc->num_tre=
);
>  	for (i =3D 0; i < gpi_desc->num_tre; i++) {
>  		tre =3D &gpi_desc->tre[i];
>  		gpi_queue_xfer(gpii, gchan, tre, &wp);
>  	}

[Severity: High]
This is a pre-existing issue, but is a dma_wmb() barrier needed here after
copying the Transfer Ring Elements (TREs) and before writing to the channel
doorbell register?

Right after this loop, gpi_issue_pending() calls gpi_write_ch_db() which
wraps writel_relaxed(). Without a dma_wmb() enforcing memory ordering, could
the register write reach the device before the TRE memory writes are
completely visible, causing the device to fetch stale descriptors?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-add-trace-=
support-gpio-v1-0-7b0fd0d0ddb3@oss.qualcomm.com?part=3D3
