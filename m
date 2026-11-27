Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793587;
	b=zUKyMziKGYjdc+HU8IVlmfO9SkNo5KaZiyDW4UetqFEnvAdhwN44trGusJxhswZUSMrq
	 Hi86o+UwqjUEvj9Fw3SETjqZsopRf0WTmK2livPkSHKkLhdOnMnlvgRGZUVgy1fNcbyDB
	 vdWl7BOFayoTn03M+tq5noyNHK5pbcZ5PymmfUfQJcTxl0b+dHt4Z4P13uRzdJH0n2HZF
	 QPxv+Mk/mVhXcppI0M010GNUXFwHP6+X74pHxVObrCczP8qwOUqHC1TLMAHRSGRAjlgqx
	 CkOF6MkopO8DEBZDLpu/ZO1hEy+VDImZcB5pDDV8qRimF+EtwQYTTeA6ixRXNpWtY2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793587;
	h=DMARC-Filter:DKIM-Signature:X-MC-Rep:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=jLe+0g9B79BiHJQYfbsPmiKRq1wqgGyG9KYMUvcqfoQ=;
	b=e/5ZP+wDl+LUHIy6Wj3HYfBggHQswDTCcZBeqMj2cIdfrnCK3joHgk+YNYGcBA7a9qkw
	 15bO9lSWFPUtP6SIjX5LqMp1H3Bp/JalIaIuBfNILsQnJMA2lLexJgSkjrZDecolIHNtr
	 3bLpXE7rxryRdqbQLFhk1RG9pgUgfW20iMGeYV/5y87z+CknAcKMdgjsckyD0YAadwy7Z
	 bZXkCqdk6o6BszXLtqc3Ygip9eU1jh8M5RnLJ16Ic/Zq67HJHDauKgqYoap8iYSKO8x1/
	 2Hms4JaYm3ytL9xykcF890XxFPfa9Rb7BL3iiUyE9H1QQ52PcJUJ7/T56asXCCEBbSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P3rFWJvD;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D611606A324
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Nov 2026 15:33:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D611606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P3rFWJvD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795793586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jLe+0g9B79BiHJQYfbsPmiKRq1wqgGyG9KYMUvcqfoQ=;
	b=P3rFWJvDXeCU5Y41NX8wzMiS1GSkCUKbKhrWqC94zKpEMpPi+XDX+FjD3R8e8mF2VehJ5O
	E2sHy0mLSUEkUYo2NeStzTtuxZMXEy5O3ANd+TjHuCSadsuSPIE8rxKNgKzpxh5FUWGxK8
	c5XwoW09ZDJ6efhh1oJIj25ltTLL4Zk=
X-MC-Rep: binary re single
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-Di6dAZGbPSeGF9Hlcg8XrQ-1; Fri,
 27 Nov 2026 15:33:03 +0000
X-MC-Unique: Di6dAZGbPSeGF9Hlcg8XrQ-1
X-Mimecast-MFC-AGG-ID: Di6dAZGbPSeGF9Hlcg8XrQ_1795793582
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 53CAC1800A79;
	Fri, 27 Nov 2026 15:33:02 +0000 (UTC)
Received: from tglozar-thinkpadt14gen5.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4DC241955F76;
	Fri, 27 Nov 2026 15:33:00 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: [RFC PATCH 02/10] rtla/tests: Add unit tests for aa action
Date: Fri, 27 Nov 2026 16:31:58 +0100
Message-ID: <20261127153206.134322-3-tglozar@redhat.com>
In-Reply-To: <20261127153206.134322-1-tglozar@redhat.com>
References: <20261127153206.134322-1-tglozar@redhat.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OeCbF0iF8x-8fKDCn26QWM4O85KH4DXPEuLyLRzqBq4_1795793582
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add unit tests for the new auto-analysis action (aa), mirroring the
existing tests for continue.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/tests/unit/actions.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/tracing/rtla/tests/unit/actions.c b/tools/tracing/rtla/tests/unit/actions.c
index 6d91ad698a925..6ab9638c2d256 100644
--- a/tools/tracing/rtla/tests/unit/actions.c
+++ b/tools/tracing/rtla/tests/unit/actions.c
@@ -291,6 +291,25 @@ START_TEST(test_actions_parse_continue_arg_bad)
 }
 END_TEST
 
+START_TEST(test_actions_parse_aa)
+{
+	ck_assert_int_eq(actions_parse(&actions_fixture, "aa", NULL), 0);
+
+	ck_assert_int_eq(actions_fixture.len, 1);
+	ck_assert_int_eq(actions_fixture.list[0].type, ACTION_AA);
+	ck_assert(actions_fixture.present[ACTION_AA]);
+}
+END_TEST
+
+START_TEST(test_actions_parse_aa_arg_bad)
+{
+	ck_assert_int_eq(actions_parse(&actions_fixture, "aa,foo=bar", NULL), -1);
+
+	ck_assert_int_eq(actions_fixture.len, 0);
+	ck_assert(!actions_fixture.present[ACTION_AA]);
+}
+END_TEST
+
 START_TEST(test_actions_parse_invalid)
 {
 	ck_assert_int_eq(actions_parse(&actions_fixture, "foobar", NULL), -1);
@@ -378,6 +397,8 @@ Suite *actions_suite(void)
 	tcase_add_test(tc, test_actions_parse_shell_arg_bad);
 	tcase_add_test(tc, test_actions_parse_continue);
 	tcase_add_test(tc, test_actions_parse_continue_arg_bad);
+	tcase_add_test(tc, test_actions_parse_aa);
+	tcase_add_test(tc, test_actions_parse_aa_arg_bad);
 	tcase_add_test(tc, test_actions_parse_invalid);
 	suite_add_tcase(s, tc);
 
-- 
2.56.1

