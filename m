Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F941361959
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 16:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787761484; cv=none; b=FWHLx77StoF7qz1mc83dDY6UwBCxRbg97J0DJf4cjfFSb6VosyrF/Uq6SKCzFf3sUy1/8sDDPmAZ6OSx2lQJ/PrloSmwErvJRN0b20+qPn3NJgKMiHMarwHRteOwPT3j33hUiP1BXoYJCpyhFPcAqF3vbeoOwkg6FsDN0czUmYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787761484; c=relaxed/simple;
	bh=TyOk4qc9NbEhPQXdVLDwlGeADrLSv/duAMRKU3keWRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8ncmVYiMR4E0CVhR6c2sMhQWSit0jFOoDMxjJMW8jr9opglqJRNJ5SpktbGKju0o3gu3NNLbWyQJV+M02ei3WVE30grH1Xp+rpy1rkIXFgvSQO/3Fknw4c/nab9m1Vv7XrPAyCX3HmwpOnwvu64It4juB3Z2mYrhCJYm/UuReU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vKqcML8S; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vKqcML8S"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-482d9ddf129so664027f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 09:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787761480; x=1788366280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o4wPhRoiAoITJ/dRbRZTHMg4nlt0LAxopK2lH03YyHA=;
        b=vKqcML8SQhedkYA/I9nxf2HpV8YA0U2IYMaTWOUjmec0hApKV1zmcRHwunVShNNypF
         4rLdZoM+R/C+cqiP5orp36n6Ze3j4PerMRn03Nl3oeSqMyZCSzocyC3nXh6oi7v6oJHC
         79FNWt3oLbajw/8AU1bxeRYBckn1hu/9JkpGum9A8IZu+npL00wdAxGA4eTjxkNGY17L
         yMknpl4eOjxtTXFugpmN86bQWE7pBVi2juQLShEsTkbpOnexHTMRpucaHELcMfrjEr0x
         XL3Tp5LFDF9+tuosQSCb4te8wq8bd7LS3IGsvR/wVgJW6XPadaIyAZ6ylaZoqOtpKu+A
         d0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787761480; x=1788366280;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o4wPhRoiAoITJ/dRbRZTHMg4nlt0LAxopK2lH03YyHA=;
        b=tYvrqT566H1HgGDHEEvj07Ym7YeAPOIN18PjHGoGDX6DqrJROO+pMlpip/7PX7zTAl
         OHzc7mz6lsR6ADoEn8ajlvBKqQhZ8NIK7tRf0Dnhuh2ipcqMIssIVp2shV2HH1podV3z
         LiwSyr3HNHRqf9ZkVKwR/x3thFyVxACU6uc5jxE1AqubIAZjdaMRY9wfZ4wUWE6kXtIP
         TlYSWfqArfgjS14Bu7ffMkyPpiem8/3d8XwSsBzdDofglaqEfmm6voreWfzvRAlt/j3T
         OwkskVTp702TcT1gFnw4X2Id6far3sn62tQyB2OZGyPHfR1R94Gsp0sgcLbV83Z7qRyH
         pxLg==
X-Forwarded-Encrypted: i=1; AHgh+RrtIN+5X3ASznhLfw5cMOA45nji0iy2ssnS8uFLqo4wLcHorN5sUzVxDQDxNjplnk/NUUgrpXlLclvX93wUakYHvU8=@vger.kernel.org
X-Gm-Message-State: AFuF++lSu4iY6+lhFrlEaQ8yuiYX3A/3q/NsEgsXH/is3o8wqHdc3RsM
	f3nxg8MMCqHeuxou0neSjeWtHp3Km6Prwq90Y7cFKka+r4vIeFE4s77A6jiEFlwe+duTdFdn61M
	2j+ZPeJsh
