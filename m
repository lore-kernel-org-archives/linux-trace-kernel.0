Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B945A2E6126
	for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757671937; cv=none; b=XTcwzvFW1lH/yDKVlLL/GSILoBSTeBkVorcB78Wvf9GTv3CsJMdmc07PWfFYephSMGnqRUgFSbiOvBsZyfeMOHPOUi1wwCabgTOTBG6KivZLDPKOJFJwUN3OnFxIlxa0SQlpbtuP2A72dDsI5lXDqlGSmyxfidN70dk0uVO3WS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757671937; c=relaxed/simple;
	bh=sULEjvL2pp1aXQje+Pg+BRBhTFd7HU/YOc2Kd4lZUiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DmaDvj/vHY35AmRukNhEwZe0iiL5i3povnuA0BClyMZyN4KHTcg5e1yAgtByhvpY1WZWcfRYQEUR/ioM3eaDR6dT1E6Oxxu2DPAVxVOIoOBTSARCfQGBM6CqAb3OKwWv23rmgxfBz5SVefIVPlb4h5NTjGMjwQJpNwAxeRSZVSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k5bMFO1G; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5bMFO1G"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-25c5e597cfcso16116865ad.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757671933; x=1758276733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAwazreHf5k9GgDRW54pld4eDw+UAZx9M09yt/sAPVs=;
        b=k5bMFO1GSjf5QIxD8S2eqMkg0oRrt5mdIvTtrORTBbOgtyc26KVNR0RErjozCFfg+I
         PMdvXJVFQ29Qcfu+FDe5NI/k7ExnsudLXrO0AvVbTgoehCOwykQO6NngM03TsmiT6/a2
         9gnFk2ENKSOk3BMsGQdmwqpdrKA2V/3V4VeQmPSjMp/DQVL/tRiV94waFEK9Akes/K3p
         Ta5Z30RNPL6z4xmQvEoLf+5nxJJRV6N4jV9u/NPDTu4Q5LWp92sYnC048UIRJAQg0mQI
         mPlFA8I7qtIEczixafmo/NZCaWMtBstWl1jLmaGJZBl/8DzwvpCmqjZSnski48K25Veq
         PuuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757671933; x=1758276733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MAwazreHf5k9GgDRW54pld4eDw+UAZx9M09yt/sAPVs=;
        b=qYovrgpOJtxd/LqGl/x+KW+c6tm68OmcCMOkZ7s6vNDfliqKCE1Djz/7Jgx1kOLpfV
         bd7QCvRUmx29M1z4XbQbb4yvvQnl7tRONVQxOYIyGL2AEQqx1KmueJmiT2JCEHyp5MYS
         3E6Pkw1KV+QOpMMCeKyZ4TWgXHs0MdzvEeajQzJGfHX2Lm8o2kmDeokrUmUJPwW4c570
         sZoCqoUZLqJyyxtBdTs6vPHdI+Q8bwMPBjvAIhirXEkk3aRVR+NvBYxMzS3VXjLqDq54
         AkF997py+w/v/uHvEsKgSqu758lKy8uWgjVJ5VwflchOPFU69ddQNYVxoEiAf2Ynkaob
         RgWg==
X-Forwarded-Encrypted: i=1; AJvYcCVBwieHxTV4ii1J2M7ry94pKV1Xc7fsJ6aN9tcfveQuAdacN0YqIH31qeH4n9lqSAuo9ZJVRDshY3VHly6lN7RMdRc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb7mHpd/3VMemetdN2HxildB4LzHZsxBYXULJPcpehOka4yJuO
	5o7+YEPfFah7BATwUcAh3zz0/VvYvMlgK+zU1s9QPN13w9Nec4cMzplI
X-Gm-Gg: ASbGncvUeHEZnWF0+AAhD1qJ9Sp9ZjcaIFLUfj+0sX115eCpu7V6Ho0b8yznWUWIf7G
	hjVSAlAtZXI2pO9l+DkItEj/wVP+x+W4KtEyJY8Q1PcRVL8F9Ul9ntnIYccUbf2qO/3HOUraaeV
	eZL1EfgJwM9BvLpaOQy1028FoStkwKuBoNlT7tEWh8Q9bxAmktjVlSeEmBAqvQepIJeN0U3FAtp
	Ooez7hQkI/dS6gC15jH8g98XbggxkiVMSM83DaJqI4NCnX/JUi9xvFT4cWhJ7IXJaOPvxgDjSba
	iXYo4t7hzsuLx8iK4JpLXF9j9iajxvJ4LODlx/ZI3sGQ6A2xLANpsajlQ6z1j8BgeHXhUh1Iabu
	/e30S4PkZlCPiAKPc81eEeIdHj6LsVOXS/Av/fPqzuk+Auk3Dng==
X-Google-Smtp-Source: AGHT+IE3riCCDjjOveSMsaG7I15WY9EHwk+eFKMgkgFo5ZyPShTClEykZoqvnQPNL3j1pPP9iEE3Tw==
X-Received: by 2002:a17:903:41ca:b0:24c:e6a6:9e59 with SMTP id d9443c01a7336-25d245dd6f8mr31272915ad.6.1757671932903;
        Fri, 12 Sep 2025 03:12:12 -0700 (PDT)
