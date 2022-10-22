Return-Path: <linux-trace-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88E4C04A95
	for <linux-trace-kernel@archiver.kernel.org>; Sat, 22 Oct 2022 06:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiJVGiv (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Sat, 22 Oct 2022 02:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiJVGis (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 02:38:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A81B2BE8B1;
        Fri, 21 Oct 2022 23:38:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA301B82D9E;
        Sat, 22 Oct 2022 06:38:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5D4C433C1;
        Sat, 22 Oct 2022 06:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666420725;
        bh=bY62hTBQJ31gL+KVZA6HgcBV6Ejt4okmOmL2uvIJQ5g=;
        h=From:To:Cc:Subject:Date:From;
        b=PO3LfiuEwqRAa/H4cbUxJRSsUVDiBb5vV4Pb1HQgkYU0RYkvgceCuKgdHJNilSPcv
         ECGK35IkD6U7Cx6t+7s+ptC11NpUCRFxxCcBw7rbHi4AVBtqmmKKgcKgLm97MtmGvM
         zFV9FO7L37EsaS+BdJmvkFhtQQrWne4KJ0jFMCmIyqZlyfYRsEZ+LORipmS7roHJHf
         snptN1Yz4JKs5/Phv3GXg+HjhOfJRDO9GUqVpwMsjtQ78gZf7Ant69666gZjI+/nJc
         bMJONj1Z020p3jdw38ItRkiYV1VqqbQJiAjajQANEqwQHh5H1IKyklTo8gilra34mT
         vL757XMhQOwOw==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Primiano Tucci <primiano@google.com>
Subject: [PATCH 0/2] tracing/probes: Add 'symstr' type for probes
Date:   Sat, 22 Oct 2022 15:38:42 +0900
Message-Id:  <166642072204.718058.1479401089273534841.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Hi,

Here is a couple of patches to add the 'symstr' type for kprobe/eprobe
events.
This type converts given value into kernel symbol string and stores
it as a dymanic symbol in the trace ring buffer entry. Thus, user who
reads the raw ring buffer data doesn't need to resolve the symbol
name afterwards.

This is similar to the existing 'symbol' type. The 'symbol' type
stores the address value itself to the entry, it only *shows* the
symbol name when it is printed.

Thank you,

---

Masami Hiramatsu (Google) (2):
      tracing/probes: Add symstr type for dynamic events
      tracing/probes: Reject symbol/symstr type for uprobe


 Documentation/trace/kprobetrace.rst                |    8 ++
 kernel/trace/trace.c                               |    2 -
 kernel/trace/trace_probe.c                         |   65 +++++++++++++-------
 kernel/trace/trace_probe.h                         |   19 ++++--
 kernel/trace/trace_probe_tmpl.h                    |   47 ++++++++++++++
 kernel/trace/trace_uprobe.c                        |    3 +
 .../ftrace/test.d/kprobe/uprobe_syntax_errors.tc   |    5 ++
 7 files changed, 113 insertions(+), 36 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
