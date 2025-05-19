Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A242586CA;
	Mon, 19 May 2025 10:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747650477; cv=none; b=gYRhrU9jkCKc0d4Jjc0tjd3QC8kckAuJmk2EkHVmEsOQ+tazJpRP/1Mev19PLj8pFP/gP8xiBpqO54GPRLNPku63DVvJWMxmFSXUIQcTV6pX/7Y+eLEQbgUzqzu71UE/rJVpehgL8Qh5FWEofzrjTqA6vby1MUVWHas/otMKM00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747650477; c=relaxed/simple;
	bh=9REGFnfyFOEyIjAE1cjJKsPFnrPKw4O7e9wg4waN3vU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b94lwX1xD5ajb1KV6UCH+r2+ZKmM81HygA45KcAS2m9qHRjQWr/tHizDY3s51hnr3CYi7gGjOaQUXxO3vfqKSbw8yKXtU/qJk/FAwKOT3N7roo6z1iSnBMWVvN65Z/E/XAr/2BN4IvcXo4Qx8zWbAvbZai+RStqx8N94Ye42ris=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Tl4EH44V; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IE/Faoxi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Tl4EH44V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IE/Faoxi"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747650474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9REGFnfyFOEyIjAE1cjJKsPFnrPKw4O7e9wg4waN3vU=;
	b=Tl4EH44V9T7kmy9zOi36/AO6mIDtgu6fNK+LsKUP6iYsVhT/dhYFmhWC6jGsmJ8ouBwJW6
	ZbYhn/HhBi2H1C1P1c5xDhtRNsqKHn5XMWU2zLbBOGGcwZS+2IW6xso+vrpZiA4ezBazXt
	sIPHiE95RJvK4SPSgLp03LsGo7tKsh0D2Ybr72FdffmrSRfLz8PgcocQ0YdglrqFBF4ftm
	LqK4h5dHQbXHWNlxcX2Sw3BmZK2lPwRuWaPybOXO5M9MXr2soZSL7qhe824axvHfdncbpq
	13IuD3zg13/0o2QaacVI91wnBL8OVPzd3HRM0Qc5+FLPg0RUay+AF7NRqxxZUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747650474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9REGFnfyFOEyIjAE1cjJKsPFnrPKw4O7e9wg4waN3vU=;
	b=IE/FaoxiySNCE51omaHaXxyfEOUGpY6NFLC9nfqePLKc5UtlFk/xkvyJ/icQuDB0zChVme
	D0fjpgssBpyEuCBg==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v9 01/22] rv: Add #undef TRACE_INCLUDE_FILE
Date: Mon, 19 May 2025 12:27:19 +0200
Message-Id: <964696573e1bc6aacd9b185f0fd819eada11d6e7.1747649899.git.namcao@linutronix.de>
In-Reply-To: <cover.1747649899.git.namcao@linutronix.de>
References: <cover.1747649899.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Without "#undef TRACE_INCLUDE_FILE", there could be a build error due to
TRACE_INCLUDE_FILE being redefined. Therefore add it.

Also fix a typo while at it.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 kernel/trace/rv/rv_trace.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
index 422b75f58891..99c3801616d4 100644
--- a/kernel/trace/rv/rv_trace.h
+++ b/kernel/trace/rv/rv_trace.h
@@ -129,8 +129,9 @@ DECLARE_EVENT_CLASS(error_da_monitor_id,
 #endif /* CONFIG_DA_MON_EVENTS_ID */
 #endif /* _TRACE_RV_H */
=20
-/* This part ust be outside protection */
+/* This part must be outside protection */
 #undef TRACE_INCLUDE_PATH
 #define TRACE_INCLUDE_PATH .
+#undef TRACE_INCLUDE_FILE
 #define TRACE_INCLUDE_FILE rv_trace
 #include <trace/define_trace.h>
--=20
2.39.5

