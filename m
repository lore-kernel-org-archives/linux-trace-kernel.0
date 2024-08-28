Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28F915B137
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Aug 2024 07:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724829639; cv=none; b=gVZ8AUvrJ6aRiMjVyQ+uBp5F7AJylsFySflczZVLH9NSH9mSyKjKKryw6uQz2Ck3qO2nGGNBm7x2jb3ripPmRrBywoQrWnDmf1/PXRyWlnG/rI+r6VVO8KEOtaeSS+MstbretKzObYAZPqYWdDbtNt3+osf9te/Z0GN45PP4W60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724829639; c=relaxed/simple;
	bh=hY0rdkFxlOJ73INaytL9GxG6uDuQeptdtje3tcWXF+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=shf6UfP90EwevWqfSbV0emooRpmXbIpj0dghALbN7Jh/KGlvA7Sxoj9DRo/XjZn0Nb1aVuwZGjE2o+QKaCIPIh3fhhHRT/SXga7PcgLlHkeNxedEsMghbVmx6leJL+obfCXJ0UtfybxT/G19EvMCCyOvuFICI41xF2s/ogsfBKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iXiG2zT1; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iXiG2zT1"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-44fee2bfd28so133521cf.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Aug 2024 00:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724829636; x=1725434436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WaKkxTlZTeNsK8i9Bxn3PWY1aY/BLsT89GdUnPxSzCs=;
        b=iXiG2zT1LZYmRlQ14gRZynyy8LwteaYwvbXkKGk5hnY0hWAZjMr8whQjsAqKYp6nIP
         XLnbQMYBrYHBNu2sGcwa411HH/mMlVF0VBicIn18IOgiBOcMj7TzkZBN5rg7K/Yp9zac
         R4aJXx9G57xEL9LbZaFy70W55jvCQSwc1bpuGqMWGM3uz93nKfBiK3V6jDEh2jPTaxEM
         ohJQqGdPdB4R2lsc7JjJsg2tfPWD/feF/rI2J35mNcyrE53PQxNmaeKZ+1xv3hFDVUjb
         cdTv7zi2Ctk8Iohq3E3vtTNIz1joqkAMQVGFaQBTDLqcJ+jeTne9UjwOa8Bge8CxHv3Z
         0R5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724829636; x=1725434436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WaKkxTlZTeNsK8i9Bxn3PWY1aY/BLsT89GdUnPxSzCs=;
        b=U8m5zWL22/uKPBPXXR1+jX1HVQ1jknQ5tfBkTMidbzo8gYc67AVed3HzpMrm+KT1Pz
         y8i3ajNAH+mrHDWkBguAIoIQGJVpXGgzBm/6aYP+HDAJkstuhyCBW8ueqvueu/TfxE6t
         GyRHSsrXeSvc0tQB2WW7tIADzQ3nxfIEFHbKenzyTyrgztMW9EFP++wdViaxbEoxEaIj
         7p43p+rEb7AvapVW7dR+i3XVvMVgizhzhdVfsChnlMSe12xouLnLWN0CaZFfUP73yrab
         C9D1zV9/cz6KxAu7K+zaviHz3+IOApZQEMRzJRd2hZLSVSGfPIliGbQbF97XryRODcS7
         wZ0w==
X-Forwarded-Encrypted: i=1; AJvYcCUhkDLAS45M2WBLilZAg+KqHYdVjvXmvIs1I3vv4UlQ9PX6/TBlem2YrAhQYrxZfIAtYk5EroPg5vxpHbf5D52ZSIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyULR12LHNJzaJfGp7MMvBqkBjNUsq/9BTkiHtx/IHbyjY6C8QI
	Zyqf8PMpaI03CtMCKLwlsx3qEJIb2A6r6Ko8c8Twy5ykKxSZxtzUcnStkxOc/jj5G+fr+I9AudY
	AsZ+YrNWrXiw+hhUeEMExK0ZIO5t/OXRsCaLJ
X-Google-Smtp-Source: AGHT+IHyMD+4xnusQLwuQ5h6kBQmR1VYMf6lXqEwBGB2U8vCgE7ervQyk/rNIf69lWKuYbdIUKJLj3Yofx+zROPan7c=
X-Received: by 2002:a05:622a:1211:b0:451:cd18:84c3 with SMTP id
 d75a77b69052e-4566cb29dc2mr2435821cf.12.1724829636084; Wed, 28 Aug 2024
 00:20:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240825041511.324452-1-almasrymina@google.com>
 <20240825041511.324452-5-almasrymina@google.com> <20240827191519.5464a0b2@kernel.org>
In-Reply-To: <20240827191519.5464a0b2@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 28 Aug 2024 00:20:23 -0700
Message-ID: <CAHS8izP8T5Xj97M7efecBmCrG9z8E0PYTxWCYZ0ym0hv13-DKg@mail.gmail.com>
Subject: Re: [PATCH net-next v22 04/13] netdev: netdevice devmem allocator
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Donald Hunter <donald.hunter@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Taehee Yoo <ap420073@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 7:15=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sun, 25 Aug 2024 04:15:02 +0000 Mina Almasry wrote:
> > +void net_devmem_free_dmabuf(struct net_iov *niov)
> > +{
> > +     struct net_devmem_dmabuf_binding *binding =3D net_iov_binding(nio=
v);
> > +     unsigned long dma_addr =3D net_devmem_get_dma_addr(niov);
> > +
> > +     if (gen_pool_has_addr(binding->chunk_pool, dma_addr, PAGE_SIZE))
> > +             gen_pool_free(binding->chunk_pool, dma_addr, PAGE_SIZE);
>
> Is the check necessary for correctness? Should it perhaps be a WARN
> under DEBUG_NET instead? The rest LGTM:
>

Not really necessary for correctness per se, but if we try to free a
dma_addr that is not in a gen_pool (due to some other bug in the
code), then gen_pool_free ends up BUG_ON, crashing the kernel.

Arguably gen_pool_free should not BUG_ON, but I think that's an old
API, and existing call sites have worked around the BUG_ON by doing a
gen_pool_has_addr check like I do here, for example kernel/dma/pool.c.
So I did not seek to change this established behavior.

I think WARN seems fine to me, but maybe not under DEBUG_NET. I don't
want production code crashing due to this error, if it's OK with you.

Unless I hear otherwise I'll add a WARN without debug here.

> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
>

Thanks!

--=20
Thanks,
Mina
