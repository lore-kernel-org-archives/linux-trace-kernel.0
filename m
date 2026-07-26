Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F61B3ACEE9
	for <linux-trace-kernel@vger.kernel.org>; Sun, 26 Jul 2026 12:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785068885; cv=none; b=aM/PoxW0RtOkeKD7uXBYywvE1pEJG3GOYAWoD5o7U4y4WL6snjqoiNgPsQOXHLspyxlOYcRhLu89rjjUP9vX5sKx2RqfJhcjO0f56Jzu4wFwTWWMzzr5YSqs78YHmbtWeczc0F/5xjuErW7ixbPz/rdWFHrvoOLcV153MTfeo+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785068885; c=relaxed/simple;
	bh=ccoLxXcVCAekN8O5gMgLDn7JdMt0YqOZNIb3h7ismYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hggVjnzfqO5kFa87U8GgGBk4aXpTSBiTTytdhP/tWnF+ZNVemg/Ly0t7LPI08+gBJSLbvcR9jt6Ey0s2v/T6mL1kSwHvippo7DXbw/usg7bBS/aCy7/t06BVrls0wtkFN8cG5a1Ndvo9O2+z61g0iCfeWNNomXZ69JqfXZye0ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tg7jnPX6; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tg7jnPX6"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6ab0223a3d3so400558eaf.3
        for <linux-trace-kernel@vger.kernel.org>; Sun, 26 Jul 2026 05:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785068880; x=1785673680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0oVEf5/gSaD+al9Pequ5m2rnhtlrO+HvKfH1QE9WEkQ=;
        b=Tg7jnPX6RNUuQtCqe7gQKvbuo6uI020ByxoFuHeWAOAbYS2hErTrgS+Y5/0dCezjUm
         4ZjOowfwrAVKNIPjgVoA9ToN3jH3hEoJ5tkfiJO4E9CSdo6KqN+sYAG/ebAw/JxgELUK
         kd1eS6MMcRyadlidxsg3eNfvNojzxbvxtwfu5VC3Pyz3wXwkD1lJ3CkFN5d0u4NPaFaT
         Lw8qlYf1ui294361LVlQsrRUI4N+aa9McMklfjIXCHvVCRzDoaw/nM00TSHC4FU4WDNH
         NtyA/7aBT0XWbAm5mWaJLEhe9Y5d+E934uLS3TLjBz6lzTUNgSkGFwX8D7Y3NSHxM4Ed
         tzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785068880; x=1785673680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0oVEf5/gSaD+al9Pequ5m2rnhtlrO+HvKfH1QE9WEkQ=;
        b=opaywWvjG5mRP+cejPHnoDI4wRGIHjrjsMW6qt9pZmCtNaf07AH2Q3mgvKLdga3xOb
         HiGTPAI1+qUsvPq9Nr+F5LLg4Gv84fhxjXz7wTDaHSoE32iccXWx7P0MWXeaKArI4IBp
         XPQX4k0bxZJ8deulGYyJO7SchVYXAIhuXI1yge1O/lysPwQfx+i1r9AgOc0TAHreRVj8
         aqWtnbSQ9Ry214J99aop7JkFjCYJua02C2EQ+h8rhXSdodmAZEZM8RYupJ/Gbbshs9XA
         gdManj/5dohmrv1HDBdNBQlDhSk41ypyEu1s2WmmNulim5S+5fEyN31+nx+j7IqMq3bM
         EyQA==
X-Forwarded-Encrypted: i=1; AHgh+RojseUAt3fB6aN5u6GBubujLxF/3KU+GU+o52kWzQ9iubvpyw8nZev+1ci2WSC4CDw+EnXTBpyILBKyhNHhxpbj1lE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw31miIhwtbYoC9cTPT5ZBZikUSNc68CVVNl9TgQZLf9hLrqBaw
	BDc+QHwKEM1ccl8T79FLdXdg3tk8PD9RNqcSp+jq5UtL4OQrNk8Fe4ZA
X-Gm-Gg: AR+sD119J7QDtmMKorEztLbo4hrE+DkbTdDq7sZA0WJlnbMnwR6gieE+mzbNysXpMpY
	S0BZwTRhhoHar20QIEYJAZQ0j1XYKs96eEr9anFd6mnFJfcyKJqjueHyBkrXkwRRYz0GS+CORy3
	bNk4bxQMGBp45ZQgLOFw8c2HVJ9KFxA0LG+fei5zsQ4wUuEllQi5auOYZORWWlvs2MZZVwUwNuk
	xOrwKmQZ4YxmqygJnMIdWJw/r4X1LRerrptz0sQl/uvl1eJk7acM8ZBZuT7b/EZZhrL/4Hv5yZ8
	4Qc3qJ6qvSWWe6V33qmS3aXr4mtJbQu5qNxRYIHgju6OZdqILde/VKOkJl4KJeSGcVp0xiBgMxP
	b0xbHLqsKKGeDu5bRd+549rX29yIGfAlDN3cp6LOiK7Z23zGkfJmWeMiq4E+shMD5tM2nZzTAvQ
	An6bM1UUBoGmUy
X-Received: by 2002:a05:6820:1caa:b0:6aa:df4e:e373 with SMTP id 006d021491bc7-6aaffadde25mr3034725eaf.62.1785068880306;
        Sun, 26 Jul 2026 05:28:00 -0700 (PDT)
