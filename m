Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592D2330D30;
	Thu, 18 Dec 2025 06:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766040612; cv=none; b=ZRf5uo2iAZCsEbHdgS/XO3eyHn56C64dYrcG4R9IpiuO7CNNcr3rnxDHcfiyV4Yu2pPPjH1f/TvUsmZOrMhZ/Z5t8+7t6vXsTndra/4DUqPHESt7bMWHXDOJGKQsR8qpP7u7qukQ00X1XVVoc6/wq7DVTXYLxkyZ2opy2aoLi4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766040612; c=relaxed/simple;
	bh=sLR5ycW13Ee+BW0II1CaUwlFCxgLKorpCzmXU5oGFKE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gf3AIlPLhgJM7O1vDPsw70kMD0pXKYKTB3aUIfcWlFv8s8RI0Ub/C4oJAcL+8+e9xdPmvy86JIfu59qmjf3V08pflsXw1rtfC6ntAgjv9LNTdPaXjrJPw7hMc2f5hRklm7pW0mdvmdQSRpSgranuq94A+nRemTMnNyalNSQfxL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BJBePF4w; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cyqy2sk1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BJBePF4w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cyqy2sk1"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766040609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sLR5ycW13Ee+BW0II1CaUwlFCxgLKorpCzmXU5oGFKE=;
	b=BJBePF4wUPbXGmABKn9c9RyBLWJvRALhaPEawgpGNG953KcNBtqZusdWP+MPzwZy9BN85Q
	1fSJ9DMVoDG2Oo6xrt5x/tJtTyxn3/F8v8flysJ1tgoB6pPXqeUTgU5/IkWw4UV8y2hFBR
	oRZowEAKj6SDHE8X75z6IDs99nVfKD7EdzwwJCLQ8cmUw6403H+4vYingXypWEFQXgR8xJ
	9drwpg5iZpU/lkP357cSNCjCyLwFeio43kWZ8VVJamkFxQvp//MQm2BD8syAXhwuJoxQ4I
	HdF/E0bmlUpd1BGEy2Did+A9yVDXGJE+4U9Pj1Cd6O+9nq8IVwv58rIZgB07lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766040609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sLR5ycW13Ee+BW0II1CaUwlFCxgLKorpCzmXU5oGFKE=;
	b=cyqy2sk1uox55aquzCmbA0DuUYV05Eu6El+gIeeIOB8HDHFurHCYRz4i0aZ9uvqCzSBEPW
	r7WgFHKqaMs3oRCw==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Gabriele Monaco
 <gmonaco@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Masami Hiramatsu
 <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v3 07/13] rv: Convert the opid monitor to a hybrid
 automaton
In-Reply-To: <20251205131621.135513-8-gmonaco@redhat.com>
References: <20251205131621.135513-1-gmonaco@redhat.com>
 <20251205131621.135513-8-gmonaco@redhat.com>
Date: Thu, 18 Dec 2025 13:50:01 +0700
Message-ID: <87qzssi8rq.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> The opid monitor validates that wakeup and need_resched events only
> occur with interrupts and preemption disabled by following the
> preemptirq tracepoints.
> As reported in [1], those tracepoints might be inaccurate in some
> situations (e.g. NMIs).
>
> Since the monitor doesn't validate other ordering properties, remove the
> dependency on preemptirq tracepoints and convert the monitor to a hybrid
> automaton to validate the constraint during event handling.
> This makes the monitor more robust by also removing the workaround for
> interrupts missing the preemption tracepoints, which was working on
> PREEMPT_RT only and allows the monitor to be built on kernels without
> the preemptirqs tracepoints.
>
> [1] - https://lore.kernel.org/lkml/20250625120823.60600-1-gmonaco@redhat.com
>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
