Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E908821FF5F;
	Tue,  7 Oct 2025 19:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759866532; cv=none; b=TG1C+QkQKwkiOAvD3Rq/LX4zEs7vAoiBlmWOF+yWA3F02PrG5h0iaPIudzR6ae4UTF0JSk2e66DU33dopvGF45TLpTifI1jSwjp6C+t26Ldq0vc3H7DgrtTFTP1vSLfoZ7nRJLhvSiimRi9Qfmt109cld8gbJTCW8HnNhJs4fRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759866532; c=relaxed/simple;
	bh=nOHANFyCsFyXoIL9liUDQHLiSZZA1TpLU3yTBKW3+gE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g6PE9zR0o7O1Z0mUz/EhWZmgE+qWfqeL9ApSft6sTsSVULkVILxaUA5BIo3avjXXDcw4cMFFmNz7iAYRuGHhL1wCsYwfXVh1t+qce4AkceoyeI4hUz6SdUTTRGYk/6MZnb6rTorW3MYHfDuf11/nOPmLee2Ev+JpDShPOspWyUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 198741DE2F0;
	Tue,  7 Oct 2025 19:41:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id B4F9E2000D;
	Tue,  7 Oct 2025 19:41:16 +0000 (UTC)
Date: Tue, 7 Oct 2025 15:43:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Runping Lai <runpinglai@google.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Wattson CI <wattson-external@google.com>,
 kernel-team@android.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Luo Gengkun
 <luogengkun@huaweicloud.com>, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: [PATCH v1] Revert "tracing: Fix tracing_marker may trigger page
 fault during preempt_disable"
Message-ID: <20251007154308.5b158d04@gandalf.local.home>
In-Reply-To: <CABgk4RQwGsn4CdP0K+_7A0j7RVOiHNfoF1ESk17wEuzCea16pA@mail.gmail.com>
References: <20251007003417.3470979-2-runpinglai@google.com>
	<20251006221043.07cdb0fd@gandalf.local.home>
	<CABgk4RQwGsn4CdP0K+_7A0j7RVOiHNfoF1ESk17wEuzCea16pA@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: urxnjt669bhdc6wji94s6qkr5tqjcu4r
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: B4F9E2000D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+hVXlRtvcPL61t77f+RImbITjCuVK+6UA=
X-HE-Tag: 1759866076-65905
X-HE-Meta: U2FsdGVkX1/ted36HpkHF++cHmrIJsIRMDKanGvtSPlNTJnNDqXm1h2aBdGzxhF8rJ1nbxJML56GqUrcdDHz9Tl/gpA6fU8Uj0pm2UMOOPdUhraLMZuSTByNQ9DtH8rrkM/eh+QBP4z27Oiah3phjWhGuTP8hRLhvL8rDV+UKJyqdliVCsmwCzIeDy/qTzC5rqukCYdUiGD4K+TP5CsUFJV3uJ8z3sieWq9Z+PpELJQpbprl2aAKrmcxNiB9PDq1DO/PWaAMy8j4p1JyeBR+tDAHCFS+TG3KthTU4kZtbR1FM1xxh1UCevkVK3GMgp6Gq7PUHtSCw2x9H1Td2JkACCFzy6NwtECF

On Tue, 7 Oct 2025 11:19:34 -0700
Runping Lai <runpinglai@google.com> wrote:


> Hey Steve,
> 
> On Pixel6, CONFIG_PREEMPT is set. And CONFIG_PREEMPT_NONE
> is not set. I'll paste the full PREEMPT configs:

Hmm, now I'm curious to why _nofault() does't work but inatomic does.

> 
> >
> > The original code is buggy, but if this is causing a regression, then we
> > likely need to do something else, like copy in a pre-allocated buffer?  
> 
> Sounds like a good plan. Before the long term fix, can we please
> revert this commit?

Not that easy as the old way has a legitimate bug in it.

Could you see if adding pagefault_disable() and pagefault_enable() around
the __copy_from_user_inatomic() works for you? Or does that have the same
problem?

I do have a working solution, but it isn't trivial.

-- Steve

