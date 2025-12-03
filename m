Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807EA35BDD8
	for <linux-trace-kernel@vger.kernel.org>; Wed,  3 Dec 2025 16:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764779019; cv=none; b=D4eA/VKhcoAfOWv5yABXg2r8sIrANptWPekr9HGy6Udx4nLwb2271Gy5OJ3Yg1gaZbj2MuZpNnNU/4RmDDFrVuDTQ4bcoFepp7HO4i/MFw1JkD9BM0EleVybWyGWHDQlSc1eCKH7od45YdEJxzyjB6IQvizsl8zIPVUmTQFKb+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764779019; c=relaxed/simple;
	bh=/xGRmTZUvawxEclmA+XPVYhBIHs2uRp6oua5Ra+o038=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H+Bly39CdT/LWGEaGti7Sn3FiBEKsyTv6gSyNECtLJtHGBDHm9xTt4dKFyodNAajKbPtC0rmrVAHs3IngCk+pxDowkXzD5ZvRtk3lu1kWZAIIk59OdSrIz2L4pHUIU4pHMEfHIRURUbVFJ5DMbrAwiLnvyFgPVKjRdLSYLrgijM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JwVqGuob; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwVqGuob"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-640f2c9cc72so6420228d50.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 Dec 2025 08:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764779015; x=1765383815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+YkI7yxgZbxvWG5CSZuoiKBiRKPO6bzZHfGPllRKlE=;
        b=JwVqGuob+TtzuGpO1mCJ3HwLFhlC5R0t5gflYrzDg9O7XoUqKVZiwfMUXLwaujI5HX
         yKXcTRZqi9WiGxHc0ueJ91ybQZwqO4RkNxSyi49wTDkUexkShTZyZ/uLP07TRjiZ0HQk
         /OZ1a4bRPJFwcMpkr4RM3ItexHZLgbGj4b6LqJhEf9WkQJSH/pZO/xQD6FTjYK6gkfz4
         Uyd9V5nLdSJMUm4dK2CtMIfc5LiR/CAFe5NOtiZvjZWtnOZEdDS/U5dNSGOLSVKSGs8a
         gUAH9nie0CmdJtKkIRjXtMizdX1XEBe6WVUmZTkuuBVIYdTWF8ncAvVIogpF2F6Y7kop
         b8Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764779015; x=1765383815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u+YkI7yxgZbxvWG5CSZuoiKBiRKPO6bzZHfGPllRKlE=;
        b=Vd8kcf6IRVi2rotUnVG73SO3oFtaRbCy734byCLeHiP6+EZTuPHSWcbYYAYjzAWhPZ
         CwklW36X1UDq7i5gkTeEi+vZHQu5XLnu4BpHV1mTXvxExkQi0lWOQEOZh78YSwL3plGh
         tc4d616dnMwUg+fBsarB4ID8gfbcIryHiP9E4HOtn6jdQ+wSEVPyU1gn36cF3lDR9Gu8
         o42JgwjEQ+em5bAVflrxr+peA8Ur4Qxtck8t808zksqBb4hTCeprNk7RO0TdnedwqCKJ
         UKfcvhOQ5KNxXzzqJdy5WgIscvr+sQA0/EObSSRk85w4FmJkQAOAdaHDj0tl+yrlK9GY
         c9jA==
X-Forwarded-Encrypted: i=1; AJvYcCV3A+viVGrQSNPQHvrHDdMVjxex0kOMn3VnDiWDauAfeB6/HGycbKzfQaoSECev+65B6RKLjmV7TTZc93W0bU3OD0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEHv3e+7ZNOx41cGLX0ttXKRQWz188EBnRY1Nvi0hcAMWlaOxO
	aAtgP6d1Ml6LHADKgm/rm01c2sdRV7KJN1Dc5lyZxh4/kpER++lr4mvs
X-Gm-Gg: ASbGncvMyuzlGPc4aAcxIDxrvI7TrfLC0E5LBAV/Iqr2AM3L+IAiLSAjytf93hL8F9C
	nvFX49SwdbizlOWTVU3vnXlY2web3T69QzDxVu6WutyKiLP3os22BdOJGeKJJHiT6DZao3dCUlA
	sShC7qI2bDvtsOnnrEcz+HCI8MkHx2kQHkVZqa3D7yeLeZ9rYBRMHRKLLiVm+LKG+g8viZADLsx
	BLJYS3DtCXA/Zwa+5+Z5dnOuXeLDsEi5Wt7jsKJKC9duz9ePQmKEfhZeAb9l9w8XSIPrdw7GCYv
	3Y8OLIcnmdYXopXvLb9erP/hKPe5UsSy4XivGlh2rMAEnRFpB0xeQzn1NVpRotaZ0XgnFgKRtK+
	9WoPZRTIbaB6cj12IfPyqASZzqu9qTRB7tEbA/t2NGZO69wwszBYB1qElLGH+kiftxawRDWtq3I
	qLl0TpkUY=
