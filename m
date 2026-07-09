Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BE93BBFA3
	for <linux-trace-kernel@vger.kernel.org>; Thu,  9 Jul 2026 12:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783599525; cv=none; b=riboBEuyjQSqLSw96B4oDWd9zCokDNEwAs6n5l3YLFnzJRpgPUQDcs9NV1YaM5taSqWbZjUsB2gLrwcrEm4o/Ne9L33aJhrYESfoQcVLP70tpqSSH1A1EPvxJS5x8d3bjVBF1vjb3gP/6OvnDq5EstpMSDzjIlIjOZMAdEUH1Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783599525; c=relaxed/simple;
	bh=XaaFaOM5GSvaUgQorJfaOxm5VOZhBRgjQkClYXbm02A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5wMWlg80RNP5UTkym/Fvxwf4NH00wGiRAmyIzYnud08CpCBeCxArmQn6yeARqyYQoO5xrSTnWbh9sJsE/LYhoMqb6DUodjqt1h+OERaF+VmgnwyayaTG38BobeTc4RGFm7/hk2kOvM66RxOYKMq10JIaEGhb2VQv5QJ50Ko3L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kTChlVeE; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kTChlVeE"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47640541585so931201f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 09 Jul 2026 05:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783599522; x=1784204322; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jngqR2jmiogEZ8PxklwH7MWgCBRAFgrXCWBq2O3HcN8=;
        b=kTChlVeEcgsAApq2ReO34kaP58D2aj79/fhb47WI60JKgDV0wWoseNLEjg4QI3GeoE
         LbCwQTZHzktOCwIKw3nKbu4r1b/HyjlIDn701FCcTctAIBqI+ywQF9J9iVx0A5/VLnaz
         rY6dsfhTvJMbEV1kS74p9IVoyhfjHHBo4/i337/CCWNfo1H2st+WYhqHkfEWFZcuR6Fc
         x+F7kzCJiOTmn+AyhXhwTi/LRlXPsEQTe+Th+3UtK28nn5lf0Afhf8NFH+SeF7HsSyaH
         qckW5X7NDRhPHEJvNPEDI2h2vMzqkTs4QPvyS3pcw0B3IGhh9GKYt1iISxhFyIFWcF5V
         7Bpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783599522; x=1784204322;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jngqR2jmiogEZ8PxklwH7MWgCBRAFgrXCWBq2O3HcN8=;
        b=EUsh11p4u5xS/41CAXk9pU+onFnlzheFhAk/Qg4YteKc7iE5FbXBhWHMVJjvbZ2c6D
         BW1b9gIPUGheMOtl+4pXWuLwYWvookOzUNI44+sCgoy7L+/4Y4k7D536PUqfdrQjVaag
         qBT3HmKPLiFm4QwAPtUM3LhbrZMDJY46GQBjyAVaQV+WslE0lmMKYZ0Y3P+mDX2JexEz
         loQTplXY4R7zwpYAUIgAAPmcaVfqYgxeYVZsxlgxuOQj/343/uW4DESRiW/Uhym86tpV
         HhwE2ncybRJ3aLFhEwFFHwLZEcBgUeiGBNgljfqRp7SuD+d9ZC7kCEc9BLs8xkNOWUBm
         K9eg==
X-Forwarded-Encrypted: i=1; AHgh+RrsHSz0qbH6wJCPCJZXkgNne7/2Ke8WrzF1A48opLNoDEenGQmM6YsLTNR1ebHB3lwxbaXPiVwEJ7sfpnWLZyO8l38=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD0Wrtbj71i2p5tWttRPGIb4EcDWqU2CyDdMTgkO/o6EF2ox7W
	xw9mdvZTxnWNjRA3N7DDQP00YoxUe2PHp/syD1ICP/W94RfiOaVugK87qT1E+FzRf2XpZWCmqDh
	pqiTdTg==
