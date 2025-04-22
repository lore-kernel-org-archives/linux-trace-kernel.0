Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D3E257420
	for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Apr 2025 08:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745311742; cv=none; b=YFZ/pZaoNErdQYUHUrWyU1vnrdvyqv/3zsguhm2/FxvC0X++o7s5J2Bbsnth6bUNs4N23KJkus8RrT8JNg1y5lpHvCcRKY52xv0hIOhdyv37fzLLF3nipMuUUKnqRdDRxJkTlU+TRTtq6fPCixZg5SE/B/t1Y0F8o52vdbhSZyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745311742; c=relaxed/simple;
	bh=WoPgBKtAFOU1d0fo8w6Xw61AaQs57lj8/ebxa9R5Uu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X0UK1b9STnngBxiU52scBvXfOHJMiqiOHAp3+JGnPdExakWJu0yN27vMhhI/3+AHp92bMrhzeiWRRv3sZRbBUFWKh+nf1Vs9E6IqL7Wie3W6IjxcVx7Nv7/nzJeqFQrPn+8i0S3C+mBaktF6mDCZnLApNxeroD+7P6KiFh9SNxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y7uiB8/H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y7uiB8/H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745311737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2hQmx2tjREbFqjppMAUgEyDX3dK5Udtyjz5xYSNhM3c=;
	b=Y7uiB8/H2+D/b3nxcFOBV68t+TBrYntIUC36MP8okZZgn0ZPfkec0FjGY01nE5mS4Sgp80
	hmPzAP74Lh9EaF3uqJknnAgRVBZtDc+dmgwA29rotQ2PirtX7WE6sICFA2ax1oYRGthkA/
	ijrTVjGwuk3+qNI0OlBiWIG33Td2mTE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-2YT-cT4bMieHI5lpKJyDaw-1; Tue, 22 Apr 2025 04:48:56 -0400
X-MC-Unique: 2YT-cT4bMieHI5lpKJyDaw-1
X-Mimecast-MFC-AGG-ID: 2YT-cT4bMieHI5lpKJyDaw_1745311735
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43e9b0fd00cso19849875e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Apr 2025 01:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745311735; x=1745916535;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2hQmx2tjREbFqjppMAUgEyDX3dK5Udtyjz5xYSNhM3c=;
        b=dm8CcWzxQWgaHTshcE2OlryiDCvR18weiK3NZbzmWGdvYBFkk4nU9E/qEkyRO4zSbm
         SFrxU4+4oQazgl90FS3Gk6a0k8rDdSyOo+y9VtJbb6cHTzqaLj5BYcHd0sG7NLtM7Q+9
         hE9+zqw1d97H2RsD+NLxusb6nVme5JI93BPF0KZmnaDtRUlRdnXDNj+w4T1ydxmV9JA7
         bd/SHsR3Z+bVHBdQBmDGOQ+LWd/mvcKmc6o3Gmn4qsN04JcLVToZy+tnH7Dqc9qD5LWF
         YkUKm3JazWoM5SAjLf05R7Nz3ZvIK1PAQrjHB5qwrWdP7prlGKhx81tVLcr5HKQi1ZAI
         QADg==
X-Forwarded-Encrypted: i=1; AJvYcCWTwozdGf/et08ktYPK2ih4WCn2mUYL1Wpki3tu01ogw5Xw7rUoheV5k3Hm92WVJ7lBsAkLL7oF6UqlRbQwxTGoRRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1slrYgjnWK/JEBoBd9nrzK9Fky9cnrpbsQoAYHJkeYZHAs5Sx
	JzYmFfCwuLywJne1qlJDYm+Ej5AINhIRic9bEmAi7/n2/yFto9KcVfBQPYp9pTZ5BFTQ3YybAnx
	l5ZAXsZmtCJ8xrW7PnNTx1W4VvNV1azwG1hWPXLR+RsRgYRk1W1qHE+opcwYYgfBDaS0hXA==
X-Gm-Gg: ASbGnctmsThhHnEKm3avADeMAn389k/JozpdpwIBMa0KSIE3C6PuqkxRqSGDPmRpAGQ
	hx5FNtbWYf8RbwiTfqtUWKl8/jvAz+VacXKzp8Xlmb9iTvfA8sXtc5FO2/2o0/Jz275J0Nd9FDG
	IvaaFxSeIcsPl70iIJaMnqvoPTf2Jl9TtvTFK6nIWC9ZKRx0NINdswpZvRy1tjBzMnEBgZPvOyu
	gXBuD/hGLr0FXuKp7PGEUJH28AeYKOZob0Rkr+gbtiqY6qBEoMGIKiEiE3CTjL6EElKnpbogpSd
	H5IakMqXFslL237EqzCYL9hhfUrCgH22j+HDt7JHt6J2S2wvT+yKshABfopsCzz/tCCkilT9Ngk
	CagL5euTheVZFB5Dy0wZ5BhA3wus1bAwiNAzb
X-Received: by 2002:a7b:ca4d:0:b0:43b:c592:7e16 with SMTP id 5b1f17b1804b1-440696f77a1mr131000975e9.3.1745311735151;
        Tue, 22 Apr 2025 01:48:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGKsSKA9Em3JZWKAbH2ydj7LyeGTaEIB2jbmFq1GS+78Pdzj5tZJEcH7x+cEtto/QVHIlfhQ==
X-Received: by 2002:a7b:ca4d:0:b0:43b:c592:7e16 with SMTP id 5b1f17b1804b1-440696f77a1mr131000585e9.3.1745311734757;
        Tue, 22 Apr 2025 01:48:54 -0700 (PDT)
Received: from ?IPV6:2003:cb:c731:8700:3969:7786:322:9641? (p200300cbc73187003969778603229641.dip0.t-ipconnect.de. [2003:cb:c731:8700:3969:7786:322:9641])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d6db230sm166556655e9.31.2025.04.22.01.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 01:48:54 -0700 (PDT)
Message-ID: <ad54fcd5-e893-40d0-bb92-5b6305db5e73@redhat.com>
Date: Tue, 22 Apr 2025 10:48:53 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] khugepaged: Refactor
 trace_mm_collapse_huge_page_isolate() to take folio instead of page
To: nifan.cxl@gmail.com, rostedt@goodmis.org, mhiramat@kernel.org,
 willy@infradead.org
Cc: akpm@linux-foundation.org, fan.ni@samsung.com,
 yang@os.amperecomputing.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, npache@redhat.com,
 mcgrof@kernel.org, a.manzanares@samsung.com, dave@stgolabs.net,
 Baolin Wang <baolin.wang@linux.alibaba.com>
References: <20250418183920.273154-1-nifan.cxl@gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250418183920.273154-1-nifan.cxl@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mK1lAFutM_QukP4RGm7oY6kmPsDGw-Nr9H1bAeiYp_Y_1745311735
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.04.25 20:34, nifan.cxl@gmail.com wrote:
> From: Fan Ni <fan.ni@samsung.com>
> 
> trace_mm_collapse_huge_page_isolate() is only used in
> __collapse_huge_page_isolate(), which passes in the head page of a
> folio, so refactor it to take folio directly.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> Reviewed-by: Nico Pache <npache@redhat.com>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
> v2:
> Picked up Reviewed-by tags;
> v1:
> https://lore.kernel.org/linux-mm/CAA1CXcB06JD9Fp4c7GGU3NHEm4W-aV7TS7JW7eWxshJEM4t2_w@mail.gmail.com/T/
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

