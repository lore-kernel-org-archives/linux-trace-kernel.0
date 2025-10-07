Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CB6241CB6;
	Tue,  7 Oct 2025 23:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759881432; cv=none; b=BpkmVQ9l4ZbOqpaRVA75UNGmrO0y8QZuLseFEP1losD/VJEiazjGyckQQwjDiuAxJg+z7RWmyE3ajVTFQehgKXjpwTCHoNGo4HDvbN9RyRPaPKO3OTTI/Du2He9S5+qpSkg04YazrCs6TJnM2IA2rY8xOK2uLT7Y0+v6gE9Ne1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759881432; c=relaxed/simple;
	bh=1lt/GTVLCLNZSIET9CdCaV6qRR/vWL2EfdDCZp2fU48=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cn+njngx34Mg6CLhkIP8Hg4+9qhtkKs1BA6wd7ySZB4mrB88kzBHQK35sE7UY57lnbJ7oNKpggDs6QguZ3coJRvde2h0pjUBoKoBQiZrW/S/VuACAORL6R02a90YpMgu/etvIQhb/JTunu2mq2kTXdlJyV3liNBazIee1fJdvdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IN4k8QBy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IN4k8QBy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C2FC4CEF1;
	Tue,  7 Oct 2025 23:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759881431;
	bh=1lt/GTVLCLNZSIET9CdCaV6qRR/vWL2EfdDCZp2fU48=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IN4k8QBy1X/rmTBeABtwBwH/i7YVJQPMCxs68EIHfekm6+GpR0JTwAXZmorJeKDKQ
	 vFCDHlI4m3FQ999udFeUMvUzwZA5ZKSZu18hkmE8zd3eUXVH8nfICAjHa/dkrCz+Tz
	 N8G536fyGyZhxxsDO//IFuOUy6ni5ks9uJBBdikaEoNfb6oYMvuUhJX1Rb2iq7BRA+
	 BI0dpf79EAXg2+zQ7rH/ylx/HmLgoccQ6GPM/B8pIeJqKwA0YbdJqDv5K/uEwUFALx
	 mTJgN4kkigiWxA9LIgaZvDbsLoVZw9YRk+/fmLSFOryhCWv8y+E8mGjHn0bQx9pCQe
	 p2EfmMeHlPHtg==
Date: Wed, 8 Oct 2025 08:57:07 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: probes: Replace strcpy() with memcpy() in
 __trace_probe_log_err()
Message-Id: <20251008085707.eb3cacb973269b94a8db4388@kernel.org>
In-Reply-To: <20251007191415.01f9005e@gandalf.local.home>
References: <20250820214717.778243-3-thorsten.blum@linux.dev>
	<20250825160540.9a5272a8a93a789eb36a7098@kernel.org>
	<635528D7-9B5F-4B7C-9568-87375BA866C3@linux.dev>
	<20250909085308.15a7f4379b5d324051bbd383@kernel.org>
	<20251007191415.01f9005e@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 Oct 2025 19:14:15 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 9 Sep 2025 08:53:08 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > On Mon, 8 Sep 2025 12:13:23 +0200
> > Thorsten Blum <thorsten.blum@linux.dev> wrote:
> > 
> > > Hi Masami,
> > > 
> > > On 25. Aug 2025, at 09:05, Masami Hiramatsu (Google) wrote:  
> > > > On Wed, 20 Aug 2025 23:47:18 +0200
> > > > Thorsten Blum <thorsten.blum@linux.dev> wrote:
> > > >   
> > > >> strcpy() is deprecated; use memcpy() instead.
> > > >> 
> > > >> Link: https://github.com/KSPP/linux/issues/88
> > > >> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>  
> > > > 
> > > > OK, looks good to me.  
> > > 
> > > Did you forget to add a Reviewed-by: tag and/or to add it to your tree?  
> > 
> > Thanks for ping me. No problem, I will add my Signed-by when
> > picking this to probes/for-next.
> > Since I will be responsible for applying this patch and sending
> > it to Linus, this includes the "Reviewed-by" as well.
> > 
> 
> Was this ever sent to Linus?

Yeah, but rejected with other patches in probes/for-next.
I thought it was a part of cleanup, or should I sent it urgently?
Then I can move this to probes/fixes.

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
