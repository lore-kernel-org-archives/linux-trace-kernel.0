Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7187930BF69
	for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Aug 2026 13:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786715759; cv=none; b=OIXOlOSdRze+JcExx5yzuqcncotfjduyeD67yd19YrkjUYJTYIh6q/wSivrysWkfpmUUC0wDTdvdyCanKCtD7Ps7CVamZqsqsov4jEyq201BW+h6IvtsDqGASvdWFeKOop1avE5bTHnNp+cJaeJKfqIfNyZEcGUEdsq7Nye7zwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786715759; c=relaxed/simple;
	bh=Y/5SyS3gwj9KjuvhfhI5U5SNRgbHxgZHdzwTve78Emo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=cByb0fPozKeVZ3nI345YdqJD7+8Gb6+CtSJx7VOpkskD/fPZ+N4GKr05Qo5yxd53JXERKQuGRArQV5D+3j8gSSQyumtg0fQlMGoYdrqvMMQBMa+QNTQmSArCnDuKMbo4A8twu9MC0sXLJ0oUSR1O5vz76Kgf3TvRtohRMM+pNcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iej6kESo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iej6kESo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786715753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qwll/rx1QVHE0RLr1ij+LcJY3pppLEwm58AIGj5D33k=;
	b=iej6kESoY8LsH13VcOCctrx0HtkpY+GVdI0yjf+VX7LE21/TR2CeXDKcEYuJWMVQyHVFaQ
	FkkMvkghwirbARlcHNaZFAC6tAuXfRQNyZhQLhHeJgFvKm78/djojl0AbSJ4GSt7lZ7k7d
	7oox5YKhBHiJVcBvgdKNUcMNLhgQolE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-T1c88Km9M9GqnCtG3iDVPQ-1; Fri,
 14 Aug 2026 09:55:52 -0400
X-MC-Unique: T1c88Km9M9GqnCtG3iDVPQ-1
X-Mimecast-MFC-AGG-ID: T1c88Km9M9GqnCtG3iDVPQ_1786715751
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3D9A619560A5;
	Fri, 14 Aug 2026 13:55:51 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.33.92])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ECBCA18005AC;
	Fri, 14 Aug 2026 13:55:47 +0000 (UTC)
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
Subject: [PATCH 5/5] rtla/tests: Add unit test for get_max_cpu_from_list()
Date: Fri, 14 Aug 2026 15:55:11 +0200
Message-ID: <20260814135511.2207190-6-tglozar@redhat.com>
In-Reply-To: <20260814135511.2207190-1-tglozar@redhat.com>
References: <20260814135511.2207190-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: zN8sZFJQF032Pojit735Y-xX8uDtaUtG6wpKedgXJ4M_1786715751
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The get_max_cpu_from_list() function is used when parsing osnoise cpus
"all" value. Furthermore, the callback used by it is also used in
get_possible_cpus().

Add unit test to cover it.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/tests/unit/utils.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/tracing/rtla/tests/unit/utils.c b/tools/tracing/rtla/tests/unit/utils.c
index 0cb5e217c56eb..cdd84ff895f86 100644
--- a/tools/tracing/rtla/tests/unit/utils.c
+++ b/tools/tracing/rtla/tests/unit/utils.c
@@ -95,6 +95,14 @@ START_TEST(test_cpu_list_iterate)
 }
 END_TEST
 
+START_TEST(test_get_max_cpu_from_list)
+{
+	ck_assert_int_eq(get_max_cpu_from_list("1,2,3,4-60"), 60);
+	ck_assert_int_eq(get_max_cpu_from_list("2,1-7,4"), 7);
+	ck_assert_int_eq(get_max_cpu_from_list("invalid"), -1);
+}
+END_TEST
+
 START_TEST(test_parse_cpu_set)
 {
 	cpu_set_t set;
@@ -160,6 +168,7 @@ Suite *utils_suite(void)
 
 	tcase_add_test(tc, test_strtoi);
 	tcase_add_test(tc, test_cpu_list_iterate);
+	tcase_add_test(tc, test_get_max_cpu_from_list);
 	tcase_add_test(tc, test_parse_cpu_set);
 	tcase_add_test(tc, test_parse_prio);
 
-- 
2.55.0

