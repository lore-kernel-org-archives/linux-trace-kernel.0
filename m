Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD76E3B3BF7;
	Tue, 23 Jun 2026 06:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782197589; cv=none; b=FB0zVcCO3+CdXXx0srNjFAGfnUDsnmnApiYzxsUeh8bqwGCniLGvKYpqENLv9HdOw6J+hCcmfufxkjWvURBLjUk4UWI+6ng5ztZuwFMCo9NKtww10vrlxZnr7AZqMD+nRiNix6gXuuorv5CiAmBqoAQ7n+XPYKbRyobx4wAGA9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782197589; c=relaxed/simple;
	bh=LXL7qONkGAOpOOeStHJZXOnDZFBiGy82fyB5si56YHw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=drMv8NTxOvoyXE9iW0D9Xgyu8rpwlgDS+KRvaenMUKA4LmoeSNqG9N75LxV8KrCLWpB1FSDlxjrJv+biNEh2EGh7XOKrjn1ADTrs8bsHBn42zQF8axYIuVEvYV3p7Xc5AkYyqIyWUNULdzggYNJfZW55oxqjH5FuIV1jEypjWQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRCDHZoL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRCDHZoL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFFF61F00A3A;
	Tue, 23 Jun 2026 06:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782197587;
	bh=HNnfaohOxZaWUKZon+skU2KZ7mFvKCAizSFNQ0PNPI8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To;
	b=DRCDHZoLKwdVscn2loPXKkokD41Zg44WA8KdBgTunRWtn9QiiETNnbuEYBlzchm1P
	 xG/kpSCUkBwwm7qspMtfJzh6wQ54c1J/LOGyDUzURZeY/E4IQwkgnY8HIgu1qbOkOP
	 mKjbwGQbA6+2wMG+VL2tejX2jAGx9qEeEWBOquwAHH2Gq+XCGqy7le2HnamiKK/g9B
	 3tdQEjT4DWMW9Rwa/PfNIKN0vDIHoeWNLGJ3TT9LIPK5kjVTRp2gxuyM/S54p3/yTq
	 B+3hh171DaIqj5HDKIk5iJx81qJuL/rfPUxbdRk8rziILgEIyR9rSPrxw8rH3PgLsF
	 3iVFGa1dsq40Q==
Message-ID: <69618bed-db94-4503-aa9b-c78fb51a945c@kernel.org>
Date: Tue, 23 Jun 2026 14:53:03 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Zhan Xusheng <zhanxusheng@xiaomi.com>,
 Daniel Lee <chullee@google.com>
Subject: Re: [PATCH] f2fs: don't drop the top folio order in the f2fs_iostat
 tracepoint
To: Zhan Xusheng <zhanxusheng1024@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260622071534.2932054-1-zhanxusheng@xiaomi.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260622071534.2932054-1-zhanxusheng@xiaomi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

+Cc Daniel,

On 6/22/26 15:15, Zhan Xusheng wrote:
> The f2fs_iostat tracepoint stores the per-order read folio counts in a
> fixed-size array and prints a fixed number of buckets, both hardcoded to
> 11. The sysfs iostat accounting array is instead sized by NR_PAGE_ORDERS
> (= MAX_PAGE_ORDER + 1), which is not always 11:
> 
> 	arm64 16K pages -> MAX_PAGE_ORDER 11 -> NR_PAGE_ORDERS 12
> 	arm64 64K pages -> MAX_PAGE_ORDER 13 -> NR_PAGE_ORDERS 14
> 
> f2fs enables large folios for immutable, non-compressed files, and the
> read folio order is bounded by MAX_PAGECACHE_ORDER, i.e.
> min(MAX_XAS_ORDER, PREFERRED_MAX_PAGECACHE_ORDER). With THP enabled this
> reaches order 11 on 16K/64K base-page kernels (MAX_XAS_ORDER caps it at
> 11). So an order-11 read folio is possible there and is accounted into
> index 11 of the array.
> 
> On those configurations the sysfs file reports the order-11 count
> correctly, but the tracepoint silently drops it: the memcpy is capped at
> min(NR_PAGE_ORDERS, 11), so index 11 is never copied and the trace
> disagrees with sysfs. There is no memory-safety issue, only the order-11
> bucket missing from the trace; 4K-page kernels (NR_PAGE_ORDERS == 11,
> max order <= 9) are unaffected.
> 
> Size the array and the printed buckets by a ceiling that covers the
> largest possible NR_PAGE_ORDERS (14) with headroom, and add a
> BUILD_BUG_ON() so any future growth of NR_PAGE_ORDERS fails the build
> loudly instead of silently truncating again. The human-readable
> "order=count" output is preserved.
> 

Cc: stable@kernel.org

