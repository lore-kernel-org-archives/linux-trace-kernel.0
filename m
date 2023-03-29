Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3F3C74A5B
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 29 Mar 2023 12:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjC2MXK (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 29 Mar 2023 08:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjC2MXJ (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 08:23:09 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EA6213A
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Mar 2023 05:23:08 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h17so15474361wrt.8
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Mar 2023 05:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680092587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EgGgvuGVyNlBdhj243ar9e2FgjTuUms5PNX7LlgANlc=;
        b=bSnuTSFzUE+tAO+Zg0gsTElr+pCPYU5fbhHM4xF8htQLO3kEqmLKeMZ55SOfjRYNns
         kGxRhrtTqrmdcShkDnadd+QcHIhdRObEeZTIntzGlnU3zKaxpWl9baX15QqOCDPVG9i5
         FGXxZWp0O01r9h1WyZX4UniGYbEyxl1vaCbD3RwFvrBRzdUlzOJjlaRbePTAyW1GY6xg
         fleO1mU4dk8lRXztfeMeVYkmf4+G8Ok47AMxG1oElYCRrLkS4AA/5rBrUFsC9QgBJO7T
         /B+MmPWhZMfzd1I5rwxRw2hpKe51YPO9ppjs1kh8TEern4sPNNkKp1uGafi5qf12Wf06
         KCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680092587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EgGgvuGVyNlBdhj243ar9e2FgjTuUms5PNX7LlgANlc=;
        b=5FMwFes13Ah9au2wujeJ8B0sTUy40Rv8aO3eIs25kPXUNkOuxJCUFrfxlEO6fYSPa7
         xD4/yyin9V3pWAWBc7j75V3s1EovxYz/WgJeDKqT4xD5yMYCSxM/qDQn4qKDHqXjG4S6
         2/1bCFbxpD5PEH6IMf7tKmsdux1TnZ70jrtqhjuSE3SIGSfLaFnODzRzqF5eAC6u7gsE
         MXjBImQajO7SF4ZrR8O/9rLzD3B8MdLBogCk9S/khowtH99e6OUWAbPtlvWlU5kXh6m5
         r/CqDM6PjUNuXfUQeXkE62W1oRactHdsx3sIqfCRVR4EeyTo5b0DXdNTcIgIp7fzlLAG
         B5hw==
X-Gm-Message-State: AAQBX9eaIoPGSMW5mNlNNcBhR9jni6rSBh5PUe6aAj3L/Y92IabyZ6zD
        F7B6oOOlAYZm01gPptLBhB1AWw==
X-Google-Smtp-Source: AKy350b+U9Wdt+IFaashu8uZXI6RPoqXNfXpoenZTc6qE+L+zQMIUUqa4TAiRAvt8zr7cXDgM2skXg==
X-Received: by 2002:adf:f245:0:b0:2ce:b2ba:9905 with SMTP id b5-20020adff245000000b002ceb2ba9905mr15432436wrp.20.1680092586795;
        Wed, 29 Mar 2023 05:23:06 -0700 (PDT)
Received: from google.com (65.0.187.35.bc.googleusercontent.com. [35.187.0.65])
        by smtp.gmail.com with ESMTPSA id k2-20020a5d6e82000000b002c55b0e6ef1sm30448545wrz.4.2023.03.29.05.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 05:23:06 -0700 (PDT)
Date:   Wed, 29 Mar 2023 13:23:01 +0100
From:   Vincent Donnefort <vdonnefort@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 1/2] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <ZCQtpbyWrjliJkdg@google.com>
References: <20230322102244.3239740-1-vdonnefort@google.com>
 <20230322102244.3239740-2-vdonnefort@google.com>
 <20230328224411.0d69e272@gandalf.local.home>
 <ZCQCsD9+nNwBYIyH@google.com>
 <20230329070353.1e1b443b@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329070353.1e1b443b@gandalf.local.home>
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 07:03:53AM -0400, Steven Rostedt wrote:
> On Wed, 29 Mar 2023 10:19:44 +0100
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > > I've been playing with this a bit, and I'm thinking, do we need the
> > > data_pages[] array on the meta page?
> > > 
> > > I noticed that I'm not even using it.
> > > 
> > > Currently, we need to do a ioctl every time we finish with the reader page,
> > > and that updates the reader_page in the meta data to point to the next page
> > > to read. When do we need to look at the data_start section?  
> > 
> > This is for non-consuming read, to get all the pages in order.
> 
> Yeah, I was trying to see how a non consuming read would work, and was
> having issues figuring that out without the tail page being updated.

Would the userspace really need to know where is the tail page? It can just stop
whenever it finds out a page doesn't have any events, and make sure it does not
loop once back to the head?

> 
> > 
> > If we remove this section we would lose this ability ... but we'd also simplify
> > the code by a good order of magnitude (don't need the update ioctl anymore, no
> > need to keep those pages in order and everything can fit a 0-order meta-page).
> > And the non-consuming read doesn't bring much to the user over the pipe version.
> > 
> > This will although impact our hypervisor tracing which will only be able to
> > expose trace_pipe interfaces. But I don't think it is a problem, all userspace
> > tools only relying on consuming read anyway.
> > 
> > So if you're happy dropping this support, let's get rid of it.
> 
> I don't really want to get rid of it, but perhaps break it up where we
> don't have it in the first release, but add it in a second one. That will
> also make sure that we can expand the API if necessary (one reason I wanted
> the "data_start" in the first place).
> 
> Let's drop it for now, but be able to add it later, an have the current
> structure be:

Ok, I will prepare a V3 accordingly.

> 
> struct ring_buffer_meta_page_header {
> #if __BITS_PER_LONG == 64
> 	__u64	entries;
> 	__u64	overrun;
> #else
> 	__u32	entries;
> 	__u32	overrun;
> #endif
> 	__u32	pages_touched;
> 	__u32	meta_page_size;
> 	__u32	reader_page;	/* page ID for the reader page */
> 	__u32	nr_data_pages;	/* doesn't take into account the reader_page */
> };
> 
> BTW, shouldn't the nr_data_pages take into account the reader page? As it
> is part of the array we traverse isn't it?

It depends if the reader page has ever been swapped out. If yes, the reader
would have to start from reader_page and then switch to the data_pages.
Which sounds like a fiddly interface for the userspace.

So yeah, consuming-read only feels like a better start.

> 
> -- Steve
