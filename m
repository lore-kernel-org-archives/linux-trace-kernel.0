Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FC030BF63
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Feb 2026 03:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772161670; cv=none; b=iEwjcfdzoXzAHY2I3m/sOaMcxKzOptgb6f5BlQAY1blihStU++MXHm0Zn1OXLMhE9DIrgSk4ta4McHpfPGt2oLexzbPy/F0Lg5A75FdYOVWA1jrHDeEPtrFZP+i9vxBcEf/OIg69HZBmn4t0cLNxe/xuJhgDUy71ka+HCKufHAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772161670; c=relaxed/simple;
	bh=UfIO6iEvg4LSZ2tM/9QdtbtzJvPbNDjmpvuy9g9cfYs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N/jPW7hcWFuuvhhZsusdTJOQgqDwfqEEDnho+gehYSrOD2Jz6gcmzrITtjTUH8DnG6yegbdYlFdRP/VmSi1xWXjTi4NgGH7E893fRI4Xn/nuvcRHQVwiifQUZoRgMd9JspX/bQq+12OXM8gCHNhbgZUp7Gb9tPkJjE8Ph1VCXdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfKNwL1U; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfKNwL1U"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4836d4c26d3so10262635e9.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Feb 2026 19:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772161667; x=1772766467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZ15nmfEjKhKNDymehMp1pFL/Nll2gZNYk6Iw5DCQDw=;
        b=dfKNwL1UdcWV9iDP+xWlWGPnKabIWH7j4q5U7XVz9/tPolfvFTtzTvwtaqW/PwuzHn
         lX8PK8WzYYHq26muM95vAZoJeXZDXXYZpq4ivKe9wAp4CCOfAdIajqbhmc2N1bXANSJs
         l7CpOrcjugZibdnJLaKrWcfg0Qh1TeD+Ju7j1oFAaPaz4bEfrpPuTO9r/XaVNZxJUyMN
         /U/i3gVnUvfwCUef8CcrYgjdcthIAC4aE6wRni+evyRcjekjl94eUrOkcU7nykwzt/zH
         14A0HtecDU1ys4d3yyoBWXyZ/jf/7y+qYt9rl6jgN0KCV8yZLmkwdb0oLvBMe75pYwGO
         c1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772161667; x=1772766467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cZ15nmfEjKhKNDymehMp1pFL/Nll2gZNYk6Iw5DCQDw=;
        b=ceqBqVJS3oREgHjZNfrWXOGnvhVyAFf8R64YyQ/9CHB4DkS1mSrgj+mK6CuJ0Cl2be
         ebyngDU9R+EmVnHGO//zNwAmjO45NNDmWwnJzYk5yt9lFoCdF3y/GsPM8s1YfRIYBBoE
         Vrymk6/DGkJJDj0ClM2Q2WQ6U9uyROJOKhjTRd3tr27IMrBlx8tZLtFdqCQwcbNG2azT
         jagaON+lD2y5ma/PMTLZ9Ka4NZ2O08dCjG4XWLekDu9gjoIx34KGpOhO9VlmjC2xZhF+
         mbZjrbP04sqHvx7ob5ZeuFO9/sUT3wH4yuY36p7gNe3wm1nEUC6Yv7BMcx6490Q7P8NJ
         8cWw==
X-Forwarded-Encrypted: i=1; AJvYcCVFTmlcQH6mD3i0hn2FJwrWGqdwuR7ovXr1d7BLMj0QY05FM539HP85MEIYVfthclgM96w2I1IclGAbnP34GHgscjU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl0j6XeSFaWGNLbLZWxqiySfklEs43sjbogLWD84Dv/lFhl99b
	VbhEu6UZbkTnllAh+4UpKvPqbr8YY+kzhfe9EXhsR8rSUjapstpefiMZ
X-Gm-Gg: ATEYQzw6AIcy97uYVsWdL5HGSFleN2cFzYxMQuMHjElmz/E5XRimRSnoM9MRdmDFgAj
	UmICoJQK6cCZqaqlfVfwjP63022KKxETNkbbDhBFLSPrBm+GHdLParjYrh4kipgWZIlze0PZhwa
	p8rYi24yzgi9wCuHDXD4SCq7seqOx1ZAclNOqp1sDoPL8CuMCnHI+WKeYVoZbB4i7ZnK47RMA+o
	E7sekmts7EfnRSkfBqc7Ef6HRpUJhc5ZI3kEUww6SLZk3TyQNQMy2jX/Cc5MvXXSBC9qiunxTRo
	uKSNlAHjJiowsonQwF4Bq6smlgIOPCh00f8BGx/X2d+nde3FiTgwTNqw15lmU0SjmsTvk4luu9U
	5kVUukhLHb8zJz1oxmKdJRy4dwzXX9FwyqYIoyTj/Pie5aqp315cYrHOdfzYta+jWFe7XgzUZwj
	qGOqyRhLASnanfw8m0EFC2Ia34EYe0ENimnS09IOgICQ7c9lhpzQ==
X-Received: by 2002:a05:600c:c490:b0:477:63b5:7148 with SMTP id 5b1f17b1804b1-483c9bb65ffmr14190225e9.6.1772161666981;
        Thu, 26 Feb 2026 19:07:46 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.215])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b89c99sm77439065e9.15.2026.02.26.19.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 19:07:46 -0800 (PST)
From: Qing Wang <wangqing7171@gmail.com>
To: rostedt@goodmis.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	syzbot+3b5dd2030fe08afdf65d@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	wangqing7171@gmail.com
Subject: Re: [syzbot] [trace?] WARNING in tracing_buffers_mmap_close (3)
Date: Fri, 27 Feb 2026 11:07:37 +0800
Message-Id: <20260227030737.1089041-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260226115229.7111b070@gandalf.local.home>
References: <20260226115229.7111b070@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 27 Feb 2026 at 00:52, Steven Rostedt <rostedt@goodmis.org> wrote:
> OK, so the issue is that the ring buffer was mapped, then the process that
> mapped it forked duplicating the mappings. And then on exit (or unmap),
> the first one to unmap the buffer will cause the ring buffer to think it
> was fully unmapped causing the next one to unmap to trigger the error.
> 
> 
> > + */
> > +void ring_buffer_map_user_mapped_inc(struct trace_buffer *buffer, int cpu)
> 
> Let's call this ring_buffer_map_dup() to be consistent with ring_buffer_map().
> 
> inc would expect a dec, but dup() is more of what it is doing.
> 
> > +{
> > +	struct ring_buffer_per_cpu *cpu_buffer;
> > +
> > +	if (!cpumask_test_cpu(cpu, buffer->cpumask))
> > +		return;
> 
> I wonder if this fails we should warn. As it should never be called unless
> it was successfully mapped.
> 
> > +
> > +	cpu_buffer = buffer->buffers[cpu];
> > +
> > +	guard(mutex)(&cpu_buffer->mapping_lock);
> > +
> > +	if (cpu_buffer->user_mapped)
> > +		__rb_inc_dec_mapped(cpu_buffer, true);
> 
> Probably should also warn if user_mapped is not set. Again, this should not
> ever not be mapped if we get here.
> 
> -- Steve

Thanks for your suggestion. I sent a patch [0] and looking forward to your review.
 [0] https://lore.kernel.org/all/20260227025842.1085206-1-wangqing7171@gmail.com/

--
Best regards,
Qing
