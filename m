Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F6633E34E;
	Thu, 13 Aug 2026 03:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786593060; cv=none; b=qBqJ5ps6ncSVsb6A5mbUvj0Y23Bzi2MIyEz8YlQJvOaG02ox5iuv0HtgiB9qUImcfgsjC9cNZJ1GPFAUabP+jghbyV/e4RrFetUgIVFMIhWFlq8X7UE4tMkafHcsdOkHXc6IQ/Y9ghDufdtRlYRiZwK97c/ff5WeoMBebCOYUfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786593060; c=relaxed/simple;
	bh=NWF4Jo4Ftrstc2NjsEJ9G79wJ3MSn8vYx7m8NL0MlZU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pRc4mWG7+TICF70UGiMhG0T1HWY2AbU0CJuuA4gTYuWP/d56BiP1NECADPkm8b95P6FX+EJqzps1b+EuEiiQHdPre5TdG/A0Cgxr4EszaupMZbepj0wDE3XnaQXDS9J0ybnbkggFbRDjbewGqr/5J0lAmU/rpgq0pfKaaA6H/iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mavick.dev; spf=pass smtp.mailfrom=mavick.dev; dkim=pass (2048-bit key) header.d=mavick.dev header.i=@mavick.dev header.b=TZnbSlZy; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mavick.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mavick.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mavick.dev header.i=@mavick.dev header.b="TZnbSlZy"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hLBGl3g1tzMlLg;
	Thu, 13 Aug 2026 05:50:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mavick.dev; s=MBO0001;
	t=1786593055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=erDbb09ucbowlxh+KqIe/GemWupH5L/Xw8pXiywX4aU=;
	b=TZnbSlZy7HIOS8R8ZtKog7gJNViTtXeo/MPHBlX60HXcjV7GAOcyfS9aQKirBkB+91lkav
	wdg8opz1yyEhh/JtOpRDQmBbm+NBSWaJuG28GTwUs4XvNRgdhbqIPJloN4C3SlVw+JhNn0
	24/mx0S2n8BC1WP0cdH+gHy1928bZplm2D5JNkbTN9tj+sF+dNBTgUpRuYmSrPbdqsi5Eu
	/U/8fm8gKxM+HBFTrRWJ+VPYbtK5kIuFSW5BK87BsSHFIulOwHrZ6kA6FT80W4zKKjzwMJ
	DIpfWfWW4njO4lEnCKCriDtWE4qN5h5WwV15W5eESREiXbAwdWHY+FekY7Ax/Q==
From: Eugene Mavick <m@mavick.dev>
Date: Thu, 13 Aug 2026 11:49:10 +0800
Subject: [PATCH v5 4/5] kunit: add test for refcount_final_put
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-refcount-final-put-trace-v5-4-6e8bf8a38b31@mavick.dev>
References: <20260813-refcount-final-put-trace-v5-0-6e8bf8a38b31@mavick.dev>
In-Reply-To: <20260813-refcount-final-put-trace-v5-0-6e8bf8a38b31@mavick.dev>
To: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Boqun Feng <boqun@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Gary Guo <gary@garyguo.net>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Dennis Zhou <dennis@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, 
 Dmitry Vyukov <dvyukov@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
 Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-mm@kvack.org, kasan-dev@googlegroups.com, 
 Eugene Mavick <m@mavick.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5310; i=m@mavick.dev;
 h=from:subject:message-id; bh=NWF4Jo4Ftrstc2NjsEJ9G79wJ3MSn8vYx7m8NL0MlZU=;
 b=kA0DAAoWnR/Kftt9NE8ByyZiAGp9PsHI80dHxtCLyQgRi2utuXrj/DrJAEEYHmKk0Ar8vJSYD
 oh1BAAWCgAdFiEEfGpgR2ipmmEzxZKMnR/Kftt9NE8FAmp9PsEACgkQnR/Kftt9NE8TpAD/TJ6T
 /Xft03kCAMYvjSLws92XtG6nUkPg2Ko2+XTnBc4A/ikVItApitgXnzGR+92IsQG0l48gW0o+Jdy
 x9AXn1jMB
X-Developer-Key: i=m@mavick.dev; a=openpgp;
 fpr=7C6A604768A99A6133C5928C9D1FCA7EDB7D344F

Add a KUnit test suite for the refcount_final_put tracepoint.

The test registers a probe function and triggers both refcount_t and
percpu_ref final put paths, verifying that the tracepoint fires
correctly and that the recorded fields match expected values.

Signed-off-by: Eugene Mavick <m@mavick.dev>
---
 lib/Kconfig                      |  10 +++
 lib/tests/Makefile               |   1 +
 lib/tests/refcount_trace_kunit.c | 141 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 152 insertions(+)

diff --git a/lib/Kconfig b/lib/Kconfig
index 12bc59515a3e..ee12e8f95158 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -60,6 +60,16 @@ config REFCOUNT_TRACE_FINAL_PUT
 
 	  If unsure, say N.
 
+config REFCOUNT_TRACE_KUNIT_TEST
+	tristate "refcount trace kunit test" if !KUNIT_ALL_TESTS
+	depends on REFCOUNT_TRACE_FINAL_PUT && KUNIT && TRACEPOINTS
+	default KUNIT_ALL_TESTS
+	help
+	  This option enables the KUnit test suite for the refcount_final_put
+	  tracepoint.
+
+	  If unsure, say N.
+
 config BITREVERSE
 	tristate
 
