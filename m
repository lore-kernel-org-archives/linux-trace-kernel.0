Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35268334C08
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Jan 2026 10:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769424280; cv=none; b=hcifwZQ0DfyY+7gJhZrL41xnqjVcT42Oc8kfBtMrLlrpZfnGtHvYxXiU2E1/kdyd5vnuBXbCB/ztO9TUPJQYkYneEGloVrNhPOnmdlGZAtOQgdR1b42sT0P9MH5loTy3qGOvQvUc5CbFRPXkWIcDNv6IkFLypu1gVbTtCfj3IrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769424280; c=relaxed/simple;
	bh=ojWH6wLlvx2Q/qChZ7rj5LS3D3RiSCBq1QSUEso5Js0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SOilPCa6k6Xl/kjfQu/hQWeqSKpbzdAJuc4qI4q4K93Sgg/HxoXR2OyXPpZx+j8XSKNr1kDUvyymxsIiqwpgJkOxYf+rr8Bt/8xltiRMuXuWgU0lWIL8xBUdSwz9DNM9VLMdu+i7zcm5TBVGqQDf2LFguCu8vaVzBQl5eg3toWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QJq8baxy; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QJq8baxy"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-48025e12b5bso48667355e9.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Jan 2026 02:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769424276; x=1770029076; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eBVdHdK5pnty3kUjGmHkkia8pj/26sMijHr3rT8k8L0=;
        b=QJq8baxyeDO6PmQcHQZkjH40QkISw38r6guFWKFvzpluwvnLvu4SBGVXUWM83IVLg+
         C6V4ywYyYsS99vK3Lw3xm2Qw7tkQ/Mw+IXO3XWrFYDHsgxdo0xchFzkEnVjzGJpF2bG/
         UX72e/YtasqAq7xU8BDPvGSbAko2JdQwBiwjq5+3U2lmfc+Z6hLfNGmlIMBCqjf7Z/u8
         wz0dLtCcUpaGmnjowc+qQzwuQPhm5SUi1eckD2qAnBoumZwbNdG7ima/jHNoOQCpBTc6
         em0m+zCv6Nhb/nZvAGDzlBuKscrKc9kBoWLdQmnCloJGhiQVt/JOcZqL+UqkTGDd/Hey
         jooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769424276; x=1770029076;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eBVdHdK5pnty3kUjGmHkkia8pj/26sMijHr3rT8k8L0=;
        b=iBIxsWXMRPbF7VH8sHwwzwgz9FDfMYWcqOsytKHY0FB7J+5+qCfLeeBXIP4r8Rv6wa
         88UUPImLZP4ZFsnRif8Rmyac/f9s54EseoLsEKDz3Qujww5wMHQHb5pz0WEMhCYEEyjT
         HzXnfu8zX0NWO/h44gUITJpU+anj36I7/qlDZ7Do++rh0LOHvai/fKuRRxxdHShA4dck
         5JWiwZCiaLCW+S1VLf3YFRTxNJMnPl+pXicHmGwSYqpHT9pkGVt8CwdHpxVRvVQB63aB
         Y5XcI6NaSAaT91jgz/u7xJEZELwa3A5e5CTEVJg/tlNYEjM1zw+qWZn9cEaNVpQYQZmo
         RCSg==
X-Forwarded-Encrypted: i=1; AJvYcCUeJ3CdGb5drJD2B5S5SVmp7WeVfkDiEmcfOGeHcaXyPeJ6Sr6GUUfeEXdRlPKt4rGA9PJvSR2uGq9u0bFdd+aiIFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwokmR+bKzOatFvcQpABU6EHmTdaGS/mZFLMY3j0hdhew9psZPW
	3NknPFL5dkr6VAlSltpmjCCLTpt+APjkboT3Y371Ag2h4LumrR3SBGEyw57z1PAWiGrUX4nSao6
	vuUKTqoMMaAbXqIfl0SM8qw==
X-Received: from wmdv19.prod.google.com ([2002:a05:600c:12d3:b0:47e:e953:a478])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a306:b0:477:a246:8398 with SMTP id 5b1f17b1804b1-4805d9664aemr50974305e9.2.1769424276747;
 Mon, 26 Jan 2026 02:44:36 -0800 (PST)
