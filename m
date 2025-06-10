Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC79628A703;
	Tue, 10 Jun 2025 09:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749548643; cv=none; b=sAxBYNRmbjCCcbilG8LONWyviN9oF+SUvKko2fyGGiHLffCWvff3RecEzmqtGfaxH6PK0iiD2nbloYjLxxWArVrwDGw/NX6mBQ67pNspHWlnFD9u0hh3kXAQpzPsi6PuHPsHM6nrxJnNWLJcgMByfUVa7JOsLP+IHTs2qDBeeFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749548643; c=relaxed/simple;
	bh=E+QayCk+7TGNhlqlVJV5U1tQWwbLYd4XEKOSd37H82M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P9Qu0sMne6uOqxRq/a99L8vfFcIAeEsuJs67o6MQ+qYP5kFvEgzSXhYNvIaEaONVBBGmfW9GkN+q2wAbIalkvUAUSp/+bBHMR0ZARtegK+Ov3PRVfjqWEMIBLG2gvw3sz27lYSnWSj6YG6t+q5KvwcFyKKzOldU105b144WBMS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1K/lxvY7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IVcoRFkA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1K/lxvY7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IVcoRFkA"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749548640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E+QayCk+7TGNhlqlVJV5U1tQWwbLYd4XEKOSd37H82M=;
	b=1K/lxvY76kGJUIjfFMRNeM/Kw8X/dcJKsiayJo/TBr9VzJdPejByimqq5PWcNxlPCQiY24
	YdEEvt5xLO19GXwMuP4/7GR8ir3Fz1lXuqe/CsrErazmgClgI7/JFlVn0YriQiF6p/Gknu
	8/j4FZsj8kEeCk1NAwrwwIxyKu5nmhYmFoFPCaVBdIlgW6mQHK/GDWoC6ISO8uhWtq+kpr
	an1h/fPqmHxlxtSwJTgwML9rvAz4Ft220m46W5Wc0A2y+XcUCAD8Q5wes9otkLbyclI2uH
	w4UvJgenR4UT1X4CuIx3tqeNISRKo8IU+NQ99KE5HR/a5kU7vMpjaVYvRgIwXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749548640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E+QayCk+7TGNhlqlVJV5U1tQWwbLYd4XEKOSd37H82M=;
	b=IVcoRFkA59+bql8caG8Oxjjfyu/TDzfLow+CksrGJnkS/SN4G9FoleLsDtTtRNQpA4BKbp
	tV6bDvoFKUy0FzDQ==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v10 01/19] rv: Add #undef TRACE_INCLUDE_FILE
Date: Tue, 10 Jun 2025 11:43:26 +0200
Message-Id: <6801e07c98c28815501a1905300e11cbc28686ae.1749547399.git.namcao@linutronix.de>
In-Reply-To: <cover.1749547399.git.namcao@linutronix.de>
References: <cover.1749547399.git.namcao@linutronix.de>
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
index 422b75f58891e..99c3801616d40 100644
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

