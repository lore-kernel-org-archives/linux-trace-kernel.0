Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAA2EB64DD
	for <linux-trace-kernel@archiver.kernel.org>; Thu,  3 Aug 2023 14:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235036AbjHCOws (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 3 Aug 2023 10:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbjHCOwr (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:52:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20921728;
        Thu,  3 Aug 2023 07:52:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 359F061DC7;
        Thu,  3 Aug 2023 14:52:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C95DC433C8;
        Thu,  3 Aug 2023 14:52:44 +0000 (UTC)
Date:   Thu, 3 Aug 2023 10:52:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vincent Donnefort <vdonnefort@google.com>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v5 1/2] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <20230803105242.2df8831d@gandalf.local.home>
In-Reply-To: <ZMuCg/J8gwbb0PXd@google.com>
References: <20230728164754.460767-1-vdonnefort@google.com>
        <20230728164754.460767-2-vdonnefort@google.com>
        <20230801132603.0b18c0eb@gandalf.local.home>
        <20230802074526.2fa479ab@gandalf.local.home>
        <ZMpMgA85+DyGirXa@google.com>
        <20230802111306.4f52c1c6@gandalf.local.home>
        <ZMuCg/J8gwbb0PXd@google.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Thu, 3 Aug 2023 11:33:39 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> [...]
> 
> > > And on the kernel side, just a function to update the "writer fields" of the
> > > meta-page:
> > > 
> > >    static void rb_wake_up_waiters(struct irq_work *work)
> > >    {
> > >           struct rb_irq_work *rbwork = container_of(work, struct rb_irq_work, work);
> > >   +       struct ring_buffer_per_cpu *cpu_buffer =
> > >   +               container_of(rbwork, struct ring_buffer_per_cpu, irq_work);
> > >   +
> > >   +       rb_update_meta_page(cpu_buffer);
> > >    
> > >           wake_up_all(&rbwork->waiters);
> > > 
> > > That would rate limit the number of updates to the meta-page without any irq storm?
> > >   
> > 
> > Is poll an issue? It requires user space to do a system call to see if
> > there's more data? But I guess that's not too much of an issue, as it needs
> > to do the ioctl to get the reader page.  
> 
> I don't think there's any problem with this approach, beside the extra system
> call...
> 
> > 
> > We could also add an option to the ioctl to block, or have the ioctl honor
> > the NON_BLOCK flags of the fd?  
> 
> ... but indeed, we could block there. The userspace interface would be even simpler.
> How about?
> 
>   +++ b/kernel/trace/trace.c
>   @@ -8499,12 +8499,22 @@ static long tracing_buffers_ioctl(struct file *file, unsigned int cmd, unsigned
>    {
>           struct ftrace_buffer_info *info = file->private_data;
>           struct trace_iterator *iter = &info->iter;
>   +       int err;
>   +
>   +       if (cmd == TRACE_MMAP_IOCTL_GET_READER_PAGE) {
>   +               if (!(file->f_flags & O_NONBLOCK)) {
>   +                       err = ring_buffer_wait(iter->array_buffer->buffer,
>   +                                              iter->cpu_file,
>   +                                              iter->tr->buffer_percent);
>   +                       if (err)
>   +                               return err;
>   +               }
>    
>   -       if (cmd == TRACE_MMAP_IOCTL_GET_READER_PAGE)
>                   return ring_buffer_map_get_reader_page(iter->array_buffer->buffer,
>                                                          iter->cpu_file);
> 

Looks good to me.

-- Steve
