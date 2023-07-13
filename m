Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C385EC04A94
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 13 Jul 2023 15:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjGMPpQ (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 13 Jul 2023 11:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjGMPpP (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:45:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5792680;
        Thu, 13 Jul 2023 08:45:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2FC961881;
        Thu, 13 Jul 2023 15:45:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F5E4C433C7;
        Thu, 13 Jul 2023 15:45:12 +0000 (UTC)
Date:   Thu, 13 Jul 2023 11:45:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Zheng Yejian <zhengyejian1@huawei.com>
Subject: [PATCH 0/2] tracing: Clean up how iter is freed
Message-ID: <20230713114510.04c452ca@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

Steven Rostedt (Google) (2):
      tracing: Remove unnecessary copying of tr->current_trace
      tracing: Add free_trace_iter_content() helper function
----
 kernel/trace/trace.c | 62 +++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 31 insertions(+), 31 deletions(-)
