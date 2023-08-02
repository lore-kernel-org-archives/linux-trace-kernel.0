Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA21C001E0
	for <linux-trace-kernel@archiver.kernel.org>; Wed,  2 Aug 2023 12:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbjHBMbJ (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 2 Aug 2023 08:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjHBMbI (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:31:08 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0A8194
        for <linux-trace-kernel@vger.kernel.org>; Wed,  2 Aug 2023 05:31:03 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-317980c4236so3302971f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 02 Aug 2023 05:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690979461; x=1691584261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UOI4p7sf9qm3jp2sWDpRQezaP1VfXV2l/+4frwp+pfo=;
        b=A4gDM2cSGcaFSfpwa1wXZUvAzPbJfGnX21w0IZ2piv2gfZNKwHWQuq+gaqWdolQDVf
         wCI3KVW0/Ixb7w3t2VLqLNQXqDKb73smXi1qJ6UqZOcFSxLOarwPSQFWEMwjImCw0hFo
         tWg6JF3VxLmhFNKRCr8J1PcvPV/p1HwVpN7JWecuylmoKHEuz1qOSXpSx2AE6LG0b3Yl
         BmMlj2ou1fFpzq32E9btpv24ZHW6OPMbGl4YTzv0ACYHkenO0hx10xtalJl0W+JdTkr3
         xzuhrNjDjGuq7G9Ucq1QcoL5Pvn4GcrmL1AWaAiQe5tV1vjtUMgRRMvMBVdAk7HNE/mN
         K6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690979461; x=1691584261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOI4p7sf9qm3jp2sWDpRQezaP1VfXV2l/+4frwp+pfo=;
        b=b3d5f9WsLrv8RZ2jevdK4H2iMT0yMSTJUlsZ7m97UZI4pafTIbZpLEPLpA5IJ5H0Qe
         mAFcxJHBe+lYbT6HY/unKF1gnAQ7GGBwHfJZM9v41ZqB2NJ+Wlo7fN9lrhDPwqxevKf5
         FkPEB1jGgLK0ro1j4+qvhy+8pgwJA7amVbKNh8gGv4s61yLEx0Hsf4hNeD469j5waC0M
         FV1g7wD6uOA+fmGkulMmdciYIF3EZ5T4Ok4QgMZpjO7ouhS7eLhs82m66THcYvEXrX8u
         ++oDlYACvzN7dCM0TZJ0CLTg9wPc/A7CTjhwQALM7A0vBj1qe20wONVWv5bwChKfMM9w
         F37g==
X-Gm-Message-State: ABy/qLZKy4u2nPt77BnfLHVSlTZHBBnx6bewAuNBmE7WnbC+34YbUx1Y
        wokcCYf1GhKGaNCoWSrtYUIwVw==
X-Google-Smtp-Source: APBJJlEyjLeRFbv0ocTWt/riOTgPTvRFCQJRf7UkIZAJEw0W48ptsBLwAM4GeKZgsTMmsU5AhgdzSg==
X-Received: by 2002:a5d:470d:0:b0:317:5c82:10c5 with SMTP id y13-20020a5d470d000000b003175c8210c5mr4412184wrq.17.1690979461541;
        Wed, 02 Aug 2023 05:31:01 -0700 (PDT)
Received: from google.com (65.0.187.35.bc.googleusercontent.com. [35.187.0.65])
        by smtp.gmail.com with ESMTPSA id z17-20020adfec91000000b003179d7ed4f3sm10643676wrn.12.2023.08.02.05.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 05:31:00 -0700 (PDT)
Date:   Wed, 2 Aug 2023 13:30:56 +0100
From:   Vincent Donnefort <vdonnefort@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v5 1/2] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <ZMpMgA85+DyGirXa@google.com>
References: <20230728164754.460767-1-vdonnefort@google.com>
 <20230728164754.460767-2-vdonnefort@google.com>
 <20230801132603.0b18c0eb@gandalf.local.home>
 <20230802074526.2fa479ab@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802074526.2fa479ab@gandalf.local.home>
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 07:45:26AM -0400, Steven Rostedt wrote:
> On Tue, 1 Aug 2023 13:26:03 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > > +
> > > +	if (READ_ONCE(cpu_buffer->mapped)) {
> > > +		/* Ensure the meta_page is ready */
> > > +		smp_rmb();
> > > +		WRITE_ONCE(cpu_buffer->meta_page->pages_touched,
> > > +			   local_read(&cpu_buffer->pages_touched));
> > > +	}  
> > 
> > I was thinking instead of doing this in the semi fast path, put this logic
> > into the rb_wakeup_waiters() code. That is, if a task is mapped, we call
> > the irq_work() to do this for us. It could even do more, like handle
> > blocked mapped waiters.
> 
> I was thinking how to implement this, and I worry that it may cause an irq
> storm. Let's keep this (and the other locations) as is, where we do the
> updates in place. Then we can look at seeing if it is possible to do it in
> a delayed fashion another time.

I actually looking at this. How about:

On the userspace side, a simple poll:

  static void wait_entries(int fd)
  {
          struct pollfd pollfd = {
                  .fd     = fd,
                  .events = POLLIN,
          };
  
          if (poll(&pollfd, 1, -1) == -1)
                  pdie("poll");
  }

And on the kernel side, just a function to update the "writer fields" of the
meta-page:

   static void rb_wake_up_waiters(struct irq_work *work)
   {
          struct rb_irq_work *rbwork = container_of(work, struct rb_irq_work, work);
  +       struct ring_buffer_per_cpu *cpu_buffer =
  +               container_of(rbwork, struct ring_buffer_per_cpu, irq_work);
  +
  +       rb_update_meta_page(cpu_buffer);
   
          wake_up_all(&rbwork->waiters);

That would rate limit the number of updates to the meta-page without any irq storm?

> 
> -- Steve
