Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6957D3D1AB7
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 07:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783670339; cv=none; b=XY+5FE1LHQbc/Ml91ubz8JHAOjUuXNZaS3lH2GRI8wEnJzoJfNGNldJzlu1yfvGpvrGwaMLfJhM25dmZmLP9QtWv0k7JIxpNHqi8UTNTFMoqLa0kOcTtepgvbMANBk6rDlf2RabmiHfMrvUDfMJXwI/XSuDI0ijTrnxQdBCcmoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783670339; c=relaxed/simple;
	bh=AZOVdK4KCiMCbqBmB8VfLClAg517289sET3fT5UBE0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bff8Q338S6BPUDYTHz9lX7MV6fve9PFJBvdk4mDeYZcITPEWDyoIrm/ChTegtEWzh/2+z2B797nV9QO7+QNWInjYIZpO+hfUjNqh5pqMTt88GHa9si5tcY+BRlAoueb9zlRkk2UTkwRw4jMfAKjO+nXq21jS8uJy2ptMNDzikgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TNsG0WUw; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TNsG0WUw"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493d92b7db3so5698115e9.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 00:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783670337; x=1784275137; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o5q0arahAtJRDOJ0dtbcAGXiTRsBAWSSsiAf5jwEM58=;
        b=TNsG0WUwww6fSktJWLxNkky44OxofziF1MoiDWVHhzvlFtjieeew3hl32adHhSkvdi
         IH3KJKvFJd3p8SNxmRPiNH/ztKvk+171MvIrVYw3kvcSMsPwtGQ26obWcu9nBx1/TnGe
         O95nxRXA+CEqpYY5JaC0tzhGAAR7FCOI6oJvGgBQvGA3vrX4bR+GHMfQxpkWiNpej03c
         2tbxMde3qIM6B1cO0BOGTQ5BrjD88A3NOKsJUnDyP/0DHcfCUqOZJc3IMaVizsY9h7py
         2CDc1WqCjuvkTXeL0aDs3pFIa7l6QavoOoKF2FB5mvm80QjiFONfmmXT5bZjBkTXrbuA
         9uzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783670337; x=1784275137;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o5q0arahAtJRDOJ0dtbcAGXiTRsBAWSSsiAf5jwEM58=;
        b=SojjDMoVl64yB31WbmyudYs6BSymcOws8EBFhgq3oAL4zefGjN3SHHW7IzcZxLIjVB
         zfumz0FEYomwvCPXYS26/hLUSBBR2itcr4mQDqF2LM99hYuLCzNPm5FuKJ1DVI042SFf
         VHPszdDlFm0PGeiK2dLHfAIsyBEAL/1BZeP16o6sfdUA0e8+Imvor2R++JnvdCWYvEM5
         fXL7bCMi0yQunly7pFXHnqajkh1HMMNgE9Mc5Ml41YdFHZrIYzug7cxhZFxVyLwHwu8F
         mQzay0oCvs+eOvF9usWfKJdGy0Tckj5xAPDxElyoCjG+4RKGXh4PnNtup9QuLDrYVKuJ
         Sbxg==
X-Forwarded-Encrypted: i=1; AHgh+RpwKHanAMVv7RRVaINCShNUbrVVGkWu8KOhar2W4ROPdWwsRJe8EJIa8M+fcJD0aioYHoYnBbIEF1LKUy54WkWkDls=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPpGbjM75PHy4upqpKlI96GSZNzar2zkmz41q9ieIXFy80wWde
	M0cGsC/PctYtrFJFDsZWitftvYAssu/vcYnkTASb3Lax+dRvUOjoMwExYgywvJKBGQ==
X-Gm-Gg: AfdE7cnPjNz3JVG7U4slnSkznct/k/kTtpMjX4QwhOauJ6zVSJ0jakeQLWAevfY6l04
	tHH/JFzpfUHC+GsB1rTAyDTW1MXKTVxIEawcdbwO/j4KuHhvrQkcfO0Hc3sFXrgPdZheGgfHFNR
	blb+ORAEFzgBUfsq0EyX42uhBTU7hYrBRE3ga+Lxu1b0dO6mtdjldf6T8on9eAtDAhULQkEpxnm
	JoM6ELfvNK76f62Cr7/mBa7ShoAUMOVLG320CP36lwRGeIoq1beyQSl6IxlQ73IeeUDxKRXiMiD
	tSOsdlProcSPOTPh383sGVNwSsadda0RdLXYQ/E9Yq9EQEULVJLxBhFJPdiV9EbemGpIyal1VU5
	D2laBny2B39FE6/ea+zMuZmY3PzXXQR4XY7pyY7uXny58DBjhla7iIF/knO7hp26qThJ7db9ySp
	AYWBU1D6SB74ojC0+nSignX8BxmHiAZUkzZS3X+6ByYfb6UbnardE=
X-Received: by 2002:a05:600c:4747:b0:493:f0f5:f2d7 with SMTP id 5b1f17b1804b1-493f0f5f374mr35237235e9.7.1783670336428;
        Fri, 10 Jul 2026 00:58:56 -0700 (PDT)
Received: from google.com (137.69.77.34.bc.googleusercontent.com. [34.77.69.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb670a41sm115777085e9.0.2026.07.10.00.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 00:58:55 -0700 (PDT)
Date: Fri, 10 Jul 2026 08:58:51 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com, kernel-team@android.com,
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v2 1/3] tracing/remotes: Fix leak in
 trace_remote_alloc_buffer() error path
Message-ID: <alCmOw8l4e-DS44v@google.com>
References: <20260709160017.1729517-1-vdonnefort@google.com>
 <20260709160017.1729517-2-vdonnefort@google.com>
 <20260709191516.7a7ad6f6@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709191516.7a7ad6f6@gandalf.local.home>

On Thu, Jul 09, 2026 at 07:15:16PM -0400, Steven Rostedt wrote:
> On Thu,  9 Jul 2026 17:00:15 +0100
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > If page allocation fails in trace_remote_alloc_buffer(), desc->nr_cpus
> > is not yet incremented for the current CPU. As a consequence, on error,
> > half-allocated rb_desc will not be freed in trace_remote_free_buffer().
> > 
> > Increment desc->nr_cpus as soon as the first allocation for the current
> > CPU has succeeded.
> > 
> > Fixes: 96e43537af54 ("tracing: Introduce trace remotes")
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> 
> This patch makes Sashiko find other possible issues with the code :-p
> 
>   https://sashiko.dev/#/patchset/20260709160017.1729517-2-vdonnefort%40google.com

So one of them is fixed as part of "tracing/remotes: Add printk, dump_on_panic
and boot parameters" [1]. I can pull those fixes into this series instead.

I'll look at the rest.

[1] https://lore.kernel.org/all/20260605163825.1762953-2-vdonnefort@google.com/ 

> 
> -- Steve
