Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794664007;
	b=2Lc/2c9GLZnIrQk8X09Rtp2KAQWIEy4LYqVoc6sv0BPEoTD8G0E3s+VPa8CRDAa98i9J
	 6a/u44s7/FDIStQzIEO35BznhYkkKQucYruVVv5cOowrv+XTTm7T6Wd82AInfBOLi9Mfg
	 Bz8C59nrBOW2lwxbCkj2icwo0P8Wj6hRZsLH0ED0aNbX49OizHSGIe36pUDK7r+4LBMxY
	 BfOxZRoYNmINhds9a3R8bK+hJB3RgUfkXhIwHTDfDMUcfj/oRt8FjTVihV87rtYvtqTp7
	 LpylCPT9GY57idAkEsANz0XTr7J4c/pA+74kmRgPHKnAi7sKD7QZHBhFBT4Xl+OebHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794664007;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=BR1VC/UzZxQOEPl73tQotgFkTmmM6Ug/uubSfLUCJn4=;
	b=2UT6Ts0MgkGk7YOJvSdxqYW+xtIboGVYo72DepEWLHKR4MFDOF7n4yB28cqeZFhpkQRr
	 x4yVInvwrrGQOgc4OsoKHe/nqNRPAz++bW4Z4O7cySxAbvW2v6wFM+Sl9hiF0MrHLaH4T
	 3kUtSB+OLMpOcgbLHJurqTpvrw2Cj/Ap/hsG4cNul0pyfTgFMURQeHPjJRgFMvDJzdyDH
	 JD+FkMXMdbDrMZk66OWytNo1ZeDzlw7f9vyN8ZaIFzzxtcoBtAB44ziLwSH1NOS7YDUTM
	 lZCSgQe7XnWtUgRzaksHQwWyedG2+Cz1vH8xQcYsTTXKh52MIr75oOnRn1JOz4HdFTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DiUDpDri;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1415606A323
	for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Nov 2026 13:46:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1415606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DiUDpDri
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso12866075e9.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Nov 2026 05:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794664005; x=1795268805; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BR1VC/UzZxQOEPl73tQotgFkTmmM6Ug/uubSfLUCJn4=;
        b=DiUDpDriUVe8FaK5aPKwNxHvujK5OsVc4ARx+MeXOF65nmFeW6WqejQladCA+lHv6Q
         DXQK3WV7IuRGEo7EN+Wj7yJ2xqoZxHDRWCbUrK20b1d2DlLlw2hv/axpgUtB+8K5tkV/
         Hza4+mglJKd2DrmK0zv4VyXqvyRoI3s29OzXfd8SEQVPTCZo10KwuOhTvhtl5eYdBfOs
         JTIEhWY8IZUVDMTKwmYjvcGwOcgXKCeZd+qgbMiEO8VAKMHxFnjzTePNd51k+UPG3Ow0
         ng7aIWQ+FnpNTx2fyKllgBppHYybkePwrMVfirbfK95Ws/WCpKqyStMkjL9YJppBI0Zg
         3Ayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794664005; x=1795268805;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BR1VC/UzZxQOEPl73tQotgFkTmmM6Ug/uubSfLUCJn4=;
        b=TDXeX9m2h5qsZgv7IzWRbMVfm4Yo2FOSzelyM+uJw+Fxhz42yVeyB9JHc6KS1QGy3j
         b3grofbRaNYLgr6DKzQXrNMnoa3/Ailq5QTwasp/8X3c1621mCC46MvdhXzANIMgpNBy
         N7HXTSinaDa5Q+7JDDKdJ36SmO6kpFzVmRSHiTrt1Ui4wrX7W+kNwoy7xQOnCLoAJe+k
         64qKHxOlLy7R1KDEyaL1hbZoWc71O64cv+9Ti/qgEUO+iBB8fopxCAImPS2LKqI/ax7W
         c+GDSxNld+33qt+RDpaXoIB48Uclms0eeyIDoKpo0Xtz8uvQ3VHZwwEzgMzjOqIsmkeD
         TEFg==
X-Gm-Message-State: APuU4Z/S8jeeAtrIM+3nNYhbhlkg5oDPrgeIsjMf/NBgDydPrgSb+KZC
	JKfqPSJxT79L7R3yvFaudGapTDBa2h5dfUl882fjmzoGmnqA94wYT2t7MTuwYO6tNw==
X-Gm-Gg: AYBFou0nELJ0kbZ9K/8AD1zizeEe/UeH3919d48CEvP3vxzltv4swtppc6mL0kpX8WC
	MaTuDruoqBQoWyAnuOu8HmoGDHu0H6s14H+1c2f1CcZklbxu6fZGSBNV36QfbenE1Gdk7JnBd0K
	gFvFzi5ASIvwbGhO4DmRKUg7Hdwb1JErxLzQ5VDTqBpf5MfQHuhMSAaSYAzlQT9VEehIZcMJQnk
	shKhmz2l6Dzur3h0Bqf9Y4pdZ+qnG9crUe/mMHwdkiSasxhsDa2PtAzp57mcPo4uan0MZ0sf6WR
	k+24xTNvF7lvqOE+fq8zfQQUtNs/U2KU9seQEKRgMNmC23+S7hKocFL3bf9+8MaQslMH0GZyOrj
	4aUI0x4Ul+75N1DXQ90up0zAtRCPybsFQp4dPFuzeNj0sgrckEV/5tFRp0ANy2vFC1LWrZhd/3L
	I4Yl3hiHQ5huRP+RwrYSg3Pv6zdx5PxcrH3XZi2orWetSyme2fEiKs94ir+K7L1zbnS7KglqA3x
	GROKbszR//jUqC5nSIEXGuBc0SPRPu+sGGLtB2uRyoA2gNSudWLHMkcBANrRJnFPMllq53wQKfU
	4KCLGZDsXxmatooXU9zzwF0ezc1Fn6RaY5pjQrus0005xOwLu8u1Sl584oxgUxEJAQ==
