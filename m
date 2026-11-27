Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795797954;
	b=j4EWArlY8B2CLbMw+JurO+cOYBZj2bAVOoCB0vFv0T/AqwH1OX3+boWdiCKFSXICfDtj
	 ys+tN/3KasnKiZPGqXUhuA4PcjxxDrwvRK0/Wd6F7HWTK5opwwkSco76dgmv+d+sgL7W/
	 /w7+S1Sw//x2QTzTLpcj1AthMcIhAfu2Lk9xMjQMB+8HVMgGdQXb/CpH/Z39ri66eR/ck
	 aEbCCL14NxzDNwES9JNjCv0pzYf1+zaoAKy7mQFpcz4g4Mdm/SnbG5q25RuHvlmXyW7eE
	 c3Jpfwe5hpSqKxxxHi/jnqcriwy4x5YhC7IDgKyZHOGOD+k6AL4F/3ftPJM98RfE5rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795797954;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=7r95nwXWAqi/I7cql0NKauT7LF5Gp9yjTbqnSjJ70U0=;
	b=s7xiuM02MDJZ2eal7c+Fq2T5RdILhkjPPUeSawYUKXjOVTSax7B25LIm/mkjK//AgvK8
	 KGoBwuRO4GZw/ngu8ST16dU8nzfGUImCw7jEQSAtqATq3z76+Bd9aGVlTVSmI9jfT6vdi
	 q19wg9rDAUIcRtrp6X8dz/oCc/Oqu8jdw3Eh+Ywkuli/5yfHcFMBwc0lYfAcsJ5zbYUz1
	 K4DOvKOp61qu3eZKR2M5jJby62/vsGEIQjBK+0KopGrRfdtOSm4YDDTL68iFHV2yDwedg
	 ZJSlfaJSvVx8vOoCunAHLUh6h7ZxP277YJGuuvQ4rovV32IRNNINXihaut9bI82nFeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b="J09q/8Wx";
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61692606A6AA;
	Fri, 27 Nov 2026 16:45:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61692606A6AA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=J09q/8Wx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795797951;
	bh=80MecpC8WzmQan/VnfBWPnuEBWDr5hrZKpx4Hs2QkYE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=J09q/8Wx8PVQt5z5w49lDmm8VCNGx95PdCOVlYZEKQsU5woH/B6W9MXlaZQyKL/u2
	 2lZsqVCVAPLIo5f7vWIJkHFaNIOXmSARiFqWPDOqSJPaBKoxwKs01r/70QXtGBDye2
	 3JMqqgH18wKsAK3yZ49TU7J8NzhzlGSTdE4vhz+SVuMnlt/jFnIS97NjbLWR6az9KB
	 t2ajnq1U3oVyV6DmgmxAIwDBAOe5lNOr0M9Yl49kMsj9myJGwqcdMpTfhH27LOrOYE
	 6fuMqM6Wmfy/ZVOuPfcWQuZfLjM2JxEAmrCHKC1FkGrLDCe3q9ieG1I7ZyT9eAUAL/
	 w8PBE1uvEzrrw==
