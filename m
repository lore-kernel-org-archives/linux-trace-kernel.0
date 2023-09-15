Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4180EE020C
	for <linux-trace-kernel@archiver.kernel.org>; Fri, 15 Sep 2023 02:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbjIOCQv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 14 Sep 2023 22:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjIOCQv (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 22:16:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215E626B7
        for <linux-trace-kernel@vger.kernel.org>; Thu, 14 Sep 2023 19:16:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27488C4AF5C;
        Fri, 15 Sep 2023 02:16:45 +0000 (UTC)
Date:   Thu, 14 Sep 2023 22:16:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linyu Yuan <quic_linyyuan@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Bin Liu <b-liu@ti.com>, Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/8] usb: udc: trace: reduce buffer usage of trace event
Message-ID: <20230914221644.6f4517b3@rorschach.local.home>
In-Reply-To: <dc54b48f-f2ad-9948-f50f-a6f2c004c77c@quicinc.com>
References: <20230914100302.30274-1-quic_linyyuan@quicinc.com>
        <20230914100302.30274-4-quic_linyyuan@quicinc.com>
        <20230914125410.432ca343@gandalf.local.home>
        <dc54b48f-f2ad-9948-f50f-a6f2c004c77c@quicinc.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Fri, 15 Sep 2023 09:11:06 +0800
Linyu Yuan <quic_linyyuan@quicinc.com> wrote:

> >> +		snprintf(__s, 9, "ep%d%s", te.address, \
> >> +			(te.caps.dir_in && te.caps.dir_out) ? "" : \
> >> +			te.caps.dir_in ? "in" : "out");  
> > Note, there's a temp buffer trace_seq 'p' available for use as well. See
> > both include/trace/events/libata.h and include/trace/events/scsi.h:
> >
> >    const char *libata_trace_parse_status(struct trace_seq*, unsigned char);
> >    #define __parse_status(s) libata_trace_parse_status(p, s)
> >
> > I think that can be used instead of adding this TP_printk_init().  
> 
> 
> the reason add TP_printk_init() because when i first design some macro 
> which not
> 
> related to tracepoint,  it use too much stack.
> 

Not sure what you mean about 'uses too much stack'. This is called by
the reading code and not some arbitrary location, and the above macros
are done in the same location as your "init" call, so I'm not sure how
that makes a difference on the stack.

> 
> but i think  TP_printk_init()  is good as it following most common way 
> to print.
> 

I really do not want to add more versions of TRACE_EVENT() that I need
to maintain unless there is a really good reason to do so.

And I really don't want to encourage the use of a "TP_printk_init()"
because that just encourages more use cases that will make it hard for
user space to parse the TP_printk().

-- Steve
