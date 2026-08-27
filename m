Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8739733B6FC
	for <linux-trace-kernel@vger.kernel.org>; Thu, 27 Aug 2026 06:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787812293; cv=none; b=W6whDtD0QeO2MS15SMlWXhtjPd1TJbWhfIkdU3AEdtNE3z4PLB5QIrQcNCyhe92d8lx/xCm9LVQKAxjSHDyEXHoaRBjO6DfFZk/xovDs89J95vMA4FPVcw8MtvEh7mse864vbjyZxAQ72LPZnYPfqRWVIG/70B50UAblupMGPnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787812293; c=relaxed/simple;
	bh=PQJW0gtfjQdQxKlaVpGRswhwcfYlvbiZR0iPxcWW0nU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMSvUSckkgLVMRw0LKRiuMGbNcQ96dHf0/BMnukgDENRFv7+auh3X2rqyP+icOZe+tqbFw7uVFwxv7r9lSru4O+33SQVGkVcLa+gAUfkl0bR2sUazgRorC99NullwN0QKA0sUT5D6stfZIkZYB7yDBJMYWT9mWzjDyw4+EMKfTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LIVEom1m; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LIVEom1m"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49978908b35so12465345e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 23:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787812288; x=1788417088; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iSQ1KNoIXoA8gP/lmKjgXg+CsD3Ak0JaTckzQJGWTIE=;
        b=LIVEom1mBSpFKgzVyQ2DjfEIcFEq3fZw5RVTMSreIPo8tYPuBQS8qVfuNPLlIZJ346
         97W8OI0jI2SAbjMCFGpJ5PYzG44q3TyYw9ZLz7fnsUBmenQkj7XuLsCeuVPw1SUOqcGw
         I2jo9ZRqTqNXBqOmPJACqEAO5A4Jq1NO6Msiv0Nixy+788XbBxNjdf1eXU4cToFjTT3+
         8e44H2rq/7Db2sKtFMo8OcbsurtbR9B4Tlojr9tCarLubrNmV41urlBq1c929JfmH1HY
         MEmSxUiVgKyQuAiv6O/tYu9oUYYJ4DJ9Z34MSEejRxhl5cDp/J6IOnZwBIHAHJXZyxQA
         4JfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787812288; x=1788417088;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iSQ1KNoIXoA8gP/lmKjgXg+CsD3Ak0JaTckzQJGWTIE=;
        b=I+dm2rQdV8WTzWxbpZW0NF6rhLIhJq6VUvSmGIhKZ26lxSrcvZeQL81J8l3sXl3GRm
         k+I7fnRd2h52PUoqTJWXN+604AJ3C175mGtVoXv6zFnSRHrB5u4FDVMO/dIhNaYnIIXE
         ib2fXz83MVrEQIb9iZPBZFT0sz3c0i7j46m0kHkNLQezsEdUyBucK+BQwllOABHVFkLd
         ZEDmyqxflxiJWnn2sZ38SwrsHlcMxjx395NOsh7bSa8ulktp+4C0K6qfhLlZ2m1XPCi5
         z8iaKOkkBR2n5uS/bc/BVP/WZEiY3PaXxqKvfXWZJ5KTYhQDh+z3q3aHAxAZDo9v1jnr
         cbTQ==
X-Forwarded-Encrypted: i=1; AHgh+RpjMtxpA8cA3gD4VE+aw5SdZ26yr4pvPMrv2sVbuMB0pygMhhR9l4uVTYtNUIc2j6Ne7zfI5auZfIu+hH8DrYjmydc=@vger.kernel.org
X-Gm-Message-State: AFuF++lCyZbY3zJgFctlofmY82R5YzAXMZPy4Xn/ydsdcMXNbfhTAtVi
	CFT+XE2lTzwueLVaomSdLc8PgKmK2Pvw8ew19msvEdwRmswrMxQCxco30syuiSqN3BTcpliGhLc
	G3BS6DW3o
X-Gm-Gg: AR+sD13vAAnbw1tPAtC86GDM/cBc0JRj/H9oVfVdfSwH7CUufgmZAQVLee8pqEI+2Uu
	rI/mPnvQ66NPRusGwYnGWCf76hbASdse9u93qTnywZkwKhWqOLBrPzyO8bs7zf/kJrPRbMnhD9m
	2yqDh/8q53RHcDQZ/nfCu6BNXcU5THb9ykHk1nrXbhif22HcX05OyVcHrgMv4dZt6uTW5uznVET
	iFKCtfb4mrHCUGSwYtLWX17K5y01XmjtnyjuNLQ9fAAcFVvsB0Yd5Jbq5MfpiqUzT6Hmio9gehd
	gnCXljmAI4/EZNxbtlARqVacEidl+pRPpbhTBmYFm/sIsjNdkYI1HXoVUeGCLKK/WkWLWSZ2Lvh
	AuS9RldoGpXRz+L5ZFhOzk1jttaGMEZO74zTWLu05AUMxO3K+WEBCh3X0LlkuZJRPclLFNYplND
	LtYDu+Mie4rJ9bmVFMtEO/Fiomi5Sqeys8GZhR4W7pZyAAqRz7Ia2N9RAE3e1ckCNI0KzUxhuEh
	U5I/lQBs26hzioqmUhAlW6UX6uiub2S
X-Received: by 2002:a05:600c:c118:b0:49b:c8e:8e6 with SMTP id 5b1f17b1804b1-49b0c8e0911mr70740995e9.0.1787812287225;
        Wed, 26 Aug 2026 23:31:27 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b8d2ba486sm6856615e9.5.2026.08.26.23.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 23:31:26 -0700 (PDT)
Date: Thu, 27 Aug 2026 07:31:23 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/3] tracing: Fix subbuf resize races with
 trace_pipe_raw readers
Message-ID: <ao_Zu0ThaWThj9YZ@google.com>
References: <20260826094528.3738023-1-vdonnefort@google.com>
 <20260826094528.3738023-2-vdonnefort@google.com>
 <20260826095947.4FF8B1F000E9@smtp.kernel.org>
 <20260826103736.2b55b464@gandalf.local.home>
 <ao8TQ-SvhjYgy43-@google.com>
 <20260826143123.1b3e3854@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826143123.1b3e3854@gandalf.local.home>

On Wed, Aug 26, 2026 at 02:31:23PM -0400, Steven Rostedt wrote:
> On Wed, 26 Aug 2026 17:24:35 +0100
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > > This is a legitimate concern. But with an easy solution. Perhaps just add:
> > > 
> > > 	if (full &&
> > > 	    (!read || (len < (size - read)) ||
> > > -	     cpu_buffer->reader_page == cpu_buffer->commit_page))
> > > +	     cpu_buffer->reader_page == cpu_buffer->commit_page) &&
> > > +	    data_page->order == buffer->subbuf_order)
> > > 		return -1;
> > > 
> > > If the user is changing the buffer size at the same time as reading raw
> > > pages, they get what they deserve! I just don't want to let the kernel go
> > > into an infinite loop.
> > > 
> > > -- Steve
> > >   
> > 
> > Sounds good. Do you prefer to get a v9 or you fold this into the existing commit?
> > 
> 
> Please send a v9. It makes the patchwork flow much better. If I modify a
> patch, it makes patchwork not be able to automate the status updates as it
> moves around git trees.
> 
> Thanks,
> 
> -- Steve
> 

Looking at the function again, shouldn't we add !rb_is_static(cpu_buffer) as
well to the full page test?

-- 
Vincent
