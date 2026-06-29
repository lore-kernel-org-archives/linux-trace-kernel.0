Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5623F7ABC
	for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jun 2026 08:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782722249; cv=none; b=ByGP+M0HOY+J5/sADqY1dU8GWqv7EnUKcBJxwVHYbw9bQdt2vbQXD+WXVUMK/yl9whiF3hLGoskvn3KWSRmeQjbqxp7h+U6scxNXwwqrKMQN54zOLRRJpWRHDwSYKSU7qRxnCzkQyeahHr5fwFRux/bb9dK7cxgxEsDGNzJ0il0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782722249; c=relaxed/simple;
	bh=A7e+0+H4APWJpzUDZsaZDpFQQHauBTnyxLLAznfU0OQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=muRtXnnXwuVM5/If6/FELfgZQ7wyewY5Zm2voqg61FmAOZvvE9TKlyG5HnMo1kYWioYlYbMV14WV11hMI0rfqgdNCmF7fB+wNkHxG1LlSRxsRIyExL1S2G8xEm9lXyphT8s0AJTAQ0/FWaE0cSNINGlue2IWEqaD+MU6Ovkwz7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mvtb30s+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mvtb30s+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782722246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OjDDAXDHlCvbTiHeVQm1rhnrTo45tpHPYvEhuWzQ8y0=;
	b=Mvtb30s+KCrHdKAXpqhw1eg+EQgBLcnM5BlzDGqi2dVCoB3d6SNtHKW9pFJ+mdxgnSeC0M
	LgB7pgrz1DpyBGLqa/cJS27f6UO1JPOZf9HBamefSJS2d4NGvC80OLa4NSzsp0YQcqzXAu
	1YbSqjgX4UWo9mZdH/NtPrVukxLDoPY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-380-rgqk11_pN6W1mIl5yMiZnw-1; Mon,
 29 Jun 2026 04:37:23 -0400
X-MC-Unique: rgqk11_pN6W1mIl5yMiZnw-1
X-Mimecast-MFC-AGG-ID: rgqk11_pN6W1mIl5yMiZnw_1782722242
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2EFB7180044D;
	Mon, 29 Jun 2026 08:37:22 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.109])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D21143652A;
	Mon, 29 Jun 2026 08:37:19 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: [PATCH 2/4] rtla: Add unit tests for unset in opt callbacks
Date: Mon, 29 Jun 2026 10:36:52 +0200
Message-ID: <20260629083654.1548925-2-tglozar@redhat.com>
In-Reply-To: <20260629083654.1548925-1-tglozar@redhat.com>
References: <20260629083654.1548925-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: k7CSSFrBRE3bqbWgg4ENcreWltI3p4JIAf2t7XxxbdY_1782722242
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Test for each opt callback that implements the unset option whether the
option sets the specified default value back correctly.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 .../rtla/tests/unit/cli_opt_callback.c        | 295 ++++++++++++++++++
 1 file changed, 295 insertions(+)

diff --git a/tools/tracing/rtla/tests/unit/cli_opt_callback.c b/tools/tracing/rtla/tests/unit/cli_opt_callback.c
index 4a406af42821b..413a04f898fbb 100644
--- a/tools/tracing/rtla/tests/unit/cli_opt_callback.c
+++ b/tools/tracing/rtla/tests/unit/cli_opt_callback.c
@@ -40,6 +40,30 @@ START_TEST(test_opt_llong_callback_min)
 }
 END_TEST
 
