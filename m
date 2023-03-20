Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51364C6FD1C
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 20 Mar 2023 21:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjCTVdJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 20 Mar 2023 17:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjCTVdI (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 17:33:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C8F2D171;
        Mon, 20 Mar 2023 14:32:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AAC8CB810A7;
        Mon, 20 Mar 2023 21:31:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6078AC433EF;
        Mon, 20 Mar 2023 21:31:57 +0000 (UTC)
Date:   Mon, 20 Mar 2023 17:31:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Florent Revest <revest@chromium.org>
Cc:     Jiri Olsa <olsajiri@gmail.com>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
        mark.rutland@arm.com, ast@kernel.org, daniel@iogearbox.net,
        kpsingh@kernel.org
Subject: Re: [PATCH 5/7] ftrace: Store direct called addresses in their ops
Message-ID: <20230320173155.55f38adc@gandalf.local.home>
In-Reply-To: <CABRcYmL_JCAGSoX98dZUhGkmek+5iL4kd+F_POJ65GfnZLADcg@mail.gmail.com>
References: <20230316173811.1223508-1-revest@chromium.org>
        <20230316173811.1223508-6-revest@chromium.org>
        <ZBcqUoUTZSNyIjLx@krava>
        <20230319135443.1d29db2d@rorschach.local.home>
        <ZBdagJQFA/Z7Phj5@krava>
        <CABRcYmL_JCAGSoX98dZUhGkmek+5iL4kd+F_POJ65GfnZLADcg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Mon, 20 Mar 2023 18:45:08 +0100
Florent Revest <revest@chromium.org> wrote:

> On Sun, Mar 19, 2023 at 7:55 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Sun, Mar 19, 2023 at 01:54:43PM -0400, Steven Rostedt wrote:  
> > > On Sun, 19 Mar 2023 16:29:22 +0100
> > > Jiri Olsa <olsajiri@gmail.com> wrote:
> > >  
> > > > > +++ b/kernel/trace/ftrace.c
> > > > > @@ -2582,9 +2582,8 @@ ftrace_add_rec_direct(unsigned long ip, unsigned long addr,
> > > > >  static void call_direct_funcs(unsigned long ip, unsigned long pip,
> > > > >                         struct ftrace_ops *ops, struct ftrace_regs *fregs)
> > > > >  {
> > > > > - unsigned long addr;
> > > > > + unsigned long addr = ops->direct_call;  
> > > >
> > > > nice, should it be read with READ_ONCE ?  
> > >
> > > Is there a "read tearing" too?  
> >
> > don't know, saw the comment in __modify_ftrace_direct and got curious
> > why it's not in here.. feel free to ignore, I'll look it up
> >
> > jirka  
> 
> Mhh, that's a good question. Based on my current understanding, it
> seems that it should have a READ_ONCE, indeed. However, I'd like Mark
> to confirm/deny this. :)
> 
> If this should be a READ_ONCE, I can send a v2 series with this fixed.

After re-reading: https://lwn.net/Articles/793253/

I think we should add the READ_ONCE() (also with a comment).

-- Steve
