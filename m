Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CCB379C2A;
	Fri, 10 Jul 2026 05:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783661476; cv=none; b=dU46q1x9Hy9hRRdSaQw/kaNDDfcg5z+8TXBXZVc/BSQQOB0RRZz4hhenZhTDUGzPB01rsEyckmDkdeOeg48mf0JbOd5O4wdrPI18ejZ4Wm/+MxAo6//g6pQOOGYdB6WeUAXpqRWumqJo31mnyH6XNb9kI/nXAEKinIhJC1oPBNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783661476; c=relaxed/simple;
	bh=hYItlIxI3TFxH56tjyUfH5lTleoN/4M0MjnyxZ2eCSw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LCqPxqU+sIbsWYUJU10SULv943cc5F+Bdb1XcVqIxV0e6TeZrX4vzmo9Kg2ZaEA+8PuyM5kbOYktj4YZF+RD3T4a0FWmKTIqveO0BdHp1GqRLUHSIzeBefcpa8DWIV6N4uLIZ/lro6vEVrkQeI+5/VQvnKjL8lUfU7ogi899ZEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l65Scuad; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l65Scuad"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34CBCC2BCFB;
	Fri, 10 Jul 2026 05:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783661476;
	bh=hYItlIxI3TFxH56tjyUfH5lTleoN/4M0MjnyxZ2eCSw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=l65ScuadIrCDCzyddzFeUgvv1Sxf2QFAxdvh+6epe1m+3ntxxcipFUji0CHV7n13f
	 e2X7H0WyQSX+dI95L/fe1pz7Sk1k7gQfxtETgDN1xMoTyq1DPv6fTVJwWO/E6ZND4G
	 c/Of4WSTzT0ASWATk1kCH+EFISLrG3ZQt7J5XV6ROdSxDTLHSAxldCsLKix70ePI3n
	 qRZgRVflHgR1HpWq5JW6T3HjdcWpTydbZAP/ZDJbFV4/IaRWsAcreUFzhYv51uDSqK
	 2KceLTGKkQU31pb/edjGPJPbkrdL+Rlpo6zbvjZg/pFvRUfOtsJxIwCizfF4V4UcwB
	 s7xMK6KVmo8fA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20261C44509;
	Fri, 10 Jul 2026 05:31:16 +0000 (UTC)
From: Eugene Mavick via B4 Relay <devnull+m.mavick.dev@kernel.org>
Date: Fri, 10 Jul 2026 13:30:42 +0800
Subject: [PATCH v2 4/5] kunit: add test for ref_trace_final_put
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-refcount-final-put-trace-v2-4-557cfce860a2@mavick.dev>
References: <20260710-refcount-final-put-trace-v2-0-557cfce860a2@mavick.dev>
In-Reply-To: <20260710-refcount-final-put-trace-v2-0-557cfce860a2@mavick.dev>
To: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Boqun Feng <boqun@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Gary Guo <gary@garyguo.net>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Dennis Zhou <dennis@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-mm@kvack.org, Eugene Mavick <m@mavick.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5506; i=m@mavick.dev;
 h=from:subject:message-id;
 bh=/9Dev+Y5OluuMZTbdCo5lc9tYCtS2UAK0B+nMvLxkRA=;
 b=owGbwMvMwCU2V/5U3e1aE3/G02pJDFkBzT3XlnTrxwqYtC050Bi7wWrFRla/teG+d+LXfH/vu
 Dqtwzezo5SFQYyLQVZMkaUmK8E9Y+WsROOjk3pg5rAygQxh4OIUgInkyzH80137etGuGXom334l
 7cxMMWp0jt3csPWciFXil8ULhTO3iTEyvLTfz7vtbLpA+bapb3MeeP01j1aqVvzZeJ4t8WJ0Ue4
 HfgA=
X-Developer-Key: i=m@mavick.dev; a=openpgp;
 fpr=7C6A604768A99A6133C5928C9D1FCA7EDB7D344F
X-Endpoint-Received: by B4 Relay for m@mavick.dev/default with auth_id=850
X-Original-From: Eugene Mavick <m@mavick.dev>
Reply-To: m@mavick.dev

From: Eugene Mavick <m@mavick.dev>

Add a KUnit test suite for the ref_trace_final_put tracepoint.

The test registers a probe function and triggers both refcount_t and
percpu_ref final put paths, verifying that the tracepoint fires
correctly and that the recorded fields match expected values.

Signed-off-by: Eugene Mavick <m@mavick.dev>
---
v2:
-fix v1 bug where test gave consistent false pass
-make probe minimal, and only check obj and store the values
-add test_init macro to register and reset count
-move value checking to new test_exit macro
-move MAINTAINERS file entries to new MAINTAINERS commit
-v1:https://lore.kernel.org/all/20260705-refcount-final-put-trace-v1-4-cdd0014626a9@mavick.dev/
---
 lib/Kconfig                 |  10 ++++
 lib/tests/Makefile          |   1 +
 lib/tests/ref_trace_kunit.c | 136 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 147 insertions(+)

diff --git a/lib/Kconfig b/lib/Kconfig
index 00a9509636c1..c29b2ccb3c31 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -52,6 +52,16 @@ config PACKING_KUNIT_TEST
 
 	  When in doubt, say N.
 
