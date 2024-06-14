Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C3A184123
	for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Jun 2024 19:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718394049; cv=none; b=IEG0+dBaFhmXy5JYtvm2Mwq0lHQw4EeWmuRUmwQXwgx6rqjHnkp02kfHhcvHdn29nciJHrQCbdKjR3OxY1KyuIrhhLaW3vmB1vq5Code2hc/miOfx+PtyDffqPF87e/Y++h5YnmvrnS/3CX8xSe1A3gM3DoGRDELFXVZozOxlc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718394049; c=relaxed/simple;
	bh=VqNw2ns7aqtWqDR0d5abv9h9DSXkqkFbhkx4mdQOkI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JtmFPDjjahLhXoUdFh8MDW+lcUUCMXJDiOoR0kT8lYbmJ5SFTQYQoZUMFBw15JjBeimbSiygwpXwROdhx5Y3LrKGBSgnWa5uhxh1L7FOQfHnoXDJuN7ojE783qOUqAgoQmKm0MuEU/sf1YxV88SaAHBWTqSViMy6c3mQ6rm5zfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=GdPLF6ZB; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="GdPLF6ZB"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57c83100bd6so3199048a12.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Jun 2024 12:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718394045; x=1718998845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wbc4GSgCSERDLxOuFdZrA/q/zxBmzXnyTxqibt9VdMs=;
        b=GdPLF6ZBrIuMGKusGj1cDSHwE4PMQconZgUcSvXqO09whx4gb+M8m5jeX5h9XUP+ZF
         q6Qt+a3u2Tp2e72LJRVCgaohhYV5KoVxipn8NB3nFyur8C8dfhIhoPf38mSuT1q7uawt
         mGvGEyvLL4wd5wUBosXWdkA+DM3+2WndiXAh61t+VAzUVq7U2b0Wj/ngCKqVwAxqWWnA
         c3Gd7Gy+zr4w5Eu698f5tCIrL1vb0Pl7Wjc7gNUQcIQgS4hdhGPJozAVJnwFydIcR95f
         R7ssTsmygMFi2/iuRJXkXKsq+QSCNPZTEZY/t+GvWyyt1oNqFXdF2TfNY27vSOlMATPp
         EFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718394045; x=1718998845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wbc4GSgCSERDLxOuFdZrA/q/zxBmzXnyTxqibt9VdMs=;
        b=L06Khpl0xv3ZaxVaN7Elw6dNK2GjAK8JyQwnjQgFkZDviv8CvRbK5Y9pqeXA15xy6w
         lPj68942iqOF9HtzKyyD/lkMb2v8ENnrWlu/etWJsf3kaG1uIxVnooGOtrZ8HP9JboF5
         sh5x8lgGX4bhtMhnRlVWB+nIq6ti+NL8BAH+e/P2tbslWCI0uXpD8FDRlrTz2vuvquJj
         hAtiuXI6E8rsw6crBb9SuQvl0CtRoNWPiSft74813+UuK+DiY6aabgzFpduVa/zUCw5j
         pgXIYMYHSZgxt6BWvD7NSX2Dm+HTj9CGDVbLBlTMi0GBdYYdvpuEz9+aCKTciHw35Ca/
         X8Uw==
X-Forwarded-Encrypted: i=1; AJvYcCXzHBk2gGEV6k/okcsGbEiWNdl06ayN5eMYw1a4CcwZOTtcNPPspLqhqpuCnPVwiYzQX3Vu4HC+QgovxkcR3kClNbAOuhExvTNuDQ1iPOl5xhsg
X-Gm-Message-State: AOJu0YyDIAl2pzxc2DBbzehvuR9sPvzcQ9JUKaD1Ufq5EP7uRYcoAKOZ
	0j6NPknuFSbqsVneridcKg/Pg/JYcdd76/5J1ho1lqlanMIYFcwDl04r6IBrg0N7H3lFg7RPbYo
	guWOnVblNsF5EVxEj3f6MQklgAG6O+OUNoZFjEg==
X-Google-Smtp-Source: AGHT+IEH8WEKx3xQbq1+oKvg4iOkF+AGoOi+MlB17Wrarh1LPwitVZ/727ewHKaMbj47weG8aVpunbjT5+1+Srui+5I=
X-Received: by 2002:a50:8747:0:b0:57c:563b:f37f with SMTP id
 4fb4d7f45d1cf-57cbd67dbedmr2527046a12.19.1718394045408; Fri, 14 Jun 2024
 12:40:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718136376.git.yan@cloudflare.com> <dcfa5db9be2d29b68fe7c87b3f017e98e5ec83b4.1718136376.git.yan@cloudflare.com>
 <fed7b2ca-5180-417f-a676-fb126157dff3@kernel.org> <86109f6c4a8303950ac13811a3f8506ff44a6cfc.camel@redhat.com>