X-Gm-Gg: AfdE7clKGIs9cEX86MoeMR1ifW0AGgQM+UpNQmo0fpuWaZRUYWMzmQlufXsm3HlLQ3q
	20FI5EMvyTlQe71l/v5AJE3ULwkIOUyEnadYwDb8UZXIOtJ1KCbgf2QFW9uKuk/+FoJM0VNdU+m
	NWdVDwXMqn+7JCJMe+W1eOpv8iOxjKdZlC7IXFzLq29ewme3RCyIuPLpbj8VaakhzuMlI+8FA0V
	CcEKPxv56cipLicrT5uUoD1VqG7grrs3aK8PfmPi2beB5mYPYi3jxmJmyn2amIOIO+Zba0HI+Ib
	JcHnRQLxDF7NHz//nOamZL7f3oPeHnCkSqwUbqnqvvJOAnh/UjIX4uTk/07J4fFK2sH0RBAw1aG
	5zgT/x50nQUYnl4+w5LRTHQtS1/niDbp1BG+7tdHXBb7qKZcD0QUWd41NTmtii+PchRNEI1vfiY
	YDT4MBPle3xILBPQBGQyfj4HY7MXl/V5VYbzwcJY3tL8Q9NF8t/wztTJjyMDS8mw==
X-Received: by 2002:a05:6000:40cc:b0:47d:eddb:c102 with SMTP id ffacd0b85a97d-47df076eb66mr7316781f8f.28.1783599521149;
        Thu, 09 Jul 2026 05:18:41 -0700 (PDT)
Received: from google.com (137.69.77.34.bc.googleusercontent.com. [34.77.69.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d910sm49755128f8f.6.2026.07.09.05.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 05:18:40 -0700 (PDT)
Date: Thu, 9 Jul 2026 13:18:37 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org, kernel-team@android.com,
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v1] tracing/remotes: Fix leak in
 trace_remote_alloc_buffer() error path
Message-ID: <ak-Rnf6qhbYFxTgC@google.com>
References: <20260708133201.295072-1-vdonnefort@google.com>
 <20260708125906.746f1def@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708125906.746f1def@gandalf.local.home>

On Wed, Jul 08, 2026 at 12:59:06PM -0400, Steven Rostedt wrote:
> On Wed,  8 Jul 2026 14:32:01 +0100
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > If page allocation fails in trace_remote_alloc_buffer(), desc->nr_cpus
> > is not yet incremented for the current CPU. As a consequence, on error,
> > half-allocated rb_desc will not be freed in trace_remote_free_buffer().
> > 
> > Include the failing CPU in desc->nr_cpus before going to the error path.
> > 
> 
> Looks like Sashiko found other issues you may want to address:
> 
>   https://sashiko.dev/#/patchset/20260708133201.295072-1-vdonnefort%40google.com

Yeah I saw it, the dreaded "This isn't a bug introduced by this patch" ...

Let me send a follow-up. After looking at the other issue, I think I want to
slightly modify this one actually!

> 
> -- Steve
> 
> > Fixes: 96e43537af54 ("tracing: Introduce trace remotes")
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> > 
> > diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
> > index 2a6cc000ec98..62d3d431c309 100644
> > --- a/kernel/trace/trace_remote.c
> > +++ b/kernel/trace/trace_remote.c
> > @@ -1008,8 +1008,10 @@ int trace_remote_alloc_buffer(struct trace_buffer_desc *desc, size_t desc_size,
> >  
> >  		for (id = 0; id < nr_pages; id++) {
> >  			rb_desc->page_va[id] = (unsigned long)__get_free_page(GFP_KERNEL);
> > -			if (!rb_desc->page_va[id])
> > +			if (!rb_desc->page_va[id]) {
> > +				desc->nr_cpus++; /* Free this partially-allocated rb_desc */
> >  				goto err;
> > +			}
> >  
> >  			rb_desc->nr_page_va++;
> >  		}
> > 
> > base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
> 
