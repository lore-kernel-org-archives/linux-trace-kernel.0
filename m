Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFCBEB64DA
	for <linux-trace-kernel@archiver.kernel.org>; Fri,  7 Jul 2023 13:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjGGNkv (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 7 Jul 2023 09:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjGGNku (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 09:40:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED9F1FF7;
        Fri,  7 Jul 2023 06:40:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CB6661961;
        Fri,  7 Jul 2023 13:40:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4463C433C8;
        Fri,  7 Jul 2023 13:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688737249;
        bh=nfU4BCuqJ0MrhHvJAT42oTBJtlqfuNiNGoro5pxyYNk=;
        h=From:To:Cc:Subject:Date:From;
        b=hBIFJhQ1YM9AiQcV/Bd0yUAWyh5+1BQDlx3F4AACjmSwvNrcEJsuhQ7AcBwKpheaU
         RoNxU/KpI5KwhEr5uHNdxf2PC0Beh+SQ9RBwMt3R/XCTYZ9PgbZdDSmo8mxOOTP41J
         IZT9YKr3k62rbMqEWOwA22PbUe2Qgumt9cqHW1AYyJWsyodY4wn7RmynNQyXsZJaNP
         dynt1rAL8lqlYej97VcptWXQUszJIViGXx1aSX590cddTYyzoeFaNAiXE9W8m3QiML
         O0VW9swaOWaP7jUWZwxAgjbXQWcHPIgutlL5SI/wkSg+fpj1iTKrPYYlZhK/EEZNsZ
         JZUly6tg5IKew==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v2 0/4] tracing/probes: Fix bugs in process_fetch_insn
Date:   Fri,  7 Jul 2023 22:40:45 +0900
Message-ID:  <168873724526.2687993.15242662075324919195.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Hi,

Here are the 2nd version of fix bugs in process_fetch_insn_*().
The previous version is here;

https://lore.kernel.org/all/168830922841.2278819.9165254236027770818.stgit@mhiramat.roam.corp.google.com/

The first patch [1/4] just updated the description. [2/4] has been
changed because previous one did not consider to store the array data.
So instead of exit, just clear the 'ret' if it has any error code.
[3/4] reverts the patch which did not work. And [4/4] makes each
fetch_store_string*() always updates the data_loc, instead of clearing
it in store_trace_args().

Thank you,

---

Masami Hiramatsu (Google) (4):
      tracing/probes: Fix to avoid double count of the string length on the array
      tracing/probes: Fix not to count error code to total length
      Revert "tracing: Add "(fault)" name injection to kernel probes"
      tracing/probes: Fix to record 0-length data_loc in fetch_store_string*() if fails


 kernel/trace/trace_events_synth.c |    2 +-
 kernel/trace/trace_probe_kernel.h |   29 ++++-------------------------
 kernel/trace/trace_probe_tmpl.h   |   10 +++++-----
 kernel/trace/trace_uprobe.c       |    3 ++-
 4 files changed, 12 insertions(+), 32 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
