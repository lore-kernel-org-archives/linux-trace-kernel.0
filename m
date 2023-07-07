Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6777EB64D9
	for <linux-trace-kernel@archiver.kernel.org>; Fri,  7 Jul 2023 05:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjGGFhi (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 7 Jul 2023 01:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjGGFhh (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 01:37:37 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CCB1BC3
        for <linux-trace-kernel@vger.kernel.org>; Thu,  6 Jul 2023 22:37:36 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-307d20548adso1512840f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 06 Jul 2023 22:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688708255; x=1691300255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hmqY2VoKOKI76rOy0nrYvF8ZYc3DQZawgMIS0yryn4s=;
        b=yLdVmduETayY3ssFUvNEgE2ms3GpnwbT+kwylb1cV9QDE5FbY4PNOD0vDbtfMUYjRM
         iYL4Z1YqEdD0+1gajareOzD94Unoh1Wzx/ndEaAwYrfCoMeGFwrwvUuFiZhk8GUVULwu
         H0SfYPU81HQ4+4bx9xRf5+/gctXpfC5j2Zd3wvUoa7C7+Q608ZcHlop7N0QTBEm9XVZV
         dES9L5Nrd1exO8ZSZ6d+1rUH1vamE4iryWZnoRROEPl1ePuX5mk83B8tcBMoCVDc4kAC
         hyuNzDo0F+ePnmKufONBxUOu73eyci3f5HW6hDO60TZYSmxkNT82Ds7Wx6LisOv6FTa/
         nlCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688708255; x=1691300255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmqY2VoKOKI76rOy0nrYvF8ZYc3DQZawgMIS0yryn4s=;
        b=Xg7qCy+RA/BdeyymGreJxhUmtwEiB4QCXFjkDokD80TGzOl2LgBXTOx/9NkZOFYcsI
         EwKUSU5BFAJIALHOhwXcIUr4tck7zyguM7CM60p8wvVuJ5RprXlFVi0jVGsgE9ZJdVh/
         PsRr1BCGqhWRqGVqR/61CZcSjlXgYXNDQ9yasDpIpR1Vp2r0B69h4pv5rTgYDQbRf/xo
         B3CUCy1jr7Stho2fF7xig+SXB5+4neXakKWIeYVnBJ+3U3wLQ4tsIidfwZaypXrWmzCO
         uGZ+KukEizu7zZX9Oxlf3bkJLXaaV9ZdWwi41uMNn2oPFeFxFUbZE00dwAygCIoqxiO+
         x4ig==
X-Gm-Message-State: ABy/qLbodwVz/3kl7h5/hBpSFKibwgAWtbHynqECddTP8N1NCal+tWzs
        hLf7zLchWjohx6LRBnbi5NJSig==
X-Google-Smtp-Source: APBJJlGdTheh7PEaw8Ceo4NJ5KEvYtfOyG5ERZSrJ4IosaZ/Y5Qh1qyUFIVhT7Ki9OpArkJfeDCgOQ==
X-Received: by 2002:a5d:6d4b:0:b0:313:f54a:a83b with SMTP id k11-20020a5d6d4b000000b00313f54aa83bmr3184383wri.59.1688708254825;
        Thu, 06 Jul 2023 22:37:34 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id x10-20020a5d490a000000b003143853590csm3491221wrq.104.2023.07.06.22.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 22:37:32 -0700 (PDT)
Date:   Fri, 7 Jul 2023 08:37:29 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-trace-kernel@vger.kernel.org
Subject: Re: [bug report] x86/ftrace: Make function graph use ftrace directly
Message-ID: <2344e517-cdce-42ef-868e-6b9ae8b4ea2c@kadam.mountain>
References: <8d9bf4bb-693a-4368-8db1-9de1b80a33e1@moroto.mountain>
 <20230706133734.499e9cbe@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706133734.499e9cbe@gandalf.local.home>
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Thu, Jul 06, 2023 at 01:37:34PM -0400, Steven Rostedt wrote:
> On Thu, 6 Jul 2023 08:50:31 +0300
> Dan Carpenter <dan.carpenter@linaro.org> wrote:
> 
> > Hello Steven Rostedt (VMware),
> > 
> > The patch 0c0593b45c9b: "x86/ftrace: Make function graph use ftrace
> > directly" from Oct 8, 2021, leads to the following Smatch static
> > checker warning:
> > 
> > 	kernel/trace/trace_selftest.c:769 trace_graph_entry_watchdog()
> > 	warn: sleeping in atomic context
> > 
> > kernel/trace/trace_selftest.c
> >     765 static int trace_graph_entry_watchdog(struct ftrace_graph_ent *trace)
> >     766 {
> >     767         /* This is harmlessly racy, we want to approximately detect a hang */
> >     768         if (unlikely(++graph_hang_thresh > GRAPH_MAX_FUNC_TEST)) {
> > --> 769                 ftrace_graph_stop();  
> > 
> > This is a sleeping function.
> 
> Hmm, this is an interesting scenario. If this triggers, it means that the
> system is likely locked up by the function graph tracer. The only way to
> stop the hang, is via calling ftrace_graph_stop(). But you are correct,
> that's calling something that can crash the system as well.
> 
> If anything, it should be called after the dump_on_oops output, with a
> warning to reboot the machine.
> 
> IOW, yes, it's doing something buggy, but pretty much the only other
> alternative is to call panic(). Not sure that's better :-/
> 
> Perhaps the solution is simply to move it to after the dump, with a warning
> saying: "Dazed and confused, and trying to continue, but please reboot the machine!"
> 
> ??

I feel like sleeping in atomic bugs used to be more of a big deal back
in the day when systems only had one CPU.  In those days it was way more
common for it to lead to a hang, but these days we quite often
re-schedule the sleeping process on a different CPU and recover.  (I
haven't actually looked at how processes are moved to different CPUs
but this is just my theory of why we see fewer real life hangs from this
bug today).

regards,
dan carpenter

