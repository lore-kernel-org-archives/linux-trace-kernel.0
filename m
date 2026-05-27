Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C43364950
	for <linux-trace-kernel@vger.kernel.org>; Wed, 27 May 2026 14:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779893389; cv=none; b=s4wgeqT/J6ghrM13gUPTMgyV8ETHa2qtWFb8a1/9Aywczi3LGbNAVwSlWLvaGvoGoiDqNKOa5Jt5YGgCOMrMUAIc2nxUPkUwtXLGL7naHNre7y94KZDpcrEpxEqiPeEvggBnP8k7DPbMkMG2aAOK5fPFh+mKOyWWvesmPPnL1Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779893389; c=relaxed/simple;
	bh=s4dAQH1PYQHYmyxUcWbpnJS1kQimi9ddZrcz6eLzna4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Kjx/pEpZOdpfO6IKCIWpEgaCm3k2t7185CcPNoQpDxpVuNLWrhrS2xY8ijpDjX1ydqDMU28av3QIf/3EN5TbJ/GQxqHwIpCaESCCXt2Z6AhD5wy2zcXxxT1IZAEZDlsoaudcaUVveeijPPUjR/hGayp7yfJr/QAXov8eMtaBFvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VAAvRela; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VAAvRela"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779893386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=klN7dPXqhMntGwbDW72MJziQiWQ48M1I9gfONYRf80w=;
	b=VAAvRelakifGHT5JyFplUVMSKuL9Ttr/3zGopB4EOBb4xt5ZzPYn/z8G2cgSxWm689RNwB
	UJ5olS0pvhFEYylKIoL8/wWc30myNMW8WRvHIcaiox21HHrkmaS+ueJyxNsET7YEeQ25zm
	kczukIDlzz2BT0dYOaUi1FnizCQL5qk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-Q29Sy25jPhqfNjNny6W10Q-1; Wed,
 27 May 2026 10:49:44 -0400
X-MC-Unique: Q29Sy25jPhqfNjNny6W10Q-1
X-Mimecast-MFC-AGG-ID: Q29Sy25jPhqfNjNny6W10Q_1779893383
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F1ED118002E0;
	Wed, 27 May 2026 14:49:42 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.34.21])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C8F4B1800465;
	Wed, 27 May 2026 14:49:39 +0000 (UTC)
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
Subject: [PATCH 2/3] rtla/tests: Add unit tests for -A/--aligned option
Date: Wed, 27 May 2026 16:49:27 +0200
Message-ID: <20260527144928.2944472-2-tglozar@redhat.com>
In-Reply-To: <20260527144928.2944472-1-tglozar@redhat.com>
References: <20260527144928.2944472-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: ZD70VZlDbsNM-7u7JAmJAFI9WzR-GI41VQ1qtuuBrDc_1779893383
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add both parse_args() and opt_* tests for the newly added -A/--aligned
option.

Assisted-by: Claude:claude-4.5-opus-high-thinking
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 .../rtla/tests/unit/cli_opt_callback.c        | 12 +++++++++++
 .../rtla/tests/unit/timerlat_hist_cli.c       | 20 +++++++++++++++++++
 .../rtla/tests/unit/timerlat_top_cli.c        | 20 +++++++++++++++++++
 3 files changed, 52 insertions(+)

diff --git a/tools/tracing/rtla/tests/unit/cli_opt_callback.c b/tools/tracing/rtla/tests/unit/cli_opt_callback.c
index 01647f4227d1..4a406af42821 100644
--- a/tools/tracing/rtla/tests/unit/cli_opt_callback.c
+++ b/tools/tracing/rtla/tests/unit/cli_opt_callback.c
@@ -545,6 +545,17 @@ START_TEST(test_opt_nano_cb)
 }
 END_TEST
 