+START_TEST(test_opt_llong_callback_unset)
+{
+	long long test_value = 0;
+	const struct option opt = TEST_CALLBACK(&test_value, opt_llong_callback);
+
+	ck_assert_int_eq(opt_llong_callback(&opt, "1234567890", 0), 0);
+	ck_assert_int_eq(opt_llong_callback(&opt, NULL, 1), 0);
+	ck_assert_int_eq(test_value, 0);
+}
+END_TEST
+
+START_TEST(test_opt_llong_callback_unset_defval)
+{
+	long long test_value = 0;
+	const long long default_value = 42;
+	const struct option opt = RTLA_OPT_LLONG_DEFVAL('t', "test", &test_value, "test value",
+							"test help", &default_value);
+
+	ck_assert_int_eq(opt_llong_callback(&opt, "1234567890", 0), 0);
+	ck_assert_int_eq(opt_llong_callback(&opt, NULL, 1), 0);
+	ck_assert_int_eq(test_value, default_value);
+}
+END_TEST
+
 START_TEST(test_opt_int_callback_simple)
 {
 	int test_value = 0;
@@ -90,6 +114,29 @@ START_TEST(test_opt_int_callback_non_numeric_suffix)
 }
 END_TEST
 
+START_TEST(test_opt_int_callback_unset)
+{
+	int test_value = 0;
+	const struct option opt = TEST_CALLBACK(&test_value, opt_int_callback);
+
+	ck_assert_int_eq(opt_int_callback(&opt, "1234567890", 0), 0);
+	ck_assert_int_eq(opt_int_callback(&opt, NULL, 1), 0);
+	ck_assert_int_eq(test_value, 0);
+}
+END_TEST
+
+START_TEST(test_opt_int_callback_unset_defval)
+{
+	int test_value = 0;
+	const struct option opt = RTLA_OPT_INT_DEFVAL('t', "test", &test_value, "test value",
+						      "test help", 42);
+
+	ck_assert_int_eq(opt_int_callback(&opt, "1234567890", 0), 0);
+	ck_assert_int_eq(opt_int_callback(&opt, NULL, 1), 0);
+	ck_assert_int_eq(test_value, 42);
+}
+END_TEST
+
 START_TEST(test_opt_cpus_cb)
 {
 	struct common_params params = {0};
@@ -134,6 +181,18 @@ START_TEST(test_opt_cgroup_cb_equals)
 }
 END_TEST
 
+START_TEST(test_opt_cgroup_cb_unset)
+{
+	struct common_params params = {0};
+	const struct option opt = TEST_CALLBACK(&params, opt_cgroup_cb);
+
+	ck_assert_int_eq(opt_cgroup_cb(&opt, "cgroup", 0), 0);
+	ck_assert_int_eq(opt_cgroup_cb(&opt, NULL, 1), 0);
+	ck_assert_int_eq(params.cgroup, 0);
+	ck_assert_ptr_null(params.cgroup_name);
+}
+END_TEST
+
 START_TEST(test_opt_duration_cb)
 {
 	struct common_params params = {0};
@@ -154,6 +213,17 @@ START_TEST(test_opt_duration_cb_invalid)
 }
 END_TEST
 
+START_TEST(test_opt_duration_cb_unset)
+{
+	struct common_params params = {0};
+	const struct option opt = TEST_CALLBACK(&params, opt_duration_cb);
+
+	ck_assert_int_eq(opt_duration_cb(&opt, "1m", 0), 0);
+	ck_assert_int_eq(opt_duration_cb(&opt, NULL, 1), 0);
+	ck_assert_int_eq(params.duration, 0);
+}
+END_TEST
+
 START_TEST(test_opt_event_cb)
 {
 	struct trace_events *events = NULL;
@@ -205,6 +275,19 @@ START_TEST(test_opt_housekeeping_cb_invalid)
 }
 END_TEST
 
+START_TEST(test_opt_housekeeping_cb_unset)
+{
+	struct common_params params = {0};
+	const struct option opt = TEST_CALLBACK(&params, opt_housekeeping_cb);
+
+	nr_cpus = 4;
+	ck_assert_int_eq(opt_housekeeping_cb(&opt, "0-3", 0), 0);
+	ck_assert_int_eq(opt_housekeeping_cb(&opt, NULL, 1), 0);
+	ck_assert_int_eq(params.hk_cpus, 0);
+	ck_assert_int_eq(CPU_COUNT(&params.hk_cpu_set), 0);
+}
+END_TEST
+
 START_TEST(test_opt_priority_cb)
 {
 	struct common_params params = {0};
@@ -226,6 +309,18 @@ START_TEST(test_opt_priority_cb_invalid)
 }
 END_TEST
 
