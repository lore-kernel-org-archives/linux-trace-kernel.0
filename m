Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBFC47124E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Oct 2026 08:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792053581; cv=none; b=aBEVVie8TlSBuL+dqkVXtQiaXlAZbQcJvSpPX5DAYwu7FhEVSa7j/ksgeXP6yDl8XOMJs34SvmkFThHE+PoBcDbbFV1tQOfN17Y0iGC85S4k7dbB36YdeD6U6WOq6HpCWvybvgka/9dI0FiIkuU5dkpYjb62t4sWj39uvyTGevg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792053581; c=relaxed/simple;
	bh=QDRFoCapch5piNiNZwIRu++sui09KOSnJriSX/46p88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1txWx3I6PuyiJjaP/ufkwJYZk9sySO8fcDq6CLQQyDVqRo6UpnWOBQuwKAdmRpDCuwR0CWMr4OaBwZTbaBoSpzFmTRroKp2nLYxzksW9RChqBw6g/OOEsW3rj2RtVfLCaaB8bIV7vQit3sR6KfOlEG/gK7jK56A9CjC4bBRAyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IKCKGvJ3; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IKCKGvJ3"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48441a2ba1bso794585f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Oct 2026 01:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792053577; x=1792658377; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X1kDRSy+ODAiHs5J4Ng+lLVHgH9QyG9hCKtrmG9m3FA=;
        b=IKCKGvJ3id0UF1UBYywkbf9HDyJvypY3UjQU2QDvjBpVkBy3zY5LfO1KNaf3FnHuR6
         LiEEgZPxTd5AZSsGHWfzwqsGjOjEQiyfkGMp0MBekpywbDhWbonQ/eKIslUGwY4dxLSu
         iywJ5304b510pKr2E+/sYaOS3s2COTNXEOVbtLRsLd2GGW+gR6+CpfSBC9UU7YmckI9H
         IQ9j/w6hgs0q25tUAQN8q1enYMo2ZPEFGsAQDSLup3wKhKxDocdTvo1L1WtQbynXn1dg
         RkLLKPjYFJRJ61zaWuA8pTOBBWjO8t9MD7z+7OrkBsPuFFS5fkUEZL4tJDQFkQzkSx/4
         ij5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792053577; x=1792658377;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X1kDRSy+ODAiHs5J4Ng+lLVHgH9QyG9hCKtrmG9m3FA=;
        b=v5zWiqOYQAhR4N6zYPd1FXT+4rgEV5xJuK5lSlCU4cb1KB2qXW8HRUpq5OIxzqlPxl
         CjtWULWMRPYt11JTN3C6O/qolNk7QyKjCVtINFcmAI6SpTXdQZa4NH+7sCDbYbPAmBk6
         knSbmyseuei7pxvRBODcs+rrXBcvsk2SnjVg1NyHkraTTOayttHVwq+PsHpVZGvc7Xsi
         14jmNFSErjCqX4873mP3JpSHU8FpZYdnwYAEvHHfAUXBbRlXKXzD17dzMCBdI1mThjJw
         z9F/4fgGdRW5xfST0wpF/gnpacb/xGNKnCZJXhIetwdUKYtsQzn2p1JvIvLseoMVUtvg
         0Y/Q==
X-Forwarded-Encrypted: i=1; AKwUvByFx6EkvBjKy/vse7J2VQWZMlrqcE2g5liwkY1bZR6OEFcXET9eSu5mFr6PopKP1ZcT3g0BrvnSVP44ADmLSZaeeqY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKycYVzx5GiLCAMDEzijXmmKq25PJCg11HbSZN2qKkd5NMKnBvu
	r0EaIVJXL5TtdXvu9zP+7L/BdAbU7pjy39a1NzhefhldxgSnWksV05m6huuddlmWMA==
X-Gm-Gg: AYBFou1AJSXNWxgWKX7wUPDBbQufktfXocDzcdGwc9hsDmMy3WxqVD7TS/y95uelrff
	jTK+Z9Srpw1fSYqxYxsgoUMiccVJzqcl3AAaLluSzNzzY6k+RDHxFDSUOrYiEVzlqw8qXT1NTIR
	yBdq7r0Rpc4eHxAkIhse09zX/qbMELrXt0OktBbWaThgeYLuTnuup806t+mecTxPDBpOYfj+F31
	ulh1ssLEA0+zb1brC8GmRZAKkmzXK2MNeIv8xRG+SEAmvWzMPmIxV3ktg0SK78LGGccomVNEw8X
	AFuxkY+K9gIj0wxmd7g1IKZx9B00DArkbaRVDuFflsWrgmaCXolwhUWWsZAmhuE3ujNdZiaaJSQ
	zM8BUJbt2G2eJmKKImqefM1YlzS7VuWBFjBtRHIr8L0pf57PdWBGsGdlV9HwozNaVbI1KrRvhUR
	csYIsk26xP0vau/CVhqgoqnxktuJ2IAbB8rSCd+O4bXwdt5vJ+W2cuWKEAOeJMpOc2BqqNsrUW8
	x06AyRT5uCHY7qprqRX3ywDnxTR1ugCjszKr+IdxDo=
