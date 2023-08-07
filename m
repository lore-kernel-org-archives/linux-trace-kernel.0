Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80148C001DF
	for <linux-trace-kernel@archiver.kernel.org>; Mon,  7 Aug 2023 20:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjHGUAj (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 7 Aug 2023 16:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjHGUAj (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 16:00:39 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36559E79
        for <linux-trace-kernel@vger.kernel.org>; Mon,  7 Aug 2023 13:00:37 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-79a2216a2d1so1328404241.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 07 Aug 2023 13:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691438436; x=1692043236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVQdRv1Yvag9pZf4ApwFuqYgv2RsqMJxrynRlvroKKI=;
        b=OfneyUN/2lerRgrz+LIZo4dK4kbguaa6/Vk3KCO8tPslYWmyMT0iw2hGT3DjJhMtPW
         +cXO8gED1UB4/QDs8B+gSQJuG1LuSkgcEaoY/W7Ir/NnGfS2aCUxUhElndRMvxe26+PY
         p+J0HeEO1KC3C7NxI/hNU6L2oH8zZi6exeqbHDfvIaPihhCrnGPQN060l+N9kzB4f+po
         t8XcRQGm1ccOtyq9pheseBUNMDq8R4jUTaVP1VOm3H6wT2OIryggbq/jcM/xZHErj187
         1Bv5P4B/bFGSl3cNjovdYXeuzQVfuoC+abgfQn7/2S4Gce3GZ/C4+6pol3Jq/NzEZE/5
         F9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691438436; x=1692043236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mVQdRv1Yvag9pZf4ApwFuqYgv2RsqMJxrynRlvroKKI=;
        b=XToglp9XVuit11fsLwVBcKmoFNad4OoArf9Z64iGejrYMJheLlOd4Ah0GZec/QcFGk
         JiDRpyHayPA0d014I6Qrk7pk+6NSx8zHCMTfwG2fTd0kc6dMpEmTC9+U2S5aLI6R/soS
         IuXMCbna1giS+RT/CpJf7T3PTUGVC4kwPgYnSpj+DwF4hsz2faFtQAv2WzTbI/xZfKBT
         UMenWd8StIUzuNGqmw4EpC0UBlqMOxPUTM71JOTIdtF1SkZs++pTNeDbjDvG8r6LnU7P
         hmgeH54BMP1DkHv17HxHoc/dhlZKQOL4ahtLW5ObaYSguM5pQEMRSlq6zrvyytI5iltx
         if3g==
X-Gm-Message-State: AOJu0Yzhv+Tkk/Rg8sAmJRCwRdMPYOrZBkvBtBMwNPf86L+x7aUVlU0E
        mD26pvualu+8CBtHZBgHVFuWQaiU4p4lDReo4ONgGg==
X-Google-Smtp-Source: AGHT+IEjizJJCB4nnVxo3w+/QZ+ihPBzKEyUWREcezwYPLVdOJJlDAIz2ug7nc/eYnPsuXNuBnjo8muQh7/Fjn3MnQs=
X-Received: by 2002:a67:e3b7:0:b0:444:eedd:1aea with SMTP id
 j23-20020a67e3b7000000b00444eedd1aeamr4591925vsm.17.1691438436080; Mon, 07
 Aug 2023 13:00:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230807183308.9015-1-me@manjusaka.me>
In-Reply-To: <20230807183308.9015-1-me@manjusaka.me>
From:   Neal Cardwell <ncardwell@google.com>
Date:   Mon, 7 Aug 2023 16:00:18 -0400
Message-ID: <CADVnQyn3UMa3Qx6cC1Rx97xLjQdG0eKsiF7oY9UR=b9vU4R-yA@mail.gmail.com>
Subject: Re: [PATCH] tracepoint: add new `tcp:tcp_ca_event_set` trace event
To:     Manjusaka <me@manjusaka.me>
Cc:     edumazet@google.com, mhiramat@kernel.org, rostedt@goodmis.org,
        davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Mon, Aug 7, 2023 at 2:33=E2=80=AFPM Manjusaka <me@manjusaka.me> wrote:
>
> In normal use case, the tcp_ca_event would be changed in high frequency.
>
> It's a good indicator to represent the network quanlity.
>
> So I propose to add a `tcp:tcp_ca_event_set` trace event
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
> index bf06db8d2046..38415c5f1d52 100644
> --- a/include/trace/events/tcp.h
> +++ b/include/trace/events/tcp.h
> @@ -416,6 +416,51 @@ TRACE_EVENT(tcp_cong_state_set,
>                   __entry->cong_state)
>  );
>
> +TRACE_EVENT(tcp_ca_event_set,

Regarding the proposed name, "tcp_ca_event_set"... including "set" in
the name is confusing, since the tcp_ca_event() function is not really
setting anything. :-)

The trace_tcp_cong_state_set() call you are using as a model has "set"
in the name because the function it is tracing, tcp_set_ca_state(),
has "set" in the name. :-)

Would it work to use something like:
  TRACE_EVENT(tcp_ca_event,

thanks,
neal
