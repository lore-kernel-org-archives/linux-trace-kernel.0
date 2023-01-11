Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F15C63797
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 11 Jan 2023 14:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbjAKO7G (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 11 Jan 2023 09:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239528AbjAKO6q (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:58:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EF0A1A3;
        Wed, 11 Jan 2023 06:58:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD272B81C0B;
        Wed, 11 Jan 2023 14:58:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0F0C433EF;
        Wed, 11 Jan 2023 14:58:43 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pFcYs-000M6f-17;
        Wed, 11 Jan 2023 09:58:42 -0500
Message-ID: <20230111145636.450953217@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 11 Jan 2023 09:56:36 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ross Zwisler <zwisler@google.com>
Subject: [PATCH 0/4] tracing: Addition of tracing instances via kernel command line
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Instance creation can happen with the bootconfig but there's currently
no way to create and enable instances via the normal command line.

This series fixes that.

 trace_instance=foo,sched_switch,sched_waking ftrace_boot_snapshot=foo

The above creates a "foo" instance at early start up and enables
the sched_switch and sched_waking events. Then at the end of boot up
a snapshot is taken so that user space does not overwrite the boot
up data.


Steven Rostedt (Google) (4):
      tracing: Add creation of instances at boot command line
      tracing: Add enabling of events to boot instances
      tracing: Add trace_array_puts() to write into instance
      tracing: Allow boot instances to have snapshot buffers

----
 Documentation/admin-guide/kernel-parameters.txt |  29 +++++
 include/linux/trace.h                           |  13 ++
 kernel/trace/trace.c                            | 159 +++++++++++++++++++++---
 kernel/trace/trace.h                            |   2 +
 kernel/trace/trace_events.c                     |   9 +-
 5 files changed, 190 insertions(+), 22 deletions(-)
