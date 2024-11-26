Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF181D4613;
	Tue, 26 Nov 2024 13:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732629438; cv=none; b=XtGbAih9ETnxEkOpH9VFvQRLHhiG0dR/FVuw8Z7d19UkmOK4vyWPLMkulgvyLp7v9ACxRo06eMFjhdvfvBJNvz9CwjNlc+tdFQaPcdB09TlOZyinA2fkJZXPrVlOHSylaGMOSRmb7989zljDUtZTkf6c46gIW3cbVmDeOihzrnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732629438; c=relaxed/simple;
	bh=d2A8Z0/djHyH30plmbMZNP6qI0p49POUzSrAaXMl4HI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=srYGV4zMom8bj5AfYTNNhVthi3O8vF7InJjP1vWMfS+hNB8tYfjjC4mwIVL4JGjO1C3yLQGKb7b2eN622VLQRFbEGpcItEZUDX1YoY07/jj6EbRaxlsqRxj3Qnp9+O64kqX3JBpYIW20WkEEx91eksdP7bNTCGvn2uEYnXUouC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRoDxZx4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRoDxZx4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B22C4CECF;
	Tue, 26 Nov 2024 13:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732629437;
	bh=d2A8Z0/djHyH30plmbMZNP6qI0p49POUzSrAaXMl4HI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DRoDxZx4TyM9f+gTOWkY7cDVzCktHXgv2GBmgqoXS3Rozx2GQ7CdMJN0ZXw1p6J6h
	 QHwXvUGfQHJBlkp531VJZvw+4Ms/U0uLUk4JCcFafgZzf0aJb+/PScjMX3Wclp/7tz
	 8sCSgaJmpEyn+G8twc9JwxfuKGmiRmAv+Cx6qJvMCBatx2BMIbGPtv6HHZrA/eU35I
	 tvyzhQ1XmVs8O/1uEP1cu/xwSSKBbG5GXBG4ILoslQ3cQAAt2MnTIqRZnST8DjvH25
	 l2qGyVoPiRxHYT6N6G4sjn0Ws/Y1Vl3OZef+y5dIZMhlgID8NKb6hIOlbJ1oCaoWFI
	 GggOKGrmONyKg==
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
Subject: [PATCH 6/6] tracing/dynevent: Adopt guard() and scoped_guard()
Date: Tue, 26 Nov 2024 22:57:12 +0900
Message-ID: <173262943230.8323.4595317585229847937.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173262937038.8323.5774362855789721936.stgit@devnote2>
References: <173262937038.8323.5774362855789721936.stgit@devnote2>
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
 kernel/trace/trace_dynevent.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index 4376887e0d8a..dbdcaef08f5d 100644
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
 
@@ -106,7 +105,7 @@ int dyn_event_release(const char *raw_command, struct dyn_event_operations *type
 		goto out;
 	}
 
-	mutex_lock(&event_mutex);
+	guard(mutex)(&event_mutex);
 	for_each_dyn_event_safe(pos, n) {
 		if (type && type != pos->ops)
 			continue;
@@ -119,7 +118,6 @@ int dyn_event_release(const char *raw_command, struct dyn_event_operations *type
 			break;
 	}
 	tracing_reset_all_online_cpus();
-	mutex_unlock(&event_mutex);
 out:
 	argv_free(argv);
 	return ret;
@@ -133,13 +131,12 @@ static int create_dyn_event(const char *raw_command)
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
 
@@ -198,7 +195,7 @@ int dyn_events_release_all(struct dyn_event_operations *type)
 	struct dyn_event *ev, *tmp;
 	int ret = 0;
 
-	mutex_lock(&event_mutex);
+	guard(mutex)(&event_mutex);
 	for_each_dyn_event(ev) {
 		if (type && ev->ops != type)
 			continue;
@@ -216,7 +213,6 @@ int dyn_events_release_all(struct dyn_event_operations *type)
 	}
 out:
 	tracing_reset_all_online_cpus();
-	mutex_unlock(&event_mutex);
 
 	return ret;
 }

