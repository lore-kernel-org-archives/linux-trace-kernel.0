Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4096933DEE9
	for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Apr 2026 05:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777527319; cv=none; b=euWQVqrVJEuQSnRdVaDYPmbJy+sau+cCzAVqvIwmrZui6dpM6L12w9OV6JuBp7xelM6Q2z2mlIulOra1JaoRrsNGVuwL9xTWHt6iMYsSRnmkFa0cd1HWgYckNHQ8y1ucLNzywmsHUCTcN5YQYGOsBLYqtggHqqfjIPyUkLlpApc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777527319; c=relaxed/simple;
	bh=eL76Q1sa3EHyipfbuet3sPexpAHfav/yaz3fmsAFPO4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UmfWYi44OpaXiTIVCvHOceGj1TmAmOlykKp5UZuIvbImUKYAPdJTTM++DEd2wQOzPZPIVm7LBLXxC3BSORdJUzYRA9IQ2hWO10A+bUWcwIrXJtu8MXF0NCmPCvTlg0B28GRb6AncicwHtHp3eg9+uexV4gm1rSjoEF4ML85ZnMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uc3h9NWW; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uc3h9NWW"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso3746955e9.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Apr 2026 22:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777527316; x=1778132116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8yQTJ0RBFyA28plH/8MX2fzpMDkq7MQmWjCFKhKVPCU=;
        b=Uc3h9NWWwLtsxcNngMpJyJRdPZTPWyfKm7qF4HmvUsxAA3r4QHnP4oiRXrKbHjMK7W
         JNdMLYIDxL3/fbIF3X/u9dtNgKRsau7hGd4t+xLss6vhF42OLGsKKyIaAr/PBYu3x4ku
         so/WyZR5pdZjTP34wOmfXtr7+ajrAb84/vME386kfjBqYdl0t1EQ0ThD9xlPOXRm5T2J
         fkU3OTATevqUSAlwC1+Fsl8jRxuusDsfFmCINgK7ghBTAYb7W2TcD6zTP6dzm2dQ4cBQ
         9FUjVo9ShUb7w4kd9XX//nnT8bvEpSfOJWG89uKvH9rNsERud4KPUnQTzT/T8gYctVi9
         B+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777527316; x=1778132116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yQTJ0RBFyA28plH/8MX2fzpMDkq7MQmWjCFKhKVPCU=;
        b=ipHjvvXSLiwsuPyA6uln3zcrCUGjNsf02ZcE4m3cK9j6lSnKteT4vqRI0ovbSMv7dw
         2Gy4xmrKe4+zj2iNcEL9alqvCIfujzHld210tBlPq3bKdF/BG5JcO6ltOx+sTfKQo+NH
         Id4QtRUcl+SQIDHBHCTWX5q9k871z1eUmkaxTsf0XDG6nfxO1sbZuwBeKaLi7M2PIceM
         vSmUr6pHg6Ij/kN6+qNeQU+CBSaTkBwNNCk3/CpugayJA9vijw8X4FLZIiR5cLd6OstQ
         hlNy/vrVqa+kdpBK8WFR/1Vet3cBe0qCzFYG6r9kJ7IJPWLC/74W0SFUH3S+Lj3xWaOj
         2vPw==
X-Gm-Message-State: AOJu0YwIqTIIvipJ+wr7leRzwu1cePquXMDwm3MB5TUWEEcmNb/LAa8x
	w1sSAzw7Nfbne2SF9o5lGf+Gar3qa3hjngGS9jSSiLZv4MfUheUHirFf7yv3Dkzx
X-Gm-Gg: AeBDietQqbBfOQEF4Xk5JmJyl3gOMVRBzxocDxyMtjDMKN4m9358Ita0cfGs5GH7J/g
	+wj9ZE4XkX+Nof+FiDCsNN6Sma1CfVum2ZEDhXKA1htJFHa69P4fJj8VklkPoLq3BgStiygR2WP
	63vr8rxE4OI2XXvFPIcqtWy20UCKhPdB3OWsCBR4hH9BYzx5ebhr/5PnIAoVQG64kpaWsC19OXw
	C+AAeY0NgUQiv0gpl7AddAAq0Ryao1AwtS0I9MX7hgUXR8ngm8FWn1cUv4LCON03WlgIh9Ys3ZE
	TpYViNZtcVVaQbIISrUOXaIImsqPiYtAbq6GuPeQIhYYc++OpyZfsNUQPbbO2nxa3jBrcclhV9P
	id4Fueju8+eeBrktso+ocn4hfepnzwJm+FB+LjUBNpBg0mrTs781YDwB9sr5ZrKKPNHpVme8jje
	kO9IoviRW5O+2q3z6RoZok44wk6Ovm9btZ0vMHh0gmyzWmOJvTi1MYeTBzOG3gBOHA1KP4g44zV
	GcJ4Nnda4ZAfs6HuVAGqA==
X-Received: by 2002:a05:600c:4ed0:b0:48a:54a6:b29f with SMTP id 5b1f17b1804b1-48a84451fc2mr22812805e9.17.1777527316147;
        Wed, 29 Apr 2026 22:35:16 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a822be9b4sm38410345e9.9.2026.04.29.22.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 22:35:15 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	"Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] tracepoint: add lockdep rcu_is_watching() check to trace_call__##name()
Date: Thu, 30 Apr 2026 06:35:10 +0100
Message-ID: <20260430053511.8767-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

trace_call__##name() was added by commit 677a3d82b640 ("tracepoint: Add
trace_call__##name() API") to let callers that already gate on
trace_##name##_enabled() skip the redundant static_branch_unlikely()
re-evaluation. The changelog states that the new helper retains the
LOCKDEP RCU-watching assertion carried by trace_##name(), but the
WARN_ONCE() was omitted from both definitions.

Without it, sites converted from trace_foo(args) to trace_call__foo(args)
lose the WARN_ONCE(!rcu_is_watching()) coverage under CONFIG_LOCKDEP when
the tracepoint is enabled - the case that commit c2679254b9c9 ("tracing:
Make tracepoint lockdep check actually test something") added the warning
for.

Mirror the same block in both trace_call__##name() bodies, gated by
(cond) in __DECLARE_TRACE to match its trace_##name() and ungated in
__DECLARE_TRACE_SYSCALL.

Fixes: 677a3d82b640 ("tracepoint: Add trace_call__##name() API")
Cc: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 include/linux/tracepoint.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 578e520b6ee6..048e0035d4fa 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -318,6 +318,10 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	static inline void trace_call__##name(proto)			\
 	{								\
 		__do_trace_##name(args);				\
+		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
+			WARN_ONCE(!rcu_is_watching(),			\
+				  "RCU not watching for tracepoint");	\
+		}							\
 	}
 
 #define __DECLARE_TRACE_SYSCALL(name, proto, args, data_proto)		\
@@ -342,6 +346,10 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	{								\
 		might_fault();						\
 		__do_trace_##name(args);				\
+		if (IS_ENABLED(CONFIG_LOCKDEP)) {			\
+			WARN_ONCE(!rcu_is_watching(),			\
+				  "RCU not watching for tracepoint");	\
+		}							\
 	}
 
 /*
-- 
2.53.0

