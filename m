Received: from mta1.migadu.com (out-51.mta1.migadu.com [95.215.58.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038A34C0402
	for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Aug 2026 18:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787163375; cv=none; b=FM0Vcc1NME9PyiFkwohRyK3/PJtpUD8VbnnOS0aP/gDayjiJ6JqNrCmTcLPA9nlTAn5Y1kvONN7GGQlRLmsQJOBL1YnE3d2nhrGu8ymBjpvqd9kw94hkRaces1d2m8MIjgYVNMPeyNLYD57qUqIv2Kfoz5fqVSpkVGf2BYLEGds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787163375; c=relaxed/simple;
	bh=5l7zNU8xFDd3uROoIZ45HJYblWzWPFr5g3AcZj9zDaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=amS2ICJ16CLHyRjZzpDkuBfWcc0owTwvjaXYV5rICeuU4aPjgBILz6lod8sY+0VV1Gv//p+pzNx4YhyDY6e0hFUctSVQM488Eh5rq0s4xOs6QwsjlighMBcB0htMhz8j+JmWb/cr1PIcjUV0sUIorD044vC4Mo7OdEvkzxlOlbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ImReXGib; arc=none smtp.client-ip=95.215.58.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ImReXGib"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=5l7zNU8xFDd3uROoIZ45HJYblWzWPFr5g3AcZj9zDaA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787163365; v=1; x=1787768165;
 b=ImReXGibhKiky5TbLXLA1/r82tIBFtdGjaLm5ZVgkPPFvAvWi28Vb4IL8OOEv/EaAt8oOGDY
 hK+7CHrj5CC0XEjXhfLzo0oVwY/44xCYzWUXAwJ/erWtJVwo7Erb1Bz3beqf7hG5m17u2738zSo
 wWrsD6FUBj6kLxyITiydIhL0=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: from localhost.localdomain (180.165.15.98)
	by mta12.migadu.com with ESMTPS id 3378b5cc75fab53a;
	Wed, 19 Aug 2026 18:16:05 +0000
X-Mizu-Trace-ID: 3378b5cc75fab53a
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v5 5/9] rv: Make da_monitor_reset_hook and EVENT_NONE_LBL overridable
Date: Thu, 20 Aug 2026 02:15:22 +0800
Message-Id: <93c62b568c392352cb0a507c85f49c46cd49fbe0.1787161646.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1787161646.git.wen.yang@linux.dev>
References: <cover.1787161646.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 include/rv/ha_monitor.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
index e1738d199b28..807b981eb548 100644
--- a/include/rv/ha_monitor.h
+++ b/include/rv/ha_monitor.h
@@ -36,8 +36,14 @@ static bool ha_monitor_handle_constraint(struct da_monitor *da_mon,
 					 da_id_type id);
 #define da_monitor_event_hook ha_monitor_handle_constraint
 #define da_monitor_init_hook ha_monitor_init_env
+
+/* Overrides must still call ha_monitor_reset_env() or cancel the timer. */
+#ifndef da_monitor_reset_hook
 #define da_monitor_reset_hook ha_monitor_reset_env
+#endif
+#ifndef da_monitor_sync_hook
 #define da_monitor_sync_hook() synchronize_rcu()
+#endif
 
 #if !defined(HA_SKIP_AUTO_CLEANUP) && RV_MON_TYPE == RV_MON_PER_TASK
 /*
@@ -75,7 +81,9 @@ _Static_assert(offsetof(struct ha_monitor, da_mon) == 0,
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

