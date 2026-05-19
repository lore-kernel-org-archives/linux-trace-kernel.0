Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643D73F4DC7
	for <linux-trace-kernel@vger.kernel.org>; Tue, 19 May 2026 10:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779188143; cv=none; b=P2MQxW1PSXk6GvT3ivHG1J3SrwFgV3Bq2k0Q3epi+R7qhjWMSGEvwFDPwtxb80HOSde+0lXKs4vFzlvnP2TVtNvhcaeYBO4ujaoaOtiVwZx/eg6SGof9uHlLpA3FcXzCGBKGvPqJ3XkAYHpOvYJEUXUUEd2lEulN7scjETIGvC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779188143; c=relaxed/simple;
	bh=qTIuYtfZpfc/KhP0my2UUsb0x1PEx+M0VM5oHniYnnU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DsIvEhnJQZybJasffVXDFDy+cu8hJ9gPtRpMPREfwchmV/rp2URWAEr1/WEPF+StWKhakgFJcQZhlLRP9kU2FZxT4HG0GUvrEE+WIbofIxLlX1UXseRwyI77VZGV975WSeutZs/q9zSCqki3lAM/Hjs5wgpp5l7YGifwpInqFUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7HnchGq; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7HnchGq"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so27975325e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 19 May 2026 03:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779188136; x=1779792936; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nXidpbPy4AblXKAWP+/SRSo2g1EEOiSrktNFCukfheQ=;
        b=C7HnchGqUGLnN3GkhnLYI4kCRbXWdcCq5etW6iz1rzND8DMyKX70wTHMEPVAm0mwH7
         MW/S/BL6VWGbD8E/+BDmjkt1cGXEVJE6HPTw5XDRKzwH36P6omnMgCFTh9T5cOoNgZmo
         HSPxlIKOWf0C4swGpYyjCld0zyMH/2Eiz8lyZf4buB96c5sq2fU0RNKE8Z29n/iX9po1
         j2Fe904BYKakl8IsoE/x0rlOotUX7CJbs1OU2+NaS2bQLEfCqy1NlOM82BYk7I9gaDNw
         EBXdXR9m6mldBVWjqm+yfAE6ac/GrUbf8gqrehAUlCmn7628WdIWnd9Xhr7W5QvwJvMJ
         1qjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779188136; x=1779792936;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nXidpbPy4AblXKAWP+/SRSo2g1EEOiSrktNFCukfheQ=;
        b=NBm+SPALoXiYVnxponE7xbO3i2TXAFdCs5EK5RiR11GoZRE4Lgl5YjGK/KHEKuKT82
         R1k4MTgAiih1vznz5rf9fV+a+g4nhCXLDD3hrdK0nG0ZisAOX8QttrwwSo/oxt8q2SyW
         tb4VW9xmTfgYE8Fgfkauy2bIcAWSQiOdJF5tX/3zTih+fcbGBvZQeN/qdXdB8o0xnLUB
         QMaBBv5G7g3t8ClNtoatx9sOQpLNcITgTnz07JjnL7B/lj6y4l3Mqqv5N89+MTfqlNmx
         qf3reFH+PxAaaSdkS26ZkYcCFNVAjOsd2yeYIfY1WAiz7tS1dRdwAJOm2+VQuWV23BkP
         bTPw==
X-Forwarded-Encrypted: i=1; AFNElJ9fHAp6ocZRkr9XCgDoknpNHdOQ7wmBPUvr+FsSv4xqYmn+cK9XG+jrJah960AK7FLaPXC9xTwmOl5xXkjIC7uLdCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBw6mMJLu5LKqIDhY+kVk5yk32HBklznYWiYaCClNe+uLPMFGN
	phDpdl7/mbOQAxGIhjH0HuzFmPok18kqSTfSpfWSjnCIVetr4cPq72iW
X-Gm-Gg: Acq92OE0nf4/QUglL9gj3Qh0fsnpij1rs2Ghy8D16lMKgPvEhDf+FhFbbWaPTbBMF4B
	6Q7D1zDfZvRMtB+hyCX35ocLZ9Tt5exD96tKMBxn25yDG1/ttX9y292KB7dUGf3HygmmVnycPkC
	ZjbQCoyRYgcmbtRlAldJffXhNzB0CR/9jrAzguFXQ08yBb5R+c4Mocnb6MbnY53BsDWd8eBCkVt
	CsG5ELvCidYgfG/HQFlnd2pqCEdLdsnMHIPdfHv/bSr2WLSjkAAQGcVM2sbzuJyRcZkZya/B5rM
	KcwO0k1+2kqUlTJSoDRreZLRJ/wQKPQc5xaUBSjd3m3DevmHFd+n2VrP6CU6wmVefPfA+AVBfji
	CCsH4lo3eVnmwO/KioR2Cmis8Gg6I0CM4W1qUiAoCVLwdgqgh4NzqW5wMomBFarsqU0fsQBIYFB
	ADo8sTb1APNHRCGbvh
X-Received: by 2002:a05:600c:5ca:b0:48f:e6de:1cb9 with SMTP id 5b1f17b1804b1-48fe6de1dd2mr182584715e9.19.1779188136017;
        Tue, 19 May 2026 03:55:36 -0700 (PDT)
Received: from krava ([2a00:102a:500e:4bd5:e407:4c9c:ff70:3933])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe537c788sm303057615e9.12.2026.05.19.03.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 03:55:35 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 19 May 2026 12:55:33 +0200
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrii Kuchmenko <capyenglishlite@gmail.com>,
	linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ftrace: fix race in __modify_ftrace_direct() between
 tmp_ops registration and direct_functions update
