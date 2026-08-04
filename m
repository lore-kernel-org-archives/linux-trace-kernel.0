Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6C5459AED
	for <linux-trace-kernel@vger.kernel.org>; Tue,  4 Aug 2026 14:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785852237; cv=none; b=FJZGOkXOhepNcfDgOOBM3L2Kxem35Ft22cktN4mnRUPQPh4XK0VcbzejR9dJZenh/Yjg/GA4plgd20tYwoBPDMpiPao9VXW2A7dKEH5Ioso7T8QlVb2i/34haK5IL7k3+yRnoAuzwOG6WYHLwi/Xr5rySgOJL/m2UPNgp788cwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785852237; c=relaxed/simple;
	bh=ZZa6sguesyvp1haPO2t380zTzWp+MSrF4GFexM2Xk7o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fnWQwm4Z3GRf7OspKVoENpjinAJX7dJZBndWf0xvj4itLNYLH0Tv7PqdiPcEcGwFTA6e//DH1Et5h3mLehF6iR8uSRJcFAdaMTxd52LyjTxo/CSrtqlld/A0Rnw2tHQA6xfQZDCJWnoiGzosET8JcjUxnDkBLuJ9uAtP5wzJNqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qm7t7kAr; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qm7t7kAr"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4956c1655c3so19913735e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 04 Aug 2026 07:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785852234; x=1786457034; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ikv3MFrtxR/TTIAPltWHqrylTHFidk32FHs+OM6AkYM=;
        b=Qm7t7kArALzoYEwT0kn+GZSB20R619Kg1KhoD2n83h4T2xtMu3+q3PEUK4gfM4wfIG
         i5tSwJFRNS2Q6fXci2pGzehMnE3gM+7bRFTJm5UAcUzb9/4yyg4qLZWJp1LQLMCleR/c
         JlOLjA4UMJyTITNIYHn9iB6aWvBOieqcyVw16fIvQ0IV28+JFGP6P1Q4cUqsAyBLt/o4
         4b0OvLReZKXInDQG9evMgt5mBBRcWeFBe6PZQJma4eGwj2R2CgPHwrHlWYukuEk/eAYM
         F1edmOWwDdWR3XiPSM+ixs0aDTe4nZetkaPi8/uCSgHnY+yxyaBY64NLi2J3/aHBVxZ8
         9rcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785852234; x=1786457034;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ikv3MFrtxR/TTIAPltWHqrylTHFidk32FHs+OM6AkYM=;
        b=OGAz/BDyIyKH/F67QncfKHOadMclXbH4RXk0DMgJnwrHyMqXTmdJTvWqJmWBmpUT3f
         s0C7vjLkvaYiuWZmk/V9KZrEKkyUfPBPYuHRG0wnlsXEw01Yrt1WcVudK8I4ecYitfT+
         hsfSEZlzMxiP8O18LyhBVzc1PbD6PabwWiU/vH7goI4wKtRA4js/ayDLfSm0R2YNawoZ
         kMrS9Jv2zhMQk9zkK/83AEEqeF4IrLTNxuPuLDfE29P2rsE/C1LltV1gT6NOT7+PkCBv
         I6qRaef1OAs7z/57NFqUfCONC/fK71J+3Z2RNHk4cKySVUOZx2mwsg04614Nayh7AOyb
         Ji8w==
X-Forwarded-Encrypted: i=1; AHgh+RqZx1lk/PfRlCPlewNe9WYGzIMgXiPh5FjGxJXlHUxmRY5U+ApKgx4s0x+EUxdRnv0M7K23l47+gkXj9aMp+Yrtgqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMvFItQMnISanyH80s2scsjYls2VgkokjymmjJRwGq0KlbcdR5
	A9Y5SM2ZJqugSvgr3Su4JN6clzkIVLZU0jacD6DG9H/wmL322tq4/Q0/y31U2g/rk92fSt8zscq
	cLFsaMio0oioJP54Ew19ZWA==
X-Received: from wmpn28.prod.google.com ([2002:a05:600c:181c:b0:493:b78f:716b])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:350c:b0:495:4d00:2fda with SMTP id 5b1f17b1804b1-4980f23180fmr271643705e9.2.1785852233517;
 Tue, 04 Aug 2026 07:03:53 -0700 (PDT)
Date: Tue,  4 Aug 2026 15:03:17 +0100
In-Reply-To: <20260804140333.797210-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804140333.797210-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804140333.797210-3-vdonnefort@google.com>
Subject: [PATCH v4 02/18] tracing/remotes: Release tracefs,eventfs on
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

diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index ce2d517183b7..0384277070b9 100644
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
 
@@ -1345,7 +1367,6 @@ static int remote_events_dir_callback(const char *name, umode_t *mode, void **da
 static int trace_remote_init_eventfs(const char *remote_name, struct trace_remote *remote,
 				     struct remote_event *evt)
 {
-	struct eventfs_inode *eventfs = remote->eventfs;
 	static struct eventfs_entry dir_entries[] = {
 		{
 			.name		= "enable",
@@ -1370,35 +1391,37 @@ static int trace_remote_init_eventfs(const char *remote_name, struct trace_remot
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
 
@@ -1413,11 +1436,11 @@ static int trace_remote_attach_events(struct trace_remote *remote, struct remote
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
@@ -1426,14 +1449,33 @@ static int trace_remote_attach_events(struct trace_remote *remote, struct remote
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
@@ -1447,6 +1489,13 @@ static int trace_remote_register_events(const char *remote_name, struct trace_re
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
2.55.0.571.g244d577d93-goog

