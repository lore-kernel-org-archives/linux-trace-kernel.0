Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6887C38142
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 31 Jan 2023 07:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjAaH6y (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 31 Jan 2023 02:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjAaH6x (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 02:58:53 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D67240BE7;
        Mon, 30 Jan 2023 23:58:52 -0800 (PST)
Received: from localhost.hse.ru (unknown [89.175.18.189])
        by mail.ispras.ru (Postfix) with ESMTPSA id 4DF7340D403D;
        Tue, 31 Jan 2023 07:58:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 4DF7340D403D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1675151927;
        bh=VSnYDxdcyGmtaDCzkcokBqEpatPFN9DVbiQ+CDtfkSQ=;
        h=From:To:Cc:Subject:Date:From;
        b=K2nrPwD7wTKlWfVK4Mw0xxce36pEelcSixpgxcUOGODyQwuSbB6Fe0kbtLkVTeFf5
         YaSqCPB5UOP3nAfWObND2iVnsL8GIDd5Yt1y6wKpN/kGH2a3J2scypFLafP4awwskn
         RP3KX6fHwWE+LHpy8JvKFpc26p/aRfu2bK/1q3UU=
From:   Anton Gusev <aagusev@ispras.ru>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Anton Gusev <aagusev@ispras.ru>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing: Fix wrong return in kprobe_event_gen_test.c
Date:   Tue, 31 Jan 2023 10:58:18 +0300
Message-Id: <20230131075818.5322-1-aagusev@ispras.ru>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Overwriting the error code with the deletion result may cause the
function to return 0 despite encountering an error. Commit b111545d26c0
("tracing: Remove the useless value assignment in
test_create_synth_event()") solves a similar issue by
returning the original error code, so this patch does the same.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Anton Gusev <aagusev@ispras.ru>
---
 kernel/trace/kprobe_event_gen_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/kprobe_event_gen_test.c b/kernel/trace/kprobe_event_gen_test.c
index c736487fc0e4..e0c420eb0b2b 100644
--- a/kernel/trace/kprobe_event_gen_test.c
+++ b/kernel/trace/kprobe_event_gen_test.c
@@ -146,7 +146,7 @@ static int __init test_gen_kprobe_cmd(void)
 	if (trace_event_file_is_valid(gen_kprobe_test))
 		gen_kprobe_test = NULL;
 	/* We got an error after creating the event, delete it */
-	ret = kprobe_event_delete("gen_kprobe_test");
+	kprobe_event_delete("gen_kprobe_test");
 	goto out;
 }
 
@@ -211,7 +211,7 @@ static int __init test_gen_kretprobe_cmd(void)
 	if (trace_event_file_is_valid(gen_kretprobe_test))
 		gen_kretprobe_test = NULL;
 	/* We got an error after creating the event, delete it */
-	ret = kprobe_event_delete("gen_kretprobe_test");
+	kprobe_event_delete("gen_kretprobe_test");
 	goto out;
 }
 
-- 
2.39.1

