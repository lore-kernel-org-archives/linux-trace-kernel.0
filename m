Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F022F30;
	Tue,  5 Aug 2025 12:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754395975; cv=none; b=LI1kD8+ERJHYUaLN2J/vdnpEV6y2jjPQ+s7M6qEI8+aUeyTwPZfeSENMT8Rm4+mIOnHyBznrFjJUXEKQDlOtay41ahSV1cnJH3HrsHRTnUYbSefQL0sRNMIY0fpR/txvwP+AqhEFJAnEcLy+H0CRNRSnTA1wJsiKKe5gHSZl4Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754395975; c=relaxed/simple;
	bh=XEe5GwvUuxJ94Qys4VzLW2ziwdJ5X2iTt4u5ZqlZIvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UaCACWZAEJ8lV66wf7ks7fal7JXuqYP2N22mHOuwcZNYzOkEZEqZjwWihnZZbxAIR3wylmUMCqsKfK8QO0GbBRRbJqLFGxB+meYPupZHzUt5Q+FOUbrA9RUpofJ7bYju16ULT97zYpb8quHw3VYAwKfnowFAeZ24fgeZcVFgNP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OxkzuWCb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ISk2V2+X; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OxkzuWCb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ISk2V2+X"
Date: Tue, 5 Aug 2025 14:12:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754395971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZAtT9tp5MBYGM1sexBghcdNMuYOkqVy1X03IbBuggP8=;
	b=OxkzuWCb4eiwB7DkjOkBLeYUxNBsspEps8IjWdnmofUBfmeWkWItYp0ExVzWMNu1RpY4qS
	X/K/43jthUfVcqChTMvT27m9wy6vfVvuYsnwb93/1SgEuRvqd6UM6mw2oBfiOuaHELs4f3
	E+VcPpb+diILfsMsOdK1U3MVp+5JzkmfPVDaFBOmGuKfpvxFd2R93rTQZNEb3y/9CaNG7K
	jfscuCzHeStp19E6qx7qwjtrV9KjtFoK5YfwZ9ulavbv+gQEHR28bZR/ZfQysqY5bltidn
	ViiQdL+wSQqEDcQneOon8SJ30+VvxV3vRvApLj3YUWPAwk++RyvUzGp6f7TxRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754395971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZAtT9tp5MBYGM1sexBghcdNMuYOkqVy1X03IbBuggP8=;
	b=ISk2V2+XRzWcf8iRqmqqO4tSMEKntmkfgoJOVX6QLPaBRlx1Vgn9gRZg/TFeuF44yzct7j
	C8RFFJ4krw5JxIAA==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, rostedt@goodmis.org,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rv: Support systems with time64-only syscalls
Message-ID: <20250805121250.XhObb6Oq@linutronix.de>
References: <20250804194518.97620-2-palmer@dabbelt.com>
 <580bf2db57cefa07631e73e5af453228cfb3cecb.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <580bf2db57cefa07631e73e5af453228cfb3cecb.camel@redhat.com>

On Tue, Aug 05, 2025 at 08:18:46AM +0200, Gabriele Monaco wrote:
> On Mon, 2025-08-04 at 12:45 -0700, Palmer Dabbelt wrote:
> > From: Palmer Dabbelt <palmer@dabbelt.com>
> > 
> > Some systems (like 32-bit RISC-V) only have the 64-bit time_t
> > versions of syscalls.  So handle the 32-bit time_t version of those
> > being undefined.
> > 
> > Fixes: f74f8bb246cf ("rv: Add rtapp_sleep monitor")
> > Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
> > ---
> > This seems a little ugly, as it'll blow up when neither is defined. 
> > Some #if/#error type stuff seemed uglier, though, and that's the best
> > I could come up with.  I figure anyone without either flavor of futex
> > call is probably deep enough in the weeds to just figure what blows
> > up here...
> 
> Yeah, this is getting ugly.. I wasn't fun of this ifdeffery already but
> a few of them seemed acceptable, if we are really expecting any single
> one of them to potentially not be available, it isn't looking good.
> 
> What about doing in the beginning of the file something like:
> 
> /*
>  * Define dummy syscall numbers for systems not supporting them
>  */
> 
> #ifndef __NR_whatever
> #define __NR_whatever -1
> #endif
> 
> #ifndef __NR_some_exotic_syscall
> #define __NR_some_exotic_syscall -2
> #endif
> 
> The negative number would never match, we may add a mostly
> insignificant overhead checking for it but we keep the function
> readable. What do you think?

That would be much better, but the patch is fine as is, so I'm okay with
merging it:

Acked-by: Nam Cao <namcao@linutronix.de>

The patch is just matching the existing ugly #ifdef style (I wonder who
even wrote that). So cleaning it up can be done in a follow-up patch.

Nam
