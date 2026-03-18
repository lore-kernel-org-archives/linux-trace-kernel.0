Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609233D9DC8
	for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Mar 2026 14:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773843216; cv=pass; b=k0LgO8DAb6MqJWzKDey5Mrrj7SyUlkoxkwG1qSx6/P0werYBy95+r7Jq4SexFj3j7XDIssr5BKaw/WeqSIS35HpE4YwlNiCqka4m5uFTfV/0hynqyQVFWtqhydlwuuU1ZMWpGdLDlw+m3v5hXKsc/mJ1gKT6HB8ce15GYzbxtT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773843216; c=relaxed/simple;
	bh=z/89pA0UO58ZBkQTFOgdhyZuqhcSfbmElffwmdziG+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ekv9PKlc4ghd/pMGmGWPRrCyj9bi4FXZzYkVdZCkCqRQr8rMmJDUfATrGeKkvxmXYQD/YaRspw1NV+IdlZ/2AczVl3nwMPrMbOxoAHAO5DLDcG++8Sh03m7Jqmg0f0+IALMKG/xkYHRWQwitDvotV7TY4g9VnxSTd/CK5A7tgTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=iLv8Kcr6; arc=pass smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="iLv8Kcr6"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-89c6a711ce9so20790126d6.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Mar 2026 07:13:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773843213; cv=none;
        d=google.com; s=arc-20240605;
        b=NE9RJpGU4wI4jrVmKNDz19Wt/Pvbw1GZcGaY9PzQM3svnnMSohc9S7bLNsw8YmwC6Z
         F9tGZ7OJcGq8DDXTnhgxWFqxATTFg2Z/hiPrkcHNNd1iqLKZ7Qww2Q5ieCf2z1HMNxNM
         gh9xODoyVL8Wo+dlQOycvonW+YGwLYr6Y2JdKaW9P8Mvj5WlizMiXErLg8bXVGuZO8No
         lFaNjOm+5k+U08d0Eurq9BYYMb98Ysihn0pCyBRp7306kBoIyKKBy32zbYsVV6ZmbSAn
         dadDswbDbEch0AQuYwcJtkmozcTNcdQof263S8cNLmv2caqyZ79zSlDN7NVafgwwpzaz
         8bPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=doH9jKyIV2pcWr9QqHgYapLUvNmJgzZV6s5pft4p5hM=;
        fh=wIJ7KbX3Lct4D8sIIch3Gjbvt2HzpuFqKPFXM+4abeQ=;
        b=KFXlfV/5gOJozHte9fSKZN2N1wiyteBYyF8hvCU1Mdj+FWWnttBDg65sLNG2gRV80L
         1muZSmDwv9zMRORFvwz7CWJJ38AC2GhjZ3oY7rCE3UiZbOG1+buyLpOyIIjTF4sErN7l
         82KS3NGOAjJJjgRnX0HFbkptUt2B4TuBl8q4OT6jGaKPI419XDQ3AifQzcGTU5cEc1RC
         SxonIVokt1Atk9WWKP9KAu+YnlHTw6mZT5jAtwEeWYW41rOKpGduqk1UKPhmFOweqVR0
         YX4gsE8JlrsUQ/pxJCPYJ2I1t3x1eEB0KssAv0qNjZGDXZ5Diw1SOvvN+AFcV1MZ6qx9
         gdNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1773843213; x=1774448013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=doH9jKyIV2pcWr9QqHgYapLUvNmJgzZV6s5pft4p5hM=;
        b=iLv8Kcr6ga2PE/qEE7gatlTbBuKuabs1y16ZU02HWWuD2F8/SlRbYD+MiJWlt2c2k2
         dduToabSVGSFcR3YzXAZivojolCfyFq8mmgx+i8+nMzfCVMkvmzgOhaHyHJ+GW5PKCux
         y4LrDFzCZ9GUaBfw7b/v/VPzts3OrrzNDJm5Orsva+cV3IuaLj8awNAPzB3LEy1AStu7
         M3P6XzAaHLQ1uullDaiNWw/xpwfx7tRGkwpdMmNeujw02McXPZfPeKTvafM8x9Ig1crv
         CyUXQV1PUOOqeUP+J6++WbBD6wJO0ngS50NoDJCoCVThx5tVRIS65X5U7WMQ0ChpvW8n
         TqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773843213; x=1774448013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=doH9jKyIV2pcWr9QqHgYapLUvNmJgzZV6s5pft4p5hM=;
        b=bqPHwudLR8xdiECqaiPEX/D72KIthrtq/VqN6L1fn/XL+Yf8y5ywMKT+ScRW0J2GVS
         J9VpPAD5P52LJtVdDoMgr0BUdWBYMaAm9dqPSTFHyyXL24BWy6FeTENHZK5cdamIhmHm
         SEnvIFUOU19G81LzbVBNeQvmF8RVgzQZCZryomgavrWbyVFwF+QsXGKMZ2n2AfojSfgp
         8883ul4LiNalqw7xXMe10tk66spVEH3Noxr1xJoq5+opL/sM2wdIIFpjzuDUL3tD8dMC
         f9zIYmpUrOicFqwu+ca2gliyFboMJR5WIcTckEwN7NnV5KXv60ugHWiSoekOLVlRtc1/
         F0Sg==