+START_TEST(test_opt_priority_cb_unset)
+{
+	struct common_params params = {0};
+	const struct option opt = TEST_CALLBACK(&params, opt_priority_cb);
+
+	ck_assert_int_eq(opt_priority_cb(&opt, "f:95", 0), 0);
+	ck_assert_int_eq(opt_priority_cb(&opt, NULL, 1), 0);
+	ck_assert_int_eq(params.sched_param.sched_policy, 0);
+	ck_assert_int_eq(params.sched_param.sched_priority, 0);
+}
+END_TEST
+
 START_TEST(test_opt_trigger_cb)
 {
 	struct trace_events *events = trace_event_alloc("sched:sched_switch");
@@ -279,6 +374,20 @@ START_TEST(test_opt_osnoise_auto_cb)
 }
 END_TEST
 
+START_TEST(test_opt_osnoise_auto_cb_unset)
+{
+	struct osnoise_params params = {0};
+	struct osnoise_cb_data cb_data = {&params};
+	const struct option opt = TEST_CALLBACK(&cb_data, opt_osnoise_auto_cb);
+
+	ck_assert_int_eq(opt_osnoise_auto_cb(&opt, "10", 0), 0);
+	ck_assert_int_eq(opt_osnoise_auto_cb(&opt, NULL, 1), 0);
+	ck_assert_int_eq(params.common.stop_us, 0);
+	ck_assert_int_eq(params.threshold, 0);
+	ck_assert_ptr_null(cb_data.trace_output);
+}
+END_TEST
+
 START_TEST(test_opt_osnoise_period_cb)
 {
 	unsigned long long period = 0;
@@ -299,6 +408,17 @@ START_TEST(test_opt_osnoise_period_cb_invalid)
 }
 END_TEST
 
+START_TEST(test_opt_osnoise_period_cb_unset)
+{
+	unsigned long long period = 0;
+	const struct option opt = TEST_CALLBACK(&period, opt_osnoise_period_cb);
+
+	ck_assert_int_eq(opt_osnoise_period_cb(&opt, "1000000", 0), 0);
+	ck_assert_int_eq(opt_osnoise_period_cb(&opt, NULL, 1), 0);
+	ck_assert_int_eq(period, 0);
+}
+END_TEST
+
 START_TEST(test_opt_osnoise_runtime_cb)
 {
 	unsigned long long runtime = 0;
@@ -319,6 +439,17 @@ START_TEST(test_opt_osnoise_runtime_cb_invalid)
 }
 END_TEST
 
+START_TEST(test_opt_osnoise_runtime_cb_unset)
+{
+	unsigned long long runtime = 0;
+	const struct option opt = TEST_CALLBACK(&runtime, opt_osnoise_runtime_cb);
+
+	ck_assert_int_eq(opt_osnoise_runtime_cb(&opt, "900000", 0), 0);
+	ck_assert_int_eq(opt_osnoise_runtime_cb(&opt, NULL, 1), 0);
+	ck_assert_int_eq(runtime, 0);
+}
+END_TEST
+
 START_TEST(test_opt_osnoise_trace_output_cb)
 {
 	const char *trace_output = NULL;
@@ -339,6 +470,17 @@ START_TEST(test_opt_osnoise_trace_output_cb_noarg)
 }
 END_TEST
 
+START_TEST(test_opt_osnoise_trace_output_cb_unset)
+{
+	const char *trace_output = NULL;
+	const struct option opt = TEST_CALLBACK(&trace_output, opt_osnoise_trace_output_cb);
+
+	ck_assert_int_eq(opt_osnoise_trace_output_cb(&opt, "trace.txt", 0), 0);
+	ck_assert_int_eq(opt_osnoise_trace_output_cb(&opt, NULL, 1), 0);
+	ck_assert_ptr_null(trace_output);
+}
+END_TEST
+
 START_TEST(test_opt_osnoise_on_threshold_cb)
 {
 	struct actions actions = {0};
@@ -403,6 +545,17 @@ START_TEST(test_opt_timerlat_period_cb_invalid)
 }
 END_TEST
 
