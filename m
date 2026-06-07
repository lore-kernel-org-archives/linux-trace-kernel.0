Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C862641EE
	for <linux-trace-kernel@vger.kernel.org>; Sun,  7 Jun 2026 16:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780848885; cv=none; b=pXt+FVhH5W2ooQECA8b5klxMrLiJSvLpSE84OtlVzsGjp9zRYz3R5K7BUiePH+f/rOsCYoFuXcPyDxgGeq/zVaj3DadWnv/GcYxbLj5TyHmHdK1JGgijZf9mjRT5sfxKRvSiOFm/DNfKoFUdK9aiggCpml/izCZc1R4eU3ifqRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780848885; c=relaxed/simple;
	bh=5NY6qf25xfqjmdv8SVYDhiiRSenNffOztDUeHWSPO3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hou+lcMPkY0hr2a2s9MioOeNA82BYhPr72mjKk2wXU4A3SBIKlN+fJKntiOJ9//1G6A6FpMf28uUBywov1yZWsRGKA17PLsJP4SBDnDNJ/QaZOIZSePADOdJR8sWGYXKs+lH3Q/EfambvDso+4RVktXcjidGEsvcfuTgyvhvbdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cP7uNyNn; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cP7uNyNn"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780848882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pUuc9LMLV82kS1hIqawnrvsy7+YnU983kgF+bNVu2Nw=;
	b=cP7uNyNnNcAEZaKfh1iMtDS7ly8lx6GMOxhsujXPAQHhncSbGq4GXXc5X6IIEtxzdV25Oa
	C/9xl/lL1DjGZhqgEyryBGZaSiySQtBGf+/4x+cwf+DNW8rdvf6cKXJ5RpDEgMTpx06+yn
	GtxNKySFMHQrkGv/FAyUmKL3i3ecsMk=
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v3 5/9] rv/ha: make da_monitor_reset_hook and EVENT_NONE_LBL overridable
Date: Mon,  8 Jun 2026 00:13:53 +0800
Message-Id: <13a25b73c9fdebd26c2d4f922a83408dbcfc214d.1780847473.git.wen.yang@linux.dev>
In-Reply-To: <cover.1780847473.git.wen.yang@linux.dev>
References: <cover.1780847473.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Wen Yang <wen.yang@linux.dev>

Wrap the two definitions with #ifndef guards so that HA-based monitors
can substitute their own implementations before including this header:

  /* in monitor.c, before #include <rv/ha_monitor.h> */
  #define da_monitor_reset_hook  my_monitor_reset_env
  #define EVENT_NONE_LBL         "idle"

No behaviour change for monitors that do not override either macro.

Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 include/rv/ha_monitor.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
index e5860900a337..610da54c111f 100644
--- a/include/rv/ha_monitor.h
+++ b/include/rv/ha_monitor.h
@@ -36,7 +36,10 @@ static bool ha_monitor_handle_constraint(struct da_monitor *da_mon,
 					 da_id_type id);
 #define da_monitor_event_hook ha_monitor_handle_constraint
 #define da_monitor_init_hook ha_monitor_init_env
+/* Allow monitors to override da_monitor_reset_hook before including this header. */
+#ifndef da_monitor_reset_hook
 #define da_monitor_reset_hook ha_monitor_reset_env
+#endif
 #define da_monitor_sync_hook() synchronize_rcu()
 
 #if !defined(HA_SKIP_AUTO_CLEANUP) && RV_MON_TYPE == RV_MON_PER_TASK
@@ -75,7 +78,9 @@ _Static_assert(offsetof(struct ha_monitor, da_mon) == 0,
 #define ENV_INVALID_VALUE U64_MAX
 /* Error with no event occurs only on timeouts */
 #define EVENT_NONE EVENT_MAX
+#ifndef EVENT_NONE_LBL
 #define EVENT_NONE_LBL "none"
+#endif
 #define ENV_BUFFER_SIZE 64
 
 #ifdef CONFIG_RV_REACTORS
-- 
2.43.0

