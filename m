Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00B3EB64DD
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 25 Jul 2023 01:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjGYBh2 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 24 Jul 2023 21:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjGYBh1 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 21:37:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E643B1999;
        Mon, 24 Jul 2023 18:37:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43764614B3;
        Tue, 25 Jul 2023 01:37:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52EE7C433C8;
        Tue, 25 Jul 2023 01:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690249043;
        bh=cvdO36sarOiv5ZpCKU2EQAmrbByydT2MCd5DqCQtaFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EEj/E2Mycd/XZbLGupp5s+8D92HNLgkPGx5U4N1chxUQYnai33YzObkt0amlp6B5g
         Ccu4gS6hmfSEnEnoCCTJ2m6mhb4w0wt5gapkbjqMlQSz4zQECibfcPbnXBk34qI9hi
         MrPgmNDygVn0NQP+YjXvJemZFfaW6FCLq4WeeHIjsxB1sNIWcpBjnrBI81vyYInpdI
         q4KBDxS9zjz5kXljewbBOaqQ6X/BJh/GugFqBjtdez7ENbLrQ+vFI81LdXKpX+yG4t
         /i0dsNR6DrOLctEOWzhwbq4Vp8tVU11WPr9t5GuNaTkItt6VQccBZFxBxaDdKTGo6L
         m9k+H632j2L4g==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, mhiramat@kernel.org
Subject: [PATCH 1/2] tracing/probes: Fix to add NULL check for BTF APIs
Date:   Tue, 25 Jul 2023 10:37:19 +0900
Message-Id: <169024903951.395371.11361556840733470934.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169024903018.395371.1006584451160707296.stgit@devnote2>
References: <169024903018.395371.1006584451160707296.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Since find_btf_func_param() abd btf_type_by_id() can return NULL,
the caller must check the return value correctly.

Fixes: b576e09701c7 ("tracing/probes: Support function parameters if BTF is available")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_probe.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index b2b726bea1f9..c68a72707852 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -386,12 +386,12 @@ static const struct btf_type *find_btf_func_proto(const char *funcname)
 
 	/* Get BTF_KIND_FUNC type */
 	t = btf_type_by_id(btf, id);
-	if (!btf_type_is_func(t))
+	if (!t || !btf_type_is_func(t))
 		return ERR_PTR(-ENOENT);
 
 	/* The type of BTF_KIND_FUNC is BTF_KIND_FUNC_PROTO */
 	t = btf_type_by_id(btf, t->type);
-	if (!btf_type_is_func_proto(t))
+	if (!t || !btf_type_is_func_proto(t))
 		return ERR_PTR(-ENOENT);
 
 	return t;
@@ -443,7 +443,7 @@ static int parse_btf_arg(const char *varname, struct fetch_insn *code,
 	if (!ctx->params) {
 		params = find_btf_func_param(ctx->funcname, &ctx->nr_params,
 					     ctx->flags & TPARG_FL_TPOINT);
-		if (IS_ERR(params)) {
+		if (IS_ERR_OR_NULL(params)) {
 			trace_probe_log_err(ctx->offset, NO_BTF_ENTRY);
 			return PTR_ERR(params);
 		}
@@ -1273,7 +1273,7 @@ const char **traceprobe_expand_meta_args(int argc, const char *argv[],
 
 	params = find_btf_func_param(ctx->funcname, &nr_params,
 				     ctx->flags & TPARG_FL_TPOINT);
-	if (IS_ERR(params)) {
+	if (IS_ERR_OR_NULL(params)) {
 		if (args_idx != -1) {
 			/* $arg* requires BTF info */
 			trace_probe_log_err(0, NOSUP_BTFARG);