In-Reply-To: <86109f6c4a8303950ac13811a3f8506ff44a6cfc.camel@redhat.com>
From: Yan Zhai <yan@cloudflare.com>
Date: Fri, 14 Jun 2024 14:40:34 -0500
Message-ID: <CAO3-PboH9aNSC7RaJdkouFoa5L2Eoqi7OjLuAay9EGABr1fEBQ@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 1/7] net: add rx_sk to trace_kfree_skb
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Abhishek Chauhan <quic_abchauha@quicinc.com>, Mina Almasry <almasrymina@google.com>, 
	Florian Westphal <fw@strlen.de>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	David Howells <dhowells@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Daniel Borkmann <daniel@iogearbox.net>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Pavel Begunkov <asml.silence@gmail.com>, 
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Neil Horman <nhorman@tuxdriver.com>, 
	linux-trace-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 5:15=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Wed, 2024-06-12 at 09:59 +0200, Jesper Dangaard Brouer wrote:
> >
> > On 11/06/2024 22.11, Yan Zhai wrote:
> > > skb does not include enough information to find out receiving
> > > sockets/services and netns/containers on packet drops. In theory
> > > skb->dev tells about netns, but it can get cleared/reused, e.g. by TC=
P
> > > stack for OOO packet lookup. Similarly, skb->sk often identifies a lo=
cal
> > > sender, and tells nothing about a receiver.
> > >
> > > Allow passing an extra receiving socket to the tracepoint to improve
> > > the visibility on receiving drops.
> > >
> > > Signed-off-by: Yan Zhai<yan@cloudflare.com>
> > > ---
> > > v3->v4: adjusted the TP_STRUCT field order to be consistent
> > > v2->v3: fixed drop_monitor function prototype
> > > ---
> > >   include/trace/events/skb.h | 11 +++++++----
> > >   net/core/dev.c             |  2 +-
> > >   net/core/drop_monitor.c    |  9 ++++++---
> > >   net/core/skbuff.c          |  2 +-
> > >   4 files changed, 15 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/include/trace/events/skb.h b/include/trace/events/skb.h
> > > index 07e0715628ec..3e9ea1cca6f2 100644
> > > --- a/include/trace/events/skb.h
> > > +++ b/include/trace/events/skb.h
> > > @@ -24,13 +24,14 @@ DEFINE_DROP_REASON(FN, FN)
> > >   TRACE_EVENT(kfree_skb,
> > >
> > >     TP_PROTO(struct sk_buff *skb, void *location,
> > > -            enum skb_drop_reason reason),
> > > +            enum skb_drop_reason reason, struct sock *rx_sk),
> > >
> > > -   TP_ARGS(skb, location, reason),
> > > +   TP_ARGS(skb, location, reason, rx_sk),
> > >
> > >     TP_STRUCT__entry(
> > >             __field(void *,         skbaddr)
> > >             __field(void *,         location)
> > > +           __field(void *,         rx_skaddr)
> >
> > Is there any reason for appending the "addr" part to "rx_sk" ?
> > It makes it harder to read this is the sk (socket).
> >
> > AFAICR the skbaddr naming is a legacy thing.
>
> I'm double-minded about the above: I can see your point, but on the
> flip side the 'addr' suffix is consistently used in net-related
> tracepoints.
> >
> > >             __field(unsigned short, protocol)
> > >             __field(enum skb_drop_reason,   reason)
> > >     ),
> > > @@ -38,12 +39,14 @@ TRACE_EVENT(kfree_skb,
> > >     TP_fast_assign(
> > >             __entry->skbaddr =3D skb;
> > >             __entry->location =3D location;
> > > +           __entry->rx_skaddr =3D rx_sk;
> > >             __entry->protocol =3D ntohs(skb->protocol);
> > >             __entry->reason =3D reason;
> > >     ),
> > >
> > > -   TP_printk("skbaddr=3D%p protocol=3D%u location=3D%pS reason: %s",
> > > -             __entry->skbaddr, __entry->protocol, __entry->location,
> > > +   TP_printk("skbaddr=3D%p rx_skaddr=3D%p protocol=3D%u location=3D%=
pS reason: %s",
> >                                ^^^^^^^^^
> > I find it hard to visually tell skbaddr and rx_skaddr apart.
> > And especially noticing the "skb" vs "sk" part of the string.
>
> I agree 'rx_skaddr' is sub-optimal. Either be consistent with all the
> other net tracepoints and use 'skaddr' (which will very likely will
> increase Jesper concerns, but I personally have no problem with such
> format) or prefer readability with something alike 'rx_sk' or (even
> better) 'sk'.
>

Jesper explained to me in a private message that "addr" makes more
sense when there was no BPF, since likely nothing would dereference
the pointer anymore at that time, so it's purely an address. But it is
no longer the case now. Also, in later patches of this change, I am
already breaking the "convention" by replacing kfree_skb with
sk_skb_reason_drop, so how about breaking it once more, and just
calling it "rx_sk". I want to keep the "rx_" to emphasize this is a
receiving socket. Let me send an amended version early next week and
see if more thoughts come.

thanks
Yan


> Thanks,
>
> Paolo
>
