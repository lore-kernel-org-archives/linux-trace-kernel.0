Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C633D31E830;
	Sat,  1 Aug 2026 11:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785582071; cv=none; b=dLk7F15I91eSfzVGMl6ildzzomuyeiQ6QqyTw/diRGvXGRysDD6Sso8wZgmq6OJ+Jm8w1zs7CmjP8KPMHWDZljCkePZScSKtBF6FcVUDhqZaKB2mD7FhbFffFc2ig17gpwzZFOxyPsiYb7sF0Z5azscwREO3CaDw0lX1OlcUdIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785582071; c=relaxed/simple;
	bh=eH7MOUuGodxq09rRikBFhUdpvaOczF07qkwIpXsPdnM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bJv4LWnduxfzEyPFK6iujCAXFmBl4gGBs/P3D/AcPqdNRvo/MQ/SClwo96OQDkAvDKKVmTXjPPVFPusG0bvOOWPs5FeZCpPOEb+lkhB8DvSRtXTaUcdFvy5DR1xQFfCm2pE4xkAACh5C78l8SsSIILWMTFaW2gckyRq541DIWgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mavick.dev; spf=pass smtp.mailfrom=mavick.dev; dkim=pass (2048-bit key) header.d=mavick.dev header.i=@mavick.dev header.b=xQS5CzkI; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mavick.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mavick.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mavick.dev header.i=@mavick.dev header.b="xQS5CzkI"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hC0Nf70nBzMlGF;
	Sat, 01 Aug 2026 13:01:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mavick.dev; s=MBO0001;
	t=1785582067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jTMRjFLThSMMc/w3StUWqu1LpTWLAsUOncWy0PHshAk=;
	b=xQS5CzkIcPO109Cb+436Qqh/cxYj3inN1re6Kjq5Boj4l3I1jsOvvNNKHFxwTEa+mnx5YT
	x8s+MjZu0OWymu98RI9/82lzQcCq+5xcpxjoM2ziXjyF6FhkJm3vslJ/Mr9rBm1jxMMFPU
	HNfDwHkPmKwNzJbuXSzQeUPfgKjbDHpJwAQjzOPGqB125yBnQ8tJzMcSotAA5FcPRnveHW
	OiUDYFDo4YJIFn8+mfHqQu+E79pWcbroR1NktHv5qvX+TePUiUdc+DeZRB4PB+1v0Uycg6
	gp3BlzM4yye6JXSBRrlw7mUXCkB4wqZLmBCPZQBorRKi0smgiPiRAjT310k3xA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of m@mavick.dev designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=m@mavick.dev
From: Eugene Mavick <m@mavick.dev>
Date: Sat, 01 Aug 2026 18:59:44 +0800
Subject: [PATCH v4 4/5] kunit: add test for ref_trace_final_put
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260801-refcount-final-put-trace-v4-4-2e58678f0ffd@mavick.dev>
References: <20260801-refcount-final-put-trace-v4-0-2e58678f0ffd@mavick.dev>
In-Reply-To: <20260801-refcount-final-put-trace-v4-0-2e58678f0ffd@mavick.dev>
To: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Boqun Feng <boqun@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Gary Guo <gary@garyguo.net>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Dennis Zhou <dennis@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-mm@kvack.org, Eugene Mavick <m@mavick.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5222; i=m@mavick.dev;
 h=from:subject:message-id; bh=eH7MOUuGodxq09rRikBFhUdpvaOczF07qkwIpXsPdnM=;
 b=owGbwMvMwCU2V/5U3e1aE3/G02pJDFm5Fzd2a7LeeL66USZ99ZaZBwMjjzFOvK/B4bGnofX9+
 Wb+hIspHaUsDGJcDLJiiiw1WQnuGStnJRofndQDM4eVCWQIAxenAExk7TSG36yLF5nvyLvHoHNv
 nZQ0wzRDhdyY6Ih0u79mvhcnaO340cvwv1TgpVYAuwuPSIqFlf4WA7GDt81l+iRYLmrNPH3VJPo
 bHwA=
X-Developer-Key: i=m@mavick.dev; a=openpgp;
 fpr=7C6A604768A99A6133C5928C9D1FCA7EDB7D344F
X-Rspamd-Queue-Id: 4hC0Nf70nBzMlGF

Add a KUnit test suite for the ref_trace_final_put tracepoint.

The test registers a probe function and triggers both refcount_t and
percpu_ref final put paths, verifying that the tracepoint fires
correctly and that the recorded fields match expected values.

Signed-off-by: Eugene Mavick <m@mavick.dev>
---
 lib/Kconfig                 |  10 ++++
 lib/tests/Makefile          |   1 +
 lib/tests/ref_trace_kunit.c | 141 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 152 insertions(+)

diff --git a/lib/Kconfig b/lib/Kconfig
index 00a9509636c1..7e2746be6d16 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -52,6 +52,16 @@ config PACKING_KUNIT_TEST
 
 	  When in doubt, say N.
 
+config REF_TRACE_KUNIT_TEST
+	bool "ref_trace kunit test" if !KUNIT_ALL_TESTS
+	depends on KUNIT && TRACEPOINTS
+	default KUNIT_ALL_TESTS
+	help
+	  This option enables the KUnit test suite for the ref_trace_final_put
+	  tracepoint.
+
+	  If unsure, say N.
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
index 000000000000..17f6936ecc1a
--- /dev/null
+++ b/lib/tests/ref_trace_kunit.c
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
+#include <trace/events/ref_trace.h>
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
+			test, register_trace_ref_trace_final_put(probe, NULL));	\
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
+		unregister_trace_ref_trace_final_put(probe, NULL);		\
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

