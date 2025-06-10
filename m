Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99D323ABAF;
	Tue, 10 Jun 2025 13:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749561445; cv=none; b=IFQckAEi/ggBUA7kpfr8D6I3e0HK0vxOOpwBYZkdyni8/WNTKjImw0hXq5ugUIm/5vAMhQVhWEI7lMaX58AgCbCbGWF1oIGGNf1L+O29Z2hn/5hiRS13BxQqVA/af7S8FURpI+chWFUwJ3Qy/8wfkwqJyK2HqS9NMiCLQAIifHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749561445; c=relaxed/simple;
	bh=dz1nForE60TGbX0NZ7KAl5DGAOgistdZ8OxJGTZaS2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u0enoZ5ZT0QXRo2Qkn6yzBr5T/r7T8YLQP274rAQc3WvBV6fLCTjivSjVQDzYyNqueHw7ZKDOAi5RPNcp/XYTEjzdfjPZ92yqVcqdwBOyb2E5ZzQp1LrQxirNmIa0zB6nz1zxpMLhCtw5InKg2WSuAS6k3wpKzTkwNvhwt6jP5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 7CF0F1A030E;
	Tue, 10 Jun 2025 13:17:20 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id C2D5C2000E;
	Tue, 10 Jun 2025 13:17:17 +0000 (UTC)
Date: Tue, 10 Jun 2025 09:18:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, Caleb Sander Mateos
 <csander@purestorage.com>, Peter Zijlstra <peterz@infradead.org>, Ingo
 Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner
 <tglx@linutronix.de>, linux-mm@kvack.org
Subject: Re: [RFC][PATCH] tracepoints: Add verifier that makes sure all
 defined tracepoints are used
Message-ID: <20250610091847.3b2aab45@gandalf.local.home>
In-Reply-To: <20250610145305.c925856f0201fb748c08b331@kernel.org>
References: <20250529130138.544ffec4@gandalf.local.home>
	<20250610145305.c925856f0201fb748c08b331@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: C2D5C2000E
X-Stat-Signature: x1m8jzjsokj43cc5gyf4a9ayj8remdka
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+aVSuBLrD9SxdYHA0aa0neCQue+qWn+mQ=
X-HE-Tag: 1749561437-404641
X-HE-Meta: U2FsdGVkX1/BidFPX/u0H1GWobAiAn0PtNSDAOg4u4GzInF4/7tgJ6AvhBjrCtbCKnf59UH9ojK9a67ocP+Kl9SB50+0e8HylGpeYb7jomtRutHC8/Ykw47mhWnIYM8LxkkiPP2gO32iLgEfWFNkIWk5xo7wFj74MTnBl0fiP7Crxa3qh0BZLjB/lluadgJpKkzUeF0cIDA/UKemKZEgAIN8Q4RAxlPHQgzJVDK9da3tW/9mJnwwJ1xCi7js+HMTT4c2vhvH3i7BXvXdZP9PzU+LNMX0eXkOhsMnJcCZoFCYCiP7DV3luBjFu5aqIGqtZwfpgbxPkq/Bl5rUtuTzULnTFzJESBVk

On Tue, 10 Jun 2025 14:53:05 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > 
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> > index fa5f19b8d53a..600d8b51e315 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -708,6 +708,7 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
> >  	MCOUNT_REC()							\
> >  	*(.init.rodata .init.rodata.*)					\
> >  	FTRACE_EVENTS()							\
> > +	BOUNDED_SECTION_BY(__tracepoint_check, ___tracepoint_check)	\  
> 
> nit: Shouldn't we also make this as TRACEPOINT_CHECKS() ?
> 
> Others looks good to me.
> 
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

In my "build time check" it requires these to be there even if it's not
used. It's how it determines if it's not used by seeing if this section is
empty.

So I need it not to be an option.

-- Steve
