Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCC4C001B0
	for <linux-trace-kernel@archiver.kernel.org>; Tue,  8 Aug 2023 18:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjHHSyt (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 8 Aug 2023 14:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbjHHSyb (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:54:31 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCAD1B05B
        for <linux-trace-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:12:39 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-348c7075afcso4265ab.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 08 Aug 2023 10:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691514759; x=1692119559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zn2bzFezk/UZyxUtkuS/wxumoulHOnZ5vgKYBp+qi5w=;
        b=adXu39tVun1jBelPm8lbm8X71JbzPs5MbdqO1bwJ14bBAqQhDmac86oHVeyQ5dhzOQ
         9dgVNh6l1yZucMLtLLayqn2OoFL531y03hD5Cd0GewdS1vXFXtsu8zbn8iuWPKejioFB
         O5qg6A4ITw1EAxOEOx5g4m5/kPJZhOA7fJxm0qHFceJDAXTdq5p8R8jI+Z9OOCVYIGLk
         +DdB0/+Ks21KVDkm51DJt+1l0uINdQccHwFE3zazfWpn0rlfA3vwSuR6c1QlTNWibWbt
         0YhPb/dbJ88CYXDqbDy0CoVfeL0i51YxRfVCoZ1SM792SbE1QwX7uRCpkay2iajN81sb
         abJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691514759; x=1692119559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zn2bzFezk/UZyxUtkuS/wxumoulHOnZ5vgKYBp+qi5w=;
        b=Hzr4i59BNKjdlTCKetffHTYrfVcCWUNYLxuMHzbYVzb6VGTWeHOGYheDKcd01VITH3
         NpFKMZX/DaSbhiQO3Yo5l5BSrlzL4RBg2YlBMQYkp6IEojqPVITguObHjnRg56yZmLzB
         Aevm5oBQ7wlOtADHV0t1u61ZO3j0IY2HKER0Q+e4QUf7a+7e3VPktoOpDPuJoK8LAQnB
         LErzm8y2ktgjXWCp1qcSRDgV6YOupDAbWLoPFQ3su6YGcmCk5pvhrLx4HtrEVbLy28K7
         Kbp6vWYnWK0HL8RayOvN1NbJtf42+hHUGyKMyK2FvhHeSfGt/JTX6fLVaYiypsqBRxXG
         nycg==
X-Gm-Message-State: AOJu0YyCn6+QGwUMDitRlU6FSzM+/TSlhML6KnObLhtPrMUnNllOEiS/
        q9Iw/kbypd6YRsZrVeU3CmM7YMZS5tY5mvpF0Z2KO/o1YurGBtbLssb+IQ==
X-Google-Smtp-Source: AGHT+IF/S2chbVVgN+yPnHABejpoo8ifP2bZqpJf8cs3Tyc6YLaH9rDxpT5eAuURhdr8o0ULbCZm5CbGz0HFlBZF3Nc=
X-Received: by 2002:a05:622a:d0:b0:403:aa88:cf7e with SMTP id
 p16-20020a05622a00d000b00403aa88cf7emr595630qtw.29.1691483209473; Tue, 08 Aug
 2023 01:26:49 -0700 (PDT)
MIME-Version: 1.0
References: <CADVnQyn3UMa3Qx6cC1Rx97xLjQdG0eKsiF7oY9UR=b9vU4R-yA@mail.gmail.com>
 <20230808055817.3979-1-me@manjusaka.me>
In-Reply-To: <20230808055817.3979-1-me@manjusaka.me>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 8 Aug 2023 10:26:36 +0200
Message-ID: <CANn89iKxJThy4ZVq4do6Z1bOZsRptfN6N8ydPaHQAmYKCjtOnw@mail.gmail.com>
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

On Tue, Aug 8, 2023 at 7:59=E2=80=AFAM Manjusaka <me@manjusaka.me> wrote:
>
> In normal use case, the tcp_ca_event would be changed in high frequency.
>
> It's a good indicator to represent the network quanlity.

quality ?

Honestly, it is more about TCP stack tracing than 'network quality'

>
> So I propose to add a `tcp:tcp_ca_event` trace event
> like `tcp:tcp_cong_state_set` to help the people to
> trace the TCP connection status
>
> Signed-off-by: Manjusaka <me@manjusaka.me>
> ---
>  include/net/tcp.h          |  9 ++------
>  include/trace/events/tcp.h | 45 ++++++++++++++++++++++++++++++++++++++
>  net/ipv4/tcp_cong.c        | 10 +++++++++
>  3 files changed, 57 insertions(+), 7 deletions(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 0ca972ebd3dd..a68c5b61889c 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -1154,13 +1154,8 @@ static inline bool tcp_ca_needs_ecn(const struct s=
ock *sk)
>         return icsk->icsk_ca_ops->flags & TCP_CONG_NEEDS_ECN;
>  }
>
> -static inline void tcp_ca_event(struct sock *sk, const enum tcp_ca_event=
 event)
> -{
> -       const struct inet_connection_sock *icsk =3D inet_csk(sk);
> -
> -       if (icsk->icsk_ca_ops->cwnd_event)
> -               icsk->icsk_ca_ops->cwnd_event(sk, event);
> -}
> +/* from tcp_cong.c */
> +void tcp_ca_event(struct sock *sk, const enum tcp_ca_event event);
>
>  /* From tcp_cong.c */
>  void tcp_set_ca_state(struct sock *sk, const u8 ca_state);
> diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
> index bf06db8d2046..b374eb636af9 100644
> --- a/include/trace/events/tcp.h
> +++ b/include/trace/events/tcp.h
> @@ -416,6 +416,51 @@ TRACE_EVENT(tcp_cong_state_set,
>                   __entry->cong_state)
>  );
>
> +TRACE_EVENT(tcp_ca_event,
> +
> +       TP_PROTO(struct sock *sk, const u8 ca_event),
> +
> +       TP_ARGS(sk, ca_event),
> +
> +       TP_STRUCT__entry(
> +               __field(const void *, skaddr)
> +               __field(__u16, sport)
> +               __field(__u16, dport)
> +               __array(__u8, saddr, 4)
> +               __array(__u8, daddr, 4)
> +               __array(__u8, saddr_v6, 16)
> +               __array(__u8, daddr_v6, 16)
> +               __field(__u8, ca_event)
> +       ),
> +

Please add the family (look at commit 3dd344ea84e1 ("net: tracepoint:
exposing sk_family in all tcp:tracepoints"))



> +       TP_fast_assign(
> +               struct inet_sock *inet =3D inet_sk(sk);
> +               __be32 *p32;
> +
> +               __entry->skaddr =3D sk;
> +
> +               __entry->sport =3D ntohs(inet->inet_sport);
> +               __entry->dport =3D ntohs(inet->inet_dport);
> +
> +               p32 =3D (__be32 *) __entry->saddr;
> +               *p32 =3D inet->inet_saddr;
> +
> +               p32 =3D (__be32 *) __entry->daddr;
> +               *p32 =3D  inet->inet_daddr;

We keep copying IPv4 addresses that might contain garbage for IPv6 sockets =
:/

> +
> +               TP_STORE_ADDRS(__entry, inet->inet_saddr, inet->inet_dadd=
r,
> +                          sk->sk_v6_rcv_saddr, sk->sk_v6_daddr);

I will send a cleanup, because IP_STORE_ADDRS() should really take
care of all details.


> +
> +               __entry->ca_event =3D ca_event;
> +       ),
> +
> +       TP_printk("sport=3D%hu dport=3D%hu saddr=3D%pI4 daddr=3D%pI4 sadd=
rv6=3D%pI6c daddrv6=3D%pI6c ca_event=3D%u",
> +                 __entry->sport, __entry->dport,
> +                 __entry->saddr, __entry->daddr,
> +                 __entry->saddr_v6, __entry->daddr_v6,
> +                 __entry->ca_event)

Please print the symbol instead of numeric ca_event.

Look at show_tcp_state_name() for instance.
