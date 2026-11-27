Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795797958;
	b=a5XDS5k64lxQTRN3LXspdBftTl8HwyT9nDJlPEs5kRDgAnmM5nsg7thpbJs3gjCj5J7z
	 z0UmUtVXUaoCOUrJPnufSC28Rnrrnz0SEVmsJfK5E1+dVMPjvmDgXLOPdkDzt9ANQlTEE
	 jRfwHa7UHclgta5q78EnRGj+616ZIDTNvaZjj6Vnvvaqj8zZpCW/vnHKUBZ2p2ejFZxy9
	 poN0v0sJUVgkADnZ76UxMhy3TMv+2WOTQtzwpKyEjTStsNqPONYBsG6GWQ1r6p8MgZiM9
	 Q+x3MhRTHTjFlnMQ0wpvAWnrUgwY+W0XBoRiS3yhe2zo3X8NiQoFT/ur9VE4Im19F9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795797958;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=m+b9qRfoe5kw0wQH5Dx62HKikqet01mDMR3chcUsRE8=;
	b=YT2Ox7ND0bERPiKNXs9LGgJAz95TxqiA3UJCFRQuQzs5ffQZdEbPzpk8BgMc3L9y963s
	 s1uhGMerAbUm1hS/wHTFXnqWryKtrPFlczWqcNYYgig+XXJlQf33L7rEhR5aPd9hQGV3q
	 Mmfw9s0cRtr0om4r7AcIYgUjyIACwQmlup9BN7fjz8vfED8ShhytBUTRhsvE1McRkU4nV
	 y8fSVvgI8WQbF4GNvLpwOEIBH0k89JF1QQW8PNHcaFi5ewFFRfw/FP+KuJW07rXzALYmE
	 fKPO5A/eEiBRru6o9D8seIOMmq8mPi/2Fp1+pqGwWRlw4+7q1GVgDq77qdSHDPk2upw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=NoKQmlyD;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D197260A2600;
	Fri, 27 Nov 2026 16:45:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D197260A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=NoKQmlyD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795797956;
	bh=26S/azp/tiJQxKKBFeHPtQPyrSoju++dR4OxSkAG01Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NoKQmlyDTa5sD/WJBU9qb2fvJDtd5JszW2pnVhUOo497j0YBEwKWZJln1wSAivObc
	 kIaJNx/n2FipJfAsjTe6aHqbM4bDvHEq5tngcu3FPuACpTRYraNWY/x6dE8QcZiMid
	 DeXqj25V0MC+fbFvHqT6OdGPk63WnTIkSJsUfb6Ky2+koDvjUpKZ7xt8mmi3mksjIz
	 NLWKjoWCBFWf5LWrf+INPWMH7cxrIzQME4ODfPQeT4EITpEpzzcYJbUwOO4T8SvfdZ
	 HrBx6lodJCDWgsQ/KJ0rZjZ2YYdDycXr/8wVQ+VkGcMFPFJq/hMMvLcUoJHcBqO3tS
	 URF2GzkpOzeEA==
Received: from [192.168.0.15] (unknown [100.64.0.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 55E0117E0A27;
	Fri, 27 Nov 2026 17:45:54 +0100 (CET)
From: Detlev Casanova <detlev.casanova@collabora.com>
Date: Fri, 27 Nov 2026 11:45:12 -0500
Subject: [PATCH v4 8/9] media: Add HW run/done trace events
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
Message-Id: <20261127-v4l2-add-ftrace-v4-8-24138479002f@collabora.com>
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

The events can be fired by drivers when the hardware is run and when it
is done.
That can be used by userspace tracers to see HW performance and usage.

The hw_done event allows setting the number of clock cycles the HW needed
to do the work, to help tools evaluate performances.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 drivers/media/v4l2-core/v4l2-trace.c |  3 +++
 include/trace/events/v4l2.h          | 52 ++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-trace.c b/drivers/media/v4l2-core/v4l2-trace.c
index af9464403f95..5b24b043295d 100644
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
index b11293365123..a72bd3e47511 100644
--- a/include/trace/events/v4l2.h
+++ b/include/trace/events/v4l2.h
@@ -299,6 +299,58 @@ DEFINE_EVENT(v4l2_stream_class, v4l2_streamoff,
 	TP_ARGS(tgid, fd, type)
 );
 
+/* Events for hardware run/done.
+ *
+ * These events will be fired respectively when the hardware is run (v4l2_hw_run) and done
+ * (v4l2_hw_done).
+ * As for other events, tgid and fd are used to identify the process that opened the video device.
+ *
+ * The v4l2_hw_done event also includes the number of hardware cycles taken by the hardware to
+ * process the command.
+ */
+DECLARE_EVENT_CLASS(v4l2_fh_class,
+	TP_PROTO(u32 tgid, s32 fd),
+	TP_ARGS(tgid, fd),
+
+	TP_STRUCT__entry(__field(u32, tgid)
+			 __field(s32, fd)
+	),
+
+	TP_fast_assign(__entry->tgid = tgid;
+		       __entry->fd = fd;
+	),
+
+	TP_printk("tgid = %u, fd = %d", __entry->tgid, __entry->fd)
+);
+
+DEFINE_EVENT(v4l2_fh_class, v4l2_hw_run,
+	TP_PROTO(u32 tgid, s32 fd),
+	TP_ARGS(tgid, fd)
+);
+
+DECLARE_EVENT_CLASS(v4l2_hw_done_class,
+	TP_PROTO(u32 tgid, s32 fd, u32 hw_cycles),
+	TP_ARGS(tgid, fd, hw_cycles),
+
+	TP_STRUCT__entry(__field(u32, tgid)
+			 __field(s32, fd)
+			 __field(u32, hw_cycles)
+	),
+
+	TP_fast_assign(__entry->tgid = tgid;
+		       __entry->fd = fd;
+		       __entry->hw_cycles = hw_cycles;
+	),
+
+	TP_printk("tgid = %u, fd = %d, hw_cycles = %u",
+		  __entry->tgid, __entry->fd, __entry->hw_cycles)
+);
+
+DEFINE_EVENT(v4l2_hw_done_class, v4l2_hw_done,
+	TP_PROTO(u32 tgid, s32 fd, u32 hw_cycles),
+	TP_ARGS(tgid, fd, hw_cycles)
+);
+
 #endif /* if !defined(_TRACE_V4L2_H) || defined(TRACE_HEADER_MULTI_READ) */
 
 /* This part must be outside protection */

-- 
2.56.1

