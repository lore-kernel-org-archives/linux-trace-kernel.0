Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A37C488D86
	for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 14:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790261912; cv=none; b=Bvno3IOlHVdfZDHUEvo7mk+diAPVXSSusk7wO/wcy1u8xqOhFObTvUiP6Co5vicEeOv3DH0/YgwBMwiu3dzM5M85TBLs0196ifoWvOZGxhjZke51ifImKXs3qzhZ0Jpfpi9dL821+BYrD3AKsTV63+aCgN/BOxM9qHgCRb5cSYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790261912; c=relaxed/simple;
	bh=+5xzwqBwN12gEv4ssy42i2wicH2rwdcYPmLPkH0iOt8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Tr2A+TZ5/9Be0nHpuuaXmL+qzG/lQscH06bBzLStdER+MhQnD90Ktfo+H5bYtBONcN46+nSCLLv0ebMkoloWC0NGXHlPYH6zdjJcCbMA1qljcAAvE3KwmJR0RDsduxOk1pyZtt3afP9CPW/Ppm+8qVjfOSmNVnc7ezVC9Kp1X4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tP33E7WR; arc=none smtp.client-ip=209.85.221.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tP33E7WR"
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47f6e8b5996so1975042f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 07:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790261905; x=1790866705; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S6PHrhtzlOlzacnZWCd9pcPPcI58m9bE8rZaxBxUxWY=;
        b=tP33E7WRaRRWYHb0b/nicfk55UJNNJkw6mzqzFgBx9C0tL0no0y455aXv2Kt0HcKZ2
         k7pGSa82MYs8p63W2QrOfxktE1EBJqZbAngW1PGQzjI0QDRhXlu4Q5Ya2O0dJvEJk4Tx
         qwQhVTv7fscs5cs9x4C6iSD0KlFKUo3H8bIHbopDsMFc2bEd6IWaFMBnAVypCaqYle/I
         o5+s2Ayf8s0c3ar0V+8VQHVEfhADXzKQNjFMi6Pk5EXCKHue66alGzIz49aQ4M8FSqH6
         npePQ3Cp0/OXUkcErdMHZfKKHyt6y3IaHOV9GEzl1rmPpTjJMkvI72dQ+U9eRYBwMA3c
         Q0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790261905; x=1790866705;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S6PHrhtzlOlzacnZWCd9pcPPcI58m9bE8rZaxBxUxWY=;
        b=sYV5XJAba0pXxDVaCaxbvvRG923yW7XdjvgIILaKjU99SpQrkjtE5adogw2jb9oDw7
         id7TqC06ZrunPzvPMtQTXEQStLRQVVpcpn21ZRtd0bpPFRGGlqdPETdeea4VMmrlfB5+
         YGCm1C9sbxHkKSo/Y8qXL9aIsjRdKbUemFCeG3E8ITtcLlv3qLUDwGT0cvItt2PSPXOa
         3qbqV2j4e9GTK/Qbcj8PN8rhWRsfs2RcFCm1DSABomupj3BumajAHnHlxog/qVXduwHr
         P4Gj70AINqG5zjPygzF00uS3J8z7X0vCp62DCc47A9fREzPYWhnO5vBlVWSBG7OVnefl
         oVug==
X-Forwarded-Encrypted: i=1; AKwUvBzLgDXwcsjwSPN/a/lSxLAgw3LHqMMSXO6Wl5s6tRU/gxyNPYKvmJiCIhEsC13X4lw8pu9igDDejLS0Fw8Dc17WUSQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mC20VIzlZzZy/Io5MpD4hPkUUPxz9eAvoNdrTpUS1P0vXP7vX0
	g/23ygpyEbhp8FiiGkEVLGuT15eThUvY4Ii2DDwvg7wrQ0PPRi0tS9qDduRJBfjA2XQTPm84t1j
	8ZS0YxahGTHXpXHiC7zMPPg==
X-Received: from wrbfi6.prod.google.com ([2002:a05:6000:4406:b0:488:7084:ff02])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:230b:b0:487:956:7e97 with SMTP id ffacd0b85a97d-48871735978mr4973091f8f.25.1790261904955;
 Thu, 24 Sep 2026 07:58:24 -0700 (PDT)
