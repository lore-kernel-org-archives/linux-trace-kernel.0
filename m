Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2EE194A60
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 May 2025 13:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747402852; cv=none; b=G3HaDPgqJPS1p8nfAjP0/cEH8PbI+nJbyHZxYNf1FKjmZybygcItzaObp8VilEiVkT5fZy/+LRJ1UQGyWI+7pX+aGlSkBeyXzbyg9U9EcnXjC2TpjXfBBliiapq60o4eQWV4wBXpmPnSwrWJ1ECRoxr7+vdlEnkuGNLTAHZJogo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747402852; c=relaxed/simple;
	bh=w8JKPJ88iJQDLUk1FH/Uus7ffIKXybTpLwm4M6OOBUs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JWO5Xg3XqgLCn8ajTEcZhSwAB6N9kIj94C38SrILX05cTDdYH6zdhUE/e9KLDFsuc96CewQr6UUGMyOjrCniD/Woctd8Vz+QnF84xgFHmAoIfANu4WMny1pK8S5YcnJ2exoTYxN/jinbhufkvKCcpAPmccimFV+NMkdzlseog+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ga2N43fu; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ga2N43fu"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43d0830c3f7so14932345e9.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 16 May 2025 06:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747402849; x=1748007649; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uMPV6q6AhxevNFuuJTWHVmUqHFVmOMovU6ugpBlq244=;
        b=ga2N43fu1HOhmu6TG9gP+PLdWThhzBiFBJEnnoUdCt37YCtcOihNmije6QmJmAvwx+
         /V9aRteoULM+qf/+UvxvL3tqEDyY4cZ0mUd5hzlFj7Wo+BfHEhRNzBU6Ig4i+v3aVAcI
         HGkJAmdX8/j00N1+z/OFIPZ1nCS+5U9f4Q/510QeA2hsksfEPE/n4ux7O/L7PlVqc/NQ
         Lyjl54N7Y4vr49mvsg/LDyfxq65sr0D1dtHs5qUGf1rSANxZ2p06w5DsNGJFXBdzENsi
         6EWZL9qINBAUCMUOQL76u9J2NbdsQRb4WIcSh1KbRhoxGgoxswH2XypvVzVsx5mGsLvN
         Xj2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747402849; x=1748007649;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uMPV6q6AhxevNFuuJTWHVmUqHFVmOMovU6ugpBlq244=;
        b=c+quUXYY0aAxoiDSLCIViLmjAHMUfcSByoXYQDr2ELPuai9Jg+JMlYM+y+7J5yL1cz
         ghxUxeiMsdWGfXXUBh7RDNMBqjaGEIOV/Nat3NTTSXRwCXaNc+oad24AHbQ4hzAhT567
         tSW1akkRfHXNBtj1Jqkc4jHu0yzdjB1MssPK29QD9H9wHn+v3E0CIicudd7k+8+aXqpk
         1AWGN1FkPjQdQHIJFlLpRS12sOUL8ZegU/CPWIh27NxW0wrvBtQXz/1e5uR2wyQXkiz3
         0w3MMmAsuTNZe2qP/KjlgWoIUeqiJY5PVqckpBgD5MLdpeQJ6jSGWX4q3v0Vr//3zaiV
         8CkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmQ5XrsQ98jtvZEPzCLWN82oXlNnN5MmmTAygWncrZKvuNSXHDnEpmxKgaG80rrYkvQQPmjCQV9amp2UN5LfenKmM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw43ulpKeWvaj+Vuymza0+Ijkpqbz5HHPIveJGlLis7A7t1sV/H
	T52z0mcsZjy0qhze9jdPU+OTriPJoYf2+d/UddhXpRxlAI0baV8Q09zulZDKhcDanC9G/0vSkEs
	wqYjInRmlYPUsXC4pYbqvvQ==
X-Google-Smtp-Source: AGHT+IHjdYekjEtSxYYuQf8wZlV0mGx8EyL0cimXZ1RlU//8JTdiC8v32KOEE5rEeE110DQaD1BJQza2ZZZwb4Cn
X-Received: from wmbei22.prod.google.com ([2002:a05:600c:3f16:b0:43c:ef1f:48d3])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f42:b0:442:f4d4:522 with SMTP id 5b1f17b1804b1-442fd60a5bemr35175355e9.5.1747402849231;
 Fri, 16 May 2025 06:40:49 -0700 (PDT)
Date: Fri, 16 May 2025 14:40:14 +0100
In-Reply-To: <20250516134031.661124-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250516134031.661124-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250516134031.661124-9-vdonnefort@google.com>
Subject: [PATCH v5 08/25] tracing: Add helpers to create trace remote events
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
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
index 000000000000..03c9f5515c5a
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
+#define __REMOTE_PRINTK_COUNT_ARGS(_0, _1, _2, _n, __args...) _n
+#define REMOTE_PRINTK_COUNT_ARGS(__args...) __REMOTE_PRINTK_COUNT_ARGS(, ##__args, 2, 1, 0)
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
2.49.0.1101.gccaa498523-goog

