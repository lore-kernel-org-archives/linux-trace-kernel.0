Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFBC47CC85
	for <linux-trace-kernel@vger.kernel.org>; Mon, 11 May 2026 18:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778523924; cv=none; b=HeBZyv5PyJ5JeDBrLkFJRf7cWU2X6xw/Ky5GT0PiDBUVg7jTFjqsVJQM/GgxNzHMi/NmZRBYvHprxYyWIH5ZVr907PeEWPTTfvs1FPmtpt0V7ohYErWvAfi7MTkr7NtLxGj+dPZXoBdJjv4JNBPxHBRyQfUg6Tz3D9xmmaEWJ0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778523924; c=relaxed/simple;
	bh=e/86egzIPIJnJBpM7nA833Sd6LId+B75HRElGKUem60=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G6qcdEJYdjI3AiQgV+TymyT/MrBsb3RcYDaiJCcGuu7hL9OuKT9vkuunrglpWFfiZn6dLuVANkY1btQ5HZofmn+LIQ2jk6iaOmMqQrZRxNySflgt/wHrqUUB0uTtRG7qHXkAoFG1DsitpTs0b5W+xtNNWKjEA8SccR+k+O88sDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X6cd78er; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X6cd78er"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778523920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aOka89wKQYcbIpNURyHjkJzZlwApVr8sbGR1QlKrqvk=;
	b=X6cd78erysjpIfKHEOgBTvBYm2PkrrOb/EMt7bvOWRuT9NMYy9Cgdd06TdzqNhkJ4WVkl7
	b2MiUQWDsAVcI0LIYvJmOkrxFk6b5Nwaklr73DCmxtAlUxCGEbeF+xG0tSqQ+gAq8fmYtV
	ufBBhyZ0nEfkdzLiDdm6LohpdlC2vMc=
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [RFC PATCH v2 02/10] rv/da: fix per-task da_monitor_destroy() ordering and sync
Date: Tue, 12 May 2026 02:24:48 +0800
Message-Id: <d02c656aada7d071f083460a5c9a454363669b61.1778522945.git.wen.yang@linux.dev>
In-Reply-To: <cover.1778522945.git.wen.yang@linux.dev>
References: <cover.1778522945.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Wen Yang <wen.yang@linux.dev>

The following two paths race:

  CPU 0 (disable_stall/__rv_disable_monitor)  CPU 1 (wwnr probe handler)
  ------------------------------------------  -----------------------------
  disable_stall()
    da_monitor_destroy()
      da_monitor_reset_all()          <------ [task T: monitoring=0]
                                              da_monitor_start(&T->rv[n])
                                              /* no timer_setup */
                                               monitoring=1  <----
  tracepoint_synchronize_unregister()
  // CPU 1 probe has already returned; sync returns

Later, enable_stall() acquires the same slot and calls da_monitor_init():

  da_monitor_reset_all()
    da_monitor_reset(&T->rv[slot])    // monitoring=1, timer.function==0
      ha_monitor_reset_env()
        ha_cancel_timer()
          timer_delete(&ha_mon->timer)  // ODEBUG: timer never initialised

  ODEBUG: assert_init not available (active state 0)
  object type: timer_list
  Call trace: timer_delete <- da_monitor_reset_all <- enable_stall

Call tracepoint_synchronize_unregister() inside da_monitor_destroy()
before da_monitor_reset_all().  The unregister_trace_xxx() calls in the
monitor's disable() have already disconnected the tracepoints; the sync
here drains any handler still in flight, so no new monitoring=1 can
appear after da_monitor_reset_all() clears the slot.

Also fix the slot release ordering: release the slot only after
reset_all() to avoid accessing rv[] with an out-of-bounds index.

Fixes: f5587d1b6ec9 ("rv: Add Hybrid Automata monitor type")
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 include/rv/da_monitor.h | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 00ded3d5ab3f..d04bb3229c75 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -304,6 +304,20 @@ static int da_monitor_init(void)
 
 /*
  * da_monitor_destroy - return the allocated slot
+ *
+ * Call tracepoint_synchronize_unregister() before reset_all() to close
+ * the race where an in-flight non-HA probe handler sets monitoring=1
+ * (without calling timer_setup()) after da_monitor_reset_all() has
+ * already cleared the slot but before the caller's own sync completes.
+ * Without this barrier, an HA_TIMER_WHEEL monitor that later acquires
+ * the same slot would call timer_delete() on a never-initialised
+ * timer_list, triggering ODEBUG warnings.
+ *
+ * Note: tracepoint_synchronize_unregister() is a system-wide barrier
+ * that waits for all CPUs to finish any in-flight tracepoint handlers.
+ * The caller's own __rv_disable_monitor() issues a second sync after
+ * returning from disable(); that redundant call is harmless on the
+ * infrequent admin (enable/disable) path.
  */
 static inline void da_monitor_destroy(void)
 {
@@ -311,10 +325,10 @@ static inline void da_monitor_destroy(void)
 		WARN_ONCE(1, "Disabling a disabled monitor: " __stringify(MONITOR_NAME));
 		return;
 	}
+	tracepoint_synchronize_unregister();
+	da_monitor_reset_all();
 	rv_put_task_monitor_slot(task_mon_slot);
 	task_mon_slot = RV_PER_TASK_MONITOR_INIT;
-
-	da_monitor_reset_all();
 }
 
 #elif RV_MON_TYPE == RV_MON_PER_OBJ
-- 
2.25.1

