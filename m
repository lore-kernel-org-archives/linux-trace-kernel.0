Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795797956;
	b=gxssiwgvja122XOPE02fJtkZ9pNDet/Wy6GDp7xgYZm06YOYLmf1tjxMuHoUbfdrzwD9
	 ELrRL7OpAf4I0lt7NFf8Sc4+7VJKolt+YCBQYgDHkN+kNrtMjW7HeqakbijmcMYXdpquJ
	 kNmnN2kvhvs36Amlg2sqnrlAIT7ZsAvkmRRF/pv9de5TAbhEGKm9o+0y99qLpfOZEVjIU
	 IhAgxP6Gk5WMH+TafKgpp8ZNoccgzLVGTJ9o6S6CxJoL2CGqhb2hRWKv09vy93jKLH59W
	 pjlkIFsF7eI8iVuW8FRp1Jr3RFqvqcGBZRk5yTqewZ5q4T8aNVhZbo0Ywwt5Fak9M4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795797956;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=1M3acFGCLR5KsNELoY15riziLexMyJMhHyB0Ci8R3Vo=;
	b=jcpTPIVOCmB41WqKGVm3xYRNSbcO6uteSG4A39tjKu+0LdCJ4D9hnQ2n1FXhj1Bl46X4
	 YkpqAfki/ugssMVZewM6YaWpZLX6uTuhqCaqWwHAjmadQwrwZaGLM1lD5eSoMOciS1IZd
	 5vp9nMbQ2af1ePk4MG99G7hmTKd4tZGOE8Ie9JJ+m5EgXHAGYdKEpw/EsB9AYXmYVAcoi
	 X+9g2xuiJdUcdUPQIUpVIzFPYhGGpwDWyY0vleJ2ciNdQS6ef5j0rB0Vh2+pESJ3f3Y/1
	 527xhs2Zf1MYWJtYlJDot3QTdY8ta6hlEvmX+E1+WX8wK2vRwn3w54L96uyXn0JXC6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=hMZMbxgX;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82C4606A324;
	Fri, 27 Nov 2026 16:45:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A82C4606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=hMZMbxgX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795797954;
	bh=L6rZvcWM1EhsZRVJ5/aUwEYKuvUsh9+nsLQFVzmMG7M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hMZMbxgXT3mbhra3N6rQX9B1oSR1Cf2j4MhwgxKNwunaIj+6erhWva49h+QSuQ+gK
	 Sts4VtKDLxYCBLApHIZylitJCXV91x2JcvAyk9/V8dBSExR7d4+t1wcWaI89udoUYF
	 a1cKnrIF5N7Dmy23/zqqCIjDdXI2a8z9k2k2sinQtut1pYww1VCWXMf75EiTa4R1Zx
	 Gbnq8prjbWK/2gg0/aiOfvtjLgjvwaZLUOTjRMKIhDc0NFCrVhkpxOgN8ltMPHZvAc
	 87JtlUVM/wSXZ1KjoKRfgp+hrCyPtjDaHjpoOwM8PDQSu+QSGw+1y5qMPMjU1hhkKE
	 +FZldVVotlIVw==
Received: from [192.168.0.15] (unknown [100.64.0.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 206BF17E010F;
	Fri, 27 Nov 2026 17:45:52 +0100 (CET)
From: Detlev Casanova <detlev.casanova@collabora.com>
Date: Fri, 27 Nov 2026 11:45:11 -0500
Subject: [PATCH v4 7/9] media: Add stream on/off traces and run them in the
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
Message-Id: <20261127-v4l2-add-ftrace-v4-7-24138479002f@collabora.com>
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

Automatically trace stream on/off events for all v4l2 drivers.

The queue type is also logged so that userspace can identify the possible
multiple stream on/off events per stream.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 drivers/media/v4l2-core/v4l2-ioctl.c | 22 +++++++++++++++++++--
 include/trace/events/v4l2.h          | 37 ++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 29ca2f7959ef..71dec6618d08 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1965,13 +1965,31 @@ static int v4l_try_fmt(const struct v4l2_ioctl_ops *ops, struct file *file,
 static int v4l_streamon(const struct v4l2_ioctl_ops *ops, struct file *file,
 			void *arg)
 {
-	return ops->vidioc_streamon(file, NULL, *(unsigned int *)arg);
+	struct v4l2_fh *fh = file_to_v4l2_fh(file);
+	unsigned int type = *(unsigned int *)arg;
+	int err;
+
+	err = ops->vidioc_streamon(file, NULL, type);
+
+	if (!err)
+		trace_v4l2_streamon(fh->tgid, fh->fd, type);
+
+	return err;
 }
 
 static int v4l_streamoff(const struct v4l2_ioctl_ops *ops, struct file *file,
 			 void *arg)
 {
-	return ops->vidioc_streamoff(file, NULL, *(unsigned int *)arg);
+	struct v4l2_fh *fh = file_to_v4l2_fh(file);
+	unsigned int type = *(unsigned int *)arg;
+	int err;
+
+	err = ops->vidioc_streamoff(file, NULL, type);
+
+	if (!err)
+		trace_v4l2_streamoff(fh->tgid, fh->fd, type);
+
+	return err;
 }
 
 static int v4l_g_tuner(const struct v4l2_ioctl_ops *ops, struct file *file,
diff --git a/include/trace/events/v4l2.h b/include/trace/events/v4l2.h
index 248bc09bfc99..b11293365123 100644
--- a/include/trace/events/v4l2.h
+++ b/include/trace/events/v4l2.h
@@ -262,6 +262,43 @@ DEFINE_EVENT(vb2_v4l2_event_class, vb2_v4l2_qbuf,
 	TP_ARGS(q, vb)
 );
 
+/* Events for stream on/off.
+ *
+ * These events will be fired every time userspace starts or stops a stream.
+ * tgid and fd are used to identify the process that opened the video device.
+ * type is the &enum v4l2_buf_type of the queue being started or stopped.
+ *
+ * Note that this even can be fired multiple times for a given tgid/fd pair.
+ * E.g.: mem2mem drivers expect stream on/off on both output and capture queues.
+ */
+DECLARE_EVENT_CLASS(v4l2_stream_class,
+	TP_PROTO(u32 tgid, s32 fd, u32 type),
+	TP_ARGS(tgid, fd, type),
+
+	TP_STRUCT__entry(__field(u32, tgid)
+			 __field(s32, fd)
+			 __field(u32, type)
+	),
+
+	TP_fast_assign(__entry->tgid = tgid;
+		       __entry->fd = fd;
+		       __entry->type = type;
+	),
+
+	TP_printk("tgid = %u, fd = %d, type = %s",
+		  __entry->tgid, __entry->fd, show_type(__entry->type))
+);
+
+DEFINE_EVENT(v4l2_stream_class, v4l2_streamon,
+	TP_PROTO(u32 tgid, s32 fd, u32 type),
+	TP_ARGS(tgid, fd, type)
+);
+
+DEFINE_EVENT(v4l2_stream_class, v4l2_streamoff,
+	TP_PROTO(u32 tgid, s32 fd, u32 type),
+	TP_ARGS(tgid, fd, type)
+);
+
 #endif /* if !defined(_TRACE_V4L2_H) || defined(TRACE_HEADER_MULTI_READ) */
 
 /* This part must be outside protection */

-- 
2.56.1

