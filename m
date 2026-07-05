Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A301AAE28;
	Sun,  5 Jul 2026 01:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783214479; cv=none; b=KmHBYNtm3T2q5QovtnJq75tm0Cc2mz1qf4H6o9MER3PQAJ6Xl32YLbpaYMd74wAyX1AcA9RCZzixQ5CXcAwrsoWeCFOcSzdZfdmokutU5KcT9aUSUMultYuT6mDKM5uTK1HGJwHspGu1FoQ9dEnIvteVqOFrmMJoZwSEIEmP3bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783214479; c=relaxed/simple;
	bh=jgQtpd6MTBZlhpzaWZIwUfeA9NemmGYKA+5oRKWQhYE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s29FGjafuliap8ugn/wutQ9DsFiS5FzQgyQ8axSt9dgdkKJBhERG9DioeYRkOIwhjq0vt8w84ubMhB2OVNqjvjMgzHoKMCVYdHkvh37H6zGelEomwDxLfD2oeNNAQaOtwjcFSpGBO6aWkBs+RWKR68Wr5txnF85n8z0NLDg8Wzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTpvx42y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTpvx42y"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F0FDC2BCF5;
	Sun,  5 Jul 2026 01:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783214479;
	bh=jgQtpd6MTBZlhpzaWZIwUfeA9NemmGYKA+5oRKWQhYE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FTpvx42yN3dsLLqcr1XIlaGxqERRJPDSQkiywwuPBZum1yauLTRRU+EPFCZTVW+Ff
	 ke4htacperVpnzsjTxB1HoCEsiWta9g8k458WfvUZ+E2Q52L1gHiNwzKfcqqlaZCOw
	 Ld+HSh4Wh8un4TLJr8AfF2MGNQKah1+917L6nB0NH8exlYiwf5QeW9myvnmfDjdUh7
	 DdM5z4s7gLTPkJne1W7FG6lB5EwF+CAXYsL7FSptnvKSxNQ1F/dbVD6h2/4UiqW1lf
	 QX+mBzuA7jm77Mf7DyFnYg87pdLQPoYcB5BHGnKa4FSXzRBThAA+tTsHV/QRsBojy+
	 SKWBOnyxAn1cw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E12C44503;
	Sun,  5 Jul 2026 01:21:19 +0000 (UTC)
