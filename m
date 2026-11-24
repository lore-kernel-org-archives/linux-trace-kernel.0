Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534160;
	b=hrTQr4OT6JQ+e20yfLbZRen2BJSmLXpOFTkyfawGFYrx0Mpgm8jRK9CNnHoyvBzaqoZJ
	 vxNGK953wOh6v155mLD49wlRDMP0f8r0D6+w4xJzy+2nrbRmCr7u99zj8v5AL4RWWt9Me
	 /YYEp0NMi3akyZFodnrJzplQ2xkazP31QGS0/R8RgR7Lc1L3jD8lJh1W7oQyH7TGJOCox
	 ByOhYsW3ON6ms+OG5uJsUfDwJEsYRmGjTyCeSc1QY1rmBarhZ7zBOMRtPbSNEv34CE8Kj
	 C2X1KbzmZ3u6TRSyPbKRbxV1nJ0t+8D/5Gp3H3KFS8MnuSyfFvrd7p0fAL9u0nprVHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534160;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=55xZyVeLX6GFRd6SFmDSVMKIFmuIOsSeB8ztN/s1qks=;
	b=XZg9pZrjgMjJx61TqqE4YEfKOyuFHNkG9ushXhho0x2RyOLQKOGlzRWtqVLGiGvnGZka
	 bux6EqWiXWJZhKt1We9vwRtUkFyxlQP5Pmz8oQ6tUXSweIbl9H0k0p8NPKsSG54X9N2Bj
	 bgeZvADCfMbrjYkbyhwayYMI+3gX6ydlC8YASEdxh+Yl1MbZ964H2j0/WNdEuOkjbuLCd
	 DRRBwOYmDrGB5W4YzEQ8bF5GHYFkMvaWJcZRkuYgVZfsH8rB1JMF7sT/ulmIJMSGvqbSo
	 drtVopfKFra/UnHcCFCOO31DGRaAPLrJ91qS/kaI7vkjk5r4iw3pHAvbYdYCUXQJFQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fYgh3zd4;
	arc=none smtp.remote-ip=209.85.221.70
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA54D606A338
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 15:29:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA54D606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fYgh3zd4
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4ab855a8c21so3801147f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 07:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795534158; x=1796138958; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=55xZyVeLX6GFRd6SFmDSVMKIFmuIOsSeB8ztN/s1qks=;
        b=fYgh3zd4C5TZLYOQNeONsMLemTqu2Nsw5kal3Qql3O6ZrZXCO4AV1+5PaU6rXxLfMf
         G+a3UyRH5PF8IQL04uTjrWTWQIEceg1NMrJ7RRyV+A+prxHyBYtna032P7pALx03Gg3N
         y6JKwh7CISNLqCjHGad9vwDf5KkWKPL4AVF07QWI9tTt2cLRqobJekIUQxOxnR6cl+xK
         G/hZRLrfhuGveaU9++gSvsr4Bcv9w7tNalvzQUHU9T+HOd64yQ4F4+KC9IE0S0q7fTA/
         krRjqZ4chJGjntQ1OmA04+WqDuZ9Dx4yLQ6KDWnGo9yG4PZmvwKAcyqXJYTTNAkFfMlY
         IZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795534158; x=1796138958;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=55xZyVeLX6GFRd6SFmDSVMKIFmuIOsSeB8ztN/s1qks=;
        b=I/n5HBaKINdEb6kO1HDEBIusAZZGNTRj4KQNtV75t5vUaO14lBRVlTdRTbd/ukhBUp
         sKlUZE4ZwRY2/JEPjCVqg3GG6iYkRKrsRDRIT5DRzZupt52tcWMcXmxmtYsR1v7Sre7g
         UZTqLY9c554z0iT6uKu8KM3S+u7nvmRhSN5sEixogL2EKfHYgtHxFd4QOn/EFxB0W5uh
         eCafObV/LBvmocd7RSNUUM+ynvenJX0byimMZ3ehdwctaptpVZPiMOeMJOUL5OCg8HK0
         4bp1sznMdn9GqHp988Wqixmsof6lou2S/ACKtm8O1pkqCIi9DsZgShKIdLrKSZ4REQji
         iF2w==
X-Forwarded-Encrypted: i=1; AL+hErGU/wLFZVB6+/7DWig+v/+PPdWwOhjWAGzQ64jgzo8gSUQVJSG1mTzuChFdsGQBZrSDy8nyUrwrIm7stggubQ6KNTc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8WXNYHPko6+scKTf3NXNH7VTDFnH9SQkSZa1Fhz0Y75EyqtzyO
	vim7SnM52+V1r9lQIz4TUtoGV4/xrcSKSuaoh6oH1d8/I5O/ekPuMFF7oncxXRO5BbHGITkC1Jy
	GUOx39n6sxFSts6PV8ggC5g==
X-Received: from wrwi1.prod.google.com ([2002:a5d:55c1:0:b0:4b8:7c3f:5b3])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5d85:0:b0:4aa:e105:381a with SMTP id ffacd0b85a97d-4abb58ec01dmr30242630f8f.51.1795534157772;
 Tue, 24 Nov 2026 07:29:17 -0800 (PST)
Date: Tue, 24 Nov 2026 15:28:26 +0000
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
Message-ID: <20261124152845.2233401-3-vdonnefort@google.com>
Subject: [PATCH v9 02/21] tracing/remotes: Release tracefs,eventfs on
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
index e8cbbd01964d..8a1a0c4ea626 100644
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
+		if (IS_ERR_OR_NULL(eventfs_root))
+			return PTR_ERR_OR_ZERO(eventfs_root) ?: -EPERM;
 
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
+				       size_t nr_events)
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
2.56.1.809.ga0b61035b5-goog

