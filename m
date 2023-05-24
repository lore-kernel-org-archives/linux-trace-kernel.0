Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B85DC77B7C
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 24 May 2023 15:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237424AbjEXPmB (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 24 May 2023 11:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236857AbjEXPlt (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 24 May 2023 11:41:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB381AE;
        Wed, 24 May 2023 08:41:05 -0700 (PDT)
Date:   Wed, 24 May 2023 17:39:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684942769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KodM6q03rsC3dG7jnhZ1Tpr90VDIanHWPa73nrEhGgA=;
        b=sez2GpBAShnFKyni7jhOnILmOn6OBdatuxoTMySi5tsOr27mNrU68Sj7QSbVcIl/QuU82K
        T+1F8lmbtmapRYvrQDXJAClza/FYyRzYrQYoM00PBnhz6/kYkzz/bbpT4F9j2pub+tzATF
        7aQ3/vqYQ3tWYC6pmVh2JWWSMViz4ydgAmkQJEaH2Yog6mJsEECe3u0zccUevlGcji7uKS
        EElaiiHjZtKMPikoC0YpOO+oeovWdYd4FHNWSb+44V5zhZJvFhuS1FrHzFObVE0udQVdAl
        3E3zncGZqHB5x/hmITERe+d0NPOjl8WhmWIL6roXAMUkDCO1TZu4H+Pg75vIRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684942769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KodM6q03rsC3dG7jnhZ1Tpr90VDIanHWPa73nrEhGgA=;
        b=ACGNRgnrhTtwLuwdWPLtwdlZSY/CxFhNWIhYgD1yBPeQ28uyFVY01U7UkiVX9p5cUuhbke
        o8OZNjeeX6sO2ICQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] tracing/timer: Add missing hrtimer modes to
 decode_hrtimer_mode().
Message-ID: <20230524153928.p9umapxB@linutronix.de>
References: <20230418143854.8vHWQKLM@linutronix.de>
 <20230424174441.3baebdef@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230424174441.3baebdef@rorschach.local.home>
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On 2023-04-24 17:44:41 [-0400], Steven Rostedt wrote:
> On Tue, 18 Apr 2023 16:38:54 +0200
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > The trace output for the HRTIMER_MODE_.*_HARD modes is seen as a number
> > since these modes are not decoded. The author was not aware of the fancy
> > decoding function which makes the life easier.
> > 
> > Extend decode_hrtimer_mode() with the additional HRTIMER_MODE_.*_HARD
> > modes.
> > 
> > Fixes: ae6683d815895 ("hrtimer: Introduce HARD expiry mode")
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Could this be either routed via the tracing tree or the tip tree but
please route this :)

Sebastian
