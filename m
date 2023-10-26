Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2B23B2A3
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Oct 2023 19:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K/iQtg9c"
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DF71B9
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Oct 2023 12:40:39 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-27d3ede72f6so1082153a91.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Oct 2023 12:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698349239; x=1698954039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gjt0z8KB401ODn/KQpGfh65VQ9DCOj6T2VTgcJAisaU=;
        b=K/iQtg9cc/3l9fzr0Yeblv4umTGFPjbbH/fPCeGKW5ufmdm6eTPUpvz6I1fbiIxxCB
         /h5h2PgtNeohg67Iqn9/7AaIFYsInNy8JbrfpfQZSKJzak9fDMcozWeXWkwNHYiY1Qo4
         Tn93rfRm0IEzPJYyP/R1RtTxgcS3/s5u8hndY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698349239; x=1698954039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gjt0z8KB401ODn/KQpGfh65VQ9DCOj6T2VTgcJAisaU=;
        b=nNSydTzi5Ps85vnZ1ZIbCh/Jkit+vXPvbSc61ppuFYmSEr5rnzqMMCzRWSV69aZAgH
         NKNb8VfAW4opu1Bpz+25/ntiiIIYqpoKVCt559/q/Q7bb6eYjjWWCkAaVGPDLfwhaHVs
         j66kccrzj3Xppdvu/V662D2XxER2WSRKtSAGKZOV4k64UMadEoAXIo7PSE0NqnMVGC9v
         5E7wl9j0D/n4j464WNZdSnixFjGakA5aB9bpIEcbPfQGUG85PDDXpNnIid69dzCaD2Oa
         9VrWuISXJ7BnVmZAtInP5NJeSmZa/3Pmp2Yd4LFKYlSgb+K6yXJkbP1JHP/1xURuW7jc
         oUbw==
X-Gm-Message-State: AOJu0Yw1DjIpoFs8J/H5ihqP9xRJROt4Zee+vpwgX5eYzdPFdkAbb6uk
	yHGixXs0OtUtKE0SbiJZA7kNhQ==
X-Google-Smtp-Source: AGHT+IFPozRjqk4eTroKTzM92AY+aYNqvVn190/wBBcMxFS6ljK2zYGS4IbI0peYiwL15ZsKGpjI2Q==
X-Received: by 2002:a17:90a:f2d4:b0:27c:f845:3e3f with SMTP id gt20-20020a17090af2d400b0027cf8453e3fmr591135pjb.1.1698349238991;
        Thu, 26 Oct 2023 12:40:38 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id rj14-20020a17090b3e8e00b00263dfe9b972sm2014171pjb.0.2023.10.26.12.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 12:40:38 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Kees Cook <keescook@chromium.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	Justin Stitt <justinstitt@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Petr Mladek <pmladek@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Yun Zhou <yun.zhou@windriver.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Zhen Lei <thunder.leizhen@huawei.com>,
	linux-trace-kernel@vger.kernel.org,
	Yosry Ahmed <yosryahmed@google.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] seq_buf: Introduce DECLARE_SEQ_BUF and seq_buf_str()
Date: Thu, 26 Oct 2023 12:40:37 -0700
Message-Id: <20231026194033.it.702-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4617; i=keescook@chromium.org;
 h=from:subject:message-id; bh=QzU6NWc3QjM8fdUO4tKS474/1B+NsO6zg9R0CrHFpJM=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlOsC1kxj4+RmjGClwoE8uk9UJshjZEuNiX1ZS+
 yLTj3vaZbKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZTrAtQAKCRCJcvTf3G3A
 Juj7D/9Q8PtxzOSbHP41qMXdud/3iF/z+PvOOKi/oEONwQhcwL6/oW8digv+UOlsJhVHk08VPqS
 66mtwRVVlCrWC3+eU/5jQgJTYhgKwpA9lnaKRBHhz+OGn+/VflkFKBbrULuQO0K32ZEJb+XVFPV
 xhxO68W1+sS2oFV9YgJxbYrlvNnSaNC0+18lRaFYabrG/3lpFdKFL/SPz7KeIekSmvxO60eZBA0
 D/OGpRMTqh9w400dRdIkLV/rV64Fz2cI3PqhOEWBkjHUYH8VQD5IEnKnhAtYTojP56cqT9l5kav
 Dnj1/7dzoQDS1D3NUuxv4DzBWWgMYKZ7ZOKlyOd3XvhVFiotft68r61bQHuyWM0VFPq1L3iT0Qy
 6PobzBVyvGHTJKwpkhxuEi+9uYH6yfYzhG4xuU7Um2e8xCSRiultRnenx8Pxgkual21gazVya/d
 +FAWdO6UDipc8Lz1VlVDnWBhUahywP6JMpVS/PXg2XSDTJg492tKH3hOmGmfhl1VAhJhqzkcLqD
 wjYepoYfgzdOeuWTtmxzp5B/OF9pkhoXevWsOUOgPVkoyk1kg3O0kYcUBe/vpRvIYcOQp0vkcir
 SI2WejEJ+lej1iSXDl0q05gZ6abepOTI6n9mk2tECFtARKNOnqScu2gAd8TqhhjVEhR+M8k9Cw2
 IwmAlV8 HxEBv7sw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Solve two ergonomic issues with struct seq_buf;