Received: from [192.168.0.15] (unknown [100.64.0.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E155B17E090C;
	Fri, 27 Nov 2026 17:45:49 +0100 (CET)
From: Detlev Casanova <detlev.casanova@collabora.com>
Date: Fri, 27 Nov 2026 11:45:10 -0500
Subject: [PATCH v4 6/9] media: Trace the stateless controls when set in
 v4l2-ctrls-core.c
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
Message-Id: <20261127-v4l2-add-ftrace-v4-6-24138479002f@collabora.com>
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

Also remove the trace from visl as the generic v4l2-requests traces can
now be used instead.

It allows all stateless drivers to inherit traceability, with just a small
overhead when disabled in userspace.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 drivers/media/test-drivers/visl/visl-dec.c |  74 ----------------
 drivers/media/v4l2-core/v4l2-ctrls-api.c   |  10 +++
 drivers/media/v4l2-core/v4l2-ctrls-core.c  | 131 +++++++++++++++++++++++++++++
 include/media/v4l2-ctrls.h                 |  15 ++++
 4 files changed, 156 insertions(+), 74 deletions(-)

diff --git a/drivers/media/test-drivers/visl/visl-dec.c b/drivers/media/test-drivers/visl/visl-dec.c
index 2a065a6249ad..9517830fb3e8 100644
--- a/drivers/media/test-drivers/visl/visl-dec.c
+++ b/drivers/media/test-drivers/visl/visl-dec.c
@@ -12,7 +12,6 @@
 #include <linux/workqueue.h>
 #include <media/v4l2-mem2mem.h>
 #include <media/tpg/v4l2-tpg.h>
-#include <trace/events/v4l2_controls.h>
 
 #define LAST_BUF_IDX (V4L2_AV1_REF_LAST_FRAME - V4L2_AV1_REF_LAST_FRAME)
 #define LAST2_BUF_IDX (V4L2_AV1_REF_LAST2_FRAME - V4L2_AV1_REF_LAST_FRAME)
@@ -486,78 +485,6 @@ static void visl_tpg_fill(struct visl_ctx *ctx, struct visl_run *run)
 	}
 }
 
