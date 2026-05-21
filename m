Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E6D3EFD1F
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 May 2026 12:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779367838; cv=none; b=NiQ78M5JnOEDJNc67bAi1yxcw4qiVuTDAi9WonCpYK3RdJB8+G5jZBIPhfWwk+V5huLsnnzd18J8HPIqpyjViY43ixKUWyRVIMt1a2i8g0Pv7p2Nr7LQ3zQLZcwTH/W2lJmh7oImBqRfvDUt8P36yA9mGs1Td+auGlP2bRe+WD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779367838; c=relaxed/simple;
	bh=sofyuN+s3Lp4Rn7CBnTQdqYr83yKYuTMO6HGabAjn+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCnAN5VxbZt2A5UjPISH0sPkUrNF6iuiQyEteWt0Irp+QlVsUeN4IspV/eBtEbPWLJKfH5HIwsmhMNizFbOYkJcqpWkpoVK2k9/zY4jjuSQeB+Zy0SeNq1sZP4H0G3mtcD7JNiFBdONMcaoN6UzHxeXSrD95LtRIhLBv014beKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jk9SV9q7; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jk9SV9q7"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-441209fb77eso3907434f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 21 May 2026 05:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779367835; x=1779972635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PZ5bq+Vtjbb2xTcNTKbtvR9sRhxPYHgaOXmmdNre9Lc=;
        b=jk9SV9q7XXU8rq3EVDUbBSy6sGlpRz+dx9ak0eH6neHvV3xYjCuKQS5BZ29lkHr2vc
         zy1YE/LPUr20e12D9zDSS/AclpNw3222l6+v1jQ17HMdr7RARhNLrIBpnYknGkToRsva
         0NDguJu5oXnn6Bz8rNbt/C+QdTCE/xBNShpmKR0e37WXJxUyPWoMk45LUOxV+eoMe0s2
         lbow7HYEQYdH2kUyhJ2bHdQ7k0Dan8J1TAdcYvU9ckjBuKgUQSn3Uk/aHw/LETXCUBvn
         n+P/nSOPha2iaYlV/A2tBvmjtScHCpkq7F/qSVUM+SgUhR3PhiXO7JL9k1aCO1EPL8K5
         CpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779367835; x=1779972635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PZ5bq+Vtjbb2xTcNTKbtvR9sRhxPYHgaOXmmdNre9Lc=;
        b=AKeaJqH66z9g5NQoFv498ciUBgGnFIwiJy/zdJJm/Rx1KpcaZbEwl57lpcpiZpPeoz
         DIN8aQoRgQ1E48suTYXKBAI5fdMihyogfQ6Eu3Bj68K1qS6fVFcJhTn7cqRZ+KFnE+cp
         SoKWuvqBXDLcR6TlRpHbuWyzm3wAxv0kkIA92jwVYcIykfCff2wA9wTBJXWKrTOkz2Ts
         pdXgSK+IzJMXURUpgG4UHnQ8H6vftIpjft3dCp+84F5zFosCBgbWH6Uj2UpCh0QkaI8H
         aem4ntNhwDBrKEWGZTv9sbfe2tnKkDf7Ts6mVYUlrv6Pc9QVTPagb/jTrJe4PWxU1WDf
         zFyA==
X-Forwarded-Encrypted: i=1; AFNElJ8NEpD/4xngZoA4H6Wj8cHhQpyHTASe+GP4loCxrsW7KcbfbUU6e37oRdMtxAFTzZ+6+r1yO/ZO/j1FW/3JrDl49Zc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ9q63acZmwmMRRTuceQb1MDKhYxC6UWLmPkyC7+3Gn6SSQT77
	xvpSMb0OFisajGZRv5TaXZXWlVFqHAzM2KtmaAA6DLmDgLSiUfVOL0Ydx5c+evPCSQ==
