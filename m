Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3C647FAE2
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 14:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786629651; cv=none; b=Gg0Lx3Wph8PodIeg4NqOt3IQwjkldyodG+aRyzNw9L/gwz7JnfOANspWnW3+tF5vBgmHVQqkIofSucxSkVWfobNMmJMDjACbVs54US2SsyjvpTCvnwVxL/ia1bEeXihH5om/DoFbM1LBZCwgEugdKurExpqNq0rg7b2uxVzFHS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786629651; c=relaxed/simple;
	bh=ByVOLrxXDXIZLPsH2sEoxKM1tFI3pn7z95TDyU8F7dA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gnb89rsSMs6n7eSyKNu/NiH5OygDoMlKiGg+WgTJejPH1g6H1SdpvNxXEfBEBz2eR+d9kv+JnQKDgCjkJ2mYsvNsYzPWlj43lzDCO5jkEHcDJN80anCU/Sd/KbAepYU4/D6FtvhAxSTuzobZ7wKWz30q6VMuxZwGl6YdBF0aSIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ClH/38vA; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ClH/38vA"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47fecbb7000so419064f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 07:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786629647; x=1787234447; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sKTp0eszm5C06QWX3K5JbiwW6wstRSEVWVpucOrqN00=;
        b=ClH/38vAs4Mdq6bYYWGvTWxGsKH9qoB3Oy+P3T5/I9FI/jFRYyrKvJbQtJNpDEC8Op
         6nQqBA8ihLoNiN+77kIMimqxv5ax2UQ4F7PX8hrZ08huzfbkuyP4rMcB5UBxvugKmdmE
         c/MXHRP22GHSAyNo+fwm18ADABs7MN7Ivdw8WhGwFUL95gEpYP0qTq53gP5hbrwDzV0a
         Bz1d2eN9zL57hUzxYe/4nLRMbE3IyNw+DMY6hdLPn4reOOcQgvZJBUBq+F0D8QfWoccW
         /89BxCOOEL7cHjpZfc76fIk5tF9wp4d44BCrTEIUCYgyT7wcHsd1uczuydz9m+Tbb6BJ
         MCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786629647; x=1787234447;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sKTp0eszm5C06QWX3K5JbiwW6wstRSEVWVpucOrqN00=;
        b=ID1dWdl55llBcNkXHeTwvR0FK9Lvhu8iR+o7rCR2C+RQzaP/OPTvGkUTYaGcuN7TQu
         H20FcR7+7+F4A2fenQG4n+v3qat6iWI4cFWFHaoJrJxr9n+YiXHEzrJVqXMM0TiJTQtR
         NkMZP5ZLc4By8xH0rxmgaT7MZbWUOUa4CFpiFoqGzkjcTpg+Oemi5Uvbahntrry2QBNy
         KzD93GozCHIPIsAokyU/kLzuj7QOtKJ9aUqz1A+/byJ3cCQfum+xb08aoYR9AbF81VwD
         gQgna/ixZTjfFhHNTweS6jOLD+L7rv8jh5csXDigq/GeyelIJa5j1XkbCNSduS+KxhvR
         wASw==
X-Gm-Message-State: AOJu0YxobuWDfWvhvUU77kWzAE72n/CU/HbUcx58FgkjlQGKw/pOFpQg
	Qgwv31vZgqplhVDHaQ2JveHOU//pwQPFjJ6bxhowniogil9ORNOnYd4Vr7TNVrrbCIp/1cCOxh+
	ZTC7/DA==
X-Gm-Gg: AR+sD13ydXS0kVtA1y+5o3fbBdRPdmru31iRqNoZxAQvKoN+2FB9dTM8AUHI3W+/S/S
	wA6RK0L9Szw9ktNdrp8zrOPzJcutGKa6j7UmsTGxf/oa02dd1g7ia+LXuLAP0PnZQuCHgEM4bw1
	rVC2WnAynOCb5IzcRxHWWQ/A8WCCWRtaFTJzJ8MYLua3HZohUJKejjDQCx8faEvJpTsNfRy9sHw
	6Bs59tlhKSuioeztn7pbQKoifCqzNOdclCN061rjN8OjoF7G8fpDgHO1SQxKEt8SUfQY1ntIzIU
	t3RiFwk9oIGih8jb4t3/ooknPiWIoTLHlPh50vcoWZKJBSnG2+XqKqO1VE1OJQY4nt/g+uJzuO7
	AvtPGFydm//GBIOwDZibQFuPcv+cJKw6T8ivSy9lqwMWR0dwikisTP6XZN7sJqfcI9SNftA/Spr
	qNe06lJDo03MJnaABY4d/+Prk+eujTj8ct81HflU2krTj3gj7bkmFfSLWgNSXepSV44hTQXzFd0
	uhCv0bbQM/fNhz97WxrfxBL0jKg31bl
X-Received: by 2002:a05:6000:41fa:b0:47f:d0fb:ea33 with SMTP id ffacd0b85a97d-4815a00d4a3mr9297074f8f.20.1786629646106;
        Thu, 13 Aug 2026 07:00:46 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a5b6616sm7409290f8f.25.2026.08.13.07.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 07:00:45 -0700 (PDT)
