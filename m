Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D9840B39C;
	Wed, 10 Jun 2026 14:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781102079; cv=none; b=oXqYNa21cR2+yJAhaU0EKihJyQ31MjQfzc6zh1WNHIK8H0+3LDF82YKR9CPhMAqMIXW1QQV9vIgAsrTZ7MijdASCxaj+Kz9xGzDJuu0sQ64pL8Bn9ndmqZ5/FfGI3/4gzVe9SFK2j+ZyaJykSrwr6xay0qWoCL+jQsQnELfxzJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781102079; c=relaxed/simple;
	bh=1TSwrODXsBUB8IftPzx52C0XkF+RmnNXu0r6bl/vr2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H7+j4268XesF0UqTS6tigsKgLTBWSeS4x4c2Sriy89HRlP7EX3YACcre2kPVP2dZZGBL0v8X/cvwoz2x9in7hOQrP73iNXzmbsQBnu1zZa2lcRpuZKgjjsa7BB5+Y9i6cEV/x2aVvIuyIJCLmzLNf5P/kSlc8TbdGK3mHP/sHPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VjMSdNz6; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VjMSdNz6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1781102070;
	bh=1TSwrODXsBUB8IftPzx52C0XkF+RmnNXu0r6bl/vr2E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VjMSdNz6BD8Oq562/yPJso2olso5XsJgxdmZIt3roVcZutcLfSD0Xq9LVLRkN/LF+
	 qF2U+FYh1D35JeRxa/DwQSjF350JwZm3ZW2s2KUMmhxcJ1r5ohFdfzcbdigN5qeZtk
	 eosueFvhvnwwTl4dl996mfO2jbMzv6sY3n6aEabl03bNk9t9m0jeg12B2q965trgJg
	 xJRl504qRNDaQm8wNSgQHrMlTqtuUAvVUQxIEy43mZPa6ccC4khBS8fvDPFhuIGV/N
	 8HyXaVCCyVAjaplM3MbevY7sisofSdjCfJ5eVzUAQy+g9ZMReUrhMBANdzI+m0EK00
	 xuquzWrCZgSNg==
Received: from [192.168.0.15] (unknown [100.64.0.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3CBF217E1221;
	Wed, 10 Jun 2026 16:34:28 +0200 (CEST)
From: Detlev Casanova <detlev.casanova@collabora.com>
Date: Wed, 10 Jun 2026 10:33:39 -0400
Subject: [PATCH v2 9/9] media: hantro: Add v4l2_hw run/done traces
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-v4l2-add-ftrace-v2-9-9756edf72ac1@collabora.com>
References: <20260610-v4l2-add-ftrace-v2-0-9756edf72ac1@collabora.com>
In-Reply-To: <20260610-v4l2-add-ftrace-v2-0-9756edf72ac1@collabora.com>
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
 drivers/media/platform/verisilicon/hantro.h               |  1 +
 drivers/media/platform/verisilicon/hantro_drv.c           | 10 ++++++++++
 drivers/media/platform/verisilicon/rockchip_vpu981_regs.h |  1 +
 drivers/media/platform/verisilicon/rockchip_vpu_hw.c      |  4 ++++
 4 files changed, 16 insertions(+)

diff --git a/drivers/media/platform/verisilicon/hantro.h b/drivers/media/platform/verisilicon/hantro.h
index 0353de154a1e..d5cddc783688 100644
--- a/drivers/media/platform/verisilicon/hantro.h
+++ b/drivers/media/platform/verisilicon/hantro.h
@@ -253,6 +253,7 @@ struct hantro_ctx {
 
 	u32 sequence_cap;
 	u32 sequence_out;
+	u32 hw_cycles;
 
 	const struct hantro_fmt *vpu_src_fmt;
 	struct v4l2_pix_format_mplane src_fmt;
diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
index 2e81877f640f..32855b14e0f1 100644
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
@@ -103,6 +105,9 @@ void hantro_irq_done(struct hantro_dev *vpu,
 	struct hantro_ctx *ctx =
 		v4l2_m2m_get_curr_priv(vpu->m2m_dev);
 
+	if (ctx)
+		trace_v4l2_hw_done(ctx->fh.tgid, ctx->fh.fd, ctx->hw_cycles);
+
 	/*
 	 * If cancel_delayed_work returns false
 	 * the timeout expired. The watchdog is running,
@@ -125,6 +130,9 @@ void hantro_watchdog(struct work_struct *work)
 	ctx = v4l2_m2m_get_curr_priv(vpu->m2m_dev);
 	if (ctx) {
 		vpu_err("frame processing timed out!\n");
+
+		trace_v4l2_hw_done(ctx->fh.tgid, ctx->fh.fd, ctx->hw_cycles);
+
 		if (ctx->codec_ops->reset)
 			ctx->codec_ops->reset(ctx);
 		hantro_job_finish(vpu, ctx, VB2_BUF_STATE_ERROR);
@@ -189,6 +197,8 @@ static void device_run(void *priv)
 	if (ctx->codec_ops->run(ctx))
 		goto err_cancel_job;
 
+	trace_v4l2_hw_run(ctx->fh.tgid, ctx->fh.fd);
+
 	return;
 
 err_cancel_job:
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
index 02673be9878e..f959151b6645 100644
--- a/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
+++ b/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
@@ -424,6 +424,8 @@ static irqreturn_t rk3588_vpu981_irq(int irq, void *dev_id)
 {
 	struct hantro_dev *vpu = dev_id;
 	enum vb2_buffer_state state;
+	struct hantro_ctx *ctx =
+		v4l2_m2m_get_curr_priv(vpu->m2m_dev);
 	u32 status;
 
 	status = vdpu_read(vpu, AV1_REG_INTERRUPT);
@@ -433,6 +435,8 @@ static irqreturn_t rk3588_vpu981_irq(int irq, void *dev_id)
 	vdpu_write(vpu, 0, AV1_REG_INTERRUPT);
 	vdpu_write(vpu, AV1_REG_CONFIG_DEC_CLK_GATE_E, AV1_REG_CONFIG);
 
+	ctx->hw_cycles = vdpu_read(vpu, AV1_CYCLE_COUNT);
+
 	hantro_irq_done(vpu, state);
 
 	return IRQ_HANDLED;

-- 
2.54.0