X-Forwarded-Encrypted: i=1; AJvYcCV/SpZvdrV2XHpeivuQAmF/oSFRHpRE55lYF5wa33TtWbX3vDJqphj69t3fc2vsN0hnuxmGiozvx0eudJIOFuBVP6E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy4fsFdZNzlk3qkAoIFPZ4VDd7NR8o9CEIJOsV/Qz4TG30Ce2x
	/V2eikbdIq3avmTuqhKf6xwNcFaGka5S2yOw/K/OUB6X32wRZLqnItHuPFfR297hlR0+9MD8GcN
	eKu6jYHB7ywcFkwtNeKlcM8Xd4/fKnUoVudR0WiQLBQ==
X-Gm-Gg: ATEYQzwydqfQp5KHXPWAaIJLKCnc7CWZFJcSj41NymAH0hNEaTv3VEhHS7FZSLXevSy
	GrRIiYorYMqevMwCxnF5+GgCfgpTTyib5AnZR7y6mbgY2Lk/gZHBvv6+QTvgxlXEaCbQoeiOgIl
	B0rye46v1QOGRe7pf/lhMhmqoL6YId0VTGHFJE1oOTLPdlNgsoPb2/Xh+HPMLxBsVPTDjo5FU4I
	DeaDoCrIjDpZbtM45zdxqo9BLuT12tgJ5cYGskvSarxT3oqwjDB4rNlOqahnKGV4WcmcSI+dtP6
	6ykBxwo=
X-Received: by 2002:a05:6214:2466:b0:89c:4cb3:4ea1 with SMTP id
 6a1803df08f44-89c6b50cda1mr53811646d6.20.1773843213183; Wed, 18 Mar 2026
 07:13:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
 <20260312150523.2054552-5-vineeth@bitbyteword.org> <f7to6ktnjxi.fsf@redhat.com>
 <CAO7JXPhfpUb1VM_=mwSUqHPQrLvBW=wurz_apWQkMXssPAQPJA@mail.gmail.com>
In-Reply-To: <CAO7JXPhfpUb1VM_=mwSUqHPQrLvBW=wurz_apWQkMXssPAQPJA@mail.gmail.com>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Wed, 18 Mar 2026 10:13:22 -0400
X-Gm-Features: AaiRm51A0epLogiUfwoUvX3H17X7FM-N_YItWsuNQqgGdOd0yFIoTXs_t_Yz52g
Message-ID: <CAO7JXPgiM12_KcM+-Kxw2A9yC7-G1wwXCmbyVqpAcckojfRrTw@mail.gmail.com>
Subject: Re: [PATCH 04/15] net: Use trace_invoke_##name() at guarded
 tracepoint call sites
To: Aaron Conole <aconole@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eelco Chaudron <echaudro@redhat.com>, 
	Ilya Maximets <i.maximets@ovn.org>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Xin Long <lucien.xin@gmail.com>, Jon Maloy <jmaloy@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, dev@openvswitch.org, linux-sctp@vger.kernel.org, 
	tipc-discussion@lists.sourceforge.net, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 9:40=E2=80=AFAM Vineeth Remanan Pillai
