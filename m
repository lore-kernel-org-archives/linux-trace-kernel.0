Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FAAEC8747
	for <linux-trace-kernel@archiver.kernel.org>; Fri,  8 Sep 2023 02:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240862AbjIHCTu (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 7 Sep 2023 22:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjIHCTt (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 22:19:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908811BCD;
        Thu,  7 Sep 2023 19:19:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B0FC433C8;
        Fri,  8 Sep 2023 02:19:45 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qeR6H-000MXt-16;
        Thu, 07 Sep 2023 22:20:01 -0400
Message-ID: <20230908021910.507739229@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 07 Sep 2023 22:19:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ajay Kaher <akaher@vmware.com>
Subject: [PATCH 0/2] tracing: Remove 'dir' from trace_event_file structure
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

The dir field is no longer used by the trace_event_file structure
as it was replaced by the tracefs 'ef' field. This caused a bug
to keep the "print" event from getting the "trigger" added to it.


Steven Rostedt (Google) (2):
      tracing: Use the new eventfs descriptor for print trigger
      tracing: Remove unused trace_event_file dir field

----
 include/linux/trace_events.h |  1 -
 kernel/trace/trace.c         |  4 ++--
 kernel/trace/trace_events.c  | 13 -------------
 3 files changed, 2 insertions(+), 16 deletions(-)
