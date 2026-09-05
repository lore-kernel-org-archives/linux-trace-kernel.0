Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA5B352030
	for <linux-trace-kernel@vger.kernel.org>; Sat,  5 Sep 2026 13:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788613574; cv=none; b=VLcWa+owAMeLdI+HVOTyZH54uQrudqppKV1AOlJc22PUF16D87C9ajdgpetw7RlStWAfJ7fNtbFNTI4M2EPUY7FWpSVjEd3u5w7e2J8EbGDcIwHrHGlDakuClDeu91c+4j/DmgjBTXhTc7BrJwR6fVAxfIQSj2J2i3S5D8N+Dd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788613574; c=relaxed/simple;
	bh=qxiTBWSzHO3v/x+E1clkm6NeovGTfMM7UvjpnNUGkIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0eHp0oPozJKXZnTLQlTrxtXJwtWD2Z1GF9FiRx8DoMrjBB0LAiFX9a/lfX0njoPNkih+uPQ2LHsq4F059T9NJq8GOMUXc7JF+3prcMiYVE7NB194SyqO6ntWy2utsNkFhwNHHT1nqWCPuLB/QJRYG5+OmUOYxKNsBH/ze6uyhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Llfl8Hxv; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Llfl8Hxv"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-484374f54d0so1163172f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 05 Sep 2026 06:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788613571; x=1789218371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p+wVHadqibFAXBtm0/DDhBcCJz1orb/mBgwxUhYUpPQ=;
        b=Llfl8HxvdfacXSMfK7hnQMagsYf3YVqq19gb9rkz0pteDUl7QSxT+chIs3j6t7OB34
         wpWv3CcNdG6cDrS60p/wfLIpFxktFzJtpksp0IegVMrDmOyGMCqRg3dcAKzQ7xIdC9D0
         ESmCVWvp4vQj8jNFW21vlDNW3912fv7o7fkIHMJS8s179xQ4kfDHpz3cNoeVoOO7l2GQ
         AtVP1wsVctmyQxRDnBvgMgVYO7ULaecc7rFMudTedHpLUUblqBs1rQ8UUEazleQiwcOg
         5Q9Kj49eg4un0mlBtSafvLwjUr0bARiMzHo9c9IrN+CJYZOkD0NeSec6Pk7aB4klmgQe
         GuJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788613571; x=1789218371;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p+wVHadqibFAXBtm0/DDhBcCJz1orb/mBgwxUhYUpPQ=;
        b=HSxCYZkTD3TGHmxjvx5HN1fHqp0otu6N1TXmLu/n2nfWh0M8iqrvaH60DW32Lzemsz
         tzOGq7bsHJXk1wWl0c2jzcHBT48SQj4tjhRpk0tvm74IGAS8eoa6Oa6GOeaFRFRB4XiH
         t49n51LYsyojAG4ysVGSDy3wHPqONRW7y0lZ0HSZsTQ22FDgraDDeV1xEH0gwD+pXrEQ
         d9AmqnnRJuXk4irN7NnJWDCP+DLJB071cvRHWQ7mtuIaXP+GcA8mvjNN6bwAOxz1f6hu
         ohVccPPtJHVqHuOdaW4UclnywFiXhGwuzdpsJ6vG2ov03uqBOWfNtBmgur9JW50xNoWA
         M+Og==
X-Forwarded-Encrypted: i=1; AKwUvBwppKDjiz17zLMtAUztKhkcqXsdAptUwK/s9Ntg5QrR4MQsmRvo/JSzu2GdmZ+0XFSgYd/tVfYqrHJ/tBCMGwyT6RI=@vger.kernel.org
X-Gm-Message-State: AFuF++kY7y5Sj6F0hxpEtjAOZMrzZ9cnCdBcEb65LOeIVldREk99Na8a
	uS175b6y5v+ihyRcOAWOuNbMkJivUGI7L+ulgYZGtw8u1GxECuJ/QdWQSbGI+uaTlA==
