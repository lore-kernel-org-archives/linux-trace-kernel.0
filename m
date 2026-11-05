Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793870511;
	b=njOl8HmR6BcucIV7VEgzZooCqwIHIjll5dRCAd6ia7n24VfLjmqYrbPUBqP0G/xj1MUw
	 OarZ2wv1IjhwinecPqu1gfPXMy1wBbS7xEkgfRON1LJPiSWK0HW5Ihj4Xh0vBp7zU6eQQ
	 xD7RyfjHSBn3tt/X3iGirIde3a+H8Q/XXYroB1fspc97FPuKByWbQ+uaQ9k/asu1LSQNr
	 ZhLN68Cq9D2rsxcgVL6UFUx3ezs7a4FxsQPRSPqnyr9QL7/16arZZfWFqZ02v1HWXWcns
	 6uiwfbYOcDk6jtrh6JxkZWJyn6E5yd78LI09MZplG/QDxzHB2CtU8Ako2soT1T71czQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793870511;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ak9x5pn77LYpbrOAvo4GHkz6DjvrPWIAs7V9DJYOPhw=;
	b=SJTD1867wNPnyCEz7BQy9TnCvVG2R43eXpT28l5Zj/+zmigW/RVqVGGGlEUgn6VkgUoH
	 i6vXgFbdGHweiaA+8fPFyt3gQGZcgb3L5h3RpBi+l51YEmVzOsYzzI5oqQdxjnlHpB24S
	 odzbK/Sj0MdrSR/V73qc8dcIEYgKLEhqLJ346tUi7txYmsqMVK1/jAtLNtJ5ZXjL7GRNf
	 +26cM8LfqIu6qg4aXmoUURtviwGQyJchxO34+Auslx5D9DK7klivYi7kjtojLl+u/AYpW
	 HubpnIJz8uN7YTKFcO9Snch0rzI8Yqm2t/CetP2zIjUlYk0YYEeARtQc+1xF9Mj6Uhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=g11l1Mql;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC02606A326
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Nov 2026 09:21:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EC02606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=g11l1Mql
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-49134c8509fso431303f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Nov 2026 01:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793870509; x=1794475309; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ak9x5pn77LYpbrOAvo4GHkz6DjvrPWIAs7V9DJYOPhw=;
        b=g11l1MqlFn50b/Mcndil8CxwZ+kNwuc6jd5CyU8kBUAll8lMu7vxnu9Zu0Uwydeema
         6RkzfBszlD5SqNS9+6GMk6gALC8ljV2+YeILbQgoFJb28rydlN3OzSNbiBvzoFhvRWcL
         R1NTa9y8eLArb8diFr/txy/0tSodCipp0CLNMW7s+jppTYoOjg4LmS7xF2L29vwcCiRX
         8Z0RMHFxuLwxmXnssan04mSWakR2KVI5dLQ8JP6uMChNFoWBjanEmDlIuD24OE2uY8eP
         nn/5Pl4IaQcir3agR9xcs67x3Et7mU7TJG9VBGMWpRjI6Vd9MjZMndICusp7i5cQnK3k
         uPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793870509; x=1794475309;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ak9x5pn77LYpbrOAvo4GHkz6DjvrPWIAs7V9DJYOPhw=;
        b=PUXAyWACiwuKCiPMhgdEgRivGToQVzNc6AklUuh2NsBr5XNkDX8Dsg6rBrIf589Aay
         sP2zFur3Tak4Ulq6/XrOOBtaI/6wxM1z2G+/svc1WpwwaM2ghanIMCHurvdoVczOFXtF
         Bc82rrJZEJIevYbJ2Bfsjrt9KAzTSDYJMC0+ZyeHRzSAxD6bhD65HUajGk27LJo6McKJ
         ryJ2QUB1CxPAea76oQ/VKGrOicxsRTgof3bxZ1/Q9RqHBH85Zeq8CDyMiquFp6bsNRTC
         hrLU64GCJfF5AsGn1NklqbCCEGTFvfE4oMNJ97MhJ0+De4GReIRQWjn4QstQQjgJ/FkY
         h/tw==
X-Forwarded-Encrypted: i=1; AKwUvBzUruMvCy80izefT0O3cGckDn92jlwwW8kF29vnhPDWO00IOII1KbML/wKN5MJiyiZbSgw/CnGrAteeg+I7UYrNprU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9RX83BOYtTVJLwlJoSddLGdkI2bqeykXGsAvcXK/pK8ovGyUnw
	zlU7ywXY63GnquRFLJfVImT9v2hbK0c9quhnpq4niXXw+gXF82kS4Hl8pvlUZkPfYw==
