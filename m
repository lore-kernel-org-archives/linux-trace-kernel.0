Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EE62D3A69
	for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Dec 2025 09:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766136457; cv=none; b=Tj+RwzOJqixEJkhcShybOPpNkB5UwQtPFOHkZ7SI5xXood3wD+YHJe60DdEldttsAlBWdrvbFNue8+phmV3z+A7u3mZu+V0dDXOxI7RbcnG/M4tSx+sVBr+NF1q8NdsXkjZpNtm3dKUCXMx63qulbExinrOasbuJ4OK09yEJ/BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766136457; c=relaxed/simple;
	bh=ncH0WX29PmKWXHkMb9W7MxVSClntPHuEcroF5q70h10=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZrjcXC5c6WB1cXB1iaQmKiJn5Xea5NVA/WaauzGXgaQelUv20HMbeAaFx0toZ6PpOeQ43ewoagP+EB+FmYX2HviRwqFoUwK28XGWjywuWMH6qG1qCqKPsrqHodeUaxJYdebArTa1oPhRNyWfLlD+4KpTI8u3w0x3lzdLGFrcXAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+WcGS3v; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+WcGS3v"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-430fbb6012bso1091165f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Dec 2025 01:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766136454; x=1766741254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wW6xT6zKa/DbjWLXugE2SCCRWvLGUmWxnxjoprlKdVA=;
        b=H+WcGS3v77jbJnwUDd+ufnwpnCE2+JOwndJc72wRCz1TiTv7SbKQ+L0AL+9b2MdR0b
         yLitPq/QpQ/mA0uuB3ZVM2uhcCuEM+kVTU+ztcyLKj8FXsl+ZNysvtG0tZbv4ewOzlBL
         5MO2hjatAJxRjfsSTTC488uTiSBYw/NnDCJ1YFnrnfG4pRuYi/BpDxW6ddZRwU7e+LsC
         p2laa4toWEalNK0JQAatQrDrwd6PTIjnb8Zf+kJgQiJlelYu4zFXZAts1mpT0KGTjFPU
         na8j7lbGWRBbkQcsWnHKpj7lx4xsfUfnzKPNxaBBekIoDZCesM4lfmXNul6KBlsBIsVM
         iI9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766136454; x=1766741254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wW6xT6zKa/DbjWLXugE2SCCRWvLGUmWxnxjoprlKdVA=;
        b=pBd3JKDeaPBRRtAFAwf4hLG0V+cY6BeAnrIws4QZhMrPUgcdEc3oGSF2hlZgFIMDVP
         B08QXmBOSvjNxfPEYzZcpLj93lwSwY9HeAP1uUNL8KDLqAYCJqIhN3duXQCeUWroH10b
         dC+C0MwR/dG4z5YHRP1hLD9dwVm0J90rshwPnhcEUF8edG8kZx8Ef/P/Uu67G28UJV6K
         AkKOD8JjIj5qVRiru9Mc4RTgSVkdn1llJjP75o5MZ7rHl10C0QpGQ2Ly1PMmt4Is4tUW
         gVmdV8jmKjVj3CwdZRzwXwIEheYnayuA0kN4cuLozVykt/bsCO2NwmeI/FCBB8Oj6sq6
         IXHw==
X-Forwarded-Encrypted: i=1; AJvYcCVCHXfX4vILPl9FR0zkfVXKQPKy59X6Vm6L364Kwp0op80ZrcoqgzLzS/29ytspemcHfIUTFox1Yf/s3ZqnKsQ6Ta4=@vger.kernel.org
X-Gm-Message-State: AOJu0YywYqDaj4iXfBONBQjl6dsGrt6rIeCsXtTrBV+8fKoFy3o0ZM8Y
	b1YLhtN+nZK+0/IcYCwpbmtPniJ7fgRpd+4WXTOa07Q4CG0G6KjBr5nS