X-Google-Smtp-Source: AGHT+IEPVhBVhHqmXlFlujsvZ2Z7YgyVduNJK+ouLa37SCa3WPL1QjTtN4FQT3/5zFNK8Ka8ZcDd2A==
X-Received: by 2002:a05:690c:25c4:b0:786:5471:f44c with SMTP id 00721157ae682-78c0c25b617mr46763917b3.63.1764779014985;
        Wed, 03 Dec 2025 08:23:34 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:3422:8bf9:97bc:b085])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78ad102d1aasm75414447b3.43.2025.12.03.08.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 08:23:34 -0800 (PST)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	David Laight <david.laight@runbox.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Daniel Gomez <da.gomez@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Subject: [PATCH v2 4/4] tracing: move tracing declarations from kernel.h to a dedicated header
Date: Wed,  3 Dec 2025 11:23:25 -0500
Message-ID: <20251203162329.280182-5-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251203162329.280182-1-yury.norov@gmail.com>
References: <20251203162329.280182-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tracing is a half of the kernel.h in terms of LOCs, although it's
a self-consistent part. It is intended for quick debugging purposes
and isn't used by the normal tracing utilities.

Move it to a separate header. If someone needs to just throw a
trace_printk() in their driver, they will not have to pull all
the heavy tracing machinery.

This is a pure move, except for removing a few 'extern's.

