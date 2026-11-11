Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794403941;
	b=V6V8zlK4YUpClGhXy7r+eNWZniFQHaCE7945kY9u4HjVJ3mZIC+8Ne4mYuSMCjOg3CXJ
	 4SRjEru2lbcIcHMdY8Pn+4AxQ1GTIwBwcBBDDLS5MVHNTB2ZDh9CNX4f4X3l0ry1f1wWf
	 +//R1l3SQGvEh7TVxIjAt21kgIOIovjAyu/vt01b/o1isjtnM3iOQPN29GgvTap3/cAfK
	 mHvx7o8QBR+T476Yd+KVLhWJSv9gtH7wa0IVtSx8o+IHHnyTTTmBJxyToMNTs7oSxSoIz
	 UZZjVHPYpSEjKYs8As7gc9JfvfYBkRhoK0sNrToKVDn+TCSZGstCmBsYfwWixDAoVGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794403941;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=NVTyTjSD88ZslZBZa+qkaw0eEzwB/Yf3D99qESsb/J8=;
	b=eyjKl2PWHc3IqMdsYrVYFVgFhp7QDNjOhkHTdTCiGgrunjL3/iiFcaowT/GOtlHhgp5w
	 RmJrQGBNcz0AWMou3dx0bAEaDve2IcDVuAnYHyyj+MBh6FIVpgCEHDaXw1Uuf4r4rVy8i
	 YMM2e+1tYg6IqUtLg7dwOuZ27LOYjYSXo+0P9358vIH3z+zV4TQj1TFSvIGG3KtsJgJhJ
	 De+EJep+7qcebIxY5syh/EgSqes335ZDBcXFI/QCNggka2Q62NBs/aL7AN6isP9Ud/8NN
	 sCUZ1bwQc0qUoIY9MIqMal/2leGyPdPZh7sz+Qzv1eOx4vvkzc0ak81JuUayk2BJ2sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UlO7TVsp;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E50606A33C
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Nov 2026 13:32:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04E50606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UlO7TVsp
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a214af2076so23509675e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Nov 2026 05:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794403939; x=1795008739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NVTyTjSD88ZslZBZa+qkaw0eEzwB/Yf3D99qESsb/J8=;
        b=UlO7TVspUXSlocLLHY+xdNnTQFFzFI+0cINbb6Sg1Tn4yPiBCKR40++aZ4ooCKnCLV
         EfMcGds/wjr+WCLnHyUwfHvHSDhIHcRS+mQKDfTZkRlna5eTjk59Rr6CO81D+V2Aah/V
         WHODxTeVpICKMxLa5TqKOWGPiz7tHe8XdUGS0of9wMQXVB9c0XcwLVRHoDZDQ+v0/gFO
         hfAGITQFUVIZR7cJuVCwqF3mkrwZHBrVUtrgnp6RwsJ/6vG99PKxoysj4QELbPxe0+Mk
         iOByEbttPqohzAgTeNlgYnElPNG48arMMDUg8SafT7UYbFNfjdVgbRBwOtYOJA4r1irH
         WF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794403939; x=1795008739;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NVTyTjSD88ZslZBZa+qkaw0eEzwB/Yf3D99qESsb/J8=;
        b=KNccuugA5BTufWFzolvhXZ0Ufn3nWTrRi2Z5PX8RXRYtxIGibLH0jlEOpAKmCFr88r
         fPiz3V8GmngqG4LaTu6KVeGZc++13cfoxjFgczzfyREwsYbuEOmw2uC4FKMBX/RiMC0w
         Pjk8imc5V1oC4gWqqJ6dNP/50jVvrob10A/Nr/RXAAn/gH4BGgPmrGoYCmCx9SbJAAmV
         SDX5fAz+oKGT5O69dYdB4xvXY/oxZy3jwvZxWqnAtoXYH56ZqukapG1ewxUEUElp1hhE
         F6Qmycvw2hyfThAqs7mCASoTlL3WK9l/QHvaWblNW1gZVSHhgKcPEH2uCe85utP00ihA
         eZKQ==