Date: Thu, 13 Aug 2026 15:00:41 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 05/18] tracing/simple_ring_buffer: Add support for
 compressed length
Message-ID: <an3OCb8Aa1nQ9jD4@google.com>
References: <20260812161340.2417322-1-vdonnefort@google.com>
 <20260812161340.2417322-6-vdonnefort@google.com>
 <20260812164242.085961F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260812164242.085961F000E9@smtp.kernel.org>

On Wed, Aug 12, 2026 at 04:42:41PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] The patch unconditionally introduces `type_len` compression for small events and hardcodes 4-byte alignment, ignoring `RB_FORCE_8BYTE_ALIGNMENT` and `RB_ARCH_ALIGNMENT`. This causes payload truncation and unaligned accesses on architectures requiring 8-byte alignment.
> 
> Pre-existing issues:
> - [High] `simple_ring_buffer_reserve` lacks a bounds check to prevent `event_size` from exceeding the maximum page capacity (`PAGE_SIZE - BUF_PAGE_HDR_SIZE`).
> --
> 
> --- Patch [5]: [PATCH v5 05/18] tracing/simple_ring_buffer: Add support for compressed length ---
> commit 661f4dfe638155c632fb481b814114210260a54c
> Author: Vincent Donnefort <vdonnefort@google.com>
> 
> tracing/simple_ring_buffer: Add support for compressed length
> 
> This patch adds support for compressing the event length into the event
> header type for small events in the simple ring buffer, saving 32 bits
> per event. It enforces a 4-byte alignment for the compressed length.
> 
> > diff --git a/kernel/trace/simple_ring_buffer.c b/kernel/trace/simple_ring_buffer.c
> > index f4642f5adda33..1a97d17cca246 100644
> > --- a/kernel/trace/simple_ring_buffer.c
> > +++ b/kernel/trace/simple_ring_buffer.c
> > @@ -207,7 +207,15 @@ static unsigned long rb_event_size(unsigned long length)
> >  {
> >  	struct ring_buffer_event *event;
> >  
> > -	return length + RB_EVNT_HDR_SIZE + sizeof(event->array[0]);
> > +	if (!length)
> > +		length++;
> > +
> > +	length = ALIGN(length, RB_ALIGNMENT);
> 
> [Severity: High]
> Does this hardcoded 4-byte alignment cause unaligned access exceptions on
> architectures that require 8-byte alignment (where RB_FORCE_8BYTE_ALIGNMENT
> is 1)?
> 
> It looks like using RB_ARCH_ALIGNMENT instead of RB_ALIGNMENT would prevent
> these exceptions.

I will add support for RB_FORCE_8BYTE_ALIGNMENT in v6.

> 
> > +
> > +	if (length > RB_MAX_SMALL_DATA)
> > +		length += sizeof(event->array[0]);
> > +
> > +	return length + RB_EVNT_HDR_SIZE;
> >  }
> 
> [ ... ]
> 
> > @@ -259,9 +270,13 @@ simple_rb_reserve_next(struct simple_rb_per_cpu *cpu_buffer, unsigned long lengt
> >  		time_delta = 0;
> >  	}
> >  
> > -	event->type_len = 0;
> > +	if (length > RB_MAX_SMALL_DATA) {
> > +		event->type_len = 0;
> > +		event->array[0] = array_size;
> > +	} else {
> > +		event->type_len = DIV_ROUND_UP(array_size, RB_ALIGNMENT);
> > +	}
> 
> [Severity: High]
> Can this unconditional compression cause payload truncation on architectures
> requiring 8-byte alignment?
> 
> If RB_FORCE_8BYTE_ALIGNMENT is set, it seems the core ring buffer reader
> (ring_buffer_event_length) might subsequently subtract 4 bytes erroneously,
> leading to data loss and potential out-of-bounds reads when parsing the event.
> 
> >  	event->time_delta = time_delta;
> > -	event->array[0] = event_size - RB_EVNT_HDR_SIZE;
> >  
> >  	return event;
> >  }
> > @@ -284,7 +299,7 @@ void *simple_ring_buffer_reserve(struct simple_rb_per_cpu *cpu_buffer, unsigned
> >  
> >  	rb_event = simple_rb_reserve_next(cpu_buffer, length, timestamp);
> >  
> > -	return &rb_event->array[1];
> > +	return rb_event->type_len ? &rb_event->array[0] : &rb_event->array[1];
> 
> [Severity: High]
> This is a pre-existing issue, but does simple_ring_buffer_reserve() lack a
> bounds check for events larger than the maximum page capacity?
> 
> If a caller attempts to reserve an event with a length exceeding
> PAGE_SIZE - BUF_PAGE_HDR_SIZE, simple_rb_reserve_next() will move to a new
> page and set the write index beyond the page boundary. This would return a
> pointer that allows the caller to write out of bounds.
> 
> Would it be safer to validate that length is smaller than the maximum buffer
> page data size before proceeding with the reservation?

Right now we just do not consider such huge events as possible.

-- 
Vincent

> 
> >  }
> >  EXPORT_SYMBOL_GPL(simple_ring_buffer_reserve);
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260812161340.2417322-1-vdonnefort@google.com?part=5

