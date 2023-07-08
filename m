Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF9EEB64DA
	for <linux-trace-kernel@archiver.kernel.org>; Sat,  8 Jul 2023 02:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbjGHCtC (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 7 Jul 2023 22:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbjGHCsv (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 22:48:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941D526A1;
        Fri,  7 Jul 2023 19:48:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33FB161A18;
        Sat,  8 Jul 2023 02:48:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6EA3C433C8;
        Sat,  8 Jul 2023 02:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688784525;
        bh=AdroxX5P9OziwCjJV/WVhJbrj4bvgg6m7fGwBk22czA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DSM9l8EFM7HHYFFC8QWSK5rY0UxRJtMfP6c1GyRdfeprm+8X73RbWZQSpgTyOI+K5
         VY4lXrL5xkZ0MKwiatdTYGT7EHQkbrv4TPQ/TiZvYhhAjEMA3rNIdLP+o0GhrCKD53
         o2C7o7v4hLYSyiXSLP7atrFBmuztri7DsIhbkpenOa6SgbtRF0LOorxWgTDXkT9bpV
         nsCe4tdZKKY5b6/WYfZMHBUObdkDjk3mt7dOr2l9EeGtVQc3ruAVMjXJok4qDiUfEl
         eGH3pro7Ru3H/JX24cxhUJqhhSpwosBTdnYoQYbyBOLYpmXt++xczD3ulOOHOfWB2v
         fC1Shf1u3eN4A==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v3 2/4] tracing/probes: Fix not to count error code to total length
Date:   Sat,  8 Jul 2023 11:48:41 +0900
Message-ID:  <168878452101.2721251.10090404317111770311.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
In-Reply-To:  <168878450334.2721251.3030778817503575503.stgit@mhiramat.roam.corp.google.com>
References:  <168878450334.2721251.3030778817503575503.stgit@mhiramat.roam.corp.google.com>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Fix not to count the error code (which is minus value) to the total
used length of array, because it can mess up the return code of
process_fetch_insn_bottom(). Also clear the 'ret' value because it
will be used for calculating next data_loc entry.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/8819b154-2ba1-43c3-98a2-cbde20892023@moroto.mountain/
Fixes: 9b960a38835f ("tracing: probeevent: Unify fetch_insn processing common part")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes in v2:
 - Check and clear ret only for the array argument.
---
 kernel/trace/trace_probe_tmpl.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index 4735c5cb76fa..ed9d57c6b041 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -204,6 +204,8 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
 array:
 	/* the last stage: Loop on array */
 	if (code->op == FETCH_OP_LP_ARRAY) {
+		if (ret < 0)
+			ret = 0;
 		total += ret;
 		if (++i < code->param) {
 			code = s3;

