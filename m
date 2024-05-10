Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8D715FA9E
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 May 2024 09:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332769; cv=none; b=m+EnmKJgIMA+3v9LF+S3RUZlULPVOrKJkAVcU1Wby/s7k07Ak49I9/4uTBItYaIfYfAuE5eIUVPIx4cOoQUFZ8p7IMw4KyfZ2Atpt906LwNskVrfWiPo4Cr+lHFPxCeaXogZNFCSOAFJMLpGWJiuedUqpIM/LcQDDw6IsFIz2zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332769; c=relaxed/simple;
	bh=IhFb5Pgicuh3snztn4LKPQtE1fwjYlbAD7oCTha2wuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pet8AtB9K9hOAe0kICYZG0NUCi+Id66xsx8ZwQ9jgjNt46Wi3D4zxdlCy0FO0T/DyjRue2As+ezEinElxfSgNIym3S1cvLPITmzV2Ye3rM0SWttr66jnazLwyhplLDnTUWjn3dsr+d7INtAYVm5MjhOSwSfFz+s4iEBee49uH/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RTbhV8fL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RTbhV8fL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715332766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=w0K49mR3hMRsaS3+WXflIxtYT2lACdM2QgyeFZGMIw0=;
	b=RTbhV8fLBtz3GXwCnojN5c4B+JJi5JARnbyMWZhpwOVay5nRPCDwJeBiIQSiZmUdgq9MCU
	em9XrnoiV65tJ4HKMnvZO0JKjf2RHlDxMXZ/iSfGs3ZWsC5lsXVqFTyA8dosmlirx1MkSX
	TZwnZyaynitfDVOexXE7u7x5cNq71jg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-XepGfYJQMbO0H16oYvsS6A-1; Fri, 10 May 2024 05:19:24 -0400
X-MC-Unique: XepGfYJQMbO0H16oYvsS6A-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-34dc66313b3so1201791f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 10 May 2024 02:19:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715332763; x=1715937563;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0K49mR3hMRsaS3+WXflIxtYT2lACdM2QgyeFZGMIw0=;
        b=eaZrBBp55HdaFm0175RyBB3kXB9JyIv4vq38jg7kICht1MRnIpdjruUVB6uzP2p8M5
         SwL+/LeEKrYJ6uIFDzpTMSsKaC+Jd/AzW2w0dgfz6joEFNfyjCtWWRctw6TlhMffA71D
         r2ZRc+9CwVFUIwKD3LOMYzU7tX9vrzoEwXCbcLCQH4fMCZro78nyPNt8xx/b2HUyIoX6
         UcMEA/gQ1L02KNMeO1c7BQ7ESzaUY9ZW/tYOfSa64eudn92fFmumIKp7vC3dW69Ib2e2
         /Cm2GZxGU+gpX5wpcvki/fNQBuDSWaGbq6bjI3XdTxQ1mOfTROjvSWI0nngZnYocLPj3
         skBw==
X-Forwarded-Encrypted: i=1; AJvYcCUIPR7zNSsUEzyKZz2UmZgh6MGM1sfm3WXIQJTHjjd/KZQWcsRFnyjGn+AZl360hLt+OkBb9TJc9W8KIdaQlHhiOud6OCyW7sDEypTqWNcjVy7K
X-Gm-Message-State: AOJu0YzFDE8ofuN6mUdQjIrhBORG8o475LRx8K6ekGFQSXiP9ZmJHkfk
	dvjL2gPnZOhYsHKM6VH4cq2f5mWFr2qQ90IQBxlmaaCHn1IT3evq2eEsdfX+bYmi3aXfwl7GLBH
	dBChBMVs8lINX8T9zwTfbj1O4AVHv7TD1pya0LwBir7csGYjQogO36PHgH6Zl39RXr5vp9w==
X-Received: by 2002:a5d:6650:0:b0:34d:7f17:1e22 with SMTP id ffacd0b85a97d-3504a61c818mr1654074f8f.14.1715332763308;
        Fri, 10 May 2024 02:19:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDLI567jRNFDBdwdqfZ6nGf1Xf15xv0+TRyAm8U9bnx+S0TvouZY2YxcPUZgob0O4OHNWsmA==
X-Received: by 2002:a5d:6650:0:b0:34d:7f17:1e22 with SMTP id ffacd0b85a97d-3504a61c818mr1654058f8f.14.1715332762858;
        Fri, 10 May 2024 02:19:22 -0700 (PDT)
