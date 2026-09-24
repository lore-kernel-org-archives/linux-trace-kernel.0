Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3185349BD77
	for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 14:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790261916; cv=none; b=skia9iX59pQ5/heA15FXxwhrFi/ItbfRJ6rkTkOUZEGnS8ywC9ot2rQhQBtHhn0UQH/xaQp7SNfH5Ay4nZsKJqUtJMCWYn6Q8w4gPjDK7/FrKMs3G3JodQ/zanndhVoATdiWNGe8MIfn0ouBBxD18pG+B3mmmwQxTnS9Ww+CUEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790261916; c=relaxed/simple;
	bh=8IP5M85GEc9DZCVpxOVA7q7jaHvKb5L/UyyoWCRHz7w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E2oP0pj0Dm03sU/SIjPmTtBB921WmM5zP4BpRrZicsymUfVlwJSmIDdOXfp87YW34z9vRSPE1p59V5+UaweOIngGfpldij4kNfg7jRU8AX2f2X/2o39qN3BgKWOvY4C9SOYrS68RzbogjzJcAWZCnP+m3InL0RksP3g5NEipsjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rQTRGKJX; arc=none smtp.client-ip=209.85.221.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rQTRGKJX"
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-486f3dbf7d2so1932288f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 07:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790261906; x=1790866706; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SB0f/oZzDgJUNrGoxHodiamfHa/t2U0me9tn4pyQ+fE=;
        b=rQTRGKJXjBbf9uNJtDdOt7lICUA4vrg+JDCIYl7e2MG6n1nDEFjHSGazwUnsJ1963u
         QtspGKk/6sfDYuKjTVMwx8Ymx70qgnMu6uHGEDo1zBD7rdwew9AT39eOQgY9MNZscQlx
         uuqsVkFYrUwkHeqL2SSlpjEkM7mowNjwoBuXz1qGgAWWm7EqAD88MVycHqJyLnPr3pJ8
         WVdXZsVPmnDqid1e1Cs/GxZv2QLY7i288NCBmaseeYiXXT6mudzluwUiE0XcP1TZAdid
         sdRO8ydhZu17st17WGeXCXqEU8OoFwDhThgbyqMn9Xo6aOgjbihUZAmVcOomuMIG33nI
         ciGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790261906; x=1790866706;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SB0f/oZzDgJUNrGoxHodiamfHa/t2U0me9tn4pyQ+fE=;
        b=YhUoLgOXmFLAjX28wCUYBADc1mv0M5KZegsnWzI4DNuMpE8C9vu1/wLJxkhJSLwxAN
         0UiuODEx9FcJV91rre1Vf21DPVl/QWYGaxzctbGVmFo9T+xtuWk8VYNSq6qaDipIUAyT
         85w3H2S6u5EVea+5An8vWjJgcEFvVOJ+wmJdM3Nnjz4GEZ3BQXTeJUtOkez17ujDTfHz
         i36gY1e6RiqXjX6QHHyBmiqvazYEbbm+vTiKmV5ffFgWw9EwkCj/DLuBVC6GsUANGGSg
         rHs6vvFd5Qy74j9XzBR31yJCImoH0f4PlXPOOCncp4EONbTxc0rq05gazv9gdhzN8sxA
         tPZQ==
X-Forwarded-Encrypted: i=1; AKwUvBzjBS4MbJyHBG0FGrsqYCuuM5Y2LvGuqkBM916nEhU88cXvjimZbZudfpEGU5hWtCCELQ5FET/ne7eu/ncoOyJ8xeo=@vger.kernel.org
X-Gm-Message-State: AFuF++kUXD2dtTtg51WBAFI3eW1RtF9D6ajGdQZOaukRsRPpfgpKB3mc
	loZpWZJVZ8GeH91uKSeB1JmyiQzYhs0c59O+rxksj8y5uRn3Z/5XElV2in8o7mBWpRKyiN2+JWL
	YHSyi7rK3ESWZW31SvpJz+w==
X-Received: from wrbft9.prod.google.com ([2002:a05:6000:2b09:b0:488:5a78:17c])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2c07:b0:486:fa7b:d3aa with SMTP id ffacd0b85a97d-4887172d776mr4922520f8f.23.1790261905912;
 Thu, 24 Sep 2026 07:58:25 -0700 (PDT)
