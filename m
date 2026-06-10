Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D08B332EBD
	for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Jun 2026 21:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781125434; cv=none; b=sArM1OK7Aentwq118+5wzsgM5N9E9a7XpIyqG23/60oDwc2F0BEw73tz7LIoWdbtnkIwJP3bRlBwBvy9ZYpGSsEKp43x84sQUqDLEoz4BfLSnVtYW7xu5EtrTgts1JRL8lR3+D8/EEIgO2P5k5wX62DZerMDLdwx4V66Zfcve8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781125434; c=relaxed/simple;
	bh=yB7eO+hhD5pmL2kVuJfveYMsTiQHzofkXIAao+lr93A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nvt8HtWMenpV9zby22kXMDfvF3OhMZnaPCnLoANeUOYzhyYaSwXbyIjcKbCA2efDyalU/rDnV489ANsV8AU2vnHgKG1UIxvkYfkYvbCUNzc/1XK2X5YIumwMgHuflnYZBzlKB3veXkdPauwRgQPbVX1tpTvE2lJ6E2GndzWMKHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zw8iaFgQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zw8iaFgQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7314A1F008A3
	for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Jun 2026 21:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781125433;
	bh=Dar8A+bLRP/EQe1Ns/CTmjxWxXld8NghJHxNJ9BIrEU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Zw8iaFgQNF2CozAcnLP2OP5G+gDTbTZ+Z6X5v2yHNsntvcyeEMJFfTCOCvmy9yt0N
	 QyF2knH5xX1535aWt7oalnIceU9AWX6fezkLujAAqYbYvdR2319XsSQwfG7D/Y+QP+
	 3vr/bJOm3gkxdjXvIPhAIoJCozMV2hdA9VVtz/qfbYHudDwRSe3nvNO93kWIChVkPr
	 A9ZkjK3Ogf4Qr9n+EzKDgW1x5GGh+vGPGss4ASivkW6efrsgOfKCM1kn9TaYbaK6jt
	 CVnl3xnGyii79eAsHFrfYGv9aiexIIEJfJns9gZXVdaB+BuCRYs5g/U9EkDMkRBNsc
	 SKWvbMIqMPDoA==
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-660e9fe3c3aso3817180d50.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Jun 2026 14:03:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9HbhZSohvI7XhjNq9gSuPbOA7rxk402IVzCa0C78KvlArDeWR3ASsO93KNPj8+nDYAEDC4zNVlWElDsI/ZDFzGb5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTxhMq20v4HT3vRM0p12FFuawTdPrnAx7NsaNYlJM8wODc3YD0
	0Np6ErUz1YVHx5BfDAk47BOjrxnv0UmPnkPRsUtITlRvbkvloC3CYDqimumKps7g2A0F6qgwRgJ
	DjOnS3JVdOppyiw8VWtFhsdl4b7xjjLs=
X-Received: by 2002:a05:690e:140d:b0:660:ef1e:5f21 with SMTP id
 956f58d0204a3-6614f7cfa32mr9259398d50.37.1781125432571; Wed, 10 Jun 2026
 14:03:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610195220.12403-1-jp.kobryn@linux.dev>
In-Reply-To: <20260610195220.12403-1-jp.kobryn@linux.dev>
From: Barry Song <baohua@kernel.org>
Date: Thu, 11 Jun 2026 05:03:41 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4wRiezXDhsKVL6WXniVxaBiUdM3hJzWmFiEsUSoyMoRLQ@mail.gmail.com>
X-Gm-Features: AVVi8CehC1XiB3ngHfO_-w8x-q0nG9SowChBmCUs9FvZGYuro-WM66pDETAoNLw
Message-ID: <CAGsJ_4wRiezXDhsKVL6WXniVxaBiUdM3hJzWmFiEsUSoyMoRLQ@mail.gmail.com>
Subject: Re: [PATCH v3] mm/lruvec: trace LRU add drains and drain-all requests
To: JP Kobryn <jp.kobryn@linux.dev>
Cc: linux-mm@kvack.org, willy@infradead.org, shakeel.butt@linux.dev, 
	usama.arif@linux.dev, akpm@linux-foundation.org, vbabka@kernel.org, 
	mhocko@suse.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, kasong@tencent.com, qi.zheng@linux.dev, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	chrisl@kernel.org, shikemeng@huaweicloud.com, nphamcs@gmail.com, 
	baoquan.he@linux.dev, youngjun.park@lge.com, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 3:53=E2=80=AFAM JP Kobryn <jp.kobryn@linux.dev> wro=
te:
>
> LRU add batches can be drained before they reach capacity. This can be a
> source of LRU lock contention, but it is not currently possible to
> attribute these drains to callers with existing tracepoints.
>
> Add mm_lru_add_drain to report the CPU and lru_add batch count when an
> lru_add batch is drained. This allows tracing to distinguish full drains
> from partial drains and attribute them to the calling stack.
>
> Add mm_lru_add_drain_all to capture callers of __lru_add_drain_all and
> whether they set the force flag for all CPUs. The tracepoint resembles
> the signature of the enclosing function, but is needed because of
> potential inlining.
>
> Signed-off-by: JP Kobryn <jp.kobryn@linux.dev>

Reviewed-by: Barry Song <baohua@kernel.org>

Some minor nits:

[...]

> +       unsigned int nr_folios_add =3D folio_batch_count(fbatch);
>
> -       if (folio_batch_count(fbatch))
> +       if (nr_folios_add) {
>                 folio_batch_move_lru(fbatch, lru_add);
> +               trace_mm_lru_add_drain(cpu, nr_folios_add);
> +       }

Would "nr_folios" work here, given the surrounding lru_add context?
Alternatively, nr_folios_added might make the meaning a little clearer.

Best Regards
Barry
