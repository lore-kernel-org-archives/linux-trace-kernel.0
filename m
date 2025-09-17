Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ADD333AA1
	for <linux-trace-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116515; cv=none; b=rhReDP7ePkKyFz9MdjlXBXAoIZPFVsY3oc5QdWfHJno9ytCm8YWCg7Ue2ebnFMNB37XpRhWRKIh/rqwmdlHZ9vosmefDrBGcOjyJlHBy+aLs8ijieof9mMLFPv2CKYgOEVYsSnvulSDaA+2/R/+qOy1+cmiLz11/Yb4UwURbbZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116515; c=relaxed/simple;
	bh=zX4lmKqHHvt6kg+FygaTZ78AhlYs4+hjvu2UKbDiG0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m9rpoXjyWZi4TB9wy/qmqTJTiJQC7+5OiBsxhYv8a/5pn9RF6OFUUnjRv9ndCe39oC+j9G7wDWglXwhSB/EcdMrlzKh4ZX1eNoj2RJkHvx/XIUwYFbDLJ07UQ8LNn4ntUWE/l5rGbz3aUoT8A30ocpdHFTknhA3CCTu299JlI6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ClH6Nm+s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ClH6Nm+s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758116512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=j9LMOchMMyRjRRzN+kT7nX+PgJH+lWPkOhHcYp1LpMc=;
	b=ClH6Nm+ssW1NCSXvxrAEzuFeyuY7DrHujw7xalStL5Lm8ppSWRb5VlGdfKh/pSZANBWyr9
	ck/NxgVeyFu6Dtj+qZMFvx80EEsHCbqhODSsSgEoM4nQGwwMHwZQg0JbZ5+YT0U6lOmrEO
	nVrJXuzk5xE4uhN5kV/VwDyScEVcdPs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-KoN5LMqsOsiPB5WroIlVeA-1; Wed, 17 Sep 2025 09:41:50 -0400
X-MC-Unique: KoN5LMqsOsiPB5WroIlVeA-1
X-Mimecast-MFC-AGG-ID: KoN5LMqsOsiPB5WroIlVeA_1758116509
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ecdc9dbc5fso777161f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:41:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758116509; x=1758721309;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j9LMOchMMyRjRRzN+kT7nX+PgJH+lWPkOhHcYp1LpMc=;
        b=sWdeU+DAaKn4jvQiGezMNHqmsDoxhSA9swqmTRDge5UBK0lhjSKbmVmktVx+lPOFSq
         7Q9o7I1AU3AsJ+MNwtLSY/N7aNogkrjKXhhCEXruxW0PfTxHmALl7sTJUUDvmBjIxKX8
         xru2a6Prb/AFMkkyNvWLZRExUdK+8WCo7/6xo5OsNZxfKmUw8QUfiuz72xD4On8CbOdf
         McsmjA2++L3m73WFhXoJKYToS6sSvCg18A7VJJd3dD2OApnJ7D7PcjPRBfNERMmEkxvY
         ugkz3skH7/t2s8epg1jCk1Z3V7d8khvq6rWEI6vG2GdgjljywEHLGhxR9VBQt096imOP
         G97Q==
X-Forwarded-Encrypted: i=1; AJvYcCV1yLAcZnds0uLqG03/y6ckVkyQpRCd4VI53rsFKoWfiD8oLkmKgeOdUxeu1ZQ+QJjZarlG5TqmWwhdnvxpthIUojY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV61sqXENSRK/tFBbLAqqpgKM7yMDAYy/LNVs/wDIzihZG/pPW
	nVNpHG4TwCRdFR4RRsEC/hNEPypLV0p8CuL/USPkGuFKoYDnjG3p3fQK0z0lLFKIWl2GSP+AUP8
	oqRttcyCphHSMqgSYCRF1CJ8w3fRXyscjWz2Sk0kdox3pQT3T+/EC+dCtFTw/NoknNvSzgWt5Yw
	==
X-Gm-Gg: ASbGnctuf3PLYysgfN7quLy5cCNNN7eNBwpQrTQXqZC974/eKKGrD+FQ28Y2gnBD7Ar
	4Xk94KmxU9WlyudENBWgwCxGK0wc8im7LQ3Imh8S6YpwBrMYTtA0xFHyYnvr7ybZ1bW4w/YS0Jg
	jm/dPf2N+7eD3AiSVdJmBwO/u84LgiLgtc509+XWlQFEnKNDBKsJ8L1maT9qLx1FWZ9kL8S4t5t
	uozrAzR0WA8lSoh26ufTb5khYKhSR3Fo4lMOv0oLQbn+od4W2Bte5B5zP0wYsjVsNvPhDnRlFJK
	VaA+1uqxbcYNV5OKAdK6Y5xqK9/P19AiMUWpmmXBnKiSs3E8FSL0D2Rz0jf/fWa2TeCXtxOZvN5
	ePSVIWpt855r8YCK+juLh8I5zHWHDG7qbxnGW1sKuXEazfJ5cLwD4J6JZ9t1KJPNA
X-Received: by 2002:a05:6000:178c:b0:3e7:615a:17de with SMTP id ffacd0b85a97d-3ecdfa1d446mr1736902f8f.47.1758116508687;
        Wed, 17 Sep 2025 06:41:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2wsn48aIbLhxRJMluX1pkl+z8XXGI8sJvZ1EmUT/hfsPa2xw9d1Th60HJN9iFrZKhSw2j9Q==
X-Received: by 2002:a05:6000:178c:b0:3e7:615a:17de with SMTP id ffacd0b85a97d-3ecdfa1d446mr1736869f8f.47.1758116508254;
        Wed, 17 Sep 2025 06:41:48 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f27:6d00:7b96:afc9:83d0:5bd? (p200300d82f276d007b96afc983d005bd.dip0.t-ipconnect.de. [2003:d8:2f27:6d00:7b96:afc9:83d0:5bd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e98b439442sm15422825f8f.38.2025.09.17.06.41.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 06:41:47 -0700 (PDT)
Message-ID: <c955bff9-b4f5-4b93-b7e0-28473766dd2f@redhat.com>
Date: Wed, 17 Sep 2025 15:41:45 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] mm: rename mm_struct::map_count to vma_count
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
 <20250915163838.631445-5-kaleshsingh@google.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250915163838.631445-5-kaleshsingh@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: efJfMsBwkEM9mlKw_doPyUhTMesJmmTKk8Dj5DSTd-k_1758116509
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.09.25 18:36, Kalesh Singh wrote:
> A mechanical rename of the mm_struct->map_count field to
> vma_count; no functional change is intended.
> 
> The name "map_count" is ambiguous within the memory management subsystem,
> as it can be confused with the folio/page->_mapcount field, which tracks
> PTE references.
> 
> The new name, vma_count, is more precise as this field has always
> counted the number of vm_area_structs associated with an mm_struct.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Pedro Falcato <pfalcato@suse.de>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---


[...]

> +++ b/mm/mmap.c
> @@ -1308,7 +1308,7 @@ void exit_mmap(struct mm_struct *mm)
>   		vma = vma_next(&vmi);
>   	} while (vma && likely(!xa_is_zero(vma)));
>   
> -	BUG_ON(count != mm->map_count);
> +	BUG_ON(count != mm->vma_count);
>   

While at it, best to change that to a WARN_ON_ONCE() or even a 
VM_WARN_ON_ONCE().

[ or remove it -- have we ever seen that firing? ]

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb

