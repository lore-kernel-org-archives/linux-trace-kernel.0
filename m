Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DEBC6FD19
	for <linux-trace-kernel@archiver.kernel.org>; Fri, 10 Mar 2023 20:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjCJUC5 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 10 Mar 2023 15:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjCJUCz (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 15:02:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A490A126F32
        for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Mar 2023 12:02:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59EC7B823FD
        for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Mar 2023 20:02:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6350BC433EF;
        Fri, 10 Mar 2023 20:02:21 +0000 (UTC)
Date:   Fri, 10 Mar 2023 15:02:18 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Stefan Roesch <shr@devkernel.io>
Cc:     kernel-team@fb.com, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH v1] mm: add tracepoints to ksm
Message-ID: <20230310150218.31510a60@gandalf.local.home>
In-Reply-To: <qvqwa60k2yt5.fsf@dev0134.prn3.facebook.com>
References: <20230210214645.2720847-1-shr@devkernel.io>
        <20230309172726.14fca32e@gandalf.local.home>
        <qvqwa60k2yt5.fsf@dev0134.prn3.facebook.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Fri, 10 Mar 2023 11:22:54 -0800
Stefan Roesch <shr@devkernel.io> wrote:

> >> +			trace_ksm_remove_rmap_item(stable_node->kpfn, rmap_item, rmap_item->mm);  
> >
> > Instead of dereferencing the stable_node here, where the work could
> > possibly happen outside the trace event and in the hot path, could you pass
> > in the stable_node instead, and then in the TP_fast_assign() do:
> >
> > 		__entry->pfn = stable_node->kpfn;
> >
> >  
> 
> To do this, the structure would need to be exposed. Currently the
> structure is defined in ksm.c. This is an internal structure that we
> most likely don't want to expose. We can get by not printing the pfn
> and use the rmap_item to refer back to it, but exposing it directly
> here is more convenient for debugging.
> 
> Any thoughts?

Sounds like the include/trace/events/ksm.h should be local too.

See my reply about include/trace/events/thermal.h

  https://lore.kernel.org/all/20230227100715.7d896836@gandalf.local.home/

And their solution.

  https://lore.kernel.org/all/20230307133735.90772-2-daniel.lezcano@linaro.org/

I suggest you do the same.

-- Steve
