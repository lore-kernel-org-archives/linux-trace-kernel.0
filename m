Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4155C3A1E87;
	Thu, 18 Dec 2025 01:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766019871; cv=none; b=UaGScG33gqDrdv4A6emNqq7nvwZDsbwZmcKNV16eBv/r8WLYoWiahGpRO68Kdx9RrF+RoASVAGKAfOuu5q5s9iOGmD53I6AwSrDGvRnjZEYvwn4/Jyu9zoXjgKJRu2KMQMKf+fgk3GByE+/teZM61GXxQPzvQhWYPFYyr2A9EhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766019871; c=relaxed/simple;
	bh=bDBkCQ8cWhinGB2q3YQaaISc8alaWVLH5IanyN3CQF4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lCsNSQDpv8FEMzf+aGvr5XvitSKNAXZDv5FqfXZR0u2Jv2hrA547EQZuUbayL+cS7d44CqqRQonn2vMR43ZlMRaa7rKtxW/59AJyPAGKBus/wERXodT1eW46huEqCpzmh0YpPvuP+tK50rTRfTxHN4tDv2cCDxL1ZkX/UalwrMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RizRbGj2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6UBa6bA2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RizRbGj2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6UBa6bA2"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766019867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7IynZpXUNT1v9eN8rS/ZIkaAnuaBqpf4DN/6/h8X/Kc=;
	b=RizRbGj2LC5telwm+jFmDVpLXjQHmqssjpMpduNdPuHBapm2Hmtst2r+k4i7JzZzvLAhy9
	o4sZIzZQhrHeFpyQF8aqZisFm4jOAk7YMuID3iEzYrqnKyl/ho7wxIDKK4/TK18MfhHo7W
	OA64rYMcr93OXmKUMKbkcSTrz+DXsEwQbDDQwFyhCTHar8faqI7qVE3LXpNzFG+xbMwPqE
	6/eygmXIwFUa+PTCuu6Rsnewt6XW18BjKMlxUpUNr4Gffi7uASBwldFKi2JW10ClCPESba
	W/dyZV8Yv1VwmQdeQbhkADmGu9Z/Y8MrDk3JJOaOBI659M+gzMjtBF7si5JqAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766019867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7IynZpXUNT1v9eN8rS/ZIkaAnuaBqpf4DN/6/h8X/Kc=;
	b=6UBa6bA20iW+65qAeDJOzzEf72I+1dYXV1WkSwcuy8qkpHAWpR9Vq5EYRU9PMgEUbX7i3N
	TMcawjtObycJWGAQ==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Gabriele Monaco
 <gmonaco@redhat.com>, linux-trace-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v3 01/13] rv: Unify DA event handling functions across
 monitor types
In-Reply-To: <20251205131621.135513-2-gmonaco@redhat.com>
References: <20251205131621.135513-1-gmonaco@redhat.com>
 <20251205131621.135513-2-gmonaco@redhat.com>
Date: Thu, 18 Dec 2025 08:04:15 +0700
Message-ID: <871pksk3cg.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> The DA event handling functions are mostly duplicated because the
> per-task monitors need to propagate the task to use the pid in the trace
> events. This is a maintenance burden for a little advantage.
> The task can be obtained with some pointer arithmetic from the da_mon,
> hence only the function tracing events really need to differ.
>
> Unify all code handling the events, create da_trace_event() and
> da_trace_error() that only call the tracepoint function.
> Propagate the monitor id through the calls, the do_trace_ functions use
> the id (pid) in case of per-task monitors but ignore it for implicit
> monitors.

I think this overexplains. I would just explain the "WHY", then the
general idea how the patch solves the problem. Let the diff speaks for
the rest.

Perhaps something like:

    The DA event handling functions are mostly duplicated for
    differerent monitor types, because per-task monitors' functions
    require a task_struct parameter while the others do not.

    Unify the functions, handle the difference by always passing a
    da_id_type which is the task's pid for per-task monitor but is
    ignored for the other types.

Regardless:

Reviewed-by: Nam Cao <namcao@linutronix.de>

Nam
