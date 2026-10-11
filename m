Received: from mta1.migadu.com (out-92.mta1.migadu.com [95.215.58.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A55D455621
	for <linux-trace-kernel@vger.kernel.org>; Sun, 11 Oct 2026 19:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791747614; cv=none; b=pAdIlPDCSHQDsKxroj6knAgfeWRTqbnlH4/xudwwmpSP6w3/F2l+8PaEfwDuZH6230uw1empMoJC5oxJvcnlhtLMJaBIaJgqQveGUtOdKtk/fkNIayusjVdN0N2BknAzlkV/xhx72MwR8I+JdQuqkuoCQbTo6AyJ2u5KEJj93PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791747614; c=relaxed/simple;
	bh=3zupAJTu8BltPTT0ExVf/8n9KO6elCrt0DszHRWjuwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rcIf2/kQQKYbbOUlA5RAvcujk9EW21CCh3ff0LttVZRn/aI9t7jGGww6H8ymR0KB+xtDu/+QbzB62adMZTUGzjq1qK82zDRdPZ61UKK4f8wZ5AYrmmKCtxX8XRwdWo0cocFm0eaLIMky9Iyaiusk0mZEgdjQC3m2b92ierZwO+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y5UMw1g+; arc=none smtp.client-ip=95.215.58.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y5UMw1g+"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=3zupAJTu8BltPTT0ExVf/8n9KO6elCrt0DszHRWjuwE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791747608; v=1; x=1792352408;
 b=Y5UMw1g+9KviwyPBDVXjm7ZTb6XP73mayBT0Xeq8Skasrb0vSLFxQoRVEsKYq256I1T7ViwD
 MEXSaDLkWKhSAARZm0BSBguP18V3oeu50owORgTZUMa8zBrOm4b4KhaziJC1Vfj8XXKq4iosddQ
 8XdGj1kPUJa2+QnuZkYRSnh4=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id b09c6ce92b56c0b4;
	Sun, 11 Oct 2026 19:40:07 +0000
X-Mizu-Trace-ID: b09c6ce92b56c0b4
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v7 06/14] rv: Make da_monitor_reset_hook and EVENT_NONE_LBL overridable
Date: Mon, 12 Oct 2026 03:39:12 +0800
Message-Id: <d8990a03af61a6989b9db1150b1205873b83a5c7.1791745088.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1791745088.git.wen.yang@linux.dev>
References: <cover.1791745088.git.wen.yang@linux.dev>
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
index 99b60d0d26b6..b8c74d4d4064 100644
--- a/include/rv/ha_monitor.h
+++ b/include/rv/ha_monitor.h
@@ -38,8 +38,14 @@ static bool ha_monitor_handle_constraint(struct da_monitor *da_mon,
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
 #define da_monitor_free_hook ha_monitor_free_env
 
 #if !defined(HA_SKIP_AUTO_CLEANUP) && RV_MON_TYPE == RV_MON_PER_TASK
@@ -78,7 +84,9 @@ _Static_assert(offsetof(struct ha_monitor, da_mon) == 0,
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

