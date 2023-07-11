Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2840EB64D9
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 11 Jul 2023 02:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjGKCLV (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 10 Jul 2023 22:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjGKCLV (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 22:11:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64035E1;
        Mon, 10 Jul 2023 19:11:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEDB861143;
        Tue, 11 Jul 2023 02:11:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A14FC433C7;
        Tue, 11 Jul 2023 02:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689041479;
        bh=m5zH5mj7zoJ1f1B+N42bt19Cic4vyFBBXFpmA2ahLKY=;
        h=From:To:Cc:Subject:Date:From;
        b=tlYYHe4Rh8gRp18dK7OwlfbtZDz3o6//XRmKFGCilyOCEehKXK7sk1pSnNr9frOxX
         QDrlz0XK3OqbgBED3VESg+ZCpOPYW3H8h38zQwHHrLIP/9ynKKokYkcKHecsJnOjvT
         nWJRyiTmqHVuzNgzxsqpYQ9Fvaej/kukm7afFmiDg4RW+FT7HU3LaZtc7TxlFpMqpI
         tDdHA/y051j2xb5ACi/+7nbMvSU658nG0YNyjQujPVnBeH1/LQHnrd7mExEISQXrWB
         bT/DsaH4lmqJoJUSY0RwIlcmdnFfir8MLmYq/UtzG9KxAkQgivp7t/IHRsGydIoNmB
         iNTj7hp6cUC9w==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v4 0/4] tracing/probes: Fix bugs in process_fetch_insn
Date:   Tue, 11 Jul 2023 11:11:15 +0900
Message-ID:  <168904147563.2908673.18054267804278861545.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Hi,

Here are the 4th version of fix bugs in process_fetch_insn_*().
The previous version is here;

https://lore.kernel.org/all/168878450334.2721251.3030778817503575503.stgit@mhiramat.roam.corp.google.com/

[4/4] is updated to simplify the code with set_data_loc().

Thank you,

---

Masami Hiramatsu (Google) (4):
      tracing/probes: Fix to avoid double count of the string length on the array
      tracing/probes: Fix not to count error code to total length
      Revert "tracing: Add "(fault)" name injection to kernel probes"
      tracing/probes: Fix to record 0-length data_loc in fetch_store_string*() if fails


 kernel/trace/trace.h              |    2 ++
 kernel/trace/trace_probe.c        |    2 +-
 kernel/trace/trace_probe_kernel.h |   30 ++++++++----------------------
 kernel/trace/trace_probe_tmpl.h   |   10 +++++-----
 kernel/trace/trace_uprobe.c       |    3 ++-
 5 files changed, 18 insertions(+), 29 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
