Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7363478E5E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 14:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786629835; cv=none; b=GJ2577dQxqHxLcqesR6s9/cJhPbRYqcn6m4sjhdGEKjIgxFBSGF+HP6SW2xjczLBf2UFMiDequGR6x0lDM9ZZHuiY/vYLALwwJ9s16lrUSPPRGzalmgEHb10RCpcq8osYvaq/gyvTbFNcfiXu4aoiiWCipVNFFH7A59ZNENb3Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786629835; c=relaxed/simple;
	bh=+68qMPQULekWGDb3r8Qb9OlUJ2P4wfYl0uDP43j2nWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSmORJu6YzW7A5PjrhMqyecbwN6l9AqrBlbHFIPy9CywhrAMzC4Oe1Hi+839SAJPyn2m7bgAizgTo85NZk5Q1hK2JHrA1T1+gJZW/R7/FvGQ4w+7N9+K9Li7Vjx5Zh18tuAFPA1wmE8WA+hvuioya12xLS3iS/70K96JzVsWBQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o0vjAgpr; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o0vjAgpr"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49800c6a846so22623415e9.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 07:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786629832; x=1787234632; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KFG7QuhLneq7bZyDroPESrKS4TWugaFx6vINPlvCtq8=;
        b=o0vjAgprXcjEakz7ERrwXpG2WbFcSBOHeYrpffcbiCLtRNsYz61apDD7uAQFkGU7/T
         lQoyoa8K5jJ3+dSfA92ClRP0aI+AYXKHkxcYfL7TAFo4pC9CMF20JsH9qw6dR46oU5qu
         eDkGa8jvGtSbM8yKy9XVahK0j0fz3Q8VieyrmmIJsoXMeSYcsJe+gAFqYemazIU+++ya
         cboOoonLlht+JuCpXM1WjvTfor42bXkdH98mMDKhS7vQmEorJjs67x4xgES79P/wM8Bp
         ZAJvnGyQRIz6V1vXPOFrz5rzpW8WUWoqNszVV9EDSk+vselGfZ85ERb8cc4N7CxqpB1U
         KbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786629832; x=1787234632;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KFG7QuhLneq7bZyDroPESrKS4TWugaFx6vINPlvCtq8=;
        b=CsUEUTrHdCxOQY9BFWbfy47f8NhfMDuKoPo46xs3eZp9qMpRFQa29dQ+XWmT5oZuuJ
         iJRc61FO53p2O4Kkml/tM3VtaCpelqOti+u8Buc2KYXmPgXao7g7EENEZp85bILn7q7K
         vp6B8cqKw21XA1CP0/BGWDCXDzrw/HFYG4+UtGMsHPn+pylqXwvUoEkSl8BHVCU5XK7d
         BF9yx7ITIErqw3M+54Y1aayaIi+ehzKuqJMPuHLM0LOk02F9nChjG4DzpEjQjxviMM26
         NaWei4Lt80T60VYB1k5+4q0TWnUACHzoCCEciv145x+JINs5Lk2EIC4PTrH2vhQb/oYO
         g8iQ==
X-Gm-Message-State: AOJu0YyzagZezJdUar0Bf1UzE0htNufXZtu+Z8+peAQQEKiVY3Qy5orF
	NMLfvJDkjJ1u4ZRgXz7yWYma9JJLy+uOHEq8VdtyhIxg0WzOD8fQM5zFORZ7RrNUQg==
