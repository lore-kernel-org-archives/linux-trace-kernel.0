Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB2278276;
	Fri, 29 Nov 2024 16:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732898925; cv=none; b=pKpFbzZrGjsICqFJBHM85J6hPNJ90tYW9N8mFXCK6EoZ5lOiqjfd6JD+xLqMh7wblkHOzZ4HgJeRrAy9jIMcjR1QBOIz6olK+7Ok56xxjEq5M6VmGaBPtlr3G4PmbmRCE/1MKG8iZRfj6OlC7Md7auIy5UPh+XPhmDtdA6rbrec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732898925; c=relaxed/simple;
	bh=/wkJeDupE0S2YFw2GJZXNRuiJiFo7UvOtoxklJ0O1A8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VYqTxqeRlLfPvhWM7/8v90Snfiad2eOuOY+u7o36OxiEaEYO1hPNnw7d8HkW7+b3lAfpuvylK2Ik+eGp+eqHnPB9QrjxYnvSJDkUq5LXmOHVbGm7FNVXP8K8yCvTeWCFBfVM7r6eLQMduJuGDXYvXt0IHhqGUkwVGO89o8U3vyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iobigL/S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iobigL/S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08DA4C4CED2;
	Fri, 29 Nov 2024 16:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732898925;
	bh=/wkJeDupE0S2YFw2GJZXNRuiJiFo7UvOtoxklJ0O1A8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iobigL/Smk8BLze7nrcfcJZOvfMFXJsrXMc2tyWYylQVDuDpha7HAeMFj5gUCsRFz
	 OAP6mpFQOYJgDhzTz14t3afrsfN79FocbczYMcQYuaKNytWUqiX3ftICNKLJr786vy
	 T2pzf0FMHM67H1QHZ1AVz/Ps1X2TzvOB8qOsSjPtlaYfrLiHUlYHnz7qW2aXBSXbGT
	 icbiWDEBp2egNIX9AsXHN+EN0C+O9Uk8mY640xsGHyci6GphY1BV2yXZztFEi23em4
	 Sz2jfZCN9QUsc31uLf3cZxaReuz9eaIlBoX9Bx2ycgTZ79bkeDV2Mmjn4If2Gw4IVn
	 b6Wvpbiy0O+eQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Naveen N Rao <naveen@kernel.org>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] tracing/dynevent: Adopt guard() and scoped_guard()
Date: Sat, 30 Nov 2024 01:48:40 +0900
Message-ID: <173289891992.73724.9491350426847416169.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173289885627.73724.13632317993038475335.stgit@devnote2>
References: <173289885627.73724.13632317993038475335.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Use guard() or scoped_guard() in dynamic events for critical sections
rather than discrete lock/unlock pairs.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v2:
  - Use scoped_guard() instead of guard() to avoid goto warnings.
---
 kernel/trace/trace_dynevent.c |   35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index 4376887e0d8a..eb8f669c15e1 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -63,9 +63,8 @@ int dyn_event_register(struct dyn_event_operations *ops)
 		return -EINVAL;
 
 	INIT_LIST_HEAD(&ops->list);
-	mutex_lock(&dyn_event_ops_mutex);
+	guard(mutex)(&dyn_event_ops_mutex);
 	list_add_tail(&ops->list, &dyn_event_ops_list);
-	mutex_unlock(&dyn_event_ops_mutex);
 	return 0;
 }
 
@@ -106,20 +105,20 @@ int dyn_event_release(const char *raw_command, struct dyn_event_operations *type
 		goto out;
 	}
 
-	mutex_lock(&event_mutex);
-	for_each_dyn_event_safe(pos, n) {
-		if (type && type != pos->ops)
-			continue;
-		if (!pos->ops->match(system, event,
-				argc - 1, (const char **)argv + 1, pos))
-			continue;
-
-		ret = pos->ops->free(pos);
-		if (ret)
-			break;
+	scoped_guard(mutex, &event_mutex) {
+		for_each_dyn_event_safe(pos, n) {
+			if (type && type != pos->ops)
+				continue;
+			if (!pos->ops->match(system, event,
+					argc - 1, (const char **)argv + 1, pos))
+				continue;
+
+			ret = pos->ops->free(pos);
+			if (ret)
+				break;
+		}
+		tracing_reset_all_online_cpus();
 	}
-	tracing_reset_all_online_cpus();
-	mutex_unlock(&event_mutex);
 out:
 	argv_free(argv);
 	return ret;
@@ -133,13 +132,12 @@ static int create_dyn_event(const char *raw_command)
 	if (raw_command[0] == '-' || raw_command[0] == '!')
 		return dyn_event_release(raw_command, NULL);
 
-	mutex_lock(&dyn_event_ops_mutex);
+	guard(mutex)(&dyn_event_ops_mutex);
 	list_for_each_entry(ops, &dyn_event_ops_list, list) {
 		ret = ops->create(raw_command);
 		if (!ret || ret != -ECANCELED)
 			break;
 	}
-	mutex_unlock(&dyn_event_ops_mutex);
 	if (ret == -ECANCELED)
 		ret = -EINVAL;
 
@@ -198,7 +196,7 @@ int dyn_events_release_all(struct dyn_event_operations *type)
 	struct dyn_event *ev, *tmp;
 	int ret = 0;
 
-	mutex_lock(&event_mutex);
+	guard(mutex)(&event_mutex);
 	for_each_dyn_event(ev) {
 		if (type && ev->ops != type)
 			continue;
@@ -216,7 +214,6 @@ int dyn_events_release_all(struct dyn_event_operations *type)
 	}
 out:
 	tracing_reset_all_online_cpus();
-	mutex_unlock(&event_mutex);
 
 	return ret;
 }

