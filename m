Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8AF3EAC84
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Jun 2026 17:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420323; cv=none; b=MaS5Gx7RMsL4i0V1+PWTRAYPm0i9CZ9HwWYHaH6iflaMOtzAXu6uIrQpN+A99osk8srGWd3L4Z/jV0bpWw/bhOy4Tl0zfyMQd+ljZ9KV8wZPrMjkWyDWx9FDoPPf4+SVTUDKqK6//vHYVCY/tnGPUYOGdx+ZMOZ6SVztoKIz03c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420323; c=relaxed/simple;
	bh=q2D1PdLXHfULJ8hVmCvZ9+71InWOnR2zyao0ZfjYgVk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jMgQw8+Ys39kSUyJ7yUPh0+sC/eMIb6D3heKea9a0WrM7mI7wH/quDQRP2amoloLLF5g1lE+cgEdAqfytiqONM6LbBVjFPK68IP0AfNvljlZSkrGJe9FBtA5vDpjrBRzCMrmfC1njqIGYlOI59FLps/EKjVez4OcNhYbs5km++g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n2z4uN5E; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n2z4uN5E"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-becb4e3e9a9so226756766b.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 02 Jun 2026 10:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780420320; x=1781025120; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fLbM8FqXWD57bGaryPb+2b83A2T/BA91IWHNooPwMd0=;
        b=n2z4uN5E1ROSg6mnw8heukBNHGcDm34p5j6rINKOFOTIMrorV++8oHndS8YOMMB3oN
         JiCpM9fnHlVfuMH9JmSZTbzXUVY8VMtGVSSdqaMjYuMb7fhbqjp17+qS/7C4NPt/1ltK
         vdN7lc19ra5yzqRlVbLHAWC6OEuQhFdCeKIqHDIHwfTa6ZxLJsIyhhtRWj0Hbz72sCx/
         u9sdcw1ebNn5CurWWMHrAr1WR3eevYxPMGvICin31xLNeJo4nuyeRqN9neCDHvReW8Ib
         1M5XXGpittk/KHlBTrUTtkl0jBw4+DPj3e2Tt1kyf+4pWk6Wkd/nkcLNlnPJmsP9Xrq3
         /yzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780420320; x=1781025120;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fLbM8FqXWD57bGaryPb+2b83A2T/BA91IWHNooPwMd0=;
        b=lovhFtKORgwnPMkog3wrCv80EFTv0+s2d+xOhNwlyvJo1ZncnyyIht3MKgmIt9AM52
         RFE887UPYk8klZSIiZeygKL9El9fYTOBW8+S6kJ5rd9npXqTAKz74dG88Z3M91qigG4h
         7KmmRh1WQWKwjfQ8wr4/Nk+ZpLYGFpIdC+tLBxtbtZiumz8OB2WxmCdkIbAaE5dtxZ+G
         vyVNw46rlU8xb1tuUDr9Lel+/5M6K/5jjmgU0zOramk6By4qB3Jaf/++vJxQsz8dNaxQ
         SJ15FuRMRZgwDSyJdz25uuRYd9u5zQpqq/jLAYJR4PqA4/4Ihl9lk/wDawH6KKpq1BDO
         19jg==
X-Forwarded-Encrypted: i=1; AFNElJ8ImBk/Ve1MqGbaCmlOUFPLWruY26fvEkqLRNoLMG9V8n8J6AnY+ZLnx62t+Fr3no9uPs+FLYX2qoMfjLhYO0RURBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTboxL1OpeiX4ymeK43SvziOw6G9tWnsrbz5GNtlTmJ0HdOumI
	lSWZCQ0HacHMGHZlun34985PfweFIHGRDbFroBtl9nD84jqqlo6bRBzRQrjXUpD799h2aRMabBY
	Me75kuI8DoIDXrmR1qLX3uw==
X-Received: from ejas20.prod.google.com ([2002:a17:906:3554:b0:bc2:d5c8:1c77])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:4fd2:b0:be3:b3fb:e2 with SMTP id a640c23a62f3a-bf061b0a8ecmr28896366b.32.1780420319902;
 Tue, 02 Jun 2026 10:11:59 -0700 (PDT)
Date: Tue,  2 Jun 2026 18:11:33 +0100
In-Reply-To: <20260602171146.2238998-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602171146.2238998-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260602171146.2238998-2-vdonnefort@google.com>
Subject: [PATCH 01/13] tracing/remotes: Release tracefs,eventfs on
 registration failure
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

In trace_remote_register(), if registration of events or the init
callback fails, the created tracefs and eventfs directories are leaked.

