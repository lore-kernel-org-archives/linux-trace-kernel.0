Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1392729A310
	for <linux-trace-kernel@vger.kernel.org>; Wed, 17 Sep 2025 10:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758106723; cv=none; b=JZp/ujR3aJeqoQtHMcRJBWRaq25kr3hYBoaZ3L2azzXDHTllVHLt3pk+hPVWBfuC7yRJ4yKeYPmtHA4HCJNWROUVFOdUoPm3NmboAiyjT0u1JU5Rw16GaAUKlMy+ri8TImYePnZAO17c2fZ7xQm6lA3U9gwUePUDQNOUQ1SifaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758106723; c=relaxed/simple;
	bh=Izdcts6h65LPN1G5a3zTjxcIrlr+ukYYyT16tAVPvkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N9Sp8tmmpTtqS6pNpOQmtiMwcedRa1VLbrmf1jcHKz/AwGnqGziKVT5rWmy1JJ+E0+Qa9NDjPuYdCg/HAvdIQTU5atxfQeyBvUrmVI9G+EGdYQ+pu9eJK50H1sBI/vDvNIztPJWu+TQvYSblKQb9RIWXO85M4B8p6Vc6k9Qve24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gohQAgu+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gohQAgu+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758106721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7JkjtbRP7dMtBFUCBqCV1SQcXuhyJiXUoZv2gn/Tp1M=;
	b=gohQAgu+Xl71BuVyh7mtMqDaDLwB4NwEMQsHmXViV+HWZwDsK8DaFm5DvRkcqo0Q++r0Sa
	mEuT4vA7Z1yzKCEOAdyljutkCaNOpRJs2N0iHDl+aKkq3a9wv/P0y1TOoCS+VLMirLG7rv
	Krc6SSQQD4fztR8QgdDWuierUkuut2I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-4RN1yoFjO8SEBhYLomAKyQ-1; Wed, 17 Sep 2025 06:58:40 -0400
X-MC-Unique: 4RN1yoFjO8SEBhYLomAKyQ-1
X-Mimecast-MFC-AGG-ID: 4RN1yoFjO8SEBhYLomAKyQ_1758106719
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b990eb77cso6392345e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 17 Sep 2025 03:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758106719; x=1758711519;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7JkjtbRP7dMtBFUCBqCV1SQcXuhyJiXUoZv2gn/Tp1M=;
        b=OF5QX1kaAaMR7qgfuR9vmonx8qvu+1A2XlPN1WwtvGjdg+WTA8KaPPfFkcnwa5Hvq/
         SbPiBuENrxLks2xBdenGK3boFe8kBxC9s6GLTBsdALknsbiJTEkWzgNhp5daeUFZ0rKZ
         ItB/9JTRdAplIJYJiJ1SeH4GGFb962/MC7rwhU36gF0nuveO4aHnyc+AqzfqFhPoLSb/
         xAYwK1M+7IVIHien0kXHyEX7s0//wxINJFGkko3AFR7D1zTkxoFfwIZVZcXpwe1oGZef
         YotUmFOCpPAftnoZZrJtX2ylZVWGDmzPs4W6fkteJ2vbljpWJcnNh9qTMufKxDi1qIDH
         13ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiIPO2ig0wRoosbwA6OCR6RiZxUaC/Nz+ljXUg8F+LXzjbeJopGg9a/oSl6hWefYJlWxe774Fmd+7jKI+74DGQ/lA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSnK1S6X/ZuRRn6g4fA1hz/MGJSUk3Bsn+lsqUDWQsN7afOvwZ
	tZMuRF8oFtrtgc8Ni//ucLS2n/abbDwY/Xdccc7dcVwqSRqvSmsahoCdaI0cczHLOS0BY5FlaIM
	cH9kLzbSjvPhX+V03qyWqGmclxd8bRD/ETs+4pzmjU6ov1s5iNvvyB8bdSeKqZCQNF8pO2WN+4w
	==
X-Gm-Gg: ASbGncty0kPYAKyrFQUYbKJfswdaIA1tRR9SV3Rc83ZaR+Bi7enyhuewJ2SQerkJxSD
	cD6Ttsg/BCOf1i2DwWADx6/A2hObbawF8Pd5JQGxLE0AibB2Ny5Gj+Jph8V3/f3tOPHZWHEoBkF
	h8/fQhOxONkkrhoubpSdMQnpLBzGFPtm0WubpdQeLqeQL+KSIgOK527C/aQg0Op2RpbZdwomAvx
	jCaoiiPYUDGg2exv36JqyF1DzSSoG3jJF7BmoZgSCmwIyTD6kHoGzyQVb0pCpBqJxLHY7z5AJZi
	5di6u0tbUxbHHDdQdgULO16S1ZTZ4+EPClwlqME+tHKJ+h7jrUDDkbDPqW1/vaF0mcJX1YrttE6
	wFU5ShXU7FtbQVmRa8WUhuKuf+ilzbwImUBiIM/LVUxzJzN/YB4USV0DNeZuIjrfg
X-Received: by 2002:a05:600c:608b:b0:45d:e775:d8b8 with SMTP id 5b1f17b1804b1-45f32d002bamr64516525e9.1.1758106718650;
        Wed, 17 Sep 2025 03:58:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYHfjJCnarL426rUzCpUmPlFf0QrjHqktYk5gtQG/LD4ICoTbUxGn3yS+4cVVuXKN0QVM+1w==
