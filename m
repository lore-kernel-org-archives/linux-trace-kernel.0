Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F79754F92
	for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Mar 2024 10:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711709032; cv=none; b=tSL4QknHSssCCRE8zBkoIKDskM8wLJje+ium0tb5JKZ/RcSwkOOtZYMzCCsWaNsrOHJfGpHSgi+VrD+IJadEJEdGxBBls73EZX6r41XV1JrB95Xyg8C07Dg8sgAb55eHOanJPrV2IzbzE9O4KeZCnDLgjxYckhcPQJ9ZOwlXelw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711709032; c=relaxed/simple;
	bh=kANklVzcWLeV7GfBdlIVGJwRz/5Ghl5l8FZ9KpprDXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CaMRxzDsU20V3QYuk701K9GXZnj5XJmGt2QR4AtvnbOIJZfdiSe7hzJ3b7tqTLMdlP5j+YKjm5eHdBqh9EnjL9P+8rF60YyQ87S8pA+X2zlHGKh4/PsZmAOGM330XPsyty2E8On+938bd36+m/X/vKzxaOfaD9E0HPVKjHg+hlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KZ0OL3Zr; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KZ0OL3Zr"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4148c09ec6bso43645e9.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Mar 2024 03:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711709028; x=1712313828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BswVeo27Oh7dAc/LOhv6CTMo7+P1mAzw3bzPOA93dfE=;
        b=KZ0OL3ZrrftA44suzZ0ULr7Wl4K5lwwF/9FQOnNJMskpZcGm6KB4sg9my6shS2XekH
         EetmR64Y3824Hlp4wJDKmAHm/TqwywNeyADRtd6OJRHCVuUWNv2RiYIZClxHALfgSMDg
         6PvwVQST2a3yRnAM3A+89epkBLNNoYjkRQmf/0g2uLDvmEgTv9995Enl9mumU9iABoKx
         HMmZTLse38zbPltukXFUCx6B10dIktsGTRLv343yEoFFG36W3gnnuN0Skcco/NPgGI79
         dW8ynBf+JR2DCJlgQZ015w2spG01ucqfSTT/3F1z2viucmkbJOXx5DEoCO2KwFMwTMCr
         /ESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711709028; x=1712313828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BswVeo27Oh7dAc/LOhv6CTMo7+P1mAzw3bzPOA93dfE=;
        b=P6Fu0p5A3vxw3veACnW+oBjahE/V3jL9b/SdTtaGAG+1276alSOi4FTl9So0FGZkuJ
         qztZIxUk3Mm6/r75rJMN8ZBopr9r+5oOtPXytJADMpZDoFSgH9rR9DRWFuLEm86ZWqRn
         MTqyZiupEYe7zhg3L/MVqBQSbLJJgIHp8DIKv0LXhBkJvhjKSQr/WvIxlAwGTFPrrAfA
         BkTlraKJRMsfcEQ4CFhvVG+G2FJOPw40t6rYyDD0QUlFWSYqHPCuEj7eGgXl3NGtX9cS
         g5vazLPcsGCQcsLezNkudsadz3qdxlStwRBkN5qZFFq1UDt7IF4hLobgANMQ9mpLq6bK
         qa2g==
X-Forwarded-Encrypted: i=1; AJvYcCU7tU+4iVr6I9/4LHnPsU+drkHPpSAPgug4fm07wFfGYvyzv7A1BeaTaT12QjnllcaZCi0rbie7n/O3bdqGqD+xltW5EbtnHWIcWTrUgoMuVDrP
X-Gm-Message-State: AOJu0YznnmnVvnG9fKQ2+Lz/rcHHCo4wNSLi0l7zY9ERBbPPj+qBEeDQ
	SiRoeuqkG4JVgOb6uvMz8k7c/AWOOeCUxaZLMIySHlQ9EFLmL6qmhejMTfmrmcbCrOstXCaOJbf
	MS6jw4ntX65+1L0tY8EQN2y/5hieb/cDIY+P4
X-Google-Smtp-Source: AGHT+IE5Na0j/pWpWqmyvzu2Nq1znLyYvblamVutWAXAwm52wP8cG6MFjnGxm4bTZfdfKqaf4u1flVZLHd/Sr5pBzLI=
X-Received: by 2002:a05:600c:47cf:b0:414:908c:460d with SMTP id
 l15-20020a05600c47cf00b00414908c460dmr108625wmo.7.1711709027784; Fri, 29 Mar
 2024 03:43:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329034243.7929-1-kerneljasonxing@gmail.com>
 <20240329034243.7929-3-kerneljasonxing@gmail.com> <CANn89iK35sZ7yYLfRb+m475b7kg+LHw4nV9qHWP7aQtLvBoeMA@mail.gmail.com>
 <CAL+tcoBt0DxdSbb5PES8uYgeyBqThUyS_J4d3hUuxZv8=J0H9A@mail.gmail.com>
In-Reply-To: <CAL+tcoBt0DxdSbb5PES8uYgeyBqThUyS_J4d3hUuxZv8=J0H9A@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 29 Mar 2024 11:43:34 +0100
Message-ID: <CANn89iJ1c2efW94sxdsiCqir=twc+Yam2KCgcGK8-oNM26nifw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/3] trace: tcp: fully support trace_tcp_send_reset
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, rostedt@goodmis.org, 
	kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 11:23=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
