Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02803F8258
	for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jun 2026 08:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782722253; cv=none; b=ZxUjRw59vGe+EJm/dpQbxmhMmmsRxDCxDKlBRyQpVX07Q1sdoHaOtBLo5WS5TyiOPm8TQMC38DQG0jg1knb0KFwHx0XiCtANVfkadisc58DbD2jKlE5jwt6vCWF0KnhvYQZUI0mNkxynd3NR1EtyCKVUYoAf63s8/WDt0NA7Kbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782722253; c=relaxed/simple;
	bh=cMVKUkFlf2EVKLgb2Sn0RNATF7v8vswHukwlTbEH5fU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=txYvt0XWhnJB3ZsinqJRiAi/c6mSMrP9bnOBgg8menTfJ3deDupMdSZOyVaQQ/G1HhY028SctH29qsL64EQ5xSznhZPr+YiyJlRylrIb5SKdOM0lXPC6orpaaOGw7XJLqQzXOLTX3qXhWvBbB8rGviIn2N+dzQ5KUgvYXT1hI/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uk4cOaF0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uk4cOaF0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782722251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=svxgQF/6v0BUuQnR9Ky9NwJ+xFziKKmsBHO7bVv9DCM=;
	b=Uk4cOaF0ye3Ii0Y5pa3WAY0FP5lkzO6fkJ1HCgZx9p+S2TCGjDBxy8YfCH/FjGjL3KXMDw
	jRIDh+dr3mrDWRmSDNXlp1/Wa527ZyuO7xWmxSRyzfIr/k9zbHZ0j1d8241fX1a+jAxNgX
	zpTJoul4dktG60rZgzkVwaoxG2uh0wM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-q6Vd-ITyMeq-u1SDvT7gNg-1; Mon,
 29 Jun 2026 04:37:25 -0400
X-MC-Unique: q6Vd-ITyMeq-u1SDvT7gNg-1
X-Mimecast-MFC-AGG-ID: q6Vd-ITyMeq-u1SDvT7gNg_1782722244
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C412A180048E;
	Mon, 29 Jun 2026 08:37:24 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.109])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 880A631D2;
	Mon, 29 Jun 2026 08:37:22 +0000 (UTC)
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
Subject: [PATCH 3/4] rtla: Add unit tests for CLI with unset
Date: Mon, 29 Jun 2026 10:36:53 +0200
Message-ID: <20260629083654.1548925-3-tglozar@redhat.com>
In-Reply-To: <20260629083654.1548925-1-tglozar@redhat.com>
References: <20260629083654.1548925-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: G0TV0150NgdRRB8dzP5PF16wyeoRqK8iZ_ZoIzXGSoo_1782722244
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Test parsing of command line that sets an option and then unsets it back
to the default value in all tools.

Only two CLI tests are added for each tool: short period option (-p ...
--no-period) and long period option (--period ... --no-period). The
logic specific for individual options is tested in opt callback tests
already.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 .../tracing/rtla/tests/unit/osnoise_hist_cli.c | 18 ++++++++++++++++++
 .../tracing/rtla/tests/unit/osnoise_top_cli.c  | 18 ++++++++++++++++++
 .../rtla/tests/unit/timerlat_hist_cli.c        | 18 ++++++++++++++++++
 .../tracing/rtla/tests/unit/timerlat_top_cli.c | 18 ++++++++++++++++++
 4 files changed, 72 insertions(+)

diff --git a/tools/tracing/rtla/tests/unit/osnoise_hist_cli.c b/tools/tracing/rtla/tests/unit/osnoise_hist_cli.c
index 3661529f93dc9..221985e6759f0 100644
--- a/tools/tracing/rtla/tests/unit/osnoise_hist_cli.c
+++ b/tools/tracing/rtla/tests/unit/osnoise_hist_cli.c
@@ -37,6 +37,22 @@ START_TEST(test_period_long)
 }
 END_TEST
 
+START_TEST(test_period_unset_short)
+{
+	PARSE_ARGS("osnoise", "hist", "-p", "100000", "--no-period");
+
+	ck_assert_int_eq(osn_params->period, 0);
+}
+END_TEST
+
+START_TEST(test_period_unset_long)
+{
+	PARSE_ARGS("osnoise", "hist", "--period", "100000", "--no-period");
+
+	ck_assert_int_eq(osn_params->period, 0);
+}
+END_TEST
+
 START_TEST(test_runtime_short)
 {
 	PARSE_ARGS("osnoise", "hist", "-r", "95000");
@@ -481,6 +497,8 @@ Suite *osnoise_hist_cli_suite(void)
 	tc = tcase_create("tracing_options");
 	tcase_add_test(tc, test_period_short);
 	tcase_add_test(tc, test_period_long);
+	tcase_add_test(tc, test_period_unset_short);
+	tcase_add_test(tc, test_period_unset_long);
 	tcase_add_test(tc, test_runtime_short);
 	tcase_add_test(tc, test_runtime_long);
 	tcase_add_test(tc, test_stop_short);
diff --git a/tools/tracing/rtla/tests/unit/osnoise_top_cli.c b/tools/tracing/rtla/tests/unit/osnoise_top_cli.c
index f3a8633cc84e8..057dbe574b079 100644
--- a/tools/tracing/rtla/tests/unit/osnoise_top_cli.c
+++ b/tools/tracing/rtla/tests/unit/osnoise_top_cli.c
@@ -37,6 +37,22 @@ START_TEST(test_period_long)
 }
 END_TEST
 
