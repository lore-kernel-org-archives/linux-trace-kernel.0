Received: from mta1.migadu.com (out-24.mta1.migadu.com [95.215.58.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C826E47D94D
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Aug 2026 16:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787244366; cv=none; b=CUaS+dcf6Qyl4YteAb3y7mRcC7KQ/U3uTWQSVo+cp8M5MwmAu61ofjiOkhjhOI4xz6kjnFvK5gX8suZz2EYvPCrrxt1zlLeb6eR1YZ0yMZ/pwLJkdjAiX2lKFpBLvXQZI2a/LKXklcbRE/caK9K/DSSGTLcoV9v77ZexpLRTVfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787244366; c=relaxed/simple;
	bh=5l7zNU8xFDd3uROoIZ45HJYblWzWPFr5g3AcZj9zDaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oJKS8fjTiDWR3xxqB933Y31qf3IZ3jYpURDbRFuEp/tU4NmhDMp71ys6+BrNYp3hpreIfon6rVbv/ZNKfSxnL7L1gViShx+mmnAcihg9yi8ivSJSVL4M3g4x9EzjKAdIXSLGbtjSwgNWMIZBOvKasS0iw+Oq9p052Q1HvvM7jaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xHjESEh2; arc=none smtp.client-ip=95.215.58.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xHjESEh2"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=5l7zNU8xFDd3uROoIZ45HJYblWzWPFr5g3AcZj9zDaA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787244362; v=1; x=1787849162;
 b=xHjESEh2YeDT0p6tPfK2ErHrB/AUJdUhFGMnP6yq10SFbzkR8EuTOFTlxT2dMjcPSAk2R4yY
 chBaYCwsM5xeuKOJLJBfkQOSQPifClQOnNYB7tmY+cSgvbaqR1eiVUvnh4YF9v3UCUaNDma5Xny
 rDsRJYRlnSVp6Q2hVECgAM6o=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: from localhost.localdomain (218.1.210.138)
	by mta11.migadu.com with ESMTPS id aea1a9faf2914596;
	Thu, 20 Aug 2026 16:46:02 +0000
X-Mizu-Trace-ID: aea1a9faf2914596
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v6 5/9] rv: Make da_monitor_reset_hook and EVENT_NONE_LBL overridable
Date: Fri, 21 Aug 2026 00:45:14 +0800
Message-Id: <1e8c3b3b8bb6bc3243eb6e4f2bfd3a61dd41cc35.1787243842.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1787243842.git.wen.yang@linux.dev>
References: <cover.1787243842.git.wen.yang@linux.dev>
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