Received: from localhost ([144.24.58.22])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6aaf973036dsm3324321eaf.14.2026.07.26.05.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 05:27:59 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	x86@kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tony Luck <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-edac@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH 3/3] HWBP: Add modify_local_hw_breakpoint_addr() API
Date: Sun, 26 Jul 2026 20:27:45 +0800
Message-ID: <f9c49dfa49bdc57ba8c0574bc9981c1e581acf92.1785067572.git.wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1785067572.git.wangjinchao600@gmail.com>
References: <178476143000.26117.9810509272687580410.stgit@devnote2> <cover.1785067572.git.wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20260726122745.qKxnEKeljpLRpZ5k5lKVc3QvTZMRZSvaw3dLH7URIgg@z>

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

Add modify_local_hw_breakpoint_addr() to update only the watched
address of an installed hardware breakpoint on the local CPU without
releasing and reserving its hardware slot. This is available when the
architecture selects CONFIG_HAVE_MODIFY_LOCAL_HW_BREAKPOINT_ADDR.

The caller must provide an installed local event and a valid address,
and update other CPUs separately.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 arch/Kconfig                  |  8 ++++++++
 arch/x86/Kconfig              |  1 +
 include/linux/hw_breakpoint.h |  6 ++++++
 kernel/events/hw_breakpoint.c | 30 ++++++++++++++++++++++++++++++
 4 files changed, 45 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index fa7507ac8e13..bea383408e32 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -457,6 +457,14 @@ config HAVE_MIXED_BREAKPOINTS_REGS
 	  Select this option if your arch implements breakpoints under the
 	  latter fashion.
 
+config HAVE_MODIFY_LOCAL_HW_BREAKPOINT_ADDR
+	bool
+	depends on HAVE_HW_BREAKPOINT
+	help
+	  Select this if the architecture can modify the address of an
+	  installed hardware breakpoint on the local CPU without releasing
+	  and reserving its hardware slot.
+
 config HAVE_USER_RETURN_NOTIFIER
 	bool
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index bdad90f210e4..09e599f2d0dd 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -246,6 +246,7 @@ config X86
 	select HAVE_FUNCTION_TRACER
 	select HAVE_GCC_PLUGINS
 	select HAVE_HW_BREAKPOINT
+	select HAVE_MODIFY_LOCAL_HW_BREAKPOINT_ADDR
 	select HAVE_IOREMAP_PROT
 	select HAVE_IRQ_EXIT_ON_IRQ_STACK	if X86_64
 	select HAVE_IRQ_TIME_ACCOUNTING
diff --git a/include/linux/hw_breakpoint.h b/include/linux/hw_breakpoint.h
index db199d653dd1..bf65c7fffd99 100644
--- a/include/linux/hw_breakpoint.h
+++ b/include/linux/hw_breakpoint.h
@@ -81,6 +81,9 @@ register_wide_hw_breakpoint(struct perf_event_attr *attr,
 			    perf_overflow_handler_t triggered,
 			    void *context);
 
+int modify_local_hw_breakpoint_addr(struct perf_event *bp,
+				    unsigned long addr);
+
 extern int register_perf_hw_breakpoint(struct perf_event *bp);
 extern void unregister_hw_breakpoint(struct perf_event *bp);
 extern void unregister_wide_hw_breakpoint(struct perf_event * __percpu *cpu_events);
@@ -124,6 +127,9 @@ register_wide_hw_breakpoint(struct perf_event_attr *attr,
 			    perf_overflow_handler_t triggered,
 			    void *context)		{ return NULL; }
 static inline int
+modify_local_hw_breakpoint_addr(struct perf_event *bp,
+				unsigned long addr) { return -EOPNOTSUPP; }
+static inline int
 register_perf_hw_breakpoint(struct perf_event *bp)	{ return -ENOSYS; }
 static inline void unregister_hw_breakpoint(struct perf_event *bp)	{ }
 static inline void
diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 789add0c185a..0b1fc01f1934 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -888,6 +888,36 @@ void unregister_wide_hw_breakpoint(struct perf_event * __percpu *cpu_events)
 }
 EXPORT_SYMBOL_GPL(unregister_wide_hw_breakpoint);
 
+/**
+ * modify_local_hw_breakpoint_addr - update a local breakpoint address
+ * @bp: the hwbp perf event for this CPU
+ * @addr: the new address for @bp
+ *
+ * Update only the address of an installed breakpoint on the local CPU without
+ * releasing and reserving its hardware slot. The caller must update other CPUs.
+ * Return 0, or -EOPNOTSUPP if the architecture does not support this operation.
+ */
+#ifdef CONFIG_HAVE_MODIFY_LOCAL_HW_BREAKPOINT_ADDR
+int modify_local_hw_breakpoint_addr(struct perf_event *bp,
+				    unsigned long addr)
+{
+	lockdep_assert_irqs_disabled();
+
+	counter_arch_bp(bp)->address = addr;
+	bp->attr.bp_addr = addr;
+	arch_modify_local_hw_breakpoint_addr(bp, addr);
+
+	return 0;
+}
+#else
+int modify_local_hw_breakpoint_addr(struct perf_event *bp,
+				    unsigned long addr)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+EXPORT_SYMBOL_GPL(modify_local_hw_breakpoint_addr);
+
 /**
  * hw_breakpoint_is_used - check if breakpoints are currently used
  *
-- 
2.53.0

