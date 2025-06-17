Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7932E06CC
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Jun 2025 11:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750161598; cv=none; b=YbCVN7onBWsfhRit3j+jGH+Mjqu2QswXay2XLjYdqeaXELQYFR/uOK81Zd/oMUNQ8Na6MOCjQAH+ToicaUnsUfLHfpF7v5qQfaKQ65UPMlH9jO3hNDdV8jTyOBNa5xgowAyhiUppwhvVkWUcZVknpVaQzuA4ScY3KZGANsbcGfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750161598; c=relaxed/simple;
	bh=9nOZhAg66hqyI/84pWFJj9MHdQy17RoVhpx+uocrR1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PJhpTE+j0mYnlka9RbF6pYhf9vKa2JJtPpq1WHezp1ZGBasU7NOFdmwZg8ukf4tsH6T3tfqn4+1azWVYVBpG08WYLncSl3KY1A6hNKL2e0kc0QGsSnt31qAIwkWTJ6yaHT8oDyg4Efxdo3B5MUaE6d3Ham+AcXvgjpScfTyLyWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R9ypEt+H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R9ypEt+H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750161594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=m3kEGwFA75VuiPq7lg+V4SoBEQCcbai8y87ujNCUAt4=;
	b=R9ypEt+HO0QxG/2GVBySdAklGeuHlPIByGLZjNwUdsOeccEi97T9h8mkz3OMNASjEafq78
	YNvXE53NLgH7zaqyucm9x7WyGU0nigS6NEXMLjQQ8F6L+RgGmJoFTtoDBP6BmP1txYgAI2
	63mqDCZCh2frZnefggfruMNlaETERvk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-6Tunia-HPS-lBwxPoxQrZA-1; Tue, 17 Jun 2025 07:59:53 -0400
X-MC-Unique: 6Tunia-HPS-lBwxPoxQrZA-1
X-Mimecast-MFC-AGG-ID: 6Tunia-HPS-lBwxPoxQrZA_1750161592
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-453018b4ddeso34088965e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Jun 2025 04:59:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750161592; x=1750766392;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m3kEGwFA75VuiPq7lg+V4SoBEQCcbai8y87ujNCUAt4=;
        b=wVCuM1zp7JsGGhkZH/yjGoZgARixeR5YqyccgylpKW67S8khHuiJxfArrm/ofmQKA7
         GNqy55LhzsqnwnUJpCrJHvuweLuTUknwEC7jkjYwtOvwQnJ+ZywQ3Rxp+/ZvC4PQLKpX
         yuij9gKJ+29OkIV3lzqGjFrvrArDoymhTKzcMoM6cG4yeMgnq4lEQIJ8TLi1YllEHSG2
         YCzCkSjD+hmY6KBPJxJrgYqZQn/IrKKLvBv1z4sW75ZduzYHLUdS9tAH9H8VtrfN0PG7
         6E4jSUDcV8CAmrLYrRNjocgX48mhNwjansjnWFym4jU9LcyraRXZA2bB2ehc2z4WkpK5
         5O3g==
X-Forwarded-Encrypted: i=1; AJvYcCXPPsdGRlM7LyJxsn5l9GAynUsmE22QN29xDIoiPx9lWIrO98vTQez6R865RfdU+1vfRN/BhR2PsVgoKaO5g/zFDTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCEisd5JjPN6Q4Y1ZG7umcyzg5hy9BK5VknY7UZJ63B6PV8GkU
	D9AEmK+Yali+kb0jAmLIqMG+/CgWQczpQPjr4HDdrhdNobp0hw6pCCgtLpUPO94ImadbKQSxpoJ
	5bFRYPLQhNW+DPGmr3/Znq2WkjemFIoNM2HTP5zRK49G2+xXceyQ+pPuKEwNA/JX4upkJkFrqoQ
	==
X-Gm-Gg: ASbGncsB59e1QQ+/3lOJTNB8LZFGCCXWBLN3YZDWKpthVv0Ty2tMJ43NaF7EgTw8LKz
	GfZi8bjgl6X135XLimdC2EDC3Ayb+PZgfDhmoS/OV5y8v57UoOYhYFBxnSsl6g+LG1yhupDyI2J
	1pKDL2h3hnZ7TeH8+ulbzpXXoTsWba90Nd/6cNgEPoKHhQu4sHSi840sxCK5KgsN0nPVk1T84xq
	MS90eo09ZLw3eG6Pg8cgZoAF+PoRiUid+jzt3TnahijKqENwCR4ylVKtPWU/h4kGFcafaYprDfy
	nASvOjBZGZnOHRZJulTMvJit9P6wNrHe9FrTYwtZHjdRmClffwpdH2kvNgB6lbWanDTt1ycGYEY
	I5QeiN8uQCkqI9vSQ8s9Sy2SY8RsgSJedcqzUppein5aafis=