Date: Mon, 26 Jan 2026 10:44:00 +0000
In-Reply-To: <20260126104419.1649811-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260126104419.1649811-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260126104419.1649811-12-vdonnefort@google.com>
Subject: [PATCH v10 11/30] tracing: Add helpers to create trace remote events
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	aneesh.kumar@kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Declaring remote events can be cumbersome let's add a set of macros to
simplify developers life. The declaration of a remote event is very
similar to kernel's events:

 REMOTE_EVENT(name, id,
     RE_STRUCT(
        re_field(u64 foo)
     ),
     RE_PRINTK("foo=%llu", __entry->foo)
 )

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/include/linux/trace_remote_event.h b/include/linux/trace_remote_event.h
index a4449008a075..c8ae1e1f5e72 100644
--- a/include/linux/trace_remote_event.h
+++ b/include/linux/trace_remote_event.h
@@ -5,6 +5,7 @@
 
 struct trace_remote;
 struct trace_event_fields;
+struct trace_seq;
 
 struct remote_event_hdr {
 	unsigned short	id;
@@ -20,4 +21,13 @@ struct remote_event {
 	char				*print_fmt;
 	void				(*print)(void *evt, struct trace_seq *seq);
 };
+
+#define RE_STRUCT(__args...) __args
+#define re_field(__type, __field) __type __field;
+
+#define REMOTE_EVENT_FORMAT(__name, __struct)	\
+	struct remote_event_format_##__name {	\
+		struct remote_event_hdr hdr;	\
+		__struct			\
+	}
 #endif
diff --git a/include/trace/define_remote_events.h b/include/trace/define_remote_events.h
new file mode 100644
index 000000000000..676e803dc144
--- /dev/null
+++ b/include/trace/define_remote_events.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/trace_events.h>
+#include <linux/trace_remote_event.h>
+#include <linux/trace_seq.h>
+#include <linux/stringify.h>
+
+#define REMOTE_EVENT_INCLUDE(__file) __stringify(../../__file)
+
+#ifdef REMOTE_EVENT_SECTION
+# define __REMOTE_EVENT_SECTION(__name) __used __section(REMOTE_EVENT_SECTION"."#__name)
+#else
+# define __REMOTE_EVENT_SECTION(__name)
+#endif
+
+#define REMOTE_PRINTK_COUNT_ARGS(__args...) \
+	__COUNT_ARGS(, ##__args, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 0)
+
+#define __remote_printk0()								\
+	trace_seq_putc(seq, '\n')
+
+#define __remote_printk1(__fmt)								\
+	trace_seq_puts(seq, " " __fmt "\n")						\
+
+#define __remote_printk2(__fmt, __args...)						\
+do {											\
+	trace_seq_putc(seq, ' ');							\
+	trace_seq_printf(seq, __fmt, __args);						\
+	trace_seq_putc(seq, '\n');							\
+} while (0)
+
+/* Apply the appropriate trace_seq sequence according to the number of arguments */
+#define remote_printk(__args...)							\
+	CONCATENATE(__remote_printk, REMOTE_PRINTK_COUNT_ARGS(__args))(__args)
+
+#define RE_PRINTK(__args...) __args
+
+#define REMOTE_EVENT(__name, __id, __struct, __printk)					\
+	REMOTE_EVENT_FORMAT(__name, __struct);						\
+	static void remote_event_print_##__name(void *evt, struct trace_seq *seq)	\
+	{										\
+		struct remote_event_format_##__name __maybe_unused *__entry = evt;	\
+		trace_seq_puts(seq, #__name);						\
+		remote_printk(__printk);						\
+	}
+#include REMOTE_EVENT_INCLUDE(REMOTE_EVENT_INCLUDE_FILE)
+
+#undef REMOTE_EVENT
+#undef RE_PRINTK
+#undef re_field
+#define re_field(__type, __field)							\
+	{										\
+		.type = #__type, .name = #__field,					\
+		.size = sizeof(__type), .align = __alignof__(__type),			\
+		.is_signed = is_signed_type(__type),					\
+	},
+#define __entry REC
+#define RE_PRINTK(__fmt, __args...) "\"" __fmt "\", " __stringify(__args)
+#define REMOTE_EVENT(__name, __id, __struct, __printk)					\
+	static struct trace_event_fields remote_event_fields_##__name[] = {		\
+		__struct								\
+		{}									\
+	};										\
+	static char remote_event_print_fmt_##__name[] = __printk;			\
+	static struct remote_event __REMOTE_EVENT_SECTION(__name)			\
+	remote_event_##__name = {							\
+		.name		= #__name,						\
+		.id		= __id,							\
+		.fields		= remote_event_fields_##__name,				\
+		.print_fmt	= remote_event_print_fmt_##__name,			\
+		.print		= remote_event_print_##__name,				\
+	}
+#include REMOTE_EVENT_INCLUDE(REMOTE_EVENT_INCLUDE_FILE)
-- 
2.52.0.457.g6b5491de43-goog

