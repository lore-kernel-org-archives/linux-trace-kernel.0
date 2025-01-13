Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F6120458D
	for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Jan 2025 10:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736762997; cv=none; b=pDdwzXxFhILx+ESWEUNft25JIXjugZOrq8aFbm4f32S2iWpAbhryqpOrZNC90NvfpjsTZLGhKhceLqfQIb6v3wSjr+opceOiytrC2DQe26KZikeej0l9Vi94DOtM9N1LOX+Yxocw/8b2K+L4FU0dNFEK1nYiP6flxGq/6czjlkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736762997; c=relaxed/simple;
	bh=1klLOJtCcPRuhBH+Wn/InXYFwXi6yX6Auawn21axQ1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SSBEsLVagC8nxDI/PlRmaUXJDvpur2fMNpp6DHodm+u9b7umxLaqSwMxE97SdIXO03sdV9YOne9RQyq3EQoPwWmu42ftriW/tMQfk9Ha4d5N0K3ROKdpC9ENwj9efGgMYkGJyksrCNnGRDCpyncRuQRJbUqyesLgJj9WYdO2ioc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K7tOPXWD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K7tOPXWD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736762994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UgUwpDhKMZgZxc1OL57CQ0iiOYpTsrgXRg+FEB3T4QQ=;
	b=K7tOPXWD/kdPx3XgjXpApqR+q4xFJVjkml+RiRd8PnQ+iOClpAcLa0Jr7Ns2f/ff/X8g73
	jm3x5HM2e9MuzETcZlJNRWmJXiYRrvz0KgnDhKFHLQ4Tnm6HJg27kX3fH1T8RkUdFZS9m1
	YnNaBhPb4bz6WTonmcUMnVQGXSPIzLA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-N3x07-c1PJ-6UgkdlipEdA-1; Mon, 13 Jan 2025 05:09:51 -0500
X-MC-Unique: N3x07-c1PJ-6UgkdlipEdA-1
X-Mimecast-MFC-AGG-ID: N3x07-c1PJ-6UgkdlipEdA
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385e49efd59so1464969f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Jan 2025 02:09:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736762990; x=1737367790;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UgUwpDhKMZgZxc1OL57CQ0iiOYpTsrgXRg+FEB3T4QQ=;
        b=lVLKwuepPRO4b798UXLcURzhTPRNWylKLisMKrU8YC3WTIFj17KKUtHQVq2Dpk0hD2
         W0Dop+t8ULC4RGcl7tS3jxDEPrlW6j/y1OJSi4R3jfkB+hZm7L3YwzBHL4xArS3zIoPA
         AIy8bLKveqYa+IhIBtm9H8FPYmDyV/EhKbpHwdI/9c/KP1M855F64BMRJlhDi2JMe2Sj
         UvGF203wcbOodxwHPPRmTX5N6oVsrmDXh+bO7zKwxdwF/D6uTZQz4d3VqnBw6JuWsJrM
         T9A1kW6ctfrfdog32BNrqi2RqJWQNOtv1xEKDluTlBXn7HDmi2u3EolqT6s6fw8JbvT7
         jF4g==
X-Forwarded-Encrypted: i=1; AJvYcCUF8qB7HC/fdsg2zbZkvqhnRgd28zBTkDNhOzuSibSVSa7x7BJeHFq+wKd/37YnQddPc/WoR6CtfyTnkWx1Gw5FyUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiWUK1DhvNd1lG7ikKWlRzJJKOxbQkOQkcK7mXQ8BCVoANa+OQ
	5nxSpSFSeOibwNzvWBNx0LKaPNDiFnDzuWyx5xJM5mwV4nryouwa6sqrOaCmYQLzAF+ty8Rpw49
	JmXMjVkNJ0DI5xh+X+QUWmH55TWOLHMt/ZLF2EMyEZhELrX4xQAWXkXPqLmjMBYa7VVs1ug==
X-Gm-Gg: ASbGncsynK2vd9MG33Y47Wk3xaQISftAz6sIS/Yo7/D5DmP1Aw2uaOP6TYhL02AJERC
	57a8U+6c7J+R8HvJwK8M9IuJRNirMfCY9ha5uceHn9iRELBuhJIuMxaY8GoFfzDhrWooQTpeLXp
	TZzXCU+L+5u73/KYsu5XIDuU4755DStNDg0YSc2IgEMv30UqkslcW+NZ+/dkHnqs1QXsAp9BqLW
	hoPn26qMe+u2Fl1GhLCGSZXwbOm/uilHdXjNann7yy2jqL7Y7Fn0rMGIuAEZyQxls6V5EZkq5a7
	F/cx1wNLPHaTQ4k=
X-Received: by 2002:a05:6000:401f:b0:386:3328:6106 with SMTP id ffacd0b85a97d-38a872f6193mr19495398f8f.35.1736762990546;
        Mon, 13 Jan 2025 02:09:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGf8PBG4ERoXmyIOlZpCoTnexxxB9ssDJClNK3ARcXYvdyIb4rTKdDCq1vGjVkp/guTo3l0EA==
X-Received: by 2002:a05:6000:401f:b0:386:3328:6106 with SMTP id ffacd0b85a97d-38a872f6193mr19495362f8f.35.1736762990214;
        Mon, 13 Jan 2025 02:09:50 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e3834fbsm11618939f8f.26.2025.01.13.02.09.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 02:09:49 -0800 (PST)
Message-ID: <04667170-d5bc-4f56-a5c7-5b08a518f2e8@redhat.com>
Date: Mon, 13 Jan 2025 11:09:48 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] mm/mglru: Check PG_dropcache instead of PG_reclaim in
 lru_gen_folio_seq()
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
 <20250113093453.1932083-8-kirill.shutemov@linux.intel.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250113093453.1932083-8-kirill.shutemov@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8rOHTSP7eOHOLv9x2m1Td7vA70pTqSzHPPgIvXOWRdY_1736762991
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.01.25 10:34, Kirill A. Shutemov wrote:
> Kernel sets PG_dropcache instead of PG_reclaim everywhere. Check
> PG_dropcache in lru_gen_folio_seq().

Subject and description PG_dropcache->PG_dropbehind

Apart from that LGTM

Acked-by: David Hildenbrand <david@redhat.com>


-- 
Cheers,

David / dhildenb

