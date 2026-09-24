Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F5047F3C8
	for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 12:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790252868; cv=none; b=XI02RlcFPsbv2yRb8mitYn7KIhH9ZqMP+tU7iMv6KmJSzxzWxz/dTgmJgUT/IFFimLgXf+5e8ZAjK0VuMilO+9D2tMG7o3Rj8eW/Et7MUDPsZCBih7yb81bKBiNvs5ZpakViZlyYWl+WxU7UidxUkTs0e6Q9WIV8PBncUGxoPUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790252868; c=relaxed/simple;
	bh=wNjl/xCEtzlgT0a5M5KycCUc9Jdogae8+RmVUW7SNzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kv/AbOECKiRhDi9jGscwot0jMgrPoh3TICh1ZnxX7Kk7ZKueNcZRwBhjZK1ds7UOxRLlDFO8CeYfzEoQe7/5hJCgi+j5NRV8unORiDy23VVI/5H4TV/shQ7sxLfWGXWx0+zkCwqh6XQX61v/8aeiy4gGO6iN9s0p3wTF3tGF/iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j2v9brbP; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j2v9brbP"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e6c0fce17so10830515e9.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 05:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790252865; x=1790857665; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oVzT9rV6dRR4JNktA0r62hGHUnd9OU93fg81zd4qkr0=;
        b=j2v9brbPbatiRgKZcHLo256ch1BXINnX848i6T2hoVaKPsIRbYgYIXxte/9QhJJIbr
         KfU27boo6iFkGwjRGn+lnR8vp8f+dTTmeX9Fik49ALUUC+gvr+GQcOvWk3l7pPo6Lb7f
         YDYLh09rncMqTQ/Zi/lAy7QFdYtsmqUrDQQ5yMgylSvWzJDGipFYXgBwJWtWYmE52vEQ
         07T72rAwr/C5cxAsa/u38o2wtVAHyJnlEHlIjMhE+/gTjgYmLooWQgHxleYSqWDZFmk0
         u0qRbJ+IsKNSrlJR/DhKWexumu6XywVbUzrC6nZxp9licgedlmW+mxNky8VQp5EHvTsY
         AWrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790252865; x=1790857665;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oVzT9rV6dRR4JNktA0r62hGHUnd9OU93fg81zd4qkr0=;
        b=0/WClSkncxq/6mbunTgPt1Uy2cCl+qX4EyGPcDQOgj9N9vENMBuPz/gOfbzxrU2ZjI
         GNy0BpoYX1GQzb2ACytPUumKgwUSjLcEF7H4aeFV+cK4biHQ8pBNz9qzRby0URnln/do
         sIg/v32J3Cv45HfiLQ3O2cXFV4QCTZeQ1BVA69PRS59s4bInnBgW3Mgj8Bx60coIN7xm
         pF25l/L6OPPBLxKKWlJUCoBbNZNosaG8lFINzWFV8HxT6H2yOgNa31JAAHQI3TAhxkvk
         fRUc/NFEdm/aCs7io6Tq05XdgVD7WLcY+PzcL8wg4BkzBULG19FP+m8KI++A30sp/Nem
         NvDQ==
X-Gm-Message-State: AFuF++kQUwS8DYvo9SIwv6EXipBKA50EA9w4UXMBpSEOi2X0ozXv97+O
	tiKN6HvVNZvis6WDynTk6tpUlD4wWIJGDGEDabRqOInFjQnnTxwQ5tWs/hwmSySdaA==
