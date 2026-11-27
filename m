Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795797950;
	b=mypfSKOuQ1T/LHFqkbW7M8pXxvRBdQTNOLVUNuHEQrqfc7YYHW+N5w8pzriB9q7gtGB+
	 B+ZEXDzOOUk7N/r7wHPXo6kKQAGPRXyA+vwwgajBOTwR0SHVdFvQTrwONiU6Tt2fb823u
	 qEAOlkIZWzJtbbSu5CuimDAvHYb1vWgvtkdVTlBih40gHAP8U4lv1WGsVWkAYQeQ0gwtO
	 NhG8rdI2zKdjX14JXDXua0Z1juePW4fZTdOuqFPIPXZElqb4Xbd2kTFAuaSMCy+h7O2o5
	 2jK3CMmr9vq1/3lSfPkrPRRS+D6XJdq4IX8BjhJjhjpHq+ZW+OMBu7PIUdaES+fXhJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795797950;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=co7zShS+Kk0RBR0RZlUh9WdEHrY5BKMrhKQ1kpoLELE=;
	b=SmhKpAO/Ij7S94l2O41FPZgTONELViGqYP64VBaurWtuGnxiQdMU3/2wshrKMR2uCICN
	 9r0kwfLttiGezx8Mx6W8ccMnwUkfAZR/jOj0Vu0YzZ20wPZpSA3++ol/IH+c60s17qjSY
	 lZtkjX7/3IuOoPOWoOe6nSPRY5ABfxxIZdp5OVlThpbxnjYI7H/2D3E9wKFrLjGVmHa2F
	 vqWQcI/DKW4EDq2EFoxz8x/Zw7PLep+aetNejM++x+FXqCe1B2YnmEk0fKbh20nwgZfE9
	 8rdegb5FL6q3pM/SkIRIbHP4x0Fz4iBUS6NpB3UwAvPmOVANLWrWQTnjcKTI+LbNaiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=i7k50nHW;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4D1606A33C;
	Fri, 27 Nov 2026 16:45:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A4D1606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=i7k50nHW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795797947;
	bh=ZxI3VM41OSJ/MVGbsER/HHF9mfBCRWBHKuHc8TsV2Jw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=i7k50nHWnikNEss7yslyFXlgU3SLfl4kzhxZtZ/Jw2kkB98QptbMeO4s0V8lDiOU6
	 gWSQKRDuNJSOeGx0t5vZQ9HUhuH+w60pMMoTEgWR7aAhj6QIWq8OCMI430O7TA6fI5
	 SxyXBv+mLYX5jWmK9RIF/DkclZC5NjesG5WSguHBT6KkjWRAAoyb48W/ll7qH3wEVX
	 r/1cym58xiwzY3XgxBIpe21oMQsQ6jgT3LZ0UonnWcYPZZKrlVWq9CkuvD0nYI1MXV
	 pwVYB4HYZYmawgOkANo32j/nCrcdhDh3Km/YZ69H924lmzJF1eaweDprk42fLbe/OW
	 Yhz3ofJcgQ8gg==
