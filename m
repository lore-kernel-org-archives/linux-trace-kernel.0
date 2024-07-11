Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5260015533B
	for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Jul 2024 20:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720731439; cv=none; b=aJDV8OF3Q0RxXRvNLAtpxKcFMI00RDxXgQW2iQf7sSbtOfVGcEBd11Bxo0Hik13GRh1LtbGnskw5lhN8l3Ekztukp3VAEpMMbWwzSnv5yGkIdwsNSv7oTAZHzbzHsxtgne81dKXB0rDKdcC9pwsM3TBLnkeP3PgGG7IvAyIGD1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720731439; c=relaxed/simple;
	bh=yspC+57ohBKj+IE3NEA9/ct7ABkwKPmz0e+zIn1KONg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MbF7tOlQulecIK6XxliAYiIrjNgZrNBW0gPdp5AjGLgIFN9F1Forw1bVn/cqrccqgvMpqarAJP6uZf6XcX43QYRbLas64sGDEtHqwEQc8sbzGfw+GYt7NIBtjzhqS82gOChT1mdQD/vjfQZqosscZ14qA7nGMGuRXlTHUOw4xpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LWDNmZ1A; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LWDNmZ1A"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-65bceed88a2so12641117b3.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Jul 2024 13:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720731436; x=1721336236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qR1w6TGwRPRKUblfK+cvVsJQzW84NzZB6wHL2Wt2c14=;
        b=LWDNmZ1AmXcyPkFEkz3scc4/444fdYHtXFWe9NH/bsP4G1jEoizC1hc9xBmCBhZ/R4
         Fb9ihPW6kqZ9OGcnnZYLpOrySPdZDXWfMjZm7AwYS4xMDhw9+GLSKREbHyBaLTMvhvvy
         NFJpjZ0nK7TZJbuKKtFq1jDlF4WIgGHmDKJBtFIWnkcz/iv9BKoensGhQEIl3w9ofku3
         yjsYlQJdVTsHmWOrcoI4WTEN/9fXRVTvI2QMcNB+lD24UHMU01bUZk71tjXonzPxYKzy
         lom7LBYj+xTEq5BhCJtsn938NwqsXycqrZ0fHe5nX4mIx6BWzHyVACBTKx61h4A5xoTv
         verA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720731436; x=1721336236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qR1w6TGwRPRKUblfK+cvVsJQzW84NzZB6wHL2Wt2c14=;
        b=UAvAUQ0V3BDdwjcJSDVTSSgxJjxkQ5uxPdPs89iudOmnpS1Pa7gQrqP0NoeM3+twEH
         wpUtDdK7Ez0FGLM+AOua9QpbBlaytO/Oab59Z5SXJ7GWnyVS7CQyv9jinI6md/NVA2Vw
         FOK37+kHcga0iDWyrGpM5r8tTkB6OXMJ5kCyelVCez6Y6DsAChbfBMMUpHmQtnapG0Lo
         AdVeLbJxIuaxL0CVYhbQrH+sD6PvnpxSl7f6vh78Loipj0oNDDVwpjUXGAXpkpKI6gLQ
         ir2qI9KteRc7ggSk23uTchNfOxXMlhFip31tBxeTpIBaeX+i8E7cyCFXWjFv5tGDIHWq
         A7fg==
X-Forwarded-Encrypted: i=1; AJvYcCXdK6sEqg2l+V9Kh7K/BsjW4pDq+dJTIBEalilqw8fatzxkPSRf5T77mDYqQEDmqNGPUkCGgkZPWkbpPSB5OPi949zrPeN2JhLFy7xgkiReEwE6
X-Gm-Message-State: AOJu0YyLIJRgq0PHZCDjkb7NXVzAcA1ir38BkFUg0rArA2wOEubIgEKo
	yrXmhMN7+gw6umogB1ZqEU0+1CLideAnb5Zu0NzgxGoKDVt6siEgXXeYipOtAgd8HxQqiMhZh6E
	OCwYSo8DCeThLrjnh2rW4P7OVElQsqPnqYeWI
X-Google-Smtp-Source: AGHT+IEYLltipW2y2jpNMjV5kpiHBN8xdsLzBdnyK43dhH65oHO3BC27aVEWQpPKMVw7hLbmYOjCnlcdqKg1G5wqhvg=
X-Received: by 2002:a25:d3cf:0:b0:dfb:c6a:643 with SMTP id 3f1490d57ef6-e041b070a46mr11240607276.7.1720731436062;
 Thu, 11 Jul 2024 13:57:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710001749.1388631-1-almasrymina@google.com>
 <20240710001749.1388631-6-almasrymina@google.com> <20240710094900.0f808684@kernel.org>
 <CAHS8izPTqsNQnQWKpDPTxULTFL4vr4k6j9Zw8TQzJVDBMXWMaA@mail.gmail.com> <20240710182322.667f0108@kernel.org>
In-Reply-To: <20240710182322.667f0108@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 11 Jul 2024 13:57:01 -0700
Message-ID: <CAHS8izNMsCHhJM4hf7pf2p98sp9-3gxL6o7sC6JQnqThxiWjYw@mail.gmail.com>
Subject: Re: [PATCH net-next v16 05/13] page_pool: devmem support
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, linux-media@vger.kernel.org, 
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
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Taehee Yoo <ap420073@gmail.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, linux-mm@kvack.org, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 6:23=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 10 Jul 2024 16:42:04 -0700 Mina Almasry wrote:
> > > > +static inline void netmem_set_pp(netmem_ref netmem, struct page_po=
ol *pool)
> > > > +{
> > > > +     __netmem_clear_lsb(netmem)->pp =3D pool;
> > > > +}
> > >
> > > Why is all this stuff in the main header? It's really low level.
> > > Please put helpers which are only used by the core in a header
> > > under net/core/, like net/core/dev.h
> >
> > Sorry none of those are only used by net/core/*. Pretty much all of
> > these are used by include/net/page_pool/helpers.h, and some have
> > callers in net/core/devmem.c or net/core/skbuff.c
> >
> > Would you like me to move these pp specific looking ones to
> > include/net/page_pool/netmem.h or something similar?
>
> That's because some things already in helpers have no real business
> being there either. Why is page_pool_set_pp_info() in helpers.h?

OK, I looked into this a bit. It looks like I can trivially move
page_pool_set/clear_pp_info() to page_pool_priv.h, and that lets me
move out a few of these netmem helpers to a header under net/core.

However, to move more of these netmem helpers to a private header, I
think I need to move all the page pool dma helpers and reffing helpers
to a private header or the .c file, which I think will uninline them
as they're eventually called from drivers.

I had guessed the previous authors put those dma and ref helpers in
the .h file to inline them as they're used in fast paths. Do you think
the refactor and the uninling is desirable? Or should I just do with
the trivial moving of the page_pool_set/clear_pp_info() to the private
file?

--=20
Thanks,
Mina