Acked-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 MAINTAINERS             |   1 +
 include/linux/kernel.h  | 195 +-------------------------------------
 include/linux/tracing.h | 203 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 205 insertions(+), 194 deletions(-)
 create mode 100644 include/linux/tracing.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 3468f6827b13..107cadb613da 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26080,6 +26080,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
 F:	Documentation/trace/*
 F:	fs/tracefs/
 F:	include/linux/trace*.h
+F:	include/linux/tracing.h
 F:	include/trace/
 F:	kernel/trace/
 F:	kernel/tracepoint.c
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 5b879bfea948..2e9d65177f45 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -32,6 +32,7 @@
 #include <linux/build_bug.h>
 #include <linux/sprintf.h>
 #include <linux/static_call_types.h>
+#include <linux/tracing.h>
 #include <linux/instruction_pointer.h>
 #include <linux/util_macros.h>
 #include <linux/wordpart.h>
@@ -190,200 +191,6 @@ enum system_states {
 };
 extern enum system_states system_state;
 
-/*
- * General tracing related utility functions - trace_printk(),
- * tracing_on/tracing_off and tracing_start()/tracing_stop
- *
- * Use tracing_on/tracing_off when you want to quickly turn on or off
- * tracing. It simply enables or disables the recording of the trace events.
- * This also corresponds to the user space /sys/kernel/tracing/tracing_on
- * file, which gives a means for the kernel and userspace to interact.
- * Place a tracing_off() in the kernel where you want tracing to end.
- * From user space, examine the trace, and then echo 1 > tracing_on
- * to continue tracing.
- *
- * tracing_stop/tracing_start has slightly more overhead. It is used
- * by things like suspend to ram where disabling the recording of the
- * trace is not enough, but tracing must actually stop because things
- * like calling smp_processor_id() may crash the system.
- *
- * Most likely, you want to use tracing_on/tracing_off.
- */
-
-enum ftrace_dump_mode {
-	DUMP_NONE,
-	DUMP_ALL,
-	DUMP_ORIG,
-	DUMP_PARAM,
-};
-
-#ifdef CONFIG_TRACING
-void tracing_on(void);
-void tracing_off(void);
-int tracing_is_on(void);
-void tracing_snapshot(void);
-void tracing_snapshot_alloc(void);
-
-extern void tracing_start(void);
-extern void tracing_stop(void);
-
-static inline __printf(1, 2)
-void ____trace_printk_check_format(const char *fmt, ...)
-{
-}
-#define __trace_printk_check_format(fmt, args...)			\
-do {									\
-	if (0)								\
-		____trace_printk_check_format(fmt, ##args);		\
-} while (0)
-
-/**
- * trace_printk - printf formatting in the ftrace buffer
- * @fmt: the printf format for printing
- *
- * Note: __trace_printk is an internal function for trace_printk() and
- *       the @ip is passed in via the trace_printk() macro.
- *
- * This function allows a kernel developer to debug fast path sections
- * that printk is not appropriate for. By scattering in various
- * printk like tracing in the code, a developer can quickly see
- * where problems are occurring.
- *
- * This is intended as a debugging tool for the developer only.
- * Please refrain from leaving trace_printks scattered around in
- * your code. (Extra memory is used for special buffers that are
- * allocated when trace_printk() is used.)
- *
- * A little optimization trick is done here. If there's only one
- * argument, there's no need to scan the string for printf formats.
- * The trace_puts() will suffice. But how can we take advantage of
- * using trace_puts() when trace_printk() has only one argument?
- * By stringifying the args and checking the size we can tell
- * whether or not there are args. __stringify((__VA_ARGS__)) will
- * turn into "()\0" with a size of 3 when there are no args, anything
- * else will be bigger. All we need to do is define a string to this,
- * and then take its size and compare to 3. If it's bigger, use
- * do_trace_printk() otherwise, optimize it to trace_puts(). Then just
- * let gcc optimize the rest.
- */
-
-#define trace_printk(fmt, ...)				\
-do {							\
-	char _______STR[] = __stringify((__VA_ARGS__));	\
-	if (sizeof(_______STR) > 3)			\
-		do_trace_printk(fmt, ##__VA_ARGS__);	\
-	else						\
-		trace_puts(fmt);			\
-} while (0)
-
-#define do_trace_printk(fmt, args...)					\
-do {									\
-	static const char *trace_printk_fmt __used			\
-		__section("__trace_printk_fmt") =			\
-		__builtin_constant_p(fmt) ? fmt : NULL;			\
-									\
-	__trace_printk_check_format(fmt, ##args);			\
-									\
-	if (__builtin_constant_p(fmt))					\
-		__trace_bprintk(_THIS_IP_, trace_printk_fmt, ##args);	\
-	else								\
-		__trace_printk(_THIS_IP_, fmt, ##args);			\
-} while (0)
-
-extern __printf(2, 3)
-int __trace_bprintk(unsigned long ip, const char *fmt, ...);
-
-extern __printf(2, 3)
-int __trace_printk(unsigned long ip, const char *fmt, ...);
-
-/**
- * trace_puts - write a string into the ftrace buffer
- * @str: the string to record
- *
- * Note: __trace_bputs is an internal function for trace_puts and
- *       the @ip is passed in via the trace_puts macro.
- *
- * This is similar to trace_printk() but is made for those really fast
- * paths that a developer wants the least amount of "Heisenbug" effects,
- * where the processing of the print format is still too much.
- *
- * This function allows a kernel developer to debug fast path sections
- * that printk is not appropriate for. By scattering in various
- * printk like tracing in the code, a developer can quickly see
- * where problems are occurring.
- *
- * This is intended as a debugging tool for the developer only.
- * Please refrain from leaving trace_puts scattered around in
- * your code. (Extra memory is used for special buffers that are
- * allocated when trace_puts() is used.)
- *
- * Returns: 0 if nothing was written, positive # if string was.
- *  (1 when __trace_bputs is used, strlen(str) when __trace_puts is used)
- */
-
-#define trace_puts(str) ({						\
-	static const char *trace_printk_fmt __used			\
-		__section("__trace_printk_fmt") =			\
-		__builtin_constant_p(str) ? str : NULL;			\
-									\
-	if (__builtin_constant_p(str))					\
-		__trace_bputs(_THIS_IP_, trace_printk_fmt);		\
-	else								\
-		__trace_puts(_THIS_IP_, str, strlen(str));		\
-})
-extern int __trace_bputs(unsigned long ip, const char *str);
-extern int __trace_puts(unsigned long ip, const char *str, int size);
-
-extern void trace_dump_stack(int skip);
-
-/*
- * The double __builtin_constant_p is because gcc will give us an error
- * if we try to allocate the static variable to fmt if it is not a
- * constant. Even with the outer if statement.
- */
-#define ftrace_vprintk(fmt, vargs)					\
-do {									\
-	if (__builtin_constant_p(fmt)) {				\
-		static const char *trace_printk_fmt __used		\
-		  __section("__trace_printk_fmt") =			\
-			__builtin_constant_p(fmt) ? fmt : NULL;		\
-									\
-		__ftrace_vbprintk(_THIS_IP_, trace_printk_fmt, vargs);	\
-	} else								\
-		__ftrace_vprintk(_THIS_IP_, fmt, vargs);		\
-} while (0)
-
-extern __printf(2, 0) int
-__ftrace_vbprintk(unsigned long ip, const char *fmt, va_list ap);
-
-extern __printf(2, 0) int
-__ftrace_vprintk(unsigned long ip, const char *fmt, va_list ap);
-
-extern void ftrace_dump(enum ftrace_dump_mode oops_dump_mode);
-#else
-static inline void tracing_start(void) { }
-static inline void tracing_stop(void) { }
-static inline void trace_dump_stack(int skip) { }
-
-static inline void tracing_on(void) { }
-static inline void tracing_off(void) { }
-static inline int tracing_is_on(void) { return 0; }
-static inline void tracing_snapshot(void) { }
-static inline void tracing_snapshot_alloc(void) { }
-
-static inline __printf(1, 2)
-int trace_printk(const char *fmt, ...)
-{
-	return 0;
-}
-static __printf(1, 0) inline int
-ftrace_vprintk(const char *fmt, va_list ap)
-{
-	return 0;
-}
-static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
-#endif /* CONFIG_TRACING */
-
 /* Rebuild everything on CONFIG_DYNAMIC_FTRACE */
 #ifdef CONFIG_DYNAMIC_FTRACE
 # define REBUILD_DUE_TO_DYNAMIC_FTRACE
diff --git a/include/linux/tracing.h b/include/linux/tracing.h
new file mode 100644
index 000000000000..1989e6328c59
--- /dev/null
+++ b/include/linux/tracing.h
@@ -0,0 +1,203 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_TRACING_H
+#define _LINUX_TRACING_H
+
+#include <linux/compiler_attributes.h>
+#include <linux/instruction_pointer.h>
+#include <linux/stringify.h>
+
+/*
+ * General tracing related utility functions - trace_printk(),
+ * tracing_on/tracing_off and tracing_start()/tracing_stop
+ *
+ * Use tracing_on/tracing_off when you want to quickly turn on or off
+ * tracing. It simply enables or disables the recording of the trace events.
+ * This also corresponds to the user space /sys/kernel/tracing/tracing_on
+ * file, which gives a means for the kernel and userspace to interact.
+ * Place a tracing_off() in the kernel where you want tracing to end.
+ * From user space, examine the trace, and then echo 1 > tracing_on
+ * to continue tracing.
+ *
+ * tracing_stop/tracing_start has slightly more overhead. It is used
+ * by things like suspend to ram where disabling the recording of the
+ * trace is not enough, but tracing must actually stop because things
+ * like calling smp_processor_id() may crash the system.
+ *
+ * Most likely, you want to use tracing_on/tracing_off.
+ */
+
+enum ftrace_dump_mode {
+	DUMP_NONE,
+	DUMP_ALL,
+	DUMP_ORIG,
+	DUMP_PARAM,
+};
+
+#ifdef CONFIG_TRACING
+void tracing_on(void);
+void tracing_off(void);
+int tracing_is_on(void);
+void tracing_snapshot(void);
+void tracing_snapshot_alloc(void);
+
+void tracing_start(void);
+void tracing_stop(void);
+
+static inline __printf(1, 2)
+void ____trace_printk_check_format(const char *fmt, ...)
+{
+}
+#define __trace_printk_check_format(fmt, args...)			\
+do {									\
+	if (0)								\
+		____trace_printk_check_format(fmt, ##args);		\
+} while (0)
+
+/**
+ * trace_printk - printf formatting in the ftrace buffer
+ * @fmt: the printf format for printing
+ *
+ * Note: __trace_printk is an internal function for trace_printk() and
+ *       the @ip is passed in via the trace_printk() macro.
+ *
+ * This function allows a kernel developer to debug fast path sections
+ * that printk is not appropriate for. By scattering in various
+ * printk like tracing in the code, a developer can quickly see
+ * where problems are occurring.
+ *
+ * This is intended as a debugging tool for the developer only.
+ * Please refrain from leaving trace_printks scattered around in
+ * your code. (Extra memory is used for special buffers that are
+ * allocated when trace_printk() is used.)
+ *
+ * A little optimization trick is done here. If there's only one
+ * argument, there's no need to scan the string for printf formats.
+ * The trace_puts() will suffice. But how can we take advantage of
+ * using trace_puts() when trace_printk() has only one argument?
+ * By stringifying the args and checking the size we can tell
+ * whether or not there are args. __stringify((__VA_ARGS__)) will
+ * turn into "()\0" with a size of 3 when there are no args, anything
+ * else will be bigger. All we need to do is define a string to this,
+ * and then take its size and compare to 3. If it's bigger, use
+ * do_trace_printk() otherwise, optimize it to trace_puts(). Then just
+ * let gcc optimize the rest.
+ */
+
+#define trace_printk(fmt, ...)				\
+do {							\
+	char _______STR[] = __stringify((__VA_ARGS__));	\
+	if (sizeof(_______STR) > 3)			\
+		do_trace_printk(fmt, ##__VA_ARGS__);	\
+	else						\
+		trace_puts(fmt);			\
+} while (0)
+
+#define do_trace_printk(fmt, args...)					\
+do {									\
+	static const char *trace_printk_fmt __used			\
+		__section("__trace_printk_fmt") =			\
+		__builtin_constant_p(fmt) ? fmt : NULL;			\
+									\
+	__trace_printk_check_format(fmt, ##args);			\
+									\
+	if (__builtin_constant_p(fmt))					\
+		__trace_bprintk(_THIS_IP_, trace_printk_fmt, ##args);	\
+	else								\
+		__trace_printk(_THIS_IP_, fmt, ##args);			\
+} while (0)
+
+__printf(2, 3)
+int __trace_bprintk(unsigned long ip, const char *fmt, ...);
+
+__printf(2, 3)
+int __trace_printk(unsigned long ip, const char *fmt, ...);
+
+/**
+ * trace_puts - write a string into the ftrace buffer
+ * @str: the string to record
+ *
+ * Note: __trace_bputs is an internal function for trace_puts and
+ *       the @ip is passed in via the trace_puts macro.
+ *
+ * This is similar to trace_printk() but is made for those really fast
+ * paths that a developer wants the least amount of "Heisenbug" effects,
+ * where the processing of the print format is still too much.
+ *
+ * This function allows a kernel developer to debug fast path sections
+ * that printk is not appropriate for. By scattering in various
+ * printk like tracing in the code, a developer can quickly see
+ * where problems are occurring.
+ *
+ * This is intended as a debugging tool for the developer only.
+ * Please refrain from leaving trace_puts scattered around in
+ * your code. (Extra memory is used for special buffers that are
+ * allocated when trace_puts() is used.)
+ *
+ * Returns: 0 if nothing was written, positive # if string was.
+ *  (1 when __trace_bputs is used, strlen(str) when __trace_puts is used)
+ */
+
+#define trace_puts(str) ({						\
+	static const char *trace_printk_fmt __used			\
+		__section("__trace_printk_fmt") =			\
+		__builtin_constant_p(str) ? str : NULL;			\
+									\
+	if (__builtin_constant_p(str))					\
+		__trace_bputs(_THIS_IP_, trace_printk_fmt);		\
+	else								\
+		__trace_puts(_THIS_IP_, str, strlen(str));		\
+})
+int __trace_bputs(unsigned long ip, const char *str);
+int __trace_puts(unsigned long ip, const char *str, int size);
+
+void trace_dump_stack(int skip);
+
+/*
+ * The double __builtin_constant_p is because gcc will give us an error
+ * if we try to allocate the static variable to fmt if it is not a
+ * constant. Even with the outer if statement.
+ */
+#define ftrace_vprintk(fmt, vargs)					\
+do {									\
+	if (__builtin_constant_p(fmt)) {				\
+		static const char *trace_printk_fmt __used		\
+		  __section("__trace_printk_fmt") =			\
+			__builtin_constant_p(fmt) ? fmt : NULL;		\
+									\
+		__ftrace_vbprintk(_THIS_IP_, trace_printk_fmt, vargs);	\
+	} else								\
+		__ftrace_vprintk(_THIS_IP_, fmt, vargs);		\
+} while (0)
+
+__printf(2, 0) int
+__ftrace_vbprintk(unsigned long ip, const char *fmt, va_list ap);
+
+__printf(2, 0) int
+__ftrace_vprintk(unsigned long ip, const char *fmt, va_list ap);
+
+void ftrace_dump(enum ftrace_dump_mode oops_dump_mode);
+#else
+static inline void tracing_start(void) { }
+static inline void tracing_stop(void) { }
+static inline void trace_dump_stack(int skip) { }
+
+static inline void tracing_on(void) { }
+static inline void tracing_off(void) { }
+static inline int tracing_is_on(void) { return 0; }
+static inline void tracing_snapshot(void) { }
+static inline void tracing_snapshot_alloc(void) { }
+
+static inline __printf(1, 2)
+int trace_printk(const char *fmt, ...)
+{
+	return 0;
+}
+static __printf(1, 0) inline int
+ftrace_vprintk(const char *fmt, va_list ap)
+{
+	return 0;
+}
+static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
+#endif /* CONFIG_TRACING */
+
+#endif
-- 
2.43.0