-static void visl_trace_ctrls(struct visl_ctx *ctx, struct visl_run *run)
-{
-	int i;
-	struct v4l2_fh *fh = &ctx->fh;
-
-	switch (ctx->current_codec) {
-	default:
-	case VISL_CODEC_NONE:
-		break;
-	case VISL_CODEC_FWHT:
-		trace_v4l2_ctrl_fwht_params(fh->tgid, fh->fd, run->fwht.params);
-		break;
-	case VISL_CODEC_MPEG2:
-		trace_v4l2_ctrl_mpeg2_sequence(fh->tgid, fh->fd, run->mpeg2.seq);
-		trace_v4l2_ctrl_mpeg2_picture(fh->tgid, fh->fd, run->mpeg2.pic);
-		trace_v4l2_ctrl_mpeg2_quantisation(fh->tgid, fh->fd, run->mpeg2.quant);
-		break;
-	case VISL_CODEC_VP8:
-		trace_v4l2_ctrl_vp8_frame(fh->tgid, fh->fd, run->vp8.frame);
-		trace_v4l2_ctrl_vp8_entropy(fh->tgid, fh->fd, run->vp8.frame);
-		break;
-	case VISL_CODEC_VP9:
-		trace_v4l2_ctrl_vp9_frame(fh->tgid, fh->fd, run->vp9.frame);
-		trace_v4l2_ctrl_vp9_compressed_hdr(fh->tgid, fh->fd, run->vp9.probs);
-		trace_v4l2_ctrl_vp9_compressed_coeff(fh->tgid, fh->fd, run->vp9.probs);
-		trace_v4l2_vp9_mv_probs(fh->tgid, fh->fd, &run->vp9.probs->mv);
-		break;
-	case VISL_CODEC_H264:
-		trace_v4l2_ctrl_h264_sps(fh->tgid, fh->fd, run->h264.sps);
-		trace_v4l2_ctrl_h264_pps(fh->tgid, fh->fd, run->h264.pps);
-		trace_v4l2_ctrl_h264_scaling_matrix(fh->tgid, fh->fd, run->h264.sm);
-		trace_v4l2_ctrl_h264_slice_params(fh->tgid, fh->fd, run->h264.spram);
-
-		for (i = 0; i < ARRAY_SIZE(run->h264.spram->ref_pic_list0); i++)
-			trace_v4l2_h264_ref_pic_list0(fh->tgid, fh->fd,
-						      &run->h264.spram->ref_pic_list0[i], i);
-		for (i = 0; i < ARRAY_SIZE(run->h264.spram->ref_pic_list0); i++)
-			trace_v4l2_h264_ref_pic_list1(fh->tgid, fh->fd,
-						      &run->h264.spram->ref_pic_list1[i], i);
-
-		trace_v4l2_ctrl_h264_decode_params(fh->tgid, fh->fd, run->h264.dpram);
-
-		for (i = 0; i < ARRAY_SIZE(run->h264.dpram->dpb); i++)
-			trace_v4l2_h264_dpb_entry(fh->tgid, fh->fd, &run->h264.dpram->dpb[i], i);
-
-		trace_v4l2_ctrl_h264_pred_weights(fh->tgid, fh->fd, run->h264.pwht);
-		break;
-	case VISL_CODEC_HEVC:
-		trace_v4l2_ctrl_hevc_sps(fh->tgid, fh->fd, run->hevc.sps);
-		trace_v4l2_ctrl_hevc_pps(fh->tgid, fh->fd, run->hevc.pps);
-		trace_v4l2_ctrl_hevc_slice_params(fh->tgid, fh->fd, run->hevc.spram);
-		trace_v4l2_ctrl_hevc_scaling_matrix(fh->tgid, fh->fd, run->hevc.sm);
-		trace_v4l2_ctrl_hevc_decode_params(fh->tgid, fh->fd, run->hevc.dpram);
-
-		for (i = 0; i < ARRAY_SIZE(run->hevc.dpram->dpb); i++)
-			trace_v4l2_hevc_dpb_entry(fh->tgid, fh->fd, &run->hevc.dpram->dpb[i]);
-
-
-		trace_v4l2_hevc_pred_weight_table(fh->tgid, fh->fd,
-						  &run->hevc.spram->pred_weight_table);
-		trace_v4l2_ctrl_hevc_ext_sps_lt_rps(fh->tgid, fh->fd, run->hevc.rps_lt);
-		trace_v4l2_ctrl_hevc_ext_sps_st_rps(fh->tgid, fh->fd, run->hevc.rps_st);
-		break;
-	case VISL_CODEC_AV1:
-		trace_v4l2_ctrl_av1_sequence(fh->tgid, fh->fd, run->av1.seq);
-		trace_v4l2_ctrl_av1_frame(fh->tgid, fh->fd, run->av1.frame);
-		trace_v4l2_ctrl_av1_film_grain(fh->tgid, fh->fd, run->av1.grain);
-		trace_v4l2_ctrl_av1_tile_group_entry(fh->tgid, fh->fd, run->av1.tge);
-		break;
-	}
-}
-
 void visl_device_run(void *priv)
 {
 	struct visl_ctx *ctx = priv;
@@ -634,7 +561,6 @@ void visl_device_run(void *priv)
 		      run.dst->sequence, run.dst->vb2_buf.timestamp);
 
 	visl_tpg_fill(ctx, &run);
-	visl_trace_ctrls(ctx, &run);
 
 	if (bitstream_trace_frame_start > -1 &&
 	    run.dst->sequence >= bitstream_trace_frame_start &&
diff --git a/drivers/media/v4l2-core/v4l2-ctrls-api.c b/drivers/media/v4l2-core/v4l2-ctrls-api.c
index 93d8d4012d0f..8bfcf994c713 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-api.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-api.c
@@ -523,6 +523,12 @@ int v4l2_g_ext_ctrls(struct v4l2_ctrl_handler *hdl, struct video_device *vdev,
 }
 EXPORT_SYMBOL(v4l2_g_ext_ctrls);
 
+static void trace_ext_ctrl(struct v4l2_fh *fh, const struct v4l2_ctrl *ctrl)
+{
+	if (fh && ctrl->type_ops->trace)
+		ctrl->type_ops->trace(fh, ctrl, ctrl->p_new);
+}
+
 /* Validate a new control */
 static int validate_new(const struct v4l2_ctrl *ctrl, union v4l2_ctrl_ptr p_new)
 {
@@ -711,6 +717,10 @@ int try_set_ext_ctrls_common(struct v4l2_fh *fh,
 				idx = helpers[idx].next;
 			} while (!ret && idx);
 		}
+
+		if (!ret && set)
+			trace_ext_ctrl(fh, master);
+
 		v4l2_ctrl_unlock(master);
 	}
 
