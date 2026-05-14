Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FDF3A1CE3
	for <linux-trace-kernel@vger.kernel.org>; Thu, 14 May 2026 09:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778752497; cv=none; b=SJJ+UTw8S8r0iHP+vkY96vBZTasXvn9kQx6YSbTk9M4fzlQEm3gyl/He/0Ro/kd97PckwA8LvWHYt0vTlDVslvhldfdBRBgqKD7JBV0c1P3gbqKNZINzRwv8N+Ll1h8W+vgxcj7gwH9VIImdLz5P4CAoy9ZLuuddLS1nnb08YWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778752497; c=relaxed/simple;
	bh=MAG50WCad4NRhmMz77hcCq+3OI9FWcjiE4jmtgCNG0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKefZDuYQQlM265GIiO3LHWy8uWUFRuMz58ZqrxY2hycm5RgmjCwCAlhUzPS5uehFrB0imnSt35XtXymxilPDL84xRkw0RkrSvgFYdATEADIGXvrnR/AGDxFkMH9uFlTlwmDWuKPHBakaEmsLCCqLWlOYKyhb/qc+gzBZRxSjxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mFtu4pAX; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mFtu4pAX"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso81652115e9.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 14 May 2026 02:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778752494; x=1779357294; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=six8czTwRWBelOcMuv1R6lBUBlisiB+Pc2XrGTy7dOY=;
        b=mFtu4pAXhbcd1U9JQa0/CT9vPOKqGqaTd7g5ywZeC8Ws2if+1lNTkCWpVylrODmUJr
         Ns+CoefZ5dRNYpxkinpjVkYrMvphCuE/cCKxoOP0sA7Mcc/F80e+7LPRVVmfVpkTeDjR
         d0yG6Gsd7VycNf++c+eAvFHmCptxmvoyW4Id+/V+2yiI+xZfe6Ge27T54nEBjKDEFxgc
         1ydrUTY8ycOyNnR34gdqRIUiHLeSskQFbtYM9P+YRZUJPG99hC86Y0138cklC8IkKsUM
         2J5zWzfCEWjBbUIkSS5oF4i7qBPY/0nhy5yZa3CghDjkAuO710bbwpRHV+n/IZZO8zTE
         33aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778752494; x=1779357294;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=six8czTwRWBelOcMuv1R6lBUBlisiB+Pc2XrGTy7dOY=;
        b=aVdvY8cwqDOBR/Y462b/XQNZnv7Ywxx3xkIUpwUcKwoKy0dkdGXSfxux7DF3Jpu9QR
         2XXclCMxGbgGkrinv+3kGzovIVcVzHITUl16dmr7bd7yCKoQyWCDjTSKfKjgyRmNHGcV
         Sff8lX5vldeUiQXdaOVAF/ulfv0mpopAsNA2pQRz/knZT20HicRddGlAmU5yQ2ru/bWX
         sxlUsrwLOBW3XjlanSSXQcDGIyIN0XKTmxYgUZqxuAAHpJcdMddiNWI6tIGl0+f5/F6J
         vAs3rak5j8ov9YYiuDSyKYk1zwKja43yT5DhOAZ76z+11DkxqL326oYOoHu8LfNYfe6/
         7eOg==
X-Forwarded-Encrypted: i=1; AFNElJ/znW43oatXxBH+Gyg6UbJH4gVHK7ak+Oc4PiJTjEo0BijSMEL6eKW2hlcOihmxDlfMHp6yoCiiu3IyzQ7sd/8uUV8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc9WPuJZLHiTK09+qCx/rth6vlYlb3rY7vnckqBypBKzCJkf9x
	eUv31LxwMLZ/Sa/UVzxwqgBuRch8Vzu0y4bETx0WkBphUbzMX4/FjUkHpdEbNmMXBg==
