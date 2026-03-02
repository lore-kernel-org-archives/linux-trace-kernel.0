Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D2124634F
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Mar 2026 08:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772438910; cv=none; b=ANm7Y48ZjVTrEK/nPskAu3hCOOhjsAvbMxUwUZ+yK5CgXvLhSC0QgqLmR9W67eUwh57wNizTmGLRXQOtODgWrX87K99CHGl3GMEQRRpC8Z6v5empBeiXqCjKZKLKtmEA/rYiEAQ9bSP8Y8/nrdcKLgjOcOsqx0CarM2IjZUrLbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772438910; c=relaxed/simple;
	bh=7dXyK6ozsmvSacmZBQXL9e0JKE9D+/u5o80S+8Bbcz0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BqKVmqJi9FBzOpDFEYLuwkiby4zpxD3dw0307xt53+DWGsiDs3m/X98th6e3qS1+EgOSbKiAQBLddd+HUY3QcbdT+Yob550HpFATZ4zbNrkK1PpJvIe9q3fyeS3iYaH6KR2UQ5uSnRJ552JRKdSE+AzbgPS2q2RTYCUmwFGAtzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kgg9nmyh; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kgg9nmyh"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-439b8a3f2bcso330866f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Mar 2026 00:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772438908; x=1773043708; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Aywtoeuxkfunv4Ek8XeTDfrALEqJk4nC+4MbytSvfC4=;
        b=Kgg9nmyhwDp4M9HxRLZCuIzZA5/Uknb/21gXD8tW16u5VXQD4uOaRRjOMRLa+S0ln1
         FYMh4hRMKsAw2/Wavl65DdBmEgXh1i3cWcRu+Cmn4RpXHC4nkqMS3rwi+XdnHfoYv8zd
         Be63uF0qJAXsPox8RWRIf85ptWQamnaqYsPR8xf3lQxf0IMC2TKYwWM1T6woajuXyBp8
         ZTn8y9u/6mPs6HszeDO6EyAHc4jGwoPOPmUkfXBMnUTChdsaM1TztplXdqOyI9fr475f
         zCSwJ6ES3MA1JSGGMD4C25ZDEN27Fg3hXiGardbuEYDyMeuteGkTmUd2ccwlcj1hzPll
         fMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772438908; x=1773043708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aywtoeuxkfunv4Ek8XeTDfrALEqJk4nC+4MbytSvfC4=;
        b=QCKtr5E/i9PXkpatsgExvTVd/Tj5q/AdyzhbB32gDsvSdXMh1R5yYaHehobJQD91LH
         c/Qi2CYJ/3Ix4n67DqL3ZKhdt+N2s3e0yxIibqBiM5tQO1Av9OcNcgoc22pln4xCv0j0
         ZJv+MBut46Q/s6exwwKjLxc3BZO84Ad5n2H62WLxhgSRLqC8mIqbHuhU1fKHqkFpHxR0
         ayWwpCOxUZYn7yvpwgx60riYb+oMJG4TKJopaBhk901rtLIqK66EZnLRMiF3LptJvCAl
         VXYhBmgLsApOi80eDs15YCioyGiF/hL98Yyhxw67Ljo6ZFubQJNvR7Nr0ksTBms42t+5
         tzbA==
X-Forwarded-Encrypted: i=1; AJvYcCVdDxIvfDeaf5trCqYqGCFaaq8Gjb6aNUnNPYXfjPXjM+aBtbJ3aDxoV50L6HGL7zWUWh01DyWpVD86rwun+tzKQYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4PdpG7fG1VacKjasjFK01LE/iISw2ssjdF1spe5FCbOlMQ04Q
	D3lWrDQjJhh3w17cwm4gvunN9Yg0VQvwWGwptW5GMj+XtZN8dN408K3A