X-Received: by 2002:a05:600c:3f12:b0:4a1:dadf:9876 with SMTP id 5b1f17b1804b1-4bb55a644bfmr114753525e9.23.1794664004843;
        Sat, 14 Nov 2026 05:46:44 -0800 (PST)
Received: from google.com (0.182.34.34.bc.googleusercontent.com. [34.34.182.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb609cc1b2sm53600795e9.11.2026.11.14.05.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 05:46:44 -0800 (PST)
Date: Sat, 14 Nov 2026 13:46:40 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/4] ring-buffer: Check remote reader page commit
 before meta entries
Message-ID: <avhmQDrQ5Y7RZc3i@google.com>
References: <20261113152729.837429-1-vdonnefort@google.com>
 <20261113152729.837429-3-vdonnefort@google.com>
 <sashiko-outbox-213147@kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-213147@kernel.org>

On Fri, Nov 13, 2026 at 04:03:36PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] ring-buffer: rb_num_of_entries() underflow when commit
>   precedes meta entries
> --
> 
> commit 1d2d0e6ae01d518c30dc9986893db113c38a4caf
> Author: Vincent Donnefort <vdonnefort@google.com>
> 
> ring-buffer: Check remote reader page commit before meta entries
> 
> This commit reorders the checks in __rb_get_reader_page_from_remote() to
> inspect the current reader page commit offset before checking if
> rb_num_of_entries() is zero, and adds memory barriers pairing page::commit
> and meta::entries between simple_ring_buffer_commit() and the remote reader.
> 
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index 3c7aa982d43e9..f70010e2ede77 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> 
> [ ... ]
> 
> > @@ -5825,8 +5823,13 @@ __rb_get_reader_page_from_remote(struct ring_buffer_per_cpu *cpu_buffer)
> >  {
> >  	struct buffer_page *new_reader, *prev_reader, *prev_head, *new_head, *last;
> >  
> > -	if (!rb_read_remote_meta_page(cpu_buffer))
> > -		return NULL;
> > +	rb_read_remote_meta_page(cpu_buffer);
> > +
> > +	/*
> > +	 * Order meta::entries read before page::commit, most likely paired with
> > +	 * simple_ring_buffer_commit().
> > +	 */
> > +	smp_rmb();
> >  
> >  	/* More to read on the reader page */
> >  	if (cpu_buffer->reader_page->read < rb_page_size(cpu_buffer->reader_page)) {
> > @@ -5835,6 +5838,9 @@ __rb_get_reader_page_from_remote(struct ring_buffer_per_cpu *cpu_buffer)
> >  		return cpu_buffer->reader_page;
> >  	}
> >  
> > +	if (!rb_num_of_entries(cpu_buffer))
> > +		return NULL;
> 
> [Severity: Medium]
> Can rb_num_of_entries() underflow to ULONG_MAX when an event is consumed in
> the window between the page->commit update and the meta->entries increment?
> 
> CPU0 (writer)                       CPU1 (reader)
> -------------                       -------------
> simple_ring_buffer_commit()
>   local_set(&page->commit, write);
>                                     ring_buffer_consume()
>                                       ...
>                                       __rb_get_reader_page_from_remote()
>                                         rb_read_remote_meta_page()
>                                           /* caches entries = N */
>                                         reader_page->read < rb_page_size()
>                                           return reader_page;
>                                       rb_advance_reader()
>                                         cpu_buffer->read++; /* N + 1 */
>   simple_rb_meta_inc(meta->entries, 1);
> 
> At this point cpu_buffer->read is N + 1 while cpu_buffer->entries is still N,
> so rb_num_of_entries() evaluates N - (N + 1) = ULONG_MAX:
> 
> kernel/trace/ring_buffer.c:rb_num_of_entries() {
> 	return local_read(&cpu_buffer->entries) -
> 		(local_read(&cpu_buffer->overrun) + cpu_buffer->read);
> }
> 
> Until rb_read_remote_meta_page() runs again, ring_buffer_entries() returns
> ULONG_MAX and ring_buffer_empty() returns false on an empty buffer (which
> also prevents trace_remote_try_unload() from unloading an idle buffer).  If
> __rb_get_reader_page_from_remote() is called again before CPU0 increments
> meta->entries, !rb_num_of_entries() evaluates to false and it proceeds to
> swap_reader_page() on an empty buffer.
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261113152729.837429-1-vdonnefort@google.com?part=2

This underflow can happen if ring_buffer_consume() is called directly. But
trace_remote always tests ring_buffer_empty_cpu() before calling
ring_buffer_peek() or ring_buffer_iter_peek().

-- 
Vincent
