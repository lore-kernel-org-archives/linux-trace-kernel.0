Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8F31FDA77
	for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Jan 2025 10:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736762873; cv=none; b=m8aHu4teUNklDYy+0KB3kS7NUtUbcPLIWoeNiS8xGNhV4PuDVWo2ZpaCs4oJltejCfo2KPYhI4K8XtOTvZpQ9JTsoI8Q6RLSxLUsUEN34A3Zb8D/hEXbJyTynT+zmM3um1QmiKNpwAjfI73ZsveqsVwYEA8Mp9dvzhOh6sgBheo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736762873; c=relaxed/simple;
	bh=eznSJ+jpe+nHeDpA5bgYVx1BJUfi+kI7I1v3a1QPjmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L//9z/Y6uijsyemc1wdEswCZXjRxKKHQDAYQrLI5hI2AsXTCFHu3qWVmO/fQNHtXwxTuHjhwjpvIZv3UCaQJ1uPSJsUkYQZUD2z8ocKU9EusXFc6Qv9rjsbrkjzuUaax4f6nsA1Zehm7wYyaWWZnfFpz9gaZu6ro675ttYFlsa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UK85j1Zj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UK85j1Zj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736762870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7rNTD193vSMTXyhHZ9NkXUwKUZO7hlen2I95MxpzwQI=;
	b=UK85j1Zj+GH5IlXrY5fRKy/SV2O6+8FrlaV9uPPV/dYfLKjzCC7hhMg0RWxaQI7ljMcC51
	5OCqYTrKrITfOnkq5RRGjOvKAONmn7iNTdm+ROIiR0BVsC9fjrIpNQdzcEUqaaJU2nTevi
	0JusjhU0t1R9HObxb2QgNjRwBavfY/s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-UE9UL4pUOu25IwhdJeRrmw-1; Mon, 13 Jan 2025 05:07:49 -0500
X-MC-Unique: UE9UL4pUOu25IwhdJeRrmw-1
X-Mimecast-MFC-AGG-ID: UE9UL4pUOu25IwhdJeRrmw
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38a9118c486so2505026f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Jan 2025 02:07:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736762868; x=1737367668;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7rNTD193vSMTXyhHZ9NkXUwKUZO7hlen2I95MxpzwQI=;
        b=dzLCEzcaae0OC/m7EkzgASTacgsXQekSBAfwe3fSMnkaoQwG2y28/Y8M/OFMo1rKK1
         vzRMWEHwB6raOAO3+c/dE/ZTZb3zCYjM5TNdOdeE/hXHeXrmMzsECPeSQsP4agNNb6yP
         Xw0NmEupVSWEzPM3Aof+6j14E3pqtfSbLZiwzGODwCHUw89qlB/l3Agl88ZhuCKUfvor
         pm/YrJLg3BaoaFK1DJcJPyIcwf5e0VVwJydbzjPHSK7KetwjcmJwYo4Stjh3U8cHLMQ3
         Ric3OQ2h1llA8XrFYK3kvfAzrLBJhlnvSwNMQ/dpQDgqQ6CPCdJA7xOUY1mc9y7L//aF
         ri6A==
X-Forwarded-Encrypted: i=1; AJvYcCU5z7lwsj7mGvuesFSPVJJ1dFfXPyudYhTFBtFmHSNdWmMNbyfgtN0IHsk7CpkMbKchELAngrkcN1n1k6gtzywNaA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQlBuEP9tCdvqzzhuR3rfkC3cGUfFjT3vJCFKEAYBzVos+OxpC
	qfaEBdg33ttVOFC0L7jqmzE/KRdTyaHohcnq1vsFHdCQwV8A0dgBUjkLkCy6Z2qUZzEhb/4rSSX
	K16pOSBinak7NjhVitygRczRi5OaLPQPo2bcp2L3f63tUs2m6LhR3XGBj1JI/cTXd3lea7A==
X-Gm-Gg: ASbGnct6sk9cwvQBj+BNvM8BKDj+zx6Yp3AdmkGXfZC748nAlvJvuLEyTJF/sIM7Tj8
	IiQDOQulfwmgeXID2pV3uqP2s4FGNuHXZfwDo+twUdhnOMBRVjEFPik9AAaqfZ5pdOOejqKVMtU
	IHQ6ijNy9tjqmFlQO+9s0IiNvYWQgqoi3lZfI8s2tbL1m+qJUQc3++gpfLbQAXqwAU9vWtlHn75
	MiWoSB53L6vRVkylTm+nv6kvEk55RnHpcI/y3qTkMDlyKq4wMNlCWTqQgkOUym3e8SvAPQFGTN6
	BuVQFh38Q/Qx6us=