Received: from ?IPV6:2003:cb:c710:2b00:9c9f:9357:3f4c:5358? (p200300cbc7102b009c9f93573f4c5358.dip0.t-ipconnect.de. [2003:cb:c710:2b00:9c9f:9357:3f4c:5358])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baad074sm4067920f8f.70.2024.05.10.02.19.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 02:19:22 -0700 (PDT)
Message-ID: <cc719813-ba73-461f-8b45-4728f926c151@redhat.com>
Date: Fri, 10 May 2024 11:19:21 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 2/5] ring-buffer: Introducing ring-buffer mapping
 functions
To: Steven Rostedt <rostedt@goodmis.org>,
 Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 kernel-team@android.com, rdunlap@infradead.org, rppt@kernel.org,
 linux-mm@kvack.org
References: <20240430111354.637356-1-vdonnefort@google.com>
 <20240430111354.637356-3-vdonnefort@google.com>
 <20240507223402.206d6ddc@rorschach.local.home>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240507223402.206d6ddc@rorschach.local.home>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.05.24 04:34, Steven Rostedt wrote:
> On Tue, 30 Apr 2024 12:13:51 +0100
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
>> +#ifdef CONFIG_MMU
>> +static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
>> +			struct vm_area_struct *vma)
>> +{
>> +	unsigned long nr_subbufs, nr_pages, vma_pages, pgoff = vma->vm_pgoff;
>> +	unsigned int subbuf_pages, subbuf_order;
>> +	struct page **pages;
>> +	int p = 0, s = 0;
>> +	int err;
>> +
>> +	/* Refuse MP_PRIVATE or writable mappings */
>> +	if (vma->vm_flags & VM_WRITE || vma->vm_flags & VM_EXEC ||
>> +	    !(vma->vm_flags & VM_MAYSHARE))
>> +		return -EPERM;
>> +
>> +	/*
>> +	 * Make sure the mapping cannot become writable later. Also tell the VM
>> +	 * to not touch these pages (VM_DONTCOPY | VM_DONTEXPAND). Finally,
>> +	 * prevent migration, GUP and dump (VM_IO).
>> +	 */
>> +	vm_flags_mod(vma, VM_DONTCOPY | VM_DONTEXPAND | VM_IO, VM_MAYWRITE);
> 
> Do we really need the VM_IO?
> 
> When testing this in gdb, I would get:
> 
> (gdb) p tmap->map->subbuf_size
> Cannot access memory at address 0x7ffff7fc2008
> 
> It appears that you can't ptrace IO memory. When I removed that flag,
> gdb has no problem reading that memory.
> 
> I think we should drop that flag.
> 
> Can you send a v23 with that removed, Shuah's update, and also the
> change below:
> 
>> +
>> +	lockdep_assert_held(&cpu_buffer->mapping_lock);
>> +
>> +	subbuf_order = cpu_buffer->buffer->subbuf_order;
>> +	subbuf_pages = 1 << subbuf_order;
>> +
>> +	nr_subbufs = cpu_buffer->nr_pages + 1; /* + reader-subbuf */
>> +	nr_pages = ((nr_subbufs) << subbuf_order) - pgoff + 1; /* + meta-page */
>> +
>> +	vma_pages = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
>> +	if (!vma_pages || vma_pages > nr_pages)
>> +		return -EINVAL;
>> +
>> +	nr_pages = vma_pages;
>> +
>> +	pages = kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
>> +	if (!pages)
>> +		return -ENOMEM;
>> +
>> +	if (!pgoff) {
>> +		pages[p++] = virt_to_page(cpu_buffer->meta_page);
>> +
>> +		/*
>> +		 * TODO: Align sub-buffers on their size, once
>> +		 * vm_insert_pages() supports the zero-page.
>> +		 */
>> +	} else {
>> +		/* Skip the meta-page */
>> +		pgoff--;
>> +
>> +		if (pgoff % subbuf_pages) {
>> +			err = -EINVAL;
>> +			goto out;
>> +		}
>> +
>> +		s += pgoff / subbuf_pages;
>> +	}
>> +
>> +	while (s < nr_subbufs && p < nr_pages) {
>> +		struct page *page = virt_to_page(cpu_buffer->subbuf_ids[s]);
>> +		int off = 0;
>> +
>> +		for (; off < (1 << (subbuf_order)); off++, page++) {
>> +			if (p >= nr_pages)
>> +				break;
>> +
>> +			pages[p++] = page;
>> +		}
>> +		s++;
>> +	}
> 
> The above can be made to:
> 
> 	while (p < nr_pages) {
> 		struct page *page;
> 		int off = 0;
> 
> 		if (WARN_ON_ONCE(s >= nr_subbufs))
> 			break;

I'm not particularly happy about us calling vm_insert_pages with NULL 
pointers stored in pages.

Should we instead do

if (WARN_ON_ONCE(s >= nr_subbufs)) {
	err = -EINVAL;
	goto out;
}

?

-- 
Cheers,

David / dhildenb