X-Gm-Gg: AYBFou2CcX1red6jb1Y2AmwByMjdi+9DZS9ID9dGMoEkTpZu09ts2SBco9CoXvOs1uq
	cxV15ytQFEmUZaWmFe4XOlCZPoA1el6LsZRi2zhUu5S3XLiMjvyAka6tnZL3fwbbumL6b4Cx6t5
	TBPV6pATSuHEah/B40n9vLiyX5wzfuLdqb7O1UBOu89IgJMQm+OkHYsdrBwqWuG9vlak1QuuugU
	H69+PXdWGLqVcDlRVovavqCfNbbk9FdkU53VBu2bavCi7s/lfEPfp0ckTPDQxWdSrUGuBj/+173
	nLTKqff/G3H8v0Cx6T8fj0vQgeQTuS71q9bBotB3St+tJO/bWIF8psRok+bzoTiNFCL6IY9kgVA
	XNkrJ19+M4XrF6IlZdun1tmuIkZ2AVHmiPkIlZACTeUx6H+RrEnYBdTiH6L/ZfagwpQlJth+WF2
	2exojvybJgG2EOoQxW5Qa8ENomMp6eMW5qGaT2nlLsNXJ4cks/5rIoKzWXlVQxWm4PmuPKmhMWu
	xz4280dpmaBySrZUA289WMZVeCGaytInndDi+TZXFU=
X-Received: by 2002:a05:600c:c8f:b0:49c:dc14:d681 with SMTP id 5b1f17b1804b1-49fe66bdf3bmr38051355e9.3.1790252864624;
        Thu, 24 Sep 2026 05:27:44 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5ce4941sm63102585e9.6.2026.09.24.05.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 05:27:44 -0700 (PDT)
Date: Thu, 24 Sep 2026 13:27:40 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6 03/18] tracing/remotes: Use kstrtobool for boolean
 tracefs files
Message-ID: <arUXPG_V-EypPM9i@google.com>
References: <20260817135517.3919534-1-vdonnefort@google.com>
 <20260817135517.3919534-4-vdonnefort@google.com>
 <20260817141120.E9E401F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260817141120.E9E401F000E9@smtp.kernel.org>

On Mon, Aug 17, 2026 at 02:11:20PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Kernel infinite loop when reading an oversized trace event from the `trace_pipe` file.
> --
> 
> --- Patch [3]: [PATCH v6 03/18] tracing/remotes: Use kstrtobool for boolean tracefs files ---
> commit 2c1ad77f49e430730de7a438ec955b0c042628e4
> Author: Vincent Donnefort <vdonnefort@google.com>
> 
> tracing/remotes: Use kstrtobool for boolean tracefs files
>     
> Use kstrtobool in trace_remote.c where possible. This is more user-friendly
> as it allows a better variety of input strings.
> 
> > diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
> > index 0384277070b9e..0e4d41a93a7ce 100644
> > --- a/kernel/trace/trace_remote.c
> > +++ b/kernel/trace/trace_remote.c
> > @@ -235,10 +235,10 @@ tracing_on_write(struct file *filp, const char __user *ubuf, size_t cnt, loff_t
> >  {
> >  	struct seq_file *seq = filp->private_data;
> >  	struct trace_remote *remote = seq->private;
> > -	unsigned long val;
> > +	bool val;
> >  	int ret;
> >  
> > -	ret = kstrtoul_from_user(ubuf, cnt, 10, &val);
> > +	ret = kstrtobool_from_user(ubuf, cnt, &val);
> >  	if (ret)
> >  		return ret;
> >  
> 
> [ ... ]
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but I noticed a potential
> regression in trace_pipe_read() when handling oversized trace events:
> 
> 	while (trace_remote_iter_read_event(iter)) {
> 		int prev_len = iter->seq.seq.len;
> 
> 		if (trace_remote_iter_print_event(iter)) {
> 			iter->seq.seq.len = prev_len;
> 			break;
> 		}
> 
> 		trace_remote_iter_move(iter);
> 	}
> 
> When trace_remote_iter_print_event() fails on an oversized event and returns
> -EOVERFLOW, the loop breaks before calling trace_remote_iter_move(). Does
> this leave the unformatted event in the buffer?

I will ignore that for the moment. There is no oversized event and the remote is
a more privileged component than the kernel anyway. 

> 
> If the event is left in the buffer and the sequence buffer is empty,
> trace_seq_to_user() will return -EBUSY. The code then calls
> ring_buffer_wait(), which would immediately return 0 because the event is
> still in the ring buffer.
> 
> Could this cause a CPU lockup where the core infinitely reads the same
> oversized event and fails to format it?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260817135517.3919534-1-vdonnefort@google.com?part=3

-- 
Vincent
