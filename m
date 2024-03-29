Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8533B290
	for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Mar 2024 09:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711703257; cv=none; b=c9CtaO+UlZgB2qNjC12CoopUHsGiVEDdXa6JCR3MuWCxT0vnmj8LzwsrZwN1gcGTwDr6DgsX2+S3hQlbKJaKPSJecroTPQYYLRH5AK//CdU3P35oFD9BqVUtGR5WjohaFlLh4a63TYvfdh2mvKZ3W2lWxkriMOmwNXHyfFSnGCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711703257; c=relaxed/simple;
	bh=vJb7YiygKplC4vPlpDcP0mJCH1WbupU2UuVmfi1ALfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U4HJbzPA0s7IP8b0qfxHJBfRhbWUzUg8iSU2Qz6m9oohxhGnUT4LEGTNkTtVrCGJUW4lJVMgwzMKynRjQQq4WqT/Il1zoVJ8qNtEi8lvcnrUJXmcZwVmAe08uoDba1edVRxMnWZJAh+FT3iX5rkB2zkhZax4d/cqdqWSEyFcsjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZBnpug3i; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZBnpug3i"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-512fab8cc6aso1334e87.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Mar 2024 02:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711703253; x=1712308053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJMheStCEdHMJvUBuv5qXsZ717POg3wfrovjb15utaA=;
        b=ZBnpug3iwbQDn8IF4XqNFjebzp3geU47Dk/uZRk6fAgIefTR3x2eZNff/KuVbohcwQ
         ktYcmv4Xr6oXnqiXbjAxRVIbAOIldQI959AnkKypnDDhUN+a+YgCgculEbO5165oaNZr
         WCTa1PqWLOXEKl53WizBkaDWBYdsd3pzfuZwm07uQGZGr+EEAbrRcW2zId2lEAqfm82+
         k8pTy7oNzmvCdD06tJ9cwbRX6NFON6MVOakGzSCUQfqaXsHAiLb76NSMCWBn6JuT8t5t
         aPtbGAimppv9f1wEOQT9bhiC8fLBn2fF0jxrk7xK3lIyhZ/HI5oT7bRkD+830UXtK9Tf
         Dwqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711703253; x=1712308053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJMheStCEdHMJvUBuv5qXsZ717POg3wfrovjb15utaA=;
        b=KpVqwdI02AqZOKfoCCpr4vATgrAa6FpQeSY8lLxZqN9J1+dX3IvSc4zpISLwhl4oG6
         jTg43A08BUXIA4CuG6PLUINNZyFzXfSPrvwUjulpoANt19nwE/0QscrOIi6gXB9G9Aa1
         es5I0hxZEKdZyApBP8C3Y8lfFdAxm44QvnMsZYDWydnFxbtxuPiF/9IDUNnWGy+Hd8ht
         2e34ObniEIY76Ee4jgJWeBBNdr2RAP9YO4ViO1Njk8MQXDZWNW2FJ/iYF3K5MMTztblf
         5BZ/19JWZ1drr6v3Np29t0R9Rc2JMAd4Kp/35/dHwhN2v95t7IKZ+TDf91/fmEvRRrCS
         mRiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnqxCD7ZBXNUjFHi2GD/gzOGiqAmCaB7eLbSc6Q0hrEqsDNXF6jeKq8sCSD06HPj3SSB9ILuvzsz8Ri1pLcVBSDfJ0tqAkph43/gmaY/sB4tO6
X-Gm-Message-State: AOJu0YxCZ5smxEl0H6aplO46IgtcptnJSVMv2g273mY9PNvPy3FmaEQY
	1qxPJosmlJ6C8cGGqJYG0mqjAMQ9vyfUreYA8+YAkPswHge44J9XA2gcl4lc79wCKLtZdE5HcAf
	IygzmYBLUpKNhfA+F06G+f9rjcvxU9B6qk4Aw
X-Google-Smtp-Source: AGHT+IHcK6x81OSZg8QFt6S2PsGLIfJ6nmLw/ihvvIkeWxelgFC9PLD/P96XdS+dn3TJ3KHGeYIOLOh+7joCMXx3fPk=
X-Received: by 2002:a05:6512:3762:b0:515:b06f:a8c4 with SMTP id
 z2-20020a056512376200b00515b06fa8c4mr94729lft.2.1711703252872; Fri, 29 Mar
 2024 02:07:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329034243.7929-1-kerneljasonxing@gmail.com> <20240329034243.7929-3-kerneljasonxing@gmail.com>
In-Reply-To: <20240329034243.7929-3-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 29 Mar 2024 10:07:19 +0100
Message-ID: <CANn89iK35sZ7yYLfRb+m475b7kg+LHw4nV9qHWP7aQtLvBoeMA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/3] trace: tcp: fully support trace_tcp_send_reset
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, rostedt@goodmis.org, 
	kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 4:43=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Prior to this patch, what we can see by enabling trace_tcp_send is
