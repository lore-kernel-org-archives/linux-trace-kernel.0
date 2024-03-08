Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB40F22F07
	for <linux-trace-kernel@vger.kernel.org>; Fri,  8 Mar 2024 02:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709863721; cv=none; b=hMCHh37vI+wesvS/YDcuyI2RZ4HIdZanNU3sM9cY1J4w4hgmuiZW4ikszWpnGye9cYaY/0HT3ka4USEkKVEbXCU/3zqQq+ho/cETsR47OYsJsZoOO87q7b5Zbqskh5JUFXWMeXH2+8SwDuLivitEQ40uwUvdIWqLZewKDb4AzOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709863721; c=relaxed/simple;
	bh=2oAucL9FmKXjOeeokVf3zjH8TEdrD9innbGK83JfkzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XMkC3LAKLDkqwQtCbyGBddXvMkagwg6ZFKjIaDdM2wNVeNCA7GRJbuzeUkj+rryCLpWmJsnMfjtHqJDIkGlH6OfJl5H0bzI2g53R90x7Q4i+mTssqt44AkhwcyoNciTZSdx3rGd6l88SGDolzkbfGJ+SV0gMZBNxsonlNyLhT3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vz8QSX83; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vz8QSX83"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a450bedffdfso214082866b.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 07 Mar 2024 18:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709863717; x=1710468517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5QPfVVlznHCy9800rrfO6KR+EEw66k04MBVvznezAw=;
        b=Vz8QSX83467DPy9/uYGiv6OK9FB4nRsUecP/Zaadz0/VC432HtZhHH1FcQH3zTYFYY
         7HjBEsKjWP8C0mg2eKq4cmIuEljNRPYJhn2LT6DQvErrBeYQsOCzdZaBO+DBgHF5hTXb
         lkqQ/7YrnMPjWk+t44qevtx5QGPq+o+D5ea7IS4ZfGhJ1RQcfuhwCs8yDY54JrC9qXrq
         S1LJ1E7W5e1ltSo6rm+C4uBPWNj3v2cqCFQiMuYEvc+3Iz81BN3MJIHW16//ytI7YNrM
         ooLn48otvXdUIyX/O4w6xN4Fu1wkPj9+2ZvrMTBW7Vt8aOVXpvzkXcYN+ycpiqX2CEGY
         xZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709863717; x=1710468517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M5QPfVVlznHCy9800rrfO6KR+EEw66k04MBVvznezAw=;
        b=PNHY2kQTWIv3CAWJvbmfHlqoqfvhbX7PXvGPmg3umpgSs/C8A0KxZu/biqmqZTcM2c
         6uSMA+2uWmu3HgK4zuJRfRK+1jKouJuXHGxgm7TVZyfQ0htlra+tFWoIOdVjKWZRx0s9
         8Cj0GfNteqc9IcPajzCZrUmEsRdjIgnhQgB8Rm2NqV0HdDL5boA0jfOxNITIB0t5D5pG
         jSdULgZWTqowpEaUz0yakf6v0ssUX6s4uaplMoUNgPPFkjvNBV+grTFknBMrBZ4GKM9O
         ABjb4Bmgar46n/4ErlTmFQlaEyDZfbrpAYIban/zbU/vVB/AVnaSZaKvXQFKc2i7bwg4
         y9iQ==
X-Forwarded-Encrypted: i=1; AJvYcCWN5AiVh2kxQOP4y94n+XTiaesVWHRnC4EKIbXhAGrnHk81p64gXS54zVEu2h1FJX0B5UWkONQI7U3q5t7SArzLSe6EAhKdtRuOP5s3RZnA37tD
X-Gm-Message-State: AOJu0Yzo5pfiav8mvciKWuWhA4dhEj5Q8SgnezxnBRcu0Xo6V2Wq+kB5
	LPkPwk33YwSG/M5IZn24svsuqlqXNm8/EK+QiVukhNFxKS/GRwFgaNJDHtcJC2t6DP74GuF2sOc
	bjw4W2xx+4C202KRi7M0C6G9Np4Ox6l/PIYPw