> Fixes: cb8ff3ead9a3 ("f2fs: add page-order information for large folio reads in iostat")
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
> ---
>  fs/f2fs/iostat.c            |  6 ++++++
>  include/trace/events/f2fs.h | 20 ++++++++++++++++----
>  2 files changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/iostat.c b/fs/f2fs/iostat.c
> index ae265e3e9b2c..cd801bd0b910 100644
> --- a/fs/f2fs/iostat.c
> +++ b/fs/f2fs/iostat.c
> @@ -188,6 +188,12 @@ void f2fs_update_read_folio_count(struct f2fs_sb_info *sbi, struct folio *folio)
>  	unsigned int order = folio_order(folio);
>  	unsigned long flags;
>  
> +	/*
> +	 * The f2fs_iostat tracepoint emits a fixed number of read folio order
> +	 * buckets. Make sure every order fits so none is silently dropped.
> +	 */
> +	BUILD_BUG_ON(NR_PAGE_ORDERS > F2FS_IOSTAT_RD_FOLIO_ORDERS);

What do you think of relocating this into f2fs_init_iostat()?

Thanks,

> +
>  	if (!sbi->iostat_enable)
>  		return;
>  
> diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
> index b5188d2671d7..3e810690d9de 100644
> --- a/include/trace/events/f2fs.h
> +++ b/include/trace/events/f2fs.h
> @@ -2114,6 +2114,14 @@ DEFINE_EVENT(f2fs_zip_end, f2fs_decompress_pages_end,
>  );
>  
>  #ifdef CONFIG_F2FS_IOSTAT
> +/*
> + * Number of read folio order buckets emitted by the f2fs_iostat tracepoint.
> + * TP_printk() cannot loop, so the field count is fixed here and must be >=
> + * the largest possible NR_PAGE_ORDERS (14 on arm64 with 64K pages). The
> + * BUILD_BUG_ON() in f2fs_update_read_folio_count() enforces this.
> + */
> +#define F2FS_IOSTAT_RD_FOLIO_ORDERS	16
> +
>  TRACE_EVENT(f2fs_iostat,
>  
>  	TP_PROTO(struct f2fs_sb_info *sbi, unsigned long long *iostat,
> @@ -2151,7 +2159,7 @@ TRACE_EVENT(f2fs_iostat,
>  		__field(unsigned long long,	fs_mrio)
>  		__field(unsigned long long,	fs_discard)
>  		__field(unsigned long long,	fs_reset_zone)
> -		__array(unsigned long long,	read_folio_count, 11)
> +		__array(unsigned long long,	read_folio_count, F2FS_IOSTAT_RD_FOLIO_ORDERS)
>  	),
>  
>  	TP_fast_assign(
> @@ -2186,7 +2194,8 @@ TRACE_EVENT(f2fs_iostat,
>  		__entry->fs_reset_zone	= iostat[FS_ZONE_RESET_IO];
>  		memset(__entry->read_folio_count, 0, sizeof(__entry->read_folio_count));
>  		memcpy(__entry->read_folio_count, read_folio_count,
> -				sizeof(unsigned long long) * min_t(int, NR_PAGE_ORDERS, 11));
> +				sizeof(unsigned long long) *
> +				min_t(int, NR_PAGE_ORDERS, F2FS_IOSTAT_RD_FOLIO_ORDERS));
>  	),
>  
>  	TP_printk("dev = (%d,%d), "
> @@ -2201,7 +2210,8 @@ TRACE_EVENT(f2fs_iostat,
>  		"fs [data=%llu, (gc_data=%llu, cdata=%llu), "
>  		"node=%llu, meta=%llu], "
>  		"read_folio_count [0=%llu, 1=%llu, 2=%llu, 3=%llu, 4=%llu, "
> -		"5=%llu, 6=%llu, 7=%llu, 8=%llu, 9=%llu, 10=%llu]",
> +		"5=%llu, 6=%llu, 7=%llu, 8=%llu, 9=%llu, 10=%llu, 11=%llu, "
> +		"12=%llu, 13=%llu, 14=%llu, 15=%llu]",
>  		show_dev(__entry->dev), __entry->app_wio, __entry->app_dio,
>  		__entry->app_bio, __entry->app_mio, __entry->app_bcdio,
>  		__entry->app_mcdio, __entry->fs_dio, __entry->fs_cdio,
> @@ -2218,7 +2228,9 @@ TRACE_EVENT(f2fs_iostat,
>  		__entry->read_folio_count[4], __entry->read_folio_count[5],
>  		__entry->read_folio_count[6], __entry->read_folio_count[7],
>  		__entry->read_folio_count[8], __entry->read_folio_count[9],
> -		__entry->read_folio_count[10])
> +		__entry->read_folio_count[10], __entry->read_folio_count[11],
> +		__entry->read_folio_count[12], __entry->read_folio_count[13],
> +		__entry->read_folio_count[14], __entry->read_folio_count[15])
>  );
>  
>  #ifndef __F2FS_IOSTAT_LATENCY_TYPE