diff --git a/lib/tests/Makefile b/lib/tests/Makefile
index 7e9c2fa52e35..1ef41c0b6a0c 100644
--- a/lib/tests/Makefile
+++ b/lib/tests/Makefile
@@ -57,5 +57,6 @@ obj-$(CONFIG_USERCOPY_KUNIT_TEST) += usercopy_kunit.o
 obj-$(CONFIG_UTIL_MACROS_KUNIT) += util_macros_kunit.o
 obj-$(CONFIG_RATELIMIT_KUNIT_TEST) += test_ratelimit.o
 obj-$(CONFIG_UUID_KUNIT_TEST) += uuid_kunit.o
+obj-$(CONFIG_REFCOUNT_TRACE_KUNIT_TEST) += refcount_trace_kunit.o
 
 obj-$(CONFIG_TEST_RUNTIME_MODULE)		+= module/
diff --git a/lib/tests/refcount_trace_kunit.c b/lib/tests/refcount_trace_kunit.c
new file mode 100644
index 000000000000..a57e9e4cfa42
--- /dev/null
+++ b/lib/tests/refcount_trace_kunit.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kernel.h>
+#include <kunit/test.h>
+#include <linux/compiler_attributes.h>
+#include <linux/wait_bit.h>
+#include <linux/instruction_pointer.h>
+#include <linux/kallsyms.h>
+#include <linux/jiffies.h>
+#include <linux/percpu-refcount.h>
+#include <linux/refcount.h>
+#include <linux/types.h>
+#include <linux/atomic.h>
+#include <trace/events/refcount.h>
+
+struct data {
+	unsigned long caller;
+	unsigned long ip;
+	const void *obj;
+	atomic_t count;
+};
+
+struct data capture;
+
+const void *chk_obj;
+
+#define test_init()								\
+	do {									\
+		KUNIT_EXPECT_FALSE(						\
+			test, register_trace_refcount_final_put(probe, NULL));	\
+										\
+		atomic_set_release(&capture.count, 0);				\
+										\
+		chk_obj = &obj;							\
+	} while (0)
+
+
+#define test_exit()								\
+	do {									\
+		/* wait for probe completion */					\
+		int notimeout = wait_var_event_timeout(				\
+			&capture.count,						\
+			atomic_read_acquire(&capture.count),			\
+			msecs_to_jiffies(10000)					\
+		);								\
+										\
+		unregister_trace_refcount_final_put(probe, NULL);		\
+		tracepoint_synchronize_unregister();				\
+										\
+		KUNIT_ASSERT_TRUE(test, notimeout);				\
+										\
+		KUNIT_EXPECT_EQ(test, atomic_read_acquire(&capture.count), 1);	\
+										\
+		KUNIT_EXPECT_TRUE(test, __kernel_text_address(capture.caller));	\
+		KUNIT_EXPECT_TRUE(test, __kernel_text_address(capture.ip));	\
+										\
+		KUNIT_EXPECT_PTR_EQ(test, capture.obj, &obj);			\
+	} while (0)
+
+static void probe(
+	  void *ignore,
+	  unsigned long caller,
+	  unsigned long ip,
+	  const void *obj)
+{
+	//prevent non test func final_puts from changing captured values
+	if (chk_obj != obj)
+		return;
+
+	capture.caller = caller;
+	capture.ip = ip;
+	capture.obj = obj;
+
+	atomic_inc_return_release(&capture.count); //increase count
+}
+
+static void test_refcount_sub_and_test(struct kunit *test)
+{
+	refcount_t obj;
+
+	test_init();
+	refcount_set(&obj, 2);
+
+	KUNIT_EXPECT_FALSE(test, refcount_dec_and_test(&obj));
+	KUNIT_EXPECT_TRUE(test, refcount_dec_and_test(&obj));
+
+	test_exit();
+}
+
+static void test_refcount_dec_if_one(struct kunit *test)
+{
+	refcount_t obj;
+
+	test_init();
+	refcount_set(&obj, 2);
+
+	KUNIT_EXPECT_FALSE(test, refcount_dec_and_test(&obj));
+	KUNIT_EXPECT_TRUE(test, refcount_dec_if_one(&obj));
+
+	test_exit();
+}
+static void dummy_release(struct percpu_ref *ref) {}
+
+static void test_percpu_ref_put_many(struct kunit *test)
+{
+	struct percpu_ref obj;
+
+	test_init();
+
+	KUNIT_ASSERT_FALSE(test, percpu_ref_init(&obj, dummy_release, 0, GFP_KERNEL));
+
+	percpu_ref_get(&obj);
+	percpu_ref_get(&obj);
+
+	percpu_ref_put(&obj);
+	percpu_ref_put(&obj);
+
+	percpu_ref_switch_to_atomic_sync(&obj);
+
+	percpu_ref_put(&obj);
+
+	test_exit();
+	percpu_ref_exit(&obj);
+}
+
+static struct kunit_case refcount_trace_test_cases[] = {
+	KUNIT_CASE(test_refcount_sub_and_test),
+	KUNIT_CASE(test_refcount_dec_if_one),
+	KUNIT_CASE(test_percpu_ref_put_many),
+	{}
+};
+
+static struct kunit_suite refcount_trace_test_suite = {
+	.name = "refcount-trace",
+	.test_cases = refcount_trace_test_cases
+};
+
+kunit_test_suites(&refcount_trace_test_suite);
+
+MODULE_AUTHOR("Eugene Mavick <m@mavick.dev>");
+MODULE_DESCRIPTION("KUnit test for ref_trace");
+MODULE_LICENSE("GPL");

-- 
2.51.2

