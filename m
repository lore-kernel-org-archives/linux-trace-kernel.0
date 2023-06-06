Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E37C77B73
	for <linux-trace-kernel@archiver.kernel.org>; Tue,  6 Jun 2023 16:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238363AbjFFQN2 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 6 Jun 2023 12:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238358AbjFFQNK (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 12:13:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAE710F4;
        Tue,  6 Jun 2023 09:12:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93CC662DE6;
        Tue,  6 Jun 2023 16:12:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00082C4339E;
        Tue,  6 Jun 2023 16:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686067976;
        bh=NspQ5eSfzkW/s4ZKEIvi8KiViH9J4SR7mF8q0fY8gJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SUtXBjQ4gi424FRAJAf2Lbg14t8Udt17Q1lNOb275daD7+epD2u4HVXHQakeqfdTx
         BmLXKKYW5L5TbtrrdFCyA/b5d6JOy4pd01YgfKbzz1yNgkTOcIrLvbMuPalTxWpbZ/
         LRTytWxeT+b0Izt90iiS98ZXRun49fBSFhZNIkIclFuaDeQPQOWybL30eqzWhVGvWK
         Bn7IAnGAqSGUt3XuzeYcoGTFXQQrhim/8EyYQmPwJgu2DO880EQ/qI67GZKSi/wILd
         tF8/fh4Z0f32tydaH1C8CnEDAiZYnGjXYtTOSkI5da1PYbVwtHTJcoLAstoEzN94AH
         nF7jrOJ2hVnUA==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-doc@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        William White <chwhite@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH V3 08/11] rtla/hwnoise: Reduce runtime to 75%
Date:   Tue,  6 Jun 2023 18:12:22 +0200
Message-Id: <af0b7113ffc00031b9af4bb40ef5889a27dadf8c.1686066600.git.bristot@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1686066600.git.bristot@kernel.org>
References: <cover.1686066600.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

osnoise runs 100% of time by default. It makes sense because osnoise
is preemptive. hwnoise checks preemption once a second, so it
reduces system progress.

Reduce runtime to 75% to avoid problems by default. I added a Fixes
as it might avoid problems for first time users as it lands on distros.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Fixes: 1f428356c38d ("rtla: Add hwnoise tool")
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 tools/tracing/rtla/src/osnoise_top.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 85abba568faf..f7c959be8677 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -348,8 +348,14 @@ struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
 	if (!params)
 		exit(1);
 
-	if (strcmp(argv[0], "hwnoise") == 0)
+	if (strcmp(argv[0], "hwnoise") == 0) {
 		params->mode = MODE_HWNOISE;
+		/*
+		 * Reduce CPU usage for 75% to avoid killing the system.
+		 */
+		params->runtime = 750000;
+		params->period = 1000000;
+	}
 
 	while (1) {
 		static struct option long_options[] = {
-- 
2.38.1

