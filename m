Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C15430797
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Jul 2026 15:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783525166; cv=none; b=q/MS8XxDnkzlNIn9aURzWCkjUHC2ZmXZxrZrGL2jwIJiBB9QQFqIFohyBqiVPdTS924Xp1f5CRVIOYW8X3LyYYg0GPCMPi29tA29S+JWfE4wQw82L6CJIbpw6ce0hidfb0vl1dnBwSvssplVTj4T5V6AqgHl5VZAyhdgj3Q+edg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783525166; c=relaxed/simple;
	bh=7+DF/aJEBcKDiuQzH1z8CrBJbpc3lfiLrZOiOABAHi0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sa3nIjpjTNyNqiJICpitTlCxOh6keyPZReeag2Nq9tpUUlLJyalH7RyeqlKbF8gwssDXWjVx6cYVTJoRUwCo0sUMbD9WqXLfLk8jxl1jo1sYo4zirS9fo32Ay6vn2WUttirR8MmazuXPyFkgi+M9kWIk7rbPeaIHbYt74RKmNag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RNorSGBr; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RNorSGBr"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783525163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=11wI0rEoJdRnLQYyIux2fDqtgUfoApLYPxW50UVagiQ=;
	b=RNorSGBrrTOJfrJwOvVI3HSrLRr6ilvLh9EM/dUGO97F2G6RPbW2GqRmoQOi5/qgEfpfxI
	+BiACG84GPVbqK82kE8qTJRYX8S9bbKq44y/TOUZesatgShNB2myu5AYnkiEau6R/veGMO
	jB90a2SGJ8RE+iwL5PN9WU4v0WnARVA=
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v4 5/8] rv/ha: make da_monitor_reset_hook and EVENT_NONE_LBL overridable
Date: Wed,  8 Jul 2026 23:38:31 +0800
Message-Id: <cb34a9676b7de794c974082a0ee9ac76735748a3.1783524627.git.wen.yang@linux.dev>
In-Reply-To: <cover.1783524627.git.wen.yang@linux.dev>
References: <cover.1783524627.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Wen Yang <wen.yang@linux.dev>

Wrap both definitions with #ifndef guards so HA-based monitors can
substitute their own implementations before including this header.
tlob uses this to define a reset hook that cancels per-task hrtimers
on monitor teardown.

Overrides must still call ha_monitor_reset_env() or cancel outstanding
timers to avoid timer UAF.

No behaviour change for monitors that do not override either macro.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 include/rv/ha_monitor.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
index dddf5694bcc8..6d526eef8348 100644
--- a/include/rv/ha_monitor.h
+++ b/include/rv/ha_monitor.h
@@ -36,7 +36,15 @@ static bool ha_monitor_handle_constraint(struct da_monitor *da_mon,
 					 da_id_type id);
 #define da_monitor_event_hook ha_monitor_handle_constraint
 #define da_monitor_init_hook ha_monitor_init_env
+
+/*
+ * Allow monitors to override da_monitor_reset_hook before including this
+ * header. The override must still call ha_monitor_reset_env() or cancel
+ * timers explicitly.
+ */
+#ifndef da_monitor_reset_hook
 #define da_monitor_reset_hook ha_monitor_reset_env
+#endif
 #define da_monitor_sync_hook() synchronize_rcu()
 
 #if !defined(HA_SKIP_AUTO_CLEANUP) && RV_MON_TYPE == RV_MON_PER_TASK
@@ -75,7 +83,9 @@ _Static_assert(offsetof(struct ha_monitor, da_mon) == 0,
 #define ENV_INVALID_VALUE U64_MAX
 /* Error with no event occurs only on timeouts */
 #define EVENT_NONE EVENT_MAX
+#ifndef EVENT_NONE_LBL
 #define EVENT_NONE_LBL "none"
+#endif
 #define ENV_BUFFER_SIZE 64
 
 #ifdef CONFIG_RV_REACTORS
-- 
2.25.1

