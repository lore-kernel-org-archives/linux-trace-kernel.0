Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17086C0015E
	for <linux-trace-kernel@archiver.kernel.org>; Sun, 13 Aug 2023 00:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjHMA7H (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Sat, 12 Aug 2023 20:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjHMA7G (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 20:59:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7237E1706;
        Sat, 12 Aug 2023 17:59:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0313561C44;
        Sun, 13 Aug 2023 00:59:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7727C433C8;
        Sun, 13 Aug 2023 00:59:06 +0000 (UTC)
Date:   Sat, 12 Aug 2023 20:59:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zheao Li <me@manjusaka.me>
Cc:     edumazet@google.com, bpf@vger.kernel.org, davem@davemloft.net,
        dsahern@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
        ncardwell@google.com, netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH v3] tracepoint: add new `tcp:tcp_ca_event` trace event
Message-ID: <20230812205905.016106c0@rorschach.local.home>
In-Reply-To: <20230812201249.62237-1-me@manjusaka.me>
References: <CANn89iKQXhqgOTkSchH6Bz-xH--pAoSyEORBtawqBTvgG+dFig@mail.gmail.com>
        <20230812201249.62237-1-me@manjusaka.me>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Sat, 12 Aug 2023 20:12:50 +0000
Zheao Li <me@manjusaka.me> wrote:

> +TRACE_EVENT(tcp_ca_event,
> +
> +	TP_PROTO(struct sock *sk, const u8 ca_event),
> +
> +	TP_ARGS(sk, ca_event),
> +
> +	TP_STRUCT__entry(
> +		__field(const void *, skaddr)
> +		__field(__u16, sport)
> +		__field(__u16, dport)
> +		__field(__u16, family)
> +		__array(__u8, saddr, 4)
> +		__array(__u8, daddr, 4)
> +		__array(__u8, saddr_v6, 16)
> +		__array(__u8, daddr_v6, 16)
> +		__field(__u8, ca_event)

Please DO NOT LISTEN TO CHECKPATCH!

The above looks horrendous! Put it back to:

> +		__field(	const void *,	skaddr			)
> +		__field(	__u16,		sport			)
> +		__field(	__u16,		dport			)
> +		__field(	__u16,		family			)
> +		__array(	__u8,		saddr,		4	)
> +		__array(	__u8,		daddr,		4	)
> +		__array(	__u8,		saddr_v6,	16	)
> +		__array(	__u8,		daddr_v6,	16	)
> +		__field(	__u8,		ca_event		)

See how much better it looks I can see fields this way.

The "checkpatch" way is a condensed mess.

-- Steve

> +	),
> +
> +	TP_fast_assign(
> +		struct inet_sock *inet = inet_sk(sk);
> +		__be32 *p32;
> +
> +		__entry->skaddr = sk;
> +
> +		__entry->sport = ntohs(inet->inet_sport);
> +		__entry->dport = ntohs(inet->inet_dport);
> +		__entry->family = sk->sk_family;
> +
> +		p32 = (__be32 *) __entry->saddr;
> +		*p32 = inet->inet_saddr;
> +
> +		p32 = (__be32 *) __entry->daddr;
> +		*p32 =  inet->inet_daddr;
> +
> +		TP_STORE_ADDRS(__entry, inet->inet_saddr,
> inet->inet_daddr,
> +			   sk->sk_v6_rcv_saddr, sk->sk_v6_daddr);
> +
> +		__entry->ca_event = ca_event;
> +	),
> +
> +	TP_printk("family=%s sport=%hu dport=%hu saddr=%pI4
> daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c ca_event=%s",
> +		  show_family_name(__entry->family),
> +		  __entry->sport, __entry->dport,
> +		  __entry->saddr, __entry->daddr,
> +		  __entry->saddr_v6, __entry->daddr_v6,
> +		  show_tcp_ca_event_names(__entry->ca_event))
> +);
> +
>  #endif /* _TRACE_TCP_H */
>  
