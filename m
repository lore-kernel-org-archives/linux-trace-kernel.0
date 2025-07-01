Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951BE275103
	for <linux-trace-kernel@vger.kernel.org>; Tue,  1 Jul 2025 16:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751387871; cv=none; b=abowXG0JzFtbhp4ZOABaJzw+BsxUDsubrnNHW4QzpE+ntuuP0Q789eLeT7B7q+Qk8EdVSL+epy3dMRbJlFGeVl8nokaaj+/awJnxx3QFbDMu6AGp7ddtSCiT2Np3o5G8g8pfk3ipVspNXK/SgQCjgyLzBO9l3tSVk6rasW19M1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751387871; c=relaxed/simple;
	bh=X6kzkxRq62hrdupe3Qvl/V+UACrDKcA+1A0KKz6FZ1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ijngK9rfqVH6NGxFoUM4llHXAalwQCj5qLhUOB77Kq0ynFVHn0h2H0BBmu2Th5Ofgck9h/Ezy0FeC76Cu5Xwsd6G7s4fNClIjJhrrfnKJSSEwh+w1SbM8qypGV6nDJeh1Z91w4P+as11Q6pA43x+MLJKDKkBP/CBu3KjXUYOaKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CNG+gFTN; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CNG+gFTN"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4a4312b4849so68254061cf.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 01 Jul 2025 09:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751387868; x=1751992668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ISLdnPxtlGKf/l3qBzDBKL53pla5A655ILSzv3SOEo=;
        b=CNG+gFTNiS8q27Lc3rAnzX2kqNYFwukkVeemw3MluDuzyhQL2rUyRS1VnsylKJbj08
         NPTWiDrPhE0iFKGcu2nORXtov1juVEPoskpIrpDyJl5jMjGD0J5UUvlWyRyf6SzB8nFQ
         Tvo9lQo7RFYf6rPFAFGUAODPWhZS52gMYenzVkD9sWPXuU5LdLS0ZbY9wt19mlYpBj07
         b+CGfZ+QuYZR2z8qXQcoTXVHGCESIg3qrPMhFCa29psLvkBb3cp7gElcBZFnlJoAd7KT
         lmklmf6+1Po2EpUf5wF3urrEsniunuA2PPlgYS7xQVaw3RNvKKOfoqYUeQTVXfsFdxQ6
         OZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751387868; x=1751992668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ISLdnPxtlGKf/l3qBzDBKL53pla5A655ILSzv3SOEo=;
        b=h6jy+kXEJZ1xGpMAFlU2/Sb1UmZbcUWQouzRzRp3CXINUMsLTpaF7/QumCUQ9A71tH
         zl87q0BmSIqpvBr2W+9In8kte41annfKqgGl8H2g4rq4fw9gWWBeIxm3HPbqu90Z7HUJ
         8YXP2U802dSWGy039LTdSxskrF+JSkp8oFqFNzgiKr2YCG9FD82eqweKCmcQmyDeobiN
         dGwRaQuHj7xDVBZ6YZgKQ+F14roRjNoLC681Xv3HZKHTpc780dc7V/eI/RUwEJODDWJg
         w4i3ScaE4UcUHCjtfk7c9JwbaNb7OfVGXPH33Uu39kGmn8TSjXg4P1PUjS2eYmOi9NTg
         IaWw==
X-Forwarded-Encrypted: i=1; AJvYcCV4q8ml2eJACSND62/PUt+5b7qbVtrNMf38rnfUFugC9iKzaiFiMTMzNs30X0rcAh2l3YADtqTqTE3OseVA9GXDIsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YysA0qnnNXTEdTaQy81ySOAQ+Fwvq2baZSsGDQXYtA9prRWV2vF
	tVyFjZjk1sskh4zzLqeeQlH/99biySyoSX8n86dEuLW4yzLMlucF0D58x7qlHGzhVR+pqu28yqU
	3yxuDPC0w03uDOq/kjcbQAQZYIrLF6sKAKw1Jv3B4
X-Gm-Gg: ASbGncta7Wk5WjMp/kCEurZPbYdC564DtzYSemYf2A4S/dl4PKdztpd+XpoXamvF5AW
	fGJZ4mJEcbNlUEqOhYCl1AJ7HrxUH+rmp6LKAzZHDkX21Pbv1XRm/+gS/93+C1qgND5KPVAz9kG
	Ad74bqhIqXFSb+16cB0Xp8rI/7ETmJN/+e17FQ60SRAz0=
X-Google-Smtp-Source: AGHT+IHAiK9oEfXH92Sml4i6lZf1ziKhaKb1A45g7ei6HvCGgdoXpQF1Hurv306Xf8kKYruBW3bAWalu9wYw+TNdGaw=
X-Received: by 2002:a05:622a:54f:b0:4a7:ba7:1a2d with SMTP id
 d75a77b69052e-4a7fc9cfbd9mr291679101cf.4.1751387867916; Tue, 01 Jul 2025
 09:37:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701174051880riwWtq_0siCJ5Yfsa6ZOQ@zte.com.cn>
In-Reply-To: <20250701174051880riwWtq_0siCJ5Yfsa6ZOQ@zte.com.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 1 Jul 2025 09:37:36 -0700
X-Gm-Features: Ac12FXzwmxaj70tKP4W8HtmDFZSM027mPiLZs_ytA57MBpY7K3gg1Pk__C05asI
Message-ID: <CANn89iJvyYjiweCESQL8E-Si7M=gosYvh1BAVWwAWycXW8GSdg@mail.gmail.com>
Subject: Re: [PATCH net-next v2] tcp: extend tcp_retransmit_skb tracepoint
 with failure reasons
