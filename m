Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F7621D3E8;
	Wed,  9 Jul 2025 17:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752083799; cv=none; b=do+YDgU/szH5oToeCVaXids5TQEm8LtGBRybjiXEHjGxHsnVPzMv9IBMybsngNr0aY8sjpf9UXtVezzALapFiTpcYalmYy4YEEGR2ymgwn+a4GQx82mXPK+Id0JN25uKWShqIKlVOI4zlN2BKShdKhQ2rsEEP6eo58R25goGkfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752083799; c=relaxed/simple;
	bh=9REGFnfyFOEyIjAE1cjJKsPFnrPKw4O7e9wg4waN3vU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G/vedTZlkEp0KtDyxxHahSTgIiRmpJqF2t3ihfhjOqh1YNffUTD7ASk2F1R2aNg5KchVFSgh0bM/kkoif7M5JmsP+EZbkFemtrbjkNmPSVL05PbfCa+KFkR43YySGhTPtsXjoiAdsUXtZGtBXxLNbWL2RrcHuFkCWZ5I1sWpJFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nc8CIx4U; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CBmoGzWn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nc8CIx4U";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CBmoGzWn"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752083796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9REGFnfyFOEyIjAE1cjJKsPFnrPKw4O7e9wg4waN3vU=;
	b=nc8CIx4UGHqh8H/ff5xg9waA7+tzAvfBvj3LoLlH+GNNc8b48FNxZUEzkh+P38MSCcvCEW
	BAY3kXHbrWL7lK+ohIZktv8mjg5h0LldgvKM8TnLhOK9vxXsBo5P8yLno0TNcHwApe8L0/
	WsK1FM/mdLqs9tkKWjAjRVwLFS/ea8dxR/d3eK+afA5BqHC/Q0CboW2cF4aBpWmH8X2oT6
	NnGjxoOpYRL9EaE6Rw/pEr9yMhHkyHiHjtZMB/aQNBYG8cFjHQ3cTZE9iatSeMXeLV0USb
	tZ2xf6Uijnh73RkJbiWINtjbFOa4HD26KBuFll/psEkTo3L07/NYjSAxe9YMcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752083796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9REGFnfyFOEyIjAE1cjJKsPFnrPKw4O7e9wg4waN3vU=;
	b=CBmoGzWnk9C7RqhHSidJRfFU5khhMPS0nC8qDy85hWEJmvqyiNqAhRuAqgyIeic1Mt/FQI
	xzciCGtYb6HZqWBw==
To: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v12 01/12] rv: Add #undef TRACE_INCLUDE_FILE
Date: Wed,  9 Jul 2025 19:56:18 +0200
Message-Id: <f805e074581e927bb176c742c981fa7675b6ebe5.1752082806.git.namcao@linutronix.de>
In-Reply-To: <cover.1752082806.git.namcao@linutronix.de>
References: <cover.1752082806.git.namcao@linutronix.de>
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

