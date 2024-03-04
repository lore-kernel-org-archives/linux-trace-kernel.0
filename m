Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD00171AF
	for <linux-trace-kernel@vger.kernel.org>; Mon,  4 Mar 2024 08:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709540002; cv=none; b=auviXpM2hFF+QGlZnUTBHIlr+vLTVJ60HQq08EzqVZg9N1aoaESSnTff+5Rdl1hE9aYRWtIZJKzKYA4ZVvh5ML1W8vE3/sf5B9ecPZSI1f66Os7L/5F8NZRCpbvLIRDrEP7hmMY80TDQ089jIceAfZ6xhp5zx/PZknNkZjFB7o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709540002; c=relaxed/simple;
	bh=4t0p8fRfEFH8AtnVja0S+UMsbXd66Z0IS78pE3ll0oY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=mCir5jZ0VXuH34SgN5CmrQ5ftXQWLl2+Qop65FKK3O/7NZ+kBNDYKXk/pXKgX2KmPF9lgcmIaH1czBoZEGnektGxMtyFWE4FXhcAARyFXcEU3N3y2qsqkbYfHmmdbLaTktSC7RvfJcRDrPgmvfXfGlobDdFV5p1Yt3bmsGveCIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w0qt9aiB; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w0qt9aiB"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-566b160f6eeso21721a12.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 04 Mar 2024 00:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709539999; x=1710144799; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4t0p8fRfEFH8AtnVja0S+UMsbXd66Z0IS78pE3ll0oY=;
        b=w0qt9aiBR9tUq81QkwVtLbFS/NfedDF3dFMR9g4YqLjU7+x/C1u0My3Pxn9fUUTrTA
         9UyIeDmzDv31u/jKiv1TTDSAgvG8N4jYr08xtPMsZdq2BL3ob6g+cCJ7ijNaH4CtCnSC
         eyeZ7Jh3jlburXwO146WARBnRmL7bEhp/Ul4rXZd9kNSPiEYk+NCkFqO1OWQ9NAVFtmj
         1XHV05ybPq5ik69tndpGm8jPpX5XZlGDjDljK6Vrj9LNrj8v/YELOu2bz/VVU5utPJn6
         0lwKmefMnPrh7qhNJ0p5Ro/etJb0favMsd/LyYawi7jReO8BJxyF6VGSi72n+TNwkhX8
         JYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709539999; x=1710144799;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4t0p8fRfEFH8AtnVja0S+UMsbXd66Z0IS78pE3ll0oY=;
        b=otmoKn1MEP9KyXJiJd0BgHhEAFK7UfARdW2ZlLCslZR032WyBuXh+lrS3shWw+qKzU
         d+tSns0GThQw5m8BxU2HE+JIY4zmilouJCrD8Yh4LTc5hqQIaKBGgDQD98QOtTTato0J
         VRxB7cm7QU3A4xNsqsoi0NYANbs2+R4V168SwTuSC8XvGV37PJrq/x8RaKsYvrc8Lf8N
         2jIhxKU8kgvp2ywh8S+35wZtawF6g+pTN1SPpPrrDYmu4kkGSSRE+LJuM75ZmOrV6oGU
         bb2R91kdAxuDrqqdXdtyKvTXIqwoDY+3TwgpuLT2le0yBlK+KFaXJa7IpZwG+C1itHUW
         V5mQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2RNaSVIu9+Pj/j+mySprOb+X6F7zMPpNgp6Tm12BaVkiCHni+ckNw82UHy36l1VIgo3YE+eSm7sWVWWxfoLWfRdpQITnLl1MrZlaB3ta73n8N
X-Gm-Message-State: AOJu0YycQ1JgmT9+wvTcs99BUwMd8QeDXgCCLvPCuejw5PRVu4hygzGO
	KdTOBl5Z8eeKzkAPNslXfQPo0ICIuFXaBo4txQO5QZbLYyeelo2RnLCbjtDNQzGLUG31si9OXQI
	D2Sm3fEy34vA8IVFR1D6elYj+A2VBMCpJKckg
X-Google-Smtp-Source: AGHT+IFURhXGlP23AfBP73eeZ3jVdVKOw/QcQFPi4UL3YUIEMqBJf9SDBOsSV9UvqLTiivjkUj1SkyMyY3MCNRbV+Ko=
X-Received: by 2002:a50:cb8c:0:b0:566:306:22b7 with SMTP id
 k12-20020a50cb8c000000b00566030622b7mr287915edi.1.1709539999391; Mon, 04 Mar
 2024 00:13:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304034632.GA21357@didi-ThinkCentre-M920t-N000>
In-Reply-To: <20240304034632.GA21357@didi-ThinkCentre-M920t-N000>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 4 Mar 2024 09:13:06 +0100
Message-ID: <CANn89iJ0yBH3HskjzFUANeTxso5PpihxZcQ4VudzmfsKC-8kDw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] tcp: Add skb addr and sock addr to arguments
 of tracepoint tcp_probe.
To: edumazet@google.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	fuyuanli@didiglobal.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 4:46=E2=80=AFAM fuyuanli <fuyuanli@didiglobal.com> w=
rote:
>
> It is useful to expose skb addr and sock addr to user in tracepoint
> tcp_probe, so that we can get more information while monitoring
> receiving of tcp data, by ebpf or other ways.
>
> For example, we need to identify a packet by seq and end_seq when
> calculate transmit latency between lay 2 and lay 4 by ebpf, but which is

Please use "layer 2 and layer 4".

> not available in tcp_probe, so we can only use kprobe hooking
> tcp_rcv_esatblised to get them. But we can use tcp_probe directly if skb
> addr and sock addr are available, which is more efficient.

Okay, but please fix the typo. Correct function name is tcp_rcv_established

>
> Signed-off-by: fuyuanli <fuyuanli@didiglobal.com>
> Link: https://lore.kernel.org/netdev/20240229052813.GA23899@didi-ThinkCen=
tre-M920t-N000/
>
