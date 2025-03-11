Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F8C26158F;
	Tue, 11 Mar 2025 17:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741712728; cv=none; b=Dfal7pU8CksBBiYibUUI88NmGFsCUXda82qO17P2YKgY4bZLufv6TV0EHT5EoqxWyZDisIk/nrV6fgkSMkznGEsAWX0mdpvxLPPpLezhHulZYRMbAd1GVR+TM0FDsa3lR42Lhsq9Yh3ab9+w1F1BRPfAZfP5y3FPxiNO+6OF2V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741712728; c=relaxed/simple;
	bh=AH6TuOSXUxic8C1QdyuBoZw4gtLjGNwyokNfKR8yfuo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LQiRYW5Q0AiytSDktERhBzahl09rxpFyz2aC8/ti2Vs3kKmMK+A7IguP50lHWaA4Tvwib3LiN0PAuzPY/MK6HO6yFre7w9z0OOeo2FGte4nxtMMjLoDcApQmc+3wj1Ndt78B3tAhSEk7DjiKT1Gq0hSQh1bZ0KoNMS+aG421UH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AyGbvowA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xtYFpXrr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AyGbvowA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xtYFpXrr"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741712725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AH6TuOSXUxic8C1QdyuBoZw4gtLjGNwyokNfKR8yfuo=;
	b=AyGbvowA6IiimQGFjthA6dAVGfjDYOaF+NanJkV0HfxoPt97n30fZESNdMnMqjteNWliAP
	R4VAhrnPvLZzZ9MJYx5dyk30pqlpl1pFU4z7Ea7HfFDUTXVvNryYKomdEL4CQEkFzkPHca
	pvVQlI5s0NAGfaHA7XoRYCYp0A5kYxuQgQKpsTg7r4hcNR079URbUqySp+iT2DHL52LjuL
	WTmF98fPCaUnt4NwQUqt8mC6is1RMAKcM33TjcBZFJFHjKD1DHq775reb0TftOPjfqipcn
	NGLDPPL4Jsunf5IPJr3dm1/Q6gNo+yzyy3ADBsq7SN30DCWYc51MAtuHE6zTtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741712725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AH6TuOSXUxic8C1QdyuBoZw4gtLjGNwyokNfKR8yfuo=;
	b=xtYFpXrruX0HFp6DpS1DkHLeKBZw6Bp4rwKx+BzsJMhrc/Z0qKcNEOgw4bjDE74D4VD5j2
	suwIyYlMbSwL5RBg==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	john.ogness@linutronix.de,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 01/10] rv: Add #undef TRACE_INCLUDE_FILE
Date: Tue, 11 Mar 2025 18:05:02 +0100
Message-Id: <1da218736158f3b648133e31b048a2c89abc50bb.1741708239.git.namcao@linutronix.de>
In-Reply-To: <cover.1741708239.git.namcao@linutronix.de>
References: <cover.1741708239.git.namcao@linutronix.de>
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

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 kernel/trace/rv/rv_trace.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
index 5e65097423ba..96264233cac5 100644
--- a/kernel/trace/rv/rv_trace.h
+++ b/kernel/trace/rv/rv_trace.h
@@ -123,8 +123,9 @@ DECLARE_EVENT_CLASS(error_da_monitor_id,
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

