Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4F8EE7FE1
	for <linux-trace-kernel@archiver.kernel.org>; Fri,  8 Sep 2023 12:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbjIHM0K (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 8 Sep 2023 08:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjIHM0K (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 08:26:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B791BC5
        for <linux-trace-kernel@vger.kernel.org>; Fri,  8 Sep 2023 05:26:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FCE3C433C9;
        Fri,  8 Sep 2023 12:26:05 +0000 (UTC)
Date:   Fri, 8 Sep 2023 08:26:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Jinjie Ruan <ruanjinjie@huawei.com>,
        <linux-trace-kernel@vger.kernel.org>,
        Ajay Kaher <akaher@vmware.com>
Subject: Re: [PATCH] eventfs: Fix the NULL pointer dereference bug in
 eventfs_remove_rec()
Message-ID: <20230908082621.1ac71afe@gandalf.local.home>
In-Reply-To: <20230908172630.6f923f31e4e3bb39748c9733@kernel.org>
References: <20230908074903.3724778-1-ruanjinjie@huawei.com>
        <20230908172630.6f923f31e4e3bb39748c9733@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Fri, 8 Sep 2023 17:26:30 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> > index 237c6f370ad9..e6efa4078f48 100644
> > --- a/fs/tracefs/event_inode.c
> > +++ b/fs/tracefs/event_inode.c
> > @@ -693,7 +693,7 @@ static void eventfs_remove_rec(struct eventfs_file *ef, struct list_head *head,
> >  {
> >  	struct eventfs_file *ef_child;
> >  
> > -	if (!ef)
> > +	if (IS_ERR(ef))
> >  		return;  
> 
> But this is not good. Allocater side should handle the error carefully and remove it.
> e.g. 
> 
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 2af92177b765..5a08db957460 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -2436,6 +2436,7 @@ event_create_dir(struct dentry *parent, struct trace_event_file *file)
>  	file->ef = eventfs_add_dir(name, ef_subsystem);
>  	if (IS_ERR(file->ef)) {
>  		pr_warn("Could not create tracefs '%s' directory\n", name);
> +		file->ef = NULL;
>  		return -1;
>  	}
>  
> 
> 
> Or at least, please use IS_ERR_OR_NULL().
> 
> >  	/*
> >  	 * Check recursion depth. It should never be greater than 3:
> > @@ -730,7 +730,7 @@ void eventfs_remove(struct eventfs_file *ef)
> >  	struct dentry *dentry_list = NULL;
> >  	struct dentry *dentry;
> >  
> > -	if (!ef)
> > +	if (IS_ERR(ef))
> >  		return;  
> 
> Ditto.
> 
> Thank you,

I guess Masami said the same thing I did as my reply to the other email.

-- Steve
