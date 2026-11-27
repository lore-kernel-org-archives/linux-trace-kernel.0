Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795797947;
	b=RidUrQIxDoaiPw7qZiPV3NXkL1w3wkdBeqTihi9kdpnuhYkBmH6EmSAvua+qWR10jd5K
	 msMc+ZZ+4/61dPmZyab1BsbuMr6/Ek4lWQeOecOV7jZcobjz2bpLpNoKiX8L4G1IUcpDM
	 keqa0qHxxhRoNaXg0U/1K5xYvyR/rO4i/wOcZ8nQZavY7N1Y7De/PZIOtICC7hWncBhrH
	 Ype5gmG0pq7nXY8k7wJu6P6jG07SKZ3MuA566tyW6bRlXdvw6yNpCoPatiHra3DRGHP3u
	 OSCqVgZagAaXbzwUghoqkEXkoA/3GUDPtKIDL/wUSNe2FonA4HzwDx5m6jIl9hryZdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795797947;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=HFVjlK2/ZN8iw8KcioYecF5BoysxU3xKdxy3x1b9yCU=;
	b=MMtnguRne2XWtFqap32aY7+sVEeQ9QWY0YsDwgnXyUwYybX9dSvOAaLpUI+/Wwtuu9Km
	 85y9fn4cjK5aW3S3U9OxWpYUNLQ4waOsHP7VuUa+ol81/D/MGulMymRHnoEK+DoJguXP7
	 we/jPS/0HSDQBlx27WIGrS0Yngp1c9qOsN6GUADIkbETk6Vl13lZBoggF/F8TtRNIEfE9
	 +xSp2Pp6AwrTV4HH7feQMZ1esN/8UBdMTxXu9fIIZBIW7G+2k957NFaiM8O0biLQGXHRO
	 vkgQ1egWANyN+DNESJgMVk0FY39HNu0Xv7uVD4lxmfyv0fJ/j0kxNXkPoExK5h0QXEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=YxymA8n9;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA334606A33A;
	Fri, 27 Nov 2026 16:45:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA334606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=YxymA8n9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795797945;
	bh=vOoLLS94i0Xp6eV49qgNp1i51z+ZDU9shsgLcYWGC9I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YxymA8n9qTLDHA2yiZaq2+S6+7mx0bvAMIu3btxGlv11Lr/Z2X+BsL4EaFA2HeSIl
	 +zYP5fXNBqIl48mHzoXMzCQ09ZF3tq35Bo9uJai3c7ENzoCd55Ms+DAKXKUwPRmW38
	 87JUXlDRVWX/DfjTsEYGy2SJL8Lvcf4e1gXuiPSTyZknNkZ0Dq+lq5Oz8WYfqECdqO
	 Q4fsp8ApC8H9C9YCm7A49aaLHBv8G/k2rVFqWQYcmylw1/yQBOa5l8eokhvu7zFeNd
	 BzBXMWMBWNTrjRncHIyUmJpGfxi2sojlCoNBQ+E4fDwosJ0LDQmVdFZZ9CrnmQCjgu
	 rkEAI+DqOmjXQ==
Received: from [192.168.0.15] (unknown [100.64.0.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 24C6E17E0800;
	Fri, 27 Nov 2026 17:45:43 +0100 (CET)
From: Detlev Casanova <detlev.casanova@collabora.com>
Date: Fri, 27 Nov 2026 11:45:07 -0500
Subject: [PATCH v4 3/9] media: Add tgid and fd fields in v4l2_fh struct
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
Message-Id: <20261127-v4l2-add-ftrace-v4-3-24138479002f@collabora.com>
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
 drivers/media/v4l2-core/v4l2-fh.c    |  2 ++
 drivers/media/v4l2-core/v4l2-ioctl.c | 17 +++++++++++++++++
 include/media/v4l2-fh.h              |  4 ++++
 3 files changed, 23 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-fh.c b/drivers/media/v4l2-core/v4l2-fh.c
index b184bed8aca9..401ee97ddb50 100644
--- a/drivers/media/v4l2-core/v4l2-fh.c
+++ b/drivers/media/v4l2-core/v4l2-fh.c
@@ -37,6 +37,8 @@ void v4l2_fh_init(struct v4l2_fh *fh, struct video_device *vdev)
 	INIT_LIST_HEAD(&fh->available);
 	INIT_LIST_HEAD(&fh->subscribed);
 	fh->sequence = -1;
+	fh->tgid = current->tgid;
+	fh->fd = -1;
 	mutex_init(&fh->subscribe_lock);
 }
 EXPORT_SYMBOL_GPL(v4l2_fh_init);
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 17ba1ae70735..29ca2f7959ef 100644
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
+		return fd + 1;
+
+	return 0;
+}
+
 static long __video_do_ioctl(struct file *file,
 		unsigned int cmd, void *arg)
 {
@@ -3111,6 +3122,12 @@ static long __video_do_ioctl(struct file *file,
 		goto unlock;
 	}
 
+	if (unlikely(vfh->fd < 0)) {
+		vfh->fd = iterate_fd(current->files, 0, _file_iterate, file) - 1;
+		if (!vfh->fd)
+			vfh->fd = -1;
+	}
+
 	if (v4l2_is_known_ioctl(cmd)) {
 		info = &v4l2_ioctls[_IOC_NR(cmd)];
 
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

