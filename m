Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5477248D893
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 16:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786636988; cv=none; b=Qm44+2KEIQPYQfpBvPI0sbydkNPBIaNqJV03RBzefKc3d9JdaBpg/Djq+DEht4BDUpvn3VB0b+i3CdPg+AlSTHhHfnEpQleHU3YSWqRyD3J7ldFrBTsLZs8Dadcv76d55+O3EPIPjI27znaPDCSkGgBLymp/AUfN9kkmW01TwDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786636988; c=relaxed/simple;
	bh=SKsbIEp8R4pXw1IRNNNSLjpPn2PWGslZn1iXKYSQdXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MRzGTDMUYLV6j+wNM+kKe5Ec6KEl1OhZXuPlIZPjnVoFt6LQnCRFkFcpiIPTgVPXr/nr+41z83MnFkQI1phrnDJLS+yHskujNmRDsEZb4FUyhVYCcorg3FWrweSTHZHaCx+8/RGB7gL9p8QAJtsrZsNnnLTp6+mrtFrBICSqCyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f5sONZsZ; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f5sONZsZ"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47f703a9e5dso4003f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 09:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786636980; x=1787241780; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=treW88TWQM0npumBYWNuqQc/1poh2s7oeF0WGn40048=;
        b=f5sONZsZ+aC7ZKty79joTl8szXH847mnn8p3lB6SrEkdBRpGpj9xp/V45abdHHLhX7
         XU/psne4m1pEkjmwkzIf5jB7tbcPBd3mgBOAa99hciZfYTuRJmwxMq+kdHEuJds5XRr+
         J+vmrqsN0r4AbFZhNbgrJX5AlVMokldZaX2OfGXR8f6kfu+/wY+bc0NZ9pguHeZ1lHot
         E/M5upHKxIIkh4aAKVrFK/y7A8DCCru0lqVJU5kx6z7AgvfLyLfYWUY417soU1hG4QfR
         vTLuYuWL3K2YGj18zKMZOjp49yECkpehCSAGOeyyaKYkgaqEs+mVK8scpixYa3MVgZb1
         4jKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786636980; x=1787241780;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=treW88TWQM0npumBYWNuqQc/1poh2s7oeF0WGn40048=;
        b=E8BDqwD17VuICgHLGtcqFQx+CkhKZecCLPTbLLbgnn64eBxtDvfjmPVAbAxkhMM8nS
         24P6imDkz/43o8TcuxNv5zCqDl821QVKfYxZCKjUJB4epESkvk3/xbP8vWOGLuA3/B7E
         qX2+V5z3YHV+Y7lwpUVOr5L+6XuMJdgKnwOnTfGxGNlV7GBlykyjwg2yWPKO5GpYyBOt
         iOpsjwQdJuq+qViBgV1vsOJ9Rrw87gUNQVQCFu4qf3HkbIhA9fBaNsWsOh9JoJZiZsA4
         4MHIHM/+4/QoQpaPZ7ZQ0DYO6h1hGNHD3G2H/EXAoymiLC+aUXJ3WK1iNN14teEUOLLr
         OrSg==
X-Forwarded-Encrypted: i=1; AHgh+RqeAAUA2Mw7hsnckaL7P4VBGm+SA/AU9Et3E8z46AzdK+4oj6Qc1spMVWcAlgx75K1ycxPVm/DF+lfvkIkNBN+lK5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcEp1i1ra3K0Ug18CzsEGCYQi9wEP9eWrO92DDMIMKOM/t97lh
	tOd1K8CXxXMc/p4x64Q8EgO4B/drnZTnzUZhKygRg1bEm+2AorqjoaS3WuXUrsoU7w==