+config REF_TRACE_KUNIT_TEST
+	bool "ref_trace kunit test" if !KUNIT_ALL_TESTS
+	depends on KUNIT && FTRACE
+	default KUNIT_ALL_TESTS
+	help
+	  This option enables the KUnit test suite for the ref_trace_final_put
+	  tracepoint.
+
+	  If unsure, say N
+
 config BITREVERSE
 	tristate
 
diff --git a/lib/tests/Makefile b/lib/tests/Makefile
index 7e9c2fa52e35..828a030ad8c7 100644
--- a/lib/tests/Makefile
+++ b/lib/tests/Makefile
@@ -57,5 +57,6 @@ obj-$(CONFIG_USERCOPY_KUNIT_TEST) += usercopy_kunit.o
 obj-$(CONFIG_UTIL_MACROS_KUNIT) += util_macros_kunit.o
 obj-$(CONFIG_RATELIMIT_KUNIT_TEST) += test_ratelimit.o
 obj-$(CONFIG_UUID_KUNIT_TEST) += uuid_kunit.o
+obj-$(CONFIG_REF_TRACE_KUNIT_TEST) += ref_trace_kunit.o
 
 obj-$(CONFIG_TEST_RUNTIME_MODULE)		+= module/
diff --git a/lib/tests/ref_trace_kunit.c b/lib/tests/ref_trace_kunit.c
new file mode 100644
index 000000000000..5c7e9d29a030
--- /dev/null
+++ b/lib/tests/ref_trace_kunit.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kernel.h>
+#include <kunit/test.h>
+#include <linux/compiler_attributes.h>
+#include <linux/wait_bit.h>
+#include <linux/instruction_pointer.h>
+#include <linux/kallsyms.h>
+#include <linux/percpu-refcount.h>
+#include <linux/refcount.h>
+#include <linux/types.h>
+#include <linux/atomic.h>
+#include <trace/events/ref_trace.h>
+
+struct data {
+	unsigned long caller;
+	const char *fn;
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
+			test, register_trace_ref_trace_final_put(probe, NULL));	\
+										\
+		atomic_set_release(&capture.count, 0);				\
+										\
+		chk_obj = &obj;							\
+	} while (0)
+
+
+#define test_exit(func_name)							\
+	do {									\
+		/* wait for probe completion */					\
+		wait_var_event(							\
+			&capture.count,						\
+			atomic_read_acquire(&capture.count) != 0);		\
+										\
+		unregister_trace_ref_trace_final_put(probe, NULL);		\
+										\
+		KUNIT_EXPECT_EQ(test, atomic_read_acquire(&capture.count), 1);	\
+		/*								\
+		 * caller testing may be flaky					\
+		 * due to compile optimisations so omit				\
+		 */								\
+		KUNIT_EXPECT_STREQ(test, capture.fn, #func_name);		\
+		KUNIT_EXPECT_PTR_EQ(test, capture.obj, &obj);			\
+	} while (0)
+
+static void probe(
+	  void *ignore,
+	  unsigned long caller,
+	  const char *fn,
+	  const void *obj)
+{
+	//prevent non test func final_puts from changing captured values
+	if (chk_obj != obj)
+		return;
+
+	capture.caller = caller;	
+	capture.fn = fn;	
+	capture.obj = obj;	
+
+	atomic_inc_return_release(&capture.count); //increase count
+}
+
+static noinline void test_refcount_sub_and_test(struct kunit *test)
+{
+	refcount_t obj;
+
+	test_init();
+	refcount_set(&obj, 2);
+
+	KUNIT_EXPECT_FALSE(test, refcount_dec_and_test(&obj));
+	KUNIT_EXPECT_TRUE(test, refcount_dec_and_test(&obj));
+
+	test_exit(__refcount_sub_and_test);
+}
+
+static __always_inline void test_refcount_dec_if_one(struct kunit *test)
+{
+	refcount_t obj;
+
+	test_init();
+	refcount_set(&obj, 2);
+
+	KUNIT_EXPECT_FALSE(test, refcount_dec_and_test(&obj));
+	KUNIT_EXPECT_TRUE(test, refcount_dec_if_one(&obj));
+
+	test_exit(refcount_dec_if_one);
+}
+static void dummy_release(struct percpu_ref *ref) {}
+
+static noinline void test_percpu_ref_put_many(struct kunit *test)
+{
+	struct percpu_ref obj;
+
+	test_init();
+
+	KUNIT_EXPECT_FALSE(test, percpu_ref_init(&obj, dummy_release, 0, GFP_KERNEL));
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
+	test_exit(percpu_ref_put_many);
+	percpu_ref_exit(&obj);
+}
+
+static struct kunit_case __refdata ref_trace_test_cases[] = {
+	KUNIT_CASE(test_refcount_sub_and_test),
+	KUNIT_CASE(test_refcount_dec_if_one),
+	KUNIT_CASE(test_percpu_ref_put_many),
+	{}
+};
+
+static struct kunit_suite ref_trace_test_suite = {
+	.name = "ref-trace",
+	.test_cases = ref_trace_test_cases
+};
+
+kunit_test_suites(&ref_trace_test_suite);
+
+MODULE_AUTHOR("Eugene Mavick <m@mavick.dev>");
+MODULE_DESCRIPTION("KUnit test for ref_trace");
+MODULE_LICENSE("GPL");

-- 
2.51.2


