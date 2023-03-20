Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C820DC6FD1D
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 20 Mar 2023 11:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjCTLmE (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 20 Mar 2023 07:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjCTLmC (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 07:42:02 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F82C19F09
        for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Mar 2023 04:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CpyrjlaQSUB7etcKaVBjRxQvFmKYl4xrw3J83Z8qPHI=; b=rhYHZHr/i4Oi6CpiiE6HSLk/ZP
        JLK6/vVe1nRCKGUVOwDKOLgdor/cJQtZdb0XkuAzfawVvBI/6Ed0+DiYhaosjGo8LNtXwih3sb5bm
        +PHzw11pDOmeFwXEVjPiixY4vXgI7bV4yWvQuudBiuh6aaCTBJLtrUZm+c8yNZ/LbguWNVKago6KL
        4xSDheuE1k5gRd0Hp1aH53hkGlOTCnga4KuTWDhy2xJJZWzmJCU3ZuFqKAmgyOGG2gdhdkCkcxRXv
        Vi4KyLr3hkOfA2R0vskPhO06VNF+uKQZBc+N7BNa7I8uAIANO5syTnaLX+x5XwuHS8trYTiX+RGBp
        pX1FQraw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1peDtk-003uBL-1M;
        Mon, 20 Mar 2023 11:41:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EA24D30006D;
        Mon, 20 Mar 2023 12:41:55 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C6615209F7546; Mon, 20 Mar 2023 12:41:55 +0100 (CET)
Date:   Mon, 20 Mar 2023 12:41:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Gildong Hong <roaming2man@gmail.com>, mhiramat@kernel.org,
        delyank@fb.com, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] trace/events/sched: Remove unit on printing vruntime
 value
Message-ID: <20230320114155.GJ2194297@hirez.programming.kicks-ass.net>
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

I'm with Steve, if you're down to consuming these here numbers, you'd
better know wth you're doing.


