Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945C331327D
	for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Aug 2026 13:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786715756; cv=none; b=SvzkTU1Ubu18GP+s8wUtlup58Mbf5FUzdsZuqyM7SvszhPspzd1OtzUpNddHgjYZpEl3v34ClFT/inCPZORdd6fvE8RSWvogCWw2yXx9v1Yr9ouoNzKzQfEnHDAUAvs+Mg73iSn0aUOuTAKvo3dc5Yydw0uC9G9InRecpOg8eEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786715756; c=relaxed/simple;
	bh=Kq5E/r9tg+1yGMrhP87SYXj2ZfJSQrGUexdSTHbexAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=hO8zzBJ+dAGBqugm/ZSGPYztGRwRoSWI/ggUC6TFIiF4SRpBhREFBL24BLF9kYBWWy2lPJMrXGqsnCU0sgk+MGX85yKCIqmltQ+F8ZQwO7Yf/+7pYpBcDBSN4WGtcCen6qm7SgxUvmQYLWHFPCIco94XCVrMrI9B+XY9ISyqTzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y4Qxt/1S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y4Qxt/1S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786715752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XjtevNBfIqkJxOx4BwwiGXQRrfIgcwR4eI1yjAuHNrU=;
	b=Y4Qxt/1SRxdt1U7DCLA8KAm8ojB4/w8AGi4SUZhW/uVJWGBTdfu7h6W8YiBJ9DcLjdjzod
	YrTJY9tYmtQaM3EbpVUf0iCS3o/HQFclxe66fDf4aroiwHsCxs4mqmKakfU7daM8RYZ6hF
	gCTJHphfHAnOmOvTZ1gBjbAF5sQqyDg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-513-arhCGr2KOriDueH4imAo1w-1; Fri,
 14 Aug 2026 09:55:48 -0400
X-MC-Unique: arhCGr2KOriDueH4imAo1w-1
X-Mimecast-MFC-AGG-ID: arhCGr2KOriDueH4imAo1w_1786715747
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8AD601800115;
	Fri, 14 Aug 2026 13:55:47 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.33.92])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 74629180049F;
	Fri, 14 Aug 2026 13:55:44 +0000 (UTC)
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
Subject: [PATCH 4/5] rtla/tests: Add unit test for cpu_list_iterate()
Date: Fri, 14 Aug 2026 15:55:10 +0200
Message-ID: <20260814135511.2207190-5-tglozar@redhat.com>
In-Reply-To: <20260814135511.2207190-1-tglozar@redhat.com>
References: <20260814135511.2207190-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: Px8kmHBzxUmBuWYLI0IeteEtTNqJo0ZfKd-a2dnlD70_1786715747
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

cpu_list_iterate() was split out of parse_cpu_set() to hold shared code
between it and the newly added function get_possible_cpus().

As its semantics are more complex than parse_cpu_set() - it calls a
callback on each element of the list, with possible abort on failure,
while parse_cpu_set() cares only about the set defined by the list - it
deserves its own test.

Test the callback being called correctly as well as the return value and
early break on different combinations of comma-separated numbers and
ranges.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/tests/unit/utils.c | 62 +++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/tools/tracing/rtla/tests/unit/utils.c b/tools/tracing/rtla/tests/unit/utils.c
index ce53cab494575..0cb5e217c56eb 100644
--- a/tools/tracing/rtla/tests/unit/utils.c
+++ b/tools/tracing/rtla/tests/unit/utils.c
@@ -34,6 +34,67 @@ START_TEST(test_strtoi)
 }
 END_TEST
 
+struct cpu_list_iterate_cb_data {
+	int index;
+	int *values;
+};
+
+static int cpu_list_iterate_callback(int cpu, void *data)
+{
+	struct cpu_list_iterate_cb_data *cb_data = data;
+
+	ck_assert_int_eq(cpu, cb_data->values[cb_data->index++]);
+
+	return 0;
+}
+
+static int cpu_list_iterate_callback_error(int cpu, void *data)
+{
+	struct cpu_list_iterate_cb_data *cb_data = data;
+
+	if (cpu > 10)
+		return -42;
+
+	ck_assert_int_eq(cpu, cb_data->values[cb_data->index++]);
+
+	return 0;
+}
+
+START_TEST(test_cpu_list_iterate)
+{
+	struct cpu_list_iterate_cb_data cb_data;
+	int test_data_1[] = {1, 2, 3, 4};
+	int test_data_2[] = {1, 2, 10, 11, 12};
+
+	cb_data.index = 0;
+
+	cb_data.values = test_data_1;
+	ck_assert_int_eq(cpu_list_iterate("1,2,3,4", cpu_list_iterate_callback, &cb_data), 4);
+	ck_assert_int_eq(cb_data.index, 4);
+	cb_data.index = 0;
+	ck_assert_int_eq(cpu_list_iterate("1-4", cpu_list_iterate_callback, &cb_data), 4);
+	ck_assert_int_eq(cb_data.index, 4);
+	cb_data.index = 0;
+	ck_assert_int_eq(cpu_list_iterate("1,2-3,4", cpu_list_iterate_callback, &cb_data), 4);
+	ck_assert_int_eq(cb_data.index, 4);
+	cb_data.index = 0;
+	ck_assert_int_eq(cpu_list_iterate("1-3,4", cpu_list_iterate_callback, &cb_data), 4);
+	ck_assert_int_eq(cb_data.index, 4);
+	cb_data.index = 0;
+	ck_assert_int_eq(cpu_list_iterate("1,2-4", cpu_list_iterate_callback, &cb_data), 4);
+	ck_assert_int_eq(cb_data.index, 4);
+
+	cb_data.index = 0;
+	ck_assert_int_eq(cpu_list_iterate("1,2-4", cpu_list_iterate_callback_error, &cb_data), 4);
+	ck_assert_int_eq(cb_data.index, 4);
+	cb_data.index = 0;
+	cb_data.values = test_data_2;
+	ck_assert_int_eq(cpu_list_iterate("1,2,10-12", cpu_list_iterate_callback_error, &cb_data),
+			 -42);
+	ck_assert_int_eq(cb_data.index, 3);
+}
+END_TEST
+
 START_TEST(test_parse_cpu_set)
 {
 	cpu_set_t set;
@@ -98,6 +159,7 @@ Suite *utils_suite(void)
 	TCase *tc = tcase_create("core");
 
 	tcase_add_test(tc, test_strtoi);
+	tcase_add_test(tc, test_cpu_list_iterate);
 	tcase_add_test(tc, test_parse_cpu_set);
 	tcase_add_test(tc, test_parse_prio);
 
-- 
2.55.0

