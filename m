Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F72C3DEFF0
	for <linux-trace-kernel@vger.kernel.org>; Wed,  5 Aug 2026 19:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785957327; cv=none; b=nCAhyjw9OMJ53C6auK5zDlQckNBAFDGbU92rWDgBsUJVoOEOdBdjyhbhMq3+vl4gCRhH5RCw6qZnJraiOH+P627uONMsRGZ+N9tvWlKQZxZQVDOpXKynMYjuHyefyrhUwvKUCi4ygadWCkB3AHWxjBBwVk4WnBxG09oGrOs07EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785957327; c=relaxed/simple;
	bh=qBOhmuZWnCOO6cEqbrIcWSbSvOFI6cPahRdg3JWl7sI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHDqX3pvKRyrDTytFOXT55RtK8uGM2zHhbWyuDc3nyWzDNLbtiKzw8zFvL8R+BAR17gqxtHM1mwLBAyxnio938N/3/6Gej7359CasYITz0C6BU4jTE3c2LL929gxcG/UlO/QTlWg0VTDfI1wGnRh6EANJiyZLDd/qwKl7otRnIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t1P2GeX3; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t1P2GeX3"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-495635a85d2so11963645e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 05 Aug 2026 12:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785957320; x=1786562120; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IgDUz1mwBjwKeSTBZbWMAC274nF2JO5FiqJPNXQBRTE=;
        b=t1P2GeX3ldsmSWITj4rxwbIt+irJ/ksc8+tAWvgMpRSM1oRkEit+t7MlLBT2+0LkAF
         A+JTOYcPlj64iM7zI9Y8yvG9FMkxMPV9wH3trRQxo6yq6f6nvCEIJaTzrLiGRRUy2rcx
         EI11VJ5Jl7w3wViKIeJERSbouokZ27JCd0GwKwcwsoKhLlY912CGsBzf63hyi8FBbwIg
         QGzkbueBR92ng5D9p9Z6WJ4R+tquhPprdVpYhBWJj5VsTTmS4rK5dwflnP3fVHJlhn+M
         AFnYwJ4G/rPxwMt9lww+Y90IqVzWD2Kay0oi/uidk2JPsOyuMy23Aua4kRyvFraiR/bd
         f31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785957320; x=1786562120;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IgDUz1mwBjwKeSTBZbWMAC274nF2JO5FiqJPNXQBRTE=;
        b=shhumbdi+LJ0e+6cI/+70RPkfRU/Z1drLDRsgFVrToBJCQ7H9ZNAVNxan0tLziq4VA
         ghIiLpnHy/uKl07zSjS9eN6tsdeGEZgROv0u5QbFnkcLLuS+YHqrOfilNeXHYscPNQNX
         II95kAUlbbpZtIOHMu1da2zOjaZ4ap4oc/y3lUe+R1GjuTTuO2Hna9kxwm2pzWOzwaLk
         8wVk0WgD5drA7Tvnplb71afHQ278R5BB4dMbmllWUyHffAhcZcVn9IvUlI45V7a31fQH
         eVkWCM3pmO02v6yzhi5FIrl/4f8FbyJUUJ6f/RipTj/dfCoWEEFqiNWJyl2QfrvPSM0I
         RCOQ==
X-Forwarded-Encrypted: i=1; AHgh+RoA5TyQW2qPqnKBPIJUrraRANmu3ohKcnyl4qNLbSIhF47cmE6uo6wGuxwc4FIwKJIjQln7jvUS2XAVQXMDU5o+WGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkeIUY8R8IYi+QARD3IFpZOCYlL9tpbzzwfFjWKXNv8lEH7k1c
	c6r+XLu8ihtr+HO7AaXPM4lZ2MxMfHHOezflrm4dSwXcmoP2c1M5LlShRZDNs3ASKQ==
