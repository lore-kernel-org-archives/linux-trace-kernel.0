Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DB31FCFE2
	for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Feb 2025 19:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740424997; cv=none; b=QUzxeia992z5igunwmYlO6jvESFImrlBpEVv+y7HlcR4AdK9SluaAFnV/w9g68pZA+c2wPmMx8rOUk3sR+gzN1BvX2QbvdfpJ7SSMyon1espUbHUoAxekuYZ1mqSfLGVJ9D4cyDRmxiWhsK9+qNSgrvPv2tJdrOVs7klNlopMA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740424997; c=relaxed/simple;
	bh=MuxBrNIX06+MBlaJPoUCPaS8vE9mO1mdJznRkFGE6ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j4uMwsVdaTX9JdAWcGoacBrY8dVYnv8jTtMKTOlkL+zHoGPpIhFT2E9fqtoZFB9CL4bXQGpEoizKXUo4Ikj9TQgg/tIW218/d15QQ8XLd9Pxzb/+70a+IQJ1sUNTpBhJsbEJNalhqKBfmofAr0qJaTTNweD/qqoKb0WkqZu0gLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tHgcLj00; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tHgcLj00"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5ded368fcd9so6823530a12.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Feb 2025 11:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740424993; x=1741029793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4G9JOwMMqctfXuBGODgzmfMVslmCh5Emd9i+EC8Wh/o=;
        b=tHgcLj00AAnkKI8aQt7gSbFjqqkq0FGg7X/srfkxhdwKmExjXzgED7als5mQMK6irq
         W0RCnO0SBUxfdvsUac1heVRRDwYxKYGsVpkgNFjJm2gJAk4j0JtMQnm8hV8nykP2TPJJ
         +mPCkbU+1rWl74XxVSH2JVuqjDE9XRuRpwzayRRn5lCH6sIFgrrYLbrunru4qAHumRbK
         8y2UF10CGMThGr8jOZEY1RIN2OSxTBKiXs6lLG/l1XujrekTrJ7El8D8cnHKGhYA4vfP
         dPDNFH6Tib3yLXQdsymufPstsZN4t9kd3zufgz8SgKtDeoBwz/xEjaGuxk7k0jcdYg6w
         /WsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740424993; x=1741029793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4G9JOwMMqctfXuBGODgzmfMVslmCh5Emd9i+EC8Wh/o=;
        b=PbSoMEJZkHujOLyqQ/o2oBRxoOWmMdJlgpQTX+TY2xrZ1d2tCYfO/8sWtHFs0KyUPx
         IeYsctaQ8P5xC4jZ3Yqobzp1p2iCqpmaFC94/R4WbXWL3o5dYHcfG1WPTW2J6kux4fgk
         hXhjPwmIEaS3rM/ODQx3NTf+xwOMzUl7ETl0j7ViztC30CPi1qHMLk7P6jUonv3sRIbE
         JaOvMc8etbwvv+TLlUAYgaDauTMyWByK7xOTIe5RZpwCELxJ1TvfFmUH4mjrvLBGVJST
         csY4yBwdZgKmepgKCXHzd85AsSpCeuYRHQJg4PHcSG1hQWzh+Db271FeL1IDqYp0b2wz
         GrYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVd2MjOoQBT/owGxEKBYNFFO134QwS//+Hb0GSOrGNWvfY8F64OO0zHiXKTQtYn43C/S0+tx9kzfacfwr9hhnqRgQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaV4Hk0L4aFjQkz9LG+C5JnNS+KPkoCkOoLTkCRBSor0YBPGxh
	yKOieNabX5N1TndiOxU99mtSVuE0oIkXZC1LvFtauET6xuLj0sCevo+887DIIozzlZ/KGciPaRb
	IL8l78uXo02ChYvU6r8tscFc9t1gWuDf/6ETl
