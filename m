Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BF1372680;
	Wed, 10 Jun 2026 14:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781102075; cv=none; b=Lt9nB0Ef7yaNstGjg7QKsI++sXFwSKan8zlJvbcWqpRIJQT6ajFcwS4dIQmIfeCVedVsuK5GeaohR/g7V5ot9X1NlKmNtQI3DnZK6klw42ihAOv0RS6/h44o/3hWiDdMntFknIbG03ofzevPDJxzLBZLXsYc69i0O2a0NzTcJ2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781102075; c=relaxed/simple;
	bh=buWzY0LM2eBzVDux6FwBX3Iv5Uvnb04/g09QnKbCclg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j7tFADJPNPdAOIYXASx6IPjH9q91CPU9Lcgi25xQGYrdGCbXhUXYk4z8Td8ia7/4I7fqz5O7nk+3vqYGgRBVJUCySa5XpKQp8D7VcMCQTLT9sWXOgDjF2IiNIGf5xmLLNZMxv/ANvZ+MSk/ST/O359vCJJmrM9o/DzLVTW+fV1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KT1t72BX; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KT1t72BX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1781102067;
	bh=buWzY0LM2eBzVDux6FwBX3Iv5Uvnb04/g09QnKbCclg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KT1t72BXfj58snpFIw5YXgBpFC2bpxE+moW/BmKWtzJ6XZc+ZolVxCWLP7OYiAOXJ
	 +/Q8wXqCW4a4bROEJP+CqgSbsPquhTVm7038tDPxTfKIhQRINaV1Sw8yTr2mLgFexc
	 4MPO2jN0wzqGNfsjtplSPsXiW2W25/9J6cYyZIeEAq9Z+jIw7eZovd+i64OMdYLr97
	 OewOvLVHLhC7oOhYoldlkS9ELzFRwhBxy6fx7Kj0EY5+htLioBAQxlAhEah5SsL/Xe
	 xXvSs1iRpYoRAMutPaaTUrsWuCR9zU0MchoPBNgSpufHqAykD7SXeUgHgV1wZwDuQ5
	 1L3CgcqVdKOMQ==
Received: from [192.168.0.15] (unknown [100.64.0.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E5E3F17E11FB;
	Wed, 10 Jun 2026 16:34:25 +0200 (CEST)
From: Detlev Casanova <detlev.casanova@collabora.com>
Date: Wed, 10 Jun 2026 10:33:38 -0400
Subject: [PATCH v2 8/9] media: Add HW run/done trace events
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-v4l2-add-ftrace-v2-8-9756edf72ac1@collabora.com>
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

The events can be fired by drivers when the hardware is run and when it
is done.
That can be used by userspace tracers to see HW performance and usage.

The hw_done event allows setting the number of clock cycles the HW needed
to do the work, to help tools evaluate performances.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 drivers/media/v4l2-core/v4l2-trace.c |  3 +++
 include/trace/events/v4l2.h          | 40 ++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-trace.c b/drivers/media/v4l2-core/v4l2-trace.c
index 183d5ecb49c5..59cf6f8807ac 100644
--- a/drivers/media/v4l2-core/v4l2-trace.c
+++ b/drivers/media/v4l2-core/v4l2-trace.c
@@ -12,6 +12,9 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(vb2_v4l2_buf_queue);
 EXPORT_TRACEPOINT_SYMBOL_GPL(vb2_v4l2_dqbuf);
 EXPORT_TRACEPOINT_SYMBOL_GPL(vb2_v4l2_qbuf);
 
+EXPORT_TRACEPOINT_SYMBOL_GPL(v4l2_hw_run);
+EXPORT_TRACEPOINT_SYMBOL_GPL(v4l2_hw_done);
+
 /* Export AV1 controls */
 EXPORT_TRACEPOINT_SYMBOL_GPL(v4l2_ctrl_av1_sequence);
 EXPORT_TRACEPOINT_SYMBOL_GPL(v4l2_ctrl_av1_frame);
diff --git a/include/trace/events/v4l2.h b/include/trace/events/v4l2.h
index e5b80aeecc30..6f1bbb085cb0 100644
--- a/include/trace/events/v4l2.h
+++ b/include/trace/events/v4l2.h
@@ -299,6 +299,46 @@ DEFINE_EVENT(v4l2_stream_class, v4l2_streamoff,
 	TP_ARGS(tgid, fd)
 );
 
+
+/* Events for hardware run/done.
+ *
+ * These events will be fired respectively when the hardware is run (v4l2_hw_run) and done
+ * (v4l2_hw_done).
+ * As for other events, tgid and fd are used to identify the process that opened the video device.
+ *
+ * The v4l2_hw_done event also includes the number of hardware cycles taken by the hardware to
+ * process the command.
+ */
+DEFINE_EVENT(v4l2_stream_class, v4l2_hw_run,
+	TP_PROTO(u32 tgid, u32 fd),
+	TP_ARGS(tgid, fd)
+);
+
+DECLARE_EVENT_CLASS(v4l2_hw_done_class,
+	TP_PROTO(u32 tgid, u32 fd, u32 hw_cycles),
+	TP_ARGS(tgid, fd, hw_cycles),
+
+	TP_STRUCT__entry(
+		__field(u32, tgid)
+		__field(u32, fd)
+		__field(u32, hw_cycles)
+	),
+
+	TP_fast_assign(
+		__entry->tgid = tgid;
+		__entry->fd = fd;
+		__entry->hw_cycles = hw_cycles;
+	),
+
+	TP_printk("tgid = %u, fd = %u, hw_cycles = %u",
+		  __entry->tgid, __entry->fd, __entry->hw_cycles)
+);
+
+DEFINE_EVENT(v4l2_hw_done_class, v4l2_hw_done,
+	TP_PROTO(u32 tgid, u32 fd, u32 hw_cycles),
+	TP_ARGS(tgid, fd, hw_cycles)
+);
+
 #endif /* if !defined(_TRACE_V4L2_H) || defined(TRACE_HEADER_MULTI_READ) */
 
 /* This part must be outside protection */

-- 
2.54.0