X-Received: by 2002:a5d:44cd:0:b0:488:89e4:c3af with SMTP id ffacd0b85a97d-48dbaae4869mr27915319f8f.45.1792053576963;
        Thu, 15 Oct 2026 01:39:36 -0700 (PDT)
Received: from google.com (197.183.140.34.bc.googleusercontent.com. [34.140.183.197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bc506asm17915462f8f.47.2026.10.15.01.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 01:39:35 -0700 (PDT)
Date: Thu, 15 Oct 2026 09:39:31 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ring-buffer: Skip si_mem_available() for
 persistent and remote buffers
Message-ID: <atCRQ3HRmWgKEJGl@google.com>
References: <20261013102047.1488347-1-vdonnefort@google.com>
 <20261013102047.1488347-2-vdonnefort@google.com>
 <20261014175126.49c26f93@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014175126.49c26f93@gandalf.local.home>

On Wed, Oct 14, 2026 at 05:51:26PM -0400, Steven Rostedt wrote:
> On Tue, 13 Oct 2026 11:20:46 +0100
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > Persistent and remote buffer memory is pre-allocated by the time
> > __rb_allocate_pages() is called. Skip si_mem_available() to avoid
> > wrongly failing the allocation under memory pressure.
> > 
> > For the same reason, unset user_thread.
> > 
> > Fixes: be68d63a139b ("ring-buffer: Add ring_buffer_alloc_range()")
> > Fixes: 2e67fabd8b77 ("ring-buffer: Introduce ring-buffer remotes")
> > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> > ---
> >  kernel/trace/ring_buffer.c | 41 +++++++++++++++++++-------------------
> >  1 file changed, 21 insertions(+), 20 deletions(-)
> > 
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index 04bb94c29f58..b3a30a0413a5 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -2442,20 +2442,30 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
> >  	struct trace_buffer *buffer = cpu_buffer->buffer;
> >  	struct ring_buffer_cpu_meta *meta = NULL;
> >  	struct buffer_page *bpage, *tmp;
> > -	bool user_thread = current->mm != NULL;
> >  	struct ring_buffer_desc *desc = NULL;
> > +	bool user_thread = false;
> >  	long i;
> >  
> > -	/*
> > -	 * Check if the available memory is there first.
> > -	 * Note, si_mem_available() only gives us a rough estimate of available
> > -	 * memory. It may not be accurate. But we don't care, we just want
> > -	 * to prevent doing any allocation when it is obvious that it is
> > -	 * not going to succeed.
> > -	 */
> > -	i = si_mem_available();
> > -	if (i < nr_pages)
> > -		return -ENOMEM;
> > +	if (buffer->range_addr_start) {
> > +		meta = rb_range_meta(buffer, nr_pages, cpu_buffer->cpu);
> > +	} else if (buffer->remote) {
> > +		desc = ring_buffer_desc(buffer->remote->desc, cpu_buffer->cpu);
> > +		if (!desc || WARN_ON(desc->nr_page_va != (nr_pages + 1)))
> > +			return -EINVAL;
> > +	} else {
> > +		/*
> > +		 * Check if the available memory is there first.
> > +		 * Note, si_mem_available() only gives us a rough estimate of available
> > +		 * memory. It may not be accurate. But we don't care, we just want
> > +		 * to prevent doing any allocation when it is obvious that it is
> > +		 * not going to succeed.
> > +		 */
> > +		i = si_mem_available();
> > +		if (i < nr_pages)
> > +			return -ENOMEM;
> > +
> > +		user_thread = current->mm != NULL;
> 
> Not caused by this patch but we need to update this to:
> 
> 		user_thread = is_user_task(current);
> 
> I may add that.

I can send a v3 if that helps.

-- 
Vincent

> 
> -- Steve
> 
> > +	}
> >  
> >  	/*
> >  	 * If a user thread allocates too much, and si_mem_available()
> > @@ -2469,15 +2479,6 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
> >  	if (user_thread)
> >  		set_current_oom_origin();
> >  
> > -	if (buffer->range_addr_start)
> > -		meta = rb_range_meta(buffer, nr_pages, cpu_buffer->cpu);
> > -
> > -	if (buffer->remote) {
> > -		desc = ring_buffer_desc(buffer->remote->desc, cpu_buffer->cpu);
> > -		if (!desc || WARN_ON(desc->nr_page_va != (nr_pages + 1)))
> > -			return -EINVAL;
> > -	}
> > -
> >  	for (i = 0; i < nr_pages; i++) {
> >  
> >  		bpage = alloc_cpu_page(cpu_buffer->cpu);
> 
