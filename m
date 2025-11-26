Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50A329BDAD
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Nov 2025 07:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764143664; cv=none; b=LOqHDzrO0jBKFzhcau2dqyleiQ68imLvjqgw95yHp0Cq5Z4MmHMWwh5EYVYpviirpy70grQO5gFnpqdsIB4Q9abshBbdqcemOn17pwlcJzm9YWqhkDwCtD+PWychhAEi8urkRXKrNtAxCdbKC9Q+y1/w3uVD/OZY5dIQrl/Jy1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764143664; c=relaxed/simple;
	bh=BLggUwFSSOnSougouiNtDF9tADe2dx8YXPmsLpbiPmM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iynnebu0fAp9GKOwpf8DU+2Ru1mijmTOlzdTqtE3tH9tWeLZRIJGVDftzj+wrc5zkDgfR+pneoc39N0m4Mvm38Ewwfw/tctN/UXOkc0Z3qT4OFCFoDJHrWTOnkwM54J3MdfzUuhgCeHgKYqxjltyr+RZWuLA6kHkPwtD/vevhXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHOmxRGR; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHOmxRGR"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42b32900c8bso3708668f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Nov 2025 23:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764143661; x=1764748461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NyPTYZiKX4AJg8UqMQQ2+zsdage/O8q7ru0ykIzuE8k=;
        b=bHOmxRGRXw/zioH6ypV3JRCaUBchEwD0qqwetUkjp2mI6cyxV6M/dUZupqu3MaLPds
         HSWalDb7T81UzaDlsUvJTXvHj8T3BMvlDk5x91/yzToNbsRzdOBGu5g9F1lT6TueMjbR
         AjOXk8yCyp6e2j9BGUJhN+6lpsUca6uReXYrhZ87I9qynMSgODh2K4AC8n6eRA94pTpx
         hkZUM8kL9tFSW7YjhxQGsZft2X85ZNd4BhiiYpiW4c8H1Q2pLK+mGxIJ+k/Xx7yZnYeF
         xSR4MGnP4jJcVenQ3q1FOfTFgTUrFiEz8MI9/CgDpGF6hE6hpzWemLdRcA41H9B7PMmD
         aJkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764143661; x=1764748461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NyPTYZiKX4AJg8UqMQQ2+zsdage/O8q7ru0ykIzuE8k=;
        b=dOzRKbaYyqz6hI8ca5wFOMczcl5lZMt/XrBCopPG2Pf85PXHC0X5tLS0fTI0Fd2IO+
         8umqudstXFzYlLRq4J5H66v5DPbIe1+iqKlbroi5S//l/iMwTZU5mLV4ZXqfb673sA76
         unQkkBmFGbE/o0YiTymwLhGxb4Hn9sJWlX6VzIG++VIVDoTG9aEYhUr8RRmsrt51Foiv
         rGJ0E8+wzdEfyAzuSFaNGDMRTCXJ6i0CvsevhDymPQXvi7CGlPd08GSCDIfPSTEtc+V2
         MKztIqqMFu/WOFGgXLwqhlKsHpg5+5YQUxjSOxUgFKcAJJ/iheMPVI+Tk23Ad7vzT0Rk
         Q8ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHDtj5ocBOU4wjY0pUpLbZqOH060B5Y5UMmpsqowCZKZIA1QeOiu2qD0QXQ13RJgNkgTZ752rVIgOW1M9AFxgnqPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKuKed/tR9XMmu99KpDycYgZxmF67UoLhR3wco3jSDzJrWTtPs
	CYfkOZzFzGXJ4CUE3+n4xUrcUjqVAMdzBw65cFdd9baYtT0ucVE6Yqn5
X-Gm-Gg: ASbGncv2A23n3wOpn9S0lrcN64ZhprQoiSYeUn3F1Em6xFqGsciRiHrD2hQ0cgLjRMU
	gp2+YYjLOszlccDkXCjL2PLh0LoPYGpPabMxA8aAfc1ySXLeWp5dRf5bEV6jlPiZBdiko9jS2s/
	5nMgt8EdJnxN/cAWndYmNLXgiP8NPzQ8ogom2M02YNRWJz+yPuS7MfGUSBsDJrV73c48wu7BaEk
	6/9KeV4ip9Mn/wsSAcScCuG7fpIOrZU2K6tP4LYVdVm6F+a22h63OtNYmayqflUYYoITyQru460
	lmMJhjujhH4ZFI9ToaYUy/gAzy9t3KV9GB02P6hLt6UWG4hPWfg0u0dYBh5I70DgZWFq+7f4a8K
	aV/LSeXvcnrbg2N+hE+VishqzJKYsvc44VIR8Sk85uVu9Aj4XcRdlQmmjLoQc
X-Google-Smtp-Source: AGHT+IF3OhJrdZ1YcyFXgQFCx3O4fzXMh5cnWnx31Q+zBL04SChpqKRjEOULsSc/MyGGIyzGtkLnAg==
X-Received: by 2002:a05:6000:2509:b0:42b:53ad:bbfa with SMTP id ffacd0b85a97d-42cc1d61ae6mr19946482f8f.53.1764143660807;
        Tue, 25 Nov 2025 23:54:20 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fb9022sm38826054f8f.36.2025.11.25.23.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 23:54:20 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 26 Nov 2025 08:54:18 +0100
