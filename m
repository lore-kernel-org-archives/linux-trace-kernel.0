Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88E11C729E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 23 Oct 2024 15:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729698241; cv=none; b=aZzwSxq3e9dra+swMEdUGR8JCFSbyXOjdFlmKib5pGCqcvb6G5x1ZVTTMRUDMQJW9CL2yK3G+4vYhz5RHnU8sTBCE0+X9y7uPwrv8/66BYLAp0bVSC/bxw0ii7yAL0VrJZHcAKZi4qyKaPKg2/HkCrbfxwKUFK8zN8K3C2bS6L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729698241; c=relaxed/simple;
	bh=cAhpK/HFRxGEanpmd8iWggUPbJ2iTk1xXXcpqebxzDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SGASqsjj+Fnvkev8F3Lqg8lCyfMtDwtk6dQvwpeNNg2L6pNGV+9XqbJBcTYNnqJPewGJl8C4bizA0eZNuYYJ4r/u+sGCcKF5oVXTK/vPSUI6quWIf+5Q1VVRRemSAeIwfZB+gaZN0U+PAQ4Q4whuiAK7m2kvo/e3S7ApyKbCb0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aQIaupnD; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aQIaupnD"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9a26a5d6bfso997883466b.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 23 Oct 2024 08:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729698238; x=1730303038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3s7LjhGl73YQtjqKgJgAjpr52I9yJyBdtqxTuAhEhk=;
        b=aQIaupnDccex2YaN5shwCrTvoBDFsKjlR+odLMEO99TrYl9layaf0/AP6n4Gpozg82
         /M83pfPcpCqPN00cDTgolvWZHCIxsqQKCrB2qi+GGL+t8OdOmTbnSNU83QYZRfAxD8gj
         kN6/JCo5IyNZa9s6eX0vY12AEFwodPchtr7i2HE8MxS0I6Yk6FXJrdPsUKInfvSnr2HA
         +S31ZBLZfvlnCKkrly8YKPEC4nPkxbfH29hYZ0oILseMxismWtb6A3ERmW8ewSvx4Skq
         GbNkmSL7k//rGinE1h8xy6Kf3wAvof+Z5Q5Gq6toI0qYvXuLG/pZyiViNEJWNfB0RXM/
         ZEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729698238; x=1730303038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t3s7LjhGl73YQtjqKgJgAjpr52I9yJyBdtqxTuAhEhk=;
        b=NjbKFl4itgzYAQV275EszewOxKlW63m2GlQqXL995s6fr4ebI3/BE24DZvWHl/NXvR
         azKQ9fFWc9usDtOK0dlyHZOcfgt82xJCO5arNxHULHOC4k9mj/s2+xtCCR9Y6KRcyEfw
         pXUKnpNvkdQMsX7EJfTAgaqOMFNlgao8Q7HsbhALlKbnrKIVo0GodyRF6j5KMTCTo4Tx
         kHIQIYyq1V/yk3VA/khwfjTCt/XP6pGOF+fyjEySyJSdjhkrDEyPj6lL+pGZyfUG9Y6c
         k1KUzyHrhoY1M6FW/RRpah+wFnqG40Ds9GUDLwoOlIXVe1/He1gbv1nPz6XhNmBln2OE
         +DPw==
X-Forwarded-Encrypted: i=1; AJvYcCV0Exp5EoyvCEfpwcL3an2y56zDp63/0hIUZ92qmF0w9trDq+DZukXcWoa5ueSl5uucPhl1XKVZN9Qy06Oz1QXbH00=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqpVZXax8JsTBoRrpSD+twbJuSd16egjD+djpsH0CcJLgFjCW0
	B20PlgyEInF/bSFVHCnpjc2GcOydd9HUsdDAvi8SsHg4GH2nUcB7t01amd2/JQoZ5yEK7sWeg+F
	O+ckAIM/W2rRFVc6Qb0LRV/aqZQkRm+4NxSn3
X-Google-Smtp-Source: AGHT+IEI73on+YmI5i8va0ruNeXUfN8zkXChj+ZLLov1S0Avkmt8sCj9P0G/22P1NuIZQKhA3CKYukT/qKyIJ8+rLjA=
X-Received: by 2002:a17:907:869f:b0:a9a:4158:494a with SMTP id
 a640c23a62f3a-a9abf94d4a6mr254932966b.41.1729698237790; Wed, 23 Oct 2024
 08:43:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023123212.15908-1-laoar.shao@gmail.com> <CANn89iJuShCmidCi_ZkYABtmscwbVjhuDta1MS5LxV_4H9tKOA@mail.gmail.com>
 <CALOAHbDk48363Bs3OyXVw-PpTLc08-+MEo4bq9kXq1EWtyh24g@mail.gmail.com>
In-Reply-To: <CALOAHbDk48363Bs3OyXVw-PpTLc08-+MEo4bq9kXq1EWtyh24g@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 23 Oct 2024 17:43:46 +0200
Message-ID: <CANn89iKvr44ipuRYFaPTpzwz=B_+pgA94jsggQ946mjwreV6Aw@mail.gmail.com>
Subject: Re: [PATCH] net: Add tcp_drop_reason tracepoint
To: Yafang Shao <laoar.shao@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, netdev@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Menglong Dong <menglong8.dong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 4:35=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Wed, Oct 23, 2024 at 9:01=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Wed, Oct 23, 2024 at 2:33=E2=80=AFPM Yafang Shao <laoar.shao@gmail.c=
om> wrote:
> > >
> > > We previously hooked the tcp_drop_reason() function using BPF to moni=
tor
> > > TCP drop reasons. However, after upgrading our compiler from GCC 9 to=
 GCC
> > > 11, tcp_drop_reason() is now inlined, preventing us from hooking into=
 it.
> > > To address this, it would be beneficial to introduce a dedicated trac=
epoint
> > > for monitoring.
> >
> > This patch would require changes in user space tracers.
> > I am surprised no one came up with a noinline variant.
> >
> > __bpf_kfunc is using
> >
> > #define __bpf_kfunc __used __retain noinline
> >
> > I would rather not have include/trace/events/tcp.h becoming the
> > biggest file in TCP stack...
>
> I=E2=80=99d prefer not to introduce a new tracepoint if we can easily hoo=
k it
> with BPF. Does the following change look good to you?
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 092456b8f8af..ebea844cc974 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -4720,7 +4720,7 @@ static bool tcp_ooo_try_coalesce(struct sock *sk,
>         return res;
>  }
>
> -static void tcp_drop_reason(struct sock *sk, struct sk_buff *skb,
> +noinline static void tcp_drop_reason(struct sock *sk, struct sk_buff *sk=
b,
>                             enum skb_drop_reason reason)
>  {
>         sk_drops_add(sk, skb);
>

I would suggest adding an explicit keyword, like the one we have for
noinline_for_stack, for documentation purposes.

noinline_for_tracing perhaps ?

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.=
h
index 1a957ea2f4fe78ed12d7f6a65e5759d07cea4449..9a687ca4bb4392583d150349ee1=
1015bcb82ec74
100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -265,6 +265,12 @@ struct ftrace_likely_data {
  */
 #define noinline_for_stack noinline

+/*
+ * Use noinline_for_tracing for functions that should not be inlined,
+ * for tracing reasons.
+ */
+#define noinline_for_tracing noinline
+
 /*
  * Sanitizer helper attributes: Because using __always_inline and
  * __no_sanitize_* conflict, provide helper attributes that will either ex=
pand
