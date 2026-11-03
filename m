Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793687205;
	b=pOw83IjgvA1Zp5K77DjWFDYx5YPIhAjkckgtSq9YHglBrSHDacX/2De94xR2582MbRMQ
	 C7toZDU7nF3fcyU1EXEW+eVAQf4fcsYgw7CdOCHN9NtBwiqxDSD55+Hd9Z3rN0ShhJpF7
	 F7RqwMa16QqlKo9et7pHfOvAUX+iuHfLg6GXdX/bJzW2D3lQ+sKKhly9orCosy6BnkDzK
	 QyGGcceOTY97CPKhYCiypKKyddJJj7a3GRsgAgbGEb+bueB17Yp1iecFeBSNB3C/EOOz8
	 f2iSQ/q9KwzXKw98pDjYkOo5hatctWNeYi9i8q0OpHtWghOxLfSzZpyljG13s1FT2KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793687205;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=8YqOpFkmr9cAx+aebIVE0MX85yK0hEwpHWmKUBVI4T8=;
	b=BoA0zwnc6oVzPSmcsPBFedcTVALbIbQ6tBniPjvTMLEkIPi7mqL1lKPrDQjW0f2k/y6q
	 WXfQjhWPsJGFU5gjlFhRHXhrTAookx2tjlQoIGzyeRs4eSzXvsE5j0Vs6v8RrZQs3zQMA
	 bXcKKSjGH9jMzKmYEEWa3+j77i+SAyMMNYFkAiJnni1rBeksOopyxaUy+5RPOU9k66Cs8
	 Ch9v4Gvi17YkUJnjOaR1g9d4olmBriRPVl9fRlViEfMmdoXq5eymiDUCvIQe+OKTUnZ5V
	 Cr4OfYM+o75bwf8i+vPkiPF5RKjy/d/zZbL1oPNEyY9/9kgLnxzHjVcL4dT7SJ0KkBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QsxeWVGs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACD4606A332
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Nov 2026 06:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QsxeWVGs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E4D01F000C1
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Nov 2026 06:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793687200;
	bh=8YqOpFkmr9cAx+aebIVE0MX85yK0hEwpHWmKUBVI4T8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=QsxeWVGs+KYTOUEkspb59iQwhUOSBK2FJX4t7WZhE3xlXkV2tPSSGG81hQg9f7bkV
	 SwSjUOfneP/7rcLzcidgl/1JltBikccpwF1OOtQFYWtq3YnlTTYd0oVNZxqBIn2Kvd
	 LxgPlDMXTqob7xiuqgZcDszFA+gs/M7q4omjZsQW7kSInuBePN+8R6NyqgpIho0fct
	 M43xAqjg2+bvEs2UiN1dJqvzAPRITyY0Z1F5LqWj8YsPhupHQpbyjY6hE145zpqcbC
	 NB8bwYvKoLGZviwk1QW64CgTjhHFPMFn/ZHZUmi4s+4g0zsDntpmAcl3hs+VXcupW5
	 wFOGJL2Ej1krQ==
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93f079a63b8so382656885a.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Nov 2026 22:26:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByX3NWvr8ngRcJbU6fjyXgRdtBz3TEyeYPzc3epIMlvL3lF2MPK5hsgi8+KH/cyMZay+wWGzfh6qFy9l3QozDibfo4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+sVbc5tDpIDk8PkofdA9tR63gFOnKaQuM09M+mYtOI/L0XkhWk
	IFgSVg5sxSlap2pNPxrqlqHX2TTytRXHl8chSoTrstgvzotLxM3MZu22FJJbfjNuJsAJkdN4/7+
	msCN8nzI1tylmtItXBEr0iuLQIBbVIYE=
X-Received: by 2002:a05:620a:880c:b0:93f:1936:b229 with SMTP id
 af79cd13be357-944217ee7a9mr1684444285a.77.1793687199176; Mon, 02 Nov 2026
 22:26:39 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103025610.3738894-1-ridong.chen@linux.dev> <20261103025610.3738894-7-ridong.chen@linux.dev>
In-Reply-To: <20261103025610.3738894-7-ridong.chen@linux.dev>
From: Barry Song <baohua@kernel.org>
Date: Tue, 3 Nov 2026 14:26:28 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zLDFkp9vfK+PxyF21LV5rEnUqmUumgmMGuwRx8MzAfnA@mail.gmail.com>
X-Gm-Features: AclHuK8HVKdqMIREpv0PqEm0E3nZYzV_dWHIZArjnQaiOz33ddVcOx-caGz6_NQ
Message-ID: <CAGsJ_4zLDFkp9vfK+PxyF21LV5rEnUqmUumgmMGuwRx8MzAfnA@mail.gmail.com>
Subject: Re: [PATCH v6 6/7] mm/mglru: add lruvec_gen_size() helper
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
	linux-mm@kvack.org, cgroups@vger.kernel.org, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>, Ridong Chen <chenridong@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 10:57=E2=80=AFAM Ridong Chen <ridong.chen@linux.dev>=
 wrote:
>
> From: Ridong Chen <chenridong@xiaomi.com>
>
> The number of pages of a given type in a generation is computed by
> summing lrugen->nr_pages[gen][type][] over all zones and clamping each
> per-zone counter to >=3D 0, since the counters are updated locklessly and
> can transiently go negative. This loop is open-coded in
> lruvec_evictable_size() and in the debugfs lru_gen output.
>
> Add lruvec_gen_size() to compute it from a seq, and convert both users.
> Put it in mm/vmscan.h so that the vmscan tracepoints, which include that
> header, can use it as well.
> An upcoming tracepoint and the MGLRU swappiness rework will also use it.
>
> No functional change.
>
> Suggested-by: Barry Song <baohua@kernel.org>
> Signed-off-by: Ridong Chen <chenridong@xiaomi.com>
> ---

Reviewed-by: Barry Song <baohua@kernel.org>
