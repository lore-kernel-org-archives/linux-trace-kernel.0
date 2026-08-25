Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4187446C19
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Aug 2026 12:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787662341; cv=none; b=Mw1gImmlwG+IvAJaUVMkRWZxqo3vRC15q9owmqXY/k+zj3knsogA3qYywQQ+IprF4vZ37ouHkaLATTo5HKlEqXmHh9421hjFPO5YLIdIKNP7P44kXm/vC23OUl9riBRUyII3Pc3/DV6o1c9EsL7PaN1YbBbKjWrkGjxuyc5RPzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787662341; c=relaxed/simple;
	bh=AJOQz1WA8ph1ReEu9bpHwzXC3pVsd01wSnP1cQHvM0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQwYI0fZmM6yRrfUfCH0m+D6mwE1/GZQqTTVVzUkdxvsZ8wMpUAQrfT89q/+/HG2zVJFgTiZjbB8JV4NRAzP0rCyJvzxPYtIRiC6q/7PPch4VMNsGOe2koohArs1Udg2jIKwnLRU/pgroapu8xm00yBg8qZj6UOtfT+9qeR5Ka8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KFQpNDjc; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KFQpNDjc"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47f703a9d05so2248102f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Aug 2026 05:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787662336; x=1788267136; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XefrAv44KfW3PE7FNjIrUOwNn6ljxjVjZviYqzfKW+0=;
        b=KFQpNDjc4mRcHYpCOKrtLseWk9xhBpm0kDIrSLKqx+sprHv1NEm/XnA/Ws79yxKtYq
         XKZbt4gf091ijou/U/+KZGou8CE1D2/XPeYn1k5B+I1dRrS1wib7Ujc9FHJrHFLEeKhN
         ay23VYbvFN5dbYZ+ZfQXyfmVZejL1e0jrBoM9UscMhiGLZ9fBRtj5YWVmAnZQX97ElWC
         bMZ0Vv+B3AJIyXKa1jvFjTzma7H9U99fXioFmsWqZLOeVtPEva5D5n9q4OXGrfUheD+4
         XUu+T3HIr7KWNhJUVZmfZyaYp7gQdaNMtoE6HywuoJt1o/Leu8yui14D1lFATH9GKsMf
         vpRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787662336; x=1788267136;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XefrAv44KfW3PE7FNjIrUOwNn6ljxjVjZviYqzfKW+0=;
        b=FbFOh/1QIDK+veEb4SVc1FPTdQPm7NP6CqdJYoKI0skdxVwqN/uuXnb4SWQjaTP1HQ
         oO8XAvK6ZMlPvrzVAsl7O5taopUUetKdcd7xcikoiWxCO8GwLMzhej+VJ/Av2szhvvTk
         CyTP65iF2Eph4fv+o1JDKHporUvrqRGZL7SOrdH+BjhBM5aLYY0zpJK64J/yqjHfToyE
         ANqtZduePN2OELRB6WHVveafCu5TBn6UcIXcUexoTmqu++KQTxEtLpy+sS9MLEg+LqZK
         MoKZ/r4sahk0JH9mCQJJRUyV/PKGvuszFVqUMlnYXCCbv2QTrZw9xE5O/RXd3MYKUgN8
         tMWA==
X-Forwarded-Encrypted: i=1; AHgh+Rr8Pod/IY4P6vPRTc3rPoYzev0dwFAwnZChreNSNTQSyE9yT7PLYLEsP8C7AKx2k7Z6EzGkfp8ypWsQ+LDyf/TRsis=@vger.kernel.org
X-Gm-Message-State: AFuF++mZReYySYOfMt4Ol7HMoRZONzu11uhRLivytLgUsGrwEdrUb+G0
	OkfP3sU8CRZ5CGBgYR6AnPP8mchLXKekfAGYfdUVFBqJtv5c44yZRYvJFA4zaMrC7Q==