<vineeth@bitbyteword.org> wrote:
>
> On Thu, Mar 12, 2026 at 11:31=E2=80=AFAM Aaron Conole <aconole@redhat.com=
> wrote:
> >
> > "Vineeth Pillai (Google)" <vineeth@bitbyteword.org> writes:
> >
> > > Replace trace_foo() with the new trace_invoke_foo() at sites already
> > > guarded by trace_foo_enabled(), avoiding a redundant
> > > static_branch_unlikely() re-evaluation inside the tracepoint.
> > > trace_invoke_foo() calls the tracepoint callbacks directly without
> > > utilizing the static branch again.
> > >
> > > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > > Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> > > Assisted-by: Claude:claude-sonnet-4-6
> > > ---
> > >  net/core/dev.c             | 2 +-
> > >  net/core/xdp.c             | 2 +-
> > >  net/openvswitch/actions.c  | 2 +-
> > >  net/openvswitch/datapath.c | 2 +-
> > >  net/sctp/outqueue.c        | 2 +-
> > >  net/tipc/node.c            | 2 +-
> > >  6 files changed, 6 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > index 14a83f2035b93..a48fae2bbf57e 100644
> > > --- a/net/core/dev.c
> > > +++ b/net/core/dev.c
> > > @@ -6444,7 +6444,7 @@ void netif_receive_skb_list(struct list_head *h=
ead)
> > >               return;
> > >       if (trace_netif_receive_skb_list_entry_enabled()) {
> > >               list_for_each_entry(skb, head, list)
> > > -                     trace_netif_receive_skb_list_entry(skb);
> > > +                     trace_invoke_netif_receive_skb_list_entry(skb);
> > >       }
> > >       netif_receive_skb_list_internal(head);
> > >       trace_netif_receive_skb_list_exit(0);
> > > diff --git a/net/core/xdp.c b/net/core/xdp.c
> > > index 9890a30584ba7..53acc887c3434 100644
> > > --- a/net/core/xdp.c
> > > +++ b/net/core/xdp.c
> > > @@ -362,7 +362,7 @@ int xdp_rxq_info_reg_mem_model(struct xdp_rxq_inf=
o *xdp_rxq,
> > >               xsk_pool_set_rxq_info(allocator, xdp_rxq);
> > >
> > >       if (trace_mem_connect_enabled() && xdp_alloc)
> > > -             trace_mem_connect(xdp_alloc, xdp_rxq);
> > > +             trace_invoke_mem_connect(xdp_alloc, xdp_rxq);
> > >       return 0;
> > >  }
> > >
> > > diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
> > > index 792ca44a461da..420eb19322e85 100644
> > > --- a/net/openvswitch/actions.c
> > > +++ b/net/openvswitch/actions.c
> > > @@ -1259,7 +1259,7 @@ static int do_execute_actions(struct datapath *=
dp, struct sk_buff *skb,
> > >               int err =3D 0;
> > >
> > >               if (trace_ovs_do_execute_action_enabled())
> > > -                     trace_ovs_do_execute_action(dp, skb, key, a, re=
m);
> > > +                     trace_invoke_ovs_do_execute_action(dp, skb, key=
, a, rem);
> >
> > Maybe we should just remove the guard here instead of calling the
> > invoke.  That seems better to me.  It wouldn't need to belong to this
> > series.
> >
> > >               /* Actions that rightfully have to consume the skb shou=
ld do it
> > >                * and return directly.
> > > diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
> > > index e209099218b41..02451629e888e 100644
> > > --- a/net/openvswitch/datapath.c
> > > +++ b/net/openvswitch/datapath.c
> > > @@ -335,7 +335,7 @@ int ovs_dp_upcall(struct datapath *dp, struct sk_=
buff *skb,
> > >       int err;
> > >
> > >       if (trace_ovs_dp_upcall_enabled())
> > > -             trace_ovs_dp_upcall(dp, skb, key, upcall_info);
> > > +             trace_invoke_ovs_dp_upcall(dp, skb, key, upcall_info);
> >
> > Same as above.  Seems OVS tracepoints are the only ones that include
> > the guard without any real reason.
> >
>
> Makes sense. Its simple enough that I think I will include it as a
> separate patch in v2 and remove these changes from this patch. Thanks
> for pointing it out.
>
On a second look, I'm not sure if this was for performance reasons.
The discussion in the io_uring patch in this series points out that
the check made there was deliberate and for performance reasons to
avoid 6 mov instruction in the hot path. Just wanted to double check
if that was the case here, before I remove the check?

Thanks,
Vineeth
