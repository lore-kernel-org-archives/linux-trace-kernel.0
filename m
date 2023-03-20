Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914FDC6FD1D
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 20 Mar 2023 11:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjCTLly (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 20 Mar 2023 07:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjCTLlt (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 07:41:49 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CE51A64B
        for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Mar 2023 04:41:44 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id x11so9919686pja.5
        for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Mar 2023 04:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679312504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q1dTFWLi+UedF1lj4XuVzoPTqsnV2vOleZvPfoIsvFk=;
        b=mkIoKFV3Xi4I3Yu13KGeuIYFSWUSkUOzDvDpDoRLo1DUJbijGYhiA5Wht3FLwKkvOO
         RcBlraXbNO3jcoozKmAHVONmR0Ay1l1gXvgPJklrMH2wcZS9wG/bYJGmArkGdB0Ti8pW
         4zvBwj0x2DgfEZ6qf51vpAGcq0JzEE156n/5fx2qgiCB9JqwavksZX+SpenuJ/bAT/9J
         i1YlMr++woNbIRvio0p6TRc2JR10jFNeGdUds2mlGFqr3sZA4h6Oe2hL/l9zne6i/07A
         q0tbrS+eFEcEy4CW/oBqYd4gBqcZk/TncBqH9v+cQlLviL7rvZi7Q5Hb+rW7mScWAtH8
         C15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679312504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q1dTFWLi+UedF1lj4XuVzoPTqsnV2vOleZvPfoIsvFk=;
        b=af4qPk+JqN4WCVEKW1ua/X0TMj08R/BZru15judBbngHwNPj7GcP04pQh5WSKtjpXx
         r1eTjSrgvlDgvGCyiyyCprpzcU6LtDl0t5QP3vmWem80ujxslk35DzM4/7L9GTm9pgTF
         assqZQ1h5l11g80WOIw7Dsa9fsM8qcqjWf4twzzh2FHhBaGVbI0o65TsmyDX+eNWkxtC
         qSPYU8IGHfofNPLQqKRaR0XuiIYYbBpwA+KExHn1eGFVsOXWaPqZsb5ZWFbwfC5+ob4F
         M0EUYqJI05wuCDyIEz0M+QM1f46i9015eTKlLQ349bZyGjaOr+RZ/ZF6nQJYpEOUH/OL
         m0gA==
X-Gm-Message-State: AO0yUKXrTbbiAJ1ly24DZjUtp5aYu0DexwEhYJnN82wtEIi1dr7UswzG
        T8MH60YioLExpIfQYYGWcMU=
X-Google-Smtp-Source: AK7set+FBTlSKNLs0eEGdMM57m8q/pgPsH8nPXcgiMCMMREeypxswp85S4uTgAtzckzgRh9iM3/+Xw==
X-Received: by 2002:a17:90b:1d0c:b0:23a:66:1d3a with SMTP id on12-20020a17090b1d0c00b0023a00661d3amr18121652pjb.45.1679312504038;
        Mon, 20 Mar 2023 04:41:44 -0700 (PDT)
Received: from darius ([114.206.94.139])
        by smtp.gmail.com with ESMTPSA id a9-20020a17090abe0900b0023f9ad42118sm2698562pjs.28.2023.03.20.04.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 04:41:43 -0700 (PDT)
Date:   Mon, 20 Mar 2023 20:41:39 +0900
From:   Gildong Hong <roaming2man@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, delyank@fb.com, peterz@infradead.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] trace/events/sched: Remove unit on printing vruntime
 value
Message-ID: <20230320114139.GB2077@darius>
References: <20230316115655.66639-1-roaming2man@gmail.com>
 <20230316101137.1739d1e2@gandalf.local.home>
 <20230319030520.GB6049@darius>
 <20230319140738.57170fab@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230319140738.57170fab@rorschach.local.home>
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Sun, Mar 19, 2023 at 02:07:38PM -0400, Steven Rostedt wrote:
> On Sun, 19 Mar 2023 12:05:20 +0900
> Gildong Hong <roaming2man@gmail.com> wrote:
> 
> > > > -	TP_printk("comm=%s pid=%d runtime=%Lu [ns] vruntime=%Lu [ns]",
> > > > +	TP_printk("comm=%s pid=%d runtime=%Lu [ns] vruntime=%Lu",  
> 
> > 
> > "vns" sounds nice.
> > But some people may hard to understand the meaning.
> > "ns" is a global standard time unit where "vns" is not.
> > So I still prefer to remove the unit.
> 
> Really? You have "runtime" (which most people understand) and labeled
> "ns", but then you have "vruntime" which some people may find hard to
> understand the meaning of. If they do understand the meaning of
> "vruntime" then they should have the means to understand "vns".
> 
> Otherwise, no label is meaningless too!
> 
> -- Steve

I agree with your opinion.
People can understand "vns" if they understand "vruntime".
Followings are the modified patch.
I add your name on "Suggested-by"
I or you could remove the line if you mind it.

Thanks,
Gildong

------------
From 8a8d1f08a2f217151f26f04795d6c1483eb1c48f Mon Sep 17 00:00:00 2001
From: Gildong Hong <roaming2man@gmail.com>
Date: Thu, 16 Mar 2023 20:05:48 +0900
Subject: [PATCH] trace/events/sched: Change unit on printing vruntime value

vruntime is not actual time so change unit on printing
from "ns" to "vns" which denotes "virtual nanosecond"

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Gildong Hong <roaming2man@gmail.com>
---
 include/trace/events/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index fbb99a61f714..993986c6c3f6 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -511,7 +511,7 @@ DECLARE_EVENT_CLASS(sched_stat_runtime,
 		__entry->vruntime	= vruntime;
 	),
 
-	TP_printk("comm=%s pid=%d runtime=%Lu [ns] vruntime=%Lu [ns]",
+	TP_printk("comm=%s pid=%d runtime=%Lu [ns] vruntime=%Lu [vns]",
 			__entry->comm, __entry->pid,
 			(unsigned long long)__entry->runtime,
 			(unsigned long long)__entry->vruntime)
-- 
2.25.1


