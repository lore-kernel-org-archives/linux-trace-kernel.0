Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F84131E38
	for <linux-trace-kernel@vger.kernel.org>; Thu,  2 May 2024 13:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714656640; cv=none; b=rZrqOaMWE6xFA90hRntqn5QEZ0NnMaqwx61sLlGjzJ0jgZ5ih3ZgnefCqSR11eJ2ud343TJD4tFCUwjGdzVfAVVGe2WtTiYGGAkw/NVQ4JQwk+3XBUEIMEXgsKErl/OWJYIe8KbHTDuzMF8+mwG8KdpRKIaFUm1nhmfblXSCYYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714656640; c=relaxed/simple;
	bh=B/DmeFPPz25MgG9qZexokA0GXN9RdncFCYD8o+LPUtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WbSBcP3kgUa+6J6VZIb2h3JOe6DXtbbaO2YlHmC2O/CjqtqbYeZQlYYJZVcGEZMjz+xj7P5MOGiZJ7JfjVAqrdTFp5PF/MEUutgMkuxWx2sCM850RcjvzrEWNdS5XP45ZRnGZlngypUzHMudwugxxGEcxQWpkZT73A9GGkAxeu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Liin5OfD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Liin5OfD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714656637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=X7Kq5Ujhxuk+kuIhjuSbJ3IX8eWVN2D+4pn7W9pBvCE=;
	b=Liin5OfDJrPPkh+lQg000Ba2muDUoC2hHxB3B+DgdySHF2YM5P2AgH5k6bGO28loamvWtX
	N1e/mhWEGybBpJrIae9QUV2bEyc7RSDT2MvMd+pMt9vqm4wxhDe6cx7DjVV2Tha1J39WSy
	tHQFzzmopH0QpWmdNAxBWzaboiLi5as=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-AGT-Z8piMHOtVHBkt8NAJw-1; Thu, 02 May 2024 09:30:36 -0400
X-MC-Unique: AGT-Z8piMHOtVHBkt8NAJw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-34e2ac93f8fso280955f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 02 May 2024 06:30:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714656635; x=1715261435;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X7Kq5Ujhxuk+kuIhjuSbJ3IX8eWVN2D+4pn7W9pBvCE=;
        b=idMoS+Fr59E3PQos/fwjNkroghFBJtpCJE1rtjejoFpe549CayHD/tl2JcEz2zzMDs
         gSNmEZCKkj9rPGwHrAUZEm+pvWybZVVBLMGZvGOSvP8J2CKQwCjBR+pw9pdzIXmschQb
         zrIyZCNDNUdwst5u14bgpXHBCbAKhpgsK4WN3mZ+ayQKDrb+9w46J7ScRIkJr8rPScrf
         tXOh+DPj/yWs6gUyb/rrIMhwg884s5k/0n3uK1Pw5ci2y3IY/tnuEue7jJY0D0FWCMWO
         cnwFr/RdrHUje5pTZv3vxbum2QtlNn2+z97BEFTYiv41icdsJEU3u2KLOST7qevm5cN5
         9t5A==
X-Forwarded-Encrypted: i=1; AJvYcCWyqROLMayNNV5KzRjoEe2n8ePzQf3L2nreeRbehA+ay7o7LBhMSTZBzHxHTWWL15cdFbfKKq7y+ZgwgEZn1S3XqXDSiESfwtY+nJomxf655w56
X-Gm-Message-State: AOJu0YwZeM3uJEXZK69okKfyCtLzitp5xzIF78u4p/G94tmZrgDmyWxe
	YwOjG8wtYm7mFVGPcGFHJir+TK7M8w4T1q+5pWqedZaFy0q+P79rPUSYRtOVhB6FWp+Oz0Gm7cf
	jQFRfnwyXJ3fjkmeeRtlrqukEru/wBGmckFegmNqdKTaXluXQnqiIS3Z+47FkuF4HqXflag==
X-Received: by 2002:a05:6000:232:b0:343:e52a:f51e with SMTP id l18-20020a056000023200b00343e52af51emr1485522wrz.47.1714656634776;
        Thu, 02 May 2024 06:30:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuB/S6CdTHsjsj9sh2DEbRbgk8zz7vRZcUdrWQc8Mdc4OSobjTIeLkqqGGRJ9qF+YC8CbSYA==
X-Received: by 2002:a05:6000:232:b0:343:e52a:f51e with SMTP id l18-20020a056000023200b00343e52af51emr1485496wrz.47.1714656634271;
        Thu, 02 May 2024 06:30:34 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71e:bf00:eba1:3ab9:ab0f:d676? (p200300cbc71ebf00eba13ab9ab0fd676.dip0.t-ipconnect.de. [2003:cb:c71e:bf00:eba1:3ab9:ab0f:d676])
        by smtp.gmail.com with ESMTPSA id n12-20020adfe34c000000b00343d6c7240fsm1288517wrj.35.2024.05.02.06.30.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 06:30:33 -0700 (PDT)
Message-ID: <78e20e98-bdfc-4d7b-a59c-988b81fcc58b@redhat.com>
Date: Thu, 2 May 2024 15:30:32 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 2/5] ring-buffer: Introducing ring-buffer mapping
 functions
