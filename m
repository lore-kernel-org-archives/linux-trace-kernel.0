Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EDC225A59;
	Thu, 20 Mar 2025 18:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742494175; cv=none; b=XYAPsM1KQG6D5keRU2PPHtb5KmB3sDPAyX7Adq8Ng+lH8Qyi3+gj77WI61pm8j+znIn0bSaHfimKf5kCFt9+14ZGXmO7PDYVwrMyE2lrBi2mMr1wEcVMNEmSXKu1+q/EJmHSNaPL0cFQhww/TJOOivY4kMx5i5HblUkWbGeUqpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742494175; c=relaxed/simple;
	bh=Nro01uE35mEDJNYyleEIH0iraSqA4MVZyZeU5e/+IW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZQg6igrXhV7LLuUTRljCOipqF4I8UPJJ4C23W3DzpgfcDYkGVakxgX5YqyUqfJtx2clja7QV85i4N/BTwBQt7xAiBR2d5FOPelSfQK4ts4BLaMlai+J2KAE+1ESW6NcDd1XEKTiunBQEqStRwX6KyGxXNFjo+rsoSqGz6iO59Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LgZMTs7z; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LgZMTs7z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742494173; x=1774030173;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nro01uE35mEDJNYyleEIH0iraSqA4MVZyZeU5e/+IW0=;
  b=LgZMTs7ztH2YS4ewUCqnD7Cf3YTJhJNLctdxYxjhj1HdqjV02HY8W4to
   +VwaHbUwjV+E451TnESTxBBo24PpleihmfjmkfVDVIRYx8qRQJxsDU4be
   tLumNSUHVTZ2t3b8un9bhihAqv0GnscoGVNfKTe5fuXP7T7McQJwvbdcc
   UH686xWme+1ZP5ep7YuweIoEHQ6nK35PwcgRT0lK8TqCg3xFvjaw/xhNs
   21hmgDtaZwqE+SZJlO1IDUc2Z0MYUO5PTVm/Zdy7defGEmxPxeHXfw1GL
   CzZVTSy17kvAwrevLxPJJKy5RTflzR3HFc8G7kTmh3AUoQV5m0W0UFeIV
   A==;
X-CSE-ConnectionGUID: 1PPatObcRf+8lNyRo6DWOg==
X-CSE-MsgGUID: T7MDYYK7Q16CK0ObbJ1ULA==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="43913246"
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="43913246"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 11:09:33 -0700
X-CSE-ConnectionGUID: efyg0u4iQ3eSrO4Ws/1T9g==
X-CSE-MsgGUID: 3FFFB2h+StmpcfTXOpUp0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="123140148"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 20 Mar 2025 11:09:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id B5D84747; Thu, 20 Mar 2025 20:09:27 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petr Mladek <pmladek@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Kees Cook <kees@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andy Shevchenko <andy@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v1 3/6] tracing: Mark binary printing functions with __printf() attribute
Date: Thu, 20 Mar 2025 20:04:24 +0200
Message-ID: <20250320180926.4002817-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250320180926.4002817-1-andriy.shevchenko@linux.intel.com>
References: <20250320180926.4002817-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Binary printing functions are using printf() type of format, and compiler
is not happy about them as is:

kernel/trace/trace.c:3292:9: error: function ‘trace_vbprintk’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
kernel/trace/trace_seq.c:182:9: error: function ‘trace_seq_bprintf’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]

Fix the compilation errors by adding __printf() attribute.

While at it, move existing __printf() attributes from the implementations
to the declarations.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/trace_seq.h |  7 ++++---
 kernel/trace/trace.c      |  3 ---
 kernel/trace/trace.h      | 16 +++++++++-------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/linux/trace_seq.h b/include/linux/trace_seq.h
index 1ef95c0287f0..7e69628092e4 100644
--- a/include/linux/trace_seq.h
+++ b/include/linux/trace_seq.h
@@ -88,8 +88,8 @@ extern __printf(2, 3)
 void trace_seq_printf(struct trace_seq *s, const char *fmt, ...);
 extern __printf(2, 0)
 void trace_seq_vprintf(struct trace_seq *s, const char *fmt, va_list args);
-extern void
-trace_seq_bprintf(struct trace_seq *s, const char *fmt, const u32 *binary);
+extern __printf(2, 0)
+void trace_seq_bprintf(struct trace_seq *s, const char *fmt, const u32 *binary);
 extern int trace_print_seq(struct seq_file *m, struct trace_seq *s);
 extern int trace_seq_to_user(struct trace_seq *s, char __user *ubuf,
 			     int cnt);
@@ -113,7 +113,8 @@ static inline __printf(2, 3)
 void trace_seq_printf(struct trace_seq *s, const char *fmt, ...)
 {
 }
-static inline void
+static inline __printf(2, 0)
+void
 trace_seq_bprintf(struct trace_seq *s, const char *fmt, const u32 *binary)
 {
 }
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 0e6d517e74e0..6a29218ca210 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3375,7 +3375,6 @@ __trace_array_vprintk(struct trace_buffer *buffer,
 	return len;
 }
 
-__printf(3, 0)
 int trace_array_vprintk(struct trace_array *tr,
 			unsigned long ip, const char *fmt, va_list args)
 {
@@ -3450,7 +3449,6 @@ int trace_array_init_printk(struct trace_array *tr)
 }
 EXPORT_SYMBOL_GPL(trace_array_init_printk);
 
-__printf(3, 4)
 int trace_array_printk_buf(struct trace_buffer *buffer,
 			   unsigned long ip, const char *fmt, ...)
 {
@@ -3466,7 +3464,6 @@ int trace_array_printk_buf(struct trace_buffer *buffer,
 	return ret;
 }
 
-__printf(2, 0)
 int trace_vprintk(unsigned long ip, const char *fmt, va_list args)
 {
 	return trace_array_vprintk(printk_trace, ip, fmt, args);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 9c21ba45b7af..447d4f2a7fd2 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -836,13 +836,15 @@ static inline void __init disable_tracing_selftest(const char *reason)
 
 extern void *head_page(struct trace_array_cpu *data);
 extern unsigned long long ns2usecs(u64 nsec);
-extern int
-trace_vbprintk(unsigned long ip, const char *fmt, va_list args);
-extern int
-trace_vprintk(unsigned long ip, const char *fmt, va_list args);
-extern int
-trace_array_vprintk(struct trace_array *tr,
-		    unsigned long ip, const char *fmt, va_list args);
+
+__printf(2, 0)
+int trace_vbprintk(unsigned long ip, const char *fmt, va_list args);
+__printf(2, 0)
+int trace_vprintk(unsigned long ip, const char *fmt, va_list args);
+__printf(3, 0)
+int trace_array_vprintk(struct trace_array *tr,
+			unsigned long ip, const char *fmt, va_list args);
+__printf(3, 4)
 int trace_array_printk_buf(struct trace_buffer *buffer,
 			   unsigned long ip, const char *fmt, ...);
 void trace_printk_seq(struct trace_seq *s);
-- 
2.47.2