Received: from localhost ([185.49.34.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25e8ed36759sm6102435ad.142.2025.09.12.03.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:12:12 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <kees@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Rong Xu <xur@google.com>,
	Naveen N Rao <naveen@kernel.org>,
	David Kaplan <david.kaplan@amd.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Nam Cao <namcao@linutronix.de>,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-mm@kvack.org,
	llvm@lists.linux.dev,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	kasan-dev@googlegroups.com,
	"David S. Miller" <davem@davemloft.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org
Cc: Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH v4 03/21] HWBP: Add modify_wide_hw_breakpoint_local() API
Date: Fri, 12 Sep 2025 18:11:13 +0800
Message-ID: <20250912101145.465708-4-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912101145.465708-1-wangjinchao600@gmail.com>
References: <20250912101145.465708-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

Add modify_wide_hw_breakpoint_local() arch-wide interface which allows
hwbp users to update watch address on-line. This is available if the
arch supports CONFIG_HAVE_REINSTALL_HW_BREAKPOINT.
Note that this allows to change the type only for compatible types,
because it does not release and reserve the hwbp slot based on type.
For instance, you can not change HW_BREAKPOINT_W to HW_BREAKPOINT_X.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 arch/Kconfig                  | 10 ++++++++++
 arch/x86/Kconfig              |  1 +
 include/linux/hw_breakpoint.h |  6 ++++++
 kernel/events/hw_breakpoint.c | 36 +++++++++++++++++++++++++++++++++++
 4 files changed, 53 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index d1b4ffd6e085..e4787fc814df 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -418,6 +418,16 @@ config HAVE_MIXED_BREAKPOINTS_REGS
 	  Select this option if your arch implements breakpoints under the
 	  latter fashion.
 
+config HAVE_REINSTALL_HW_BREAKPOINT
+	bool
+	depends on HAVE_HW_BREAKPOINT
+	help
+	  Depending on the arch implementation of hardware breakpoints,
+	  some of them are able to update the breakpoint configuration
+	  without release and reserve the hardware breakpoint register.
+	  What configuration is able to update depends on hardware and
+	  software implementation.
+
 config HAVE_USER_RETURN_NOTIFIER
 	bool
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 58d890fe2100..49d4ce2af94c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -247,6 +247,7 @@ config X86
 	select HAVE_FUNCTION_TRACER
 	select HAVE_GCC_PLUGINS
 	select HAVE_HW_BREAKPOINT
+	select HAVE_REINSTALL_HW_BREAKPOINT
 	select HAVE_IOREMAP_PROT
 	select HAVE_IRQ_EXIT_ON_IRQ_STACK	if X86_64
 	select HAVE_IRQ_TIME_ACCOUNTING
diff --git a/include/linux/hw_breakpoint.h b/include/linux/hw_breakpoint.h
index db199d653dd1..ea373f2587f8 100644
--- a/include/linux/hw_breakpoint.h
+++ b/include/linux/hw_breakpoint.h
@@ -81,6 +81,9 @@ register_wide_hw_breakpoint(struct perf_event_attr *attr,
 			    perf_overflow_handler_t triggered,
 			    void *context);
 
+extern int modify_wide_hw_breakpoint_local(struct perf_event *bp,
+					   struct perf_event_attr *attr);
+
 extern int register_perf_hw_breakpoint(struct perf_event *bp);
 extern void unregister_hw_breakpoint(struct perf_event *bp);
 extern void unregister_wide_hw_breakpoint(struct perf_event * __percpu *cpu_events);
@@ -124,6 +127,9 @@ register_wide_hw_breakpoint(struct perf_event_attr *attr,
 			    perf_overflow_handler_t triggered,
 			    void *context)		{ return NULL; }
 static inline int
+modify_wide_hw_breakpoint_local(struct perf_event *bp,
+				struct perf_event_attr *attr) { return -ENOSYS; }
+static inline int
 register_perf_hw_breakpoint(struct perf_event *bp)	{ return -ENOSYS; }
 static inline void unregister_hw_breakpoint(struct perf_event *bp)	{ }
 static inline void
diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 8ec2cb688903..ef9bab968b2c 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -887,6 +887,42 @@ void unregister_wide_hw_breakpoint(struct perf_event * __percpu *cpu_events)
 }
 EXPORT_SYMBOL_GPL(unregister_wide_hw_breakpoint);
 
+/**
+ * modify_wide_hw_breakpoint_local - update breakpoint config for local cpu
+ * @bp: the hwbp perf event for this cpu
+ * @attr: the new attribute for @bp
+ *
+ * This does not release and reserve the slot of HWBP, just reuse the current
+ * slot on local CPU. So the users must update the other CPUs by themselves.
+ * Also, since this does not release/reserve the slot, this can not change the
+ * type to incompatible type of the HWBP.
+ * Return err if attr is invalid or the cpu fails to update debug register
+ * for new @attr.
+ */
+#ifdef CONFIG_HAVE_REINSTALL_HW_BREAKPOINT
+int modify_wide_hw_breakpoint_local(struct perf_event *bp,
+				    struct perf_event_attr *attr)
+{
+	int ret;
+
+	if (find_slot_idx(bp->attr.bp_type) != find_slot_idx(attr->bp_type))
+		return -EINVAL;
+
+	ret = hw_breakpoint_arch_parse(bp, attr, counter_arch_bp(bp));
+	if (ret)
+		return ret;
+
+	return arch_reinstall_hw_breakpoint(bp);
+}
+#else
+int modify_wide_hw_breakpoint_local(struct perf_event *bp,
+				    struct perf_event_attr *attr)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+EXPORT_SYMBOL_GPL(modify_wide_hw_breakpoint_local);
+
 /**
  * hw_breakpoint_is_used - check if breakpoints are currently used
  *
-- 
2.43.0