X-Google-Smtp-Source: AGHT+IEumbOv6N2RdvxqNHnmUGQyPJoik+UnzOHCm5V6zf8kG5cWaKe9qZLk7VBIdBkDMUerOetVJNL7YjESeOQCAoM=
X-Received: by 2002:a17:906:b055:b0:a45:ba06:e501 with SMTP id
 bj21-20020a170906b05500b00a45ba06e501mr4646563ejb.57.1709863716984; Thu, 07
 Mar 2024 18:08:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305020153.2787423-1-almasrymina@google.com>
 <20240305020153.2787423-2-almasrymina@google.com> <20240307173039.00e6fbb7@kernel.org>
In-Reply-To: <20240307173039.00e6fbb7@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 7 Mar 2024 18:08:24 -0800
Message-ID: <CAHS8izPyxn2LsOsxL98WAHse21tq3i9MCp_Xn8AA8sx5iettNQ@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v6 01/15] queue_api: define queue api
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Richard Henderson <richard.henderson@linaro.org>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeelb@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 5:30=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Mon,  4 Mar 2024 18:01:36 -0800 Mina Almasry wrote:
> > + * void *(*ndo_queue_mem_alloc)(struct net_device *dev, int idx);
> > + *   Allocate memory for an RX queue. The memory returned in the form =
of
> > + *   a void * can be passed to ndo_queue_mem_free() for freeing or to
> > + *   ndo_queue_start to create an RX queue with this memory.
> > + *
> > + * void      (*ndo_queue_mem_free)(struct net_device *dev, void *);
> > + *   Free memory from an RX queue.
> > + *
> > + * int (*ndo_queue_start)(struct net_device *dev, int idx, void *);
> > + *   Start an RX queue at the specified index.
> > + *
> > + * int (*ndo_queue_stop)(struct net_device *dev, int idx, void **);
> > + *   Stop the RX queue at the specified index.
> >   */
> >  struct net_device_ops {
> >       int                     (*ndo_init)(struct net_device *dev);
> > @@ -1679,6 +1693,16 @@ struct net_device_ops {
> >       int                     (*ndo_hwtstamp_set)(struct net_device *de=
v,
> >                                                   struct kernel_hwtstam=
p_config *kernel_config,
> >                                                   struct netlink_ext_ac=
k *extack);
> > +     void *                  (*ndo_queue_mem_alloc)(struct net_device =
*dev,
> > +                                                    int idx);
> > +     void                    (*ndo_queue_mem_free)(struct net_device *=
dev,
> > +                                                   void *queue_mem);
> > +     int                     (*ndo_queue_start)(struct net_device *dev=
,
> > +                                                int idx,
> > +                                                void *queue_mem);
> > +     int                     (*ndo_queue_stop)(struct net_device *dev,
> > +                                               int idx,
> > +                                               void **out_queue_mem);
>
> The queue configuration object was quite an integral part of the design,
> I'm slightly worried that it's not here :)

That was a bit of a simplification I'm making since we just want to
restart the queue. I thought it was OK to define some minimal version
here and extend it later with configuration? Because in this context
all we really need is to restart the queue, yes?

If extending with some configuration is a must please let me know what
configuration struct you're envisioning. Were you envisioning a stub?
Or some real configuration struct that we just don't use at the
moment? Or one that we use for this use case somehow?

> Also we may want to rename
> the about-to-be-merged ops from netdev_stat_ops and netdev_queue_ops,
> and add these there?
>
> https://lore.kernel.org/all/20240306195509.1502746-2-kuba@kernel.org/
>

Yeah, that sounds reasonable! Thanks! We could also keep the
netdev_stat_ops and add new netdev_queue_ops alongside them if you
prefer.

> Very excited to hear that you made progress on this and ported GVE over!

Actually, we're still discussing but it looks like my GVE queue API
implementation I proposed earlier may be a no-go. Likely someone from
the GVE team will follow up here with this piece, probably in a
separate series.

For now I'm carrying my POC for the GVE implementation out of tree
with the rest of the driver changes:

https://github.com/mina/linux/commit/501b734c80186545281e9edb1bf313f5a2d8cb=
ee

--=20
Thanks,
Mina