X-Gm-Gg: AR+sD12y+wLufdhLvrla8nuE7apWlB2zW4MmQHUdpkJa+h9wYrIVZvVotagYwCIovva
	eWw7SaS5v9FSsToxeCTFwwVBXynkKGKsP1tkIBDGncaJkSWWFjWmyUtoI5wmo7z+kF6MoMSUHI1
	/An41PlsK19GG3h0GhNdJGkgeQ8ymMLORVEJs33yYNA9+5NbQZsVvrK15HJiFfzquedfd8jxytO
	luc9lVh5ooyKZwNzVXRnLwPY1QCKsbHMYzmSJ7pcnRbVb8VpCznJPTfeU7EC/gC2PcYIreckGgC
	MOPSGoXmAxohDilZQ8QvE+gov2T4WmApuMhzbRtygqY0v9GV5n7fSmwnIMa+UgCZH02HRHv4Dix
	hlVJ3Cf+nOkjFhyH8ZzPnEeRUwhaO1DkoMDNgYMgC62XemcDVRHuKphBoHJ30TMH1KvAQM2E1sH
	WxODtg7ammPhNztf6TFQBX86E+WNYRUM+TB1cuC5A/ghsEgpkrUvbeI1CjAsCQ0/iXkJ1hJRY3o
	nLOipa9gfhHltiKjQY733Q/FrH69us3
X-Received: by 2002:a05:600c:138a:b0:498:943:ccc0 with SMTP id 5b1f17b1804b1-4994e714d8fmr115961675e9.6.1785957319636;
        Wed, 05 Aug 2026 12:15:19 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e99319bsm59638565e9.3.2026.08.05.12.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 12:15:19 -0700 (PDT)
Date: Wed, 5 Aug 2026 20:15:15 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com,
	linux-kernel@vger.kernel.org,
	syzbot+e0cc44465d6bae735679@syzkaller.appspotmail.com
Subject: Re: [PATCH] ring-buffer: Prevent subbuf order change when resizing
 is disabled
Message-ID: <anOLw1kOAjMX7Bfc@google.com>
References: <20260805153225.2096152-1-vdonnefort@google.com>
 <anNmo6KLI697zYJP@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anNmo6KLI697zYJP@google.com>

On Wed, Aug 05, 2026 at 05:36:51PM +0100, Vincent Donnefort wrote:
> On Wed, Aug 05, 2026 at 04:32:24PM +0100, Vincent Donnefort wrote:
> > Because ring_buffer_subbuf_order_set() frees buffer pages, we can't
> > allow it when risizing is disabled. A non-consuming reader is at risk of
> > use-after-free (rb_advance_iter()).
> > 
> > Return -EBUSY on resize_disabled, matching ring_buffer_resize()
> > behaviour.
> > 
> > Fixes: f9b94daa542a ("ring-buffer: Set new size of the ring buffer sub page")
> > Reported-by: syzbot+e0cc44465d6bae735679@syzkaller.appspotmail.com
> > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> > 
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index 8e2485bb3aa8..414bca2121a7 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -7358,7 +7358,7 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
> >  
> >  		cpu_buffer = buffer->buffers[cpu];
> >  
> > -		if (cpu_buffer->mapped) {
> > +		if (atomic_read(&cpu_buffer->resize_disabled)) {
> 
> Ha, my bad I forgot that mapped is not just "user-space mapped" but also
> "range-mapped". 
> 
> However probably the best is just to record_disable range mapped buffers in
> rb_allocate_cpu_buffer()... especially ring_buffer_resize() doesn't use
> cpu_buffer->mapped

I am also looking at the other findings from Sashiko. I believe some are legit.


> 
> >  			err = -EBUSY;
> >  			goto error;
> >  		}
> > 
> > base-commit: 075b74841bd0065a3bda3440873c747938e69b68
> > -- 
> > 2.55.0.571.g244d577d93-goog
> > 
> 
> -- 
> Vincent

-- 
Vincent
