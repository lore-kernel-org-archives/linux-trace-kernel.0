Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534158;
	b=K39KnLKByf6PerARxhmr9h1K3A4uFXgaCxX4OOZuBneQ2/Ba4+e0JarfeTf4yGej5mog
	 BSm9avRBHTZITxC9LJL6zrjCPEPlBSPgFwpph3mmtIC2kvMR9hd03vBq3EcvrLW6QSksu
	 8DBUeCuNNZ+dhWPMcbrB4wCsp+P7zKHfYbDAwOvA3K765Ex3tWWeytAMAxJ8gGUn5r3ea
	 VOemboWCGNz2/EUTglL304w03L9eqeMDFtlkZrBCA57+cnD+1eIREaq/gGVEvFQPOf7C6
	 3euA+dP2gN8rA+vmzdWRjydW54Lrq1dhXJ0xXPTPwhDOuV/+lJchLimo/PEO6psf5bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534158;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=7NNvfATBgoqyP9g5BE16T7BDqTiZfULTMPCslX8t2oI=;
	b=qeu4FU1CtbvrYc56vIiFQ/8X7Scwpl6yrCjP8RNnR4MGiLHeAn/U1TjZX0RvxH0xSUJ+
	 MrtAsLxmAU/9pb8SzW3HtioMTpFzBv/F39ZjqSX8n3sysuxbrtoKb73XZTr++UujIjDwH
	 oU7fSq3DpIyApXMW85EOrHnNtJM3RDEofWDZ1FWiQxyHoP0Pz5weZBvSoAa46QKAI6gE3
	 sAUi5XDX+kX/ZlgJP5L2W9cvg4G9sM1smap0ouN7QXjet6DCNAC3knvNImgJrQwMzxFoC
	 OdNWJRGvBM+bxWviooffHgq801H++MLmRjoLddiuurWJw2B1jHco+KEERs4KLBVa02g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Hp3X8mJF;
	arc=none smtp.remote-ip=209.85.128.70
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586E7606A326
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 15:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 586E7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Hp3X8mJF
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4994d67d0e3so28781855e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 07:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795534157; x=1796138957; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7NNvfATBgoqyP9g5BE16T7BDqTiZfULTMPCslX8t2oI=;
        b=Hp3X8mJFJwlrI6ipaDW45I+4hKNUaxHDtJ6dnlkERsJ5zpmDEDxDbc/ef9Q1JKXowa
         7DljfuX/r+tYA2kwlEUH/vEdkeWdUjgji9uSwxRArj5d0BGchwZ8xFnpLk+fPC0OR9hf
         m7adqe+5tutEOtZh4SR8wQ3IptUWPk4mJxEr6p+un4Om345AU3/U7X2Nb+hxcV+O4lG1
         hXYG64IdAKTpUZzkLVBkQbqEC9mGyC4s0Gy7OdhEfaaJw7r/HraV2JEoNt1D9HKEgSFD
         RZqimBwzy8pDrYMEfokvUXc0ixw7FedLX+yXQ2os95ckrrhQW8Y9TlPOKxB5M/pI6Fxv
         FbPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795534157; x=1796138957;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7NNvfATBgoqyP9g5BE16T7BDqTiZfULTMPCslX8t2oI=;
        b=SIq1F+PWcm0jaAIR58YhNT5pCZW5is4sdy0amQI3q7yEirwpuDQlbtDiWUAINKQgS8
         s2TMolwrnIV5rL9D+7kMoOT3LAGCPes9vzukRjRIYgmiLBLbSqKnQMxi+PcvpJY0Nh9N
         GsvGMAP/EcxbfJv7weJVzbR+GUoigFEygCM2mMUQjCb3EQhfNM9ZCTEUMqsQeNTXbYVm
         ovqyJm4+O5D57potagoZepxd7PcmqKTTxkwWghajXQCSo/Q57AvhJeL6P9i87dY2WwkW
         qbeBv818Ay+iqgi1BNGieazJx93wvtOAAh6BDGFt98cNJbpUhX3GZugTtOiOlYDxex1c
         4Vbg==
X-Forwarded-Encrypted: i=1; AL+hErFzNW/hhESRnf74IU17eXJVnEI0b2LM8EM//pP613HrxVna2yqBXwCWjvudpbvlu1myoA0gbticINenaiI8+XP6ml0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8wT8leeu4Zqyxa3VR5bqj0c814U3p/NWbWxnOOplUlJoVhQgJK
	tLCSEmsgA3D3AdQdEY7EjHB037hTjighJcafq1/yxrzDLMMCys4m6NDN6x372ml93trkMmwbal5
	wtwl7c+Rm3YFa5Pa3ND0/rg==
X-Received: from wmep21.prod.google.com ([2002:a05:600c:4315:b0:4bb:5fab:7687])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1c0f:b0:4a1:f625:2108 with SMTP id 5b1f17b1804b1-4bb8881d4a3mr335413355e9.33.1795534156586;
 Tue, 24 Nov 2026 07:29:16 -0800 (PST)
Date: Tue, 24 Nov 2026 15:28:25 +0000
In-Reply-To: <20261124152845.2233401-1-vdonnefort@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261124152845.2233401-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261124152845.2233401-2-vdonnefort@google.com>
Subject: [PATCH v9 01/21] tracing/remotes: Gate tracefs files opening on trace
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
2.56.1.809.ga0b61035b5-goog

