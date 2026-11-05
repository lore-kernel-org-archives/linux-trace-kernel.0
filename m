Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793843825;
	b=OUIy6XqwejLaHvzFtkiciqCX9UbTtcw+l//pQyWM6ElnM0avR2Kh9pBxdPhRdxrWthTo
	 RYL/Lq99bseQjADbZ3oZgfRIxpWACRc5Z23Y1RWjyzcHd4sdAqZOagmsq4zyD4G1wLrPF
	 rzTzWXBUtB/6mF/U7d7pLInf623++TRkMhnkH1QWIfsiSvutrNo/sspD9cYxUntm2pGby
	 FQdtEuRIaKpiRQSXBtUuhO76OBsXqvmhel+wcvMw3J6D9PRYW6Tm2m2uxqNtXK36NkxwT
	 GNc7dBLfJV+6ThtA8CmZWyV15qRrODeGzlckLhEYdHU2yAEQGHbIA1f1tO9lotR8yfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793843825;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=7A8XN8qah6ZpgQDR1TC944oMLlKdGGVIvkv8k0nErd8=;
	b=gPNIPfMHJo77dBQguCO5MVgxywW2l/+A5npkKYwWeiDOuWhBHp3U0L0+oOS0KIM9kPcZ
	 f4047H8t8V+z5nhkifYA7g3Yf9GYsYNuqJSZtIAM6CoiDa6Vz5cgS9m4++yDaN9RWcn3t
	 7rOUM+MOwsAF4Lkl5g27gjn7YQkmkH0bBaMEsnzlePR4EEC1/wZciQclvodQ96/hmCsGK
	 StVIAbtv/mP6HNjhd/BrKDT3TKhTtcYuWqgsXgGADwByEx4AuuEtvvk0fpQ8LNRzLqz6D
	 ZT93ckjzVsj3VozpsW2mbd9jrJXe2TXHD3Awzktdq+JWeC5BtQ5SaKhgUGZotEqHSAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="oyf3kUA/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FE9606A31B;
	Thu,  5 Nov 2026 01:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oyf3kUA/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20B21F000C1;
	Thu,  5 Nov 2026 01:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793843824;
	bh=7A8XN8qah6ZpgQDR1TC944oMLlKdGGVIvkv8k0nErd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oyf3kUA/olxhGZhzTv+Cprvn5O7ggqbwvZLHagS5b4UfQtwluKIrLRROdj7Qhlpr1
	 7lyvo7DJzZfcADM4KyqXyyFYyX/+kEzIZ1asOB+XAihPkqlK3S6/ZoX83XegkSOib4
	 8On9ibufDX3g8pDx0xrgOM6oI8lel/W0XkyZ/jiQAtb3Y7np9MYvw7T7nwr0JsBDCD
	 /sg1vVu6xmEF68Cd1MavTKYGyPgvguojFhC4QPJvi/CU485vswqmF6HCwoCRFaXxQB
	 phMQielVnhykS1TA7qAedhv4VyR2CT7nOlF2V4RGOAFTG8mktdTo7faFPy5h6h+qY6
	 s99sQJHd6DbQA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: fprobe: stop when the address array is full
Date: Thu, 05 Nov 2026 10:57:01 +0900
Message-ID: <undine-1793843821596761836-0942d0cbf5c03fd9@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <179362071771.29269.16527354623976202893@stu.pku.edu.cn>
References: <179362071771.29269.16527354623976202893@stu.pku.edu.cn>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Mon, 02 Nov 2026 19:58:37 +0800, Yifan Zhang <yfzhang23@stu.pku.edu.cn> wrote:
> get_ips_from_filter() counts matching symbols before allocating its address
> and module arrays, then repeats the walk to fill them.  A matching module
> can be loaded between the two passes.  If the vmlinux walk fills the
> arrays, filter_match_callback() returns a positive stop value, but the
> caller ignores it and starts the module walk with index equal to size.
> The first module match then writes beyond both allocations.
>
> KASAN reports:
>
>   BUG: KASAN: slab-out-of-bounds in filter_match_callback
>   Write of size 8
>   filter_match_callback
>   module_kallsyms_on_each_symbol
>   get_ips_from_filter
>   register_fprobe
>
> Return the completed count when the vmlinux walk reports that the arrays
> are full instead of continuing into module symbols.
>
> The reproducer completed all tested module-load timings without a KASAN
> report with this change.
>
> Fixes: 4346ba160409 ("fprobe: Rewrite fprobe on function-graph tracer")
> Signed-off-by: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
> ---
>  kernel/trace/fprobe.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index da286619c5d89..69d1887790739 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -885,6 +885,8 @@ static int get_ips_from_filter(const char *filter, const char *notfilter,
>  	ret = kallsyms_on_each_symbol(filter_match_callback, &match);
>  	if (ret < 0)
>  		return ret;
> +	if (ret > 0)
> +		return match.index;

Thanks for finding! Hmm, but we should return an error so that caller can
rerun it. Can you make this return -EAGAIN?

Thanks,

>  	if (IS_ENABLED(CONFIG_MODULES)) {
>  		ret = module_kallsyms_on_each_symbol(NULL, filter_match_callback, &match);
>  		if (ret < 0)
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