X-Gm-Gg: AYBFou0YAhLKZUc1RGLKHXmHHfEfnlV8NE0xU4+xLp4D+9tfbYWke3a2Ze6Bh9jQUs1
	n93AQa0mjor/1JWoE7dL3bIoPf1rsx6mlwyytQ9foRFnNMQxx9dCPhHRLM8Eb2EY0MQLYykiqCc
	bIy22szzZBI/uf/FGct8hZxIZmBXrGDDd7tPSpW7pIl7Ai0DKoO67R38ab9TgjqlLn/6XHMiVEt
	K1Mge0kIUafpc76hQcIFO5KCkLTAvzJC2Xs3mZTqR4/0Ujj+pYaR4RKE6o2c7wP+9Tsu8uS5FHh
	HRBE3fT91/SME5YvKlFni/tIbnHs4D0GGoVwnGyNM3BgKHxF7WQNJC5I+D+fTDougVf/nudDYdz
	Qbv84FxHSFpr0/GLIVuCRmOUMok+V0dMtmEKF5t1wd4uXsunOR+F/kErQkQQDWQIQ1k3Ysl0Uu7
	ABNXtYezd/vx1szCR/fsiDiLdCu1pVVZpOvbH/dmy2fMez3hc+LLsTcs0RrPhhH9i+lq502Dey4
	PK+CxDSkeE/0WMMP6moltXT+2UsvArahO1toCBTLcZRgbOwa2GvmATSK0vwXrlXf9ck/ygqvMqR
	44IYsyigL6BXRCDreFWSVS8yLHS5liDBbU4eX7aj4Dq+h2CCBnDetjRp7mCnP4As
X-Received: by 2002:a05:6000:288e:b0:491:45bc:d69a with SMTP id ffacd0b85a97d-49145bcd7a0mr3470214f8f.44.1793870509058;
        Thu, 05 Nov 2026 01:21:49 -0800 (PST)
Received: from google.com (0.182.34.34.bc.googleusercontent.com. [34.34.182.0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed08536dsm7877076f8f.32.2026.11.05.01.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 01:21:48 -0800 (PST)
Date: Thu, 5 Nov 2026 09:21:44 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] ring-buffer: Drop redundant
 ring_buffer_iter::event_size
Message-ID: <auxKqGjWEZa-7iNt@google.com>
References: <20260922072944.1281427-1-vdonnefort@google.com>
 <20260922072944.1281427-4-vdonnefort@google.com>
 <20261104140723.1251aee1@gandalf.local.home>
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
In-Reply-To: <20261104140723.1251aee1@gandalf.local.home>

On Wed, Nov 04, 2026 at 02:07:23PM -0500, Steven Rostedt wrote:
> On Tue, 22 Sep 2026 08:29:43 +0100
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > event_size contains the maximum size the iterator can read for each
> > event. It corresponds to the maximum capacity of a ring-buffer page.
> > During non-consuming read, resizing is disabled. It is therefore safe to
> > just use rb_subbuf_capacity(), making event_size redundant. Remove it.
> 
> Hmm, I don't like the code dependency here. Yes, we disable resizing and
> the event_size isn't going to change, but if in the future that is no
> longer the case, then this becomes a hidden bug.
> 
> What's wrong with just having a field that keeps track of the size
> allocated? It's more robust that way and doesn't have any hidden
> dependencies.
> 
> -- Steve

Ack. It was just an attempt at cleaning up the struct, but indeed this makes an
additional assumption we didn't have before.

I can drop this patch.

-- 
Vincent

>  
> 
> > 
> > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> > ---
> >  kernel/trace/ring_buffer.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index 1a158a24b3c8..3129589e2d0e 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -680,7 +680,6 @@ struct ring_buffer_iter {
> >  	u64				read_stamp;
> >  	u64				page_stamp;
> >  	struct ring_buffer_event	*event;
> > -	size_t				event_size;
> >  	int				missed_events;
> >  };
> >  
> > @@ -3558,9 +3557,11 @@ rb_iter_head_event(struct ring_buffer_iter *iter)
> >  	 */
> >  	barrier();
> >  
> > -	if ((iter->head + length) > commit || length > iter->event_size)
> > +	if ((iter->head + length) > commit ||
> > +	    length > rb_subbuf_capacity(iter->cpu_buffer->buffer)) {
> >  		/* Writer corrupted the read? */
> >  		goto reset;
> > +	}
> >  
> >  	memcpy(iter->event, event, length);
> >  	/*
> > @@ -6488,8 +6489,7 @@ ring_buffer_read_start(struct trace_buffer *buffer, int cpu, gfp_t flags)
> >  		mutex_unlock(&buffer->mutex);
> >  
> >  	/* Holds the entire event: data and meta data. */
> > -	iter->event_size = rb_page_capacity(READ_ONCE(cpu_buffer->reader_page));
> > -	iter->event = kmalloc(iter->event_size, flags);
> > +	iter->event = kmalloc(rb_subbuf_capacity(buffer), flags);
> >  	if (!iter->event) {
> >  		atomic_dec(&cpu_buffer->resize_disabled);
> >  		return NULL;
> 
