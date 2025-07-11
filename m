Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1D22ED149;
	Fri, 11 Jul 2025 16:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250093; cv=none; b=G8ZS2pgYJvc41AOfgCvpT+HN0pJz0zZTB4jSgzaM8sGQybfgQH9oF2y7yqS4TXodIBaSW+GKMgvMV0y8wLkHtIe5vRvJKsIeOnk5U0sf8LRPBhfPvqy6TRGPdeiYPokz+U7hbwBjxs0v8yP8RetDe0nDYUEovgwP4wRBi8ADQ58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250093; c=relaxed/simple;
	bh=Uy4Zxm8qEhAQy0/hG84LOWQs66Csqb8gSMvRyqPJ0ck=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B3NVnCbXdXyjhMkVZmFx20kVNaeHZHDJCgqzvFyvObjHj4RrJPNuF/sjdJB7Ox/QkkyDBe4bnh7IEQsXeTMZ2Pw4vR3HNjDg23sPYGRnWL3SrqPwQFamzUAuvm/vRQ0zKCrb/4rNWDw7yJRGPV9nJewmgHyeT1jROlflSgAuaX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 2663C80A3C;
	Fri, 11 Jul 2025 16:08:02 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id E8EB620024;
	Fri, 11 Jul 2025 16:07:59 +0000 (UTC)
Date: Fri, 11 Jul 2025 12:07:58 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Nam Cao <namcao@linutronix.de>, Gabriele Monaco <gmonaco@redhat.com>,
 John Ogness <john.ogness@linutronix.de>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Remove pointless memory barriers
Message-ID: <20250711120758.3f6904e9@batman.local.home>
In-Reply-To: <20250711092946.1bbd58ef@pumpkin>
References: <20250626151940.1756398-1-namcao@linutronix.de>
	<20250626113520.315db641@gandalf.local.home>
	<20250626160459.soHxOROG@linutronix.de>
	<20250626123445.5b01849d@gandalf.local.home>
	<84o6uatn6i.fsf@jogness.linutronix.de>
	<564f10574f11bd7ca42fcc5fb4d6c5625dc17205.camel@redhat.com>
	<20250708074219.K7BthlGg@linutronix.de>
	<20250709110827.0dce4012@batman.local.home>
	<20250711092946.1bbd58ef@pumpkin>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: n75e47kzdasjzuxp45e7bn6wjorpqtek
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: E8EB620024
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/fdHFSxGdHkrgqj6zrC1ejyafkaGQjA4Q=
X-HE-Tag: 1752250079-604324
X-HE-Meta: U2FsdGVkX1+uNop2+UGknTnVPsmahA7Y1zkbmQ32Nq/YDGwvYOKI3ZvYEdhKqA/YxGcxDSaPHyxsZgWvPXNRKIft1yY8eE1zUmEae56Zlbap2j/dv19WZr+5bD5RaMqg1A04U3wHF7yJpP8Jz+N9JVhdQQv+Idy101nAo1CTl5lJjUW5a4XcbqFysAnSFj7l0YMHsLqngfrRjLAmiIk4uQjLLsKjZcrtZWJKCUu6px80gCJSKGlhf1h8ol9qFWTRL07UBcYPG7IBNiUej5RlTz3y9LQcB6Z/BCl7dw6/E3sVk6rzNxJ6Ws4Q2LgAcw79EwIKqwSYG2kNnJCthdPZkN/4lLny/3qs

On Fri, 11 Jul 2025 09:29:46 +0100
David Laight <david.laight.linux@gmail.com> wrote:

> > Doesn't atomic make sure the values are seen when they are changed?  
> 
> No.
> It normally just ensures the read/write aren't 'torn'.
> Atomics are used for read-modify-writes to ensure two cpu don't
> do read-read-modify-modify-write-write losing one of the changes.
> (They can need special instructions for read and write - but normally don't.)
> So here just the same as the volatile accesses READ_ONCE() and WRITE_ONCE().

At first I was about to say "But wait! I rely on this to work in other
parts of my code", but then realized I use atomic_inc_return() and
similar that actually do make the update atomic across CPUs.

-- Steve
