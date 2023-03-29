Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CF1C761A6
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 29 Mar 2023 13:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjC2NbQ (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 29 Mar 2023 09:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjC2NbP (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 09:31:15 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8291444A2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Mar 2023 06:31:13 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t4so10498996wra.7
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Mar 2023 06:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680096672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XPcrWC89uyvGiy5iw9GWnI8C+4ORF9dvsNBf+0cB00o=;
        b=Hu3eJcUJhu3n9dOUB/l/4mCsVOAJ2lOgC5mFMKc9MDJ6N/M8l9GyWP7xvuqS+szrua
         0u48XlTUYTDEg76d8NHw0kEYFd1LoDUxM6hSiSLf7x0X0QCKCRhwHco+csPg+H/JzOeS
         OzD49xgQA5L580f0gzaFijeWy5bLEaJQshQNpfYpRyugsfcDBjwRjYANIxSzpF8Y04sg
         +l4qXyHIqAW+s2gKBB6W6bU7mFeXx9O2kCgp6WWocpl6FRGpjqXvblz0I/ngcyDwE9Pr
         Zm9JxroLoJW950kT0lMmAn6wjaOW7MeqgTIj4M4rJ5c7nu3ipMmDOXzAKI2pffI+Kz7C
         DNDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680096672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPcrWC89uyvGiy5iw9GWnI8C+4ORF9dvsNBf+0cB00o=;
        b=MratoxaVDDkumLA6LY8XepEVwMbVwFF2EzKASEJpe6fnjxRLOgkf+tZLqmKiAQCpH7
         u6rh1toaGQP4B3qcoTLRQiRAEqMSB16lkvwIVgIvqltE8BM8qP8V2IsJuK603E98Pwk9
         OhJq8Whmuvl/4+x+Ndax1Q8bQ4d7dWFSjP6esQZMjNDema8DzLCloYQiSeDyzO4N2r65
         rPTQKtwFwZkL0U41ItqeUyInh0GqHmln0dB5fll8olrrMJJePCH+O895gfQvUbvw2F7U
         kUmIgBgh8FypBcp2lWFsnM0kS7KCJu6Ql9uLHJNDQcKb8mNCv/JyetchXYGc1WOiYA/U
         L/Gw==
X-Gm-Message-State: AAQBX9c7/wBjdaZZdoT+YKqwP/CeznV851xzTjKMt6h6aKlcxBTBp0X7
        Yg/UW1LjK7Aqjyp6ttedC9BwIg==
X-Google-Smtp-Source: AKy350a4gUYJkkQM96D0mP2b6HwbfXslvkrUItBPYRKXFWdKFxLss9/HjxUZamPMhqyisyz8u1/OUA==
X-Received: by 2002:a5d:6dcc:0:b0:2ce:ab76:cc8c with SMTP id d12-20020a5d6dcc000000b002ceab76cc8cmr1890261wrz.2.1680096671965;
        Wed, 29 Mar 2023 06:31:11 -0700 (PDT)
Received: from google.com (65.0.187.35.bc.googleusercontent.com. [35.187.0.65])
        by smtp.gmail.com with ESMTPSA id b7-20020a5d4d87000000b002c707785da4sm30159594wru.107.2023.03.29.06.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 06:31:11 -0700 (PDT)
Date:   Wed, 29 Mar 2023 14:31:07 +0100
From:   Vincent Donnefort <vdonnefort@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 1/2] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <ZCQ9m5K34Qa9ZkUd@google.com>
References: <20230322102244.3239740-1-vdonnefort@google.com>
 <20230322102244.3239740-2-vdonnefort@google.com>
 <20230328224411.0d69e272@gandalf.local.home>
 <ZCQCsD9+nNwBYIyH@google.com>
 <20230329070353.1e1b443b@gandalf.local.home>
 <20230329085106.046a8991@rorschach.local.home>
 <ZCQ2jW5Jl/cWCG7s@google.com>
 <20230329091107.408d63a8@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329091107.408d63a8@rorschach.local.home>
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 09:11:07AM -0400, Steven Rostedt wrote:
> On Wed, 29 Mar 2023 14:01:01 +0100
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > > Oh, I guess we should also expose the amount read on the reader page,
> > > that gets updated on the ioctl. That is, if the first time we read the
> > > reader page and the page is not full and unmap the pages, and then new
> > > events were added to the reader page, we should not re-read the events
> > > that were read previously.
> > > 
> > > That is, expose cpu_buffer->reader_page->read  
> > 
> > Couldn't it be an issue of updating cpu_buffer->reader_page->read during the
> > ioctl? I guess we would write the value of the current written events on that
> > page, hopping for the userspace reader to read it all.
> > 
> > But then if new events are written, the reader doesn't need the ioctl to read
> > them, it can just check the meta->entries field or the commit field in the
> > reader_page header?
> > 
> > So it's much likely cpu_buffer->reader_page->read will go out of sync?
> 
> Here's the issue I found during testing:
> 
> write 10 events to ring buffer (all go into the reader page)
> 
> Run application that maps the pages, and reads the 10 events, and exits.
> 
> Write 10 more events to ring buffer (all are appended to the reader page)
> 
> Run application that maps the pages and reads 20 events, and exits.
> 
> It read the 10 previous events, but should not have. It should have
> only read the last 10 that were not read previously.

I see.

We can say we update cpu_buffer->reader_page->read on the get_reader_page ioctl,
to the most recent value possible, which will have the consequence of actually
"flushing" those events?

If the reader decides to read events past this value then it just can't expect
them to not be duplicated?

I suppose it'd be down the reader to store meta->read somehwere?

   prev_read = meta->read
   ioctl(fd, TRACE_MMAP_IOCTL_GET_READER_PAGE)
   /* read events from prev_read to meta->read */


> 
> -- Steve