X-Gm-Gg: AR+sD12YAA3EZk1F+rQKxHY1OORwKRCR2Qh5WDReq1b1jLHh/WIBcq1YkgY9z9WwohM
	rnGA/qjTUhbm1uuR6ev40iiA1coxoA45xRvCbh/zayOgbXHw/NLUBjqkGzRe4xlx0j21WW5LD8U
	cU0H5ZiHrEI+sCZZRdM86IZ8oDJfncfcVcp7c6gkSY4BBu71uoX9rU3T2N8ZvgM8tLxcvGRhgFC
	no/ZUx+7YCHZ/848/TtxjJ4qxPVXITHu6JsO4h7GJPW1I/Dw86M/tt/isKQHl5upq4eu9wWkk2a
	b9QNVjJzUPKB7NIwzzKeOcL1h6UJK9NKMTXdAJx/8k3tV1JFd6Pg74dg3LHIKx+0z8c40Y+JbIc
	zGJ8zKH54phczVWskdTRi44OI8aYIPc7BiX8jeJYpqgQJ/KtXZvdmhCnKc+zraCZJSK7FtzEIqf
	Jaj5BHsE3UaL4YaB5D/I3kkYzTky2Qnz3bwlmbg3nhqicQrURiTiXDSSkLVBe6e7eujCXB7KsaY
	heeufGAjP/KrkdMwmGFubuCzqYz459/
X-Received: by 2002:a5d:5f8b:0:b0:482:a9c4:bfd6 with SMTP id ffacd0b85a97d-482d9efe45fmr8958222f8f.7.1787662335425;
        Tue, 25 Aug 2026 05:52:15 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482c9c146f1sm11512374f8f.33.2026.08.25.05.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 05:52:14 -0700 (PDT)
Date: Tue, 25 Aug 2026 13:52:11 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] tracing: Fix subbuf resize races with
 trace_pipe_raw readers
Message-ID: <ao2P-4a2aJFYVT6k@google.com>
References: <20260817134750.3909384-1-vdonnefort@google.com>
 <20260817134750.3909384-2-vdonnefort@google.com>
 <20260817140812.2C7D41F00A3A@smtp.kernel.org>
 <20260822110424.346fa3c8@fedora>
 <aotTYT0zE5LNik06@google.com>
 <20260824105315.27377f30@gandalf.local.home>
 <ao1Rn8ZKr5XafWRZ@google.com>
 <20260825084707.4c9cf9f5@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825084707.4c9cf9f5@gandalf.local.home>

On Tue, Aug 25, 2026 at 08:47:07AM -0400, Steven Rostedt wrote:
> On Tue, 25 Aug 2026 09:26:07 +0100
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > 
> > Do you think it is still worth to reduce the window of discrepency between
> > buffer->subbuf_order and buffer_page->order?
> 
> Can you elaborate more on what you mean?
> 
> -- Steve

Something like this.

@@ -7469,8 +7473,6 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
        /* Make sure all commits have finished */
        synchronize_rcu();
 
-       buffer->subbuf_order = order;
-
        /* Make sure all new buffers are allocated, before deleting the old ones */
        for_each_buffer_cpu(buffer, cpu) {
 
@@ -7500,6 +7502,7 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
                /* Allocate the new size buffer */
                INIT_LIST_HEAD(&cpu_buffer->new_pages);
                if (__rb_allocate_pages(cpu_buffer, nr_pages,
+                                       order,
                                        &cpu_buffer->new_pages)) {
                        /* not enough memory for new pages */
                        err = -ENOMEM;
@@ -7507,6 +7510,8 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
                }
        }
 
+       buffer->subbuf_order = order;
+
        for_each_buffer_cpu(buffer, cpu) {
                struct buffer_data_read_page old_free_data_page;
                struct list_head old_pages;


But now with the idea of copying the data when data_page->order !=
reader_page->order, I am less convinced there's any gain.

-- 
Vincent