Date: Thu, 24 Sep 2026 15:57:35 +0100
In-Reply-To: <20260924145754.1285146-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924145754.1285146-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260924145754.1285146-2-vdonnefort@google.com>
Subject: [PATCH v7 01/20] tracing/remotes: Gate tracefs files opening on trace
 remote registration
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, if a remote fails to register, its resources will leak and
will not be properly torn down.

To prevent a user accessing a remote tracefs that is about to be
destroyed, keep track of the registered remotes in a global list,
similarly to trace instances. Gate the tracefs open function based on
the presence of the remote in that list.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/trace_remote.c | 100 +++++++++++++++++++++++++++++++-----
 1 file changed, 87 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index 2d5bc423efca..e8cbbd01964d 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -39,6 +39,7 @@ struct trace_remote_iterator {
 };
 
 struct trace_remote {
+	struct list_head		node;
 	struct trace_remote_callbacks	*cbs;
 	void				*priv;
 	struct trace_buffer		*trace_buffer;
@@ -57,6 +58,9 @@ struct trace_remote {
 	bool				tracing_on;
 };
 
+static DEFINE_MUTEX(trace_remotes_lock);
+static LIST_HEAD(trace_remotes);
+
 static bool trace_remote_loaded(struct trace_remote *remote)
 {
 	return !!remote->trace_buffer;
@@ -170,6 +174,60 @@ static void trace_remote_reset(struct trace_remote *remote, int cpu)
 	trace_remote_try_unload(remote);
 }
 
+static int trace_remote_tracefs_open(struct inode *inode, struct file *filp)
+{
+	void *i_private = inode->i_private;
+	struct trace_remote *r;
+
+	if (!i_private)
+		return -ENODEV;
+
+	guard(mutex)(&trace_remotes_lock);
+
+	/* i_private is either a struct trace_remote or a struct remote_event */
+	list_for_each_entry(r, &trace_remotes, node) {
+		if (r == i_private)
+			return 0;
+		if (!r->events)
+			continue;
+		if (i_private >= (void *)r->events &&
+		    i_private < (void *)(r->events + r->nr_events))
+			return 0;
+	}
+
+	return -ENODEV;
+}
+
+#define DEFINE_TRACE_REMOTE_ATTRIBUTE_FUNCS(__name)			\
+static int __name ## _open(struct inode *inode, struct file *file)	\
+{									\
+	int ret = trace_remote_tracefs_open(inode, file);		\
+									\
+	if (ret)							\
+		return ret;						\
+									\
+	return single_open(file, __name ## _show, inode->i_private);	\
+}
+
+#define DEFINE_TRACE_REMOTE_ATTRIBUTE(__name)				\
+DEFINE_TRACE_REMOTE_ATTRIBUTE_FUNCS(__name)				\
+static const struct file_operations __name ## _fops = {			\
+	.open		= __name ## _open,				\
+	.read		= seq_read,					\
+	.write		= __name ## _write,				\
+	.llseek		= seq_lseek,					\
+	.release	= single_release,				\
+}
+
+#define DEFINE_TRACE_REMOTE_SHOW_ATTRIBUTE(__name)			\
+DEFINE_TRACE_REMOTE_ATTRIBUTE_FUNCS(__name)				\
+static const struct file_operations __name ## _fops = {			\
+	.open		= __name ## _open,				\
+	.read		= seq_read,					\
+	.llseek		= seq_lseek,					\
+	.release	= single_release,				\
+}
+
 static ssize_t
 tracing_on_write(struct file *filp, const char __user *ubuf, size_t cnt, loff_t *ppos)
 {
@@ -198,7 +256,7 @@ static int tracing_on_show(struct seq_file *s, void *unused)
 
 	return 0;
 }
-DEFINE_SHOW_STORE_ATTRIBUTE(tracing_on);
+DEFINE_TRACE_REMOTE_ATTRIBUTE(tracing_on);
 
 static ssize_t buffer_size_kb_write(struct file *filp, const char __user *ubuf, size_t cnt,
 				    loff_t *ppos)
@@ -235,7 +293,7 @@ static int buffer_size_kb_show(struct seq_file *s, void *unused)
 
 	return 0;
 }
