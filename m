Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76713BF66D
	for <linux-trace-kernel@vger.kernel.org>; Fri,  7 Aug 2026 08:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786090487; cv=none; b=oiFh/6rgmM3A1cp8AL7nLWbFfBwHdXz5EhPlgi+nlpAEWt1vJ2uNsqiT/JLD56BEjjhX48W9GqeDSggm85orWggboHR5zq7ZBUFJA5OfxCWJpg2w0eSAusd2vF0VJPlYNceWZz0Q6WruI0C+6LlfFmXpZo9DGaBMYDp5eUp91zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786090487; c=relaxed/simple;
	bh=mFfy2EqUma9Eh4SsYEj1tqEQQsUWbdUUzTbx4+5m0ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTIL06NaffkzIBVhTyK2Hg5s9IwAL6H01dBOs1fLEHNVOHKF/9UbvCb/wrrd3qGzJxdjWJwU5N7UZ8dmLCXxZ5vVARPMZpzFtrMx2CUULy+v0oLvGSpkmBNgVkrkrbLzm+3M0I8YW6UpeKNYBxtyCWDhRq7DVJa1OeDpVP8W4Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RPtq5L2E; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RPtq5L2E"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48000c5d6d3so182593f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 07 Aug 2026 01:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786090471; x=1786695271; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gp9hFyIf2ru25qKqyVvBftXQtYl0Dn+ub+8H391zBlQ=;
        b=RPtq5L2ETRBOdnCj6s9+5rCU9N+MLmrDoeVIsmF5wT3xOoMwlPlkPKVFrV0RjujA4V
         RLpSqRMOvE+5Bz+LxeI+eNUD5lGfd77/CK39qF++yvqFKosNm5x4+CvKvhOD/tHaZpa7
         Ef/0GOKlfEfbc9tro7q+L2Q9ezOlAJ5oXK6FbQuc+aBDcP4b/KJ21NMcPcDD3dHZV3zS
         w5GIyTseZ6cc6A00M6Fd0Y0N/INO+xpIy4IV3exWlxrkvF1g3r3e0Vw2E1wnBnq6c7hP
         nLLSdcqqNJZsuqdzzmuwJ/+1UqRF3qLh5Ga0iiRxPZrhXrInO26GD/GKl9q9i0glp+Eq
         HqfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786090471; x=1786695271;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gp9hFyIf2ru25qKqyVvBftXQtYl0Dn+ub+8H391zBlQ=;
        b=Y0hQvQywWNfw3sd+4zp6BJHi0i52SZ8Kcp0WZ69aju/r/ESl5iDBWVtx0pF55xwNnS
         VLUsJvZjL9vJHfVNPPLFhjgXMMRwKe7UVMU8k97FAYUBV4GY6CqkfKQo6fCxwGy2g9Bn
         e/iiyROROMaI8pBAGxJwVoRv/9DR4bzUpyzpCB5mekNBFK5tlUOyPfMHCF7GtUHX04ml
         MiH+n4crWZ07aX9u09Gk3Nqo2JzuI8mgaTdjDMA4RZU//I27l5/3GMlZ2VznNoj9nxzp
         v5TWsMFKQHIp1nhcL3gxv1Wa/ba4ifyhrkH82cPnDcCh8gfAuM+ZBZUA2+CfzrfOna1T
         oMaQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqtq5dIzYOhCM1bfuTBCkNp7y/seS3mytYqqXlvlf5d8ZYXH+UbDXggET+LuWcfUZc0uVEz3Zpx2xjuhN9IC1muK18=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4eykPgsZnxnwUo3843xv6R0xfzBaLnPHA3MOpmCvSc4VXHpsZ
	uePIxwT35OdykpOtQC67tQJ1qYwTSRiShx371lnu1c8FvgqalkZD+Sf07Y4LrP9pEA==
X-Gm-Gg: AR+sD13CF76cslNBu9VNt2ST0yTUmvX/e4oOvFZcdVVPyvLdCf205Xx7hpQHKm/tZfo
	+++2JtNQrrTm+lk924oGBEv65j9DYqF94NqZT6juaRvliahmF1UzOmc9lOoM5JMPlu5UmYt5ivN
	vYO9IowNrNDkFQ4sFoj1UbksAj/sOBQ0NvXr+rb5z9as0AVGMGDvTb7HKhnmKVLC5wxwXWqzrDe
	eLBEeIUE6oWc5wh2Pu7Pbg2p9pfZc3RLlySH59G/DIG96lyVedkvUG+NwvodtkU4k8OMxAS0W+e
	Bmf2uQz8WLHlDotcKAHg6/MytAkHW0Cbjyswel8V0nhVIR0LONt64DPLR8DDCY734MykyXXmug0
	PWdOUjpET19ApL3fNcrqs04rc9Ibv0OABY2M8Hd4eIPEGPogKWbLvWrDwBbovCJFSljSWf7NiiI
	2UJNJKYtEZDp/Kz+qgsWKyMyALcICbjTL0EucLd5wrZrEwrShb4foUmKmtn2DDlEMJJ2logjox5
	0Enox+M6rTBUZ8imFJ5sjaja0BDNMS/
X-Received: by 2002:a05:6000:4813:b0:45e:73eb:5119 with SMTP id ffacd0b85a97d-480026d7fa6mr2900147f8f.22.1786090470439;
        Fri, 07 Aug 2026 01:14:30 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021f93acsm3773511f8f.29.2026.08.07.01.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 01:14:29 -0700 (PDT)
Date: Fri, 7 Aug 2026 09:14:26 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] ring-buffer: Prevent resizing of persistent ring
 buffer
Message-ID: <anWT4heM5Z--A1Mo@google.com>
References: <20260806211306.3704194-1-vdonnefort@google.com>
 <20260806211306.3704194-2-vdonnefort@google.com>
 <20260807111808.d5dc1a48b080d241100f4a57@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807111808.d5dc1a48b080d241100f4a57@kernel.org>

On Fri, Aug 07, 2026 at 11:18:08AM +0900, Masami Hiramatsu wrote:
> On Thu,  6 Aug 2026 22:13:01 +0100
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > Dynamically resizing a persistent ring buffer is not possible. Disable
> > the feature.
> 
> Is it true? Of course there is meaningless to resize the persistent
> ring buffer (because it makes the buffer none-persistent), we are currently
> allows user to resize it (like for resizing unused persistent ring buffer)

__rb_allocate_pages() in ring_buffer_resize() would call for a persistent buffer
rb_range_buffer(), which IIUC, is just reusing the same ring buffer pages as the
one already in the persistent buffer.

So, reducing the size would surely work, however increasing it, would most
likely mean having buffer_page pointing to the same buffer_data_page?

Also, the comment

  /* 
   * Range mapped buffers have the same restrictions as memory
   * mapped ones do.
   */

Made me think that resize_disabled was omitted.

> 
> Thank you,
> 
> > 
> > Fixes: be68d63a139b ("ring-buffer: Add ring_buffer_alloc_range()")
> > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> > 
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index 8e2485bb3aa8..afe75ad2bbf2 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -2528,6 +2528,8 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
> >  		if (cpu_buffer->ring_meta->head_buffer)
> >  			rb_meta_buffer_update(cpu_buffer, bpage);
> >  		bpage->range = 1;
> > +
> > +		atomic_inc(&cpu_buffer->resize_disabled);
> >  	} else if (buffer->remote) {
> >  		struct ring_buffer_desc *desc = ring_buffer_desc(buffer->remote->desc, cpu);
> >  
> > -- 
> > 2.55.0.654.g21b8a5bc05-goog
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

-- 
Vincent
