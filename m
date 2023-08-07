Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5EAC001DF
	for <linux-trace-kernel@archiver.kernel.org>; Mon,  7 Aug 2023 12:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbjHGMek (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 7 Aug 2023 08:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjHGMej (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:34:39 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FA110D9
        for <linux-trace-kernel@vger.kernel.org>; Mon,  7 Aug 2023 05:34:38 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-40a47e8e38dso425051cf.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 07 Aug 2023 05:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691411677; x=1692016477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0FG/UEllzNChCej8uXILncmRysAuM1vV07T2iwe42JA=;
        b=JpyDvOlj8VBrVqf1QSAgsDbip9pZlub24NJkJgJyyKB/H/DvdYdoxmjreXhlt1XvEP
         BP0DjmArpqwF15QAa3jz91kn+FPVNwL+cRVQ3I/BKEXs07v/DA+dOdarrrjAcNiyXf4Y
         J59sSCESD9TIZf4sTxP8kqwazGIcloy5AMOdFtij0HlIzDpZK5rFOw+zPENKEcfIv/yu
         3B/2arwFsiBhG4ZUeUh0EG1CNngwKQX+VkNkpwxYQodGXSONZrJngAxrxzgNj3Lk++JE
         on7fa7ERhUJGQfqu3LEfqOVs5Rc+FljYUwIM3CcQ4stUUYTtGKEvP5N6gcfr2dKAYfOp
         s2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691411677; x=1692016477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0FG/UEllzNChCej8uXILncmRysAuM1vV07T2iwe42JA=;
        b=fLUqHUXOAy2SAE9gF+sAajYyEd44znggOYWxxYHa2AoPwYLgbmEGygRyUc+zBi7l0V
         4ZzZmFdgQpBq1EbqHmYm+CfERk+tSkSHasJFd3Uc2mq2+lZEIj5EFa2IBk0cprZwBgjl
         6Rhr6rY/avk/qpPmZv8A1ZFCPGgn/+cG76BjlLpL0PrvmiA+DczlW8lxU0h5BV9b2wvu
         pjNA4MSfb0LrwXbHUv8fyJBhvp2Bv+DYxN/Q4Ya6EvMYJN4pfe8BuL5zN0Ql6+N8sOv5
         NL+y3tuxYnb6Mf96dDUlJKkqv9+D1VOshYBjjzdtnDCEuQ04aUV+3Mvkm51X/Sz/pD+X
         9T+w==
X-Gm-Message-State: AOJu0YyYQN4bHCfFIglOgEIEsaKW15lQUAszIJMoNaky1ARhMOjl852I
        GP/dPSg4agsZi+d0OruUzQi3YLT0tyuINJssN15u5A==
X-Google-Smtp-Source: AGHT+IGFEOfPtttEqEQyisE87Q3lIx5E81ZJFnGZiNcPLZo40nfouDPJGZtep5wdJaynAYrKupNCRJJKkJYsTDd7zVc=
X-Received: by 2002:ac8:7d8c:0:b0:405:3a65:b3d6 with SMTP id
 c12-20020ac87d8c000000b004053a65b3d6mr369753qtd.13.1691411677157; Mon, 07 Aug
 2023 05:34:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230806075216.13378-1-me@manjusaka.me>
In-Reply-To: <20230806075216.13378-1-me@manjusaka.me>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 7 Aug 2023 14:34:24 +0200
Message-ID: <CANn89i+bMh-xU7PCxf_O5N+vy=83S+V=23mAAmbCuhjuP5Ob9g@mail.gmail.com>
Subject: Re: [PATCH] [RFC PATCH] tcp event: add new tcp:tcp_cwnd_restart event
To:     Manjusaka <me@manjusaka.me>
Cc:     mhiramat@kernel.org, rostedt@goodmis.org, davem@davemloft.net,
        dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Sun, Aug 6, 2023 at 9:52=E2=80=AFAM Manjusaka <me@manjusaka.me> wrote:
>
> The tcp_cwnd_restart function would be called if the user has enabled the
> tcp_slow_start_after_idle configuration and would be triggered when the
> connection is idle (like LONG RTO etc.). I think it would be great to
> add a new trace event named 'tcp:tcp_cwnd_reset'; it would help people
> to monitor the TCP state in a complicated network environment(like
> overlay/underlay SDN in Kubernetes, etc)
>
> Signed-off-by: Manjusaka <me@manjusaka.me>
> ---
>  include/trace/events/tcp.h | 7 +++++++
>  net/ipv4/tcp_output.c      | 1 +
>  2 files changed, 8 insertions(+)
>
> diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
> index bf06db8d2046..fa44191cc609 100644
> --- a/include/trace/events/tcp.h
> +++ b/include/trace/events/tcp.h
> @@ -187,6 +187,13 @@ DEFINE_EVENT(tcp_event_sk, tcp_rcv_space_adjust,
>         TP_ARGS(sk)
>  );
>
> +DEFINE_EVENT(tcp_event_sk, tcp_cwnd_restart,
> +
> +       TP_PROTO(struct sock *sk),
> +
> +       TP_ARGS(sk)
> +);
> +
>  TRACE_EVENT(tcp_retransmit_synack,
>
>         TP_PROTO(const struct sock *sk, const struct request_sock *req),
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 51d8638d4b4c..e902fa74303d 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -141,6 +141,7 @@ static __u16 tcp_advertise_mss(struct sock *sk)
>   */
>  void tcp_cwnd_restart(struct sock *sk, s32 delta)
>  {
> +       trace_tcp_cwnd_restart(sk);

Do not include code before variable declarations.

>         struct tcp_sock *tp =3D tcp_sk(sk);
>         u32 restart_cwnd =3D tcp_init_cwnd(tp, __sk_dst_get(sk));
>         u32 cwnd =3D tcp_snd_cwnd(tp);
> --
> 2.34.1
>

I would rather add a trace in tcp_ca_event(), this would be more generic ?