Date: Thu, 24 Sep 2026 15:57:36 +0100
In-Reply-To: <20260924145754.1285146-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924145754.1285146-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260924145754.1285146-3-vdonnefort@google.com>
Subject: [PATCH v7 02/20] tracing/remotes: Release tracefs,eventfs on
 registration failure
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

In trace_remote_register(), if registration of events or the init
callback fails, the created tracefs and eventfs directories are leaked.

Release the entire eventfs and tracefs hierarchy on trace_remote
registration failure.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/trace_remote.c | 137 ++++++++++++++++++++++++------------
 1 file changed, 93 insertions(+), 44 deletions(-)

diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index e8cbbd01964d..a1b84290be2d 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -45,7 +45,8 @@ struct trace_remote {
 	struct trace_buffer		*trace_buffer;
 	struct trace_buffer_desc	*trace_buffer_desc;
 	struct dentry			*dentry;
-	struct eventfs_inode		*eventfs;
+	struct eventfs_inode		*eventfs_root;
+	struct eventfs_inode		*eventfs_subdir;
 	struct remote_event		*events;
 	unsigned long			nr_events;
 	unsigned long			trace_buffer_size;
@@ -60,6 +61,7 @@ struct trace_remote {
 
 static DEFINE_MUTEX(trace_remotes_lock);
 static LIST_HEAD(trace_remotes);
+static struct dentry *trace_remotes_root;
 
 static bool trace_remote_loaded(struct trace_remote *remote)
 {
@@ -865,23 +867,21 @@ static const struct file_operations trace_fops = {
 static int trace_remote_init_tracefs(const char *name, struct trace_remote *remote)
 {
 	struct dentry *remote_d, *percpu_d, *d;
-	static struct dentry *root;
-	static DEFINE_MUTEX(lock);
 	bool root_inited = false;
 	int cpu;
 
-	guard(mutex)(&lock);
+	lockdep_assert_held(&trace_remotes_lock);
 
-	if (!root) {
-		root = tracefs_create_dir(TRACEFS_DIR, NULL);
-		if (!root) {
+	if (!trace_remotes_root) {
+		trace_remotes_root = tracefs_create_dir(TRACEFS_DIR, NULL);
+		if (!trace_remotes_root) {
 			pr_err("Failed to create tracefs dir "TRACEFS_DIR"\n");
 			return -ENOMEM;
 		}
 		root_inited = true;
 	}
 
-	remote_d = tracefs_create_dir(name, root);
+	remote_d = tracefs_create_dir(name, trace_remotes_root);
 	if (!remote_d) {
 		pr_err("Failed to create tracefs dir "TRACEFS_DIR"%s/\n", name);
 		goto err;
@@ -939,8 +939,8 @@ static int trace_remote_init_tracefs(const char *name, struct trace_remote *remo
 
 err:
 	if (root_inited) {
-		tracefs_remove(root);
-		root = NULL;
+		tracefs_remove(trace_remotes_root);
+		trace_remotes_root = NULL;
 	} else {
 		tracefs_remove(remote_d);
 	}
@@ -948,8 +948,26 @@ static int trace_remote_init_tracefs(const char *name, struct trace_remote *remo
 	return -ENOMEM;
 }
 
+static void trace_remote_remove_tracefs(struct trace_remote *remote)
+{
+	lockdep_assert_held(&trace_remotes_lock);
+
+	if (!remote->dentry)
+		return;
+
+	tracefs_remove(remote->dentry);
+	remote->dentry = NULL;
+
+	if (!list_empty(&trace_remotes))
+		return;
+
+	tracefs_remove(trace_remotes_root);
+	trace_remotes_root = NULL;
+}
+
 static int trace_remote_register_events(const char *remote_name, struct trace_remote *remote,
 					struct remote_event *events, size_t nr_events);
+static void trace_remote_unregister_events(struct trace_remote *remote);
 
 /**
  * trace_remote_register() - Register a Tracefs remote
@@ -972,10 +990,9 @@ static int trace_remote_register_events(const char *remote_name, struct trace_re
 int trace_remote_register(const char *name, struct trace_remote_callbacks *cbs, void *priv,
 			  struct remote_event *events, size_t nr_events)
 {
-	struct trace_remote *remote;
+	struct trace_remote *remote __free(kfree) = kzalloc_obj(*remote);
 	int ret;
 
-	remote = kzalloc_obj(*remote);
 	if (!remote)
 		return -ENOMEM;
 
@@ -986,13 +1003,15 @@ int trace_remote_register(const char *name, struct trace_remote_callbacks *cbs,
 	mutex_init(&remote->lock);
 	init_rwsem(&remote->reader_lock);
 
-	if (trace_remote_init_tracefs(name, remote)) {
-		kfree(remote);
-		return -ENOMEM;
-	}
+	guard(mutex)(&trace_remotes_lock);
+
+	ret = trace_remote_init_tracefs(name, remote);
+	if (ret)
+		return ret;
 
 	ret = trace_remote_register_events(name, remote, events, nr_events);
 	if (ret) {
+		trace_remote_remove_tracefs(remote);
 		pr_err("Failed to register events for trace remote '%s' (%d)\n",
 		       name, ret);
 		return ret;
@@ -1000,13 +1019,16 @@ int trace_remote_register(const char *name, struct trace_remote_callbacks *cbs,
 
 	ret = cbs->init ? cbs->init(remote->dentry, priv) : 0;
 	if (ret) {
+		trace_remote_unregister_events(remote);
+		trace_remote_remove_tracefs(remote);
 		pr_err("Init failed for trace remote '%s' (%d)\n", name, ret);
-	} else {
-		guard(mutex)(&trace_remotes_lock);
-		list_add(&remote->node, &trace_remotes);
+		return ret;
 	}
 
-	return ret;
+	list_add(&remote->node, &trace_remotes);
+	retain_and_null_ptr(remote);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(trace_remote_register);
 
@@ -1349,7 +1371,6 @@ static int remote_events_dir_callback(const char *name, umode_t *mode, void **da
 static int trace_remote_init_eventfs(const char *remote_name, struct trace_remote *remote,
 				     struct remote_event *evt)
 {
-	struct eventfs_inode *eventfs = remote->eventfs;
 	static struct eventfs_entry dir_entries[] = {
 		{
 			.name		= "enable",
@@ -1374,35 +1395,37 @@ static int trace_remote_init_eventfs(const char *remote_name, struct trace_remot
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
-	}
-
-	eventfs = eventfs_create_dir(evt->name, eventfs, entries, ARRAY_SIZE(entries), evt);
-	if (IS_ERR(eventfs)) {
-		if (eventfs_create) {
-			eventfs_remove_events_dir(remote->eventfs);
-			remote->eventfs = NULL;
+		eventfs_subdir = eventfs_create_dir(remote_name, eventfs_root, NULL, 0, NULL);
+		if (IS_ERR(eventfs_subdir)) {
+			eventfs_remove_events_dir(eventfs_root);
+			return PTR_ERR(eventfs_subdir);
 		}
-		return PTR_ERR(eventfs);
 	}
 
+	e = eventfs_create_dir(evt->name, eventfs_subdir, entries, ARRAY_SIZE(entries), evt);
+	if (IS_ERR(e)) {
+		if (!remote->eventfs_root)
+			eventfs_remove_events_dir(eventfs_root);
+		return PTR_ERR(e);
+	}
+
+	remote->eventfs_root = eventfs_root;
+	remote->eventfs_subdir = eventfs_subdir;
+
 	return 0;
 }
 
@@ -1417,11 +1440,11 @@ static int trace_remote_attach_events(struct trace_remote *remote, struct remote
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
@@ -1430,14 +1453,33 @@ static int trace_remote_attach_events(struct trace_remote *remote, struct remote
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
@@ -1451,6 +1493,13 @@ static int trace_remote_register_events(const char *remote_name, struct trace_re
 	return 0;
 }
 
+static void trace_remote_unregister_events(struct trace_remote *remote)
+{
+	trace_remote_detach_events(remote, remote->events, remote->nr_events);
+	if (remote->eventfs_root)
+		eventfs_remove_events_dir(remote->eventfs_root);
+}
+
 static int __cmp_events(const void *key, const void *data)
 {
 	const struct remote_event *evt = data;
-- 
2.56.0.rc1.310.g51773c2048-goog

