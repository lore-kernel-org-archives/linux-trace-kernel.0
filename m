Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD561CD29;
	Tue, 18 Jun 2024 15:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718725393; cv=none; b=Yfz81RglXadEPN7Jv9DxV+pO19aTm5Q2RiNGS0zZBtgRjyoHhaoyWOKlrWdvcTwKlLgXH31F1nE0UXA9E6sQ1ZfXQW7bLghbgaT5GIoiDKle8xEHYZ3X9BAUJko+1QHl+vIFVeItqM/dm72SIvUvTolytwb6KfFFhikcs9X+HEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718725393; c=relaxed/simple;
	bh=gGx8gkJpM9wjGl4dfZe8iwSMFIAJ8nVorKm3b84gtgI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s8yvTHbGkIXUzGTVTnyTqRBt0bQd79Yb357nObAAoUr0zogyp9+Ifb6j88FzRPQ7OyLH6QEoD7wgtNW4rLVUwFdUMpKlIrjo1KNKgY+E8CTxxTlBcXtKDkTylGVFaCSbY3Vd9LEvlBseVnhDjC4960ZnyG/kxquCMAiodLEEgEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE13C3277B;
	Tue, 18 Jun 2024 15:43:08 +0000 (UTC)
Date: Tue, 18 Jun 2024 11:43:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexander Graf <graf@amazon.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Vincent Donnefort <vdonnefort@google.com>,
 Joel Fernandes <joel@joelfernandes.org>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, <suleiman@google.com>, Thomas Gleixner
 <tglx@linutronix.de>, Vineeth Pillai <vineeth@bitbyteword.org>, Youssef
 Esmat <youssefesmat@google.com>, "Beau Belgrave"
 <beaub@linux.microsoft.com>, Baoquan He <bhe@redhat.com>, "Borislav Petkov"
 <bp@alien8.de>, "Paul E. McKenney" <paulmck@kernel.org>, David Howells
 <dhowells@redhat.com>, Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v6 0/2] mm/memblock: Add "reserve_mem" to reserved named
 memory at boot up
Message-ID: <20240618114307.48513bb5@rorschach.local.home>
In-Reply-To: <cd759ac0-73e6-4ab3-a2d0-94f43eec5752@amazon.com>
References: <20240613155506.811013916@goodmis.org>
	<b0ed328f-c4e5-4e9b-ae4e-5c60703ab376@amazon.com>
	<20240613131212.7d1a7ffa@rorschach.local.home>
	<7c90c574-5cfa-40cf-bd4c-1188136cd886@amazon.com>
	<20240617164006.198b9ba3@rorschach.local.home>
	<049b2e0f-00b2-4704-8868-1569a006a134@amazon.com>
	<CAMj1kXF3AetyuLh-QU8yaE-wTLcgyzwuAwe-uo_3EqSDsAYhuQ@mail.gmail.com>
	<cd759ac0-73e6-4ab3-a2d0-94f43eec5752@amazon.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 13:47:49 +0200
Alexander Graf <graf@amazon.com> wrote:

> IMHO the big fat disclaimer should be in the argument name. 
> "reserve_mem" to me sounds like it actually guarantees a reservation - 
> which it doesn't. Can we name it more along the lines of "debug" (to 
> indicate it's not for production data) or "phoenix" (usually gets reborn 
> out of ashes, but you can never know for sure): "debug_mem", / 
> "phoenix_mem"?

I don't see any reason it will not reserve memory. That doesn't seem to
be the issue.  What is not guaranteed is that it will be in the same
location as last time. So the name is correct. It's not
"reserve_consistent_memory" ;-)

-- Steve