+START_TEST(test_opt_timerlat_align_cb)
+{
+	struct timerlat_params params = {0};
+	const struct option opt = TEST_CALLBACK(&params, opt_timerlat_align_cb);
+
+	ck_assert_int_eq(opt_timerlat_align_cb(&opt, "500", 0), 0);
+	ck_assert(params.timerlat_align);
+	ck_assert_int_eq(params.timerlat_align_us, 500);
+}
+END_TEST
+
 START_TEST(test_opt_stack_format_cb)
 {
 	int stack_format = 0;
@@ -689,6 +700,7 @@ Suite *cli_opt_callback_suite(void)
 	tcase_add_test(tc, test_opt_nano_cb);
 	tcase_add_test(tc, test_opt_stack_format_cb);
 	tcase_add_exit_test(tc, test_opt_stack_format_cb_invalid, EXIT_FAILURE);
+	tcase_add_test(tc, test_opt_timerlat_align_cb);
 	suite_add_tcase(s, tc);
 
 	tc = tcase_create("histogram");
diff --git a/tools/tracing/rtla/tests/unit/timerlat_hist_cli.c b/tools/tracing/rtla/tests/unit/timerlat_hist_cli.c
index 81dc04596cd1..968bf962f53f 100644
--- a/tools/tracing/rtla/tests/unit/timerlat_hist_cli.c
+++ b/tools/tracing/rtla/tests/unit/timerlat_hist_cli.c
@@ -373,6 +373,24 @@ START_TEST(test_user_threads_long)
 }
 END_TEST
 
+START_TEST(test_aligned_short)
+{
+	PARSE_ARGS("timerlat", "hist", "-A", "500");
+
+	ck_assert(tlat_params->timerlat_align);
+	ck_assert_int_eq(tlat_params->timerlat_align_us, 500);
+}
+END_TEST
+
+START_TEST(test_aligned_long)
+{
+	PARSE_ARGS("timerlat", "hist", "--aligned", "500");
+
+	ck_assert(tlat_params->timerlat_align);
+	ck_assert_int_eq(tlat_params->timerlat_align_us, 500);
+}
+END_TEST
+
 /* Histogram Options */
 
 START_TEST(test_bucket_size_short)
@@ -654,6 +672,8 @@ Suite *timerlat_hist_cli_suite(void)
 	tcase_add_test(tc, test_user_load_long);
 	tcase_add_test(tc, test_user_threads_short);
 	tcase_add_test(tc, test_user_threads_long);
+	tcase_add_test(tc, test_aligned_short);
+	tcase_add_test(tc, test_aligned_long);
 	suite_add_tcase(s, tc);
 
 	tc = tcase_create("histogram_options");
diff --git a/tools/tracing/rtla/tests/unit/timerlat_top_cli.c b/tools/tracing/rtla/tests/unit/timerlat_top_cli.c
index 1c39008564c5..33aa6588d503 100644
--- a/tools/tracing/rtla/tests/unit/timerlat_top_cli.c
+++ b/tools/tracing/rtla/tests/unit/timerlat_top_cli.c
@@ -373,6 +373,24 @@ START_TEST(test_user_threads_long)
 }
 END_TEST
 
+START_TEST(test_aligned_short)
+{
+	PARSE_ARGS("timerlat", "top", "-A", "500");
+
+	ck_assert(tlat_params->timerlat_align);
+	ck_assert_int_eq(tlat_params->timerlat_align_us, 500);
+}
+END_TEST
+
+START_TEST(test_aligned_long)
+{
+	PARSE_ARGS("timerlat", "top", "--aligned", "500");
+
+	ck_assert(tlat_params->timerlat_align);
+	ck_assert_int_eq(tlat_params->timerlat_align_us, 500);
+}
+END_TEST
+
 /* Output */
 
 START_TEST(test_nano_short)
@@ -596,6 +614,8 @@ Suite *timerlat_top_cli_suite(void)
 	tcase_add_test(tc, test_user_load_long);
 	tcase_add_test(tc, test_user_threads_short);
 	tcase_add_test(tc, test_user_threads_long);
+	tcase_add_test(tc, test_aligned_short);
+	tcase_add_test(tc, test_aligned_long);
 	suite_add_tcase(s, tc);
 
 	tc = tcase_create("output");
-- 
2.54.0