X-Gm-Gg: ATEYQzx4bbu9M5hzFFRHlGTTbyVA3fiJX3eK2ofFirHlbvhF+AteYb8uIYhxKn5PgnF
	r4aLooqCrWxsfDMV/RsM6/GlxYwABIvzn38mLVRpZ20TCpHRJBOeymdL0gZkNaO1MiepA3APb1e
	u2Zcl+2GGmd1o79Os0n2+IvVR1+zRg8LrorcNzJAKEL9OjNmTpYPqbB0YNi7X8I7w5BGQu6MYw6
	J/r86KyDNchwtcE5KMuWiH3Zchh2YtEhCyR+td2pctEy350/nhWG8wZdQVKdhY1072H6ORHIRTB
	H6YWDqHGUZ4lXnNcWvDeAX1bHh1I+9AdF3DUnAu4NHB4E/tdd1d1fZpYUbTSQt8V9fAHpthFmek
	CMZAcHnAAdf1Ej51FtVtOjnC5NtJN7ZVFea8gWZqMDOmmrcRKhTbs61U+jRKQ9FXiswLyvziU
X-Received: by 2002:a05:6000:2404:b0:437:6e55:a736 with SMTP id ffacd0b85a97d-4399dde3046mr20509566f8f.7.1772438907722;
        Mon, 02 Mar 2026 00:08:27 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c75a25dsm25282488f8f.21.2026.03.02.00.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 00:08:27 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 2 Mar 2026 09:08:25 +0100
To: Steven Rostedt <rostedt@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Ihor Solodrai <ihor.solodrai@linux.dev>,
	Florent Revest <revest@google.com>,
	Mark Rutland <mark.rutland@arm.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: [PATCHv6 bpf-next 9/9] bpf,x86: Use single ftrace_ops for direct
 calls
Message-ID: <aaVFeafZb76l9L0m@krava>
References: <20251230145010.103439-1-jolsa@kernel.org>
 <20251230145010.103439-10-jolsa@kernel.org>
 <1b58ffb2-92ae-433a-ba46-95294d6edea2@linux.dev>
 <aaIAoBZGkP7RQrvc@krava>
 <aaILlSuEgaYDq41r@krava>
 <20260228153921.19cd42a6@fedora>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228153921.19cd42a6@fedora>

On Sat, Feb 28, 2026 at 03:39:21PM -0500, Steven Rostedt wrote:
> On Fri, 27 Feb 2026 22:24:37 +0100
> Jiri Olsa <olsajiri@gmail.com> wrote:
> 
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index 827fb9a0bf0d..e333749a5896 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -6404,7 +6404,9 @@ int update_ftrace_direct_add(struct ftrace_ops *ops, struct ftrace_hash *hash)
> >  			new_filter_hash = old_filter_hash;
> >  		}
> >  	} else {
> 
> As this looks to fix the issue, just add:
> 
> 		guard(mutex)(&ftrace_lock);
> 
> > +		mutex_lock(&ftrace_lock);
> >  		err = ftrace_update_ops(ops, new_filter_hash, EMPTY_HASH);
> > +		mutex_unlock(&ftrace_lock);
> >  		/*
> >  		 * new_filter_hash is dup-ed, so we need to release it anyway,
> >  		 * old_filter_hash either stays on error or is already released
> > @@ -6530,7 +6532,9 @@ int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash)
> >  			ops->func_hash->filter_hash = NULL;
> >  		}
> >  	} else {
> 
> And here too.
> 
> As there's nothing after the comment and before the end of the block.

ok, will do.. the original changes:

  05dc5e9c1fe1 ("ftrace: Add update_ftrace_direct_add function")
  8d2c1233f371 ("ftrace: Add update_ftrace_direct_del function")

went through bpf tree, so I'll send the fix the same way,
please let me know otherwise

thanks,
jirka


> 
> -- Steve
> 
> > +		mutex_lock(&ftrace_lock);
> >  		err = ftrace_update_ops(ops, new_filter_hash, EMPTY_HASH);
> > +		mutex_unlock(&ftrace_lock);
> >  		/*
> >  		 * new_filter_hash is dup-ed, so we need to release it anyway,
> >  		 * old_filter_hash either stays on error or is already released
> 
> 
> 
> -- Steve