To: xu.xin16@zte.com.cn
Cc: kuba@kernel.org, kuniyu@amazon.com, ncardwell@google.com, 
	davem@davemloft.net, horms@kernel.org, dsahern@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, fan.yu9@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 2:42=E2=80=AFAM <xu.xin16@zte.com.cn> wrote:
>
> From: Fan Yu <fan.yu9@zte.com.cn>
>
> Background
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> When TCP retransmits a packet due to missing ACKs, the
> retransmission may fail for various reasons (e.g., packets
> stuck in driver queues, sequence errors, or routing issues).
>
> The original tcp_retransmit_skb tracepoint:
> 'commit e086101b150a ("tcp: add a tracepoint for tcp retransmission")'
> lacks visibility into these failure causes, making production
> diagnostics difficult.
>
> Solution
> =3D=3D=3D=3D=3D=3D=3D
> Adds a 'reason' field to the tcp_retransmit_skb tracepoint,
> enumerating with explicit failure cases:
> TCP_RETRANS_ERR_DEFAULT (retransmit terminate unexpectedly)
> TCP_RETRANS_IN_HOST_QUEUE (packet still queued in driver)
> TCP_RETRANS_END_SEQ_ERROR (invalid end sequence)
> TCP_RETRANS_TRIM_HEAD_NOMEM (trim head no memory)
> TCP_RETRANS_UNCLONE_NOMEM (skb unclone keeptruesize no memory)
> TCP_RETRANS_FRAG_NOMEM (fragment no memory)
> TCP_RETRANS_ROUTE_FAIL (routing failure)
> TCP_RETRANS_RCV_ZERO_WINDOW (closed recevier window)
> TCP_RETRANS_PSKB_COPY_NOBUFS (no buffer for skb copy)
>
> Functionality
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Enables users to know why some tcp retransmission quitted and filter
> retransmission failures by reason.
>
>

...

> +enum tcp_retransmit_quit_reason {
> +       TCP_RETRANS_ERR_DEFAULT,
> +       TCP_RETRANS_SUCCESS,
> +       TCP_RETRANS_IN_HOST_QUEUE,
> +       TCP_RETRANS_END_SEQ_ERROR,
> +       TCP_RETRANS_TRIM_HEAD_NOMEM,
> +       TCP_RETRANS_UNCLONE_NOMEM,
> +       TCP_RETRANS_FRAG_NOMEM,
> +       TCP_RETRANS_ROUTE_FAIL,
> +       TCP_RETRANS_RCV_ZERO_WINDOW,
> +       TCP_RETRANS_PSKB_COPY_NOBUFS,
> +};
> +
>  #define tcp_sk(ptr) container_of_const(ptr, struct tcp_sock, inet_conn.i=
csk_inet.sk)
>
>  /* Variant of tcp_sk() upgrading a const sock to a read/write tcp socket=
.
> diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
> index 54e60c6009e3..3e24740d759e 100644
> --- a/include/trace/events/tcp.h
> +++ b/include/trace/events/tcp.h
> @@ -13,17 +13,38 @@
>  #include <linux/sock_diag.h>
>  #include <net/rstreason.h>
>
> -/*
> - * tcp event with arguments sk and skb
> - *
> - * Note: this class requires a valid sk pointer; while skb pointer could
> - *       be NULL.
> - */
> -DECLARE_EVENT_CLASS(tcp_event_sk_skb,
> +#define TCP_RETRANSMIT_QUIT_REASON             \
> +               ENUM(TCP_RETRANS_ERR_DEFAULT,           "retransmit termi=
nate unexpectedly")    \
> +               ENUM(TCP_RETRANS_SUCCESS,               "retransmit succe=
ssfully")              \
> +               ENUM(TCP_RETRANS_IN_HOST_QUEUE,         "packet still que=
ued in driver")        \
> +               ENUM(TCP_RETRANS_END_SEQ_ERROR,         "invalid end sequ=
ence")                 \
> +               ENUM(TCP_RETRANS_TRIM_HEAD_NOMEM,       "trim head no mem=
ory")                  \
> +               ENUM(TCP_RETRANS_UNCLONE_NOMEM,         "skb unclone keep=
truesize no memory")   \
> +               ENUM(TCP_RETRANS_FRAG_NOMEM,            "fragment no memo=
ry")                   \

Do we really need 3 + 1 different 'NOMEMORY' status ?

> +               ENUM(TCP_RETRANS_ROUTE_FAIL,            "routing failure"=
)                      \
> +               ENUM(TCP_RETRANS_RCV_ZERO_WINDOW,       "closed recevier =
window")               \

receiver

> +               ENUMe(TCP_RETRANS_PSKB_COPY_NOBUFS,     "no buffer for sk=
b copy")               \

-> another NOMEM...

> +
> +


> +               __entry->quit_reason =3D quit_reason;
>         ),
>
> -       TP_printk("skbaddr=3D%p skaddr=3D%p family=3D%s sport=3D%hu dport=
=3D%hu saddr=3D%pI4 daddr=3D%pI4 saddrv6=3D%pI6c daddrv6=3D%pI6c state=3D%s=
",
> +       TP_printk("skbaddr=3D%p skaddr=3D%p family=3D%s sport=3D%hu dport=
=3D%hu saddr=3D%pI4 daddr=3D%pI4 saddrv6=3D%pI6c daddrv6=3D%pI6c state=3D%s=
 quit_reason=3D%s",

quit_reason is really weird, since most retransmits are a success.

What about using : status or result ?

Also, for scripts parsing the output, I would try to keep  key=3Dval
format (no space in @val), and concise 'vals'
