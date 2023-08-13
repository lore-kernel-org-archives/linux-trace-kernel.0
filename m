Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6B7C0015E
	for <linux-trace-kernel@archiver.kernel.org>; Sun, 13 Aug 2023 01:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjHMBEw (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Sat, 12 Aug 2023 21:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjHMBEv (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 21:04:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4F31706;
        Sat, 12 Aug 2023 18:04:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0392460A5F;
        Sun, 13 Aug 2023 01:04:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5AFBC433C7;
        Sun, 13 Aug 2023 01:04:51 +0000 (UTC)
Date:   Sat, 12 Aug 2023 21:04:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zheao Li <me@manjusaka.me>
Cc:     edumazet@google.com, bpf@vger.kernel.org, davem@davemloft.net,
        dsahern@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
        ncardwell@google.com, netdev@vger.kernel.org, pabeni@redhat.com,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v3] tracepoint: add new `tcp:tcp_ca_event` trace event
Message-ID: <20230812210450.53464a78@rorschach.local.home>
In-Reply-To: <20230812210140.117da558@rorschach.local.home>
References: <CANn89iKQXhqgOTkSchH6Bz-xH--pAoSyEORBtawqBTvgG+dFig@mail.gmail.com>
        <20230812201249.62237-1-me@manjusaka.me>
        <20230812205905.016106c0@rorschach.local.home>
        <20230812210140.117da558@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Sat, 12 Aug 2023 21:01:40 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 12 Aug 2023 20:59:05 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Sat, 12 Aug 2023 20:12:50 +0000
> > Zheao Li <me@manjusaka.me> wrote:
> >   
> > > +TRACE_EVENT(tcp_ca_event,
> > > +
> > > +	TP_PROTO(struct sock *sk, const u8 ca_event),
> > > +
> > > +	TP_ARGS(sk, ca_event),
> > > +
> > > +	TP_STRUCT__entry(
> > > +		__field(const void *, skaddr)
> > > +		__field(__u16, sport)
> > > +		__field(__u16, dport)
> > > +		__field(__u16, family)
> > > +		__array(__u8, saddr, 4)
> > > +		__array(__u8, daddr, 4)
> > > +		__array(__u8, saddr_v6, 16)
> > > +		__array(__u8, daddr_v6, 16)
> > > +		__field(__u8, ca_event)    
> > 
> > Please DO NOT LISTEN TO CHECKPATCH!

I forgot to say "for TRACE_EVENT() macros". This is not about what
checkpatch says about other code.

-- Steve


> > 
> > The above looks horrendous! Put it back to:
> >   
> > > +		__field(	const void *,	skaddr			)
> > > +		__field(	__u16,		sport			)
> > > +		__field(	__u16,		dport			)
> > > +		__field(	__u16,		family			)
> > > +		__array(	__u8,		saddr,		4	)
> > > +		__array(	__u8,		daddr,		4	)
> > > +		__array(	__u8,		saddr_v6,	16	)
> > > +		__array(	__u8,		daddr_v6,	16	)
> > > +		__field(	__u8,		ca_event		)    
> > 
> > See how much better it looks I can see fields this way.
> > 
> > The "checkpatch" way is a condensed mess.
> >   
> 
