Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283FA36F41F
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Apr 2026 20:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775679219; cv=none; b=DEoiKJlela2wL0h//wGJ4pUKIRQ+r6XvqZC58j7fO8pbyz/Pds/Dfb+ip4dLhA1RLetUP3c12gvHt43oqy98tsHXtY+SEIW5sTyIsRelzQIV1PsJ+1vEFDfjUHp5DaOMZasCBmr+Li1JWwzqONbZLuQ7E21lZde6jOz/sp6o3cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775679219; c=relaxed/simple;
	bh=GvgmhP0zXh+kqAev56iRmVwSt6NW9FF19MvHlqntkxA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFxbuBY/8zIYKadQn0hTKd8kA8cVwu+IjgYbGlFo7V+IyOhim+ie7UmM+mtUPlwenExJ5h0WpAKmexsHGKUNh6Zl8LJzr7cI+5xICgLQABwPr3uLkjW7AGn1P+qYyD1mQ4T/Am8CrYr2MqkliFQLf44Y13CDbe3cQJBJQZqAZLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=omVtNE1O; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="omVtNE1O"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d02a71526so64909f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 08 Apr 2026 13:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775679216; x=1776284016; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rcC0ByEFy9h43wSPxh/dSOWCQS4PMAnAG7iuN00tuA4=;
        b=omVtNE1OO2baBnW01+1vSgjyDYJfcH4u1wGW3Y6pOR/Y0bpJ2Kp7cWvkRxrpShl5c0
         ESWv72si1ObMVud4hj5KSZRX8XA+jJkFAiMTivmkTd+GIW1nRyCkxQPHDmObnh7I+6L0
         WR2q2xIFO1BzVYMiuoswhB0idd/b7Fv4+7PXZp7wd3MTk2mBJzkfIE/VNzNQDluDBYJP
         2D7aSsgAnbp9GnoMrXUQMFimETDx3rd1XpAh+KevE2MpFgEr1UTqwYM6YlJtUpH23wJ3
         LDOFDDMF0fvpB9E/NpPK/nEmUtxGh1d5RaqxKhClTpFMaeEX2Ay3JF8oSTp0BMeilJk7
         ghQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775679216; x=1776284016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rcC0ByEFy9h43wSPxh/dSOWCQS4PMAnAG7iuN00tuA4=;
        b=S0HQc0izUSJBtWFsqIw91RzdZ+cexz23lfxy+r8k/NwDFtZ6/ljHUkjALBTr0qnhxn
         7JFBn8Zppys5UNSfbayO3N/O6raERJchqY3HbwUh21clPGE5os5hXd56zJSYlAgVLL60
         +6cAs25dpA8T75fmn2yyC2EQ/iNbjmR8T/iDp5ym8mAONtGf8CXUgR3MUeZGa/JiSrmh
         NijzTgfc7sHX5f0ZYi0E70nqcxhRgMU6sadRZTLZakJonK3bPERc2Rvb0g5vjg6+ouHV
         ujyTmHQII/LSZMUxG9CcvOu7vnIv8FWgERIuYnE7NKxdV9qqV9gJYNCz5ERKDwO/qtzv
         Ulfg==
X-Forwarded-Encrypted: i=1; AJvYcCXXSrLB3QGJ5hh+vMt4VFUc/MkyyNFEaAJbTJ7gz8V5k5BO+afkmqN4LGRrawnXOyBgdBNAwQ4PY9oDp+VvZavsD4E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj2uPktUSz4R3EY62J83nI26OmUMb8lbet7JMapn7xAPjZ90ZX
	zTBhi8YtaVq+zGHsuYpUDPshAfZdSpAhsp3f/290APlggiECJLoZR0aS
X-Gm-Gg: AeBDiesOG8fW409dR9hKQFJuRELTwdZcxsyzW6ijfk3Xxx2/BWAaXn+pe+zz76C3qwm
	IaiU6g+m5E3WSgR8UPtuMyrRsVXnN5UUF50cBqqjWH34k9Q4cdR84onLcz1np737jF78r6Xi1jh
	iCgvlJIvtCzee8NPnzeAonzZ0yqVeRBFwmW0BhfL4A2uJv7mjZgE9W9sl+OXJAdCgYG1Sw0dEuM
	ct7nxRhO5UASbve5qLl+rJRfQyj8qbXXSp84zZ3xbEcYVK/lif4sQO6P1vuYui12UU3dORVEwdR
	lb3BjhgR4mGtg2eat50qnFoBhn8oAbfN0fNUzliBh2ot7661aSlEhFuRS4VFwvnK43R0HT3ALE/
	PWiBv9NPb/tuZ6HFztOZKA9JIbhQNM7E633WYAlxDm11JOd2/HAC/teP2ubcZl4PNXm8piRbA0v
	ANr34sXcdt3KwoZirjhD3p5A==
X-Received: by 2002:a05:6000:288a:b0:439:c1ca:82be with SMTP id ffacd0b85a97d-43d5a18bdbbmr836151f8f.28.1775679216325;
        Wed, 08 Apr 2026 13:13:36 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c5253sm54698406f8f.9.2026.04.08.13.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 13:13:35 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 8 Apr 2026 22:13:33 +0200
To: Varun R Mallya <varunrmallya@gmail.com>
Cc: bpf@vger.kernel.org, leon.hwang@linux.dev, memxor@gmail.com,
	ast@kernel.org, daniel@iogearbox.net, yonghong.song@linux.dev,
	rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: Add test to ensure
 kprobe_multi is not sleepable
Message-ID: <ada27R-ai8FvnPu0@krava>
References: <20260408183549.92990-1-varunrmallya@gmail.com>
 <20260408183549.92990-3-varunrmallya@gmail.com>
 <adai2mXaRGpf1Kvb@computer>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adai2mXaRGpf1Kvb@computer>

On Thu, Apr 09, 2026 at 12:17:54AM +0530, Varun R Mallya wrote:
> On Thu, Apr 09, 2026 at 12:05:49AM +0530, Varun R Mallya wrote:
> > @@ -676,5 +750,7 @@ void test_kprobe_multi_test(void)
> >  		test_unique_match();
> >  	if (test__start_subtest("attach_write_ctx"))
> >  		test_attach_write_ctx();
> > +	if (test__start_subtest("attach_multi_sleepable"))
> > +		test_attach_multi_sleepable();
> >  	RUN_TESTS(kprobe_multi_verifier);
> Please ignore this patch. I will send a v5 in a few minutes. I forgot to
> remove the selftest from the previous location after moving it into
> attach_api_fails.

also no need to send patch#1 it's already in:
  eb7024bfcc5f bpf: Reject sleepable kprobe_multi programs at attach time

jirka


> > +}
> > +
> > +char _license[] SEC("license") = "GPL";
> > -- 
> > 2.53.0
> > 