X-Received: by 2002:a05:6000:1a8c:b0:382:4ab4:b428 with SMTP id ffacd0b85a97d-38a872d071cmr16565941f8f.8.1736762868191;
        Mon, 13 Jan 2025 02:07:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJTLbl+/pB0wum17vS/yuTvKnH/YKlZ6n4UVMWStkQVhvf7Kl5evkXclZ+YVPK5imx38HFEw==
X-Received: by 2002:a05:6000:1a8c:b0:382:4ab4:b428 with SMTP id ffacd0b85a97d-38a872d071cmr16565909f8f.8.1736762867827;
        Mon, 13 Jan 2025 02:07:47 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bdc0d8e4bsm2730484f8f.42.2025.01.13.02.07.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 02:07:46 -0800 (PST)
Message-ID: <7b0e384b-6d42-48b7-ade0-f5a699bc369d@redhat.com>
Date: Mon, 13 Jan 2025 11:07:44 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] mm/vmscan: Use PG_dropbehind instead of PG_reclaim
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Andi Shyti <andi.shyti@linux.intel.com>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Christian Brauner <brauner@kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Dan Carpenter <dan.carpenter@linaro.org>, David Airlie <airlied@gmail.com>,
 Hao Ge <gehao@kylinos.cn>, Jani Nikula <jani.nikula@linux.intel.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Josef Bacik <josef@toxicpanda.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Miklos Szeredi <miklos@szeredi.hu>, Nhat Pham <nphamcs@gmail.com>,
 Oscar Salvador <osalvador@suse.de>, Ran Xiaokai <ran.xiaokai@zte.com.cn>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Simona Vetter <simona@ffwll.ch>,
 Steven Rostedt <rostedt@goodmis.org>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Vlastimil Babka <vbabka@suse.cz>, Yosry Ahmed <yosryahmed@google.com>,
 Yu Zhao <yuzhao@google.com>, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org
References: <20250113093453.1932083-1-kirill.shutemov@linux.intel.com>
 <20250113093453.1932083-6-kirill.shutemov@linux.intel.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250113093453.1932083-6-kirill.shutemov@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qmiay6KJv409Nl1-IOHA6_7SXMGbThax9X76Fyl4L_4_1736762868
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.01.25 10:34, Kirill A. Shutemov wrote:
> The recently introduced PG_dropbehind allows for freeing folios
> immediately after writeback. Unlike PG_reclaim, it does not need vmscan
> to be involved to get the folio freed.
> 
> Instead of using folio_set_reclaim(), use folio_set_dropbehind() in
> pageout().
> 
> It is safe to leave PG_dropbehind on the folio if, for some reason
> (bug?), the folio is not in a writeback state after ->writepage().
> In these cases, the kernel had to clear PG_reclaim as it shared a page
> flag bit with PG_readahead.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>   mm/vmscan.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index a099876fa029..d15f80333d6b 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -692,19 +692,16 @@ static pageout_t pageout(struct folio *folio, struct address_space *mapping,
>   		if (shmem_mapping(mapping) && folio_test_large(folio))
>   			wbc.list = folio_list;
>   
> -		folio_set_reclaim(folio);
> +		folio_set_dropbehind(folio);
> +
>   		res = mapping->a_ops->writepage(&folio->page, &wbc);
>   		if (res < 0)
>   			handle_write_error(mapping, folio, res);
>   		if (res == AOP_WRITEPAGE_ACTIVATE) {
> -			folio_clear_reclaim(folio);
> +			folio_clear_dropbehind(folio);
>   			return PAGE_ACTIVATE;
>   		}
>   
> -		if (!folio_test_writeback(folio)) {
> -			/* synchronous write or broken a_ops? */
> -			folio_clear_reclaim(folio);
> -		}
>   		trace_mm_vmscan_write_folio(folio);
>   		node_stat_add_folio(folio, NR_VMSCAN_WRITE);
>   		return PAGE_SUCCESS;

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

