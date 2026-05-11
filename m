Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B247466B71
	for <linux-trace-kernel@vger.kernel.org>; Mon, 11 May 2026 18:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778523921; cv=none; b=s/ufQsTnu+ZTvbxStS9CDIWsAuWUbbeoLV3hteNwaO8EYtzfsC0YZuuvi5nyFosjglvtPULoMPT7ku/lZcPn7YSxL4egXmk2DsMzlyesRy+knzzN+JxkMCJwcfIAlZftEuEwzJa47uIjouGuWDUDkf+Nxra6uq9ZT7S2a4PdVFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778523921; c=relaxed/simple;
	bh=tlbRJPfl1ZZkEWC7hqJDh2bvR3yWdajgZ6vYRz4zjnk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cnrrG5uiCDlq3hW3tshS64RegqKZxbeI6+G+1grKitHRVMfBA/Ap6l9cQEWu8FyAmF+55JB+vILwpRskJYa589zFPxvWxDAfNYnQGHiCXZa5J4zqbp8uovF6qcVynlzRToPXoelqDIbLT5AS9yRnq9UnCEZtiSAs0a3QYu+59xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B2HmG0NU; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B2HmG0NU"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778523917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sJXtw30v4yT1aoXHrw8fkCEubjdJLYouJzBqKlxq+jQ=;
	b=B2HmG0NU0oMB4KuRavo42Tz0lgyuJSsUB7nvYoUS0cw/P4O/EtIMviO2A22ngKbjSCgaay
	pWuiq/QERPN/uUR/eAw+QD+e0yqZKPbuWfOaylSwkmoPbb5kAhJOpILnNpUmW+KuhSg+DI
	hnbpGoDg5EvfutcrWm10aPtv2GM2gxc=
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [RFC PATCH v2 01/10] rv/da: fix monitor start ordering and memory ordering for monitoring flag
Date: Tue, 12 May 2026 02:24:47 +0800
Message-Id: <8af5ba4bd93d2acb8a546e8e47ced974a87c1eb8.1778522945.git.wen.yang@linux.dev>
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

da_monitor_start() set monitoring=1 before calling da_monitor_init_hook(),
may racing with the sched_switch handler:

  da_monitor_start()               sched_switch handler
  -------------------------        ---------------------------------
  da_mon->monitoring = 1;
                                   if (da_monitoring(da_mon))  /* true  */
                                       ha_start_timer_ns(...);
                                       /* hrtimer->base == NULL, crash */
  da_monitor_init_hook(da_mon);
  /* hrtimer_setup() sets base */

Fix the ordering and pair with release/acquire semantics:

  da_monitor_init_hook(da_mon);
  smp_store_release(&da_mon->monitoring, 1);    /* da_monitor_start()  */
  return smp_load_acquire(&da_mon->monitoring); /* da_monitoring()     */

On ARM64 a plain STR + LDR does not form a release-acquire pair, so
the load can observe monitoring=1 while hrtimer->base is still NULL.
The plain accesses are also data races under KCSAN.

Use WRITE_ONCE for the monitoring=0 store in da_monitor_reset() to
cover the reset path.

Fixes: 792575348ff7 ("rv/include: Add deterministic automata monitor definition via C macros")
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 include/rv/da_monitor.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 39765ff6f098..00ded3d5ab3f 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -82,7 +82,7 @@ static void react(enum states curr_state, enum events event)
 static inline void da_monitor_reset(struct da_monitor *da_mon)
 {
 	da_monitor_reset_hook(da_mon);
-	da_mon->monitoring = 0;
+	WRITE_ONCE(da_mon->monitoring, 0);
 	da_mon->curr_state = model_get_initial_state();
 }
 
@@ -95,8 +95,9 @@ static inline void da_monitor_reset(struct da_monitor *da_mon)
 static inline void da_monitor_start(struct da_monitor *da_mon)
 {
 	da_mon->curr_state = model_get_initial_state();
-	da_mon->monitoring = 1;
 	da_monitor_init_hook(da_mon);
+	/* Pairs with smp_load_acquire in da_monitoring(). */
+	smp_store_release(&da_mon->monitoring, 1);
 }
 
 /*
@@ -104,7 +105,8 @@ static inline void da_monitor_start(struct da_monitor *da_mon)
  */
 static inline bool da_monitoring(struct da_monitor *da_mon)
 {
-	return da_mon->monitoring;
+	/* Pairs with smp_store_release in da_monitor_start(). */
+	return smp_load_acquire(&da_mon->monitoring);
 }
 
 /*
-- 
2.25.1

