Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE89139579;
	Mon, 14 Jul 2025 12:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752497287; cv=none; b=p21+3c5WaSnWMVcUZ4GeKI1dCziQ6FRBf/EVfL79bwcv69AcuaNsRpTHJ2HZBjv73Z7iws172BUbgKc0n5kkLtYYrVi3DSv6EP/7eRxL/AjMwtpYdF+70jOtnEorN+CYQrVe79T5cmTwysdiyp0KtswqrJb1ss+8Z5uAmS/Gyrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752497287; c=relaxed/simple;
	bh=W1gBBx378huEbUH0UKJW2zvbwvEPzdigrptMNOSbIKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9dGQL+T5sXWmO/ogxI9mHduwAeBwCS9lhPD+JQ2e/D7FgOYvih5Z/100hV3A4spaivolpElJ3ZZh2PgxOzadyyquK5oH4L4yO41qmIGfE3IR4i95nR5IEqps8UCnOg8xLKpzoXd1xzg/n9TTNU/lEqzhy/XTPrKOh4WfxmnfR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZOC64fV8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1TP2UKzZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZOC64fV8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1TP2UKzZ"
Date: Mon, 14 Jul 2025 14:48:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752497283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DIpxN6xYFz8Yqjq9UwnnrNqlfbMEdukPF/7/bPkrB4g=;
	b=ZOC64fV8yrxRmx1RNHaPYZFqHAdR4kcft4LnUXcslrgImE3o8J3ObKtLu6kn2MzYcovRhM
	UlIa75N3chnEMw/bMY4mzd5PaGCuwu3zaThA2x9Z784fowxh+AtTm8jzNMJkjZohcrC+aS
	CSJ75Iq7k7rixi4cS5mxNuFMTsyxo0YffC5BbOTzan2kAJOe6VjnjULQryERhFZXaaG7AT
	P6etVh5x/kp06pc7y27uLve+qu977LPdeHF2FS8bsxJu5Vb9cLVWvsiZEyrNBn4Xj+Ie8o
	BD+nJ91U3RKB6ZoRtSnlN/R5xccLG3T4gt1Uq1HnNgB94wof0Cz/FOuec44FYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752497283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DIpxN6xYFz8Yqjq9UwnnrNqlfbMEdukPF/7/bPkrB4g=;
	b=1TP2UKzZ+hS1KqO7ntISw88fPLNKyXvqWw/fvrbF2E+skH6invyWk7xkTbS7HQbx/dzxw5
	MJBroYGoz6ht1eBw==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] verification/rvgen: Support the 'next' operator
Message-ID: <20250714124802.kjqjNWmr@linutronix.de>
References: <cover.1752239482.git.namcao@linutronix.de>
 <9c32cec04dd18d2e956fddd84b0e0a2503daa75a.1752239482.git.namcao@linutronix.de>
 <7f4409eae10023a804d24ad2a9c67d368db152cb.camel@redhat.com>
 <20250714124208.qVXvUVqp@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714124208.qVXvUVqp@linutronix.de>

On Mon, Jul 14, 2025 at 02:42:10PM +0200, Nam Cao wrote:
> On Mon, Jul 14, 2025 at 02:18:05PM +0200, Gabriele Monaco wrote:
> > Now I can't think of a way to rewrite the model to allow a pulse in
> > sched_switch, that is /whenever scheduling turns to true, the next
> > event is a switch/ instead of /any time scheduling is true, the next
> > event is a switch/.
> > 
> > I tried something like:
> >   RULE = always ((not SCHEDULING and next SCHEDULING) imply next
> > SWITCH)
> 
> Be careful of operator precedence. This rule is also what I would suggest,
> but you need parentheses:
> 
>     RULE = always (((not SCHEDULING) and (next SCHEDULING)) imply (next SWITCH))

Actually no, this also does not work. You need double 'next':

     RULE = always (((not SCHEDULING) and (next SCHEDULING)) imply (next next SWITCH))

Or if you want to allow some other things to happen inbetween, then:

     RULE = always (((not SCHEDULING) and (next SCHEDULING)) imply (SCHEDULING until SWITCH))

Best regards,
Nam