To: Vincent Donnefort <vdonnefort@google.com>, rostedt@goodmis.org,
 mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com,
 rdunlap@infradead.org, rppt@kernel.org, linux-mm@kvack.org
References: <20240430111354.637356-1-vdonnefort@google.com>
 <20240430111354.637356-3-vdonnefort@google.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240430111354.637356-3-vdonnefort@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.04.24 13:13, Vincent Donnefort wrote:
> In preparation for allowing the user-space to map a ring-buffer, add
> a set of mapping functions:
> 
>    ring_buffer_{map,unmap}()
> 
> And controls on the ring-buffer:
> 
>    ring_buffer_map_get_reader()  /* swap reader and head */
> 
> Mapping the ring-buffer also involves:
> 
>    A unique ID for each subbuf of the ring-buffer, currently they are
>    only identified through their in-kernel VA.
> 
>    A meta-page, where are stored ring-buffer statistics and a
>    description for the current reader
> 
> The linear mapping exposes the meta-page, and each subbuf of the
> ring-buffer, ordered following their unique ID, assigned during the
> first mapping.
> 
> Once mapped, no subbuf can get in or out of the ring-buffer: the buffer
> size will remain unmodified and the splice enabling functions will in
> reality simply memcpy the data instead of swapping subbufs.
> 
> CC: <linux-mm@kvack.org>
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> 
> diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
> index dc5ae4e96aee..96d2140b471e 100644
> --- a/include/linux/ring_buffer.h
> +++ b/include/linux/ring_buffer.h

[...]

> +/*
> + *   +--------------+  pgoff == 0
> + *   |   meta page  |
> + *   +--------------+  pgoff == 1
> + *   | subbuffer 0  |
> + *   |              |
> + *   +--------------+  pgoff == (1 + (1 << subbuf_order))
> + *   | subbuffer 1  |
> + *   |              |
> + *         ...
> + */
> +#ifdef CONFIG_MMU
> +static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
> +			struct vm_area_struct *vma)
> +{
> +	unsigned long nr_subbufs, nr_pages, vma_pages, pgoff = vma->vm_pgoff;
> +	unsigned int subbuf_pages, subbuf_order;
> +	struct page **pages;
> +	int p = 0, s = 0;
> +	int err;
> +
> +	/* Refuse MP_PRIVATE or writable mappings */
> +	if (vma->vm_flags & VM_WRITE || vma->vm_flags & VM_EXEC ||
> +	    !(vma->vm_flags & VM_MAYSHARE))
> +		return -EPERM;
> +
> +	/*
> +	 * Make sure the mapping cannot become writable later. Also tell the VM
> +	 * to not touch these pages (VM_DONTCOPY | VM_DONTEXPAND). Finally,
> +	 * prevent migration, GUP and dump (VM_IO).
> +	 */
> +	vm_flags_mod(vma, VM_DONTCOPY | VM_DONTEXPAND | VM_IO, VM_MAYWRITE);
> +
> +	lockdep_assert_held(&cpu_buffer->mapping_lock);
> +
> +	subbuf_order = cpu_buffer->buffer->subbuf_order;
> +	subbuf_pages = 1 << subbuf_order;
> +
> +	nr_subbufs = cpu_buffer->nr_pages + 1; /* + reader-subbuf */
> +	nr_pages = ((nr_subbufs) << subbuf_order) - pgoff + 1; /* + meta-page */
> +
> +	vma_pages = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
> +	if (!vma_pages || vma_pages > nr_pages)
> +		return -EINVAL;
> +
> +	nr_pages = vma_pages;
> +
> +	pages = kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
> +	if (!pages)
> +		return -ENOMEM;
> +
> +	if (!pgoff) {
> +		pages[p++] = virt_to_page(cpu_buffer->meta_page);
> +
> +		/*
> +		 * TODO: Align sub-buffers on their size, once
> +		 * vm_insert_pages() supports the zero-page.
> +		 */
> +	} else {
> +		/* Skip the meta-page */
> +		pgoff--;
> +
> +		if (pgoff % subbuf_pages) {
> +			err = -EINVAL;
> +			goto out;
> +		}
> +
> +		s += pgoff / subbuf_pages;
> +	}
> +
> +	while (s < nr_subbufs && p < nr_pages) {
> +		struct page *page = virt_to_page(cpu_buffer->subbuf_ids[s]);
> +		int off = 0;
> +
> +		for (; off < (1 << (subbuf_order)); off++, page++) {
> +			if (p >= nr_pages)
> +				break;
> +
> +			pages[p++] = page;
> +		}
> +		s++;
> +	}
> +
> +	err = vm_insert_pages(vma, vma->vm_start, pages, &nr_pages);

Nit: I did not immediately understand if we could end here with p < 
nr_pages (IOW, pages[] not completely filled).

One source of confusion is the "s < nr_subbufs" check in the while loop: 
why is "p < nr_pages" insufficient?


For the MM bits:

Acked-by: David Hildenbrand <david@redhat.com>



-- 
Cheers,

David / dhildenb