Received: from [192.168.0.15] (unknown [100.64.0.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5C35017E0887;
	Fri, 27 Nov 2026 17:45:45 +0100 (CET)
From: Detlev Casanova <detlev.casanova@collabora.com>
Date: Fri, 27 Nov 2026 11:45:08 -0500
Subject: [PATCH v4 4/9] media: Add tgid and fd to the v4l2-requests trace
 fields
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
Message-Id: <20261127-v4l2-add-ftrace-v4-4-24138479002f@collabora.com>
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

With these fields, userspace can better track which trace event matches
with a given stream.

Even though the trace shows the PID (based on current->tgid), trace
functions could be called from other contexts, therefore showing the wrong
PID, or none at all.

These will ensure that the trace event can be matched with the PID/FD that
opened and configured the video device file.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 drivers/media/test-drivers/visl/visl-dec.c |  68 ++--
 include/trace/events/v4l2_controls.h       | 630 +++++++++++++++++++----------
 2 files changed, 447 insertions(+), 251 deletions(-)

diff --git a/drivers/media/test-drivers/visl/visl-dec.c b/drivers/media/test-drivers/visl/visl-dec.c
index 1c66a1b8d78f..2a065a6249ad 100644
--- a/drivers/media/test-drivers/visl/visl-dec.c
+++ b/drivers/media/test-drivers/visl/visl-dec.c
@@ -489,67 +489,71 @@ static void visl_tpg_fill(struct visl_ctx *ctx, struct visl_run *run)
 static void visl_trace_ctrls(struct visl_ctx *ctx, struct visl_run *run)
 {
 	int i;
+	struct v4l2_fh *fh = &ctx->fh;
 
 	switch (ctx->current_codec) {
 	default:
 	case VISL_CODEC_NONE:
 		break;
 	case VISL_CODEC_FWHT:
-		trace_v4l2_ctrl_fwht_params(run->fwht.params);
+		trace_v4l2_ctrl_fwht_params(fh->tgid, fh->fd, run->fwht.params);
 		break;
 	case VISL_CODEC_MPEG2:
-		trace_v4l2_ctrl_mpeg2_sequence(run->mpeg2.seq);
-		trace_v4l2_ctrl_mpeg2_picture(run->mpeg2.pic);
-		trace_v4l2_ctrl_mpeg2_quantisation(run->mpeg2.quant);
+		trace_v4l2_ctrl_mpeg2_sequence(fh->tgid, fh->fd, run->mpeg2.seq);
+		trace_v4l2_ctrl_mpeg2_picture(fh->tgid, fh->fd, run->mpeg2.pic);
+		trace_v4l2_ctrl_mpeg2_quantisation(fh->tgid, fh->fd, run->mpeg2.quant);
 		break;
 	case VISL_CODEC_VP8:
-		trace_v4l2_ctrl_vp8_frame(run->vp8.frame);
-		trace_v4l2_ctrl_vp8_entropy(run->vp8.frame);
+		trace_v4l2_ctrl_vp8_frame(fh->tgid, fh->fd, run->vp8.frame);
+		trace_v4l2_ctrl_vp8_entropy(fh->tgid, fh->fd, run->vp8.frame);
 		break;
 	case VISL_CODEC_VP9:
-		trace_v4l2_ctrl_vp9_frame(run->vp9.frame);
-		trace_v4l2_ctrl_vp9_compressed_hdr(run->vp9.probs);
-		trace_v4l2_ctrl_vp9_compressed_coeff(run->vp9.probs);
-		trace_v4l2_vp9_mv_probs(&run->vp9.probs->mv);
+		trace_v4l2_ctrl_vp9_frame(fh->tgid, fh->fd, run->vp9.frame);
+		trace_v4l2_ctrl_vp9_compressed_hdr(fh->tgid, fh->fd, run->vp9.probs);
+		trace_v4l2_ctrl_vp9_compressed_coeff(fh->tgid, fh->fd, run->vp9.probs);
+		trace_v4l2_vp9_mv_probs(fh->tgid, fh->fd, &run->vp9.probs->mv);
 		break;
 	case VISL_CODEC_H264:
-		trace_v4l2_ctrl_h264_sps(run->h264.sps);
-		trace_v4l2_ctrl_h264_pps(run->h264.pps);
-		trace_v4l2_ctrl_h264_scaling_matrix(run->h264.sm);
-		trace_v4l2_ctrl_h264_slice_params(run->h264.spram);
+		trace_v4l2_ctrl_h264_sps(fh->tgid, fh->fd, run->h264.sps);
+		trace_v4l2_ctrl_h264_pps(fh->tgid, fh->fd, run->h264.pps);
+		trace_v4l2_ctrl_h264_scaling_matrix(fh->tgid, fh->fd, run->h264.sm);
+		trace_v4l2_ctrl_h264_slice_params(fh->tgid, fh->fd, run->h264.spram);
 
 		for (i = 0; i < ARRAY_SIZE(run->h264.spram->ref_pic_list0); i++)
-			trace_v4l2_h264_ref_pic_list0(&run->h264.spram->ref_pic_list0[i], i);
+			trace_v4l2_h264_ref_pic_list0(fh->tgid, fh->fd,
+						      &run->h264.spram->ref_pic_list0[i], i);
 		for (i = 0; i < ARRAY_SIZE(run->h264.spram->ref_pic_list0); i++)
-			trace_v4l2_h264_ref_pic_list1(&run->h264.spram->ref_pic_list1[i], i);
+			trace_v4l2_h264_ref_pic_list1(fh->tgid, fh->fd,
+						      &run->h264.spram->ref_pic_list1[i], i);
 
-		trace_v4l2_ctrl_h264_decode_params(run->h264.dpram);
+		trace_v4l2_ctrl_h264_decode_params(fh->tgid, fh->fd, run->h264.dpram);
 
 		for (i = 0; i < ARRAY_SIZE(run->h264.dpram->dpb); i++)
-			trace_v4l2_h264_dpb_entry(&run->h264.dpram->dpb[i], i);
+			trace_v4l2_h264_dpb_entry(fh->tgid, fh->fd, &run->h264.dpram->dpb[i], i);
 
-		trace_v4l2_ctrl_h264_pred_weights(run->h264.pwht);
+		trace_v4l2_ctrl_h264_pred_weights(fh->tgid, fh->fd, run->h264.pwht);
 		break;
 	case VISL_CODEC_HEVC:
-		trace_v4l2_ctrl_hevc_sps(run->hevc.sps);
-		trace_v4l2_ctrl_hevc_pps(run->hevc.pps);
-		trace_v4l2_ctrl_hevc_slice_params(run->hevc.spram);
-		trace_v4l2_ctrl_hevc_scaling_matrix(run->hevc.sm);
-		trace_v4l2_ctrl_hevc_decode_params(run->hevc.dpram);
+		trace_v4l2_ctrl_hevc_sps(fh->tgid, fh->fd, run->hevc.sps);
+		trace_v4l2_ctrl_hevc_pps(fh->tgid, fh->fd, run->hevc.pps);
+		trace_v4l2_ctrl_hevc_slice_params(fh->tgid, fh->fd, run->hevc.spram);
+		trace_v4l2_ctrl_hevc_scaling_matrix(fh->tgid, fh->fd, run->hevc.sm);
+		trace_v4l2_ctrl_hevc_decode_params(fh->tgid, fh->fd, run->hevc.dpram);
 
 		for (i = 0; i < ARRAY_SIZE(run->hevc.dpram->dpb); i++)
-			trace_v4l2_hevc_dpb_entry(&run->hevc.dpram->dpb[i]);
+			trace_v4l2_hevc_dpb_entry(fh->tgid, fh->fd, &run->hevc.dpram->dpb[i]);
 
-		trace_v4l2_hevc_pred_weight_table(&run->hevc.spram->pred_weight_table);
-		trace_v4l2_ctrl_hevc_ext_sps_lt_rps(run->hevc.rps_lt);
-		trace_v4l2_ctrl_hevc_ext_sps_st_rps(run->hevc.rps_st);
 
+		trace_v4l2_hevc_pred_weight_table(fh->tgid, fh->fd,
+						  &run->hevc.spram->pred_weight_table);
+		trace_v4l2_ctrl_hevc_ext_sps_lt_rps(fh->tgid, fh->fd, run->hevc.rps_lt);
+		trace_v4l2_ctrl_hevc_ext_sps_st_rps(fh->tgid, fh->fd, run->hevc.rps_st);
 		break;
 	case VISL_CODEC_AV1:
-		trace_v4l2_ctrl_av1_sequence(run->av1.seq);
-		trace_v4l2_ctrl_av1_frame(run->av1.frame);
-		trace_v4l2_ctrl_av1_film_grain(run->av1.grain);
-		trace_v4l2_ctrl_av1_tile_group_entry(run->av1.tge);
+		trace_v4l2_ctrl_av1_sequence(fh->tgid, fh->fd, run->av1.seq);
+		trace_v4l2_ctrl_av1_frame(fh->tgid, fh->fd, run->av1.frame);
+		trace_v4l2_ctrl_av1_film_grain(fh->tgid, fh->fd, run->av1.grain);
+		trace_v4l2_ctrl_av1_tile_group_entry(fh->tgid, fh->fd, run->av1.tge);
 		break;
 	}
 }
diff --git a/include/trace/events/v4l2_controls.h b/include/trace/events/v4l2_controls.h
index f3a46569072e..d80e39078d01 100644
--- a/include/trace/events/v4l2_controls.h
+++ b/include/trace/events/v4l2_controls.h
@@ -17,27 +17,39 @@
  * They can be identified by the name of the event. All control fields are copied in a TP_STRUCT
  * field so that they can be filtered separately in userspace.
  *
+ * In addition to the controls fields, tgid and fd are also added in each trace events.
+ * This allows to identify controls set by a specific process and to match them with other events
+ * from the same process.
+ * tgid contains the process id that opened the video device.
+ * fd is the file descriptor in the tgid, used in case a process opens multiple video devices.
+ *
  * Currently only the codec controls are supported.
  */
 
 /* AV1 controls */
 DECLARE_EVENT_CLASS(v4l2_ctrl_av1_seq_tmpl,
-	TP_PROTO(const struct v4l2_ctrl_av1_sequence *s),
-	TP_ARGS(s),
-	TP_STRUCT__entry(__field(__u32, flags)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_ctrl_av1_sequence *s),
+	TP_ARGS(tgid, fd, s),
+	TP_STRUCT__entry(__field(u32, tgid)
+			 __field(s32, fd)
+			 __field(__u32, flags)
 			 __field(__u8, seq_profile)
 			 __field(__u8, order_hint_bits)
 			 __field(__u8, bit_depth)
 			 __field(__u16, max_frame_width_minus_1)
 			 __field(__u16, max_frame_height_minus_1)),
-	TP_fast_assign(__entry->flags = s->flags;
+	TP_fast_assign(__entry->tgid = tgid;
+		       __entry->fd = fd;
+		       __entry->flags = s->flags;
 		       __entry->seq_profile = s->seq_profile;
 		       __entry->order_hint_bits = s->order_hint_bits;
 		       __entry->bit_depth = s->bit_depth;
 		       __entry->max_frame_width_minus_1 = s->max_frame_width_minus_1;
 		       __entry->max_frame_height_minus_1 = s->max_frame_height_minus_1;),
-	TP_printk("\nflags %s\nseq_profile: %u\norder_hint_bits: %u\nbit_depth: %u\n"
+	TP_printk("tgid = %u, fd = %d\n"
+		  "flags %s\nseq_profile: %u\norder_hint_bits: %u\nbit_depth: %u\n"
 		  "max_frame_width_minus_1: %u\nmax_frame_height_minus_1: %u\n",
+		  __entry->tgid, __entry->fd,
 		  __print_flags(__entry->flags, "|",
 		  V4L2_FLAG(AV1_SEQUENCE, STILL_PICTURE),
 		  V4L2_FLAG(AV1_SEQUENCE, USE_128X128_SUPERBLOCK),
@@ -68,17 +80,23 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_av1_seq_tmpl,
 );
 
 DECLARE_EVENT_CLASS(v4l2_ctrl_av1_tge_tmpl,
-	TP_PROTO(const struct v4l2_ctrl_av1_tile_group_entry *t),
-	TP_ARGS(t),
-	TP_STRUCT__entry(__field(__u32, tile_offset)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_ctrl_av1_tile_group_entry *t),
+	TP_ARGS(tgid, fd, t),
+	TP_STRUCT__entry(__field(u32, tgid)
+			 __field(s32, fd)
+			 __field(__u32, tile_offset)
 			 __field(__u32, tile_size)
 			 __field(__u32, tile_row)
 			 __field(__u32, tile_col)),
-	TP_fast_assign(__entry->tile_offset = t->tile_offset;
+	TP_fast_assign(__entry->tgid = tgid;
+		       __entry->fd = fd;
+		       __entry->tile_offset = t->tile_offset;
 		       __entry->tile_size = t->tile_size;
 		       __entry->tile_row = t->tile_row;
 		       __entry->tile_col = t->tile_col;),
-	TP_printk("\ntile_offset: %u\n tile_size: %u\n tile_row: %u\ntile_col: %u\n",
+	TP_printk("tgid = %u, fd = %d\n"
+		  "tile_offset: %u\n tile_size: %u\n tile_row: %u\ntile_col: %u\n",
+		  __entry->tgid, __entry->fd,
 		  __entry->tile_offset,
 		  __entry->tile_size,
 		  __entry->tile_row,
@@ -87,9 +105,11 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_av1_tge_tmpl,
 );
 
 DECLARE_EVENT_CLASS(v4l2_ctrl_av1_frame_tmpl,
-	TP_PROTO(const struct v4l2_ctrl_av1_frame *f),
-	TP_ARGS(f),
-	TP_STRUCT__entry(__field(u8, tile_info_flags)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_ctrl_av1_frame *f),
+	TP_ARGS(tgid, fd, f),
+	TP_STRUCT__entry(__field(u32, tgid)
+			 __field(s32, fd)
+			 __field(u8, tile_info_flags)
 			 __field(u8, tile_info_context_update_tile_id)
 			 __field(u8, tile_info_tile_cols)
 			 __field(u8, tile_info_tile_rows)
@@ -147,7 +167,9 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_av1_frame_tmpl,
 			 __array(u64, reference_frame_ts, V4L2_AV1_TOTAL_REFS_PER_FRAME)
 			 __array(s8, ref_frame_idx, V4L2_AV1_REFS_PER_FRAME)
 			 __field(u8, refresh_frame_flags)),
-	TP_fast_assign(__entry->tile_info_flags = f->tile_info.flags;
+	TP_fast_assign(__entry->tgid = tgid;
+		       __entry->fd = fd;
+		       __entry->tile_info_flags = f->tile_info.flags;
 		       __entry->tile_info_context_update_tile_id =
 				f->tile_info.context_update_tile_id;
 		       __entry->tile_info_tile_cols = f->tile_info.tile_cols;
@@ -229,7 +251,8 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_av1_frame_tmpl,
 		       memcpy(__entry->ref_frame_idx, f->ref_frame_idx,
 			      sizeof(__entry->ref_frame_idx));
 		       __entry->refresh_frame_flags = f->refresh_frame_flags;),
-	TP_printk("\ntile_info.flags: %s\ntile_info.context_update_tile_id: %u\n"
+	TP_printk("tgid = %u, fd = %d\n"
+		  "tile_info.flags: %s\ntile_info.context_update_tile_id: %u\n"
 		  "tile_info.tile_cols: %u\ntile_info.tile_rows: %u\n"
 		  "tile_info.mi_col_starts: %s\ntile_info.mi_row_starts: %s\n"
 		  "tile_info.width_in_sbs_minus_1: %s\ntile_info.height_in_sbs_minus_1: %s\n"
@@ -253,6 +276,7 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_av1_frame_tmpl,
 		  "render_width_minus_1: %u\nrender_height_minus_1: %u\ncurrent_frame_id: %u\n"
 		  "buffer_removal_time: %s\norder_hints: %s\nreference_frame_ts: %s\n"
 		  "ref_frame_idx: %s\nrefresh_frame_flags: %u\n",
+		  __entry->tgid, __entry->fd,
 		  __print_flags(__entry->tile_info_flags, "|",
 		  V4L2_FLAG(AV1_TILE_INFO, UNIFORM_TILE_SPACING)),
 		  __entry->tile_info_context_update_tile_id,
@@ -387,9 +411,11 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_av1_frame_tmpl,
 );
 
 DECLARE_EVENT_CLASS(v4l2_ctrl_av1_film_grain_tmpl,
-	TP_PROTO(const struct v4l2_ctrl_av1_film_grain *f),
-	TP_ARGS(f),
-	TP_STRUCT__entry(__field(__u8, flags)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_ctrl_av1_film_grain *f),
+	TP_ARGS(tgid, fd, f),
+	TP_STRUCT__entry(__field(u32, tgid)
+			 __field(s32, fd)
+			 __field(__u8, flags)
 			 __field(__u8, cr_mult)
 			 __field(__u16, grain_seed)
 			 __field(__u8, film_grain_params_ref_idx)
@@ -414,7 +440,9 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_av1_film_grain_tmpl,
 			 __field(__u8, cr_luma_mult)
 			 __field(__u16, cb_offset)
 			 __field(__u16, cr_offset)),
-	TP_fast_assign(__entry->flags = f->flags;
+	TP_fast_assign(__entry->tgid = tgid;
+		       __entry->fd = fd;
+		       __entry->flags = f->flags;
 		       __entry->cr_mult = f->cr_mult;
 		       __entry->grain_seed = f->grain_seed;
 		       __entry->film_grain_params_ref_idx = f->film_grain_params_ref_idx;
@@ -448,7 +476,8 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_av1_film_grain_tmpl,
 		       __entry->cr_luma_mult = f->cr_luma_mult;
 		       __entry->cb_offset = f->cb_offset;
 		       __entry->cr_offset = f->cr_offset;),
-	TP_printk("\nflags %s\ncr_mult: %u\ngrain_seed: %u\n"
+	TP_printk("tgid = %u, fd = %d\n"
+		  "flags %s\ncr_mult: %u\ngrain_seed: %u\n"
 		  "film_grain_params_ref_idx: %u\nnum_y_points: %u\npoint_y_value: %s\n"
 		  "point_y_scaling: %s\nnum_cb_points: %u\npoint_cb_value: %s\n"
 		  "point_cb_scaling: %s\nnum_cr_points: %u\npoint_cr_value: %s\n"
@@ -457,6 +486,7 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_av1_film_grain_tmpl,
 		  "ar_coeffs_cr_plus_128: %s\nar_coeff_shift_minus_6: %u\n"
 		  "grain_scale_shift: %u\ncb_mult: %u\ncb_luma_mult: %u\ncr_luma_mult: %u\n"
 		  "cb_offset: %u\ncr_offset: %u\n",
+		  __entry->tgid, __entry->fd,
 		  __print_flags(__entry->flags, "|",
 		  V4L2_FLAG(AV1_FILM_GRAIN, APPLY_GRAIN),
 		  V4L2_FLAG(AV1_FILM_GRAIN, UPDATE_GRAIN),
@@ -509,31 +539,33 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_av1_film_grain_tmpl,
 )
 
 DEFINE_EVENT(v4l2_ctrl_av1_seq_tmpl, v4l2_ctrl_av1_sequence,
-	TP_PROTO(const struct v4l2_ctrl_av1_sequence *s),
-	TP_ARGS(s)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_ctrl_av1_sequence *s),
+	TP_ARGS(tgid, fd, s)
 );
 
 DEFINE_EVENT(v4l2_ctrl_av1_frame_tmpl, v4l2_ctrl_av1_frame,
-	TP_PROTO(const struct v4l2_ctrl_av1_frame *f),
-	TP_ARGS(f)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_ctrl_av1_frame *f),
+	TP_ARGS(tgid, fd, f)
 );
 
 DEFINE_EVENT(v4l2_ctrl_av1_tge_tmpl, v4l2_ctrl_av1_tile_group_entry,
-	TP_PROTO(const struct v4l2_ctrl_av1_tile_group_entry *t),
-	TP_ARGS(t)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_ctrl_av1_tile_group_entry *t),
+	TP_ARGS(tgid, fd, t)
 );
 
 DEFINE_EVENT(v4l2_ctrl_av1_film_grain_tmpl, v4l2_ctrl_av1_film_grain,
-	TP_PROTO(const struct v4l2_ctrl_av1_film_grain *f),
-	TP_ARGS(f)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_ctrl_av1_film_grain *f),
+	TP_ARGS(tgid, fd, f)
 );
 
 /* FWHT controls */
 
 DECLARE_EVENT_CLASS(v4l2_ctrl_fwht_params_tmpl,
-	TP_PROTO(const struct v4l2_ctrl_fwht_params *p),
-	TP_ARGS(p),
-	TP_STRUCT__entry(__field(u64, backward_ref_ts)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_ctrl_fwht_params *p),
+	TP_ARGS(tgid, fd, p),
+	TP_STRUCT__entry(__field(u32, tgid)
+			 __field(s32, fd)
+			 __field(u64, backward_ref_ts)
 			 __field(u32, version)
 			 __field(u32, width)
 			 __field(u32, height)
@@ -543,7 +575,9 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_fwht_params_tmpl,
 			 __field(u32, ycbcr_enc)
 			 __field(u32, quantization)
 			 ),
-	TP_fast_assign(__entry->backward_ref_ts = p->backward_ref_ts;
+	TP_fast_assign(__entry->tgid = tgid;
+		       __entry->fd = fd;
+		       __entry->backward_ref_ts = p->backward_ref_ts;
 		       __entry->version = p->version;
 		       __entry->width = p->width;
 		       __entry->height = p->height;
@@ -553,7 +587,8 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_fwht_params_tmpl,
 		       __entry->ycbcr_enc = p->ycbcr_enc;
 		       __entry->quantization = p->quantization;
 		       ),
-	TP_printk("backward_ref_ts %llu\n"
+	TP_printk("tgid = %u, fd = %d\n"
+		  "backward_ref_ts %llu\n"
 		  "version %u\n"
 		  "width %u\n"
 		  "height %u\n"
@@ -562,6 +597,7 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_fwht_params_tmpl,
 		  "xfer_func %u\n"
 		  "ycbcr_enc %u\n"
 		  "quantization %u\n",
+		  __entry->tgid, __entry->fd,
 		  __entry->backward_ref_ts, __entry->version, __entry->width, __entry->height,
 		  __print_flags(__entry->flags, "|",
 		  {V4L2_FWHT_FL_IS_INTERLACED, "IS_INTERLACED"},
@@ -581,16 +617,18 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_fwht_params_tmpl,
 );
 
 DEFINE_EVENT(v4l2_ctrl_fwht_params_tmpl, v4l2_ctrl_fwht_params,
-	TP_PROTO(const struct v4l2_ctrl_fwht_params *p),
-	TP_ARGS(p)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_ctrl_fwht_params *p),
+	TP_ARGS(tgid, fd, p)
 );
 
 /* H264 controls */
 
 DECLARE_EVENT_CLASS(v4l2_ctrl_h264_sps_tmpl,
-	TP_PROTO(const struct v4l2_ctrl_h264_sps *s),
-	TP_ARGS(s),
-	TP_STRUCT__entry(__field(u8, profile_idc)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_ctrl_h264_sps *s),
+	TP_ARGS(tgid, fd, s),
+	TP_STRUCT__entry(__field(u32, tgid)
+			 __field(s32, fd)
+			 __field(u8, profile_idc)
 			 __field(u8, constraint_set_flags)
 			 __field(u8, level_idc)
 			 __field(u8, seq_parameter_set_id)
@@ -608,7 +646,9 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_h264_sps_tmpl,
 			 __field(u16, pic_width_in_mbs_minus1)
 			 __field(u16, pic_height_in_map_units_minus1)
 			 __field(u32, flags)),
-	TP_fast_assign(__entry->profile_idc = s->profile_idc;
+	TP_fast_assign(__entry->tgid = tgid;
+		       __entry->fd = fd;
+		       __entry->profile_idc = s->profile_idc;
 		       __entry->constraint_set_flags = s->constraint_set_flags;
 		       __entry->level_idc = s->level_idc;
 		       __entry->seq_parameter_set_id = s->seq_parameter_set_id;
@@ -629,7 +669,8 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_h264_sps_tmpl,
 		       __entry->pic_width_in_mbs_minus1 = s->pic_width_in_mbs_minus1;
 		       __entry->pic_height_in_map_units_minus1 = s->pic_height_in_map_units_minus1;
 		       __entry->flags = s->flags),
-	TP_printk("\nprofile_idc %u\n"
+	TP_printk("tgid = %u, fd = %d\n"
+		  "profile_idc %u\n"
 		  "constraint_set_flags %s\n"
 		  "level_idc %u\n"
 		  "seq_parameter_set_id %u\n"
@@ -647,6 +688,7 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_h264_sps_tmpl,
 		  "pic_width_in_mbs_minus1 %u\n"
 		  "pic_height_in_map_units_minus1 %u\n"
 		  "flags %s",
+		  __entry->tgid, __entry->fd,
 		  __entry->profile_idc,
 		  __print_flags(__entry->constraint_set_flags, "|",
 		  {V4L2_H264_SPS_CONSTRAINT_SET0_FLAG, "CONSTRAINT_SET0_FLAG"},
@@ -686,9 +728,11 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_h264_sps_tmpl,
 );
 
 DECLARE_EVENT_CLASS(v4l2_ctrl_h264_pps_tmpl,
-	TP_PROTO(const struct v4l2_ctrl_h264_pps *p),
-	TP_ARGS(p),
-	TP_STRUCT__entry(__field(u8, pic_parameter_set_id)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_ctrl_h264_pps *p),
+	TP_ARGS(tgid, fd, p),
+	TP_STRUCT__entry(__field(u32, tgid)
+			 __field(s32, fd)
+			 __field(u8, pic_parameter_set_id)
 			 __field(u8, seq_parameter_set_id)
 			 __field(u8, num_slice_groups_minus1)
 			 __field(u8, num_ref_idx_l0_default_active_minus1)
@@ -699,7 +743,9 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_h264_pps_tmpl,
 			 __field(__s8, chroma_qp_index_offset)
 			 __field(__s8, second_chroma_qp_index_offset)
 			 __field(u16, flags)),
-	TP_fast_assign(__entry->pic_parameter_set_id = p->pic_parameter_set_id;
+	TP_fast_assign(__entry->tgid = tgid;
+		       __entry->fd = fd;
+		       __entry->pic_parameter_set_id = p->pic_parameter_set_id;
 		       __entry->seq_parameter_set_id = p->seq_parameter_set_id;
 		       __entry->num_slice_groups_minus1 = p->num_slice_groups_minus1;
 		       __entry->num_ref_idx_l0_default_active_minus1 =
@@ -712,7 +758,8 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_h264_pps_tmpl,
 		       __entry->chroma_qp_index_offset = p->chroma_qp_index_offset;
 		       __entry->second_chroma_qp_index_offset = p->second_chroma_qp_index_offset;
 		       __entry->flags = p->flags),
-	TP_printk("\npic_parameter_set_id %u\n"
+	TP_printk("tgid = %u, fd = %d\n"
+		  "pic_parameter_set_id %u\n"
 		  "seq_parameter_set_id %u\n"
 		  "num_slice_groups_minus1 %u\n"
 		  "num_ref_idx_l0_default_active_minus1 %u\n"
@@ -723,6 +770,7 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_h264_pps_tmpl,
 		  "chroma_qp_index_offset %d\n"
 		  "second_chroma_qp_index_offset %d\n"
 		  "flags %s",
+		  __entry->tgid, __entry->fd,
 		  __entry->pic_parameter_set_id,
 		  __entry->seq_parameter_set_id,
 		  __entry->num_slice_groups_minus1,
@@ -748,15 +796,21 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_h264_pps_tmpl,
 );
 
 DECLARE_EVENT_CLASS(v4l2_ctrl_h264_scaling_matrix_tmpl,
-	TP_PROTO(const struct v4l2_ctrl_h264_scaling_matrix *s),
-	TP_ARGS(s),
-	TP_STRUCT__entry(__array(u8, scaling_list_4x4, 6 * 16)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_ctrl_h264_scaling_matrix *s),
+	TP_ARGS(tgid, fd, s),
+	TP_STRUCT__entry(__field(u32, tgid)
+			 __field(s32, fd)
+			 __array(u8, scaling_list_4x4, 6 * 16)
 			 __array(u8, scaling_list_8x8, 6 * 64)),
-	TP_fast_assign(memcpy(__entry->scaling_list_4x4, s->scaling_list_4x4,
+	TP_fast_assign(__entry->tgid = tgid;
+		       __entry->fd = fd;
+		       memcpy(__entry->scaling_list_4x4, s->scaling_list_4x4,
 			      sizeof(__entry->scaling_list_4x4));
 		       memcpy(__entry->scaling_list_8x8, s->scaling_list_8x8,
 			      sizeof(__entry->scaling_list_8x8))),
-	TP_printk("\nscaling_list_4x4 {%s}\nscaling_list_8x8 {%s}",
+	TP_printk("tgid = %u, fd = %d\n"
+		  "scaling_list_4x4 {%s}\nscaling_list_8x8 {%s}",
+		  __entry->tgid, __entry->fd,
 		  __print_hex_dump("", DUMP_PREFIX_NONE, 32, 1,
 				   __entry->scaling_list_4x4,
 				   sizeof(__entry->scaling_list_4x4),
@@ -769,9 +823,11 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_h264_scaling_matrix_tmpl,
 );
 
 DECLARE_EVENT_CLASS(v4l2_ctrl_h264_pred_weights_tmpl,
-	TP_PROTO(const struct v4l2_ctrl_h264_pred_weights *p),
-	TP_ARGS(p),
-	TP_STRUCT__entry(__field(u16, luma_log2_weight_denom)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_ctrl_h264_pred_weights *p),
+	TP_ARGS(tgid, fd, p),
+	TP_STRUCT__entry(__field(u32, tgid)
+			 __field(s32, fd)
+			 __field(u16, luma_log2_weight_denom)
 			 __field(u16, chroma_log2_weight_denom)
 			 __array(__s16, weight_factors_0_luma_weight, 32)
 			 __array(__s16, weight_factors_0_luma_offset, 32)
@@ -781,7 +837,9 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_h264_pred_weights_tmpl,
 			 __array(__s16, weight_factors_1_luma_offset, 32)
 			 __array(__s16, weight_factors_1_chroma_weight, 32 * 2)
 			 __array(__s16, weight_factors_1_chroma_offset, 32 * 2)),
-	TP_fast_assign(__entry->luma_log2_weight_denom = p->luma_log2_weight_denom;
+	TP_fast_assign(__entry->tgid = tgid;
+		       __entry->fd = fd;
+		       __entry->luma_log2_weight_denom = p->luma_log2_weight_denom;
 		       __entry->chroma_log2_weight_denom = p->chroma_log2_weight_denom;
 		       memcpy(__entry->weight_factors_0_luma_weight,
 			      p->weight_factors[0].luma_weight,
@@ -807,7 +865,8 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_h264_pred_weights_tmpl,
 		       memcpy(__entry->weight_factors_1_chroma_offset,
 			      p->weight_factors[1].chroma_offset,
 			      sizeof(__entry->weight_factors_1_chroma_offset))),
-	TP_printk("\nluma_log2_weight_denom %u\n"
+	TP_printk("tgid = %u, fd = %d\n"
+		  "luma_log2_weight_denom %u\n"
 		  "chroma_log2_weight_denom %u\n"
 		  "weight_factor[0].luma_weight %s\n"
 		  "weight_factor[0].luma_offset %s\n"
@@ -817,6 +876,7 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_h264_pred_weights_tmpl,
 		  "weight_factor[1].luma_offset %s\n"
 		  "weight_factor[1].chroma_weight {%s}\n"
 		  "weight_factor[1].chroma_offset {%s}\n",
+		  __entry->tgid, __entry->fd,
 		  __entry->luma_log2_weight_denom,
 		  __entry->chroma_log2_weight_denom,
 		  __print_array(__entry->weight_factors_0_luma_weight,
@@ -851,9 +911,11 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_h264_pred_weights_tmpl,
 );
 
 DECLARE_EVENT_CLASS(v4l2_ctrl_h264_slice_params_tmpl,
-	TP_PROTO(const struct v4l2_ctrl_h264_slice_params *s),
-	TP_ARGS(s),
-	TP_STRUCT__entry(__field(u32, header_bit_size)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_ctrl_h264_slice_params *s),
+	TP_ARGS(tgid, fd, s),
+	TP_STRUCT__entry(__field(u32, tgid)
+			 __field(s32, fd)
+			 __field(u32, header_bit_size)
 			 __field(u32, first_mb_in_slice)
 			 __field(u8, slice_type)
 			 __field(u8, colour_plane_id)
@@ -867,7 +929,9 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_h264_slice_params_tmpl,
 			 __field(u8, num_ref_idx_l0_active_minus1)
 			 __field(u8, num_ref_idx_l1_active_minus1)
 			 __field(u32, flags)),
-	TP_fast_assign(__entry->header_bit_size = s->header_bit_size;
+	TP_fast_assign(__entry->tgid = tgid;
+		       __entry->fd = fd;
+		       __entry->header_bit_size = s->header_bit_size;
 		       __entry->first_mb_in_slice = s->first_mb_in_slice;
 		       __entry->slice_type = s->slice_type;
 		       __entry->colour_plane_id = s->colour_plane_id;
@@ -881,7 +945,8 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_h264_slice_params_tmpl,
 		       __entry->num_ref_idx_l0_active_minus1 = s->num_ref_idx_l0_active_minus1;
 		       __entry->num_ref_idx_l1_active_minus1 = s->num_ref_idx_l1_active_minus1;
 		       __entry->flags = s->flags),
-	TP_printk("\nheader_bit_size %u\n"
+	TP_printk("tgid = %u, fd = %d\n"
+		  "header_bit_size %u\n"
 		  "first_mb_in_slice %u\n"
 		  "slice_type %s\n"
 		  "colour_plane_id %u\n"
@@ -895,6 +960,7 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_h264_slice_params_tmpl,
 		  "num_ref_idx_l0_active_minus1 %u\n"
 		  "num_ref_idx_l1_active_minus1 %u\n"
 		  "flags %s",
+		  __entry->tgid, __entry->fd,
 		  __entry->header_bit_size,
 		  __entry->first_mb_in_slice,
 		  __print_symbolic(__entry->slice_type,
@@ -920,15 +986,21 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_h264_slice_params_tmpl,
 );
 
 DECLARE_EVENT_CLASS(v4l2_h264_reference_tmpl,
-	TP_PROTO(const struct v4l2_h264_reference *r, int i),
-	TP_ARGS(r, i),
-	TP_STRUCT__entry(__field(u8, fields)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_h264_reference *r, int i),
+	TP_ARGS(tgid, fd, r, i),
+	TP_STRUCT__entry(__field(u32, tgid)
+			 __field(s32, fd)
+			 __field(u8, fields)
 			 __field(u8, index)
 			 __field(int, i)),
-	TP_fast_assign(__entry->fields = r->fields;
+	TP_fast_assign(__entry->tgid = tgid;
+		       __entry->fd = fd;
+		       __entry->fields = r->fields;
 		       __entry->index = r->index;
 		       __entry->i = i;),
-	TP_printk("[%d]: fields %s index %u",
+	TP_printk("tgid = %u, fd = %d\n"
+		  "[%d]: fields %s index %u",
+		  __entry->tgid, __entry->fd,
 		  __entry->i,
 		  __print_flags(__entry->fields, "|",
 		  {V4L2_H264_TOP_FIELD_REF, "TOP_FIELD_REF"},
@@ -939,9 +1011,11 @@ DECLARE_EVENT_CLASS(v4l2_h264_reference_tmpl,
 );
 
 DECLARE_EVENT_CLASS(v4l2_ctrl_h264_decode_params_tmpl,
-	TP_PROTO(const struct v4l2_ctrl_h264_decode_params *d),
-	TP_ARGS(d),
-	TP_STRUCT__entry(__field(u16, nal_ref_idc)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_ctrl_h264_decode_params *d),
+	TP_ARGS(tgid, fd, d),
+	TP_STRUCT__entry(__field(u32, tgid)
+			 __field(s32, fd)
+			 __field(u16, nal_ref_idc)
 			 __field(u16, frame_num)
 			 __field(__s32, top_field_order_cnt)
 			 __field(__s32, bottom_field_order_cnt)
@@ -954,7 +1028,9 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_h264_decode_params_tmpl,
 			 __field(u32, pic_order_cnt_bit_size)
 			 __field(u32, slice_group_change_cycle)
 			 __field(u32, flags)),
-	TP_fast_assign(__entry->nal_ref_idc = d->nal_ref_idc;
+	TP_fast_assign(__entry->tgid = tgid;
+		       __entry->fd = fd;
+		       __entry->nal_ref_idc = d->nal_ref_idc;
 		       __entry->frame_num = d->frame_num;
 		       __entry->top_field_order_cnt = d->top_field_order_cnt;
 		       __entry->bottom_field_order_cnt = d->bottom_field_order_cnt;
@@ -967,7 +1043,8 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_h264_decode_params_tmpl,
 		       __entry->pic_order_cnt_bit_size = d->pic_order_cnt_bit_size;
 		       __entry->slice_group_change_cycle = d->slice_group_change_cycle;
 		       __entry->flags = d->flags),
-	TP_printk("\nnal_ref_idc %u\n"
+	TP_printk("tgid = %u, fd = %d\n"
+		  "nal_ref_idc %u\n"
 		  "frame_num %u\n"
 		  "top_field_order_cnt %d\n"
 		  "bottom_field_order_cnt %d\n"
@@ -980,6 +1057,7 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_h264_decode_params_tmpl,
 		  "pic_order_cnt_bit_size %u\n"
 		  "slice_group_change_cycle %u\n"
 		  "flags %s\n",
+		  __entry->tgid, __entry->fd,
 		  __entry->nal_ref_idc,
 		  __entry->frame_num,
 		  __entry->top_field_order_cnt,
@@ -1002,9 +1080,11 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_h264_decode_params_tmpl,
 );
 
 DECLARE_EVENT_CLASS(v4l2_h264_dpb_entry_tmpl,
-	TP_PROTO(const struct v4l2_h264_dpb_entry *e, int i),
-	TP_ARGS(e, i),
-	TP_STRUCT__entry(__field(u64, reference_ts)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_h264_dpb_entry *e, int i),
+	TP_ARGS(tgid, fd, e, i),
+	TP_STRUCT__entry(__field(u32, tgid)
+			 __field(s32, fd)
+			 __field(u64, reference_ts)
 			 __field(u32, pic_num)
 			 __field(u16, frame_num)
 			 __field(u8, fields)
@@ -1012,7 +1092,9 @@ DECLARE_EVENT_CLASS(v4l2_h264_dpb_entry_tmpl,
 			 __field(__s32, bottom_field_order_cnt)
 			 __field(u32, flags)
 			 __field(int, i)),
-	TP_fast_assign(__entry->reference_ts = e->reference_ts;
+	TP_fast_assign(__entry->tgid = tgid;
+		       __entry->fd = fd;
+		       __entry->reference_ts = e->reference_ts;
 		       __entry->pic_num = e->pic_num;
 		       __entry->frame_num = e->frame_num;
 		       __entry->fields = e->fields;
@@ -1020,13 +1102,15 @@ DECLARE_EVENT_CLASS(v4l2_h264_dpb_entry_tmpl,
 		       __entry->bottom_field_order_cnt = e->bottom_field_order_cnt;
 		       __entry->flags = e->flags;
 		       __entry->i = i;),
-	TP_printk("[%d]: reference_ts %llu\n"
+	TP_printk("tgid = %u, fd = %d\n"
+		  "[%d]: reference_ts %llu\n"
 		  "pic_num %u\n"
 		  "frame_num %u\n"
 		  "fields %s\n"
 		  "top_field_order_cnt %d\n"
 		  "bottom_field_order_cnt %d\n"
 		  "flags %s\n",
+		  __entry->tgid, __entry->fd,
 		  __entry->i,
 		  __entry->reference_ts,
 		  __entry->pic_num,
@@ -1047,56 +1131,58 @@ DECLARE_EVENT_CLASS(v4l2_h264_dpb_entry_tmpl,
 );
 
 DEFINE_EVENT(v4l2_ctrl_h264_sps_tmpl, v4l2_ctrl_h264_sps,
-	TP_PROTO(const struct v4l2_ctrl_h264_sps *s),
-	TP_ARGS(s)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_ctrl_h264_sps *s),
+	TP_ARGS(tgid, fd, s)
 );
 
 DEFINE_EVENT(v4l2_ctrl_h264_pps_tmpl, v4l2_ctrl_h264_pps,
-	TP_PROTO(const struct v4l2_ctrl_h264_pps *p),
-	TP_ARGS(p)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_ctrl_h264_pps *p),
+	TP_ARGS(tgid, fd, p)
 );
 
 DEFINE_EVENT(v4l2_ctrl_h264_scaling_matrix_tmpl, v4l2_ctrl_h264_scaling_matrix,
-	TP_PROTO(const struct v4l2_ctrl_h264_scaling_matrix *s),
-	TP_ARGS(s)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_ctrl_h264_scaling_matrix *s),
+	TP_ARGS(tgid, fd, s)
 );
 
 DEFINE_EVENT(v4l2_ctrl_h264_pred_weights_tmpl, v4l2_ctrl_h264_pred_weights,
-	TP_PROTO(const struct v4l2_ctrl_h264_pred_weights *p),
-	TP_ARGS(p)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_ctrl_h264_pred_weights *p),
+	TP_ARGS(tgid, fd, p)
 );
 
 DEFINE_EVENT(v4l2_ctrl_h264_slice_params_tmpl, v4l2_ctrl_h264_slice_params,
-	TP_PROTO(const struct v4l2_ctrl_h264_slice_params *s),
-	TP_ARGS(s)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_ctrl_h264_slice_params *s),
+	TP_ARGS(tgid, fd, s)
 );
 
 DEFINE_EVENT(v4l2_h264_reference_tmpl, v4l2_h264_ref_pic_list0,
-	TP_PROTO(const struct v4l2_h264_reference *r, int i),
-	TP_ARGS(r, i)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_h264_reference *r, int i),
+	TP_ARGS(tgid, fd, r, i)
 );
 
 DEFINE_EVENT(v4l2_h264_reference_tmpl, v4l2_h264_ref_pic_list1,
-	TP_PROTO(const struct v4l2_h264_reference *r, int i),
-	TP_ARGS(r, i)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_h264_reference *r, int i),
+	TP_ARGS(tgid, fd, r, i)
 );
 
 DEFINE_EVENT(v4l2_ctrl_h264_decode_params_tmpl, v4l2_ctrl_h264_decode_params,
-	TP_PROTO(const struct v4l2_ctrl_h264_decode_params *d),
-	TP_ARGS(d)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_ctrl_h264_decode_params *d),
+	TP_ARGS(tgid, fd, d)
 );
 
 DEFINE_EVENT(v4l2_h264_dpb_entry_tmpl, v4l2_h264_dpb_entry,
-	TP_PROTO(const struct v4l2_h264_dpb_entry *e, int i),
-	TP_ARGS(e, i)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_h264_dpb_entry *e, int i),
+	TP_ARGS(tgid, fd, e, i)
 );
 
 /* HEVC controls */
 
 DECLARE_EVENT_CLASS(v4l2_ctrl_hevc_sps_tmpl,
-	TP_PROTO(const struct v4l2_ctrl_hevc_sps *s),
-	TP_ARGS(s),
-	TP_STRUCT__entry(__field(__u8, video_parameter_set_id)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_ctrl_hevc_sps *s),
+	TP_ARGS(tgid, fd, s),
+	TP_STRUCT__entry(__field(u32, tgid)
+			 __field(s32, fd)
+			 __field(__u8, video_parameter_set_id)
 			 __field(__u8, seq_parameter_set_id)
 			 __field(__u16, pic_width_in_luma_samples)
 			 __field(__u16, pic_height_in_luma_samples)
@@ -1121,7 +1207,9 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_hevc_sps_tmpl,
 			 __field(__u8, chroma_format_idc)
 			 __field(__u8, sps_max_sub_layers_minus1)
 			 __field(__u64, flags)),
-	TP_fast_assign(__entry->video_parameter_set_id = s->video_parameter_set_id;
+	TP_fast_assign(__entry->tgid = tgid;
+		       __entry->fd = fd;
+		       __entry->video_parameter_set_id = s->video_parameter_set_id;
 		       __entry->seq_parameter_set_id = s->seq_parameter_set_id;
 		       __entry->pic_width_in_luma_samples = s->pic_width_in_luma_samples;
 		       __entry->pic_height_in_luma_samples = s->pic_height_in_luma_samples;
@@ -1158,7 +1246,8 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_hevc_sps_tmpl,
 		       __entry->chroma_format_idc = s->chroma_format_idc;
 		       __entry->sps_max_sub_layers_minus1 = s->sps_max_sub_layers_minus1;
 		       __entry->flags = s->flags;),
-	TP_printk("\nvideo_parameter_set_id %u\n"
+	TP_printk("tgid = %u, fd = %d\n"
+		  "video_parameter_set_id %u\n"
 		  "seq_parameter_set_id %u\n"
 		  "pic_width_in_luma_samples %u\n"
 		  "pic_height_in_luma_samples %u\n"
@@ -1183,6 +1272,7 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_hevc_sps_tmpl,
 		  "chroma_format_idc %u\n"
 		  "sps_max_sub_layers_minus1 %u\n"
 		  "flags %s",
+		  __entry->tgid, __entry->fd,
 		  __entry->video_parameter_set_id,
 		  __entry->seq_parameter_set_id,
 		  __entry->pic_width_in_luma_samples,
@@ -1222,9 +1312,11 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_hevc_sps_tmpl,
 );
 
 DECLARE_EVENT_CLASS(v4l2_ctrl_hevc_pps_tmpl,
-	TP_PROTO(const struct v4l2_ctrl_hevc_pps *p),
-	TP_ARGS(p),
-	TP_STRUCT__entry(__field(__u8, pic_parameter_set_id)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_ctrl_hevc_pps *p),
+	TP_ARGS(tgid, fd, p),
+	TP_STRUCT__entry(__field(u32, tgid)
+			 __field(s32, fd)
+			 __field(__u8, pic_parameter_set_id)
 			 __field(__u8, num_extra_slice_header_bits)
 			 __field(__u8, num_ref_idx_l0_default_active_minus1)
 			 __field(__u8, num_ref_idx_l1_default_active_minus1)
@@ -1240,7 +1332,9 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_hevc_pps_tmpl,
 			 __field(__s8, pps_tc_offset_div2)
 			 __field(__u8, log2_parallel_merge_level_minus2)
 			 __field(__u64, flags)),
-	TP_fast_assign(__entry->pic_parameter_set_id = p->pic_parameter_set_id;
+	TP_fast_assign(__entry->tgid = tgid;
+		       __entry->fd = fd;
+		       __entry->pic_parameter_set_id = p->pic_parameter_set_id;
 		       __entry->num_extra_slice_header_bits = p->num_extra_slice_header_bits;
 		       __entry->num_ref_idx_l0_default_active_minus1 =
 				p->num_ref_idx_l0_default_active_minus1;
@@ -1261,7 +1355,8 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_hevc_pps_tmpl,
 		       __entry->log2_parallel_merge_level_minus2 =
 				p->log2_parallel_merge_level_minus2;
 		       __entry->flags = p->flags;),
-	TP_printk("\npic_parameter_set_id %u\n"
+	TP_printk("tgid = %u, fd = %d\n"
+		  "pic_parameter_set_id %u\n"
 		  "num_extra_slice_header_bits %u\n"
 		  "num_ref_idx_l0_default_active_minus1 %u\n"
 		  "num_ref_idx_l1_default_active_minus1 %u\n"
@@ -1277,6 +1372,7 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_hevc_pps_tmpl,
 		  "pps_tc_offset_div2 %d\n"
 		  "log2_parallel_merge_level_minus2 %u\n"
 		  "flags %s",
+		  __entry->tgid, __entry->fd,
 		  __entry->pic_parameter_set_id,
 		  __entry->num_extra_slice_header_bits,
 		  __entry->num_ref_idx_l0_default_active_minus1,
@@ -1321,9 +1417,11 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_hevc_pps_tmpl,
 );
 
 DECLARE_EVENT_CLASS(v4l2_ctrl_hevc_slice_params_tmpl,
-	TP_PROTO(const struct v4l2_ctrl_hevc_slice_params *s),
-	TP_ARGS(s),
-	TP_STRUCT__entry(__field(__u32, bit_size)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_ctrl_hevc_slice_params *s),
+	TP_ARGS(tgid, fd, s),
+	TP_STRUCT__entry(__field(u32, tgid)
+			 __field(s32, fd)
+			 __field(__u32, bit_size)
 			 __field(__u32, data_byte_offset)
 			 __field(__u32, num_entry_point_offsets)
 			 __field(__u8, nal_unit_type)
@@ -1350,7 +1448,9 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_hevc_slice_params_tmpl,
 			 __field(__u16, short_term_ref_pic_set_size)
 			 __field(__u16, long_term_ref_pic_set_size)
 			 __field(__u64, flags)),
-	TP_fast_assign(__entry->bit_size = s->bit_size;
+	TP_fast_assign(__entry->tgid = tgid;
+		       __entry->fd = fd;
+		       __entry->bit_size = s->bit_size;
 		       __entry->data_byte_offset = s->data_byte_offset;
 		       __entry->num_entry_point_offsets = s->num_entry_point_offsets;
 		       __entry->nal_unit_type = s->nal_unit_type;
@@ -1377,7 +1477,8 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_hevc_slice_params_tmpl,
 		       __entry->short_term_ref_pic_set_size = s->short_term_ref_pic_set_size;
 		       __entry->long_term_ref_pic_set_size = s->long_term_ref_pic_set_size;
 		       __entry->flags = s->flags;),
-	TP_printk("\nbit_size %u\n"
+	TP_printk("tgid = %u, fd = %d\n"
+		  "bit_size %u\n"
 		  "data_byte_offset %u\n"
 		  "num_entry_point_offsets %u\n"
 		  "nal_unit_type %u\n"
@@ -1404,6 +1505,7 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_hevc_slice_params_tmpl,
 		  "short_term_ref_pic_set_size %u\n"
 		  "long_term_ref_pic_set_size %u\n"
 		  "flags %s",
+		  __entry->tgid, __entry->fd,
 		  __entry->bit_size,
 		  __entry->data_byte_offset,
 		  __entry->num_entry_point_offsets,
@@ -1449,9 +1551,11 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_hevc_slice_params_tmpl,
 );
 
 DECLARE_EVENT_CLASS(v4l2_hevc_pred_weight_table_tmpl,
-	TP_PROTO(const struct v4l2_hevc_pred_weight_table *p),
-	TP_ARGS(p),
-	TP_STRUCT__entry(__array(__s8, delta_luma_weight_l0, V4L2_HEVC_DPB_ENTRIES_NUM_MAX)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_hevc_pred_weight_table *p),
+	TP_ARGS(tgid, fd, p),
+	TP_STRUCT__entry(__field(u32, tgid)
+			 __field(s32, fd)
+			 __array(__s8, delta_luma_weight_l0, V4L2_HEVC_DPB_ENTRIES_NUM_MAX)
 			 __array(__s8, luma_offset_l0, V4L2_HEVC_DPB_ENTRIES_NUM_MAX)
 			 __array(__s8, delta_chroma_weight_l0, V4L2_HEVC_DPB_ENTRIES_NUM_MAX * 2)
 			 __array(__s8, chroma_offset_l0, V4L2_HEVC_DPB_ENTRIES_NUM_MAX * 2)
@@ -1461,7 +1565,9 @@ DECLARE_EVENT_CLASS(v4l2_hevc_pred_weight_table_tmpl,
 			 __array(__s8, chroma_offset_l1, V4L2_HEVC_DPB_ENTRIES_NUM_MAX * 2)
 			 __field(__u8, luma_log2_weight_denom)
 			 __field(__s8, delta_chroma_log2_weight_denom)),
-	TP_fast_assign(memcpy(__entry->delta_luma_weight_l0, p->delta_luma_weight_l0,
+	TP_fast_assign(__entry->tgid = tgid;
+		       __entry->fd = fd;
+		       memcpy(__entry->delta_luma_weight_l0, p->delta_luma_weight_l0,
 			      sizeof(__entry->delta_luma_weight_l0));
 		       memcpy(__entry->luma_offset_l0, p->luma_offset_l0,
 			      sizeof(__entry->luma_offset_l0));
@@ -1480,7 +1586,8 @@ DECLARE_EVENT_CLASS(v4l2_hevc_pred_weight_table_tmpl,
 		       __entry->luma_log2_weight_denom = p->luma_log2_weight_denom;
 		       __entry->delta_chroma_log2_weight_denom =
 				p->delta_chroma_log2_weight_denom;),
-	TP_printk("\ndelta_luma_weight_l0 %s\n"
+	TP_printk("tgid = %u, fd = %d\n"
+		  "delta_luma_weight_l0 %s\n"
 		  "luma_offset_l0 %s\n"
 		  "delta_chroma_weight_l0 {%s}\n"
 		  "chroma_offset_l0 {%s}\n"
@@ -1490,6 +1597,7 @@ DECLARE_EVENT_CLASS(v4l2_hevc_pred_weight_table_tmpl,
 		  "chroma_offset_l1 {%s}\n"
 		  "luma_log2_weight_denom %d\n"
 		  "delta_chroma_log2_weight_denom %d\n",
+		  __entry->tgid, __entry->fd,
 		  __print_array(__entry->delta_luma_weight_l0,
 				ARRAY_SIZE(__entry->delta_luma_weight_l0),
 				sizeof(__entry->delta_luma_weight_l0[0])),
@@ -1524,15 +1632,19 @@ DECLARE_EVENT_CLASS(v4l2_hevc_pred_weight_table_tmpl,
 	))
 
 DECLARE_EVENT_CLASS(v4l2_ctrl_hevc_scaling_matrix_tmpl,
-	TP_PROTO(const struct v4l2_ctrl_hevc_scaling_matrix *s),
-	TP_ARGS(s),
-	TP_STRUCT__entry(__array(__u8, scaling_list_4x4, 6 * 16)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_ctrl_hevc_scaling_matrix *s),
+	TP_ARGS(tgid, fd, s),
+	TP_STRUCT__entry(__field(u32, tgid)
+			 __field(s32, fd)
+			 __array(__u8, scaling_list_4x4, 6 * 16)
 			 __array(__u8, scaling_list_8x8, 6 * 64)
 			 __array(__u8, scaling_list_16x16, 6 * 64)
 			 __array(__u8, scaling_list_32x32, 2 * 64)
 			 __array(__u8, scaling_list_dc_coef_16x16, 6)
 			 __array(__u8, scaling_list_dc_coef_32x32, 2)),
-	TP_fast_assign(memcpy(__entry->scaling_list_4x4,
+	TP_fast_assign(__entry->tgid = tgid;
+		       __entry->fd = fd;
+		       memcpy(__entry->scaling_list_4x4,
 			      s->scaling_list_4x4, sizeof(__entry->scaling_list_4x4));
 		       memcpy(__entry->scaling_list_8x8,
 			      s->scaling_list_8x8, sizeof(__entry->scaling_list_8x8));
@@ -1546,12 +1658,14 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_hevc_scaling_matrix_tmpl,
 		       memcpy(__entry->scaling_list_dc_coef_32x32,
 			      s->scaling_list_dc_coef_32x32,
 			      sizeof(__entry->scaling_list_dc_coef_32x32));),
-	TP_printk("\nscaling_list_4x4 {%s}\n"
+	TP_printk("tgid = %u, fd = %d\n"
+		  "scaling_list_4x4 {%s}\n"
 		  "scaling_list_8x8 {%s}\n"
 		  "scaling_list_16x16 {%s}\n"
 		  "scaling_list_32x32 {%s}\n"
 		  "scaling_list_dc_coef_16x16 %s\n"
 		  "scaling_list_dc_coef_32x32 %s\n",
+		  __entry->tgid, __entry->fd,
 		  __print_hex_dump("", DUMP_PREFIX_NONE, 32, 1,
 				   __entry->scaling_list_4x4,
 				   sizeof(__entry->scaling_list_4x4),
@@ -1577,9 +1691,11 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_hevc_scaling_matrix_tmpl,
 	))
 
 DECLARE_EVENT_CLASS(v4l2_ctrl_hevc_decode_params_tmpl,
-	TP_PROTO(const struct v4l2_ctrl_hevc_decode_params *d),
-	TP_ARGS(d),
-	TP_STRUCT__entry(__field(__s32, pic_order_cnt_val)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_ctrl_hevc_decode_params *d),
+	TP_ARGS(tgid, fd, d),
+	TP_STRUCT__entry(__field(u32, tgid)
+			 __field(s32, fd)
+			 __field(__s32, pic_order_cnt_val)
 			 __field(__u16, short_term_ref_pic_set_size)
 			 __field(__u16, long_term_ref_pic_set_size)
 			 __field(__u8, num_active_dpb_entries)
@@ -1590,7 +1706,9 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_hevc_decode_params_tmpl,
 			 __array(__u8, poc_st_curr_after, V4L2_HEVC_DPB_ENTRIES_NUM_MAX)
 			 __array(__u8, poc_lt_curr, V4L2_HEVC_DPB_ENTRIES_NUM_MAX)
 			 __field(__u64, flags)),
-	TP_fast_assign(__entry->pic_order_cnt_val = d->pic_order_cnt_val;
+	TP_fast_assign(__entry->tgid = tgid;
+		       __entry->fd = fd;
+		       __entry->pic_order_cnt_val = d->pic_order_cnt_val;
 		       __entry->short_term_ref_pic_set_size = d->short_term_ref_pic_set_size;
 		       __entry->long_term_ref_pic_set_size = d->long_term_ref_pic_set_size;
 		       __entry->num_active_dpb_entries = d->num_active_dpb_entries;
@@ -1603,7 +1721,8 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_hevc_decode_params_tmpl,
 			      sizeof(__entry->poc_st_curr_after));
 		       memcpy(__entry->poc_lt_curr, d->poc_lt_curr, sizeof(__entry->poc_lt_curr));
 		       __entry->flags = d->flags;),
-	TP_printk("\npic_order_cnt_val %d\n"
+	TP_printk("tgid = %u, fd = %d\n"
+		  "pic_order_cnt_val %d\n"
 		  "short_term_ref_pic_set_size %u\n"
 		  "long_term_ref_pic_set_size %u\n"
 		  "num_active_dpb_entries %u\n"
@@ -1614,6 +1733,7 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_hevc_decode_params_tmpl,
 		  "poc_st_curr_after %s\n"
 		  "poc_lt_curr %s\n"
 		  "flags %s",
+		  __entry->tgid, __entry->fd,
 		  __entry->pic_order_cnt_val,
 		  __entry->short_term_ref_pic_set_size,
 		  __entry->long_term_ref_pic_set_size,
@@ -1638,14 +1758,20 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_hevc_decode_params_tmpl,
 );
 
 DECLARE_EVENT_CLASS(v4l2_ctrl_hevc_ext_sps_lt_rps_tmpl,
-	TP_PROTO(const struct v4l2_ctrl_hevc_ext_sps_lt_rps *lt),
-	TP_ARGS(lt),
-	TP_STRUCT__entry(__field(__u8, flags)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_ctrl_hevc_ext_sps_lt_rps *lt),
+	TP_ARGS(tgid, fd, lt),
+	TP_STRUCT__entry(__field(u32, tgid)
+			 __field(s32, fd)
+			 __field(__u8, flags)
 			 __field(__u32, lt_ref_pic_poc_lsb_sps)),
-	TP_fast_assign(__entry->flags = lt->flags;
+	TP_fast_assign(__entry->tgid = tgid;
+		       __entry->fd = fd;
+		       __entry->flags = lt->flags;
 		       __entry->lt_ref_pic_poc_lsb_sps = lt->lt_ref_pic_poc_lsb_sps;),
-	TP_printk("\nflags %s\n"
+	TP_printk("tgid = %u, fd = %d\n"
+		  "flags %s\n"
 		  "lt_ref_pic_poc_lsb_sps %x\n",
+		  __entry->tgid, __entry->fd,
 		  __print_flags(__entry->flags, "|",
 		  V4L2_FLAG(HEVC_EXT_SPS_LT_RPS, USED_LT)
 		  ),
@@ -1654,9 +1780,11 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_hevc_ext_sps_lt_rps_tmpl,
 );
 
 DECLARE_EVENT_CLASS(v4l2_ctrl_hevc_ext_sps_st_rps_tmpl,
-	TP_PROTO(const struct v4l2_ctrl_hevc_ext_sps_st_rps *st),
-	TP_ARGS(st),
-	TP_STRUCT__entry(__field(__u8, flags)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_ctrl_hevc_ext_sps_st_rps *st),
+	TP_ARGS(tgid, fd, st),
+	TP_STRUCT__entry(__field(u32, tgid)
+			 __field(s32, fd)
+			 __field(__u8, flags)
 			 __field(__u8, delta_idx_minus1)
 			 __field(__u8, delta_rps_sign)
 			 __field(__u16, abs_delta_rps_minus1)
@@ -1666,7 +1794,9 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_hevc_ext_sps_st_rps_tmpl,
 			 __field(__u32, use_delta_flag)
 			 __array(__u16, delta_poc_s0_minus1, 16)
 			 __array(__u16, delta_poc_s1_minus1, 16)),
-	TP_fast_assign(__entry->flags = st->flags;
+	TP_fast_assign(__entry->tgid = tgid;
+		       __entry->fd = fd;
+		       __entry->flags = st->flags;
 		       __entry->delta_idx_minus1 = st->delta_idx_minus1;
 		       __entry->delta_rps_sign = st->delta_rps_sign;
 		       __entry->abs_delta_rps_minus1 = st->abs_delta_rps_minus1;
@@ -1678,7 +1808,8 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_hevc_ext_sps_st_rps_tmpl,
 			      sizeof(__entry->delta_poc_s0_minus1));
 		       memcpy(__entry->delta_poc_s1_minus1, st->delta_poc_s1_minus1,
 			      sizeof(__entry->delta_poc_s1_minus1));),
-	TP_printk("\nflags %s\n"
+	TP_printk("tgid = %u, fd = %d\n"
+		  "flags %s\n"
 		  "delta_idx_minus1: %u\n"
 		  "delta_rps_sign: %u\n"
 		  "abs_delta_rps_minus1: %u\n"
@@ -1688,6 +1819,7 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_hevc_ext_sps_st_rps_tmpl,
 		  "use_delta_flag: %08x\n"
 		  "delta_poc_s0_minus1: %s\n"
 		  "delta_poc_s1_minus1: %s\n",
+		  __entry->tgid, __entry->fd,
 		  __print_flags(__entry->flags, "|",
 		  V4L2_FLAG(HEVC_EXT_SPS_ST_RPS, INTER_REF_PIC_SET_PRED)
 		  ),
@@ -1708,20 +1840,26 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_hevc_ext_sps_st_rps_tmpl,
 );
 
 DECLARE_EVENT_CLASS(v4l2_hevc_dpb_entry_tmpl,
-	TP_PROTO(const struct v4l2_hevc_dpb_entry *e),
-	TP_ARGS(e),
-	TP_STRUCT__entry(__field(__u64, timestamp)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_hevc_dpb_entry *e),
+	TP_ARGS(tgid, fd, e),
+	TP_STRUCT__entry(__field(u32, tgid)
+			 __field(s32, fd)
+			 __field(__u64, timestamp)
 			 __field(__u8, flags)
 			 __field(__u8, field_pic)
 			 __field(__s32, pic_order_cnt_val)),
-	TP_fast_assign(__entry->timestamp = e->timestamp;
+	TP_fast_assign(__entry->tgid = tgid;
+		       __entry->fd = fd;
+		       __entry->timestamp = e->timestamp;
 		       __entry->flags = e->flags;
 		       __entry->field_pic = e->field_pic;
 		       __entry->pic_order_cnt_val = e->pic_order_cnt_val;),
-	TP_printk("\ntimestamp %llu\n"
+	TP_printk("tgid = %u, fd = %d\n"
+		  "timestamp %llu\n"
 		  "flags %s\n"
 		  "field_pic %u\n"
 		  "pic_order_cnt_val %d\n",
+		  __entry->tgid, __entry->fd,
 		__entry->timestamp,
 		__print_flags(__entry->flags, "|",
 		{V4L2_HEVC_DPB_ENTRY_LONG_TERM_REFERENCE, "LONG_TERM_REFERENCE"}
@@ -1731,69 +1869,75 @@ DECLARE_EVENT_CLASS(v4l2_hevc_dpb_entry_tmpl,
 	))
 
 DEFINE_EVENT(v4l2_ctrl_hevc_sps_tmpl, v4l2_ctrl_hevc_sps,
-	TP_PROTO(const struct v4l2_ctrl_hevc_sps *s),
-	TP_ARGS(s)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_ctrl_hevc_sps *s),
+	TP_ARGS(tgid, fd, s)
 );
 
 DEFINE_EVENT(v4l2_ctrl_hevc_pps_tmpl, v4l2_ctrl_hevc_pps,
-	TP_PROTO(const struct v4l2_ctrl_hevc_pps *p),
-	TP_ARGS(p)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_ctrl_hevc_pps *p),
+	TP_ARGS(tgid, fd, p)
 );
 
 DEFINE_EVENT(v4l2_ctrl_hevc_slice_params_tmpl, v4l2_ctrl_hevc_slice_params,
-	TP_PROTO(const struct v4l2_ctrl_hevc_slice_params *s),
-	TP_ARGS(s)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_ctrl_hevc_slice_params *s),
+	TP_ARGS(tgid, fd, s)
 );
 
 DEFINE_EVENT(v4l2_hevc_pred_weight_table_tmpl, v4l2_hevc_pred_weight_table,
-	TP_PROTO(const struct v4l2_hevc_pred_weight_table *p),
-	TP_ARGS(p)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_hevc_pred_weight_table *p),
+	TP_ARGS(tgid, fd, p)
 );
 
 DEFINE_EVENT(v4l2_ctrl_hevc_scaling_matrix_tmpl, v4l2_ctrl_hevc_scaling_matrix,
-	TP_PROTO(const struct v4l2_ctrl_hevc_scaling_matrix *s),
-	TP_ARGS(s)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_ctrl_hevc_scaling_matrix *s),
+	TP_ARGS(tgid, fd, s)
 );
 
 DEFINE_EVENT(v4l2_ctrl_hevc_decode_params_tmpl, v4l2_ctrl_hevc_decode_params,
-	TP_PROTO(const struct v4l2_ctrl_hevc_decode_params *d),
-	TP_ARGS(d)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_ctrl_hevc_decode_params *d),
+	TP_ARGS(tgid, fd, d)
 );
 
 DEFINE_EVENT(v4l2_ctrl_hevc_ext_sps_lt_rps_tmpl, v4l2_ctrl_hevc_ext_sps_lt_rps,
-	TP_PROTO(const struct v4l2_ctrl_hevc_ext_sps_lt_rps *lt),
-	TP_ARGS(lt)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_ctrl_hevc_ext_sps_lt_rps *lt),
+	TP_ARGS(tgid, fd, lt)
 );
 
 DEFINE_EVENT(v4l2_ctrl_hevc_ext_sps_st_rps_tmpl, v4l2_ctrl_hevc_ext_sps_st_rps,
-	TP_PROTO(const struct v4l2_ctrl_hevc_ext_sps_st_rps *st),
-	TP_ARGS(st)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_ctrl_hevc_ext_sps_st_rps *st),
+	TP_ARGS(tgid, fd, st)
 );
 
 DEFINE_EVENT(v4l2_hevc_dpb_entry_tmpl, v4l2_hevc_dpb_entry,
-	TP_PROTO(const struct v4l2_hevc_dpb_entry *e),
-	TP_ARGS(e)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_hevc_dpb_entry *e),
+	TP_ARGS(tgid, fd, e)
 );
 
 /* MPEG2 controls */
 
 DECLARE_EVENT_CLASS(v4l2_ctrl_mpeg2_seq_tmpl,
-	TP_PROTO(const struct v4l2_ctrl_mpeg2_sequence *s),
-	TP_ARGS(s),
-	TP_STRUCT__entry(__field(__u16, horizontal_size)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_ctrl_mpeg2_sequence *s),
+	TP_ARGS(tgid, fd, s),
+	TP_STRUCT__entry(__field(u32, tgid)
+			 __field(s32, fd)
+			 __field(__u16, horizontal_size)
 			 __field(__u16, vertical_size)
 			 __field(__u32, vbv_buffer_size)
 			 __field(__u16, profile_and_level_indication)
 			 __field(__u8, chroma_format)
 			 __field(__u8, flags)),
-	TP_fast_assign(__entry->horizontal_size = s->horizontal_size;
+	TP_fast_assign(__entry->tgid = tgid;
+		       __entry->fd = fd;
+		       __entry->horizontal_size = s->horizontal_size;
 		       __entry->vertical_size = s->vertical_size;
 		       __entry->vbv_buffer_size = s->vbv_buffer_size;
 		       __entry->profile_and_level_indication = s->profile_and_level_indication;
 		       __entry->chroma_format = s->chroma_format;
 		       __entry->flags = s->flags;),
-	TP_printk("\nhorizontal_size %u\nvertical_size %u\nvbv_buffer_size %u\n"
+	TP_printk("tgid = %u, fd = %d\n"
+		  "horizontal_size %u\nvertical_size %u\nvbv_buffer_size %u\n"
 		  "profile_and_level_indication %u\nchroma_format %u\nflags %s\n",
+		  __entry->tgid, __entry->fd,
 		  __entry->horizontal_size,
 		  __entry->vertical_size,
 		  __entry->vbv_buffer_size,
@@ -1805,24 +1949,30 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_mpeg2_seq_tmpl,
 );
 
 DECLARE_EVENT_CLASS(v4l2_ctrl_mpeg2_pic_tmpl,
-	TP_PROTO(const struct v4l2_ctrl_mpeg2_picture *p),
-	TP_ARGS(p),
-	TP_STRUCT__entry(__field(__u64, backward_ref_ts)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_ctrl_mpeg2_picture *p),
+	TP_ARGS(tgid, fd, p),
+	TP_STRUCT__entry(__field(u32, tgid)
+			 __field(s32, fd)
+			 __field(__u64, backward_ref_ts)
 			 __field(__u64, forward_ref_ts)
 			 __field(__u32, flags)
 			 __array(__u8, f_code, 4)
 			 __field(__u8, picture_coding_type)
 			 __field(__u8, picture_structure)
 			 __field(__u8, intra_dc_precision)),
-	TP_fast_assign(__entry->backward_ref_ts = p->backward_ref_ts;
+	TP_fast_assign(__entry->tgid = tgid;
+		       __entry->fd = fd;
+		       __entry->backward_ref_ts = p->backward_ref_ts;
 		       __entry->forward_ref_ts = p->forward_ref_ts;
 		       __entry->flags = p->flags;
 		       memcpy(__entry->f_code, p->f_code, sizeof(__entry->f_code));
 		       __entry->picture_coding_type = p->picture_coding_type;
 		       __entry->picture_structure = p->picture_structure;
 		       __entry->intra_dc_precision = p->intra_dc_precision;),
-	TP_printk("\nbackward_ref_ts %llu\nforward_ref_ts %llu\nflags %s\nf_code {%s}\n"
+	TP_printk("tgid = %u, fd = %d\n"
+		  "backward_ref_ts %llu\nforward_ref_ts %llu\nflags %s\nf_code {%s}\n"
 		  "picture_coding_type: %u\npicture_structure %u\nintra_dc_precision %u\n",
+		  __entry->tgid, __entry->fd,
 		  __entry->backward_ref_ts,
 		  __entry->forward_ref_ts,
 		  __print_flags(__entry->flags, "|",
@@ -1845,13 +1995,17 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_mpeg2_pic_tmpl,
 );
 
 DECLARE_EVENT_CLASS(v4l2_ctrl_mpeg2_quant_tmpl,
-	TP_PROTO(const struct v4l2_ctrl_mpeg2_quantisation *q),
-	TP_ARGS(q),
-	TP_STRUCT__entry(__array(__u8, intra_quantiser_matrix, 64)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_ctrl_mpeg2_quantisation *q),
+	TP_ARGS(tgid, fd, q),
+	TP_STRUCT__entry(__field(u32, tgid)
+			 __field(s32, fd)
+			 __array(__u8, intra_quantiser_matrix, 64)
 			 __array(__u8, non_intra_quantiser_matrix, 64)
 			 __array(__u8, chroma_intra_quantiser_matrix, 64)
 			 __array(__u8, chroma_non_intra_quantiser_matrix, 64)),
-	TP_fast_assign(memcpy(__entry->intra_quantiser_matrix, q->intra_quantiser_matrix,
+	TP_fast_assign(__entry->tgid = tgid;
+		       __entry->fd = fd;
+		       memcpy(__entry->intra_quantiser_matrix, q->intra_quantiser_matrix,
 			      sizeof(__entry->intra_quantiser_matrix));
 		       memcpy(__entry->non_intra_quantiser_matrix, q->non_intra_quantiser_matrix,
 			      sizeof(__entry->non_intra_quantiser_matrix));
@@ -1861,8 +2015,10 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_mpeg2_quant_tmpl,
 		       memcpy(__entry->chroma_non_intra_quantiser_matrix,
 			      q->chroma_non_intra_quantiser_matrix,
 			      sizeof(__entry->chroma_non_intra_quantiser_matrix));),
-	TP_printk("\nintra_quantiser_matrix %s\nnon_intra_quantiser_matrix %s\n"
+	TP_printk("tgid = %u, fd = %d\n"
+		  "intra_quantiser_matrix %s\nnon_intra_quantiser_matrix %s\n"
 		  "chroma_intra_quantiser_matrix %s\nchroma_non_intra_quantiser_matrix %s\n",
+		  __entry->tgid, __entry->fd,
 		  __print_array(__entry->intra_quantiser_matrix,
 				ARRAY_SIZE(__entry->intra_quantiser_matrix),
 				sizeof(__entry->intra_quantiser_matrix[0])),
@@ -1879,30 +2035,34 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_mpeg2_quant_tmpl,
 )
 
 DEFINE_EVENT(v4l2_ctrl_mpeg2_seq_tmpl, v4l2_ctrl_mpeg2_sequence,
-	TP_PROTO(const struct v4l2_ctrl_mpeg2_sequence *s),
-	TP_ARGS(s)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_ctrl_mpeg2_sequence *s),
+	TP_ARGS(tgid, fd, s)
 );
 
 DEFINE_EVENT(v4l2_ctrl_mpeg2_pic_tmpl, v4l2_ctrl_mpeg2_picture,
-	TP_PROTO(const struct v4l2_ctrl_mpeg2_picture *p),
-	TP_ARGS(p)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_ctrl_mpeg2_picture *p),
+	TP_ARGS(tgid, fd, p)
 );
 
 DEFINE_EVENT(v4l2_ctrl_mpeg2_quant_tmpl, v4l2_ctrl_mpeg2_quantisation,
-	TP_PROTO(const struct v4l2_ctrl_mpeg2_quantisation *q),
-	TP_ARGS(q)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_ctrl_mpeg2_quantisation *q),
+	TP_ARGS(tgid, fd, q)
 );
 
 /* VP8 controls */
 
 DECLARE_EVENT_CLASS(v4l2_ctrl_vp8_entropy_tmpl,
-	TP_PROTO(const struct v4l2_ctrl_vp8_frame *f),
-	TP_ARGS(f),
-	TP_STRUCT__entry(__array(__u8, entropy_coeff_probs, 4 * 8 * 3 * V4L2_VP8_COEFF_PROB_CNT)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_ctrl_vp8_frame *f),
+	TP_ARGS(tgid, fd, f),
+	TP_STRUCT__entry(__field(u32, tgid)
+			 __field(s32, fd)
+			 __array(__u8, entropy_coeff_probs, 4 * 8 * 3 * V4L2_VP8_COEFF_PROB_CNT)
 			 __array(__u8, entropy_y_mode_probs, 4)
 			 __array(__u8, entropy_uv_mode_probs, 3)
 			 __array(__u8, entropy_mv_probs, 2 * 19)),
-	TP_fast_assign(memcpy(__entry->entropy_coeff_probs, f->entropy.coeff_probs,
+	TP_fast_assign(__entry->tgid = tgid;
+		       __entry->fd = fd;
+		       memcpy(__entry->entropy_coeff_probs, f->entropy.coeff_probs,
 			      sizeof(__entry->entropy_coeff_probs));
 		       memcpy(__entry->entropy_y_mode_probs, f->entropy.y_mode_probs,
 			      sizeof(__entry->entropy_y_mode_probs));
@@ -1910,10 +2070,12 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_vp8_entropy_tmpl,
 			      sizeof(__entry->entropy_uv_mode_probs));
 		       memcpy(__entry->entropy_mv_probs, f->entropy.mv_probs,
 			      sizeof(__entry->entropy_mv_probs));),
-	TP_printk("\nentropy.coeff_probs {%s}\n"
+	TP_printk("tgid = %u, fd = %d\n"
+		  "entropy.coeff_probs {%s}\n"
 		  "entropy.y_mode_probs %s\n"
 		  "entropy.uv_mode_probs %s\n"
 		  "entropy.mv_probs {%s}",
+		  __entry->tgid, __entry->fd,
 		  __print_hex_dump("", DUMP_PREFIX_NONE, 32, 1,
 				   __entry->entropy_coeff_probs,
 				   sizeof(__entry->entropy_coeff_probs),
@@ -1932,9 +2094,11 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_vp8_entropy_tmpl,
 )
 
 DECLARE_EVENT_CLASS(v4l2_ctrl_vp8_frame_tmpl,
-	TP_PROTO(const struct v4l2_ctrl_vp8_frame *f),
-	TP_ARGS(f),
-	TP_STRUCT__entry(__array(__s8, segment_quant_update, 4)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_ctrl_vp8_frame *f),
+	TP_ARGS(tgid, fd, f),
+	TP_STRUCT__entry(__field(u32, tgid)
+			 __field(s32, fd)
+			 __array(__s8, segment_quant_update, 4)
 			 __array(__s8, segment_lf_update, 4)
 			 __array(__u8, segment_segment_probs, 3)
 			 __field(__u32, segment_flags)
@@ -1969,7 +2133,9 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_vp8_frame_tmpl,
 			 __field(__u64, golden_frame_ts)
 			 __field(__u64, alt_frame_ts)
 			 __field(__u64, flags)),
-	TP_fast_assign(memcpy(__entry->segment_quant_update, f->segment.quant_update,
+	TP_fast_assign(__entry->tgid = tgid;
+		       __entry->fd = fd;
+		       memcpy(__entry->segment_quant_update, f->segment.quant_update,
 			      sizeof(__entry->segment_quant_update));
 		       memcpy(__entry->segment_lf_update, f->segment.lf_update,
 			      sizeof(__entry->segment_lf_update));
@@ -2010,7 +2176,8 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_vp8_frame_tmpl,
 		       __entry->golden_frame_ts = f->golden_frame_ts;
 		       __entry->alt_frame_ts = f->alt_frame_ts;
 		       __entry->flags = f->flags;),
-	TP_printk("\nsegment.quant_update %s\n"
+	TP_printk("tgid = %u, fd = %d\n"
+		  "segment.quant_update %s\n"
 		  "segment.lf_update %s\n"
 		  "segment.segment_probs %s\n"
 		  "segment.flags %s\n"
@@ -2045,6 +2212,7 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_vp8_frame_tmpl,
 		  "golden_frame_ts %llu\n"
 		  "alt_frame_ts %llu\n"
 		  "flags %s",
+		  __entry->tgid, __entry->fd,
 		  __print_array(__entry->segment_quant_update,
 				ARRAY_SIZE(__entry->segment_quant_update),
 				sizeof(__entry->segment_quant_update[0])),
@@ -2109,21 +2277,23 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_vp8_frame_tmpl,
 );
 
 DEFINE_EVENT(v4l2_ctrl_vp8_frame_tmpl, v4l2_ctrl_vp8_frame,
-	TP_PROTO(const struct v4l2_ctrl_vp8_frame *f),
-	TP_ARGS(f)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_ctrl_vp8_frame *f),
+	TP_ARGS(tgid, fd, f)
 );
 
 DEFINE_EVENT(v4l2_ctrl_vp8_entropy_tmpl, v4l2_ctrl_vp8_entropy,
-	TP_PROTO(const struct v4l2_ctrl_vp8_frame *f),
-	TP_ARGS(f)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_ctrl_vp8_frame *f),
+	TP_ARGS(tgid, fd, f)
 );
 
 /* VP9 controls */
 
 DECLARE_EVENT_CLASS(v4l2_ctrl_vp9_frame_tmpl,
-	TP_PROTO(const struct v4l2_ctrl_vp9_frame *f),
-	TP_ARGS(f),
-	TP_STRUCT__entry(__array(__s8, lf_ref_deltas, 4)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_ctrl_vp9_frame *f),
+	TP_ARGS(tgid, fd, f),
+	TP_STRUCT__entry(__field(u32, tgid)
+			 __field(s32, fd)
+			 __array(__s8, lf_ref_deltas, 4)
 			 __array(__s8, lf_mode_deltas, 2)
 			 __field(__u8, lf_level)
 			 __field(__u8, lf_sharpness)
@@ -2156,7 +2326,9 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_vp9_frame_tmpl,
 			 __field(__u8, tile_cols_log2)
 			 __field(__u8, tile_rows_log2)
 			 __field(__u8, reference_mode)),
-	TP_fast_assign(memcpy(__entry->lf_ref_deltas, f->lf.ref_deltas,
+	TP_fast_assign(__entry->tgid = tgid;
+		       __entry->fd = fd;
+		       memcpy(__entry->lf_ref_deltas, f->lf.ref_deltas,
 			      sizeof(__entry->lf_ref_deltas));
 		       memcpy(__entry->lf_mode_deltas, f->lf.mode_deltas,
 			      sizeof(__entry->lf_mode_deltas));
@@ -2195,7 +2367,8 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_vp9_frame_tmpl,
 		       __entry->tile_cols_log2 = f->tile_cols_log2;
 		       __entry->tile_rows_log2 = f->tile_rows_log2;
 		       __entry->reference_mode = f->reference_mode;),
-	TP_printk("\nlf.ref_deltas %s\n"
+	TP_printk("tgid = %u, fd = %d\n"
+		  "lf.ref_deltas %s\n"
 		  "lf.mode_deltas %s\n"
 		  "lf.level %u\n"
 		  "lf.sharpness %u\n"
@@ -2228,6 +2401,7 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_vp9_frame_tmpl,
 		  "tile_cols_log2 %u\n"
 		  "tile_rows_log_2 %u\n"
 		  "reference_mode %s\n",
+		  __entry->tgid, __entry->fd,
 		  __print_array(__entry->lf_ref_deltas,
 				ARRAY_SIZE(__entry->lf_ref_deltas),
 				sizeof(__entry->lf_ref_deltas[0])),
@@ -2308,9 +2482,11 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_vp9_frame_tmpl,
 );
 
 DECLARE_EVENT_CLASS(v4l2_ctrl_vp9_compressed_hdr_tmpl,
-	TP_PROTO(const struct v4l2_ctrl_vp9_compressed_hdr *h),
-	TP_ARGS(h),
-	TP_STRUCT__entry(__field(__u8, tx_mode)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_ctrl_vp9_compressed_hdr *h),
+	TP_ARGS(tgid, fd, h),
+	TP_STRUCT__entry(__field(u32, tgid)
+			 __field(s32, fd)
+			 __field(__u8, tx_mode)
 			 __array(__u8, tx8, 2 * 1)
 			 __array(__u8, tx16, 2 * 2)
 			 __array(__u8, tx32, 2 * 3)
@@ -2324,7 +2500,9 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_vp9_compressed_hdr_tmpl,
 			 __array(__u8, y_mode, 4 * 9)
 			 __array(__u8, uv_mode, 10 * 9)
 			 __array(__u8, partition, 16 * 3)),
-	TP_fast_assign(__entry->tx_mode = h->tx_mode;
+	TP_fast_assign(__entry->tgid = tgid;
+		       __entry->fd = fd;
+		       __entry->tx_mode = h->tx_mode;
 		       memcpy(__entry->tx8, h->tx8, sizeof(__entry->tx8));
 		       memcpy(__entry->tx16, h->tx16, sizeof(__entry->tx16));
 		       memcpy(__entry->tx32, h->tx32, sizeof(__entry->tx32));
@@ -2339,7 +2517,8 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_vp9_compressed_hdr_tmpl,
 		       memcpy(__entry->y_mode, h->y_mode, sizeof(__entry->y_mode));
 		       memcpy(__entry->uv_mode, h->uv_mode, sizeof(__entry->uv_mode));
 		       memcpy(__entry->partition, h->partition, sizeof(__entry->partition));),
-	TP_printk("\ntx_mode %s\n"
+	TP_printk("tgid = %u, fd = %d\n"
+		  "tx_mode %s\n"
 		  "tx8 {%s}\n"
 		  "tx16 {%s}\n"
 		  "tx32 {%s}\n"
@@ -2353,6 +2532,7 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_vp9_compressed_hdr_tmpl,
 		  "y_mode {%s}\n"
 		  "uv_mode {%s}\n"
 		  "partition {%s}\n",
+		  __entry->tgid, __entry->fd,
 		  __print_symbolic(__entry->tx_mode,
 		  {V4L2_VP9_TX_MODE_ONLY_4X4, "TX_MODE_ONLY_4X4"},
 		  {V4L2_VP9_TX_MODE_ALLOW_8X8, "TX_MODE_ALLOW_8X8"},
@@ -2411,11 +2591,17 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_vp9_compressed_hdr_tmpl,
 );
 
 DECLARE_EVENT_CLASS(v4l2_ctrl_vp9_compressed_coef_tmpl,
-	TP_PROTO(const struct v4l2_ctrl_vp9_compressed_hdr *h),
-	TP_ARGS(h),
-	TP_STRUCT__entry(__array(__u8, coef, 4 * 2 * 2 * 6 * 6 * 3)),
-	TP_fast_assign(memcpy(__entry->coef, h->coef, sizeof(__entry->coef));),
-	TP_printk("\n coef {%s}",
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_ctrl_vp9_compressed_hdr *h),
+	TP_ARGS(tgid, fd, h),
+	TP_STRUCT__entry(__field(u32, tgid)
+			 __field(s32, fd)
+			 __array(__u8, coef, 4 * 2 * 2 * 6 * 6 * 3)),
+	TP_fast_assign(__entry->tgid = tgid;
+		       __entry->fd = fd;
+		       memcpy(__entry->coef, h->coef, sizeof(__entry->coef));),
+	TP_printk("tgid = %u, fd = %d\n"
+		  "coef {%s}",
+		  __entry->tgid, __entry->fd,
 		  __print_hex_dump("", DUMP_PREFIX_NONE, 32, 1,
 				   __entry->coef,
 				   sizeof(__entry->coef),
@@ -2424,9 +2610,11 @@ DECLARE_EVENT_CLASS(v4l2_ctrl_vp9_compressed_coef_tmpl,
 );
 
 DECLARE_EVENT_CLASS(v4l2_vp9_mv_probs_tmpl,
-	TP_PROTO(const struct v4l2_vp9_mv_probs *p),
-	TP_ARGS(p),
-	TP_STRUCT__entry(__array(__u8, joint, 3)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_vp9_mv_probs *p),
+	TP_ARGS(tgid, fd, p),
+	TP_STRUCT__entry(__field(u32, tgid)
+			 __field(s32, fd)
+			 __array(__u8, joint, 3)
 			 __array(__u8, sign, 2)
 			 __array(__u8, classes, 2 * 10)
 			 __array(__u8, class0_bit, 2)
@@ -2435,7 +2623,9 @@ DECLARE_EVENT_CLASS(v4l2_vp9_mv_probs_tmpl,
 			 __array(__u8, fr, 2 * 3)
 			 __array(__u8, class0_hp, 2)
 			 __array(__u8, hp, 2)),
-	TP_fast_assign(memcpy(__entry->joint, p->joint, sizeof(__entry->joint));
+	TP_fast_assign(__entry->tgid = tgid;
+		       __entry->fd = fd;
+		       memcpy(__entry->joint, p->joint, sizeof(__entry->joint));
 		       memcpy(__entry->sign, p->sign, sizeof(__entry->sign));
 		       memcpy(__entry->classes, p->classes, sizeof(__entry->classes));
 		       memcpy(__entry->class0_bit, p->class0_bit, sizeof(__entry->class0_bit));
@@ -2444,7 +2634,8 @@ DECLARE_EVENT_CLASS(v4l2_vp9_mv_probs_tmpl,
 		       memcpy(__entry->fr, p->fr, sizeof(__entry->fr));
 		       memcpy(__entry->class0_hp, p->class0_hp, sizeof(__entry->class0_hp));
 		       memcpy(__entry->hp, p->hp, sizeof(__entry->hp));),
-	TP_printk("\n joint %s\n"
+	TP_printk("tgid = %u, fd = %d\n"
+		  "joint %s\n"
 		  "sign %s\n"
 		  "classes {%s}\n"
 		  "class0_bit %s\n"
@@ -2453,6 +2644,7 @@ DECLARE_EVENT_CLASS(v4l2_vp9_mv_probs_tmpl,
 		  "fr {%s}\n"
 		  "class0_hp %s\n"
 		  "hp %s\n",
+		  __entry->tgid, __entry->fd,
 		  __print_array(__entry->joint,
 				ARRAY_SIZE(__entry->joint),
 				sizeof(__entry->joint[0])),
@@ -2488,23 +2680,23 @@ DECLARE_EVENT_CLASS(v4l2_vp9_mv_probs_tmpl,
 );
 
 DEFINE_EVENT(v4l2_ctrl_vp9_frame_tmpl, v4l2_ctrl_vp9_frame,
-	TP_PROTO(const struct v4l2_ctrl_vp9_frame *f),
-	TP_ARGS(f)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_ctrl_vp9_frame *f),
+	TP_ARGS(tgid, fd, f)
 );
 
 DEFINE_EVENT(v4l2_ctrl_vp9_compressed_hdr_tmpl, v4l2_ctrl_vp9_compressed_hdr,
-	TP_PROTO(const struct v4l2_ctrl_vp9_compressed_hdr *h),
-	TP_ARGS(h)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_ctrl_vp9_compressed_hdr *h),
+	TP_ARGS(tgid, fd, h)
 );
 
 DEFINE_EVENT(v4l2_ctrl_vp9_compressed_coef_tmpl, v4l2_ctrl_vp9_compressed_coeff,
-	TP_PROTO(const struct v4l2_ctrl_vp9_compressed_hdr *h),
-	TP_ARGS(h)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_ctrl_vp9_compressed_hdr *h),
+	TP_ARGS(tgid, fd, h)
 );
 
 DEFINE_EVENT(v4l2_vp9_mv_probs_tmpl, v4l2_vp9_mv_probs,
-	TP_PROTO(const struct v4l2_vp9_mv_probs *p),
-	TP_ARGS(p)
+	TP_PROTO(u32 tgid, s32 fd, const struct v4l2_vp9_mv_probs *p),
+	TP_ARGS(tgid, fd, p)
 );
 
 #endif /* if !defined(_TRACE_V4L2_CONTROLS_H_) || defined(TRACE_HEADER_MULTI_READ) */

-- 
2.56.1