diff --git a/drivers/media/v4l2-core/v4l2-ctrls-core.c b/drivers/media/v4l2-core/v4l2-ctrls-core.c
index 6e751a043a21..1f29b6a4d5bc 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-core.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-core.c
@@ -10,8 +10,11 @@
 #include <linux/slab.h>
 #include <media/v4l2-ctrls.h>
 #include <media/v4l2-event.h>
+#include <media/v4l2-fh.h>
 #include <media/v4l2-fwnode.h>
 
+#include <trace/events/v4l2_controls.h>
+
 #include "v4l2-ctrls-priv.h"
 
 static const union v4l2_ctrl_ptr ptr_null;
@@ -1546,12 +1549,140 @@ int v4l2_ctrl_type_op_validate(const struct v4l2_ctrl *ctrl,
 }
 EXPORT_SYMBOL(v4l2_ctrl_type_op_validate);
 
+void v4l2_ctrl_type_op_trace(const struct v4l2_fh *fh,
+			     const struct v4l2_ctrl *ctrl, union v4l2_ctrl_ptr ptr)
+{
+	int i = 0;
+
+	switch ((u32)ctrl->type) {
+	case V4L2_CTRL_TYPE_FWHT_PARAMS:
+		trace_v4l2_ctrl_fwht_params(fh->tgid, fh->fd, ptr.p_fwht_params);
+		break;
+	case V4L2_CTRL_TYPE_MPEG2_SEQUENCE:
+		trace_v4l2_ctrl_mpeg2_sequence(fh->tgid, fh->fd, ptr.p_mpeg2_sequence);
+		break;
+	case V4L2_CTRL_TYPE_MPEG2_PICTURE:
+		trace_v4l2_ctrl_mpeg2_picture(fh->tgid, fh->fd, ptr.p_mpeg2_picture);
+		break;
+	case V4L2_CTRL_TYPE_MPEG2_QUANTISATION:
+		trace_v4l2_ctrl_mpeg2_quantisation(fh->tgid, fh->fd, ptr.p_mpeg2_quantisation);
+		break;
+	case V4L2_CTRL_TYPE_VP8_FRAME:
+		trace_v4l2_ctrl_vp8_frame(fh->tgid, fh->fd, ptr.p_vp8_frame);
+		trace_v4l2_ctrl_vp8_entropy(fh->tgid, fh->fd, ptr.p_vp8_frame);
+		break;
+	case V4L2_CTRL_TYPE_VP9_FRAME:
+		trace_v4l2_ctrl_vp9_frame(fh->tgid, fh->fd, ptr.p_vp9_frame);
+		break;
+	case V4L2_CTRL_TYPE_VP9_COMPRESSED_HDR:
+		trace_v4l2_ctrl_vp9_compressed_hdr(fh->tgid, fh->fd,
+						   ptr.p_vp9_compressed_hdr_probs);
+		trace_v4l2_ctrl_vp9_compressed_coeff(fh->tgid, fh->fd,
+						     ptr.p_vp9_compressed_hdr_probs);
+		trace_v4l2_vp9_mv_probs(fh->tgid, fh->fd, &ptr.p_vp9_compressed_hdr_probs->mv);
+		break;
+	case V4L2_CTRL_TYPE_H264_SPS:
+		trace_v4l2_ctrl_h264_sps(fh->tgid, fh->fd, ptr.p_h264_sps);
+		break;
+	case V4L2_CTRL_TYPE_H264_PPS:
+		trace_v4l2_ctrl_h264_pps(fh->tgid, fh->fd, ptr.p_h264_pps);
+		break;
+	case V4L2_CTRL_TYPE_H264_SCALING_MATRIX:
+		trace_v4l2_ctrl_h264_scaling_matrix(fh->tgid, fh->fd, ptr.p_h264_scaling_matrix);
+		break;
+	case V4L2_CTRL_TYPE_H264_SLICE_PARAMS:
+	{
+		struct v4l2_ctrl_h264_slice_params *sp = ptr.p_h264_slice_params;
+
+		trace_v4l2_ctrl_h264_slice_params(fh->tgid, fh->fd, sp);
+
+		for (i = 0; i < ARRAY_SIZE(sp->ref_pic_list0); i++)
+			trace_v4l2_h264_ref_pic_list0(fh->tgid, fh->fd, &sp->ref_pic_list0[i], i);
+		for (i = 0; i < ARRAY_SIZE(sp->ref_pic_list1); i++)
+			trace_v4l2_h264_ref_pic_list1(fh->tgid, fh->fd, &sp->ref_pic_list1[i], i);
+
+		break;
+	}
+	case V4L2_CTRL_TYPE_H264_DECODE_PARAMS:
+	{
+		struct v4l2_ctrl_h264_decode_params *dp = ptr.p_h264_decode_params;
+
+		trace_v4l2_ctrl_h264_decode_params(fh->tgid, fh->fd, dp);
+
+		for (i = 0; i < ARRAY_SIZE(dp->dpb); i++)
+			trace_v4l2_h264_dpb_entry(fh->tgid, fh->fd, &dp->dpb[i], i);
+
+		break;
+	}
+	case V4L2_CTRL_TYPE_H264_PRED_WEIGHTS:
+		trace_v4l2_ctrl_h264_pred_weights(fh->tgid, fh->fd, ptr.p_h264_pred_weights);
+		break;
+	case V4L2_CTRL_TYPE_HEVC_SPS:
+		trace_v4l2_ctrl_hevc_sps(fh->tgid, fh->fd, ptr.p_hevc_sps);
+		break;
+	case V4L2_CTRL_TYPE_HEVC_PPS:
+		trace_v4l2_ctrl_hevc_pps(fh->tgid, fh->fd, ptr.p_hevc_pps);
+		break;
+	case V4L2_CTRL_TYPE_HEVC_SLICE_PARAMS:
+		trace_v4l2_ctrl_hevc_slice_params(fh->tgid, fh->fd, ptr.p_hevc_slice_params);
+		trace_v4l2_hevc_pred_weight_table(fh->tgid, fh->fd,
+						  &ptr.p_hevc_slice_params->pred_weight_table);
+		break;
+	case V4L2_CTRL_TYPE_HEVC_SCALING_MATRIX:
+		trace_v4l2_ctrl_hevc_scaling_matrix(fh->tgid, fh->fd, ptr.p_hevc_scaling_matrix);
+		break;
+	case V4L2_CTRL_TYPE_HEVC_DECODE_PARAMS:
+	{
+		struct v4l2_ctrl_hevc_decode_params *dp = ptr.p_hevc_decode_params;
+
+		trace_v4l2_ctrl_hevc_decode_params(fh->tgid, fh->fd, dp);
+
+		for (i = 0; i < ARRAY_SIZE(dp->dpb); i++)
+			trace_v4l2_hevc_dpb_entry(fh->tgid, fh->fd, &dp->dpb[i]);
+
+		break;
+	}
+	case V4L2_CTRL_TYPE_HEVC_EXT_SPS_ST_RPS:
+	{
+		const struct v4l2_ctrl_hevc_ext_sps_st_rps *st = ptr.p_const;
+
+		for (i = 0; i < ctrl->new_elems; i++)
+			trace_v4l2_ctrl_hevc_ext_sps_st_rps(fh->tgid, fh->fd, &st[i]);
+
+		break;
+	}
+	case V4L2_CTRL_TYPE_HEVC_EXT_SPS_LT_RPS:
+	{
+		const struct v4l2_ctrl_hevc_ext_sps_lt_rps *lt = ptr.p_const;
+
+		for (i = 0; i < ctrl->new_elems; i++)
+			trace_v4l2_ctrl_hevc_ext_sps_lt_rps(fh->tgid, fh->fd, &lt[i]);
+
+		break;
+	}
+	case V4L2_CTRL_TYPE_AV1_SEQUENCE:
+		trace_v4l2_ctrl_av1_sequence(fh->tgid, fh->fd, ptr.p_av1_sequence);
+		break;
+	case V4L2_CTRL_TYPE_AV1_FRAME:
+		trace_v4l2_ctrl_av1_frame(fh->tgid, fh->fd, ptr.p_av1_frame);
+		break;
+	case V4L2_CTRL_TYPE_AV1_FILM_GRAIN:
+		trace_v4l2_ctrl_av1_film_grain(fh->tgid, fh->fd, ptr.p_av1_film_grain);
+		break;
+	case V4L2_CTRL_TYPE_AV1_TILE_GROUP_ENTRY:
+		trace_v4l2_ctrl_av1_tile_group_entry(fh->tgid, fh->fd, ptr.p_av1_tile_group_entry);
+		break;
+	}
+}
+EXPORT_SYMBOL(v4l2_ctrl_type_op_trace);
+
 static const struct v4l2_ctrl_type_ops std_type_ops = {
 	.equal = v4l2_ctrl_type_op_equal,
 	.init = v4l2_ctrl_type_op_init,
 	.minimum = v4l2_ctrl_type_op_minimum,
 	.maximum = v4l2_ctrl_type_op_maximum,
 	.log = v4l2_ctrl_type_op_log,
+	.trace = v4l2_ctrl_type_op_trace,
 	.validate = v4l2_ctrl_type_op_validate,
 };
 
