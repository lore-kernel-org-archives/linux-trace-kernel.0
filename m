Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D1AC7618A
	for <linux-trace-kernel@archiver.kernel.org>; Sun, 19 Mar 2023 18:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjCSSHn (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Sun, 19 Mar 2023 14:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCSSHm (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 14:07:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E6C13D53
        for <linux-trace-kernel@vger.kernel.org>; Sun, 19 Mar 2023 11:07:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EE0E61133
        for <linux-trace-kernel@vger.kernel.org>; Sun, 19 Mar 2023 18:07:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7CF2C433D2;
        Sun, 19 Mar 2023 18:07:39 +0000 (UTC)
Date:   Sun, 19 Mar 2023 14:07:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Gildong Hong <roaming2man@gmail.com>
Cc:     mhiramat@kernel.org, delyank@fb.com, peterz@infradead.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] trace/events/sched: Remove unit on printing vruntime
 value
Message-ID: <20230319140738.57170fab@rorschach.local.home>
In-Reply-To: <20230319030520.GB6049@darius>
References: <20230316115655.66639-1-roaming2man@gmail.com>
        <20230316101137.1739d1e2@gandalf.local.home>
        <20230319030520.GB6049@darius>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Sun, 19 Mar 2023 12:05:20 +0900
Gildong Hong <roaming2man@gmail.com> wrote:

> > > -	TP_printk("comm=%s pid=%d runtime=%Lu [ns] vruntime=%Lu [ns]",
> > > +	TP_printk("comm=%s pid=%d runtime=%Lu [ns] vruntime=%Lu",  

> 
> "vns" sounds nice.
> But some people may hard to understand the meaning.
> "ns" is a global standard time unit where "vns" is not.
> So I still prefer to remove the unit.

Really? You have "runtime" (which most people understand) and labeled
"ns", but then you have "vruntime" which some people may find hard to
understand the meaning of. If they do understand the meaning of
"vruntime" then they should have the means to understand "vns".

Otherwise, no label is meaningless too!

-- Steve