X-Gm-Gg: Acq92OHHAqhKqJFMQZtV48vwvi3s0kwMo4sT2ySpYQ9n7LXWgUI+FlgxQDC4dUCikmw
	XSH4lKVFYzJL80zmUTYWywN1qS+By2S603JvumQE9ppI/UIQ5K/juEm9XD7RCyhvKld0ifaYCVM
	HmlwlMKLESCI0VzVO4R3qFPgEmO8TSklbNEly63GpUS07nyMOu1UbY+1i3RTv70F/DtItq2tjnV
	PnyGpC4W77cpV42g43uH5pR4zpYZ4TuuD4TNagagejEVrcRKjd5N8AKXZA6NCsWcEo3JITnuaMg
	UnVz31EVY4oaTxVqj3HkM5EeKFL4c+GVHzet8EXGc3H98Eqne2DuWd51/a/dgmhx5pHmQ9kLYwc
	GuvDl/en05Dh8fDQT2RLcJEg8QalPrLk8GuVTW1o46QQ2/UCj3CvPdTrBJE9+ZTHs0qYwyqOTo7
	jwUDVrULCEuSP0VwguPlQrrC1VxzDoMimQSECbIOs8xQo1IeOs3h6x4x5Rdc+nFM5ycY61L26XE
	+tfbA==
X-Received: by 2002:a05:600c:c057:b0:485:3c2e:60d5 with SMTP id 5b1f17b1804b1-48fe245d443mr3433095e9.2.1778752493832;
        Thu, 14 May 2026 02:54:53 -0700 (PDT)
Received: from google.com (197.183.140.34.bc.googleusercontent.com. [34.140.183.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd6301bd1sm17220565e9.11.2026.05.14.02.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 02:54:53 -0700 (PDT)
Date: Thu, 14 May 2026 10:54:48 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Arnd Bergmann <arnd@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: samples: avoid warning about
 __aeabi_unwind_cpp_pr1
Message-ID: <agWb6DvB1MdJ12cB@google.com>
References: <20260323105646.590718-1-arnd@kernel.org>
 <20260513105939.3bbdc174@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513105939.3bbdc174@gandalf.local.home>

On Wed, May 13, 2026 at 10:59:39AM -0400, Steven Rostedt wrote:
> 
> Vincent,
> 
> Is this patch needed? That is, did it fall through the cracks?

Yes, I believe it is! 

Reviewed-by: Vincent Donnefort <vdonnefort@google.com>

> 
> -- Steve
> 
> On Mon, 23 Mar 2026 11:56:41 +0100
> Arnd Bergmann <arnd@kernel.org> wrote:
> 
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > The now more verbose check found another symbol missing from the whitelist:
> > 
> > Unexpected symbols in kernel/trace/simple_ring_buffer.o:
> >          U __aeabi_unwind_cpp_pr1
> > 
> > Add this to the Makefile.
> > 
> > Fixes: 1211907ac0b5 ("tracing: Generate undef symbols allowlist for simple_ring_buffer")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  kernel/trace/Makefile | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> > index d662c1a64cd5..aba6a25db17b 100644
> > --- a/kernel/trace/Makefile
> > +++ b/kernel/trace/Makefile
> > @@ -169,8 +169,8 @@ targets += undefsyms_base.o
> >  # because it is not linked into vmlinux.
> >  KASAN_SANITIZE_undefsyms_base.o := y
> >  
> > -UNDEFINED_ALLOWLIST = __asan __gcov __kasan __kcsan __hwasan __sancov __sanitizer __tsan __ubsan __x86_indirect_thunk \
> > -		      __msan simple_ring_buffer \
> > +UNDEFINED_ALLOWLIST = __asan __gcov __kasan __kcsan __hwasan __sancov __sanitizer __tsan __ubsan __msan \
> > +		      __x86_indirect_thunk __aeabi_unwind_cpp simple_ring_buffer \
> >  		      $(shell $(NM) -u $(obj)/undefsyms_base.o 2>/dev/null | awk '{print $$2}')
> >  
> >  quiet_cmd_check_undefined = NM      $<
> 
