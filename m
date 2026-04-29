Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C77C28CF77;
	Wed, 29 Apr 2026 20:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777493029; cv=none; b=Dd6WhfLvLF2vMdv6dFQ/4PTn5tjETYf7j/2C5FF8K5TF6zilTmUSRB/M/04C+E04yEQxJEMW2zcxDAmZcsHmCRfNRYwLEXflGs2We4+/r1SstrvwMEdiaOX1WU440ik8sHiGwIxFeZvkTR+2qAiBVxypSW5zC6YqMg7cIG7330U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777493029; c=relaxed/simple;
	bh=h0IQVlvRuE4TyYyyTYn5ytPGsD4u49LlWz15fvfCedM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bG11ay4+xb+h3YPOUsK4lWe6waS5XqPQqbMXJ2ZKOhVm5z180IBGfZkWlqD2He9LuYl+0nkMZu8pUmITrRFtbqyPC0DfGuph7VgEyFPbl2XtcozwzG45uRUoaV+82hhxaBbNbOp8XLuLShFk5xLKx0n0qCDoTW7lbGI7r1PzG0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 599641202AB;
	Wed, 29 Apr 2026 20:03:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 9859D20031;
	Wed, 29 Apr 2026 20:03:27 +0000 (UTC)
Date: Wed, 29 Apr 2026 16:03:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Jens Remus <jremus@linux.ibm.com>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat
 <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>,
 Florian Weimer <fweimer@redhat.com>, Kees Cook <kees@kernel.org>, Carlos
 O'Donell <codonell@redhat.com>, Sam James <sam@gentoo.org>, Dylan Hatch
 <dylanbhatch@google.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, "H.
 Peter Anvin" <hpa@zytor.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko
 <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [RFC][PATCH] unwind: Add stacktrace_setup system call
Message-ID: <20260429160344.7e5510e9@gandalf.local.home>
In-Reply-To: <20260429145815.69dcb1c0@gandalf.local.home>
References: <20260429114355.6c712e6a@gandalf.local.home>
	<ade15347-6eca-4204-9f64-9b2eed9e9aec@efficios.com>
	<20260429145512.461e09fe@gandalf.local.home>
	<20260429145815.69dcb1c0@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: hxmfe7w3wr9uor4dyg3j855xon8st3j6
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 9859D20031
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX186XI8crKb965hYUI0qx9vjtudljjAJgUY=
X-HE-Tag: 1777493007-670399
X-HE-Meta: U2FsdGVkX1/TBjG8hSoOxbc0HZA3uowb1SBiYXQi2NrjxeYnWdQaclcONKJgECfsJoo25ZtVC/fp3Gz4CNgQ+fZfcs4wU6tQr9v2lzJgpYHoLQv9Bkge/n6fmf0JQ4K98HWuAQdHWBdJfviISNmc2T2aZjB66yvD00L5mCqRewibu4f3iwFrL3uFhbXoJClL7d2gk86HaLeNkjY958Wp5yDeC0bKA4Q7+rpJZfTQpzzj5lCY0PeUnmNyfqyLNac/uohP0UK78Xh/ZGp8hc9ASfe7xE4xGgoMZJV/wgZtSbQ5EGB/9XZvfV35ijoAJyCWpSb4vg2nZE99X1Rewj0ZsWXxy6Fj4h/MTEAk7505q/DuwLKGwm3BSMebBTcnRtzJ

On Wed, 29 Apr 2026 14:58:15 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > If the main executable doesn't have a sframe section, I don't see why this
> > shouldn't be allowed to add one.  
> 
> The address is added via mtree_insert_range() which states it will return
> -EEXISTS if the range is occupied.

I confirmed this. I changed the test program to load its own sframe section
again, and it errors out with -EEXISTS.

-- Steve
