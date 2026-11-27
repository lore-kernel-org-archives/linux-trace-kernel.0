Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795797960;
	b=l88616QoZf/uexIAB85Hvk/n9JYDIDWlLoKOh15FKytQx7pTm+fHkNnJy8BGdmp1ePmZ
	 KjcbkvCuXdn5InBGEAh4BKHo2MPm8WTAIk6TUkoYQ9pVdpI8qxssLLI/Xnc527w9GLpaF
	 TCQv5InyoqaB2PWyjqs/U1BpJI8gNlY+Y15ll1tpKjaVz22HzanXOIqnVOwd9a6BH6y0O
	 whqlB/BFFGoOsm0inPdJfoQUHL+OR+T3ZjEwhgjD81Z8CXuzww++QEs0AXoBNsCpRvxt/
	 FF8QOze9dvydLgqtEyNTO6mXYRzjZcTnLxZgxcw+DjWqjTEbImAu8z9Ti2cClxfMIhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795797960;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=tL59kLErIyoVt3fJ3Igm47VdgC5F3mDCdQ7RiRVXjAk=;
	b=i0ps+/MFCGyfAEzDGpcr2qigwvraujZDvoWdXFZPEc5rnNUb2aPZB0CGIjvudh/k2ufI
	 wf38fKAK28RdtRmnFiWgLVgnQK9/x/CHHxStjdQJvJSaACKyN3Hk6Y4NeTuR8rmHJFAVT
	 mnqaDOItkFRcjYH1rwHYcdYouPwVvqRli8dDazb0bPf0/InYpSppMf9clCiupPcYNK5dG
	 UYA+IdFoyan36bzme/M+kGGUtdUpWGPnEyDjnX2u3e/KKr1EnL8EjHgWkty6vWNrh+dzf
	 rUBy9HuNmQ5PxYqYNSnbQB5mPmKRCHfJumdCaxURNL+O3D70ddZiXr0DqClLgPGULmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=DfMAiQdT;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0897A606A32A;
	Fri, 27 Nov 2026 16:45:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0897A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=DfMAiQdT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795797958;
	bh=Bxc8NEyDBUAYf72MPzeam6V/+fXECf3K+tlbsq+D+c4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DfMAiQdT73P4gDRHUOQsFCrPjT6Rf2xJ/xO6bt/DViSdS/DZ0fWMmNXt1LIY9j1T5
	 oW7pEbKXi3IXbJAydTZAKsQYpRk96cCaJWwQDWxR4YZT1q4388wGH1+pxgeWcGWAax
	 4ktMLi3m5+IOw6tR5NOaWb7JCHvfxgqFU/miRoJl3GyseTaFWpCFZuL/yUzbATTniw
	 zBG8aS0nXcDGkH5+SCiw/KDckibIxeTfqUVtJsfDfvd2PDtd64k2JBGg09awM5BWCp
	 2ScJkKOuuYFhpoUJ1wBM7tMHBs8O4tdDsaWVISmzjAEsl7vuKGkM2y5af4vvG+YDAL
	 /kIg7d7FXbELA==
