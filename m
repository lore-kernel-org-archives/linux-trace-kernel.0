Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D0A383987
	for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Jul 2026 13:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784293440; cv=none; b=au/0BiyuMTKEPt60cMZMVZGWVqbWhhF3FVT6EsQa/v3oYgw9TrM+0Q7bmkF6/kqEwP8W8Cit+e61b8jOZSrIll86I0V8jFBzu5ladNPcUCwqfUwpKI96AXw2X72tSceoaeO5VHZFkj+zOXTFxceQzM/kVv3hCS6HlSyKro4vvAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784293440; c=relaxed/simple;
	bh=lbvzkRlsaSDQiGshM+ijhIvb7bTedz8kwBQ4nTh8K9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gzWWRklrAE1Y/CnlpUF6XYMMMz4iC7d1lPso8fo7kwMJl1eeW+F9zsq8ADIVxdNR0u3FpOndq8vCPpCJ8prvwlVJs4xWyOl1poQZrJX66eZ+S/6VrvfN5eNZ/5PaMqe+LDGQCri+ELSzuVDVEh/wr77QwW8pvGOXBsDqXKLz2Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D54CRgnn; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D54CRgnn"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-ca7bea5e5b3so5635237a12.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Jul 2026 06:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784293438; x=1784898238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7JZPn8H4RH/LnX03bYCbT81/FjSS1gT/hhL27IRJwnA=;
        b=D54CRgnnfKxCNTe/r4oVwUW7Y4H3h4oRAdG+BNslFp7936UZzXzbgMPKqNnB7DoJ5+
         ZkbNrmjOx7dcamJSrBjzKQE77Q4vuIYucWMDF4JsvOhVpq2dsp18ugaRw8CO+naG6/GI
         PmC+eHeqwHZbis+kWaI5B67jexK4S21YR4bf7IS4vsQkKuDPL/a8Y/UNI/eSyWahWP/H
         qutXQuqz09/s/oaV2107nD+iaOMJpx4rVyI36UHCXVOrVbwLk/qjgbnudYb4BmNAGSUf
         JO5y0e+2P/MSQqLaebvah9LwF7NLyFhtScCwSONNfjbrHWcJqNhQJDj4/2L7LIceeFYd
         92JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784293438; x=1784898238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7JZPn8H4RH/LnX03bYCbT81/FjSS1gT/hhL27IRJwnA=;
        b=VipuId3r7+RgPEQUGMDcIIJlIJRN3IneB9hAZ7u87xLAmKnlm4hrxUAbAqYYQlpItj
         6zojkOYBas42a7IZjsgHR627nC4+aR7VLZ/ilxSCUvt//kw72SrC/SRFDWa3LuNHf1qt
         /46dF68mhqJGBjpEeNsHhy454STz/m/moEPVZgNUEZZ5k3yA82D5qflZbDJtzea5bovl
         h4z4BFVM/8oR308Y6tmcMBKTdN5HWgDhL9PbUtptALQCfLpVXF3D6ZDAjHk01ptoOqWL
         cWdGvJxDRCsUXjVvxCBTkUT05IIZdKdCRdSJjZln0d3SntkIStl+Hcob6oWSn/9ILrTN
         auqQ==
X-Forwarded-Encrypted: i=1; AHgh+RrqCFXiaOEM9U6UWfGze+AdTqc4Q22NlliHaJ8NDCk9e/DsJSaQCMbMfDM2c1IKA2XPvn9vfWIRH77GBe2PyYXxizk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyofjRQQRBDRuT0lTbNsyYO/vhYbVbQWklwcVb6Jih/TEuRAbAv
	szBFARZckAfDHGYdw+iAiPaUQ/Svw9ZaUM9R9vZv4MpVjQU0uqq9OERR