X-Received: by 2002:a05:600c:4e54:b0:442:d9fc:7de with SMTP id 5b1f17b1804b1-4533caa21d9mr104115555e9.22.1750161591839;
        Tue, 17 Jun 2025 04:59:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKcix1FzFhSz1vLXa92huVqpQa/bFyDvxo6Bnl1VEwl2ZJ7gHIUtu3EDoH+eOKHJrUZ+NJUw==
X-Received: by 2002:a05:600c:4e54:b0:442:d9fc:7de with SMTP id 5b1f17b1804b1-4533caa21d9mr104115345e9.22.1750161591460;
        Tue, 17 Jun 2025 04:59:51 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f31:700:3851:c66a:b6b9:3490? (p200300d82f3107003851c66ab6b93490.dip0.t-ipconnect.de. [2003:d8:2f31:700:3851:c66a:b6b9:3490])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e14fc98sm180074115e9.29.2025.06.17.04.59.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 04:59:51 -0700 (PDT)
Message-ID: <e77b2fb5-f2ff-4c11-8b3a-6b5ee89738e0@redhat.com>
Date: Tue, 17 Jun 2025 13:59:50 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 mm-stable] uprobes: Revert ref_ctr_offset in
 uprobe_unregister error path
To: Jiri Olsa <olsajiri@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Andrii Nakryiko <andrii@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20250514101809.2010193-1-jolsa@kernel.org>
 <aECseBOkQynCpnfK@krava> <aElE4r21ZYhLWTZz@krava> <aFFYTi4FcKE7rmlI@krava>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <aFFYTi4FcKE7rmlI@krava>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XQ9WYOdsnG-pfTWB71gXx4BWzKkmCJRa6ibA86N3I6M_1750161592
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.06.25 13:58, Jiri Olsa wrote:
> ping
> 
> On Wed, Jun 11, 2025 at 10:57:08AM +0200, Jiri Olsa wrote:
>> hi, ping ;-)
>>
>> On Wed, Jun 04, 2025 at 10:28:42PM +0200, Jiri Olsa wrote:
>>> On Wed, May 14, 2025 at 12:18:09PM +0200, Jiri Olsa wrote:
>>>> From: Jiri Olsa <olsajiri@gmail.com>
>>>>
>>>> There's error path that could lead to inactive uprobe:
>>>>
>>>>    1) uprobe_register succeeds - updates instruction to int3 and
>>>>       changes ref_ctr from 0 to 1
>>>>    2) uprobe_unregister fails  - int3 stays in place, but ref_ctr
>>>>       is changed to 0 (it's not restored to 1 in the fail path)
>>>>       uprobe is leaked
>>>>    3) another uprobe_register comes and re-uses the leaked uprobe
>>>>       and succeds - but int3 is already in place, so ref_ctr update
>>>>       is skipped and it stays 0 - uprobe CAN NOT be triggered now
>>>>    4) uprobe_unregister fails because ref_ctr value is unexpected
>>>>
>>>> Fixing this by reverting the updated ref_ctr value back to 1 in step 2),
>>>> which is the case when uprobe_unregister fails (int3 stays in place),
>>>> but we have already updated refctr.
>>>>
>>>> The new scenario will go as follows:
>>>>
>>>>    1) uprobe_register succeeds - updates instruction to int3 and
>>>>       changes ref_ctr from 0 to 1
>>>>    2) uprobe_unregister fails  - int3 stays in place and ref_ctr
>>>>       is reverted to 1..  uprobe is leaked
>>>>    3) another uprobe_register comes and re-uses the leaked uprobe
>>>>       and succeds - but int3 is already in place, so ref_ctr update
>>>>       is skipped and it stays 1 - uprobe CAN be triggered now
>>>>    4) uprobe_unregister succeeds
>>>>
>>>> Fixes: 1cc33161a83d ("uprobes: Support SDT markers having reference count (semaphore)")
>>>> Acked-by: David Hildenbrand <david@redhat.com>
>>>> Acked-by: Oleg Nesterov <oleg@redhat.com>
>>>> Suggested-by: Oleg Nesterov <oleg@redhat.com>
>>>> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
>>>
>>> hi,
>>> I can't find this in any related tree, was this pulled in?

@Andrew, I assume you should pick this.

-- 
Cheers,

David / dhildenb

