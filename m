Return-Path: <linux-trace-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1F6C43219
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 23 Nov 2022 19:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238590AbiKWT2W (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 23 Nov 2022 14:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240047AbiKWT1p (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 14:27:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBD712627;
        Wed, 23 Nov 2022 11:27:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 582E361E79;
        Wed, 23 Nov 2022 19:27:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9537C433B5;
        Wed, 23 Nov 2022 19:27:42 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oxvPJ-000vyg-22;
        Wed, 23 Nov 2022 14:27:41 -0500
Message-ID: <20221123192556.738176467@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 23 Nov 2022 14:25:56 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zheng Yejian <zhengyejian1@huawei.com>
Subject: [PATCH 0/2] tracing: Prevent UAF on reused trace event type numbers
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Steven Rostedt (Google) (2):
      tracing: Add tracing_reset_all_online_cpus_unlocked() function
      tracing: Free buffers when a used dynamic event is removed

----
 kernel/trace/trace.c              | 11 ++++++++++-
 kernel/trace/trace.h              |  1 +
 kernel/trace/trace_dynevent.c     |  2 ++
 kernel/trace/trace_events.c       | 13 +++++++++++--
 kernel/trace/trace_events_synth.c |  2 --
 5 files changed, 24 insertions(+), 5 deletions(-)
