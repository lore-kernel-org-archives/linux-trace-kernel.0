Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795632297;
	b=BT+DNoC9TdKdZsAOrp9LM/1nK3vRvgcb6Kn613pn4jWaIAmhe0nECShuwEf8lK6NiAu0
	 SSGPVHzT+ZGt47lGPgthYqTraeSAEa0vrFA40XvfLTuSeiTcW0M7UR+y+2qwUvXq7HYRm
	 pRYJQFT29CI2mBP/Kbrwm/c1QebJ3nFF6ZS+lWu4fx4/wv7NoEI6W81wroFXyao4BsGf6
	 RtVxUnR0v1gmJ61l60v8DzgshNXgj3B/sUh1mVGZnzkM5sOP+Es/+1tuc3XZAgJx6Udzg
	 eqzGZgLB2gx0RSKB52mTQwLtD2z4aP25F0XfbFRgzDIJ98soPrd19kOvjhGQc24kE3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795632297;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=lztRdkoEfHXfPLjrWU6dsJpmXlIzrR9WYIGBZGJqNOI=;
	b=uAgrsTUFs7CaiSCBzHN9Wt0/6T2vLtSUdnThG5Oav1DSUU8DWLQWQkCgRBI4cRYoKVLv
	 jG9WGAJ9mDUwGgr2NnQ6DHz0+AthNstxobWoT+ZqkAAAWEng9PNSKxEkRFgnhcjDnt6Jp
	 xsvYtYXu1Z1LIBJdPRcZBIKA/zZh/tnmHOzDcnJIH3M2wbZRUpIaoDSkEaiHU7BYsrtKO
	 75OT9C8CjsIH5htk93BATBtUbTCVPwZmJRYwENNUvrawC3v+iB+mRHU9t7W8hACCW6UBU
	 hxfHlHlDjhH9NoIQlqmgJ7gbenh/txBQNAXrplNT5LVvgxYGlhJiFfzptGm5gB1Rhhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=H+0tWgFZ;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35537606A68E;
	Wed, 25 Nov 2026 18:44:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35537606A68E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=H+0tWgFZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795632295;
	bh=/9vfGQcY27HGY4BnTzA1JyrGpZYrrGs5WU0br6myPH8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=H+0tWgFZHaXyTs0SeNGvu9d+37Lsgps8h+kvZ5ttWpoJww4ses4gXabpCnihydBLu
	 Y7ffi4NKRTKrR3bx6ajJYvpqsI7lSN/KiWb+I8quemZnXuB5gzAMKGGGc3orXNgxWN
	 rJaTfDFnR66FD1jKCkWTJz+Bzc3fVl36ZX892b7gUwScaoydzaIz3BoEjh+Rg5YMKK
	 xFc6Gs/SGAguFwlnV49CLBfr2QSZWbTw18odj5x+1M/chtVIOK+tAQb+Pt6pw1mc23
	 THZab79pYejPYq18ycRun7f9qUBh/Py+rwdrG6N/Z2IMevsWIVsQPdcDPG2LqwFes+
	 RgIVQIfpy9c4Q==
Received: from [192.168.0.15] (unknown [100.64.0.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BB30A17E10D0;
	Wed, 25 Nov 2026 19:44:53 +0100 (CET)
From: Detlev Casanova <detlev.casanova@collabora.com>
Date: Wed, 25 Nov 2026 13:33:25 -0500
Subject: [PATCH v3 3/9] media: Add tgid and fd fields in v4l2_fh struct
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
Message-Id: <20261125-v4l2-add-ftrace-v3-3-1d1db48372ed@collabora.com>
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

These fields will be used in traces to help userspace tracing tools
identify streams.

The tgid field will keep the PID of the process that opened the video
file.
That is needed because trace calls can happen in IRQs, for which there is
no current PID.

The fd field helps identify the context in case the same process opens the
video device multiple times.
Note that the fd field is set in the __video_do_ioctl() function.
That is because the file descriptor has not been allocated yet when
v4l2_open() is called.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 drivers/media/v4l2-core/v4l2-fh.c    |  1 +
 drivers/media/v4l2-core/v4l2-ioctl.c | 17 +++++++++++++++++
 include/media/v4l2-fh.h              |  4 ++++
 3 files changed, 22 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-fh.c b/drivers/media/v4l2-core/v4l2-fh.c
index b184bed8aca9..9c2ddd1c2137 100644
--- a/drivers/media/v4l2-core/v4l2-fh.c
+++ b/drivers/media/v4l2-core/v4l2-fh.c
@@ -37,6 +37,7 @@ void v4l2_fh_init(struct v4l2_fh *fh, struct video_device *vdev)
 	INIT_LIST_HEAD(&fh->available);
 	INIT_LIST_HEAD(&fh->subscribed);
 	fh->sequence = -1;
+	fh->tgid = current->tgid;
 	mutex_init(&fh->subscribe_lock);
 }
 EXPORT_SYMBOL_GPL(v4l2_fh_init);
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 17ba1ae70735..5d7fbaa1b41a 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/compat.h>
+#include <linux/fdtable.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -3063,6 +3064,16 @@ void v4l_printk_ioctl(const char *prefix, unsigned int cmd)
 }
 EXPORT_SYMBOL(v4l_printk_ioctl);
 
+static int _file_iterate(const void *priv, struct file *filp, unsigned int fd)
+{
+	const struct file *fh_filp = priv;
+
+	if (fh_filp == filp)
+		return fd;
+
+	return 0;
+}
+
 static long __video_do_ioctl(struct file *file,
 		unsigned int cmd, void *arg)
 {
@@ -3083,6 +3094,12 @@ static long __video_do_ioctl(struct file *file,
 		return ret;
 	}
 
+	if (unlikely(!vfh->fd)) {
+		vfh->fd = iterate_fd(current->files, 0, _file_iterate, file);
+		if (!vfh->fd)
+			vfh->fd = -1;
+	}
+
 	/*
 	 * We need to serialize streamon/off/reqbufs with queueing new requests.
 	 * These ioctls may trigger the cancellation of a streaming
diff --git a/include/media/v4l2-fh.h b/include/media/v4l2-fh.h
index aad4b3689d7e..080cb00e3867 100644
--- a/include/media/v4l2-fh.h
+++ b/include/media/v4l2-fh.h
@@ -28,6 +28,8 @@ struct v4l2_ctrl_handler;
  * @vdev: pointer to &struct video_device
  * @ctrl_handler: pointer to &struct v4l2_ctrl_handler
  * @prio: priority of the file handler, as defined by &enum v4l2_priority
+ * @tgid: process id that initialized the v4l2_fh
+ * @fd: file descriptor associated to this v4l2_fh for the process id in tgid
  *
  * @wait: event' s wait queue
  * @subscribe_lock: serialise changes to the subscribed list; guarantee that
@@ -44,6 +46,8 @@ struct v4l2_fh {
 	struct video_device	*vdev;
 	struct v4l2_ctrl_handler *ctrl_handler;
 	enum v4l2_priority	prio;
+	u32			tgid;
+	int			fd;
 
 	/* Events */
 	wait_queue_head_t	wait;

-- 
2.56.1

