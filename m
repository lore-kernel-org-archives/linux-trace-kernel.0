Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B01235358
	for <linux-trace-kernel@vger.kernel.org>; Wed, 17 Dec 2025 01:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765935179; cv=none; b=JqdAWwlLnR8HlITRSBNt6ggVAOFm8Gs5m1+RFRZuYPJLwJgkJB9WX8ksS2GS/6LL5bDhlI6i7UKVJ045kqQ6Uo84oWq+9/WfjIautRrfX/XOokgoZVbsoL0cdWeYMFuKkReSbHOjOjQCntSj39EmkUu4WhEdR6TP2WrABZARskY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765935179; c=relaxed/simple;
	bh=H2EPelVtxa9cSbaez/N6ihHJJnBMSD0SbUDnh72zVQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g3lXTfPSD3q+NUD411nG6d5EzKCtCTR/IcdxuQiLVt3lvDPnOYQOuMz+zA5EMFTRODlPIIMDc3mFKlEaAt06ztGz13o3K34s+be3i70W3WRJH82MpwOgrFn1dKlpYyYVPPdVitgKjJhKpvjBNwNktU3+/oY2yYUYh+iTU39n8D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=duODWYXx; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="duODWYXx"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765935164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WrVIBM2tLfOWRTdEprkdT5ENUo8ZaU5+JFTfwv8hYhw=;
	b=duODWYXx5QOPcxwGaJYDxby9mebAIy/aFKWKEgVUk6jCxiBr21vr3T97SjXE1R2RpIrZAU
	5MWk/oJ8+mxt4CG0SWsD5V9gF9NlSh1OEFeYc8q3kpywcwoq2NKcd5S2Q1aVuXuX+Lh8pc
	UtOw9CexN8GmDGE/nkkY3bSzI8qJcKs=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
 ast@kernel.org, jiang.biao@linux.dev, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: fix address for jmp mode in t_show
Date: Wed, 17 Dec 2025 09:32:32 +0800
Message-ID: <2816532.mvXUDI8C0e@7940hx>
In-Reply-To: <20251216112814.71588752@gandalf.local.home>
References:
 <20251216034533.111090-1-dongml2@chinatelecom.cn>
 <20251216112814.71588752@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/12/17 00:28 Steven Rostedt <rostedt@goodmis.org> write:
> On Tue, 16 Dec 2025 11:45:33 +0800
> Menglong Dong <menglong8.dong@gmail.com> wrote:
> 
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index bbb37c0f8c6c..d4c41fb76a25 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -4492,8 +4492,12 @@ static int t_show(struct seq_file *m, void *v)
> >  			unsigned long direct;
> >  
> >  			direct = ftrace_find_rec_direct(rec->ip);
> > -			if (direct)
> > -				seq_printf(m, "\n\tdirect-->%pS", (void *)direct);
> > +			if (direct) {
> > +				seq_printf(m, ftrace_is_jmp(direct) ?
> > +					      "\n\tdirect(jmp)-->%pS" :
> > +					      "\n\tdirect-->%pS",
> > +					   (void *)ftrace_jmp_get(direct));
> 
> A little cleaner way to do the above:
> 
> 				seq_printf(m, "\n\tdirect%s-->%pS",
> 					   ftrace_is_jmp(direct) ? "(jmp)" : "",
> 					   (void *)ftrace_jmp_get(direct));

Yeah, looks better. I'll send a V2 later.

Thanks!
Menglong Dong

> 
> 
> -- Steve
> 
> > +			}
> >  		}
> >  	}
> 
> 