X-Gm-Gg: AY/fxX5CZXBGO+VGwnxEyWceNzcPh67xI7hwJKjtMzqgnzYN5moEMfZ55THRzwyZTW8
	SBalOwl6mz7bhTHx6DUEBDcgXHs1MlFQi4ePGGjlp01HPRqdoVjJxs618JkyIQSP1Z/N3hTzel8
	iKuMMWREkxT77NYAm32RUO9iqpjA48y5tXDJxFRWnfki5IV1S1BPxK28UYMryX80bqle1qhTg+o
	FnMhrfHC+wlZFaBlPqPkSAECXN9HZeiZ06pjeNU6sV48YpfTiFpdpG5cjq0abnwiFMBOgfKYZBL
	WIZ7EKj7K749kwpkxIkBWPnnktBnx2xfVKHLMRF/2RjZ12SioZT7/u85gXW6XpP/oSBLuiIYylq
	LqzBps+c9lBaEgjh7mxn+h+06ysWAkEExhq9v3zyREIa7S+txo2CH/r5U1VST
X-Google-Smtp-Source: AGHT+IGZerDxPd0b4gdsyGcPyDLXRMjKat7AKujtmwuJrtu/onCDnzbnfiuN8UDjCgD2FYBSHSQDtg==
X-Received: by 2002:a05:6000:24c9:b0:430:fc0f:8fb3 with SMTP id ffacd0b85a97d-4324e506148mr2457124f8f.38.1766136453761;
        Fri, 19 Dec 2025 01:27:33 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa08d9sm4154643f8f.30.2025.12.19.01.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 01:27:33 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 19 Dec 2025 10:27:31 +0100
To: Steven Rostedt <rostedt@kernel.org>
Cc: Florent Revest <revest@google.com>, Mark Rutland <mark.rutland@arm.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Song Liu <song@kernel.org>
Subject: Re: [PATCHv5 bpf-next 3/9] ftrace: Export some of hash related
 functions
Message-ID: <aUUag8LVUy2CTNpS@krava>
References: <20251215211402.353056-1-jolsa@kernel.org>
 <20251215211402.353056-4-jolsa@kernel.org>
 <20251217200712.606a9a7a@robin>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217200712.606a9a7a@robin>

On Wed, Dec 17, 2025 at 08:07:12PM -0500, Steven Rostedt wrote:
> On Mon, 15 Dec 2025 22:13:56 +0100
> Jiri Olsa <jolsa@kernel.org> wrote:
> 
> > index 505b7d3f5641..c0a72fcae1f6 100644
> > --- a/include/linux/ftrace.h
> > +++ b/include/linux/ftrace.h
> > @@ -82,6 +82,7 @@ static inline void early_trace_init(void) { }
> >  
> >  struct module;
> >  struct ftrace_hash;
> > +struct ftrace_func_entry;
> >  
> >  #if defined(CONFIG_FUNCTION_TRACER) && defined(CONFIG_MODULES) && \
> >  	defined(CONFIG_DYNAMIC_FTRACE)
> > @@ -405,6 +406,14 @@ enum ftrace_ops_cmd {
> >  typedef int (*ftrace_ops_func_t)(struct ftrace_ops *op, enum ftrace_ops_cmd cmd);
> >  
> >  #ifdef CONFIG_DYNAMIC_FTRACE
> > +
> > +#define FTRACE_HASH_DEFAULT_BITS 10
> > +
> > +struct ftrace_hash *alloc_ftrace_hash(int size_bits);
> > +void free_ftrace_hash(struct ftrace_hash *hash);
> > +struct ftrace_func_entry *add_hash_entry_direct(struct ftrace_hash *hash,
> 
> As this is no longer static and is exported to other users within the
> kernel, it should be renamed to: add_ftrace_hash_entry_direct()
> to keep the namespace unique.

ok, will change

jirka

> 
> -- Steve
> 
> > +						unsigned long ip, unsigned long direct);
> > +
> >  /* The hash used to know what functions callbacks trace */
> >  struct ftrace_ops_hash {
> >  	struct ftrace_hash __rcu	*notrace_hash;
