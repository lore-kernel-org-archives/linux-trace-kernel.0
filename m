Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A36C38142
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 31 Jan 2023 16:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjAaQPd (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 31 Jan 2023 11:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbjAaQPa (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 11:15:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034725423B;
        Tue, 31 Jan 2023 08:15:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FB9561590;
        Tue, 31 Jan 2023 16:15:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD25FC433D2;
        Tue, 31 Jan 2023 16:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675181725;
        bh=Q2EPanjPmFZeesRSm0BQ+4z8xT5vyStaiZMkawcpuzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IVg+/izi9e92w+V3WqBN3kncunlA5E1TQu1gJ+qxEPus3+HlyeKN4VbQskiValGrz
         LZqY1I8EB+pvEXrMdAYb5v9h0PRzGDvUF9dPWBBdVQSe4PsWs7CJcG92TVQivFDbMz
         Cne3rDjewGQp76toIzdQB8ib/gRS97PoKSMriXrhop5KVX7Z5WZ0X9Qm/Rr5mwwJp0
         B6dHc1lWHECN+fL9FqjtQo64DWkE/eHtggsvOwWavxMSqdANJUxD8yiW0dE/yAP0J0
         vmbBV4ceAQWRvbcSWVliR51Edmf7e3/Z3gORlubqZTvK/aEpKqmroPpucX0u+A0WNV
         9Ad5x5FdEBLzg==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        mhiramat@kernel.org, Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v2 02/10] lib/test_fprobe: Add private entry_data testcases
Date:   Wed,  1 Feb 2023 01:15:21 +0900
Message-Id:  <167518172159.336834.7401065319752710790.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
In-Reply-To:  <167518170369.336834.15310137713178284219.stgit@mhiramat.roam.corp.google.com>
References:  <167518170369.336834.15310137713178284219.stgit@mhiramat.roam.corp.google.com>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Add test cases for checking whether private entry_data is
correctly passed or not.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 lib/test_fprobe.c |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/lib/test_fprobe.c b/lib/test_fprobe.c
index e4f65d114ed2..6c7ef5acea21 100644
--- a/lib/test_fprobe.c
+++ b/lib/test_fprobe.c
@@ -38,6 +38,12 @@ static notrace void fp_entry_handler(struct fprobe *fp, unsigned long ip,
 	if (ip != target_ip)
 		KUNIT_EXPECT_EQ(current_test, ip, target2_ip);
 	entry_val = (rand1 / div_factor);
+	if (fp->entry_data_size) {
+		KUNIT_EXPECT_NOT_NULL(current_test, data);
+		if (data)
+			*(u32 *)data = entry_val;
+	} else
+		KUNIT_EXPECT_NULL(current_test, data);
 }
 
 static notrace void fp_exit_handler(struct fprobe *fp, unsigned long ip,
@@ -53,6 +59,12 @@ static notrace void fp_exit_handler(struct fprobe *fp, unsigned long ip,
 		KUNIT_EXPECT_EQ(current_test, ret, (rand1 / div_factor));
 	KUNIT_EXPECT_EQ(current_test, entry_val, (rand1 / div_factor));
 	exit_val = entry_val + div_factor;
+	if (fp->entry_data_size) {
+		KUNIT_EXPECT_NOT_NULL(current_test, data);
+		if (data)
+			KUNIT_EXPECT_EQ(current_test, *(u32 *)data, entry_val);
+	} else
+		KUNIT_EXPECT_NULL(current_test, data);
 }
 
 /* Test entry only (no rethook) */
@@ -134,6 +146,23 @@ static void test_fprobe_syms(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 0, unregister_fprobe(&fp));
 }
 
+/* Test private entry_data */
+static void test_fprobe_data(struct kunit *test)
+{
+	struct fprobe fp = {
+		.entry_handler = fp_entry_handler,
+		.exit_handler = fp_exit_handler,
+		.entry_data_size = sizeof(u32),
+	};
+
+	current_test = test;
+	KUNIT_EXPECT_EQ(test, 0, register_fprobe(&fp, "fprobe_selftest_target", NULL));
+
+	target(rand1);
+
+	KUNIT_EXPECT_EQ(test, 0, unregister_fprobe(&fp));
+}
+
 static unsigned long get_ftrace_location(void *func)
 {
 	unsigned long size, addr = (unsigned long)func;
@@ -159,6 +188,7 @@ static struct kunit_case fprobe_testcases[] = {
 	KUNIT_CASE(test_fprobe_entry),
 	KUNIT_CASE(test_fprobe),
 	KUNIT_CASE(test_fprobe_syms),
+	KUNIT_CASE(test_fprobe_data),
 	{}
 };
 

