Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980A3C74A5B
	for <linux-trace-kernel@archiver.kernel.org>; Sun, 19 Mar 2023 03:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjCSDFb (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Sat, 18 Mar 2023 23:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjCSDF3 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 23:05:29 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846B7149BB
        for <linux-trace-kernel@vger.kernel.org>; Sat, 18 Mar 2023 20:05:26 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so9010904pjb.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 18 Mar 2023 20:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679195126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MCicefmFGAfU8N0PCYJlO4cx010Q7y5PWD9unGv6dCo=;
        b=PFPw4BLx06eFkIXIzvZpbANxwMrBENa3UXxDRgIq9/Fh/3qX+PBu9i4w4gTzcgFDAs
         Tg1goxKR4TpuP0JvtQQczhU2Hhcxv8ffBKmAMpR1eBtlTROUssT1B4QR0g6pxbT2/j53
         ae6pJvTWUoQlH6Umech5CGDXuAVPf5JKpzLvTFHO3Orfkl+ZG1YvHLwvQ/4lAUdSt3F5
         DB6K0dqbYO1gqpswHS7A0DjCzbqoxcOFxGtmgJ/835Covj4SnT80VxAtLRPvxXO+rEtd
         y4BSyZxEJuEXGP267YWtn9KlotLsvQfNatwY2AVgrZ+95r6/ZU8jVEc+C/GxYpfMQ6W9
         jLVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679195126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCicefmFGAfU8N0PCYJlO4cx010Q7y5PWD9unGv6dCo=;
        b=oRIpnw1NtZE0Xdp/kL6azgZJ/6BszeszmbWSM2HqFAWnGq76+mTyFzH5uWclloxzd6
         /JXsEM2+KCYFCtVL2HrWfrp5F0AmcK/E3cN5t71aby2Pjmmt5Ij9xo2Yxm1m5N4g7bDm
         hqhkw0dkmm8UV3muLvrQIce632jokNUjUZv2A1n1olu3KYTns3QPAjVLpaKd0F3gbBSF
         /tdQAAkyZg2+Gwzy8IBsl9dPTcI3qQ0L+al4Jn4Jg3k9P5lm8elO3hVStVDFeWZkGIWH
         tb9KOals96W8Ts0ct5ZeB3Sq7IeKum9eRjIi2EXYZj2ac3MmyJdUew6Jrw7464PSecm/
         cq4A==
X-Gm-Message-State: AO0yUKX52dOg3gheCZ12kgmqNb65mKxLTsTYPSNQtK0VcWUBpGEqOzZC
        PAyXM0dgtm394wCCltKP/s/GY/XuEWQ=
X-Google-Smtp-Source: AK7set+t4hOkoXW6VMQ6P3nhM3pOShxOvMfPnXI/VG7q8X6AjsR6jYnB3TmMdZiN/W9+evkVibAOVQ==
X-Received: by 2002:a17:90b:1bc4:b0:23b:bd09:7f0b with SMTP id oa4-20020a17090b1bc400b0023bbd097f0bmr14017293pjb.30.1679195125866;
        Sat, 18 Mar 2023 20:05:25 -0700 (PDT)
Received: from darius ([114.206.94.139])
        by smtp.gmail.com with ESMTPSA id ce8-20020a17090aff0800b002339491ead6sm7213648pjb.5.2023.03.18.20.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 20:05:24 -0700 (PDT)
Date:   Sun, 19 Mar 2023 12:05:20 +0900
From:   Gildong Hong <roaming2man@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, delyank@fb.com, peterz@infradead.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] trace/events/sched: Remove unit on printing vruntime
 value
Message-ID: <20230319030520.GB6049@darius>
References: <20230316115655.66639-1-roaming2man@gmail.com>
 <20230316101137.1739d1e2@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316101137.1739d1e2@gandalf.local.home>
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 10:11:37AM -0400, Steven Rostedt wrote:
> On Thu, 16 Mar 2023 20:56:55 +0900
> Gildong Hong <roaming2man@gmail.com> wrote:
> 
> > vruntime is not actual time so remove unit on printing
> > 
> > Signed-off-by: Gildong Hong <roaming2man@gmail.com>
> > ---
> >  include/trace/events/sched.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> > index fbb99a61f714..26ef85a8d3cd 100644
> > --- a/include/trace/events/sched.h
> > +++ b/include/trace/events/sched.h
> > @@ -511,7 +511,7 @@ DECLARE_EVENT_CLASS(sched_stat_runtime,
> >  		__entry->vruntime	= vruntime;
> >  	),
> >  
> > -	TP_printk("comm=%s pid=%d runtime=%Lu [ns] vruntime=%Lu [ns]",
> > +	TP_printk("comm=%s pid=%d runtime=%Lu [ns] vruntime=%Lu",
> 
> What about calling it "[vns]" for "virtual nanosecond" ?
> 
> ;-)
> 
> -- Steve
> 
> >  			__entry->comm, __entry->pid,
> >  			(unsigned long long)__entry->runtime,
> >  			(unsigned long long)__entry->vruntime)
> 

Dear Steve

"vns" sounds nice.
But some people may hard to understand the meaning.
"ns" is a global standard time unit where "vns" is not.
So I still prefer to remove the unit.

Thanks for your review.
Gildong