> only happening under two circumstances:
> 1) active rst mode
> 2) non-active rst mode and based on the full socket
>
> That means the inconsistency occurs if we use tcpdump and trace
> simultaneously to see how rst happens.
>
> It's necessary that we should take into other cases into considerations,
> say:
> 1) time-wait socket
> 2) no socket
> ...
>
> By parsing the incoming skb and reversing its 4-tuple can
> we know the exact 'flow' which might not exist.
>
> Samples after applied this patch:
> 1. tcp_send_reset: skbaddr=3DXXX skaddr=3DXXX src=3Dip:port dest=3Dip:por=
t
> state=3DTCP_ESTABLISHED
> 2. tcp_send_reset: skbaddr=3D000...000 skaddr=3DXXX src=3Dip:port dest=3D=
ip:port
> state=3DUNKNOWN
> Note:
> 1) UNKNOWN means we cannot extract the right information from skb.
> 2) skbaddr/skaddr could be 0
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  include/trace/events/tcp.h | 39 ++++++++++++++++++++++++++++++++++++--
>  net/ipv4/tcp_ipv4.c        |  4 ++--
>  net/ipv6/tcp_ipv6.c        |  3 ++-
>  3 files changed, 41 insertions(+), 5 deletions(-)
>
> diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
> index 194425f69642..289438c54227 100644
> --- a/include/trace/events/tcp.h
> +++ b/include/trace/events/tcp.h
> @@ -78,11 +78,46 @@ DEFINE_EVENT(tcp_event_sk_skb, tcp_retransmit_skb,
>   * skb of trace_tcp_send_reset is the skb that caused RST. In case of
>   * active reset, skb should be NULL
>   */
> -DEFINE_EVENT(tcp_event_sk_skb, tcp_send_reset,
> +TRACE_EVENT(tcp_send_reset,
>
>         TP_PROTO(const struct sock *sk, const struct sk_buff *skb),
>
> -       TP_ARGS(sk, skb)
> +       TP_ARGS(sk, skb),
> +
> +       TP_STRUCT__entry(
> +               __field(const void *, skbaddr)
> +               __field(const void *, skaddr)
> +               __field(int, state)
> +               __array(__u8, saddr, sizeof(struct sockaddr_in6))
> +               __array(__u8, daddr, sizeof(struct sockaddr_in6))
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->skbaddr =3D skb;
> +               __entry->skaddr =3D sk;
> +               /* Zero means unknown state. */
> +               __entry->state =3D sk ? sk->sk_state : 0;
> +
> +               memset(__entry->saddr, 0, sizeof(struct sockaddr_in6));
> +               memset(__entry->daddr, 0, sizeof(struct sockaddr_in6));
> +
> +               if (sk && sk_fullsock(sk)) {
> +                       const struct inet_sock *inet =3D inet_sk(sk);
> +
> +                       TP_STORE_ADDR_PORTS(__entry, inet, sk);
> +               } else {

To be on the safe side, I would test if (skb) here.
We have one caller with skb =3D=3D NULL, we might have more in the future.

> +                       /*
> +                        * We should reverse the 4-tuple of skb, so later
> +                        * it can print the right flow direction of rst.
> +                        */
> +                       TP_STORE_ADDR_PORTS_SKB(skb, entry->daddr, entry-=
>saddr);
> +               }
> +       ),
> +
> +       TP_printk("skbaddr=3D%p skaddr=3D%p src=3D%pISpc dest=3D%pISpc st=
ate=3D%s",
> +                 __entry->skbaddr, __entry->skaddr,
> +                 __entry->saddr, __entry->daddr,
> +                 __entry->state ? show_tcp_state_name(__entry->state) : =
"UNKNOWN")
>  );
>
>  /*
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index a22ee5838751..d5c4a969c066 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -868,10 +868,10 @@ static void tcp_v4_send_reset(const struct sock *sk=
, struct sk_buff *skb)
>          */
>         if (sk) {
>                 arg.bound_dev_if =3D sk->sk_bound_dev_if;
> -               if (sk_fullsock(sk))
> -                       trace_tcp_send_reset(sk, skb);
>         }

Remove the { } ?


>
> +       trace_tcp_send_reset(sk, skb);
> +
>         BUILD_BUG_ON(offsetof(struct sock, sk_bound_dev_if) !=3D
>                      offsetof(struct inet_timewait_sock, tw_bound_dev_if)=
);
>
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index 3f4cba49e9ee..8e9c59b6c00c 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -1113,7 +1113,6 @@ static void tcp_v6_send_reset(const struct sock *sk=
, struct sk_buff *skb)
>         if (sk) {
>                 oif =3D sk->sk_bound_dev_if;
>                 if (sk_fullsock(sk)) {
> -                       trace_tcp_send_reset(sk, skb);
>                         if (inet6_test_bit(REPFLOW, sk))
>                                 label =3D ip6_flowlabel(ipv6h);
>                         priority =3D READ_ONCE(sk->sk_priority);
> @@ -1129,6 +1128,8 @@ static void tcp_v6_send_reset(const struct sock *sk=
, struct sk_buff *skb)
>                         label =3D ip6_flowlabel(ipv6h);
>         }
>
> +       trace_tcp_send_reset(sk, skb);
> +
>         tcp_v6_send_response(sk, skb, seq, ack_seq, 0, 0, 0, oif, 1,
>                              ipv6_get_dsfield(ipv6h), label, priority, tx=
hash,
>                              &key);
> --
> 2.37.3
>
