Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6601B352C47
	for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Jan 2026 13:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769866175; cv=none; b=hNFlbCcqAjnEbcsm5rW0JpJIBNtV1x03r83rbwEgyFNWF6PWWYJXBlnqLmNx9jSzpjif4GIIr4fqFRIyKXp8yHKEqadsnbwrduymWldXiWMxEUAbt1VhF4EkqwVrUrcZGcceA3rVlxhMmD/v5Vi4CEEJ88h3zOHOykvdxAWP4kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769866175; c=relaxed/simple;
	bh=bH9A+PcOeaBqOY1n6QII0dmbCLpPluQkaUgm1wPBKiE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VDAcXCHQuq6SAgJiSupmtGlIJXjoKxp35hHia6JpK3EoOkbyHIvAODVMq9GrRaIhbAfhtVw6DaDvZZk22bWDn6XVmq6N0Sah/Y8fPWWKgJaImf8gfMFVqQSDLJ+bGNyv6UFbm5ww76Zjc/X3wl0Z/t2u4hbqbq9kisfo+Be0Oz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fdP2U8s3; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fdP2U8s3"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b83c3dd2092so319720666b.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Jan 2026 05:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769866172; x=1770470972; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cmv9pvVDnZ4go9IGE3NPxdNq415YebjgteYn5xFgp+s=;
        b=fdP2U8s35d1Yq1/UsRf9KYnZc+kSYYQfY0Tqgrikaz5v38q3mOMEQ+adczj1b0oDty
         pdmJf3VNHVylb3UkscLnM+zycjZelO4487KaKOvPtoop1iVLUT1G7sUm8OaPnmhnKBrH
         n5t0vPFmsNX617s/uWCf12GicMZPOQ1JnaZq6873qeA63MDFn01mSwgpJ/6zW/U4Qnh4
         2ai2BGKuetmzihVhk7FyHfcFvrXPD5H9KgH7700bnhqlwW42s10oNQ7bymwVemFyO0Gx
         dnbwPGwNd/hsrBr/Tg0pe1WfnGu2+O00ll/ul1HrFf5AyLb+l/kSvrf3uOWsQvNVwt+R
         HBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769866172; x=1770470972;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cmv9pvVDnZ4go9IGE3NPxdNq415YebjgteYn5xFgp+s=;
        b=P6LM1xf5jDgcilv24WJRQ2z7KMEEE8imIXaBA+c0i25HZDGOWa48wyjoyRZ3KXdLIv
         m+1eveRE5RCdxmGAdusHqkrXxU/xvPN6jZAU7JL897oIE3PuW2lV+joNE/PAtXJjW1hQ
         6qJCNb/2rgKv5amQBb15laCzaCoHV7oJ2klQNeHGJMDNUChr3M7StpfbpZZ1ntFfctZy
         Eg48I+GL2WbUZQRYXQsHe0r1d/q073YIrl2Cu1ikeSZCo3iwD/dcCmMNU8hYDcOrCrRV
         0eQ0p5CSgHe+5jV5wNgx+7Dl9BTvjfz70iKwWmqm+Tn15FU8QVNoDkARjftWJbxebrU1
         XVMw==
X-Forwarded-Encrypted: i=1; AJvYcCVSUpLKvFvbJv4R0fqV0awIZIw6M7n04ec8SXLO8hM2IGFr8F9Dlhisfkbgk5fXRF73HrgmhxrjXvKwUqusSztH+30=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx60yQRLUdF/9oShjjhKafyvx0KSF9Gmk6PeFnVSSYWw+qvrQgs
	KG6+5Fzcm44Rrzaa+RmKKOVyjkjxUHz0HoINHSiYrzU6Npw7V6AJR0h55fhv5+hDNs/dLczqRmL
	qLRfRlwt9DWn61KwuNSnrMQ==
X-Received: from ejpk1.prod.google.com ([2002:a17:906:66c1:b0:b84:4fbe:af3b])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:2d1f:b0:b87:efa:8786 with SMTP id a640c23a62f3a-b8dff6f7d99mr386552866b.55.1769866171645;
 Sat, 31 Jan 2026 05:29:31 -0800 (PST)
Date: Sat, 31 Jan 2026 13:28:29 +0000
In-Reply-To: <20260131132848.254084-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260131132848.254084-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260131132848.254084-12-vdonnefort@google.com>
Subject: [PATCH v11 11/30] tracing: Add helpers to create trace remote events
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

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
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
2.53.0.rc1.225.gd81095ad13-goog