diff --git a/include/media/v4l2-ctrls.h b/include/media/v4l2-ctrls.h
index 6e363262c868..976f9b05af9a 100644
--- a/include/media/v4l2-ctrls.h
+++ b/include/media/v4l2-ctrls.h
@@ -140,6 +140,7 @@ struct v4l2_ctrl_ops {
  * @minimum: set the value to the minimum value of the control.
  * @maximum: set the value to the maximum value of the control.
  * @log: log the value.
+ * @trace: trace the value of the control with Ftrace.
  * @validate: validate the value for ctrl->new_elems array elements.
  *	Return 0 on success and a negative value otherwise.
  */
@@ -153,6 +154,8 @@ struct v4l2_ctrl_type_ops {
 	void (*maximum)(const struct v4l2_ctrl *ctrl, u32 idx,
 			union v4l2_ctrl_ptr ptr);
 	void (*log)(const struct v4l2_ctrl *ctrl);
+	void (*trace)(const struct v4l2_fh *fh,
+		      const struct v4l2_ctrl *ctrl, union v4l2_ctrl_ptr ptr);
 	int (*validate)(const struct v4l2_ctrl *ctrl, union v4l2_ctrl_ptr ptr);
 };
 
@@ -1633,6 +1636,18 @@ void v4l2_ctrl_type_op_init(const struct v4l2_ctrl *ctrl, u32 from_idx,
  */
 void v4l2_ctrl_type_op_log(const struct v4l2_ctrl *ctrl);
 
+/**
+ * v4l2_ctrl_type_op_trace - Default v4l2_ctrl_type_ops trace callback.
+ *
+ * @fh: The v4l2_fh of the current context.
+ * @ctrl: The v4l2_ctrl pointer.
+ * @ptr: The v4l2 control value.
+ *
+ * Return: void
+ */
+void v4l2_ctrl_type_op_trace(const struct v4l2_fh *fh,
+			     const struct v4l2_ctrl *ctrl, union v4l2_ctrl_ptr ptr);
+
 /**
  * v4l2_ctrl_type_op_validate - Default v4l2_ctrl_type_ops validate callback.
  *

-- 
2.56.1

