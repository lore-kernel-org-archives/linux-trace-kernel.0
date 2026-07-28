Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAD4442111
	for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Jul 2026 13:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785245955; cv=none; b=JLWxxCKbB6t4TY8FCR16ai2UuSM49mSQMzKBexO2VkeU/QqhO8WV5he2llOnu/+QpVlUFlHtIzar1SxbGAWS4iofzZFqKOFNehR2N7LN4ClrXmHdp0pEGng3UoVwhnoRuLBZc2m6aNGtHYaQ3cYqfk3JyR0MV1Kj8X9Jn1veFY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785245955; c=relaxed/simple;
	bh=m1hRgnx9KR+o6rJ46yZExEf2MnNgmZrIfD+GztQKaJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fslCU92yoWr7VQb6dNS/dCJE9VNqkYrz9Xj6a5+ylNrEdpDft7ALSKZg0klzl4brnGP8r7agKqth4bZHixIDMT2qvN/x7NddhEWse0aDRjr/1sAZ1mXcYHYiPQRB90W75SJtw+bApcUnk2mR0qYAV0kkNuyieczfsYc8E1rl0Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UmvgXyD3; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmvgXyD3"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cad8076b01so48424785ad.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Jul 2026 06:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785245954; x=1785850754; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gWLSoQUrxbW8ffU1hMIvqVbw2cAnieAmgRFRZP9/rN8=;
        b=UmvgXyD3wDMFwL1U9jBb5r14mLE26BB+n70obuNy/VNgrZIM/dxmsC6ZI8DDbT6I1K
         PXeMb5en6gLtE8LODMIj7Al9mCPhGKwnuDUE+CzYG+k6x8Y9iMhgfwA+0RDFDSnZVImr
         0fAgMpdseXD8N5Ok46CDOm5FUcP7SYX6NCxnNiE44htTc2Qoio9GWnm5vN5mGj/4bNGv
         dNloTtRsyjIH4z3b9Us5a/3oH+ak9uwEJNLPdFqTqKs1Y7IdFuQQHianaYjyfLt7JN+p
         BNv728igH5fIPtZ7dqaVhR+56HCQvmZyRUfQzgz8Ckiei/NIa3o1COs7dKI50GXlOhp3
         Ig/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785245954; x=1785850754;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gWLSoQUrxbW8ffU1hMIvqVbw2cAnieAmgRFRZP9/rN8=;
        b=ZdLx7p98x8NLrRDKidHeqViVXNT9i5GRpzkBa5YwUuWmuRDKjr0qq7wf3+t6g0e/Vf
         2ta684WVfCMKWdeExXLYsHb3cca6+BeSxC0CJhl1+AOdFmnx38+MNREhP7r/9pAxcwD/
         2IIGk2RK/0jEZx36Pbm7FdwBpmgEX61EtwGyntg0Wv3qkmZLVCk9Q4QiKtxTAuYjyI31
         rdJkO2+/JPcpCptqjZfk0K7wWb0yFBSxTWoFPA8PSKOFKCd37+Z5PUrXuVt8vz8TNeeG
         x9gEM3imI3C3tN358fNVxBdm6wGoNm8Ltuxz2mcIxhMEmirwjYLwRUvcZJLgrGEQ6JjO
         DpjQ==
X-Forwarded-Encrypted: i=1; AHgh+RpJhY26N9EPPULhN6fZpDFQ5E3CMnrwLT9488duxIxoEmAnpRUHU7RDNmrd4AQBr1ElN1HUZcFyJ3G+woUayQmCwvw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6wlj+g8c06eXuyZhP/VHSUe+E4MyEEEkklg6B97zzsRkq6DT2
	2XyyXcM4wgYV93gj0DxDkntoFy5LI8m9JSgozqCgAUIO/o3U5sBo1CpA
X-Gm-Gg: AR+sD11JDilgnwVlCHDfPOu+r8dm8I4wnyx2F4Xo0nu1FLua+bk8DStzAOu5mFOH3AF
	o2sDV5Alx4fQSILhnMqAIvVYiIHAI7nyFsFrcmlBNx7S3fXVtnUKWpjHaSIXduetFLuphWEzxFr
	T8bUMerYWtcNrpc2WBZtPbu6K/R3FgXqjlIRl8uI4UVV9mBIXmUQ2YdfXDrq+oOnJhy9ONJpPYv
	CkNUVCaB/tf5bMLcvOo+2+PXNax5A/d6dkOfFA+sUyIxDO/nm9xO7SrFC1PR8XRw/ZXqMk/9wbQ
	QNadEkKLqG+zhxsnsqApNAtQdkljQBePAEIa7OVmsrRqM86FMagCIKmo7K6j0BJAsmz4O9bKGRi
	UaTOYtL/HYJzNg/rtXMrGSm5bvzuRWne2uivbFRyDdpZoxNsXGsvQ8yKvatycGeWGo/xTxA6Sx4
	3od5f7A0H5nUVhAS09KSj4QOFwEOYzT1m8F7vku3opEi9lJ97aBL72mUpx37sFY+M=
X-Received: by 2002:a17:903:2308:b0:2cc:5fae:cc56 with SMTP id d9443c01a7336-2d015d22fd0mr28987505ad.27.1785245953525;
        Tue, 28 Jul 2026 06:39:13 -0700 (PDT)
Received: from localhost ([118.34.230.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde80ee56sm52793285ad.76.2026.07.28.06.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 06:39:13 -0700 (PDT)
Date: Tue, 28 Jul 2026 19:09:11 +0530
From: shaikh kamaluddin <shaikhkamal2012@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: trace: fprobe: fix 'thos' spelling
Message-ID: <amiw_5EeKOErKhD9@acer-nitro-anv15-41>
References: <20260726065633.20897-1-shaikhkamal2012@gmail.com>
 <20260728214645.1e0584e6e654bea696294662@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260728214645.1e0584e6e654bea696294662@kernel.org>

On Tue, Jul 28, 2026 at 09:46:45PM +0900, Masami Hiramatsu wrote:
> On Sun, 26 Jul 2026 12:26:33 +0530
> "shaikh.kamal" <shaikhkamal2012@gmail.com> wrote:
> 
> > Fix spelling error reported by codespell: thos -> those.
> > No functional change.
> > 
> 
> OK, let me pick it up.
> 
> Thanks!
>
Thank you Masami

> > Signed-off-by: shaikh.kamal <shaikhkamal2012@gmail.com>
> > ---
> >  Documentation/trace/fprobe.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/trace/fprobe.rst b/Documentation/trace/fprobe.rst
> > index 95998b189ae3..46dd46a97c1f 100644
> > --- a/Documentation/trace/fprobe.rst
> > +++ b/Documentation/trace/fprobe.rst
> > @@ -118,7 +118,7 @@ will be cancelled.
> >  @fregs
> >          This is the `ftrace_regs` data structure at the entry and exit. This
> >          includes the function parameters, or the return values. So user can
> > -        access thos values via appropriate `ftrace_regs_*` APIs.
> > +        access those values via appropriate `ftrace_regs_*` APIs.
> >  
> >  @entry_data
> >          This is a local storage to share the data between entry and exit handlers.
> > -- 
> > 2.43.0
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
