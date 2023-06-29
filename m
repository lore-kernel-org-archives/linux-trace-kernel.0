Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7E7EB64D9
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 29 Jun 2023 14:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbjF2ONx (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 29 Jun 2023 10:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjF2ONw (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 10:13:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643791738;
        Thu, 29 Jun 2023 07:13:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC05761546;
        Thu, 29 Jun 2023 14:13:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1233CC433C0;
        Thu, 29 Jun 2023 14:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688048030;
        bh=m7fseDBhPX1IzVbpXSstpX3+zK+fdP0lb9n1W+GBLxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bW+0POmJtNAG+tkcvM8tZCWW+S+VgKKznjveQu/hsEIdoW3B3vLLBnXYpvAWzL4YA
         fkH01DVZ22jjIzBho2/hcrkiGjVgplTgXzP5VasYalNxIwbf0asjspRS7Efl5P9tkd
         5gJ+Sky2sr9hHRpCvuJxLQfI/TcINHWIgQIpCA1Kyomlv3XRwdkbIWNVTODUa/zwHM
         c4s0LqjKxgYie9DiKI8QJ4BUOsa9Fs1pLQbpvQ8EXp5OE3FZf6NFxN4e++AQ/FYPh1
         TIlmendcIBw4P6Nfs9lDv4oXffyvgFL93fZipovQ66LAC9xwj2MYD626ISFzN7dJer
         DYNmAPZHKDp4A==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 2/2] tracing/probes: Fix to exit fetching if an error is detected
Date:   Thu, 29 Jun 2023 23:13:46 +0900
Message-ID:  <168804802668.2028538.4634073314317984220.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
In-Reply-To: <8819b154-2ba1-43c3-98a2-cbde20892023@moroto.mountain>
References: <8819b154-2ba1-43c3-98a2-cbde20892023@moroto.mountain>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Fix to exit fetching arguments if an error is detected when storing
strings. Without this fix, if an array is specified with string types
it may point wrong address to store the data.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/8819b154-2ba1-43c3-98a2-cbde20892023@moroto.mountain/
Fixes: 9b960a38835f ("tracing: probeevent: Unify fetch_insn processing common part")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_probe_tmpl.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index 4735c5cb76fa..d6f2bf69f9bc 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -193,6 +193,8 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
 	default:
 		return -EILSEQ;
 	}
+	if (ret < 0)
+		return ret;
 	code++;
 
 	/* 4th stage: modify stored value if needed */

