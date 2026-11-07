Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794031500;
	b=CnTOlPIo3+vl5HjODzG3gkLfwHg0zp4abzRio5U3+xcNVtMrdirZU2GB0uOSthu2FVPJ
	 X5ucA/EJnFNnsZiYfoTMQPjn1sQvHSxILCn8F09ogYfR7GZv8Jarf5u/6PazhX/E5ryb3
	 lfSZrDLO3Wg+CfV8advj/ZAGwV8cnA6zFewgp2xM4qOTwFUNSG/ctLQLM/2wFgQjgO7v/
	 G9ySZ849Um4jMs7C6UCkjoeK4BqXiC6S0Ea2Kkxu3QXWxWhj/VHg5J8UIxC4uNqfprzGy
	 4HIEerXNz9/3EIeD0/xeReG+FMiDuAQxnIzs2LQota4UG8S1Ye2aUYkZOM6eSJWcgeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794031500;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uHJALVp3/SQveib5OvUvwqtSajPXbWyPalJ+PBSXIOo=;
	b=JrGfDYNdnYypmz5mygRr93H2iYlDyYTUISp1Vk52r4CPY2OcihPlUkZq/7oCRviEsa+7
	 PR+fvwFGlHdKip3tYHm27eBa3oLc4hKAvqbW2ZMCtSC6CscuX/bOU/RS3d68gtjQHEO2o
	 GJ35GQXRtZs8BBZbUENDAnFQpv6u7VzOGfv7cYJkhBDzMMNTcvUCnuMovbcQoOw+mgMjG
	 yvOiKIzVKkOpHcBIVRAsDi9kg9m4JBZv2kAY9tLYCfMNJUNzl8cd3wDhu23dhwql/BUkS
	 QJmR8gG6WD6SBF6da8V8Zb+yrNVmkpn8ItJ21GXjFjUKcGJ29drpIAS4DaJgBjwXaOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T0OQxtsi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA6C606A326
	for <linux-trace-kernel@vger.kernel.org>; Sat,  7 Nov 2026 06:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T0OQxtsi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B0121F008A1;
	Sat,  7 Nov 2026 06:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794031499;
	bh=uHJALVp3/SQveib5OvUvwqtSajPXbWyPalJ+PBSXIOo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T0OQxtsiiQEmXUFuymmMDXDyG9o2P8uAa7h1AyDj5oXf9UiTOmcaWod5JFaqS3ukC
	 SdbodVyDnSedTxKkgG4gqKNV/u+OKNrVqq3L6+8TY0FH4Lybe+KyXJULGGi/1Zs+lU
	 eq874lTCUPBTMoOI7GvOofOPqWoZkbt8/235roRsBTjiUy9WfIy22yx0BI35TglIZm
	 xeIVbs7lIwKanx86eSSEPRXWOz/9MFXRiF3OZrkyUHHelH5RLq4knrdMT+grrSXdn+
	 PxKFDWitxCcNn3/YM/5PKE047/XO9PuScWJOM/1hhfu+aJB+ekR9bscUPjgDmhymg8
	 FMk1feo2Xigqg==
Message-ID: <sashiko-outbox-202646@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/5] tracing: Add stackmap statistics interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Li Pengfei" <ljdlns1987@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261107055139.3138633-4-lipengfei28@xiaomi.com>
References: <20261107055139.3138633-1-lipengfei28@xiaomi.com>
 <20261107055139.3138633-4-lipengfei28@xiaomi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 06:04:59 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] tracing: undercounted fallbacks in ftrace_stackmap_get_cookie()
  on pool race
--

commit 668d6dcc7b8dc107b88cd7cdf37f1ed69e5f66bc
Author: Pengfei Li <lipengfei28@xiaomi.com>

tracing: Add stackmap statistics interface

This commit adds a tracefs stack_map_stat file and per-CPU counters to
report stackmap generation, capacity, element usage, and lookup successes
and fallbacks.

> diff --git a/kernel/trace/trace_stackmap.c b/kernel/trace/trace_stackmap.c
> index b02eb22c76a98..5d2a406f39b93 100644
> --- a/kernel/trace/trace_stackmap.c
> +++ b/kernel/trace/trace_stackmap.c

[ ... ]

> @@ -254,8 +276,10 @@ bool ftrace_stackmap_get_cookie(struct ftrace_stackm=
ap *smap,
>  		probes++;
>  	}
> =20
> +	stackmap_count(smap->fallbacks);
>  	return false;
>  found:
> +	stackmap_count(smap->successes);
>  	*cookie =3D ((u64)smap->generation << FTRACE_STACKMAP_COOKIE_GEN_SHIFT)=
 | idx;
>  	return true;
>  }

[Severity: Low]
Can ftrace_stackmap_get_cookie() undercount smap->fallbacks when the
element pool runs out during a concurrent insert?

When two CPUs pass the smap->next_elt < smap->max_elts check for the last
available element, both claim an entry->key slot via cmpxchg(), and
stackmap_get_elt() returns NULL for the loser:

kernel/trace/trace_stackmap.c:ftrace_stackmap_get_cookie() {
    ...
		if (test_key =3D=3D key_hash) {
			val =3D stackmap_load_elt(entry);
			/* Insert in progress; from NMI it may be the interrupted one. */
			if (!val)
				return false;
    ...
		} else if (!test_key) {
			if (atomic_read(&smap->next_elt) >=3D smap->max_elts)
				break;
			/* Lost the race; the slot may now hold this stack. */
			if (cmpxchg(&entry->key, 0, key_hash) !=3D 0)
				continue;

			val =3D stackmap_get_elt(smap);
			if (!val)
				break;
    ...
}

That leaves entry->key set to key_hash with entry->val still NULL.  Every
subsequent lookup for that stack (or any stack with the same key_hash
probing through that slot) then hits test_key =3D=3D key_hash, sees !val, a=
nd
returns false early without incrementing smap->fallbacks.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107055139.3138=
633-1-lipengfei28@xiaomi.com?part=3D3