X-Gm-Gg: AR+sD12vVEHTOlpXkdUxltBRHXzwbjfzmze8H5OhzsvKFvorIboT7HZ//ZEQx+4FrhB
	ArNBgR/lCyCM6u9lAwqxz3Lp5JWBX77oprD2XQiPNrZ/ShG5W2VF1H0F4cRTjM4XbJFo7OEv1QQ
	nEAliHVQU1mPf9zm3lo6MhvL9hK3May/KaN6UBgPFTJ0lWm/ot9sNphUFsQL6Z1PL1SgX1Z/ivG
	VuhtefJ7yDNht5K509PeW7hqR5UthQxUE6OZR03kTM3qfdywugs+m6YfCz6WtyTUOvJj1PG28I2
	6jWgUo71aKHRfCzKVp4Ov1o5beWYnNwJTFomqgIOPmYJiM95aucMUwLczP+Sw13YRP2utwfAtjO
	EFXpkJMiNPJ7UN/pPrgs33Y5DZJP4Cp+o6Av42N7El3YK/Sw6IXMrG5twHoAnkDKAs5PJz42JzU
	N9N+ALqzwd8fUWQy1WLjDm2U/7gUVqJJtgsN8WECeO9PQCeam+MxizwOxGnnunVJsmwGX/YAXdX
	68+jr1lWKUNZ7J67Dr2sAkrsVgrQRp+
X-Received: by 2002:a05:6000:4619:b0:47f:9de0:c27f with SMTP id ffacd0b85a97d-48159c9031fmr11468648f8f.1.1786636979725;
        Thu, 13 Aug 2026 09:02:59 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2b1d9bsm288102f8f.24.2026.08.13.09.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 09:02:58 -0700 (PDT)
Date: Thu, 13 Aug 2026 17:02:54 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, sashiko-bot@kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 01/10] ring-buffer: Free cpu_buffer::free_page with
 subbuf_order
Message-ID: <an3qrsYnQJ7ovwhQ@google.com>
References: <20260813131152.3589632-1-vdonnefort@google.com>
 <20260813131152.3589632-2-vdonnefort@google.com>
 <20260813135439.E42E01F000E9@smtp.kernel.org>
 <20260814004932.4bf99af3fd65e8132142d335@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814004932.4bf99af3fd65e8132142d335@kernel.org>

On Fri, Aug 14, 2026 at 12:49:32AM +0900, Masami Hiramatsu wrote:
> On Thu, 13 Aug 2026 13:54:39 +0000
> sashiko-bot@kernel.org wrote:
> 
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > 
> > Pre-existing issues:
> > - [Critical] A data race and locking mismatch between `ring_buffer_subbuf_order_set()`, `ring_buffer_alloc_read_page()`, and `ring_buffer_free_read_page()` allows `cpu_buffer->free_page` to cache a page of an old order while `buffer->subbuf_order` reflects a new larger order. This leads to heap buffer overflow and buddy allocator corruption.
> > --
> > 
> > --- Patch [1]: [PATCH v5 01/10] ring-buffer: Free cpu_buffer::free_page with subbuf_order ---
> > commit f550c0bfeadcc22eca47316e1820b4d91f6ef261
> > Author: Vincent Donnefort <vdonnefort@google.com>
> > 
> > ring-buffer: Free cpu_buffer::free_page with subbuf_order
> >     
> > When sub-buffers use an order greater than 0, cpu_buffer->free_page is
> > allocated with subbuf_order. Use the correct order for
> > cpu_buffer->free_page.
> > 
> > > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > > index 2667992f0aa29..a3d28b2e2c94a 100644
> > > --- a/kernel/trace/ring_buffer.c
> > > +++ b/kernel/trace/ring_buffer.c
> > > @@ -2631,7 +2631,7 @@ static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
> > >  		free_buffer_page(bpage);
> > >  	}
> > >  
> > > -	free_page((unsigned long)cpu_buffer->free_page);
> > > +	free_pages((unsigned long)cpu_buffer->free_page, cpu_buffer->buffer->subbuf_order);
> > 
> > [Severity: Critical]
> > This is a pre-existing issue, but does this change expose a buddy allocator
> > corruption if cpu_buffer->free_page contains a page of a smaller order than
> > buffer->subbuf_order?
> 
> Hmm, I think you have to fix cpu_buffer->{free_page,subbuf_order} race issue at first.
> Let me try another series to fix it.
> 
> Thank you,

You mean this one?

https://lore.kernel.org/all/20260813131152.3589632-4-vdonnefort@google.com/

> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

-- 
Vincent