To: Oleg Nesterov <oleg@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	David Laight <David.Laight@aculab.com>
Subject: Re: [RFC PATCH 5/8] uprobe/x86: Add support to optimize on top of
 emulated instructions
Message-ID: <aSayKtsTNkuyu0TP@krava>
References: <20251117124057.687384-1-jolsa@kernel.org>
 <20251117124057.687384-6-jolsa@kernel.org>
 <aSSdavSy_unRaEgF@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSSdavSy_unRaEgF@redhat.com>

On Mon, Nov 24, 2025 at 07:01:14PM +0100, Oleg Nesterov wrote:
> Hi Jiri,
> 
> I am trying to understand this series, will try to read it more carefully
> later...
> 
> (damn why do you always send the patches when I am on PTO? ;)

it's more fun that way ;-) thanks for checking on it

> 
> On 11/17, Jiri Olsa wrote:
> >
> >  struct arch_uprobe {
> >  	union {
> > -		u8			insn[MAX_UINSN_BYTES];
> > +		u8			insn[5*MAX_UINSN_BYTES];
> 
> Hmm. OK, this matches the "for (i = 0; i < 5; i++)" loop in
> opt_setup_xol_ops(), but do we really need this change? Please see
> the question at the end.
> 
> > +static int opt_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
> > +{
> > +	unsigned long offset = insn->length;
> > +	struct insn insnX;
> > +	int i, ret;
> > +
> > +	if (test_bit(ARCH_UPROBE_FLAG_CAN_OPTIMIZE, &auprobe->flags))
> > +		return -ENOSYS;
> 
> I think this logic needs some cleanups... If ARCH_UPROBE_FLAG_CAN_OPTIMIZE
> is set by the caller, the it doesn't make sense to call xxx_setup_xol_ops(),
> right? But lets forget it for now.
> 
> > +	ret = opt_setup_xol_insns(auprobe, &auprobe->opt.xol[0], insn);
> 
> I think this should go into the main loop, see below
> 
> > +	for (i = 1; i < 5; i++) {
> > +		ret = uprobe_init_insn_offset(auprobe, offset, &insnX, true);
> > +		if (ret)
> > +			break;
> > +		ret = opt_setup_xol_insns(auprobe, &auprobe->opt.xol[i], &insnX);
> > +		if (ret)
> > +			break;
> > +		offset += insnX.length;
> > +		auprobe->opt.cnt++;
> > +		if (offset >= 5)
> > +			goto optimize;
> > +	}
> > +
> > +	return -ENOSYS;
> 
> I don't think -ENOSYS makes sense if opt_setup_xol_insns() succeeds at least once.
> IOW, how about
> 
> 	static int opt_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
> 	{
> 		unsigned long offset = 0;
> 		struct insn insnX;
> 		int i, ret;
> 
> 		if (test_bit(ARCH_UPROBE_FLAG_CAN_OPTIMIZE, &auprobe->flags))
> 			return -ENOSYS;
> 
> 		for (i = 0; i < 5; i++) {
> 			ret = opt_setup_xol_insns(auprobe, &auprobe->opt.xol[i], insn);
> 			if (ret)
> 				break;
> 			offset += insn->length;
> 			if (offset >= 5)
> 				break;
> 
> 			insn = &insnX;
> 			ret = uprobe_init_insn_offset(auprobe, offset, insn, true);
> 			if (ret)
> 				break;
> 		}
> 
> 		if (!offset)
> 			return -ENOSYS;
> 
> 		if (offset >= 5) {
> 			auprobe->opt.cnt = i + 1;
> 			auprobe->xol.ops = &opt_xol_ops;
> 			set_bit(ARCH_UPROBE_FLAG_CAN_OPTIMIZE, &auprobe->flags);
> 			set_bit(ARCH_UPROBE_FLAG_OPTIMIZE_EMULATE, &auprobe->flags);
> 		}
> 
> 		return 0;
> 	}
> 
> ?
> 
> This way the caller, arch_uprobe_analyze_insn(), doesn't need to call
> push/mov/sub/_setup_xol_ops(), and the code looks a bit simpler to me.

ah nice, will try that

> 
> No?
> 
> > +      * TODO perhaps we could 'emulate' nop, so there would be no need for
> > +      * ARCH_UPROBE_FLAG_OPTIMIZE_EMULATE flag, because we would emulate
> > +      * allways.
> 
> Agreed... and this connects to "this logic needs some cleanups" above.
> I guess we need nop_setup_xol_ops() extracted from branch_setup_xol_ops()
> but again, lets forget it for now.

ok, it will hopefully make the code simpler, will check on that

> 
> -------------------------------------------------------------------------------
> Now the main question. What if we avoid this change
> 
> 	-             u8                      insn[MAX_UINSN_BYTES];
> 	+             u8                      insn[5*MAX_UINSN_BYTES];
> 
> mentioned above, and change opt_setup_xol_ops() to just do
> 
> 	-	for (i = 0; i < 5; i++)
> 	+	for (i = 0;; i++)
> 
> ?
> 
> The main loop stops when offset >= 5 anyway.

> 
> And. if auprobe->insn[offset:MAX_UINSN_BYTES] doesn't contain a full/valid
> insn at the start, then uprobe_init_insn_offset()->insn_decode() should fail?
> 
> Most probably I missed something, but I can't understand this part.

no, I think you're right, I did not realize we fit under MAX_UINSN_BYTES
anyway, call instruction needs only 5 bytes

thanks,
jirka
