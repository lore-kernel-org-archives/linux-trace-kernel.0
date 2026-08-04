Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7ED41DEDC;
	Tue,  4 Aug 2026 07:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785828607; cv=none; b=QHWUdUqKSeOfIDqOKbsRiO+4wtTOK+7aqxw8Kf36Slc98J+FxiPqEUKd5XjIbFmPsYrS5bRrvNfml4V0P8t8yW8/WywIhIsiBWjqXaPJGOBKZsoRE9XXZj7pDHG7iM1GwQzwUmIf1bd6Z2YYloJJR8qiUvjmVMYduFxXsdaU9xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785828607; c=relaxed/simple;
	bh=b4F9hGzF+5muQyPEEUGPr+T9+ufk62mwuN9s2YFqCko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JYifyjuZ0Ypf/P1w+8mpgJBo9aihqdvhfUPZ9T5lABmuyZPhilmSG1C7FJ17W3nvBwZqjfddc2UoPxCeawBEc/7I3GT2jdM8jngjNhyWDBZn92f5iYylPswHWzer8KtNtHu1g8FHTJt0ZyLdnl1o3m88wSOZSlPt9jQXBpvat2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U4W+1B1e; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Kw03iv8Z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U4W+1B1e";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kw03iv8Z"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785828604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b4F9hGzF+5muQyPEEUGPr+T9+ufk62mwuN9s2YFqCko=;
	b=U4W+1B1e0IXhKaJtjaceKiQ02+8BecX6nDXukf6KE2r+5y1M5mW9VJHdFcQir2GAAlHIBI
	chkG6TDfV/G9jW9hfZJGq7CM/2Cv4SVSxTay1NckRINTGOPrtzwvV5Xz+IexCIukeFa6Fe
	ZNaRVry+lLfcwazj9rCkWDZos8rvvMg2pG+Vad9hhKn5PpwXtr+xgmJF+1W11LtlQRPTqS
	802cn6jWmreTqA1GLpvupHXsx4azfDgmh2eUCUu3OYX+Gtwaad1CiIrAoHTRTZXZ6R9ppI
	hLNH9niBQrSTDKWikO77THHd5G0G1JSzmDA+/6xIvQ/evPUfNqLTCUSofsHlTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785828604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b4F9hGzF+5muQyPEEUGPr+T9+ufk62mwuN9s2YFqCko=;
	b=Kw03iv8Zm2nxjWjcOJfwu9raiVE88D7s0TaCbzyPGDn/7xUW9sRktbWwk8AQ1+cCltqVgs
	lFRNF1/4EdtAdsAg==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Gabriele Monaco
 <gmonaco@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] rv: Fix 32-bit build of nomiss KUnit test
In-Reply-To: <20260803150622.322806-1-gmonaco@redhat.com>
References: <20260803150622.322806-1-gmonaco@redhat.com>
Date: Tue, 04 Aug 2026 09:30:03 +0200
Message-ID: <87jyq69wck.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:

> Commit 8da2a8838365 ("rv: Add KUnit tests for some DA/HA monitors")
> introduced a division of a 64-bit value by 1000 in the nomiss KUnit
> test. This does not compile on 32-bit systems, as standard division of
> 64-bit values leads to an undefined reference to __udivdi3.
>
> Fix the build on 32-bit systems by using div_u64().
>
> Fixes: 8da2a8838365 ("rv: Add KUnit tests for some DA/HA monitors")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202608020311.hYjqOG5k-lkp@intel.com
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