X-Gm-Gg: AfdE7ckW8aJyrTE+667sTgtHxZi9l9mMVqJpCCHdpQODg9RryU0cTRO/8vxxtQOYsIE
	6vPF3ozM0CGelFbKY8oomPHErTqOkRKjy7ThO3EaTQkh/eo5y6iqPyj3t3tGM8m7BSiifWL1G0q
	Vfuw3Sxd9NnlbqtPRYDnwUg7jC1eoW3W5ayN56WLYqSBsN4kUhE/82lmV85zlLY1XJ2P1THPoqY
	H0rHZKYAqRj7od7uxPpnj9y6fx7WG3U/w/voYuc0Hpa1hCAQSgNcUMz1eCFdvJvk7kWH4d75Rtp
	A2m7ncmwctdinJoeVoyg4mPNWMbClcT7KfG1t295ZYgFoqg93NJwoD3+R+zm4tlls+KzIkI+xK0
	GREKf/kJn8sqdn83Gzlh42EGE4hOG1N0IdE2xTd0vKEz9PZWqWXSaK3HWAUyx3D7KhNkT3gScOV
	Ks5A==
X-Received: by 2002:a17:90a:e7c1:b0:36b:9e24:c692 with SMTP id 98e67ed59e1d1-38e4b53439emr2169596a91.20.1784293438047;
        Fri, 17 Jul 2026 06:03:58 -0700 (PDT)
Received: from localhost ([144.24.58.22])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a210571sm7374968eec.31.2026.07.17.06.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 06:03:56 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Matthew Wilcox <willy@infradead.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Randy Dunlap <rdunlap@infradead.org>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [RFC PATCH v2 04/13] HWBP: Add modify_wide_hw_breakpoint_local() API
Date: Fri, 17 Jul 2026 09:03:40 -0400
Message-ID: <20260717130340.1902076-1-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260717125023.1895892-1-wangjinchao600@gmail.com>
References: <20260717125023.1895892-1-wangjinchao600@gmail.com>
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

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 include/linux/hw_breakpoint.h |  6 +++++
 kernel/events/hw_breakpoint.c | 43 +++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/include/linux/hw_breakpoint.h b/include/linux/hw_breakpoint.h
index db199d653dd1..6754ffbee9ed 100644
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
+				struct perf_event_attr *attr) { return -EOPNOTSUPP; }
+static inline int
 register_perf_hw_breakpoint(struct perf_event *bp)	{ return -ENOSYS; }
 static inline void unregister_hw_breakpoint(struct perf_event *bp)	{ }
 static inline void
diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 789add0c185a..f4709c892d67 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -888,6 +888,49 @@ void unregister_wide_hw_breakpoint(struct perf_event * __percpu *cpu_events)
 }
 EXPORT_SYMBOL_GPL(unregister_wide_hw_breakpoint);
 
+/**
+ * modify_wide_hw_breakpoint_local - update breakpoint config for local CPU
+ * @bp: the hwbp perf event for this CPU
+ * @attr: the new attribute for @bp
+ *
+ * This does not release and reserve the slot of a HWBP; it just reuses the
+ * current slot on local CPU. So the users must update the other CPUs by
+ * themselves.
+ * Also, since this does not release/reserve the slot, this can not change the
+ * type to incompatible type of the HWBP.
+ * Return err if attr is invalid or the CPU fails to update debug register
+ * for new @attr.
+ */
+#ifdef CONFIG_HAVE_REINSTALL_HW_BREAKPOINT
+int modify_wide_hw_breakpoint_local(struct perf_event *bp,
+				    struct perf_event_attr *attr)
+{
+	struct arch_hw_breakpoint info;
+	int ret;
+
+	if (find_slot_idx(bp->attr.bp_type) != find_slot_idx(attr->bp_type))
+		return -EINVAL;
+
+	ret = hw_breakpoint_arch_parse(bp, attr, &info);
+	if (ret)
+		return ret;
+
+	*counter_arch_bp(bp) = info;
+	bp->attr.bp_addr = attr->bp_addr;
+	bp->attr.bp_type = attr->bp_type;
+	bp->attr.bp_len = attr->bp_len;
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
2.53.0