X-Gm-Gg: AR+sD10oF/CGsGmgd9Akw44Jlj15RQJTTA8BLqUsZ+fzPGc7wz3QpgJgOGr0oQZE/qq
	bvXvX2lGqmZsT1VKXHRC4HXxbX/bfqpojr08/qgC3cMqozXlu1saOxeYKeIh4Tvs0+dCEXoNCVB
	LT/SvYg6z2wrfbgTDqYRsCynFtjsep9n/3/3+20i5MXZ3RupTeZ1NIjagOnOhV51ZF/zBQndHVB
	3IJHjzwpIvzq3L+EwBj34rfxdSxPo/wZuIez0pPVf3ot2FMYKGCr6sM1mAVQJ8HecMA1gFdJAqJ
	JRTog1xOZ887FtZv3uitUpX4P4ztACTvIIyqOoVFNbCAcJ9AtKcVKHky40nDSCZUlp1cxgBJO5E
	yQISxG28QciuqIAj3CuapALFa4hYkgw98O4ohgLUbZMrxFq0DlmjzixQKDPD9VExkHpyxWxsN1/
	HIGnGKg1rdKOMk3WjDqlfTlvBTeft+kk8KtBq92YuGM33H72mA4BNkMlxxXb+nQ+CP6e+o3kzN4
	CsTKNQwCF/oEzVjdEBAnY30asGHqlEn
X-Received: by 2002:a05:600c:1c1a:b0:495:48d7:f178 with SMTP id 5b1f17b1804b1-499821ba2e6mr66608875e9.11.1786629831520;
        Thu, 13 Aug 2026 07:03:51 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981e31c41sm30768675e9.2.2026.08.13.07.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 07:03:50 -0700 (PDT)
Date: Thu, 13 Aug 2026 15:02:20 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 06/18] tracing/remotes: Add dmesg tracefs file
Message-ID: <an3ObE0FFGHK07EO@google.com>
References: <20260812161340.2417322-1-vdonnefort@google.com>
 <20260812161340.2417322-7-vdonnefort@google.com>
 <20260812164257.AD3A31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260812164257.AD3A31F000E9@smtp.kernel.org>

On Wed, Aug 12, 2026 at 04:42:57PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] When CONFIG_PRINTK is disabled, dmesg redirection stalls the event iterator perpetually because `pr_info` returns 0.
> --
> 
> --- Patch [6]: [PATCH v5 06/18] tracing/remotes: Add dmesg tracefs file ---
> commit b41c280df86084ff7600dad9b61a6fa3dbbdf1dd
> Author: Vincent Donnefort <vdonnefort@google.com>
> 
> tracing/remotes: Add dmesg tracefs file
> 
> When enabled, the dmesg tracefs file enables the redirection of all
> events to dmesg. This is similar to tp_printk.
> 
> > diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
> > index 1fbe2f3f20e99..3a5e0d84c1722 100644
> > --- a/kernel/trace/trace_remote.c
> > +++ b/kernel/trace/trace_remote.c
> 
> [ ... ]
> 
> > @@ -882,6 +908,87 @@ static const struct file_operations trace_fops = {
> >  	.release	= trace_release,
> >  };
> >  
> > +static bool trace_remote_do_dmesg(struct trace_remote *remote)
> > +{
> > +	struct trace_remote_iterator *iter = smp_load_acquire(&remote->dmesg);
> > +	unsigned int max_events = 1000;
> > +
> > +	if (!iter)
> > +		return false;
> > +
> > +	trace_remote_iter_read_start(iter);
> > +
> > +	while (trace_remote_iter_read_event(iter)) {
> > +		trace_seq_init(&iter->seq);
> > +
> > +		trace_remote_iter_print_event(iter);
> > +		trace_seq_putc(&iter->seq, 0);
> > +		if (!pr_info("%s", seq_buf_str(&iter->seq.seq)))
> > +			break;
> 
> [Severity: Medium]
> When CONFIG_PRINTK is disabled, pr_info() is defined as no_printk, which
> unconditionally returns 0. Does this cause the loop to always break early
> and skip the call to trace_remote_iter_move() below?
> 
> If so, it appears the background polling work would continually fail to drain
> the trace remote buffer and run periodically without doing any work, as the
> iterator never advances.
> 
> > +
> > +		trace_remote_iter_move(iter);
> > +
> > +		if (!(--max_events))
> > +			break;
> > +	}
> > +
> > +	trace_remote_iter_read_finished(iter);
> > +
> > +	return !max_events;
> > +}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260812161340.2417322-1-vdonnefort@google.com?part=6

Do we really want to support !CONFIG_PRINTK? 

In that case dmesg/dump_on_panic should just fail to enable... but is it really
worth it?

-- 
Vincent