+START_TEST(test_opt_timerlat_period_cb_unset)
+{
+	long long period = 0;
+	const struct option opt = TEST_CALLBACK(&period, opt_timerlat_period_cb);
+
+	ck_assert_int_eq(opt_timerlat_period_cb(&opt, "1000", 0), 0);
+	ck_assert_int_eq(opt_timerlat_period_cb(&opt, NULL, 1), 0);
+	ck_assert_int_eq(period, 0);
+}
+END_TEST
+
 START_TEST(test_opt_timerlat_auto_cb)
 {
 	struct timerlat_params params = {0};
@@ -417,6 +570,21 @@ START_TEST(test_opt_timerlat_auto_cb)
 }
 END_TEST
 
+START_TEST(test_opt_timerlat_auto_cb_unset)
+{
+	struct timerlat_params params = {0};
+	struct timerlat_cb_data cb_data = {&params};
+	const struct option opt = TEST_CALLBACK(&cb_data, opt_timerlat_auto_cb);
+
+	ck_assert_int_eq(opt_timerlat_auto_cb(&opt, "10", 0), 0);
+	ck_assert_int_eq(opt_timerlat_auto_cb(&opt, NULL, 1), 0);
+	ck_assert_int_eq(params.common.stop_us, 0);
+	ck_assert_int_eq(params.common.stop_total_us, 0);
+	ck_assert_int_eq(params.print_stack, 0);
+	ck_assert_ptr_null(cb_data.trace_output);
+}
+END_TEST
+
 START_TEST(test_opt_dma_latency_cb)
 {
 	int dma_latency = 0;
@@ -447,6 +615,17 @@ START_TEST(test_opt_dma_latency_cb_max)
 }
 END_TEST
 
+START_TEST(test_opt_dma_latency_cb_unset)
+{
+	int dma_latency = 0;
+	const struct option opt = TEST_CALLBACK(&dma_latency, opt_dma_latency_cb);
+
+	ck_assert_int_eq(opt_dma_latency_cb(&opt, "1000", 0), 0);
+	ck_assert_int_eq(opt_dma_latency_cb(&opt, NULL, 1), 0);
+	ck_assert_int_eq(dma_latency, default_dma_latency);
+}
+END_TEST
+
 START_TEST(test_opt_aa_only_cb)
 {
 	struct timerlat_params params = {0};
@@ -460,6 +639,20 @@ START_TEST(test_opt_aa_only_cb)
 }
 END_TEST
 
+START_TEST(test_opt_aa_only_cb_unset)
+{
+	struct timerlat_params params = {0};
+	const struct option opt = TEST_CALLBACK(&params, opt_aa_only_cb);
+
+	ck_assert_int_eq(opt_aa_only_cb(&opt, "10", 0), 0);
+	ck_assert_int_eq(opt_aa_only_cb(&opt, NULL, 1), 0);
+	ck_assert_int_eq(params.common.stop_us, 0);
+	ck_assert_int_eq(params.common.stop_total_us, 0);
+	ck_assert_int_eq(params.print_stack, 0);
+	ck_assert_int_eq(params.common.aa_only, 0);
+}
+END_TEST
+
 START_TEST(test_opt_timerlat_trace_output_cb)
 {
 	const char *trace_output = NULL;
@@ -480,6 +673,17 @@ START_TEST(test_opt_timerlat_trace_output_cb_noarg)
 }
 END_TEST
 
