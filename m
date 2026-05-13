Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B221E25B092;
	Wed, 13 May 2026 11:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778672899; cv=none; b=B4vX0oObjKRLCIfJTDVdanzeSLVLKhOFC223+J7JED9koRh2O38FUQvnFbFvxWVR8TPvzlz1AEl/yE74k++UNX+GtdSwqg4sytsjReI26GruBNLPdC2mZGH3itvq+03iuPllxxFE3WGf/EBuGiE5srJ4hVidBPWzMG92xrmpZR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778672899; c=relaxed/simple;
	bh=6SsqoKOotrL8ImGaZxMJB/vHRv7t8SzBAUCminkkLtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CQ5YF9UlcTUaXqMPOZPcojNset2eiHpcML1xuiPf+5DnCl92r6KsrUU9Al9pLnrooOb5k0YnqxvkGngPtt1uxz5tJdXYydl5zlklfZRK2wtCuBDL6EA7jULVcYASXbz8uWv51A+amwc7soCqTbO9CaZH3hVSlfOwLSMNxkR+AhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fe+ZJqt8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fe+ZJqt8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB1BCC2BCB7;
	Wed, 13 May 2026 11:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778672899;
	bh=6SsqoKOotrL8ImGaZxMJB/vHRv7t8SzBAUCminkkLtQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fe+ZJqt84+2lMlaa6rou22hlRZGeWIU61oh+Y19FSZLBWom/w/0qOdxOPqfcxmH4i
	 WiOT/lHJQs+yVtlW34v0D5Y00mXnAySDtmwuDGQQn6NM+IAiHEA0fd8vqo/idin85w
	 9m4h1y42Qp806JY3vLaNJ2/KKnIoEO/ldPjggl5Xekubs8OD/xzdWwUptQS46qyQ+G
	 tu62E6sa5hRB6iUkuNB3I2/FQh9bNep88xf0DSbbTjb8oVz6oz1TBIL2540A+gvhw2
	 BsE4yzcO/NGPntfo07dZAqW954WLuNnGz8Sq2L7MjaB0Ghq7T0uVpkde3wx3wvu8Pp
	 +4nYivhm8TqQQ==
Message-ID: <3e5e8fb8-6957-46b7-9777-0ed1bff1d0fb@kernel.org>
Date: Wed, 13 May 2026 13:48:11 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/4] mm/memory-failure: classify get_any_page()
 failures by reason
To: Breno Leitao <leitao@debian.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Liam R. Howlett" <liam@infradead.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 kernel-team@meta.com, Lance Yang <lance.yang@linux.dev>
References: <20260511-ecc_panic-v6-0-183012ba7d4b@debian.org>
 <20260511-ecc_panic-v6-2-183012ba7d4b@debian.org>
 <28b01c14-3d87-4cab-b695-5b9015578785@kernel.org>
 <agMpqhpgmezqnaA_@gmail.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <agMpqhpgmezqnaA_@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/12/26 15:33, Breno Leitao wrote:
> On Tue, May 12, 2026 at 10:21:50AM +0200, David Hildenbrand (Arm) wrote:
>>
>>>  		}
>>>  		goto unlock_mutex;
>>>  	} else if (res < 0) {
>>> -		if (is_reserved)
>>> +		/*
>>> +		 * Promote a stable unhandlable kernel page diagnosed by
>>> +		 * get_hwpoison_page() to MF_MSG_KERNEL alongside reserved
>>> +		 * pages; transient lifecycle races stay as MF_MSG_GET_HWPOISON.
>>> +		 */
>>> +		if (is_reserved || gp_status == MF_GET_PAGE_UNHANDLABLE)
>>>  			res = action_result(pfn, MF_MSG_KERNEL, MF_IGNORED);
>>
>>
>> It's all a bit of a mess. get_hwpoison_page() should just indicate that a page
>> is unhandable if it is PG_reserved?
> 
> Are you saying that we should identify if the page is PG_reserved in
> get_hwpoison_page() instead of in memory_failure(), as done in the
> previous patch ("mm/memory-failure: report MF_MSG_KERNEL for reserved
> pages") ?
> 
>> Why can't we just return a special error code from  get_hwpoison_page()? We ahve
>> plenty of errno values to chose from.
> 
> Something like:
> 
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 866c4428ac7ef..0a6d83575833e 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -878,7 +878,7 @@ static const char *action_name[] = {
>  };
>  
>  static const char * const action_page_types[] = {
> -	[MF_MSG_KERNEL]			= "reserved kernel page",
> +	[MF_MSG_KERNEL]			= "unrecoverable kernel page",
>  	[MF_MSG_KERNEL_HIGH_ORDER]	= "high-order kernel page",
>  	[MF_MSG_HUGE]			= "huge page",
>  	[MF_MSG_FREE_HUGE]		= "free huge page",
> @@ -1394,6 +1394,21 @@ static int get_any_page(struct page *p, unsigned long flags)
>  	int ret = 0, pass = 0;
>  	bool count_increased = false;
> 
> +	if (PageReserved(p)) {
> +		ret = -ENOTRECOVERABLE;
> +		goto out;
> +	}
> +
>  	if (flags & MF_COUNT_INCREASED)
>  		count_increased = true;
>  
> @@ -1422,7 +1437,7 @@ static int get_any_page(struct page *p, unsigned long flags)
>  				shake_page(p);
>  				goto try_again;
>  			}
> -			ret = -EIO;
> +			ret = -ENOTRECOVERABLE;
>  			goto out;
>  		}
>  	}
> @@ -1441,10 +1456,10 @@ static int get_any_page(struct page *p, unsigned long flags)
>  			goto try_again;
>  		}
>  		put_page(p);
> -		ret = -EIO;
> +		ret = -ENOTRECOVERABLE;
>  	}
>  out:
> -	if (ret == -EIO)
> +	if (ret == -EIO || ret == -ENOTRECOVERABLE)
>  		pr_err("%#lx: unhandlable page.\n", page_to_pfn(p));
>  
>  	return ret;
> @@ -2431,6 +2448,9 @@ int memory_failure(unsigned long pfn, int flags)
>  			res = action_result(pfn, MF_MSG_KERNEL_HIGH_ORDER, MF_IGNORED);
>  		}
>  		goto unlock_mutex;
> +	} else if (res == -ENOTRECOVERABLE) {
> +		res = action_result(pfn, MF_MSG_KERNEL, MF_IGNORED);
> +		goto unlock_mutex;
>  	} else if (res < 0) {
>  		res = action_result(pfn, MF_MSG_GET_HWPOISON, MF_IGNORED);
>  		goto unlock_mutex;

That might probably read nicer as

switch (res) {
case 0: ...
case 1: ...
case -ENOTRECOVERABLE:  ...
case ...
default:
}

> 
> 
> If that is what you are suggestion, maybe we can create another
> MF_MSG_RESERVED? and another return value for get_any_page() to track
> the reserve pages ?

I guess "reserved" is really just like most other kernel pages. So I wouldn't
special-case them here.

Or would there be a good reason?

-- 
Cheers,

David