X-Gm-Gg: AR+sD124TJACeLvId588nI4TygD5gf9mhH1nk58H5+5i1fsIojw+OWAy1SVfguLbGvP
	QrNEmNpD5CfUC/U+jMOrvZDoVNCdTJJzh1flivN4Fc/xFT9Parlip7WtlAJOLmWSgTakJgnZ3Sq
	mAKzsXEseFOMrkUFPU1TFOdeUL6ROCyf8EnkuB67IzBc0qhVK4NEwgWKC9bYmd3CbJylsh04+N7
	hPWkkJMKVBN3qHcSWyJ50ZSfX87NfA59M2CY8UFsFSRS7Fo/ve2aV/DZdjmpK+nCkSFicm01WQi
	9z9bQR71LIz/O2yFZjH/mAaZ88TG4MXqLKjOjdE+f3ZFLkOL0lOojMjxBJ+A/W6v25H2Cck2tSz
	r9aaLnw5kLBjakZMVfZwVi4UdWQGXGItw+nmP6xvPfiGqhPN0BiMELvKGtGFlB6Venh7pvDuYdu
	J6wbcaq4HVkYIVy+cv4waiGrzXThc+k+TLj58QqErSohwVlYpze4FfPHtjPnXVS9Ndv/GnVtSBj
	TSscEvMHeIsRTU0IWrhBuDdiG0gNkP0
X-Received: by 2002:a5d:5e12:0:b0:482:dfab:8689 with SMTP id ffacd0b85a97d-482e26d8990mr6671700f8f.13.1787761480049;
        Wed, 26 Aug 2026 09:24:40 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e279eb11sm3321640f8f.8.2026.08.26.09.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 09:24:38 -0700 (PDT)
Date: Wed, 26 Aug 2026 17:24:35 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/3] tracing: Fix subbuf resize races with
 trace_pipe_raw readers
Message-ID: <ao8TQ-SvhjYgy43-@google.com>
References: <20260826094528.3738023-1-vdonnefort@google.com>
 <20260826094528.3738023-2-vdonnefort@google.com>
 <20260826095947.4FF8B1F000E9@smtp.kernel.org>
 <20260826103736.2b55b464@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826103736.2b55b464@gandalf.local.home>

On Wed, Aug 26, 2026 at 10:37:36AM -0400, Steven Rostedt wrote:
> On Wed, 26 Aug 2026 09:59:46 +0000
> sashiko-bot@kernel.org wrote:
> 
> > > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > > --- a/kernel/trace/ring_buffer.c
> > > +++ b/kernel/trace/ring_buffer.c  
> > [ ... ]
> > > @@ -7183,7 +7218,8 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
> > >  	 */
> > >  	if (read || (len < (size - read)) ||
> > >  	    cpu_buffer->reader_page == cpu_buffer->commit_page ||
> > > -	    rb_is_static(cpu_buffer)) {
> > > +	    rb_is_static(cpu_buffer) ||
> > > +	    data_page->order != reader->order) {
> > >  		struct buffer_data_page *rpage = cpu_buffer->reader_page->page;
> > >  		unsigned int rpos = read;
> > >  		unsigned int pos = 0;  
> > 
> > [Severity: High]
> > Does this new condition break splice reads when the buffer order changes?
> > 
> > When tracing_buffers_splice_read() allocates a read page with the new order
> > and calls ring_buffer_read_page() with full=1, it will now enter this manual
> > copy block because the subbuffer orders no longer match.
> > 
> > However, just a few lines down inside this block in ring_buffer_read_page(),
> > there is the following check:
> > 
> >         if (full &&
> >             (!read || (len < (size - read)) ||
> >              cpu_buffer->reader_page == cpu_buffer->commit_page))
> >                 return -1;
> > 
> > Since the reader page typically hasn't been partially read yet (read == 0),
> > and full == 1 from splice, this check evaluates to true and immediately
> > returns -1 instead of copying the data.
> > 
> > Because tracing_buffers_splice_read() loops and ultimately returns -EAGAIN
> > on failure, will this cause an infinite loop of -EAGAIN for userspace tools
> > trying to read across buffer resizes?
> > 
> 
> 
> This is a legitimate concern. But with an easy solution. Perhaps just add:
> 
> 	if (full &&
> 	    (!read || (len < (size - read)) ||
> -	     cpu_buffer->reader_page == cpu_buffer->commit_page))
> +	     cpu_buffer->reader_page == cpu_buffer->commit_page) &&
> +	    data_page->order == buffer->subbuf_order)
> 		return -1;
> 
> If the user is changing the buffer size at the same time as reading raw
> pages, they get what they deserve! I just don't want to let the kernel go
> into an infinite loop.
> 
> -- Steve
> 

Sounds good. Do you prefer to get a v9 or you fold this into the existing commit?

-- 
Vincent