X-Gm-Gg: AYBFou3eLtYNY5FleQB6/yfFYSXZ8K7xdx9TpDx1t+VRqdk4qjzyf1sNgHcT4K7TwIb
	BgZ1UICkXikKEu6dxJ2iL3WINbEx1XvhJyloAvxtvlEMN3RlEbAaSYRdZ663xOZwlAV2uiKmKst
	fGk7A2rq9kGdfkIT2Ec/P1e4FsGbWoFYS5fKuMEnYp1YVh91w3sI1DqjuhR83S4XaZRipsC/Wyz
	pge/RtNu9t1hLwnmmZjtm2Ab7e6y3Oh12dB/6pYwirBzkNPbBOC9mr+QF3XFAaYdbyCGK8C6FUg
	LTPChb/blRY4YNigrWhZlJNLhSFnIxEmshIQ0Q1sq/kgRIDe9qgY2mNvjBBpul7x0cYsBuKPLqH
	dbUdsqCgsaXChgpE3Tg/S2my16WcO2pfCMApXa5VNEl37dXWyO+h7pr4Adpgk6CyCpjOoUsJYOj
	u/lIGr+5goWKGiY7hwFWiTHNWPKLuj1RssB5Pays7y5n6e1OCp4EMub7PN0nGbdlCLT8rL0AFuE
	TUUWjJ1GJcrtPx07SIXIgBfiM4JHEu9
X-Received: by 2002:a05:6000:220a:b0:485:943c:886d with SMTP id ffacd0b85a97d-485943c8a37mr5001319f8f.7.1788613570173;
        Sat, 05 Sep 2026 06:06:10 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485881353e8sm14107016f8f.1.2026.09.05.06.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 06:06:09 -0700 (PDT)
Date: Sat, 5 Sep 2026 14:06:06 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] ring-buffer: Use a macro for static buffer bits
Message-ID: <apwTvi6sC0xqRvwP@google.com>
References: <20260904151641.17eae0aa@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904151641.17eae0aa@gandalf.local.home>

On Fri, Sep 04, 2026 at 03:16:41PM -0400, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Instead of hard coding 30 for the number of bits used for the static
> buffer ids in two places, create a macro. This way if it changes in the
> future, it will change in all the locations that use it.
> 
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ---
>  kernel/trace/ring_buffer.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 220b8405adfc..b88c75b52e8f 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -335,6 +335,9 @@ static __always_inline unsigned int rb_read_page_capacity(struct buffer_data_rea
>  	return (PAGE_SIZE << rpage->order) - BUF_PAGE_HDR_SIZE;
>  }
>  
> +/* The number of bits for static buffer ids */
> +#define RB_STATIC_BITS	30
> +
>  /*
>   * Note, the buffer_page list must be first. The buffer pages
>   * are allocated in cache lines, which means that each buffer
> @@ -350,7 +353,7 @@ struct buffer_page {
>  	local_t		 entries;	/* entries on this page */
>  	unsigned long	 real_end;	/* real end of data */
>  	unsigned	 order;		/* order of the page */
> -	u32		 id:30;		/* ID for external mapping */
> +	u32		 id:RB_STATIC_BITS; /* ID for external mapping */
>  	u32		 range:1;	/* Mapped via a range */
>  	struct buffer_data_page *page;	/* Actual data page */
>  };
> @@ -663,7 +666,7 @@ static unsigned long rb_static_max_pages(void)
>  	 * Static ring buffers are using bpage::id and must account for the
>  	 * reader page.
>  	 */
> -	return (1UL << 30) - 1;
> +	return (1UL << RB_STATIC_BITS) - 1;
>  }
>  
>  struct ring_buffer_iter {
> -- 
> 2.53.0
>

Reviewed-by: Vincent Donnefort <vdonnefort@google.com>

-- 
Vincent