>
> On Fri, Mar 29, 2024 at 5:07=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Fri, Mar 29, 2024 at 4:43=E2=80=AFAM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> > >
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > Prior to this patch, what we can see by enabling trace_tcp_send is
> > > only happening under two circumstances:
> > > 1) active rst mode
> > > 2) non-active rst mode and based on the full socket
> > >
> > > That means the inconsistency occurs if we use tcpdump and trace
> > > simultaneously to see how rst happens.
> > >
> > > It's necessary that we should take into other cases into consideratio=
ns,
> > > say:
> > > 1) time-wait socket
> > > 2) no socket
> > > ...
> > >
> > > By parsing the incoming skb and reversing its 4-tuple can
> > > we know the exact 'flow' which might not exist.
> > >
> > > Samples after applied this patch:
> > > 1. tcp_send_reset: skbaddr=3DXXX skaddr=3DXXX src=3Dip:port dest=3Dip=
:port
> > > state=3DTCP_ESTABLISHED
> > > 2. tcp_send_reset: skbaddr=3D000...000 skaddr=3DXXX src=3Dip:port des=
t=3Dip:port
> > > state=3DUNKNOWN
> > > Note:
> > > 1) UNKNOWN means we cannot extract the right information from skb.
> > > 2) skbaddr/skaddr could be 0
> > >
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > >  include/trace/events/tcp.h | 39 ++++++++++++++++++++++++++++++++++++=
--
> > >  net/ipv4/tcp_ipv4.c        |  4 ++--
> > >  net/ipv6/tcp_ipv6.c        |  3 ++-
> > >  3 files changed, 41 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
> > > index 194425f69642..289438c54227 100644
> > > --- a/include/trace/events/tcp.h
> > > +++ b/include/trace/events/tcp.h
> > > @@ -78,11 +78,46 @@ DEFINE_EVENT(tcp_event_sk_skb, tcp_retransmit_skb=
,
> > >   * skb of trace_tcp_send_reset is the skb that caused RST. In case o=
f
> > >   * active reset, skb should be NULL
> > >   */
> > > -DEFINE_EVENT(tcp_event_sk_skb, tcp_send_reset,
> > > +TRACE_EVENT(tcp_send_reset,
> > >
> > >         TP_PROTO(const struct sock *sk, const struct sk_buff *skb),
> > >
> > > -       TP_ARGS(sk, skb)
> > > +       TP_ARGS(sk, skb),
> > > +
> > > +       TP_STRUCT__entry(
> > > +               __field(const void *, skbaddr)
> > > +               __field(const void *, skaddr)
> > > +               __field(int, state)
> > > +               __array(__u8, saddr, sizeof(struct sockaddr_in6))
> > > +               __array(__u8, daddr, sizeof(struct sockaddr_in6))
> > > +       ),
> > > +
> > > +       TP_fast_assign(
> > > +               __entry->skbaddr =3D skb;
> > > +               __entry->skaddr =3D sk;
> > > +               /* Zero means unknown state. */
> > > +               __entry->state =3D sk ? sk->sk_state : 0;
> > > +
> > > +               memset(__entry->saddr, 0, sizeof(struct sockaddr_in6)=
);
> > > +               memset(__entry->daddr, 0, sizeof(struct sockaddr_in6)=
);
> > > +
> > > +               if (sk && sk_fullsock(sk)) {
> > > +                       const struct inet_sock *inet =3D inet_sk(sk);
> > > +
> > > +                       TP_STORE_ADDR_PORTS(__entry, inet, sk);
> > > +               } else {
> >
> > To be on the safe side, I would test if (skb) here.
> > We have one caller with skb =3D=3D NULL, we might have more in the futu=
re.
>
> Thanks for the review.
>
> How about changing '} else {' to '} else if (skb) {', then if we go
> into this else-if branch, we will print nothing, right? I'll test it
> in this case.

Right, the fields are cleared before this else

+               memset(__entry->saddr, 0, sizeof(struct sockaddr_in6));
+               memset(__entry->daddr, 0, sizeof(struct sockaddr_in6));

>
> >
> > > +                       /*
> > > +                        * We should reverse the 4-tuple of skb, so l=
ater
> > > +                        * it can print the right flow direction of r=
st.
> > > +                        */
> > > +                       TP_STORE_ADDR_PORTS_SKB(skb, entry->daddr, en=
try->saddr);
> > > +               }
> > > +       ),
> > > +
> > > +       TP_printk("skbaddr=3D%p skaddr=3D%p src=3D%pISpc dest=3D%pISp=
c state=3D%s",
> > > +                 __entry->skbaddr, __entry->skaddr,
> > > +                 __entry->saddr, __entry->daddr,
> > > +                 __entry->state ? show_tcp_state_name(__entry->state=
) : "UNKNOWN")
> > >  );
> > >
> > >  /*
> > > diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> > > index a22ee5838751..d5c4a969c066 100644
> > > --- a/net/ipv4/tcp_ipv4.c
> > > +++ b/net/ipv4/tcp_ipv4.c
> > > @@ -868,10 +868,10 @@ static void tcp_v4_send_reset(const struct sock=
 *sk, struct sk_buff *skb)
> > >          */
> > >         if (sk) {
> > >                 arg.bound_dev_if =3D sk->sk_bound_dev_if;
> > > -               if (sk_fullsock(sk))
> > > -                       trace_tcp_send_reset(sk, skb);
> > >         }
> >
> > Remove the { } ?
>
> Yes, I forgot to remove them.

No problem.
