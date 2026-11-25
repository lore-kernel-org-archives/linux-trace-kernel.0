Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795632306;
	b=1Y3ae7S8Kd+vKFOE1HyY/XvzGaPgp2Rz5r830X33J4Dpde+cZGPKA717ArHn/Wl+13ZD
	 Fv0d1Fh00FKtXkakXrSCZqhBR7jkaQDj2yNz5UsToBsxHp4LdOP1d+neNWgcWFtzfY3sD
	 FPa22zTbbsSH8Op2ucoO8N/c0xV+WPpQCvmA/d2Ue4m+SqwAlqou4EYInhROw553FLpZ8
	 +TpnLEb6esr7O/rPuZwWF0Kp3Ep9797+fJS3iT+ONe2fjKnk10VIYjjNVAJbtWuSCRHuv
	 lTOgYAFeE7jQuCAdmshKiX9cicwlR1KdTVsJcq3cT8xdYkTwDOQ0tqLBZcfCmQwGGtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795632306;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=BTvd7VIbBg1p/dh97oMGLopVdTDaC1qAlcNdO6Nm7V0=;
	b=bNlh8mvKX8SeOfiaaOn5KYT/amcGExay9L9kaVdeZnXvWcDwKFv4zJUunsXWcDWlTzxc
	 9E1XfNKdYDqN4fgnDAXqOUKMJkpR+j1hwgv0kJNcCG+/zuj3KeTVFpb92vQsdzRCcXJRg
	 30jVbDukoEzzo/NY9M+qLlIGtL7QpV0n4n66vLPnQz2XKkKHtNNrOyTUsL02JMSqGqp/l
	 9zWXwWErWRL8nKv3G9PL0qZL5zLGZ53eOqh9hFCACSNbuT+1V7q2Z1kIL3OHmyzt6fIhd
	 Th5YUw8D1ZNjT6vIFpSBRr6ixIXdZxY/Ays7qeq/ZXKs6W+yY2c6N+QKne5Df5HxwFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=jbhIKLEx;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A73160A2617;
	Wed, 25 Nov 2026 18:45:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A73160A2617
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=jbhIKLEx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795632304;
	bh=NGbc8Fxp/m2XrR8id2lX4uwCcm+j1OUYcrLHIZ7FIAQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jbhIKLExcreI/0djbaObu7/K+HNhuJMQ3BnOmVeaKy9upMVSJQvGBflGX3teVXJXg
	 O08hNGd0vyZ24iy0Htc2tlx5pkk0U2g3NWsSHSE1fkhk1IB2tN04Svo+fB6Tev2XG4
	 JeMBXiAqFDI7gfBylK3JsSK9aGwdR5AIWAI5Iw0SpZYfFkm0l20H3USxzoOIigP6DG
	 Ctc/2lXiRczMk+fGT4oo2Mq7GS74YTynM/w42jHC3XrZoTIA1tg4YonQpTN8rs92U2
	 S/8QFgUt5eNhoyheZk/dU2p8xyrMDFSsWJpJ5J8oGFvMLX/NHAO1EzKacsbw/D1HJM
	 VH3/6r7BVYe9g==
Received: from [192.168.0.15] (unknown [100.64.0.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DB22C17E1296;
	Wed, 25 Nov 2026 19:45:02 +0100 (CET)
From: Detlev Casanova <detlev.casanova@collabora.com>
Date: Wed, 25 Nov 2026 13:33:29 -0500
Subject: [PATCH v3 7/9] media: Add stream on/off traces and run them in the
 ioctl
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
Message-Id: <20261125-v4l2-add-ftrace-v3-7-1d1db48372ed@collabora.com>
References: <20261125-v4l2-add-ftrace-v3-0-1d1db48372ed@collabora.com>
In-Reply-To: <20261125-v4l2-add-ftrace-v3-0-1d1db48372ed@collabora.com>
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

This will automatically add stream on/off tracing for all v4l2 drivers.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 drivers/media/v4l2-core/v4l2-ioctl.c | 20 ++++++++++++++++++--
 include/trace/events/v4l2.h          | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 5d7fbaa1b41a..09e8bc9df132 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1965,13 +1965,29 @@ static int v4l_try_fmt(const struct v4l2_ioctl_ops *ops, struct file *file,
 static int v4l_streamon(const struct v4l2_ioctl_ops *ops, struct file *file,
 			void *arg)
 {
-	return ops->vidioc_streamon(file, NULL, *(unsigned int *)arg);
+	struct v4l2_fh *fh = file_to_v4l2_fh(file);
+	int err;
+
+	err = ops->vidioc_streamon(file, NULL, *(unsigned int *)arg);
+
+	if (!err)
+		trace_v4l2_streamon(fh->tgid, fh->fd);
+
+	return err;
 }
 
 static int v4l_streamoff(const struct v4l2_ioctl_ops *ops, struct file *file,
 			 void *arg)
 {
-	return ops->vidioc_streamoff(file, NULL, *(unsigned int *)arg);
+	struct v4l2_fh *fh = file_to_v4l2_fh(file);
+	int err;
+
+	err = ops->vidioc_streamoff(file, NULL, *(unsigned int *)arg);
+
+	if (!err)
+		trace_v4l2_streamoff(fh->tgid, fh->fd);
+
+	return err;
 }
 
 static int v4l_g_tuner(const struct v4l2_ioctl_ops *ops, struct file *file,
diff --git a/include/trace/events/v4l2.h b/include/trace/events/v4l2.h
index 248bc09bfc99..089c5ff0b3af 100644
--- a/include/trace/events/v4l2.h
+++ b/include/trace/events/v4l2.h
@@ -262,6 +262,40 @@ DEFINE_EVENT(vb2_v4l2_event_class, vb2_v4l2_qbuf,
 	TP_ARGS(q, vb)
 );
 
+/* Events for stream on/off.
+ *
+ * These events will be fired every time userspace starts or stops a stream.
+ * tgid and fd are used to identify the process that opened the video device.
+ *
+ * Note that this even can be fired multiple times for a given tgid/fd pair.
+ * E.g.: mem2mem drivers expect stream on/off on both output and capture queues.
+ */
+DECLARE_EVENT_CLASS(v4l2_stream_class,
+	TP_PROTO(u32 tgid, u32 fd),
+	TP_ARGS(tgid, fd),
+
+	TP_STRUCT__entry(__field(u32, tgid)
+			 __field(u32, fd)
+	),
+
+	TP_fast_assign(__entry->tgid = tgid;
+		       __entry->fd = fd;
+	),
+
+	TP_printk("tgid = %u, fd = %u",
+		  __entry->tgid, __entry->fd)
+);
+
+DEFINE_EVENT(v4l2_stream_class, v4l2_streamon,
+	TP_PROTO(u32 tgid, u32 fd),
+	TP_ARGS(tgid, fd)
+);
+
+DEFINE_EVENT(v4l2_stream_class, v4l2_streamoff,
+	TP_PROTO(u32 tgid, u32 fd),
+	TP_ARGS(tgid, fd)
+);
+
 #endif /* if !defined(_TRACE_V4L2_H) || defined(TRACE_HEADER_MULTI_READ) */
 
 /* This part must be outside protection */

-- 
2.56.1