Release the entire eventfs and tracefs hierarchy on trace_remote
registration.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index d6c3f94d67cd..cfe84e9b8fe6 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -44,7 +44,8 @@ struct trace_remote {
 	struct trace_buffer		*trace_buffer;
 	struct trace_buffer_desc	*trace_buffer_desc;
 	struct dentry			*dentry;
-	struct eventfs_inode		*eventfs;
+	struct eventfs_inode		*eventfs_root;
+	struct eventfs_inode		*eventfs_subdir;
 	struct remote_event		*events;
 	unsigned long			nr_events;
 	unsigned long			trace_buffer_size;
@@ -795,26 +796,28 @@ static const struct file_operations trace_fops = {
 	.release	= trace_release,
 };
 
+static struct dentry *tracefs_root;
+static DEFINE_MUTEX(tracefs_lock);
+static u64 tracefs_root_count;
+
 static int trace_remote_init_tracefs(const char *name, struct trace_remote *remote)
 {
 	struct dentry *remote_d, *percpu_d, *d;
-	static struct dentry *root;
-	static DEFINE_MUTEX(lock);
 	bool root_inited = false;
 	int cpu;
 
-	guard(mutex)(&lock);
+	guard(mutex)(&tracefs_lock);
 
-	if (!root) {
-		root = tracefs_create_dir(TRACEFS_DIR, NULL);
-		if (!root) {
+	if (!tracefs_root) {
+		tracefs_root = tracefs_create_dir(TRACEFS_DIR, NULL);
+		if (!tracefs_root) {
 			pr_err("Failed to create tracefs dir "TRACEFS_DIR"\n");
 			return -ENOMEM;
 		}
 		root_inited = true;
 	}
 
-	remote_d = tracefs_create_dir(name, root);
+	remote_d = tracefs_create_dir(name, tracefs_root);
 	if (!remote_d) {
 		pr_err("Failed to create tracefs dir "TRACEFS_DIR"%s/\n", name);
 		goto err;
@@ -866,14 +869,15 @@ static int trace_remote_init_tracefs(const char *name, struct trace_remote *remo
 			goto err;
 	}
 
+	tracefs_root_count++;
 	remote->dentry = remote_d;
 
 	return 0;
 
 err:
 	if (root_inited) {
-		tracefs_remove(root);
-		root = NULL;
+		tracefs_remove(tracefs_root);
+		tracefs_root = NULL;
 	} else {
 		tracefs_remove(remote_d);
 	}
@@ -881,8 +885,26 @@ static int trace_remote_init_tracefs(const char *name, struct trace_remote *remo
 	return -ENOMEM;
 }
 
+static void trace_remote_remove_tracefs(struct trace_remote *remote)
+{
+	guard(mutex)(&tracefs_lock);
+
+	if (!remote->dentry)
+		return;
+
+	tracefs_remove(remote->dentry);
+	remote->dentry = NULL;
+
+	tracefs_root_count--;
+	if (!tracefs_root_count) {
+		tracefs_remove(tracefs_root);
+		tracefs_root = NULL;
+	}
+}
+
 static int trace_remote_register_events(const char *remote_name, struct trace_remote *remote,
 					struct remote_event *events, size_t nr_events);
+static void trace_remote_unregister_events(struct trace_remote *remote);
 
 /**
  * trace_remote_register() - Register a Tracefs remote
@@ -905,10 +927,9 @@ static int trace_remote_register_events(const char *remote_name, struct trace_re
 int trace_remote_register(const char *name, struct trace_remote_callbacks *cbs, void *priv,
 			  struct remote_event *events, size_t nr_events)
 {
-	struct trace_remote *remote;
+	struct trace_remote *remote __free(kfree) = kzalloc_obj(*remote);
 	int ret;
 
-	remote = kzalloc_obj(*remote);
 	if (!remote)
 		return -ENOMEM;
 
@@ -919,22 +940,30 @@ int trace_remote_register(const char *name, struct trace_remote_callbacks *cbs,
 	mutex_init(&remote->lock);
 	init_rwsem(&remote->reader_lock);
 
-	if (trace_remote_init_tracefs(name, remote)) {
-		kfree(remote);
-		return -ENOMEM;
-	}
+	ret = trace_remote_init_tracefs(name, remote);
+	if (ret)
+		return ret;
 
 	ret = trace_remote_register_events(name, remote, events, nr_events);
 	if (ret) {
 		pr_err("Failed to register events for trace remote '%s' (%d)\n",
 		       name, ret);
-		return ret;
+		goto err_remove_tracefs;
 	}
 
 	ret = cbs->init ? cbs->init(remote->dentry, priv) : 0;
-	if (ret)
+	if (ret) {
 		pr_err("Init failed for trace remote '%s' (%d)\n", name, ret);
+		goto err_unregister_events;
+	}
+
+	no_free_ptr(remote);
+	return 0;
 
+err_unregister_events:
+	trace_remote_unregister_events(remote);
+err_remove_tracefs:
+	trace_remote_remove_tracefs(remote);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(trace_remote_register);
@@ -1267,7 +1296,6 @@ static int remote_events_dir_callback(const char *name, umode_t *mode, void **da
 static int trace_remote_init_eventfs(const char *remote_name, struct trace_remote *remote,
 				     struct remote_event *evt)
 {
-	struct eventfs_inode *eventfs = remote->eventfs;
 	static struct eventfs_entry dir_entries[] = {
 		{
 			.name		= "enable",
@@ -1292,35 +1320,37 @@ static int trace_remote_init_eventfs(const char *remote_name, struct trace_remot
 			.callback	= remote_event_callback,
 		}
 	};
-	bool eventfs_create = false;
+	struct eventfs_inode *eventfs_root, *eventfs_subdir, *e;
 
-	if (!eventfs) {
-		eventfs = eventfs_create_events_dir("events", remote->dentry, dir_entries,
-						    ARRAY_SIZE(dir_entries), remote);
-		if (IS_ERR(eventfs))
-			return PTR_ERR(eventfs);
+	eventfs_root = remote->eventfs_root;
+	eventfs_subdir = remote->eventfs_subdir;
+	if (!eventfs_root) {
+		eventfs_root = eventfs_create_events_dir("events", remote->dentry, dir_entries,
+							 ARRAY_SIZE(dir_entries), remote);
+		if (IS_ERR(eventfs_root))
+			return PTR_ERR(eventfs_root);
 
 		/*
 		 * Create similar hierarchy as local events even if a single system is supported at
 		 * the moment
 		 */
-		eventfs = eventfs_create_dir(remote_name, eventfs, NULL, 0, NULL);
-		if (IS_ERR(eventfs))
-			return PTR_ERR(eventfs);
-
-		remote->eventfs = eventfs;
-		eventfs_create = true;
+		eventfs_subdir = eventfs_create_dir(remote_name, eventfs_root, NULL, 0, NULL);
+		if (IS_ERR(eventfs_subdir)) {
+			eventfs_remove_events_dir(eventfs_root);
+			return PTR_ERR(eventfs_subdir);
+		}
 	}
 
-	eventfs = eventfs_create_dir(evt->name, eventfs, entries, ARRAY_SIZE(entries), evt);
-	if (IS_ERR(eventfs)) {
-		if (eventfs_create) {
-			eventfs_remove_events_dir(remote->eventfs);
-			remote->eventfs = NULL;
-		}
-		return PTR_ERR(eventfs);
+	e = eventfs_create_dir(evt->name, eventfs_subdir, entries, ARRAY_SIZE(entries), evt);
+	if (IS_ERR(e)) {
+		if (!remote->eventfs_root)
+			eventfs_remove_events_dir(eventfs_root);
+		return PTR_ERR(e);
 	}
 
+	remote->eventfs_root = eventfs_root;
+	remote->eventfs_subdir = eventfs_subdir;
+
 	return 0;
 }
 
@@ -1335,11 +1365,11 @@ static int trace_remote_attach_events(struct trace_remote *remote, struct remote
 		if (evt->remote)
 			return -EEXIST;
 
-		evt->remote = remote;
-
 		/* We need events to be sorted for efficient lookup */
 		if (i && evt->id <= events[i - 1].id)
 			return -EINVAL;
+
+		evt->remote = remote;
 	}
 
 	remote->events = events;
@@ -1348,14 +1378,33 @@ static int trace_remote_attach_events(struct trace_remote *remote, struct remote
 	return 0;
 }
 
+static void trace_remote_detach_events(struct trace_remote *remote, struct remote_event *events,
+					size_t nr_events)
+{
+	int i;
+
+	for (i = 0; i < nr_events; i++) {
+		struct remote_event *evt = &events[i];
+
+		if (evt->remote == remote)
+			evt->remote = NULL;
+	}
+
+	remote->events = NULL;
+	remote->nr_events = 0;
+}
+
 static int trace_remote_register_events(const char *remote_name, struct trace_remote *remote,
 					struct remote_event *events, size_t nr_events)
 {
 	int i, ret;
 
 	ret = trace_remote_attach_events(remote, events, nr_events);
-	if (ret)
+	if (ret) {
+		/* It is safe to call detach on a half-registered array */
+		trace_remote_detach_events(remote, events, nr_events);
 		return ret;
+	}
 
 	for (i = 0; i < nr_events; i++) {
 		struct remote_event *evt = &events[i];
@@ -1369,6 +1418,12 @@ static int trace_remote_register_events(const char *remote_name, struct trace_re
 	return 0;
 }
 
+static void trace_remote_unregister_events(struct trace_remote *remote)
+{
+	trace_remote_detach_events(remote, remote->events, remote->nr_events);
+	eventfs_remove_events_dir(remote->eventfs_root);
+}
+
 static int __cmp_events(const void *key, const void *data)
 {
 	const struct remote_event *evt = data;
-- 
2.54.0.1032.g2f8565e1d1-goog

