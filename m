Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D2CCA0EC8
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 12 Sep 2023 02:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239176AbjILChY (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 11 Sep 2023 22:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239125AbjILChJ (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:37:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B2013E0CF;
        Mon, 11 Sep 2023 19:02:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D463EC433C9;
        Mon, 11 Sep 2023 20:51:28 +0000 (UTC)
Date:   Mon, 11 Sep 2023 16:51:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/damon/core: add a tracepoint for damos apply
 target regions
Message-ID: <20230911165144.5002a0ac@gandalf.local.home>
In-Reply-To: <20230911203642.1788-1-sj@kernel.org>
References: <20230911163127.167dccc2@gandalf.local.home>
        <20230911203642.1788-1-sj@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Mon, 11 Sep 2023 20:36:42 +0000
SeongJae Park <sj@kernel.org> wrote:

> > Then tracing is fully enabled here, and now we enter:
> > 
> >  	if (trace_damos_before_apply_enabled()) {
> > 		trace_damos_before_apply(cidx, sidx, tidx, r,
> >  				damon_nr_regions(t));
> >  	}
> > 
> > Now the trace event is hit with sidx and tidx zero when they should not be.
> > This could confuse you when looking at the report.  
> 
> Thank you so much for enlightening me with this kind explanation, Steve!  And
> this all make sense.  I will follow your suggestion in the next spin.
> 
> > 
> > What I suggested was to initialize sidx to zero,  
> 
> Nit.  Initialize to not zero but -1, right?

Yeah, but I was also thinking of the reset of it too :-p

	sidx = -1;

	if (trace_damos_before_apply_enabled()) {
		sidx = 0;

-- Steve


> 
> > set it in the first trace_*_enabled() check, and ignore calling the
> > tracepoint if it's not >= 0.
> > 
