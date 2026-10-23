Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792792640;
	b=nfIJKXeNZrU9SJX6j9+/TabloWKbexMha49kOlklzzO/d76Xom1Sef7MndTuu8XX6lNM
	 vqS4VVcL0a581vFg2f8K9SHFf28H3AUCe/bXORdVxDpMDV6lEMPJ5HFn8rRA1N/CCBN/e
	 GyXJTkHUm7hoMBdBz6cJaSQSL6ihx8JF8A8KSTl1r7iKjuYcukl0RI5qSgkPxPxP0klAk
	 D1C3zT6JwiBNcl3HuOkixmGluj4RtZ6EVv/hERUIDaIkkQ1JCTqcLxjT75zcdfXvIOIdV
	 TiTKfVfRndcKrrMzQ2g9tJmc0Qf1whrKFHdLETTEx/MmYmAqetHH5X9svXNMCVki2vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792792640;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Tu8cvyWH/oOOkyCYeseFYJUgW609McRuCvju08fCeYQ=;
	b=nFD3n+P3jLu0A/z2nYpe95uh2wR43NuJ1fputbYGPd+inUbSZi1vCWMJQ8e4lRXzlgnt
	 VnDzU5JSutBxdfT4voiRJxe3o5aZR8JpXQP6y3qssqgkYvlmkBER6hiAhQtp7g2zhk6sM
	 5c8H5HyC1mFqutkbAQqL0LyfuU6z24GXDJxp8rXRmt9FBCLHGS/BNRpED+uW9WwusTf05
	 ZVU2EdMWY/vxInqdg55IayGIKuZHKtEaTqZp1/OkJOy2kLoI9mGvvtGnEsABEIBfxRtJb
	 pbue3/NuR/fz8/aQ8BFhUSuVLEFx2Y0vs+sl7d1IxRJERnfSLbq6EyAuCD70lVUxkxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ArBbS8sR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58CF606A31D
	for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Oct 2026 21:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ArBbS8sR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A531F01829
	for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Oct 2026 21:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792792639;
	bh=Tu8cvyWH/oOOkyCYeseFYJUgW609McRuCvju08fCeYQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ArBbS8sRe2vZvBPusOGjqBO4rL5/iJmOJ9CkoNhu2e7k0FBxGNrH52nYh00i7StEL
	 q0XDBQh44yKY+SeL2AfUQqAt2TSOdFPMVwBZ6gA2lZ6rcXJM85LPT6kalfXQ9baMYs
	 fsvl13QpfrVCSsMIr5vAzn6XoLzf4egFifAFEloe3/vgA4RvocSeoRiurCA/yUx+lk
	 z08L3Qb3Um5BospfauxuAe9lP38hTSyZf82Ac5LCA2mxiN62w/7eCCeA0lw3/dEq7u
	 8UkpKXie61nurXw0oYGj7IONt1Jy2RDtoAyWvqslWyxUniA2I8K6BvppggqcvFFwM6
	 tbsZfYxGbHfEw==
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-93f2f2edb19so118647685a.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Oct 2026 14:57:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwtoi3R80yKYeGBQ8hnI1+Y5DT9+oW611bEoGYTh0D6tAmi+5Nn0d+Xf3pUyrQnwEyDgZwbofKro2166227qpN+IxA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJU0g9+coUj0fFRIKZVF8za2n+y0QHdoHbftVNhNqVzJmxL7RQq
	Wd/+q7e/QAHy7QQMSs5EvNPDRHPgYMHq6HNvOXpzhQ6ypAR5G5CEZjxXfa4t0RQiKRR3wMY0GqS
	4O4vx0lcArpU+MIeN8Tyh30vRUFDIxQs=
X-Received: by 2002:a05:620a:8389:b0:93f:5ab9:fda7 with SMTP id
 af79cd13be357-940ef95664emr52518085a.42.1792792638589; Fri, 23 Oct 2026
 14:57:18 -0700 (PDT)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019034426.2354049-1-ridong.chen@linux.dev> <20261019035252.2357900-1-ridong.chen@linux.dev>
In-Reply-To: <20261019035252.2357900-1-ridong.chen@linux.dev>
From: Barry Song <baohua@kernel.org>
Date: Sat, 24 Oct 2026 05:57:06 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4z-sbP+qtSk8b2tWGBPTNfKiF3=z69qc9f+FjWGUEgyow@mail.gmail.com>
X-Gm-Features: AclHuK_VJ_jirLI57h8oBojXk8WvqdC7Lhm8-1ezp_qE6OG-iPQQ44-4rsmpu_4
Message-ID: <CAGsJ_4z-sbP+qtSk8b2tWGBPTNfKiF3=z69qc9f+FjWGUEgyow@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] mm/memcontrol: drop unused vmscan tracepoint include
To: Ridong Chen <ridong.chen@linux.dev>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Dave Chinner <david@fromorbit.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Muchun Song <muchun.song@linux.dev>, 
	Qi Zheng <qi.zheng@linux.dev>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, bpf@vger.kernel.org, 
	Ridong Chen <chenridong@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 11:53=E2=80=AFAM Ridong Chen <ridong.chen@linux.dev=
> wrote:
>
> From: Ridong Chen <chenridong@xiaomi.com>
>
> memcontrol.c includes <trace/events/vmscan.h> but does not use any of
> the tracepoints or macros it defines: all tracepoints invoked here come
> from memcg.h and writeback.h.
>
> Drop it ahead of moving the vmscan trace header under mm/, after which
> <trace/events/vmscan.h> will no longer exist.
>
> No functional change.
>
> Assisted-by: LLM
> Acked-by: Muchun Song <muchun.song@linux.dev>
> Signed-off-by: Ridong Chen <chenridong@xiaomi.com>
> ---

Reviewed-by: Barry Song <baohua@kernel.org>
