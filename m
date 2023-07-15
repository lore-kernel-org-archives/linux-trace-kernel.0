Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAA0EB64DC
	for <linux-trace-kernel@archiver.kernel.org>; Sat, 15 Jul 2023 13:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjGONy0 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Sat, 15 Jul 2023 09:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjGONy0 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 09:54:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCDC10DC;
        Sat, 15 Jul 2023 06:54:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0EC360B98;
        Sat, 15 Jul 2023 13:54:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C3FC433C8;
        Sat, 15 Jul 2023 13:54:23 +0000 (UTC)
Date:   Sat, 15 Jul 2023 09:54:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 2/2] tracing: Add free_trace_iter_content() helper
 function
Message-ID: <20230715095419.3af9ec19@rorschach.local.home>
In-Reply-To: <20230715094201.34a41f17@rorschach.local.home>
References: <20230713114510.04c452ca@gandalf.local.home>
        <20230713114700.450e7a17@gandalf.local.home>
        <d8aeab6c-338e-dcdd-75c6-7ae4eb9c9887@huawei.com>
        <20230715094201.34a41f17@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Sat, 15 Jul 2023 09:42:01 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 15 Jul 2023 13:15:32 +0800
> Zheng Yejian <zhengyejian1@huawei.com> wrote:
> 
> > > @@ -6709,7 +6723,12 @@ static int tracing_open_pipe(struct inode *inode, struct file *filp)
> > >   	}
> > >   
> > >   	trace_seq_init(&iter->seq);
> > > -	iter->trace = tr->current_trace;
> > > +
> > > +	iter->trace = kzalloc(sizeof(*iter->trace), GFP_KERNEL);
> > > +	if (!iter->trace)
> > > +		goto fail;  
> > 
> > Hi, Steve, 'ret' may need to be set before `goto fail`:
> >    ret = -ENOMEM;
> > 
> 
> As I mentioned to Masami, this hunk of the patch didn't belong.
> Something got mixed up in the commit. This patch even depends on the
> previous patch to remove the allocation completely.
> 

I know what I did now. I first started writing this patch and saw that
the iter->trace was inconsistent and in one place allocated a copy and
here it did not. I started to make the copy here, when I realized that
there was no reason to make that copy. Then I wrote the first patch to
remove the copying, but forgot to remove the copying I added in this
patch! :-p

-- Steve
