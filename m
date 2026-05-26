Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13DC3DD516
	for <linux-trace-kernel@vger.kernel.org>; Tue, 26 May 2026 10:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779791154; cv=none; b=Mn2XO4xZAtxkrXDdax3Mk0uyiwfsPQt6sSGDi8sbLM4PYtS081VkctaNpP6QdHFezCLUKMZlql90DYKSXOgCq8azGsgBR0GAb3B9ZUQy81dX8BWZpfVxGFWc80usruzQyPNAvJ/0BCJkE9XDy7JvoFFFKwLpcfzsr9VdDWnCfbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779791154; c=relaxed/simple;
	bh=qYaWHiqABe/gaKPt1xctoer3N1fSct1tDUF7PBnJd/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=MZsf4yCVVxSphc6DsZVro44CQwqeMoUro2bY1z578XpBmz5ODPuIQA7KaPTLIWeMm9m+av41s2ZfZxbCteF3X3Bd4aO6MGoFYzpDHXWMI5I65YEBbd40RQvapIqBtMMdOggVX29pjW+0Mi6h1cmQ7MzO4IVANdKq+GtqQ6wYjeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cY14q44Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cY14q44Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779791151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GDNo+KX8wOx5KmJ9+fjZxYr4nMMzkGcJcU1eeyiqsYE=;
	b=cY14q44YDv4qjkIDeKcwaEaFT1pXNleZ1u04xc5q8ZJ5fB5DfvhPWw49UKTGdU412IncO7
	bFIDRE+m8K7DfeYxyt6vWrP1G2Pc/zgPX5ae+u5ejKjf70oNV/zfAJeRGoVrlDzTYVVy3C
	egFxs1euLn7/bflz0ts6JivK04eH+pM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-1e74TXWiNE-fYACYfxDBtg-1; Tue,
 26 May 2026 06:25:48 -0400
X-MC-Unique: 1e74TXWiNE-fYACYfxDBtg-1
X-Mimecast-MFC-AGG-ID: 1e74TXWiNE-fYACYfxDBtg_1779791147
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 40D361956096;
	Tue, 26 May 2026 10:25:47 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.109])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 143111956056;
	Tue, 26 May 2026 10:25:44 +0000 (UTC)
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
Subject: [PATCH 2/4] rtla/tests: Add unit test for restoring continue flag
Date: Tue, 26 May 2026 12:25:21 +0200
Message-ID: <20260526102523.2662391-2-tglozar@redhat.com>
In-Reply-To: <20260526102523.2662391-1-tglozar@redhat.com>
References: <20260526102523.2662391-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: URlKlsMxNdWFl_FVlmTTg65iUgeVsyb5Yjd_ztcYSl0_1779791147
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

In case an action preceding the continue action fails, not only
the continue flag should not be set, it should be unset if it was set
from a previous run of actions_perform().

Add a unit test to check if this is implemented correctly.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---

Depends on "rtla/tests: Add unit tests for actions module"
- https://lore.kernel.org/linux-trace-kernel/20260424140244.958495-1-tglozar@redhat.com/

 tools/tracing/rtla/tests/unit/actions.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/tracing/rtla/tests/unit/actions.c b/tools/tracing/rtla/tests/unit/actions.c
index a5808ab71a4d..94ad5ad42774 100644
--- a/tools/tracing/rtla/tests/unit/actions.c
+++ b/tools/tracing/rtla/tests/unit/actions.c
@@ -328,6 +328,18 @@ START_TEST(test_actions_perform_continue_after_failed_shell_command)
 }
 END_TEST
 
+START_TEST(test_actions_perform_continue_unset_flag)
+{
+	actions_fixture.continue_flag = true;
+
+	actions_add_shell(&actions_fixture, "exit 1");
+	actions_add_continue(&actions_fixture);
+	ck_assert_int_eq(actions_perform(&actions_fixture), 1 << 8);
+
+	ck_assert(!actions_fixture.continue_flag);
+}
+END_TEST
+
 Suite *actions_suite(void)
 {
 	Suite *s = suite_create("actions");
@@ -374,6 +386,7 @@ Suite *actions_suite(void)
 	tcase_add_test(tc, test_actions_perform_continue);
 	tcase_add_test(tc, test_actions_perform_continue_after_successful_shell_command);
 	tcase_add_test(tc, test_actions_perform_continue_after_failed_shell_command);
+	tcase_add_test(tc, test_actions_perform_continue_unset_flag);
 	suite_add_tcase(s, tc);
 
 	return s;
-- 
2.54.0