From: Eugene Mavick via B4 Relay <devnull+m.mavick.dev@kernel.org>
Date: Sun, 05 Jul 2026 09:20:54 +0800
Subject: [PATCH 4/4] kunit: add test for ref_trace_final_put
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-refcount-final-put-trace-v1-4-0ae936edb750@mavick.dev>
References: <20260705-refcount-final-put-trace-v1-0-0ae936edb750@mavick.dev>
In-Reply-To: <20260705-refcount-final-put-trace-v1-0-0ae936edb750@mavick.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5737; i=m@mavick.dev;
 h=from:subject:message-id;
 bh=uO0yuH0cgFlwuh+60ouE/XunglpmQTZB7vngb53hITQ=;
 b=owGbwMvMwCU2V/5U3e1aE3/G02pJDFmeGyvPXt0ov/zIZLkvsSpSZaK2yn6W7NL+j3uebOXjS
 NB8e5a1o5SFQYyLQVZMkaUmK8E9Y+WsROOjk3pg5rAygQxh4OIUgIlc4mT4n/ev8e3l7Q7mn3n4
 TtkWtG79vqO8W5zX7lC0RpbL7/elFowM9zpqgzZZJD5Sln3/3OSYQe5KM7++F/d3hz/g2+P51Da
 MFwA=
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
 MAINTAINERS                 |   1 +
 lib/Kconfig                 |  10 ++++
 lib/tests/Makefile          |   1 +
 lib/tests/ref_trace_kunit.c | 138 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 150 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8dab37726b9d..7c387ed746ee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4213,6 +4213,7 @@ F:	include/*/atomic*.h
 F:	include/linux/ref_trace.h
 F:	include/linux/refcount.h
 F:	lib/ref_trace.h
+F:	lib/tests/ref_trace_kunit.c
 F:	scripts/atomic/
 F:	rust/kernel/sync/atomic.rs
 F:	rust/kernel/sync/atomic/
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
index 000000000000..2ece6c840fe0
--- /dev/null
+++ b/lib/tests/ref_trace_kunit.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kernel.h>
+#include <kunit/test.h>
+#include <linux/wait_bit.h>
+#include <linux/instruction_pointer.h>
+#include <linux/kallsyms.h>
+#include <linux/percpu-refcount.h>
+#include <linux/refcount.h>
+#include <trace/events/ref_trace.h>
+
+struct data {
+	unsigned long caller;
+	const char *fn;
+	const void *obj;
+	int *flag;
+	struct kunit *test;
+};
+
+struct data refc_chk;
+struct data pcpu_chk;
+
+//called when tracepoint fires
+static void probe(
+	  void *ignore,
+	  unsigned long caller,
+	  const char *fn,
+	  const void *obj)
+{
+	struct data *chk_val;
+
+	char func_name[KSYM_SYMBOL_LEN];
+
+	sprint_symbol_no_offset(func_name, caller);
+
+	if (!strcmp(func_name, "test_refcount")) {
+		chk_val = &refc_chk;
+		KUNIT_EXPECT_FALSE(chk_val->test, memcmp(obj, chk_val->obj, sizeof(refcount_t)));
+	} else if (!strcmp(func_name, "test_percpu")) {
+		chk_val = &pcpu_chk;
+		KUNIT_EXPECT_FALSE(chk_val->test, memcmp(
+			obj, chk_val->obj, sizeof(struct percpu_ref)));
+	} else {
+		//non test function origin trace events
+		return;
+	}
+
+	struct kunit *test = chk_val->test;
+	int *flag = chk_val->flag;
+
+	//ensure past flag writes are done before reading
+	KUNIT_EXPECT_EQ(test, 1, smp_load_acquire(flag));
+	KUNIT_EXPECT_EQ(test, caller, chk_val->caller);
+
+	smp_store_release(flag, 0); //signal probe completion
+}
+
+
+
+static void test_refcount(struct kunit *test)
+{
+	refcount_t refc;
+	int flag_addr = 0;
+
+	refc_chk.caller = (unsigned long)&test_refcount;
+	refc_chk.fn = "__refcount_sub_and_test";
+	refc_chk.obj = &refc;
+	refc_chk.flag = &flag_addr;
+	refc_chk.test = test;
+
+	int *flag = refc_chk.flag;
+
+	KUNIT_EXPECT_FALSE(test, register_trace_ref_trace_final_put(probe, NULL));
+
+	refcount_set(&refc, 2);
+
+	KUNIT_EXPECT_FALSE(test, refcount_dec_and_test(&refc));
+
+	smp_store_release(flag, 1); //signal final put can happen
+
+	KUNIT_EXPECT_TRUE(test, refcount_dec_and_test(&refc));
+
+	wait_var_event(flag, smp_load_acquire(flag)); //wait for probe completion
+	unregister_trace_ref_trace_final_put(probe, NULL);
+}
+
+static void dummy_release(struct percpu_ref *ref) {}
+
+static void test_percpu(struct kunit *test)
+{
+	struct percpu_ref pcpu_ref;
+
+	int flag_addr = 1;
+
+	pcpu_chk.caller = (unsigned long)&test_percpu;
+	pcpu_chk.fn = "percpu_ref_put_many";
+	pcpu_chk.obj = &pcpu_ref;
+	pcpu_chk.flag = &flag_addr;
+	pcpu_chk.test = test;
+
+	int *flag = pcpu_chk.flag;
+
+	KUNIT_EXPECT_FALSE(test, register_trace_ref_trace_final_put(probe, NULL));
+
+	KUNIT_EXPECT_FALSE(test, percpu_ref_init(&pcpu_ref, dummy_release, 0, GFP_KERNEL));
+
+	percpu_ref_get(&pcpu_ref);
+	percpu_ref_get(&pcpu_ref);
+
+	percpu_ref_put(&pcpu_ref);
+	percpu_ref_put(&pcpu_ref);
+
+	percpu_ref_switch_to_atomic_sync(&pcpu_ref);
+
+	smp_store_release(flag, 1); //signal final put can happen
+
+	percpu_ref_put(&pcpu_ref);
+
+	wait_var_event(flag, smp_load_acquire(flag)); //wait for probe completion
+	unregister_trace_ref_trace_final_put(probe, NULL);
+	percpu_ref_exit(&pcpu_ref);
+}
+
+static struct kunit_case __refdata ref_trace_test_cases[] = {
+	KUNIT_CASE(test_refcount),
+	KUNIT_CASE(test_percpu),
+	{}
+};
+
+static struct kunit_suite ref_trace_test_suite = {
+	.name = "ref-trace",
+	.test_cases = ref_trace_test_cases,
+};
+
+kunit_test_suites(&ref_trace_test_suite);
+
+MODULE_AUTHOR("Eugene Mavick <m@mavick.dev>");
+MODULE_DESCRIPTION("KUnit test for ref_trace");
+MODULE_LICENSE("GPL");

-- 
2.51.2


