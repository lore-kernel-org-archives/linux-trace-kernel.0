Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D341AEB64D9
	for <linux-trace-kernel@archiver.kernel.org>; Sat,  8 Jul 2023 02:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbjGHCtN (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 7 Jul 2023 22:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbjGHCtI (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 22:49:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97960212C;
        Fri,  7 Jul 2023 19:49:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21FE261AE0;
        Sat,  8 Jul 2023 02:49:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E2DC433C7;
        Sat,  8 Jul 2023 02:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688784543;
        bh=jw6d8p0evmmLgL+3c21Ikyeph2z5FEfOBl7kFpuv2U0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NqFJ3xRS0mFlcru88HYiqy7sqVf++U7zAEpwNji4RcRi1Zy5DwwLqbAV72a10GVkq
         ZqXtXTsMkkmFXPdYEqcbPVPNSUnC3zEuntaSn82kRwwuzah7yxainG13YiGuVMsd9I
         i401iT2/Nq45gVqjlXHX8Sw3Oq29RzVTXFOY27tDQKtLpUj12SC6guP8vULJJki3VM
         mIpW8BZaNUUeFFg4Q1DgfO8mXsobxtzmTK2w/LWC97ZFIk1th0Rz0HJch0QNVlwLlL
         ECSCXvP0aZjwOEcV7iQ+clEbGcXbq6x+rGVE7++gEwjCIMKuKtiG5PUCaeJdgq0W4o
         Gr61VQbVUTnqg==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v3 4/4] tracing/probes: Fix to record 0-length data_loc in fetch_store_string*() if fails
Date:   Sat,  8 Jul 2023 11:48:58 +0900
Message-ID:  <168878453829.2721251.15110493517953858343.stgit@mhiramat.roam.corp.google.com>
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

Fix to record 0-length data to data_loc in fetch_store_string*() if it fails
to get the string data.
Currently those expect that the data_loc is updated by store_trace_args() if
it returns the error code. However, that does not work correctly if the
argument is an array of strings. In that case, store_trace_args() only clears
the first entry of the array (which may have no error) and leaves other
entries. So it should be cleared by fetch_store_string*() itself.
Also, 'dyndata' and 'maxlen' in store_trace_args() should be updated
only if it is used (ret > 0 and argument is a dynamic data.)

Fixes: 40b53b771806 ("tracing: probeevent: Add array type support")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_probe_kernel.h |    6 ++----
 kernel/trace/trace_probe_tmpl.h   |    4 +---
 kernel/trace/trace_uprobe.c       |    3 ++-
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace_probe_kernel.h b/kernel/trace/trace_probe_kernel.h
index 6deae2ce34f8..37d5696ed768 100644
--- a/kernel/trace/trace_probe_kernel.h
+++ b/kernel/trace/trace_probe_kernel.h
@@ -55,8 +55,7 @@ fetch_store_string_user(unsigned long addr, void *dest, void *base)
 	__dest = get_loc_data(dest, base);
 
 	ret = strncpy_from_user_nofault(__dest, uaddr, maxlen);
-	if (ret >= 0)
-		*(u32 *)dest = make_data_loc(ret, __dest - base);
+	*(u32 *)dest = make_data_loc((ret >= 0) ? ret : 0, __dest - base);
 
 	return ret;
 }
@@ -87,8 +86,7 @@ fetch_store_string(unsigned long addr, void *dest, void *base)
 	 * probing.
 	 */
 	ret = strncpy_from_kernel_nofault(__dest, (void *)addr, maxlen);
-	if (ret >= 0)
-		*(u32 *)dest = make_data_loc(ret, __dest - base);
+	*(u32 *)dest = make_data_loc((ret >= 0) ? ret : 0, __dest - base);
 
 	return ret;
 }
diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index ed9d57c6b041..bbad0503f166 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -267,9 +267,7 @@ store_trace_args(void *data, struct trace_probe *tp, void *rec,
 		if (unlikely(arg->dynamic))
 			*dl = make_data_loc(maxlen, dyndata - base);
 		ret = process_fetch_insn(arg->code, rec, dl, base);
-		if (unlikely(ret < 0 && arg->dynamic)) {
-			*dl = make_data_loc(0, dyndata - base);
-		} else {
+		if (unlikely(ret > 0 && arg->dynamic)) {
 			dyndata += ret;
 			maxlen -= ret;
 		}
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 8b92e34ff0c8..7b47e9a2c010 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -170,7 +170,8 @@ fetch_store_string(unsigned long addr, void *dest, void *base)
 			 */
 			ret++;
 		*(u32 *)dest = make_data_loc(ret, (void *)dst - base);
-	}
+	} else
+		*(u32 *)dest = make_data_loc(0, (void *)dst - base);
 
 	return ret;
 }