X-Gm-Gg: Acq92OFliZm9OmA7rdnj11qzVhrXTpqPWTI1RxGs/a27PLu/08LNuDfHr61Jono7sdF
	3yiSXS9geMpiaM1AeOTLI7OUgbQ4JGXN3Crg+8LJUotKzD47zwoMbY8e8TuXXAcFdpzDLmveN3G
	0udwlED8VdWtd8bWhsBXDNc2HznWzzvTwe1cDLjJ9J/zqK/jqBb2dJGuYXRo34qKn4RPKt0R7Im
	+93+5JefhH8Ij41K+sW/sHi8XPm6l1ii5TeGAYbfd//ZIAgY7nVTkl4PGJsBuHMOdGxLlrvJ0AP
	MgWlvIOV6i0Xq6rprVXmbxSW6fT1KauKUq9sQCuMKer3VYlDKt1J3DIoqLa5LCRDjg7qkHQulf5
	M3rMkisbhdoya3IkXaLet2tARb25Mv9JWIJKYRD3ID0C04hv5+dhzFJ7Bs+aFsgHJqI+71FprCa
	J8e6ZISa//qV+vsN8Gat4uyVqDbyPLB17DylWirmhd2mgjL/+2YpVrGse8OFDC9Be9Wo1WEthdF
	DanYw==
X-Received: by 2002:a05:6000:29db:b0:452:bc74:b129 with SMTP id ffacd0b85a97d-45ea34accaamr2671976f8f.16.1779367835053;
        Thu, 21 May 2026 05:50:35 -0700 (PDT)
Received: from google.com (197.183.140.34.bc.googleusercontent.com. [34.140.183.197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eaa92ca4esm2708726f8f.22.2026.05.21.05.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 05:50:34 -0700 (PDT)
Date: Thu, 21 May 2026 13:50:30 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix unload_page for simple_ring_buffer init
 rollback
Message-ID: <ag7_llt1VUHDDOSt@google.com>
References: <20260512141614.1759430-1-vdonnefort@google.com>
 <20260521083107.286c5f1b@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521083107.286c5f1b@gandalf.local.home>

On Thu, May 21, 2026 at 08:31:07AM -0400, Steven Rostedt wrote:
> On Tue, 12 May 2026 15:16:14 +0100
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > The unload_page callback expects the return value of load_page() as its
> > argument: ret = load_page(va); unload(ret). Fix the rollback code in
> > simple_ring_buffer_init_mm() where the descriptor's VA is used instead
> > of the loaded page address.
> > 
> > Fixes: 635923081c79 ("tracing: load/unload page callbacks for simple_ring_buffer")
> > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> > 
> > diff --git a/kernel/trace/simple_ring_buffer.c b/kernel/trace/simple_ring_buffer.c
> > index 02af2297ae5a..38cf9abe0be8 100644
> > --- a/kernel/trace/simple_ring_buffer.c
> > +++ b/kernel/trace/simple_ring_buffer.c
> > @@ -431,7 +431,7 @@ int simple_ring_buffer_init_mm(struct simple_rb_per_cpu *cpu_buffer,
> >  
> >  	if (ret) {
> >  		for (i--; i >= 0; i--)
> > -			unload_page((void *)desc->page_va[i]);
> > +			unload_page(bpages[i].page);
> >  		unload_page(cpu_buffer->meta);
> >  
> >  		return ret;
> > 
> > base-commit: 5d6919055dec134de3c40167a490f33c74c12581
> 
> Vincent,
> 
> Did you make this patch because of the Sashiko report?
> 
>   https://sashiko.dev/?list=org.kernel.vger.linux-trace-kernel#/patchset/20260512135420.99194-1-devnexen%40gmail.com
> 
> If so, I think we can add a: Reported-by: Sashiko <sashiko-bot@kernel.org>

I did not for this one, but I have used this tag few times since yesterday [1] though :) 

https://lore.kernel.org/all/20260521102149.804874-2-vdonnefort@google.com/
https://lore.kernel.org/all/20260521124613.911067-4-vdonnefort@google.com/

> 
> -- Steve
