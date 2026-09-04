Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F633242BD;
	Fri,  4 Sep 2026 05:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788501174; cv=none; b=tx7Nl5uXapktHT7VJaJaeo9zR0JUidpcUEPWn6CLsX5yZKhBKiQWO7T+8k4JFzzq2pl2Eha+PUeflmRqKsWMdzYSQ4zprpNB/y4US2NNW+rGEN6wZmvpuetz3hXwXXihyZv1QfKEs8/6HVRwbS05KKr1t1i98L6DuPPyOc/t3PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788501174; c=relaxed/simple;
	bh=e2g3g54KwFRsloJPAlmi/uHZIxA3aMLrYcp7/6+Lfw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBOcXQ31qBzY0/DvSXZYFKhqKozg6LNBPWavIYCVbkklq331y+6bxZA/qNb1CcGtFvLH59o/LX5xiQT0cx+cDsfMhAtaLcHDfhsQqkITujZ47fWkWh8EWyv5gMEfnviW2+XezM7ZjdpdX6V5zfKgl00IV2bcelYQAJSomQ+gmDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C1D03Lq+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C1D03Lq+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990331F00A3E;
	Fri,  4 Sep 2026 05:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788501173;
	bh=8rBoG2WG4B1iwCAvzbGZgp2GuQ0cCStOe5qagQj9a5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C1D03Lq+nvjRKcd/7W7/784Tg9gx27aWeX5H2sCza1ubuuXxLCieCevsSH9pBF5eR
	 C91ehR03zW5/389ehBpo9GcC98dtSWG7EMLpYm9+aTHUG/rniH/BanNLkFhHv2qyz4
	 HRhrr1wA7Sw5tvbT3dsdic+5XB9FkDJJWn90OfCM=
Date: Fri, 4 Sep 2026 07:51:08 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] module: pull out add_taint_module() to be public
Message-ID: <2026090457-aide-backrest-d2eb@gregkh>
References: <20260904-bind_taint-v3-0-30025465f38a@linuxfoundation.org>
 <20260904-bind_taint-v3-1-30025465f38a@linuxfoundation.org>
 <20260904052123.27E601F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904052123.27E601F00AC4@smtp.kernel.org>

On Fri, Sep 04, 2026 at 05:21:22AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The newly added docstring for `add_taint_module` provides dangerously misleading advice regarding the `lockdep_ok` parameter, treating an enum as a boolean and effectively reversing its logical meaning.
> --
> 
> commit 2864484c56cc4bda3a7f73ba92dcb0a54f6a1232
> Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Subject: module: pull out add_taint_module() to be public
> 
> This commit makes add_taint_module() public so other kernel code can call
> it, providing a fallback to add_taint() when modules are not enabled.
> 
> > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > index d0e1e0bd2ad06..444d990c99832 100644
> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> [ ... ]
> > +/**
> > + * add_taint_module: add a taint flag if not already set for a specific module
> > + * @mod: pointer to the module that caused the problem
> > + * @flag: one of the TAINT_* constants.
> > + * @lockdep_ok: whether lock debugging is still OK.
> > + *
> > + * If something bad has gone wrong, you'll want @lockdebug_ok = false, but for
> > + * some noteworthy-but-not-corrupting cases, it can be set to true.
> > + */
> 
> [Severity: Medium]
> Does this documentation invert the logical meaning of the lockdep_ok enum?
> 
> Since lockdep_ok is an enum where LOCKDEP_STILL_OK is 0 and
> LOCKDEP_NOW_UNRELIABLE is 1, a developer following this advice and passing
> false (0) when a serious error occurs will inadvertently leave lock
> debugging enabled. Passing true (1) for minor issues will unintentionally
> disable lock debugging.
> 
> Would it be clearer to document the explicit enum values rather than
> suggesting boolean true and false?

This preserves the existing api, nothing is changed, if we wish to
change this later we can.

> Also, there is a small typo in the parameter name here: @lockdebug_ok
> is used instead of @lockdep_ok.

That comes straight from the add_taint() documentation, so we are
typo-compatible :)

