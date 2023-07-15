Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DD0C001DE
	for <linux-trace-kernel@archiver.kernel.org>; Sat, 15 Jul 2023 14:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjGOONy (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Sat, 15 Jul 2023 10:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjGOONv (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 10:13:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B66C0;
        Sat, 15 Jul 2023 07:13:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2AD460BB1;
        Sat, 15 Jul 2023 14:13:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EAE6C433C8;
        Sat, 15 Jul 2023 14:13:49 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qKg1s-00102r-0L;
        Sat, 15 Jul 2023 10:13:48 -0400
Message-ID: <20230715141213.970003974@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 15 Jul 2023 10:12:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 0/2] tracing: Clean up how iter is freed
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

The trace iterator is used in various interfaces and needs to be consistent
in how it is cleaned up. Add a helper function to clean up its content. But
before doing so, I noticed that iter->trace is allocated then the content
of tr->current_trace is copied to it. There's no reason for this, so the
first patch removes that allocation and just points to the content of
tr->current_trace, as tr->current_trace can change, but the content should
not.

Changes since v1: https://lore.kernel.org/linux-trace-kernel/20230713114510.04c452ca@gandalf.local.home/

 - Updated the change log of patch 1, as I remembered why the copy was done.

 - Remove the allocation and copy of the second patch. I started with the
   second patch and noticed that there was an inconsistency with the
   iter->trace. Where in one place it was allocated and copied and the second
   place it was just pointing to the tr->current_trace. I first started to make it
   be a copy as well, but then realized that the copy wasn't needed. I created
   the first patch but forgot to remove the copy and it ended up in the second
   patch.

Steven Rostedt (Google) (2):
      tracing: Remove unnecessary copying of tr->current_trace
      tracing: Add free_trace_iter_content() helper function

----
 kernel/trace/trace.c | 55 ++++++++++++++++++++++++----------------------------
 1 file changed, 25 insertions(+), 30 deletions(-)
