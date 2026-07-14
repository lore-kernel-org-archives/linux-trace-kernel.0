Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74366336EC0
	for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Jul 2026 18:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784053861; cv=none; b=Rxpc4faz79xN0EXcIFSwP3yd4lK6HcdiYP4lqpTbXk45Ift/5p6GOeP7gXIzJLEj4sXYJLQpkNCJNW9C4v+azQFNUtekoNuY18h42qibvtPALiRk491YS8alfn/3t+9ZWzukIJwC7x2vbd8INCFMxkjm7+uh8IFeb7zMIWFuduc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784053861; c=relaxed/simple;
	bh=FHK60SJXTYT3avGIezwouMxmlq7uogDooasnOh5j77M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XtB6Cv2nnf1MNu5AzbZhkibB9upeBVtGCy6taLU0FmxCdOYsZW+3r0GigADS48Ncq/uif6UhI7LyVSna/Ri3eL/+K1AsEumSwBHXGLZhHlrhd4ZUpl0aoZoBRgfhY5tsFYW65x3k1oPsZ8igwHApLS4qPIdDJJUdwO1ehHZ5X6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUXD74rY; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUXD74rY"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c01089e8aso10169601cf.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Jul 2026 11:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784053859; x=1784658659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XbJ+trxR7t2GCSYkV+uASOu7DEK0LHp1KcDwbXdFB5Y=;
        b=WUXD74rYONhqHtUftV7/r2zoWXVS/VCNwvFGavyIQWkBSP7RukQbuxV6ld49DYR+Td
         qCfOh4kw/TJtDJ9LKrjeYkrF4FgDESk0vFyQrOjAdsdjdBH+9iigzB0Fxg0VWjI/pi73
         oYGEKQbLZ+g1+k+d0uL7jcV9yaAJrj851jKQk+kkGTGVYzFfOB5h29H/zQVnLcl5ikIK
         5RMvRp4/WE9VVgYf95q7tBkLBNq6t0G2L2s1OkNHDFniTjQ7zOzx2BTcvtYZBMPw1Bic
         w58LuiJHIfORrSHlPXCUcpWFj5QNiWq7uG1WYYlNUetZKO7bbt0NQwR0XL2AvtOi5Gza
         15Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784053859; x=1784658659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XbJ+trxR7t2GCSYkV+uASOu7DEK0LHp1KcDwbXdFB5Y=;
        b=AgqlbxXIgEBH5GPAFZY44zWGXfAtFyYA7S7xc+ogyY1oVXwYKjrHsVj5+hsk3UmqEW
         2yg236TgpM4oGRICdszcYJJ2EuGf5NoBGqJqriybSnt7WJG7Bx89fMyVCux76+W26rRr
         U2G7gfYAb8fh6UurtB9OUS8XX5UaZW38ytSc7AJxUaLdG/50aYD7cnGSSzyzv19cUpbp
         pyczPRBEfacc1CQGChT3HLSwvzK8JgUWou/DGks11eBFqJuTr4OM61PNA5iwOnDHe1SN
         tM8IU88Mi87WyvPBh8BAFK7g8lgD/kQ/8n6g3x8xJTwxh0ooqzv+GpOHMFor1XQjyJsx
         2nDQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp7iGErngOdR0Ea5X2JsaJv5WHALl/MmlgX3k2Z5+gzh4WjDLe/WlW4C34LQ8fth9utQA24U8YIZ8Wh2RwoyVNL0MA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuEEhdffBSt/MF8abaX46hk3ZMH+uZp37sttzBZTHvAEtSWIiJ
	gtC31AHdEsJzNbkv464EAbcfQ3ToqjyQf+jhm2cd8ekcO8dkO0U4hO7u
X-Gm-Gg: AfdE7ckdOsX4OOTaHqZ6CiTT6bfe2Hix4jFbC7+h9HU+bn5rq2WCcer5vZSQRfbYUP4
	KhZyW7mm6W0wmWJui003vgCbyiLt6G/ht2hNn54Dsd9DLGx8RPDam//ugVJZ7NWe9MUaBp1PQjH
	K6+d1adLGXm008loAzDoMoWoSSz3L98bmyurQfMYshYPVQ/NYfM8Pss9pqYmZaZy4hYDwA0lDZe
	qwqawe96Nkd66Cp80QGRxLZZkjfWdYWpgdZRYYvKxwu1+1/F0i3fC6qQtv6qTGz1GGDxXmU6xDX
	GNwSZa8EiP7EbqRcpPiaI0nLhRNxZZLu7i57VPAwEIsR6qppv8DGvvowjN1UQUrvb+VXuszDcNP
	dHISInkkD1LcknSr8cfCsx57eofGX6nwBWd/ld2FysOsRbl9Gd4dGTtwq5LIIMZgZsjVlDcVq72
	qbfVgi4zufz5hb4myrjvxmHWN+Df5rkzqpZK99EyG2gN6rwaX6QIs=
X-Received: by 2002:a05:622a:1f98:b0:51c:84cb:b9b0 with SMTP id d75a77b69052e-51cbf301566mr148948911cf.81.1784053859166;
        Tue, 14 Jul 2026 11:30:59 -0700 (PDT)
Received: from localhost ([48.45.163.146])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caae24d04sm117191211cf.18.2026.07.14.11.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:30:58 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [RFC PATCH 04/13] HWBP: Add modify_wide_hw_breakpoint_local() API
Date: Wed, 15 Jul 2026 02:30:49 +0800
Message-ID: <20260714183049.12383-1-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714182243.10687-1-wangjinchao600@gmail.com>
References: <20260714182243.10687-1-wangjinchao600@gmail.com>
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
Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 include/linux/hw_breakpoint.h |  6 ++++++
 kernel/events/hw_breakpoint.c | 37 +++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

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
index 789add0c185a..20ca64f30508 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -888,6 +888,43 @@ void unregister_wide_hw_breakpoint(struct perf_event * __percpu *cpu_events)
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
2.53.0