Message-ID: <agxBpRc9YIyPVwCO@krava>
References: <20260517110155.21706-1-capyenglishlite@gmail.com>
 <20260518121906.4eebad77@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260518121906.4eebad77@gandalf.local.home>

On Mon, May 18, 2026 at 12:19:06PM -0400, Steven Rostedt wrote:
> On Sun, 17 May 2026 14:01:53 +0300
> Andrii Kuchmenko <capyenglishlite@gmail.com> wrote:
> 
> > In __modify_ftrace_direct(), register_ftrace_function_nolock() makes
> > tmp_ops visible in ftrace_ops_list before entry->direct is updated
> > under ftrace_lock. During this window any CPU entering the traced
> > function calls call_direct_funcs(), reads the old address from
> > direct_functions via RCU, and jumps to it via
> > arch_ftrace_set_direct_caller(). If the caller freed or invalidated
> > the old trampoline before calling modify_ftrace_direct(), this is a
> > use-after-free in executable code context.
> > 
> > The race window:
> > 
> >   CPU 0 (__modify_ftrace_direct)       CPU 1 (executing traced func)
> >   ──────────────────────────────       ──────────────────────────────
> >   register_ftrace_function_nolock()
> >     -> tmp_ops visible in ops_list  
> >                                         call_direct_funcs()
> >                                           ftrace_find_rec_direct() -> old_addr
> >                                           arch_ftrace_set_direct_caller(old_addr)
> >                                           jump to old_addr  <- UAF if freed
> 
> You do not state where old_addr is freed.
> 
> >   mutex_lock(&ftrace_lock)
> >   entry->direct = addr   <- too late
> >   mutex_unlock(&ftrace_lock)
> > 
> > Fix: update entry->direct under ftrace_lock BEFORE registering tmp_ops.
> > Any CPU that observes tmp_ops in ftrace_ops_list after this point will
> > already see the new address when it calls ftrace_find_rec_direct().
> > Add smp_wmb() between the store and the registration to ensure the
> > write is visible on weakly-ordered architectures before tmp_ops
> > becomes observable via ftrace_ops_list.
> > 
> > On error from register_ftrace_function_nolock(), restore entry->direct
> > to old_addr since tmp_ops never became visible to other CPUs.
> 
> The above statement is incorrect. The tmp_ops hash entries are also
> *shared* with the ops that is being updated. That is, by changing the entry->direct, you 
> 
> > 
> > This affects all callers of __modify_ftrace_direct(), including:
> >   - modify_ftrace_direct() used by kernel modules and live patching
> >   - modify_ftrace_direct_nolock() used by BPF trampolines
> >     (kernel/bpf/trampoline.c) reachable with CAP_BPF + CAP_PERFMON
> > 
> > Fixes: 0567d6809440 ("ftrace: Add modify_ftrace_direct()")
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Andrii Kuchmenko <capyenglishlite@gmail.com>
> > ---
> >  kernel/trace/ftrace.c | 35 +++++++++++++++++++++++++----------
> >  1 file changed, 25 insertions(+), 10 deletions(-)
> > 
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index a1b2c3d4e5f6..b7c8d9e0f1a2 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -5950,6 +5950,7 @@ static int __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
> >  	struct ftrace_func_entry *entry;
> >  	struct ftrace_ops tmp_ops;
> > +	unsigned long old_addr;
> >  	int err;
> >  
> >  	lockdep_assert_held(&direct_mutex);
> > @@ -5960,22 +5961,36 @@ static int __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
> >  	if (!entry)
> >  		return -ENODEV;
> >  
> > -	/*
> > -	 * tmp_ops is registered into ftrace_ops_list here, making it
> > -	 * visible to all CPUs executing the traced function. However,
> > -	 * entry->direct is not updated until after this call returns,
> > -	 * leaving a window where CPUs read the stale (possibly freed)
> > -	 * direct call address via ftrace_find_rec_direct().
> > -	 */
> 
> Are you posting patches on top of your own patches that are not public?

hi,

right, the original email states 5.15 is affected, but I dont see
__modify_ftrace_direct in stable version v5.15.207 .. what kernel
version is the patch for?

> 
> > -	err = register_ftrace_function_nolock(&tmp_ops);
> > -	if (err)
> > -		return err;
> > -
> > +	/* Save old address in case we need to roll back on error. */
> > +	old_addr = entry->direct;
> > +
> > +	/*
> > +	 * Update entry->direct BEFORE registering tmp_ops into
> > +	 * ftrace_ops_list. This closes the race window where a CPU
> > +	 * executing the traced function could read the old (potentially
> > +	 * freed) direct call address between tmp_ops becoming visible
> > +	 * and entry->direct being updated.
> > +	 *
> > +	 * Any CPU that observes tmp_ops in ftrace_ops_list after the
> > +	 * smp_wmb() below is guaranteed to see the new address when
> > +	 * it calls ftrace_find_rec_direct().
> > +	 */
> >  	mutex_lock(&ftrace_lock);
> >  	entry->direct = addr;
> >  	mutex_unlock(&ftrace_lock);
> >  
> > +	/*
> > +	 * Ensure entry->direct store is ordered before tmp_ops
> > +	 * becomes visible via ftrace_ops_list on weakly-ordered archs.
> > +	 */
> > +	smp_wmb();
> 
> You do realize that register_ftrace_function_nolock() is itself a full
> memory barrier? It's doing code modification which requires lots of
> barriers to work.
> 
> Still, the only bug I see that is possible is that the caller may need to
> do some synchronize RCU calls before freeing an old trampoline.
> 
> Can you show a path that doesn't do that?

+1 

jirka