+START_TEST(test_period_unset_short)
+{
+	PARSE_ARGS("osnoise", "top", "-p", "100000", "--no-period");
+
+	ck_assert_int_eq(osn_params->period, 0);
+}
+END_TEST
+
+START_TEST(test_period_unset_long)
+{
+	PARSE_ARGS("osnoise", "top", "--period", "100000", "--no-period");
+
+	ck_assert_int_eq(osn_params->period, 0);
+}
+END_TEST
+
 START_TEST(test_runtime_short)
 {
 	PARSE_ARGS("osnoise", "top", "-r", "95000");
@@ -433,6 +449,8 @@ Suite *osnoise_top_cli_suite(void)
 	tc = tcase_create("tracing_options");
 	tcase_add_test(tc, test_period_short);
 	tcase_add_test(tc, test_period_long);
+	tcase_add_test(tc, test_period_unset_short);
+	tcase_add_test(tc, test_period_unset_long);
 	tcase_add_test(tc, test_runtime_short);
 	tcase_add_test(tc, test_runtime_long);
 	tcase_add_test(tc, test_stop_short);
diff --git a/tools/tracing/rtla/tests/unit/timerlat_hist_cli.c b/tools/tracing/rtla/tests/unit/timerlat_hist_cli.c
index 968bf962f53f0..d8dd9d752636e 100644
--- a/tools/tracing/rtla/tests/unit/timerlat_hist_cli.c
+++ b/tools/tracing/rtla/tests/unit/timerlat_hist_cli.c
@@ -55,6 +55,22 @@ START_TEST(test_period_long)
 }
 END_TEST
 
+START_TEST(test_period_unset_short)
+{
+	PARSE_ARGS("timerlat", "hist", "-p", "200", "--no-period");
+
+	ck_assert_int_eq(tlat_params->timerlat_period_us, 0);
+}
+END_TEST
+
+START_TEST(test_period_unset_long)
+{
+	PARSE_ARGS("timerlat", "hist", "--period", "200", "--no-period");
+
+	ck_assert_int_eq(tlat_params->timerlat_period_us, 0);
+}
+END_TEST
+
 START_TEST(test_stack_short)
 {
 	PARSE_ARGS("timerlat", "hist", "-s", "20");
@@ -629,6 +645,8 @@ Suite *timerlat_hist_cli_suite(void)
 	tcase_add_test(tc, test_irq_long);
 	tcase_add_test(tc, test_period_short);
 	tcase_add_test(tc, test_period_long);
+	tcase_add_test(tc, test_period_unset_short);
+	tcase_add_test(tc, test_period_unset_long);
 	tcase_add_test(tc, test_stack_short);
 	tcase_add_test(tc, test_stack_long);
 	tcase_add_test(tc, test_thread_short);
diff --git a/tools/tracing/rtla/tests/unit/timerlat_top_cli.c b/tools/tracing/rtla/tests/unit/timerlat_top_cli.c
index 33aa6588d503b..e9fb1a86ab8c4 100644
--- a/tools/tracing/rtla/tests/unit/timerlat_top_cli.c
+++ b/tools/tracing/rtla/tests/unit/timerlat_top_cli.c
@@ -55,6 +55,22 @@ START_TEST(test_period_long)
 }
 END_TEST
 
+START_TEST(test_period_unset_short)
+{
+	PARSE_ARGS("timerlat", "top", "-p", "200", "--no-period");
+
+	ck_assert_int_eq(tlat_params->timerlat_period_us, 0);
+}
+END_TEST
+
+START_TEST(test_period_unset_long)
+{
+	PARSE_ARGS("timerlat", "top", "--period", "200", "--no-period");
+
+	ck_assert_int_eq(tlat_params->timerlat_period_us, 0);
+}
+END_TEST
+
 START_TEST(test_stack_short)
 {
 	PARSE_ARGS("timerlat", "top", "-s", "20");
@@ -571,6 +587,8 @@ Suite *timerlat_top_cli_suite(void)
 	tcase_add_test(tc, test_irq_long);
 	tcase_add_test(tc, test_period_short);
 	tcase_add_test(tc, test_period_long);
+	tcase_add_test(tc, test_period_unset_short);
+	tcase_add_test(tc, test_period_unset_long);
 	tcase_add_test(tc, test_stack_short);
 	tcase_add_test(tc, test_stack_long);
 	tcase_add_test(tc, test_thread_short);
-- 
2.54.0

