Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7A024337B;
	Wed, 16 Jul 2025 08:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752655525; cv=none; b=bt+A1JfVA/q08izH9RHiKKZuXk9J/T+4UZwzwZGBhIc6gkGhLNuCy8V3ZtbbuzZKnOZ6TpGX0gEq0KqapTmbIdqyOqnkMhMXKzFpxTIUrImv0fjtLFXJCLqKr3tOR8xQPy+okQzILIKU5seDzjBUKLe3YrsRjEb4JdY3wttQNv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752655525; c=relaxed/simple;
	bh=1NXbWx2kLzPZS55lk3fbpz5DfeiM3JWRD20iG+FWHdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1znX1oz0bHkqp+cjuksCkGo1BMCxgv7sRSc6VwRJi22FDFO6+cprakmcXBEnPsDJzK5iv6iptpmgyyNJmG230OkGyB5QMeDiq0lagKIPZnWCsT6eusCyCw51/D4sH+JohDvs5fJka9MydkpKyBeb3sDv0vXj/NkM/Asf4xGImo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nGGfDAvO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wMBUlA6K; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nGGfDAvO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wMBUlA6K"
Date: Wed, 16 Jul 2025 10:45:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752655522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nIiIKG0sIFehb8gE9KkNPCWT2c8bsmOUJ77N6v2fQnA=;
	b=nGGfDAvOgfbxvQ+ItbHkuKmJc7fhNMXdylQtXADVW6Pij1apU1+3cuJ5OUI84mO4RRfzXq
	xODQFegvJwHIbgOo6xm8clKlUdYBUdjn/R6BKdubKI2P4+ZnKApoHS8vS8rME+eLCA3Gnv
	tpOaiwcxF93rKVPTUkl2XsCEq9lL/i7an95fxhH0NdGFVXPEXoaQXPOc4mlZesRxGsOOB3
	/FZG+epCxkvLNTFW+uBSrdb/0xxnSAGcmp+Cp4YWHM6cuHRYZeSmZsaZiXnpobBHTwfp0m
	bLk4Q2lKSWLv3nMw/AcBQJTrI5vqexMKjcxlfwZeqJZ8/wsAG3pYej5Tts3JMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752655522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nIiIKG0sIFehb8gE9KkNPCWT2c8bsmOUJ77N6v2fQnA=;
	b=wMBUlA6K9yd+vXdEYF702fvYHvbOcxNNvsiv9ZaMcN1ZXk4UrgpBDIlvZMzJMvM7zyhA/v
	bKKqh5wGUWgaBdCQ==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v3 11/17] rv: Retry when da monitor detects race
 conditions
Message-ID: <20250716084520._QLbd5AY@linutronix.de>
References: <20250715071434.22508-1-gmonaco@redhat.com>
 <20250715071434.22508-12-gmonaco@redhat.com>
 <20250715152322.Os4lDq_B@linutronix.de>
 <e2f4f8d372612cd61689b91562e73677599d08de.camel@redhat.com>
 <20250716082712.L9z_ptHK@linutronix.de>
 <f7028488e9d820848955de87ead3ec619fe5dbec.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7028488e9d820848955de87ead3ec619fe5dbec.camel@redhat.com>

On Wed, Jul 16, 2025 at 10:38:11AM +0200, Gabriele Monaco wrote:
> On Wed, 2025-07-16 at 10:27 +0200, Nam Cao wrote:
> > Can't you bring the monitor back to the init state, and start over
> > again?
> > 
> > I think "da_mon->monitoring = 0;" does the trick?
> > 
> 
> Yes you can, but I wouldn't do so silently.

Why not? The absolute worst that we get, is the rare case where a bug
appears at the exact same time. In that case, we would get a false
negative.

And I think that is really really rare.

> I'd say the cleanest approach without reaction is to still return false
> for the system to do all the cleanup but trace the event or, at the
> very least, print a warning.
> 
> But you're right, this is more relevant for who develops the monitor
> rather than for the user, so should probably be tracked separately.

Yes, if you really want to emit some sort of warning here, it should be
absolutely clear that the monitor itself is having a hiccup, not the
monitored kernel.

Nam