Received: from [192.168.0.15] (unknown [100.64.0.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8629E17E0BA9;
	Fri, 27 Nov 2026 17:45:56 +0100 (CET)
From: Detlev Casanova <detlev.casanova@collabora.com>
Date: Fri, 27 Nov 2026 11:45:13 -0500
Subject: [PATCH v4 9/9] media: hantro: Add v4l2_hw run/done traces
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-v4l2-add-ftrace-v4-9-24138479002f@collabora.com>
References: <20261127-v4l2-add-ftrace-v4-0-24138479002f@collabora.com>
In-Reply-To: <20261127-v4l2-add-ftrace-v4-0-24138479002f@collabora.com>
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com, 
 Detlev Casanova <detlev.casanova@collabora.com>
X-Mailer: b4 0.15.2

Add the trace calls as well as retrieving the number of clock cycles for
the rockchip_vpu core.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 drivers/media/platform/verisilicon/hantro.h               | 3 +++
 drivers/media/platform/verisilicon/hantro_drv.c           | 9 +++++++++
 drivers/media/platform/verisilicon/rockchip_vpu981_regs.h | 1 +
 drivers/media/platform/verisilicon/rockchip_vpu_hw.c      | 2 ++
 4 files changed, 15 insertions(+)

diff --git a/drivers/media/platform/verisilicon/hantro.h b/drivers/media/platform/verisilicon/hantro.h
index 0353de154a1e..3f7c54f81f3b 100644
--- a/drivers/media/platform/verisilicon/hantro.h
+++ b/drivers/media/platform/verisilicon/hantro.h
@@ -193,6 +193,8 @@ hantro_vdev_to_func(struct video_device *vdev)
  *			shared with interrupt handlers.
  * @variant:		Hardware variant-specific parameters.
  * @watchdog_work:	Delayed work for hardware timeout handling.
+ * @hw_cycles:		Hardware cycles used by the current job, if reported
+ *			by the variant. Reset to 0 when a job is started.
  */
 struct hantro_dev {
 	struct v4l2_device v4l2_dev;
@@ -213,6 +215,7 @@ struct hantro_dev {
 	spinlock_t irqlock;
 	const struct hantro_variant *variant;
 	struct delayed_work watchdog_work;
+	u32 hw_cycles;
 };
 
 /**
diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
index 3734ea701145..45bf926c0480 100644
--- a/drivers/media/platform/verisilicon/hantro_drv.c
+++ b/drivers/media/platform/verisilicon/hantro_drv.c
@@ -25,6 +25,8 @@
 #include <media/videobuf2-core.h>
 #include <media/videobuf2-vmalloc.h>
 
+#include <trace/events/v4l2.h>
+
 #include "hantro_v4l2.h"
 #include "hantro.h"
 #include "hantro_hw.h"
@@ -106,6 +108,7 @@ void hantro_irq_done(struct hantro_dev *vpu,
 	 * and will take care of finishing the job.
 	 */
 	if (cancel_delayed_work(&vpu->watchdog_work)) {
+		trace_v4l2_hw_done(ctx->fh.tgid, ctx->fh.fd, vpu->hw_cycles);
 		if (result == VB2_BUF_STATE_DONE && ctx->codec_ops->done)
 			ctx->codec_ops->done(ctx);
 		hantro_job_finish(ctx, result);
@@ -122,6 +125,9 @@ void hantro_watchdog(struct work_struct *work)
 	ctx = v4l2_m2m_get_curr_priv(vpu->m2m_dev);
 	if (ctx) {
 		vpu_err("frame processing timed out!\n");
+
+		trace_v4l2_hw_done(ctx->fh.tgid, ctx->fh.fd, vpu->hw_cycles);
+
 		if (ctx->codec_ops->reset)
 			ctx->codec_ops->reset(ctx);
 		hantro_job_finish(ctx, VB2_BUF_STATE_ERROR);
@@ -159,6 +165,8 @@ void hantro_end_prepare_run(struct hantro_ctx *ctx)
 	v4l2_ctrl_request_complete(src_buf->vb2_buf.req_obj.req,
 				   &ctx->ctrl_handler);
 
+	trace_v4l2_hw_run(ctx->fh.tgid, ctx->fh.fd);
+
 	/* Kick the watchdog. */
 	schedule_delayed_work(&ctx->dev->watchdog_work,
 			      msecs_to_jiffies(2000));
@@ -182,6 +190,7 @@ static void device_run(void *priv)
 
 	v4l2_m2m_buf_copy_metadata(src, dst);
 
+	vpu->hw_cycles = 0;
 	ret = ctx->codec_ops->run(ctx);
 	if (ret)
 		hantro_job_finish(ctx, VB2_BUF_STATE_ERROR);
diff --git a/drivers/media/platform/verisilicon/rockchip_vpu981_regs.h b/drivers/media/platform/verisilicon/rockchip_vpu981_regs.h
index e4008da64f19..96b85470208b 100644
--- a/drivers/media/platform/verisilicon/rockchip_vpu981_regs.h
+++ b/drivers/media/platform/verisilicon/rockchip_vpu981_regs.h
@@ -451,6 +451,7 @@
 #define av1_pp0_dup_ver			AV1_DEC_REG(394, 16, 0xff)
 #define av1_pp0_dup_hor			AV1_DEC_REG(394, 24, 0xff)
 
+#define AV1_CYCLE_COUNT			(AV1_SWREG(63))
 #define AV1_TILE_OUT_LU			(AV1_SWREG(65))
 #define AV1_REFERENCE_Y(i)		(AV1_SWREG(67) + ((i) * 0x8))
 #define AV1_SEGMENTATION		(AV1_SWREG(81))
diff --git a/drivers/media/platform/verisilicon/rockchip_vpu_hw.c b/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
index 02673be9878e..04f26d6fded2 100644
--- a/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
+++ b/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
@@ -433,6 +433,8 @@ static irqreturn_t rk3588_vpu981_irq(int irq, void *dev_id)
 	vdpu_write(vpu, 0, AV1_REG_INTERRUPT);
 	vdpu_write(vpu, AV1_REG_CONFIG_DEC_CLK_GATE_E, AV1_REG_CONFIG);
 
+	vpu->hw_cycles = vdpu_read(vpu, AV1_CYCLE_COUNT);
+
 	hantro_irq_done(vpu, state);
 
 	return IRQ_HANDLED;

-- 
2.56.1

