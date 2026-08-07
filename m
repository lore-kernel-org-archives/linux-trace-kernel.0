Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF91D44A41C
	for <linux-trace-kernel@vger.kernel.org>; Fri,  7 Aug 2026 10:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786098332; cv=none; b=BnBEBQsPouVlfUzigwPqTqNnx66y/hOE0jktDFhMDQJy6bjdfcKjXVSS/NQNXFQzGzMBrOdRNhIqsR+PITjFgefeFeOJTjlxyFY65DiPrXMtTTAzcu0Thaul1vbM6S9NhIzkXXysoOGrFY952ZhhbbY/ulKax/8zBvq7WWjGCuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786098332; c=relaxed/simple;
	bh=inJLRty6ZgsoYYoNuJdPiOm8I47Wdr7rvozamiHV1Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aID8+Zynud/XejrYX+88Lr8PDbBQocAEHh/PChJWqWt8uxKpOwg5uj01ibIt5Czwk3gxe7AD72ZJWPuIi+Nv9MQfB6raic0y0B0VnQFveeZy406mOObQdRr+KHWop5bYeKvD5YQbE34IUo2N6MgxxPWZbgOEKrO+cs29RkPG7OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bzj2CFnP; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bzj2CFnP"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c15e592da74so401466466b.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 07 Aug 2026 03:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786098328; x=1786703128; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3IYy5szNuRGeMh5DMQZtziXg8pTrFr3dhRgA8Iqm8oo=;
        b=bzj2CFnPC4colberxvN1NrGsT1dfSl2rgXumAQ3hGq4WkM83pJhR28VQfiGbwRjGjK
         E07knWfyAMxnKHdK7R0qEV9g2y/aNz3pKWivQPpOpC/CH9+Z7sP+MPqhzVHBHGpa811A
         G0UKTMCJ5rbz1JQfjLbT8tZgt7Y5JLsJD9tLtb6lVYa8jK7QFUyhgTedNopVR/kGq3V6
         MGKjAqaJcKzxpGobXOnBdvF5NuslK/1CMGu53MxRrx+c7HllhhCAN58MWLGMG2XAp4vz
         z3ikxyfKT+spLmTfAahvu38iiUntw1ci9vm2yV+ALenHPOkn21OlMqBDOSWpJAbLyprP
         3MoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786098328; x=1786703128;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3IYy5szNuRGeMh5DMQZtziXg8pTrFr3dhRgA8Iqm8oo=;
        b=Yoo5TY1ADNhFys9+3i51ntv+LeEHZjwcsNP1lu3eprQGYYOzimPTqf3kGig1pUazp5
         UmIJjplUl6r93zmQ3khM1BwlIeVJPNdLrN9mJMPLOX8mNsM6NUM1tL7Hd9/MugHaOdZ1
         3MaMCSFF0Oj6Oo7c62cuXSviwhPM1YsrozwozxpldKLX+llxzhU1O4f7OaHvVF+wxBsj
         3i53DXy0zmvcPy67sQVhT8FsIxWqdND3KCtsXA/ZLBF12GHKD6yVWnQoN9+vJITQJEfu
         kdtwmbtsY03mPsj97e0IHf0JBGZ4Him/6Wy/21RDzX6Dht6HF9mk+huQp7eq1Skayt29
         KWyQ==
X-Forwarded-Encrypted: i=1; AHgh+RqBN9SIduiNUiSnZUdzurSKiYKqkiCG/uFKCPXNrNgMLqatLdDz4OEPQBEOBJ9w0XHUJAy5KHOB9GXCYRw0xBBKnBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YygrkalXfXVEoA9O0qImKue1L/WxhUK9yA+Xs3WsVAEKRkvZEYr
	JlQdu/k+HFtJRNs9ZIOU3SxsP+R+7mGprtOFCC1zutJ6ij29TGMq1RXdnQV7uGckqQ==
X-Gm-Gg: AR+sD130SVclIuI+yk1m2pHYO3hDl1wqRVfqmwMEcO3F/FH/0BmWwwmN/AK1fq5nG31
	onsrOWAvPGo+u+hnwzgLsFid9Ar+qHfIzq5T87GcqkyO+qpX9GZ2pw7ZyM0U6ccFo9wpnVT0irN
	s+LNJaMOXgl+pBqhPHdMDuK+DeS5Xn95iYJ10Lhf+c6kQGp3w/GnKLDC48C6HLoEa/5b3zsBVTl
	c/X/Hum77JCKmSty3oHa5Q5bvDfXtUV2crla+vQzTmvu2xqF18uZmjd1mcy8r5D9GJO54ED7u8y
	OjDDutoNMuYSvEnc1adaWSIxVuSsMZoeBJfmjKOec3xbdwx3VeCnSiwhD3AJ2xFT/FR9msrmjRG
	nKtmR5koc7VuDBfPx108KRPbA7Neh5tXjlBQpFBHL9VG5+6ZbaJ8Hog7zZf7hifGaR3TH9nQzTh
	5Dl5/PSC6o0iMueB3uqM7wOG9+ksedeB2N6jrpV+svqNnV1LC1RSsDNe+yLUCd1uSDCAIthOZbD
	rrreHUEatb4fZ0x1NpamepL/ZpJW/nA