X-Forwarded-Encrypted: i=1; AL+hErEHiNkhDSCxUYduND+xGg2/PVZm0olx8KRvuy2h9JJmrduJkEC/oMljElMzeSirYjnJKEwd5wVTv5sg4FDwkIK0MJk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8/g0L7k0cbtw5pnMYuisJCAJJUsOut8nsE32f/CPTSF4QtLsot
	YVVvvsE6a/tYRD0z+2zOdFZBmAlhqxf6KJ5IFxlsV8t9D8VwLJhnldF4ZoZtb0us/RvJweQcnvV
	M8zq0gw==
X-Gm-Gg: AYBFou3tas9GoWxHR2f1YS7YcULhTr4wja8M2kMnZK+0WxAy2zWqld9hffxSLK0iC2y
	uWkaUocpC4HmnjJfBrUUG8oEyUI647p0ApURdcv5rOq45tnmqtt54eVbe90NcNf24r0h6zPLYxZ
	WmAoTPBKraQV7jbP0LEQoyl2oRw8JP+hyHBsvsSYzZ/DFpQjk54eF+O8BgqFSeTVDUEQSM92Nut
	SFFgCmvPCc4D01q3KYzyCWqL6y5dP5FZcAPHeag9B1/+Pe9PHTZJZzdDCVJGBl3ldO69R3DNP0j
	rODVkol4NdxIpRvBOp0rh7YFD7Sf4A3Hc7vpNhwPbqe3xKy1kDuME7GVKq92mekbfGguVEeAOrw
	ai6qOv78gNvO7J5uoc6F3wL5zHRJTMRpUv4T6grnWwjmWjazh8kA6ng6NNtU86wtU5xDWon3RKP
	wTMCSD+wSe0dnJVQDBry2hPShk0Up86Z6i04SrqLaPeJ2gijNojRjctZTJaTCJ2o9Sl/DMg7P1O
	CWQ/dAxYNdwI0dgz98iYd+hMuM9Ji27RYnrVD0usDjHWXKGLyAm3zJtmzNsQvMiwu3RA5uTKcgC
	AacgJIcsMlbgJxajnO5HEE8ifdb8ortW552t94ZvIItCQFYItn7jWv5QbvQFz5eq4g==
X-Received: by 2002:a05:600c:6214:b0:49c:fa20:cbfd with SMTP id 5b1f17b1804b1-4ba09375bb4mr41985575e9.20.1794403938536;
        Wed, 11 Nov 2026 05:32:18 -0800 (PST)
