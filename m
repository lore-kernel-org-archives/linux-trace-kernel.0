Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F1E1FDA97
	for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Jan 2025 10:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736762820; cv=none; b=AMqdsAHCG8h6V16Y3Oyf7FOPkBmbRDeMWOj2NMC/8+VIuGdttt809w/mzo6do1k2t95hqD7liurnc7PmUVN9GX41br3F4ZiPx3S9R/VS1LRpdIZ+nrwLeuXrOE9lvoiLpx8NJw+JO4HvW0jqfWzyXWuxq3c2JzHS5V+3bEbrlw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736762820; c=relaxed/simple;
	bh=PwRVzVMCk8TY41NJ6Gsf6G4FjtBN28UEqXOwJVROv7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cEsyBc+AOOSF7BqkLzBEj3lihjtHfWBXW9lS22e21Pg2CeRhPie+FEIkThbOlZykLQ2zqsaVFngmV9XjrSoBy5h49IIaNpTE5RJriRiJQYGjEK54TYOlA1tf8UeXMAwX21DZCSnT+Lak7eYvGrdHbEh11KZO7WLyzV+CKVg8rFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O2qE7Bk1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O2qE7Bk1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736762818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JHCb4bB8mImBjabkrJwimOaj2JB88jxmW+kXdkww2/A=;
	b=O2qE7Bk1WKf6xHDrZCTZFl8bIlnczUIcWeHeVJMA0z27Uh7HczbOjwBETXVzjNtwFH4HDW
	DkTmm62sWghogBQiewNWoa4bYIzKQ8kNo5ON/wef+uDwM5rPIn1BpkOF6x0gzXX7Vibkf/
	/uGGLZtlY+Edp/YwTtxerdy6e5iyOKY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-kMCkFjcPPaOr3GBPQe4CTw-1; Mon, 13 Jan 2025 05:06:56 -0500
X-MC-Unique: kMCkFjcPPaOr3GBPQe4CTw-1
X-Mimecast-MFC-AGG-ID: kMCkFjcPPaOr3GBPQe4CTw
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4361c040ba8so23366315e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Jan 2025 02:06:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736762815; x=1737367615;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JHCb4bB8mImBjabkrJwimOaj2JB88jxmW+kXdkww2/A=;
        b=LUtSW0SY145si70UdgLay+nlqtpawbfbNoQGViPp1C2AZSCqglO0EOfDuaNtnGHT+Y
         BS+O7ggZxfemmzy3n64lL6PKi0Ztasqzm/l3PLaRM47whdxnQCE8agOd8khSyaQpQU6/
         0RzAB9pOanUAAcl9t5P5SltJQDBJv5sPOHiC85RgLa6hZvAtb2hXjZMtCURGAkbeyoUB
         epI+Nz3lDbJKbEQ3UmcvkAiewU6sJGkTef4ofJu6bhok5cf4dyUnkOI8oVVGAdMfKtmn
         9UYNo5fDDaRotrYoviCPOTf6TAHSmRMrAaFbldA0dvMRA8pVAh63yTfQ3UHjIC9WA6bs
         5xOg==
X-Forwarded-Encrypted: i=1; AJvYcCU3NtNd8ouwPg2StoJZmZD2GoA4/4nbWpkHGfDmf15rBqFcbnrF9biB88XR15JaeUmsuydIw0HHKlSriIR2wvDHKpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy96IB4Spue8vAD3w8esZWAA1YtLL9Nlc2EJvsTddkU4XnY6SYG
	w1m6+rPePwSXf+x7Fpi7ycOGV5m5elCbM8wExZkjlvucPA4+4+sCohtQFhduZ7C3GaSKr/37Dyi
	y9Kxv9b5Fh4otbWoNPUBD0fC91lhQ886OaE4L2C9MwT5LvTSpb3f7T6hjjqpCd7b8nT3K+g==
X-Gm-Gg: ASbGncvJtaQZb7k5I/hhAvjVsvYYvwk3NKoANtsAYXH0JJK1VPn5hdMQjxAZwSY8O5i
	eI/en7f+pHomSDIk16kSj3b0lYwfXNrLp1f27UbgErgu+GIjVj50CR2nmSwrqlj9vJpp2rWAJi3
	kMiIDfGJ5K886qxBMU86PhZFmYaDumFQ/xhXY78ze/Z4qrH8WXOROzmZbPbwkIS14Q/anDR1dXv
	KKgPi9zn7hPrbMjOySr2D93VXKv4izrmARDDKs1y6hpW3vw25105ztL9BJo6VXRZ6q5VzdBPny2
	5ZzbtguEGw2vKtg=
X-Received: by 2002:a05:600c:4f4e:b0:434:a902:97cd with SMTP id 5b1f17b1804b1-436e26935cbmr165347065e9.12.1736762815546;
        Mon, 13 Jan 2025 02:06:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFI9kqKBJcLu+c3urAkuVsV+36WinEuiIzeJjEJMU6N7+OFY6sH2E4P/sySxRLfmyj02wuFag==
X-Received: by 2002:a05:600c:4f4e:b0:434:a902:97cd with SMTP id 5b1f17b1804b1-436e26935cbmr165346705e9.12.1736762815223;
        Mon, 13 Jan 2025 02:06:55 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9dd1de9sm137917315e9.15.2025.01.13.02.06.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 02:06:53 -0800 (PST)
Message-ID: <d104f8f1-6930-419f-93ea-e9a8d35c3d48@redhat.com>
Date: Mon, 13 Jan 2025 11:06:52 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] mm/zswap: Use PG_dropbehind instead of PG_reclaim
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
 <20250113093453.1932083-4-kirill.shutemov@linux.intel.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250113093453.1932083-4-kirill.shutemov@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: h7emfZSqu5_BQxTOJ1QSjPLsYq0gR_APdZl8ZYnF0Tk_1736762816
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
> zswap_writeback_entry().
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>   mm/zswap.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 167ae641379f..c20bad0b0978 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1096,8 +1096,8 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
>   	/* folio is up to date */
>   	folio_mark_uptodate(folio);
>   
> -	/* move it to the tail of the inactive list after end_writeback */
> -	folio_set_reclaim(folio);
> +	/* free the folio after writeback */
> +	folio_set_dropbehind(folio);

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