X-Received: by 2002:a17:907:9301:b0:bec:64d4:3872 with SMTP id a640c23a62f3a-c2039ec8d14mr939317766b.24.1786098327209;
        Fri, 07 Aug 2026 03:25:27 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a1e7d48ce7sm423129a12.16.2026.08.07.03.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 03:25:26 -0700 (PDT)
Date: Fri, 7 Aug 2026 11:25:23 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] ring-buffer: Prevent resizing of persistent ring
 buffer
Message-ID: <anWyk2GqNLtwddWQ@google.com>
References: <20260806211306.3704194-1-vdonnefort@google.com>
 <20260806211306.3704194-2-vdonnefort@google.com>
 <20260807111808.d5dc1a48b080d241100f4a57@kernel.org>
 <anWT4heM5Z--A1Mo@google.com>
 <anWosNi-U8lVqBZP@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anWosNi-U8lVqBZP@google.com>

On Fri, Aug 07, 2026 at 10:43:12AM +0100, Vincent Donnefort wrote:
> On Fri, Aug 07, 2026 at 09:14:26AM +0100, Vincent Donnefort wrote:
> > On Fri, Aug 07, 2026 at 11:18:08AM +0900, Masami Hiramatsu wrote:
> > > On Thu,  6 Aug 2026 22:13:01 +0100
> > > Vincent Donnefort <vdonnefort@google.com> wrote:
> > > 
> > > > Dynamically resizing a persistent ring buffer is not possible. Disable
> > > > the feature.
> > > 
> > > Is it true? Of course there is meaningless to resize the persistent
> > > ring buffer (because it makes the buffer none-persistent), we are currently
> > > allows user to resize it (like for resizing unused persistent ring buffer)
> > 
> > __rb_allocate_pages() in ring_buffer_resize() would call for a persistent buffer
> > rb_range_buffer(), which IIUC, is just reusing the same ring buffer pages as the
> > one already in the persistent buffer.

With more logs, during a resize form 8 to 16K: 

cpu_buffer->new_pages contains:

[  632.919017] ring_buffer_resize: CPU 0 NEW page 00000000768ccc81
[  632.919828] ring_buffer_resize: CPU 0 NEW page 00000000ee48729c

while cpu_buffer->pages contains:

[  632.921511] ring_buffer_resize: CPU 0 OLD page 000000002c4c6f92
[  632.921917] ring_buffer_resize: CPU 0 OLD page 00000000dadcb510
[  632.922295] ring_buffer_resize: CPU 0 OLD page 00000000768ccc81
[  632.923226] ring_buffer_resize: CPU 0 OLD reader page 000000003b4dd5ba

So two buffer_page point to 00000000768ccc81.

-- 
Vincent

> 
> I have just tried and if reducing the size works, increasing fails in both
> rb_set_head_page() and rb_insert_pages() with a warning, which I believe is
> expected.
> 
> We could improve that, but it feels like it is a lot of work for a meaningless
> feature which we should just disable?
> 
> -- 
> Vincent
> 
> > 
> > So, reducing the size would surely work, however increasing it, would most
> > likely mean having buffer_page pointing to the same buffer_data_page?
> > 
> > Also, the comment
> > 
> >   /* 
> >    * Range mapped buffers have the same restrictions as memory
> >    * mapped ones do.
> >    */
> > 
> > Made me think that resize_disabled was omitted.
> > 
> > > 
> > > Thank you,
> > > 
> > > > 
> > > > Fixes: be68d63a139b ("ring-buffer: Add ring_buffer_alloc_range()")
> > > > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> > > > 
> > > > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > > > index 8e2485bb3aa8..afe75ad2bbf2 100644
> > > > --- a/kernel/trace/ring_buffer.c
> > > > +++ b/kernel/trace/ring_buffer.c
> > > > @@ -2528,6 +2528,8 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
> > > >  		if (cpu_buffer->ring_meta->head_buffer)
> > > >  			rb_meta_buffer_update(cpu_buffer, bpage);
> > > >  		bpage->range = 1;
> > > > +
> > > > +		atomic_inc(&cpu_buffer->resize_disabled);
> > > >  	} else if (buffer->remote) {
> > > >  		struct ring_buffer_desc *desc = ring_buffer_desc(buffer->remote->desc, cpu);
> > > >  
> > > > -- 
> > > > 2.55.0.654.g21b8a5bc05-goog
> > > > 
> > > 
> > > 
> > > -- 
> > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > -- 
> > Vincent
> 
