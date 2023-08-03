Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62693C001DF
	for <linux-trace-kernel@archiver.kernel.org>; Thu,  3 Aug 2023 10:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbjHCKeG (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 3 Aug 2023 06:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234936AbjHCKeF (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 06:34:05 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D4C11B
        for <linux-trace-kernel@vger.kernel.org>; Thu,  3 Aug 2023 03:34:03 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b9cbaee7a9so12018281fa.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 03 Aug 2023 03:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691058841; x=1691663641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xssq6HuuqKN2Ig2rF5/7qFRDdi6y4lBSkM6NwJlpiDk=;
        b=J961eCKfo2aGsgDWhV0WVBWw7rnE9G79errIN1OAK4iGPNpUBYHU5SkcDnOyRlYfhL
         6u3PfGb/W4fBk2BNj35Kj4HU1u9eZXqbul183vWOx+L0g+CXLqw55tLEFpBcjueG/jFx
         TMZFrzbqk1iJyoYb7u1KWZQRFNEf0Jf1USRR3In9g88QiMsLXFUsAdkMEIhWljUUF0y5
         58w8GywjH23OKytdq2Usi9Xn6ny+lSz7H6K3sIr4X2JboJaIdByGXM/N2zCZTRRkb8fn
         41CwSG738ZecET19I855sIS71P0SUG1SkxrOZygWXREPeLIth7EsARWsgrkT+eVh+7rG
         sTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691058841; x=1691663641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xssq6HuuqKN2Ig2rF5/7qFRDdi6y4lBSkM6NwJlpiDk=;
        b=KoNKOXLtTBW5bbgBTI20LFiu/W/u33hJv4pxLVzE5myAseBg8ZQESGSmN13lWwK1kT
         4aNGdissz6e7ZDSALydmClJOvX0+0UxZoXpRwTphDHP8/KeoObNb0Ut2ke5DSMW4Twdc
         ab0u+lhsV0IZn2r7NpdiivyYPeNftALPjoOMqdAgma3l2x4o/ejvWC6hk7qfry7/W1Hx
         vI7Pt7EcJVxcx6gUm/Jls+sogUmpI+nPUq8hn9cPehvTf+0Ghs9rbToKsuGHzKChJKj4
         nlpSo7p09eU9jccf0/53eN0m4+JnMluv54px/OZsdHqyRmT3sIHG7c9fkcyxD99cFrsg
         PRdw==
X-Gm-Message-State: ABy/qLbmlbrUVCr1muyVxl4360s2One8hUJTQKXjck+SAW7TESX5JO7N
        8c/XelnOM+2izoRmlR0C+LyPhA==
X-Google-Smtp-Source: APBJJlGPGUkg90Pft4TCcuHnUyjD/blL473+fQwsAgsjx/gNyIUveQvck8Oc1+lLctPzyLKCNKIs3Q==
X-Received: by 2002:a2e:3817:0:b0:2b6:da66:2d69 with SMTP id f23-20020a2e3817000000b002b6da662d69mr7078534lja.28.1691058841415;
        Thu, 03 Aug 2023 03:34:01 -0700 (PDT)
Received: from google.com (65.0.187.35.bc.googleusercontent.com. [35.187.0.65])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c249100b003fe26bf65e7sm3940327wms.13.2023.08.03.03.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 03:34:00 -0700 (PDT)
Date:   Thu, 3 Aug 2023 11:33:39 +0100
From:   Vincent Donnefort <vdonnefort@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v5 1/2] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <ZMuCg/J8gwbb0PXd@google.com>
References: <20230728164754.460767-1-vdonnefort@google.com>
 <20230728164754.460767-2-vdonnefort@google.com>
 <20230801132603.0b18c0eb@gandalf.local.home>
 <20230802074526.2fa479ab@gandalf.local.home>
 <ZMpMgA85+DyGirXa@google.com>
 <20230802111306.4f52c1c6@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802111306.4f52c1c6@gandalf.local.home>
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

[...]

> > And on the kernel side, just a function to update the "writer fields" of the
> > meta-page:
> > 
> >    static void rb_wake_up_waiters(struct irq_work *work)
> >    {
> >           struct rb_irq_work *rbwork = container_of(work, struct rb_irq_work, work);
> >   +       struct ring_buffer_per_cpu *cpu_buffer =
> >   +               container_of(rbwork, struct ring_buffer_per_cpu, irq_work);
> >   +
> >   +       rb_update_meta_page(cpu_buffer);
> >    
> >           wake_up_all(&rbwork->waiters);
> > 
> > That would rate limit the number of updates to the meta-page without any irq storm?
> > 
> 
> Is poll an issue? It requires user space to do a system call to see if
> there's more data? But I guess that's not too much of an issue, as it needs
> to do the ioctl to get the reader page.

I don't think there's any problem with this approach, beside the extra system
call...

> 
> We could also add an option to the ioctl to block, or have the ioctl honor
> the NON_BLOCK flags of the fd?

... but indeed, we could block there. The userspace interface would be even simpler.
How about?

  +++ b/kernel/trace/trace.c
  @@ -8499,12 +8499,22 @@ static long tracing_buffers_ioctl(struct file *file, unsigned int cmd, unsigned
   {
          struct ftrace_buffer_info *info = file->private_data;
          struct trace_iterator *iter = &info->iter;
  +       int err;
  +
  +       if (cmd == TRACE_MMAP_IOCTL_GET_READER_PAGE) {
  +               if (!(file->f_flags & O_NONBLOCK)) {
  +                       err = ring_buffer_wait(iter->array_buffer->buffer,
  +                                              iter->cpu_file,
  +                                              iter->tr->buffer_percent);
  +                       if (err)
  +                               return err;
  +               }
   
  -       if (cmd == TRACE_MMAP_IOCTL_GET_READER_PAGE)
                  return ring_buffer_map_get_reader_page(iter->array_buffer->buffer,
                                                         iter->cpu_file);

> 
> -- Steve
> 
> -- 
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> 