-DEFINE_SHOW_STORE_ATTRIBUTE(buffer_size_kb);
+DEFINE_TRACE_REMOTE_ATTRIBUTE(buffer_size_kb);
 
 static int trace_remote_get(struct trace_remote *remote, int cpu)
 {
@@ -593,6 +651,11 @@ static int trace_pipe_open(struct inode *inode, struct file *filp)
 	struct trace_remote *remote = inode->i_private;
 	struct trace_remote_iterator *iter;
 	int cpu = tracing_get_cpu(inode);
+	int ret;
+
+	ret = trace_remote_tracefs_open(inode, filp);
+	if (ret)
+		return ret;
 
 	guard(mutex)(&remote->lock);
 
@@ -734,22 +797,26 @@ static int trace_open(struct inode *inode, struct file *filp)
 	int cpu = tracing_get_cpu(inode);
 	int ret;
 
+	ret = trace_remote_tracefs_open(inode, filp);
+	if (ret)
+		return ret;
+
 	if (!(filp->f_mode & FMODE_READ))
 		return 0;
 
+	ret = seq_open(filp, &trace_sops);
+	if (ret)
+		return ret;
+
 	guard(mutex)(&remote->lock);
 
 	iter = trace_remote_iter(remote, cpu, TRI_NONCONSUMING);
-	if (IS_ERR(iter))
+	if (IS_ERR(iter)) {
+		seq_release(inode, filp);
 		return PTR_ERR(iter);
-
-	ret = seq_open(filp, &trace_sops);
-	if (ret) {
-		trace_remote_iter_free(iter);
-		return ret;
 	}
 
-	((struct seq_file *)filp->private_data)->private = (void *)iter;
+	((struct seq_file *)filp->private_data)->private = iter;
 
 	return 0;
 }
@@ -932,8 +999,12 @@ int trace_remote_register(const char *name, struct trace_remote_callbacks *cbs,
 	}
 
 	ret = cbs->init ? cbs->init(remote->dentry, priv) : 0;
-	if (ret)
+	if (ret) {
 		pr_err("Init failed for trace remote '%s' (%d)\n", name, ret);
+	} else {
+		guard(mutex)(&trace_remotes_lock);
+		list_add(&remote->node, &trace_remotes);
+	}
 
 	return ret;
 }
@@ -1073,7 +1144,7 @@ static ssize_t remote_event_enable_write(struct file *filp, const char __user *u
 
 	return count;
 }
-DEFINE_SHOW_STORE_ATTRIBUTE(remote_event_enable);
+DEFINE_TRACE_REMOTE_ATTRIBUTE(remote_event_enable);
 
 static int remote_event_id_show(struct seq_file *s, void *unused)
 {
@@ -1083,7 +1154,7 @@ static int remote_event_id_show(struct seq_file *s, void *unused)
 
 	return 0;
 }
-DEFINE_SHOW_ATTRIBUTE(remote_event_id);
+DEFINE_TRACE_REMOTE_SHOW_ATTRIBUTE(remote_event_id);
 
 static int remote_event_format_show(struct seq_file *s, void *unused)
 {
@@ -1112,7 +1183,7 @@ static int remote_event_format_show(struct seq_file *s, void *unused)
 
 	return 0;
 }
-DEFINE_SHOW_ATTRIBUTE(remote_event_format);
+DEFINE_TRACE_REMOTE_SHOW_ATTRIBUTE(remote_event_format);
 
 static int remote_event_callback(const char *name, umode_t *mode, void **data,
 				 const struct file_operations **fops)
@@ -1198,6 +1269,7 @@ static ssize_t remote_events_dir_enable_read(struct file *filp, char __user *ubu
 }
 
 static const struct file_operations remote_events_dir_enable_fops = {
+	.open = trace_remote_tracefs_open,
 	.write = remote_events_dir_enable_write,
 	.read = remote_events_dir_enable_read,
 };
@@ -1222,6 +1294,7 @@ remote_events_dir_header_page_read(struct file *filp, char __user *ubuf, size_t
 }
 
 static const struct file_operations remote_events_dir_header_page_fops = {
+	.open = trace_remote_tracefs_open,
 	.read = remote_events_dir_header_page_read,
 };
 
@@ -1245,6 +1318,7 @@ remote_events_dir_header_event_read(struct file *filp, char __user *ubuf, size_t
 }
 
 static const struct file_operations remote_events_dir_header_event_fops = {
+	.open = trace_remote_tracefs_open,
 	.read = remote_events_dir_header_event_read,
 };
 
-- 
2.56.0.rc1.310.g51773c2048-goog