1) Too much boilerplate is required to initialize:

	struct seq_buf s;
	char buf[32];

	seq_buf_init(s, buf, sizeof(buf));

Instead, we can build this directly on the stack. Provide
DECLARE_SEQ_BUF() macro to do this:

	DECLARE_SEQ_BUF(s, 32);

2) %NUL termination is fragile and requires 2 steps to get a valid
   C String (and is a layering violation exposing the "internals" of
   seq_buf):

	seq_buf_terminate(s);
	do_something(s->buffer);

Instead, we can just return s->buffer direction after terminating it
in refactored seq_buf_terminate(), now known as seq_buf_str():

	do_soemthing(seq_buf_str(s));

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Justin Stitt <justinstitt@google.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Yun Zhou <yun.zhou@windriver.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>
Cc: Zhen Lei <thunder.leizhen@huawei.com>
Cc: linux-trace-kernel@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2 - rename seq_buf_cstr() to seq_buf_str() (rostedt)
v1 - https://lore.kernel.org/all/20231026170722.work.638-kees@kernel.org/
---
 include/linux/seq_buf.h | 19 +++++++++++++++----
 kernel/trace/trace.c    | 11 +----------
 lib/seq_buf.c           |  4 +---
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
index 8483e4b2d0d2..71eb4d624308 100644
--- a/include/linux/seq_buf.h
+++ b/include/linux/seq_buf.h
@@ -21,9 +21,16 @@ struct seq_buf {
 	size_t			len;
 };
 
+#define DECLARE_SEQ_BUF(NAME, SIZE)					\
+	char __ ## NAME ## _buffer[SIZE] = "";				\
+	struct seq_buf NAME = { .buffer = &__ ## NAME ## _buffer,	\
+				.size = SIZE }
+
 static inline void seq_buf_clear(struct seq_buf *s)
 {
 	s->len = 0;
+	if (s->size)
+		s->buffer[0] = '\0';
 }
 
 static inline void
@@ -69,8 +76,8 @@ static inline unsigned int seq_buf_used(struct seq_buf *s)
 }
 
 /**
- * seq_buf_terminate - Make sure buffer is nul terminated
- * @s: the seq_buf descriptor to terminate.
+ * seq_buf_str - get %NUL-terminated C string from seq_buf
+ * @s: the seq_buf handle
  *
  * This makes sure that the buffer in @s is nul terminated and
  * safe to read as a string.
@@ -81,16 +88,20 @@ static inline unsigned int seq_buf_used(struct seq_buf *s)
  *
  * After this function is called, s->buffer is safe to use
  * in string operations.
+ *
+ * Returns @s->buf after making sure it is terminated.
  */
-static inline void seq_buf_terminate(struct seq_buf *s)
+static inline char *seq_buf_str(struct seq_buf *s)
 {
 	if (WARN_ON(s->size == 0))
-		return;
+		return "";
 
 	if (seq_buf_buffer_left(s))
 		s->buffer[s->len] = 0;
 	else
 		s->buffer[s->size - 1] = 0;
+
+	return s->buffer;
 }
 
 /**
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index d629065c2383..2539cfc20a97 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3828,15 +3828,6 @@ static bool trace_safe_str(struct trace_iterator *iter, const char *str,
 	return false;
 }
 
-static const char *show_buffer(struct trace_seq *s)
-{
-	struct seq_buf *seq = &s->seq;
-
-	seq_buf_terminate(seq);
-
-	return seq->buffer;
-}
-
 static DEFINE_STATIC_KEY_FALSE(trace_no_verify);
 
 static int test_can_verify_check(const char *fmt, ...)
@@ -3976,7 +3967,7 @@ void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
 		 */
 		if (WARN_ONCE(!trace_safe_str(iter, str, star, len),
 			      "fmt: '%s' current_buffer: '%s'",
-			      fmt, show_buffer(&iter->seq))) {
+			      fmt, seq_buf_str(&iter->seq.seq))) {
 			int ret;
 
 			/* Try to safely read the string */
diff --git a/lib/seq_buf.c b/lib/seq_buf.c
index b7477aefff53..23518f77ea9c 100644
--- a/lib/seq_buf.c
+++ b/lib/seq_buf.c
@@ -109,9 +109,7 @@ void seq_buf_do_printk(struct seq_buf *s, const char *lvl)
 	if (s->size == 0 || s->len == 0)
 		return;
 
-	seq_buf_terminate(s);
-
-	start = s->buffer;
+	start = seq_buf_str(s);
 	while ((lf = strchr(start, '\n'))) {
 		int len = lf - start + 1;
 
-- 
2.34.1