+START_TEST(test_opt_timerlat_trace_output_cb_unset)
+{
+	const char *trace_output = NULL;
+	const struct option opt = TEST_CALLBACK(&trace_output, opt_timerlat_trace_output_cb);
+
+	ck_assert_int_eq(opt_timerlat_trace_output_cb(&opt, "trace.txt", 0), 0);
+	ck_assert_int_eq(opt_timerlat_trace_output_cb(&opt, NULL, 1), 0);
+	ck_assert_ptr_null(trace_output);
+}
+END_TEST
+
 START_TEST(test_opt_timerlat_on_threshold_cb)
 {
 	struct actions actions = {0};
@@ -535,6 +739,18 @@ START_TEST(test_opt_user_threads_cb)
 }
 END_TEST
 
+START_TEST(test_opt_user_threads_cb_unset)
+{
+	struct timerlat_params params = {0};
+	const struct option opt = TEST_CALLBACK(&params, opt_user_threads_cb);
+
+	ck_assert_int_eq(opt_user_threads_cb(&opt, NULL, 0), 0);
+	ck_assert_int_eq(opt_user_threads_cb(&opt, NULL, 1), 0);
+	ck_assert_int_eq(params.common.user_workload, 0);
+	ck_assert_int_eq(params.common.user_data, 0);
+}
+END_TEST
+
 START_TEST(test_opt_nano_cb)
 {
 	struct timerlat_params params = {0};
@@ -545,6 +761,17 @@ START_TEST(test_opt_nano_cb)
 }
 END_TEST
 
+START_TEST(test_opt_nano_cb_unset)
+{
+	struct timerlat_params params = {0};
+	const struct option opt = TEST_CALLBACK(&params, opt_nano_cb);
+
+	ck_assert_int_eq(opt_nano_cb(&opt, NULL, 0), 0);
+	ck_assert_int_eq(opt_nano_cb(&opt, NULL, 1), 0);
+	ck_assert_int_eq(params.common.output_divisor, default_output_divisor);
+}
+END_TEST
+
 START_TEST(test_opt_timerlat_align_cb)
 {
 	struct timerlat_params params = {0};
@@ -556,6 +783,18 @@ START_TEST(test_opt_timerlat_align_cb)
 }
 END_TEST
 
+START_TEST(test_opt_timerlat_align_cb_unset)
+{
+	struct timerlat_params params = {0};
+	const struct option opt = TEST_CALLBACK(&params, opt_timerlat_align_cb);
+
+	ck_assert_int_eq(opt_timerlat_align_cb(&opt, "500", 0), 0);
+	ck_assert_int_eq(opt_timerlat_align_cb(&opt, NULL, 1), 0);
+	ck_assert_int_eq(params.timerlat_align, 0);
+	ck_assert_int_eq(params.timerlat_align_us, 0);
+}
+END_TEST
+
 START_TEST(test_opt_stack_format_cb)
 {
 	int stack_format = 0;
@@ -576,6 +815,17 @@ START_TEST(test_opt_stack_format_cb_invalid)
 }
 END_TEST
 
+START_TEST(test_opt_stack_format_cb_unset)
+{
+	int stack_format = 0;
+	const struct option opt = TEST_CALLBACK(&stack_format, opt_stack_format_cb);
+
+	ck_assert_int_eq(opt_stack_format_cb(&opt, "full", 0), 0);
+	ck_assert_int_eq(opt_stack_format_cb(&opt, NULL, 1), 0);
+	ck_assert_int_eq(stack_format, default_stack_format);
+}
+END_TEST
+
 START_TEST(test_opt_bucket_size_cb)
 {
 	int bucket_size = 0;
@@ -606,6 +856,17 @@ START_TEST(test_opt_bucket_size_max)
 }
 END_TEST
 
+START_TEST(test_opt_bucket_size_cb_unset)
+{
+	int bucket_size = 0;
+	const struct option opt = TEST_CALLBACK(&bucket_size, opt_bucket_size_cb);
+
+	ck_assert_int_eq(opt_bucket_size_cb(&opt, "100", 0), 0);
+	ck_assert_int_eq(opt_bucket_size_cb(&opt, NULL, 1), 0);
+	ck_assert_int_eq(bucket_size, default_bucket_size);
+}
+END_TEST
+
 START_TEST(test_opt_entries_cb)
 {
 	int entries = 0;
@@ -636,6 +897,17 @@ START_TEST(test_opt_entries_max)
 }
 END_TEST
 
