Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3287DC001B0
	for <linux-trace-kernel@archiver.kernel.org>; Tue,  8 Aug 2023 20:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbjHHUsd (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 8 Aug 2023 16:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbjHHUsQ (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:48:16 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909D315BA6
        for <linux-trace-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:41:15 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-3493d0f785dso195ab.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691512869; x=1692117669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCOXJYzxETCH/0UcvxLQeHGSMM7DSEXKUT9P3Dlmymo=;
        b=OjpxwZgwSn6o28EtjIan1lHju74EERsJr4orcmboMr/ayQy9uNlIEECBPj2dVlxj2l
         7t7bKOWW81M5YclIV2VxQ+rvYsOtkJggoWOnXrsbSrrlGOy1x1TvzsE6dfx2f4ImfOKd
         N7CJ7a03xLeHVnWj8BjcSgZ55Mq6/QP+AcKwOJHSX30lV40h5f0++c07vxRaFc6tXIsh
         kPhpx+KGHQPYOQLN8PuvCDto3aOLCsrw383NdveN/7FJCiA0EU2hu+1vQCWZd2pl80tE
         MpJ/GkM7CjBITJeqDdGnKfjZlCfwkhF8Y8zNXJQyTnhXJI4ONxNqd4tKtAJ7clRVLn7x
         2Aeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691512869; x=1692117669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kCOXJYzxETCH/0UcvxLQeHGSMM7DSEXKUT9P3Dlmymo=;
        b=JS7Zgb0ydyfKA+nbTA4bmWXrtqhEUWa7/XumhqCba/doZsVh6WWHmoHdHc174rIvgQ
         b77lp/i5wxebEODarxSKIoWLavRhvZ5zGIcaJMwyGO3NthNhqffNsJcpUthQsFw9VZb6
         sA6rRuZpGvjlGgMwf+QiabFWYMKpkKOG8k2LrbUBdXx2t0oBesbK5zwPUQZTnFhGKv9+
         PRL0k+KStKfGTkEcHQI/6Jk2A43X2/tXasuG5IFAKWOMmzWl1nnqvhvNxKPHWoYTEVjV
         4+hiL/ADaEBINwprpYChZNEZoPSPxiqjHSMUESQlzQVDDeey7FGOYZsaHEttWDxK8pn9
         1Chw==
X-Gm-Message-State: AOJu0Yz3dX/ekaCNIE9EXLJTy2tmVY/4WD5Rqqae98ZNSGKkMtbsZQPg
        9DF6cCWf7RKIsKW5AxAe76VHUDDgt4iWHGhHyhYLWqgBbFq1NOH/pmI=
X-Google-Smtp-Source: AGHT+IEfM3zZpi2A8IEkcUU11DnAyYRP6HYaBR73Q/AKzK2pHMPvaVHfkSYylHJ4uhb2VI1kTwpMv6BetR8BNyyQJjc=
X-Received: by 2002:ac8:5951:0:b0:403:96e3:4745 with SMTP id
 17-20020ac85951000000b0040396e34745mr749543qtz.20.1691484513351; Tue, 08 Aug
 2023 01:48:33 -0700 (PDT)
MIME-Version: 1.0
References: <CADVnQyn3UMa3Qx6cC1Rx97xLjQdG0eKsiF7oY9UR=b9vU4R-yA@mail.gmail.com>
 <20230808055817.3979-1-me@manjusaka.me> <CANn89iKxJThy4ZVq4do6Z1bOZsRptfN6N8ydPaHQAmYKCjtOnw@mail.gmail.com>
 <af02d2a9-4655-45a1-8c3a-d9921bfdbc35@manjusaka.me>
In-Reply-To: <af02d2a9-4655-45a1-8c3a-d9921bfdbc35@manjusaka.me>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 8 Aug 2023 10:48:21 +0200
Message-ID: <CANn89iKQXhqgOTkSchH6Bz-xH--pAoSyEORBtawqBTvgG+dFig@mail.gmail.com>
Subject: Re: [PATCH v2] tracepoint: add new `tcp:tcp_ca_event` trace event
To:     Manjusaka <me@manjusaka.me>
Cc:     ncardwell@google.com, bpf@vger.kernel.org, davem@davemloft.net,
        dsahern@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com, rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Tue, Aug 8, 2023 at 10:46=E2=80=AFAM Manjusaka <me@manjusaka.me> wrote:
>
>
>
> On 2023/8/8 16:26, Eric Dumazet wrote:
> > On Tue, Aug 8, 2023 at 7:59=E2=80=AFAM Manjusaka <me@manjusaka.me> wrot=
e:
> >>
> >> In normal use case, the tcp_ca_event would be changed in high frequenc=
y.
> >>
> >> It's a good indicator to represent the network quanlity.
> >
> > quality ?
> >
> > Honestly, it is more about TCP stack tracing than 'network quality'
> >
> >>
> >> So I propose to add a `tcp:tcp_ca_event` trace event
> >> like `tcp:tcp_cong_state_set` to help the people to
> >> trace the TCP connection status
> >>
> >> Signed-off-by: Manjusaka <me@manjusaka.me>
> >> ---
> >>  include/net/tcp.h          |  9 ++------
> >>  include/trace/events/tcp.h | 45 +++++++++++++++++++++++++++++++++++++=
+
> >>  net/ipv4/tcp_cong.c        | 10 +++++++++
> >>  3 files changed, 57 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/include/net/tcp.h b/include/net/tcp.h
> >> index 0ca972ebd3dd..a68c5b61889c 100644
> >> --- a/include/net/tcp.h
> >> +++ b/include/net/tcp.h
> >> @@ -1154,13 +1154,8 @@ static inline bool tcp_ca_needs_ecn(const struc=
t sock *sk)
> >>         return icsk->icsk_ca_ops->flags & TCP_CONG_NEEDS_ECN;
> >>  }
> >>
> >> -static inline void tcp_ca_event(struct sock *sk, const enum tcp_ca_ev=
ent event)
> >> -{
> >> -       const struct inet_connection_sock *icsk =3D inet_csk(sk);
> >> -
> >> -       if (icsk->icsk_ca_ops->cwnd_event)
> >> -               icsk->icsk_ca_ops->cwnd_event(sk, event);
> >> -}
> >> +/* from tcp_cong.c */
> >> +void tcp_ca_event(struct sock *sk, const enum tcp_ca_event event);
> >>
> >>  /* From tcp_cong.c */
> >>  void tcp_set_ca_state(struct sock *sk, const u8 ca_state);
> >> diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
> >> index bf06db8d2046..b374eb636af9 100644
> >> --- a/include/trace/events/tcp.h
> >> +++ b/include/trace/events/tcp.h
> >> @@ -416,6 +416,51 @@ TRACE_EVENT(tcp_cong_state_set,
> >>                   __entry->cong_state)
> >>  );
> >>
> >> +TRACE_EVENT(tcp_ca_event,
> >> +
> >> +       TP_PROTO(struct sock *sk, const u8 ca_event),
> >> +
> >> +       TP_ARGS(sk, ca_event),
> >> +
> >> +       TP_STRUCT__entry(
> >> +               __field(const void *, skaddr)
> >> +               __field(__u16, sport)
> >> +               __field(__u16, dport)
> >> +               __array(__u8, saddr, 4)
> >> +               __array(__u8, daddr, 4)
> >> +               __array(__u8, saddr_v6, 16)
> >> +               __array(__u8, daddr_v6, 16)
> >> +               __field(__u8, ca_event)
> >> +       ),
> >> +
> >
> > Please add the family (look at commit 3dd344ea84e1 ("net: tracepoint:
> > exposing sk_family in all tcp:tracepoints"))
> >
> >
> >
> >> +       TP_fast_assign(
> >> +               struct inet_sock *inet =3D inet_sk(sk);
> >> +               __be32 *p32;
> >> +
> >> +               __entry->skaddr =3D sk;
> >> +
> >> +               __entry->sport =3D ntohs(inet->inet_sport);
> >> +               __entry->dport =3D ntohs(inet->inet_dport);
> >> +
> >> +               p32 =3D (__be32 *) __entry->saddr;
> >> +               *p32 =3D inet->inet_saddr;
> >> +
> >> +               p32 =3D (__be32 *) __entry->daddr;
> >> +               *p32 =3D  inet->inet_daddr;
> >
> > We keep copying IPv4 addresses that might contain garbage for IPv6 sock=
ets :/
> >
> >> +
> >> +               TP_STORE_ADDRS(__entry, inet->inet_saddr, inet->inet_d=
addr,
> >> +                          sk->sk_v6_rcv_saddr, sk->sk_v6_daddr);
> >
> > I will send a cleanup, because IP_STORE_ADDRS() should really take
> > care of all details.
> >
> >
> >> +
> >> +               __entry->ca_event =3D ca_event;
> >> +       ),
> >> +
> >> +       TP_printk("sport=3D%hu dport=3D%hu saddr=3D%pI4 daddr=3D%pI4 s=
addrv6=3D%pI6c daddrv6=3D%pI6c ca_event=3D%u",
> >> +                 __entry->sport, __entry->dport,
> >> +                 __entry->saddr, __entry->daddr,
> >> +                 __entry->saddr_v6, __entry->daddr_v6,
> >> +                 __entry->ca_event)
> >
> > Please print the symbol instead of numeric ca_event.
> >
> > Look at show_tcp_state_name() for instance.
>
> Thanks for the kindness code review, I still get some issue here(Sorry fo=
r the first time to contribute):
>
> 1. > We keep copying IPv4 addresses that might contain garbage for IPv6 s=
ockets :/
>
> I'm not getting your means, would you mean that we should only save the I=
Pv4 Address here?
>
> 2. > I will send a cleanup, because IP_STORE_ADDRS() should really take c=
are of all details.
>
> I think you will make the address assignment code in TP_fast_assign as a =
new function.
>
> Should I submit the new change until you send the cleanup patch or I can =
make this in my patch(cleanup the address assignment)
>

Wait a bit, I am sending fixes today, so that no more copy/paste
duplicates the issues.