X-Received: by 2002:a05:600c:608b:b0:45d:e775:d8b8 with SMTP id 5b1f17b1804b1-45f32d002bamr64516205e9.1.1758106718247;
        Wed, 17 Sep 2025 03:58:38 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f27:6d00:7b96:afc9:83d0:5bd? (p200300d82f276d007b96afc983d005bd.dip0.t-ipconnect.de. [2003:d8:2f27:6d00:7b96:afc9:83d0:5bd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ece199ad24sm745170f8f.50.2025.09.17.03.58.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 03:58:37 -0700 (PDT)
Message-ID: <1308de0e-bb5a-481f-a447-ee4440ffb419@redhat.com>
Date: Wed, 17 Sep 2025 12:58:35 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] mm/selftests: add max_vma_count tests
To: Kalesh Singh <kaleshsingh@google.com>, akpm@linux-foundation.org,
 minchan@kernel.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 rppt@kernel.org, pfalcato@suse.de
Cc: kernel-team@android.com, android-mm@google.com,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>, Jann Horn <jannh@google.com>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250915163838.631445-1-kaleshsingh@google.com>
 <20250915163838.631445-3-kaleshsingh@google.com>
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
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZoEEwEIAEQCGwMCF4ACGQEFCwkIBwICIgIG
 FQoJCAsCBBYCAwECHgcWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaJzangUJJlgIpAAKCRBN
 3hD3AP+DWhAxD/9wcL0A+2rtaAmutaKTfxhTP0b4AAp1r/eLxjrbfbCCmh4pqzBhmSX/4z11
 opn2KqcOsueRF1t2ENLOWzQu3Roiny2HOU7DajqB4dm1BVMaXQya5ae2ghzlJN9SIoopTWlR
 0Af3hPj5E2PYvQhlcqeoehKlBo9rROJv/rjmr2x0yOM8qeTroH/ZzNlCtJ56AsE6Tvl+r7cW
 3x7/Jq5WvWeudKrhFh7/yQ7eRvHCjd9bBrZTlgAfiHmX9AnCCPRPpNGNedV9Yty2Jnxhfmbv
 Pw37LA/jef8zlCDyUh2KCU1xVEOWqg15o1RtTyGV1nXV2O/mfuQJud5vIgzBvHhypc3p6VZJ
 lEf8YmT+Ol5P7SfCs5/uGdWUYQEMqOlg6w9R4Pe8d+mk8KGvfE9/zTwGg0nRgKqlQXrWRERv
 cuEwQbridlPAoQHrFWtwpgYMXx2TaZ3sihcIPo9uU5eBs0rf4mOERY75SK+Ekayv2ucTfjxr
 Kf014py2aoRJHuvy85ee/zIyLmve5hngZTTe3Wg3TInT9UTFzTPhItam6dZ1xqdTGHZYGU0O
 otRHcwLGt470grdiob6PfVTXoHlBvkWRadMhSuG4RORCDpq89vu5QralFNIf3EysNohoFy2A
 LYg2/D53xbU/aa4DDzBb5b1Rkg/udO1gZocVQWrDh6I2K3+cCs7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <20250915163838.631445-3-kaleshsingh@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZUWdEEdwVp54NSVbQ1XiS78lvDfZ2B4Rh7zsiwX1vdE_1758106719
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> + * test_suite_setup - Set up the VMA layout for VMA count testing.
> + *
> + * Sets up the following VMA layout:
> + *
> + * +----- base_addr
> + * |
> + * V
> + * +--------------+----------------------+--------------+----------------+--------------+----------------+--------------+-----+----------------+--------------+
> + * |  Guard Page  |                      |  Guard Page  |  Extra Map 1   | Unmapped Gap |  Extra Map 2   | Unmapped Gap | ... |  Extra Map N   | Unmapped Gap |
> + * |  (unmapped)  |      TEST_AREA       |  (unmapped)  | (mapped page)  |  (1 page)    | (mapped page)  |  (1 page)    | ... | (mapped page)  |  (1 page)    |
> + * |   (1 page)   | (unmapped, 3 pages)  |   (1 page)   |    (1 page)    |              |    (1 page)    |              |     |    (1 page)    |              |
> + * +--------------+----------------------+--------------+----------------+--------------+----------------+--------------+-----+----------------+--------------+
> + * ^              ^                      ^              ^                                                                  ^
> + * |              |                      |              |                                                                  |
> + * +--GUARD_SIZE--+                      |              +-- EXTRA_MAPS points here             Sufficient EXTRA_MAPS to ---+
> + *    (PAGE_SIZE) |                      |                                                         reach MAX_VMA_COUNT
> + *                |                      |
> + *                +--- TEST_AREA_SIZE ---+
> + *                |   (3 * PAGE_SIZE)    |
> + *                ^
> + *                |
> + *                +-- TEST_AREA starts here
> + *
>

Just wondering if we could find a different name than "guard page" here, 
to not confuse stuff with guard ptes

Will the current "guard page" we a valid vma or just a hole?

-- 
Cheers

David / dhildenb