X-Gm-Gg: ASbGncsEWF3pAeGM27LDD0mWddbswnTNFvM1Fzj9Lprab7D6+buWO1UAj7DTCFsJLjN
	YYDi0zwobvVP3Gw/3xYYJsQlnwe06HYBEPAxL/GznlGkfMH6ETxGYdpdYEWJG74wXl2PhVHBpkl
	9Hyd59Gg==
X-Google-Smtp-Source: AGHT+IGfiIchpM9eOMnXtJ/WcKCVUkgDFUa2p/xrMF61h/aNYjj6Fhs5Fbn5eztpvP2RHcdoRWctJt81jVevyjeHkjo=
X-Received: by 2002:a05:6402:238f:b0:5e0:348a:e33c with SMTP id
 4fb4d7f45d1cf-5e0b70d674amr10053613a12.10.1740424992694; Mon, 24 Feb 2025
 11:23:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224-tcpsendmsg-v1-1-bac043c59cc8@debian.org>
 <CANn89iLybqJ22LVy00KUOVscRr8GQ88AcJ3Oy9MjBUgN=or0jA@mail.gmail.com> <SA3PR15MB5630CFBB36C212008DA8ACC7CAC02@SA3PR15MB5630.namprd15.prod.outlook.com>
In-Reply-To: <SA3PR15MB5630CFBB36C212008DA8ACC7CAC02@SA3PR15MB5630.namprd15.prod.outlook.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 24 Feb 2025 20:23:00 +0100
X-Gm-Features: AWEUYZnUmpoUUWnKefqPzOGV3a3YKaKSZHqzoRXrvSuNNgfx9ij51R1mq4ffPRc
Message-ID: <CANn89i+zxMje+wbQzLKbSq_WKYnwGdMyAdStMm4GqkdJCvWPOg@mail.gmail.com>
Subject: Re: [PATCH net-next] trace: tcp: Add tracepoint for tcp_sendmsg()
To: Yonghong Song <yhs@meta.com>
Cc: Breno Leitao <leitao@debian.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	"kuba@kernel.org" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>, Kernel Team <kernel-team@meta.com>, 
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 8:13=E2=80=AFPM Yonghong Song <yhs@meta.com> wrote:
>
> > ________________________________________
> >
> > On Mon, Feb 24, 2025 at 7:24=E2=80=AFPM Breno Leitao <leitao@debian.org=
> wrote:
> >>
> >> Add a lightweight tracepoint to monitor TCP sendmsg operations, enabli=
ng
> >> the tracing of TCP messages being sent.
> >>
> >> Meta has been using BPF programs to monitor this function for years,
> >> indicating significant interest in observing this important
> >> functionality. Adding a proper tracepoint provides a stable API for al=
l
> >> users who need visibility into TCP message transmission.
> >>
> >> The implementation uses DECLARE_TRACE instead of TRACE_EVENT to avoid
> >> creating unnecessary trace event infrastructure and tracefs exports,
> >> keeping the implementation minimal while stabilizing the API.
> >>
> >> Given that this patch creates a rawtracepoint, you could hook into it
> >> using regular tooling, like bpftrace, using regular rawtracepoint
> >> infrastructure, such as:
> >>
> >>         rawtracepoint:tcp_sendmsg_tp {
> >>                 ....
> >>         }
> >
> > I would expect tcp_sendmsg() being stable enough ?
> >
> > kprobe:tcp_sendmsg {
> > }
>
> In LTO mode, tcp_sendmsg could be inlined cross files. For example,
>
>   net/ipv4/tcp.c:
>        int tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
>   net/ipv4/tcp_bpf.c:
>        ...
>       return tcp_sendmsg(sk, msg, size);
>   net/ipv6/af_inet6.c:
>        ...
>        return INDIRECT_CALL_2(prot->sendmsg, tcp_sendmsg, udpv6_sendmsg, =
...)
>
> And this does happen in our production environment.

And we do not have a way to make the kprobe work even if LTO decided
to inline a function ?

This seems like a tracing or LTO issue, this could be addressed there
in a generic way
and avoid many other patches to work around this.
