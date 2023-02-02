Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FD5C05027
	for <linux-trace-kernel@archiver.kernel.org>; Thu,  2 Feb 2023 15:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbjBBP1C (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 2 Feb 2023 10:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbjBBP1B (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:27:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EAA24103
        for <linux-trace-kernel@vger.kernel.org>; Thu,  2 Feb 2023 07:26:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8408561B8C
        for <linux-trace-kernel@vger.kernel.org>; Thu,  2 Feb 2023 15:26:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74446C433A8;
        Thu,  2 Feb 2023 15:26:15 +0000 (UTC)
Date:   Thu, 2 Feb 2023 10:26:13 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Dan Carpenter <error27@gmail.com>
Cc:     linux-trace-kernel@vger.kernel.org
Subject: Re: [bug report] tracing: Allow synthetic events to pass around
 stacktraces
Message-ID: <20230202102613.5a62f4d5@rorschach.local.home>
In-Reply-To: <Y9uxjD7jwHbjJB1G@kili>
References: <Y9uxjD7jwHbjJB1G@kili>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Thu, 2 Feb 2023 15:50:20 +0300
Dan Carpenter <error27@gmail.com> wrote:

> Hello Steven Rostedt (Google),
> 
> The patch 00cf3d672a9d: "tracing: Allow synthetic events to pass
> around stacktraces" from Jan 17, 2023, leads to the following Smatch
> static checker warning:
> 
> 	kernel/trace/trace_events_synth.c:567 trace_event_raw_event_synth()
> 	warn: inconsistent indenting

Already reported and a fix is pending.

  https://lore.kernel.org/all/20230131095237.63e3ca8d@gandalf.local.home/

Thanks,

-- Steve