+START_TEST(test_opt_entries_cb_unset)
+{
+	int entries = 0;
+	const struct option opt = TEST_CALLBACK(&entries, opt_entries_cb);
+
+	ck_assert_int_eq(opt_entries_cb(&opt, "100", 0), 0);
+	ck_assert_int_eq(opt_entries_cb(&opt, NULL, 1), 0);
+	ck_assert_int_eq(entries, default_entries);
+}
+END_TEST
+
 Suite *cli_opt_callback_suite(void)
 {
 	Suite *s = suite_create("cli_opt_callback");
@@ -645,23 +917,31 @@ Suite *cli_opt_callback_suite(void)
 	tcase_add_test(tc, test_opt_llong_callback_simple);
 	tcase_add_test(tc, test_opt_llong_callback_max);
 	tcase_add_test(tc, test_opt_llong_callback_min);
+	tcase_add_test(tc, test_opt_llong_callback_unset);
+	tcase_add_test(tc, test_opt_llong_callback_unset_defval);
 	tcase_add_test(tc, test_opt_int_callback_simple);
 	tcase_add_test(tc, test_opt_int_callback_max);
 	tcase_add_test(tc, test_opt_int_callback_min);
 	tcase_add_test(tc, test_opt_int_callback_non_numeric);
 	tcase_add_test(tc, test_opt_int_callback_non_numeric_suffix);
+	tcase_add_test(tc, test_opt_int_callback_unset);
+	tcase_add_test(tc, test_opt_int_callback_unset_defval);
 	tcase_add_test(tc, test_opt_cpus_cb);
 	tcase_add_exit_test(tc, test_opt_cpus_cb_invalid, EXIT_FAILURE);
 	tcase_add_test(tc, test_opt_cgroup_cb);
 	tcase_add_test(tc, test_opt_cgroup_cb_equals);
+	tcase_add_test(tc, test_opt_cgroup_cb_unset);
 	tcase_add_test(tc, test_opt_duration_cb);
+	tcase_add_test(tc, test_opt_duration_cb_unset);
 	tcase_add_exit_test(tc, test_opt_duration_cb_invalid, EXIT_FAILURE);
 	tcase_add_test(tc, test_opt_event_cb);
 	tcase_add_test(tc, test_opt_event_cb_multiple);
 	tcase_add_test(tc, test_opt_housekeeping_cb);
 	tcase_add_exit_test(tc, test_opt_housekeeping_cb_invalid, EXIT_FAILURE);
+	tcase_add_test(tc, test_opt_housekeeping_cb_unset);
 	tcase_add_test(tc, test_opt_priority_cb);
 	tcase_add_exit_test(tc, test_opt_priority_cb_invalid, EXIT_FAILURE);
+	tcase_add_test(tc, test_opt_priority_cb_unset);
 	tcase_add_test(tc, test_opt_trigger_cb);
 	tcase_add_exit_test(tc, test_opt_trigger_cb_no_event, EXIT_FAILURE);
 	tcase_add_test(tc, test_opt_filter_cb);
@@ -670,12 +950,16 @@ Suite *cli_opt_callback_suite(void)
 
 	tc = tcase_create("osnoise");
 	tcase_add_test(tc, test_opt_osnoise_auto_cb);
+	tcase_add_test(tc, test_opt_osnoise_auto_cb_unset);
 	tcase_add_test(tc, test_opt_osnoise_period_cb);
+	tcase_add_test(tc, test_opt_osnoise_period_cb_unset);
 	tcase_add_exit_test(tc, test_opt_osnoise_period_cb_invalid, EXIT_FAILURE);
 	tcase_add_test(tc, test_opt_osnoise_runtime_cb);
 	tcase_add_exit_test(tc, test_opt_osnoise_runtime_cb_invalid, EXIT_FAILURE);
+	tcase_add_test(tc, test_opt_osnoise_runtime_cb_unset);
 	tcase_add_test(tc, test_opt_osnoise_trace_output_cb);
 	tcase_add_test(tc, test_opt_osnoise_trace_output_cb_noarg);
+	tcase_add_test(tc, test_opt_osnoise_trace_output_cb_unset);
 	tcase_add_test(tc, test_opt_osnoise_on_threshold_cb);
 	tcase_add_exit_test(tc, test_opt_osnoise_on_threshold_cb_invalid, EXIT_FAILURE);
 	tcase_add_test(tc, test_opt_osnoise_on_end_cb);
@@ -685,31 +969,42 @@ Suite *cli_opt_callback_suite(void)
 	tc = tcase_create("timerlat");
 	tcase_add_test(tc, test_opt_timerlat_period_cb);
 	tcase_add_exit_test(tc, test_opt_timerlat_period_cb_invalid, EXIT_FAILURE);
+	tcase_add_test(tc, test_opt_timerlat_period_cb_unset);
 	tcase_add_test(tc, test_opt_timerlat_auto_cb);
+	tcase_add_test(tc, test_opt_timerlat_auto_cb_unset);
 	tcase_add_test(tc, test_opt_dma_latency_cb);
 	tcase_add_exit_test(tc, test_opt_dma_latency_cb_min, EXIT_FAILURE);
 	tcase_add_exit_test(tc, test_opt_dma_latency_cb_max, EXIT_FAILURE);
+	tcase_add_test(tc, test_opt_dma_latency_cb_unset);
 	tcase_add_test(tc, test_opt_aa_only_cb);
+	tcase_add_test(tc, test_opt_aa_only_cb_unset);
 	tcase_add_test(tc, test_opt_timerlat_trace_output_cb);
 	tcase_add_test(tc, test_opt_timerlat_trace_output_cb_noarg);
+	tcase_add_test(tc, test_opt_timerlat_trace_output_cb_unset);
 	tcase_add_test(tc, test_opt_timerlat_on_threshold_cb);
 	tcase_add_exit_test(tc, test_opt_timerlat_on_threshold_cb_invalid, EXIT_FAILURE);
 	tcase_add_test(tc, test_opt_timerlat_on_end_cb);
 	tcase_add_exit_test(tc, test_opt_timerlat_on_end_cb_invalid, EXIT_FAILURE);
 	tcase_add_test(tc, test_opt_user_threads_cb);
+	tcase_add_test(tc, test_opt_user_threads_cb_unset);
 	tcase_add_test(tc, test_opt_nano_cb);
+	tcase_add_test(tc, test_opt_nano_cb_unset);
 	tcase_add_test(tc, test_opt_stack_format_cb);
 	tcase_add_exit_test(tc, test_opt_stack_format_cb_invalid, EXIT_FAILURE);
+	tcase_add_test(tc, test_opt_stack_format_cb_unset);
 	tcase_add_test(tc, test_opt_timerlat_align_cb);
+	tcase_add_test(tc, test_opt_timerlat_align_cb_unset);
 	suite_add_tcase(s, tc);
 
 	tc = tcase_create("histogram");
 	tcase_add_test(tc, test_opt_bucket_size_cb);
 	tcase_add_exit_test(tc, test_opt_bucket_size_min, EXIT_FAILURE);
 	tcase_add_exit_test(tc, test_opt_bucket_size_max, EXIT_FAILURE);
+	tcase_add_test(tc, test_opt_bucket_size_cb_unset);
 	tcase_add_test(tc, test_opt_entries_cb);
 	tcase_add_exit_test(tc, test_opt_entries_min, EXIT_FAILURE);
 	tcase_add_exit_test(tc, test_opt_entries_max, EXIT_FAILURE);
+	tcase_add_test(tc, test_opt_entries_cb_unset);
 	suite_add_tcase(s, tc);
 
 	return s;
-- 
2.54.0