Received: from google.com (0.182.34.34.bc.googleusercontent.com. [34.34.182.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0951fe22sm64107395e9.3.2026.11.11.05.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 05:32:17 -0800 (PST)
Date: Wed, 11 Nov 2026 13:32:13 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Breno Leitao <leitao@debian.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Steven Rostedt <srostedt@redhat.com>, kernel-team@meta.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] ring-buffer: Handle a reader taking the new head in
 rb_handle_head_page()
Message-ID: <avRuXVxVrp-Kjiqj@google.com>
References: <20261105-ring-buffer-head-moved-v2-1-05da40cebccc@debian.org>
 <20261105155729.0f9c7e4d@gandalf.local.home>
 <avGQnBjyUMwunknT@google.com>
 <20261110025202.78c8c03a@fedora>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110025202.78c8c03a@fedora>

On Tue, Nov 10, 2026 at 02:52:02AM -0500, Steven Rostedt wrote:
> On Mon, 9 Nov 2026 09:21:32 +0000
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > > The issue I think you hit was that we have two HEAD pages, when interrupts
> > > come in. That is, we can get a state of:
> > >   
> > >   --> subbuf --UPDATE--> subbuf --> subbuf --HEAD--> subbuf -->  
> > 
> > How we can end-up in this situation? The cmpxch will only swap HEAD for UPDATE. 
> 
> The cpu_buffer->head_page is only updated by the reader, when it did its last read.
> 
> Let's look at it one at a time:
> 
>                               cpu_buffer->head_page
>                      tail               |
>                       v                 v
>   +--> subbuf ----> subbuf --HEAD--> subbuf ----> subbuf ----> subbuf --+
>   |                                                                     |
>   +---------------------------------------------------------------------+
> 
> Then the writer moves the HEAD page around the buffer while there are
> no reads happening
> 
> 
>                               cpu_buffer->head_page
>                                 tail |
>                                   v  v
>   +--> subbuf ----> subbuf ----> subbuf --HEAD--> subbuf ----> subbuf --+
>   |                                                                     |
>   +---------------------------------------------------------------------+
> 
>                               cpu_buffer->head_page
>                                     |          tail
>                                     v            v
>   +--> subbuf ----> subbuf ----> subbuf ----> subbuf --HEAD--> subbuf --+
>   |                                                                     |
>   +---------------------------------------------------------------------+
> 
>                               cpu_buffer->head_page
>                                         |                      tail
>                                         v                        v
>   +-HEAD-> subbuf ----> subbuf ----> subbuf ----> subbuf ----> subbuf --+
>   |                                                                     |
>   +---------------------------------------------------------------------+
> 
>                               cpu_buffer->head_page
>         tail                             |
>           v                              v
>   +--> subbuf --HEAD--> subbuf ----> subbuf ----> subbuf ----> subbuf --+
>   |                                                                     |
>   +---------------------------------------------------------------------+
> 
> Now, I'll break up the update part:
> 
>                               cpu_buffer->head_page
>         tail                             |
>           v                              v
>   +--> subbuf --UPDATE--> subbuf ----> subbuf ----> subbuf ----> subbuf --+
>   |                                                                       |
>   +-----------------------------------------------------------------------+
> 
>                                  cpu_buffer->head_page
>         tail                                |
>           v                                 v
>   +--> subbuf --UPDATE--> subbuf --HEAD--> subbuf ----> subbuf ----> subbuf --+
>   |                                                                           |
>   +---------------------------------------------------------------------------+
> 
> An interrupt comes in and moves the head even more.
> 
>                                  cpu_buffer->head_page
>         tail                              |
>           v                               v
>   +--> subbuf --UPDATE--> subbuf ----> subbuf --HEAD--> subbuf ----> subbuf --+
>   |                                                                           |
>   +---------------------------------------------------------------------------+
> 
> Now  the reader decides to read again and starts between the UPDATE and the HEAD
> 
> 
>                                                  cpu_buffer->head_page
>         tail                                              |
>           v                                               v
>   +--> subbuf --UPDATE--> subbuf ----> subbuf --HEAD--> subbuf ----> subbuf --+
>   |                                                                           |
>   +---------------------------------------------------------------------------+
> 
> It finds a page with the HEAD pointer set but not the UPDATE pointer and does a swap!
> 
> 
>                                                         reader_page -----+
>                                                                          |
>                                                  cpu_buffer->head_page   |
>         tail                                                         |   |
>           v                                                          v   v
>   +--> subbuf --UPDATE--> subbuf ----> subbuf ----> subbuf --HEAD--> subbuf --+
>   |                                                                           |
>   +---------------------------------------------------------------------------+
> 
> Now the commit finishes and moves forward and will even hit a blank
> page but the last write is now on the reader page. This breaks the
> entire integrity of the ring buffer.
> 
> Does this make sense?
> 
> -- Steve

Yes, now I spent more time on it, I believe it makes sense. I looked at what we
could do and I'm trying to use a temporary RB_PAGE_HEAD | RB_PAGE_UPDATE. This
link flag is then only converted to RB_PAGE_HEAD by the outer writer. I believe
this would fix the race entirely... However that means the reader spins as long
as the buffer writing is interrupted, which I admit is far from ideal.

-- 
Vincent
