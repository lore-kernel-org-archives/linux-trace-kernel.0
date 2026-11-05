Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.91
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901011;
	b=BGuDWNYr2JyjRO6S63aoCi4foAlAI45mj5n4qez/a6UC5nfywcuoYXDC+jdpJMP2Dbfz
	 +1uj1L1tgQeMjaDj1ixt9YC7c+HBNpQ1dbprgpvR1ZOdKLqUo1FBl9SV/8F3sRk6yBlce
	 WzD0U3fwb2JieI4l9/Lq1UYr6Yzlxwy7vnSLFw0eOIOkSnpXIXxLHCKSNeHpRQrPGWiBg
	 aReMA20YI/D9Uw271iVctGVSokjnUHsmOKVwWA5LNjUBxEgtjvSuI2LHh5kpB6heMzgW/
	 MgTkQFv3v9QwovDuFCfWiXRdECk1Fr46XMP/TN4rUfb5jb8Bg/sBKlGQwCfSBvSFhGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901011;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=igxEc+MTOqAdiXi1dSGRkv2g+PoAmFiYUjf2iRakRDY=;
	b=R+IfpXskz7PEuSfj8gUT0Js+FXmgQYo7CgJConmez1zX53L5GONeWNhRAL/c6+PgXmWB
	 uu1YkwocRiclcbyArRhX34Lwdu24ss/y6ONSV5WOLmNCHk5biP3Q0hz22tJB+pDBY7QNQ
	 0XvRgWIfnSZlc6xcV10llH6dFxzw0ZeaNbmANEKFvhu5YY5mCLj6rbYjLkRFk6Q2FUR+o
	 tbO5ZT0N8CP/LXlXyi6PwFxC73UM2bC9Hkzm9duHCXPh4+TqVLS25IAITUu1TalL2AYF4
	 uE02p+i5aej9uyGNjjrXDnGlF5KcJ3gC8jNSYb6zJT7U8OK3/n2Ni+myGX2M8pz7FIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nWDqzorf;
	arc=none smtp.remote-ip=91.218.175.91
Received: from mta0.migadu.com (out-91.mta0.migadu.com [91.218.175.91])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD21606A331
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Nov 2026 17:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BD21606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nWDqzorf
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=LLlgdevBBdJJUP3RYH6MF67ODYXlzihUz/N4bDB5bkw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793901008; v=1; x=1794505808;
 b=nWDqzorfA23n69Mz0dcjW1DMUFvfaTZAoNGWSzM5uXCFNWdAI2F3HSSKBWEBojXMYmDZJuN4
 MohRX0+Vb4CFEECfHjofTaUe2l7rGw6J8jeYR6djiYdSni8YnhG8LuyPXmM5QCdzTh4o6t/6s1X
 7MebSOsPWdYwuVmADlg0kMPc=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id c4bf3e9adab4dad2;
	Thu, 05 Nov 2026 17:50:08 +0000
X-Mizu-Trace-ID: c4bf3e9adab4dad2
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v8 06/14] rv: Make da_monitor_reset_hook, sync_hook and EVENT_NONE_LBL overridable
Date: Fri,  6 Nov 2026 01:49:06 +0800
Message-Id: <58752a7c181127dcd2db9c69359c6d96af75e1d6.1793900349.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1793900349.git.wen.yang@linux.dev>
References: <cover.1793900349.git.wen.yang@linux.dev>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wen.yang@linux.dev>

Wrap da_monitor_reset_hook, da_monitor_sync_hook, and EVENT_NONE_LBL with
ifndef guards so HA-based monitors can substitute their own implementations
before including this header.

Overrides of da_monitor_reset_hook must still call ha_monitor_reset_env()
or cancel outstanding timers to avoid timer UAF.

No behaviour change for monitors that do not override these macros.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 include/rv/ha_monitor.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
index 3bf1dd15544c..5372e5dfe3c5 100644
--- a/include/rv/ha_monitor.h
+++ b/include/rv/ha_monitor.h
@@ -37,8 +37,14 @@ static bool ha_monitor_handle_constraint(struct da_monitor *da_mon,
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
@@ -77,7 +83,9 @@ _Static_assert(offsetof(struct ha_monitor, da_mon) == 0,
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

