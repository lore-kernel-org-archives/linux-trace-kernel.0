Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB20E2FDC5C;
	Mon, 12 Jan 2026 16:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768236895; cv=none; b=UHzasv9Vlz/00q4C93mP1tbP8Vc2KsVX2zi0FxpFGiznLddcOi6kwhMLmoDVDLTOU3+Z3TfKaB67d0TrR+z+W7hyD903BgDFgOj8Qm4L8dnj/oyhGKOm1nhFwjBAmjDYj2p/t7+WiXnoojl1KriyR/cJ3zTfFRffz/FolF9pwWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768236895; c=relaxed/simple;
	bh=jwnYMhEKwVu0vR7ZQgYLXhidRyb6PMIcJlUy+4WgWc4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iTOB09BKrdtBTeOYHZBKKnugVLFhMFfUypn13My9AyAr4tbAblxoZ5Rl+o1jdN5g8phEVB6yI39pf7hfFeonLL4P1W4I0RUSdIKUNUtMjf3PhpNulUnlOZzXQulb/zADTkwEEa3zRO7ecpkDxjORyspMYxcLgLlJEBNtgDZgcjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 9DDFD1607C0;
	Mon, 12 Jan 2026 16:54:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 5996638;
	Mon, 12 Jan 2026 16:54:49 +0000 (UTC)
Date: Mon, 12 Jan 2026 11:54:52 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, Ard Biesheuvel
 <ardb@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add Rust files to STATIC BRANCH/CALL and
 TRACING
Message-ID: <20260112115452.3e0f63ef@gandalf.local.home>
In-Reply-To: <CANiq72nY2xUj0aG4q7YOKxt0EV29Jwos_kjAPD89eE3_irsr0g@mail.gmail.com>
References: <20260107-jump-label-rust-maintainers-v1-1-702b03482f2e@google.com>
	<CANiq72nV0Z_UjdAwT=41TjjfmKnT6WL4hVNcxg_QCe7TAEYK_Q@mail.gmail.com>
	<20260112100006.7db6d31d@gandalf.local.home>
	<CANiq72nY2xUj0aG4q7YOKxt0EV29Jwos_kjAPD89eE3_irsr0g@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 4q5j8bueff6pnxbmnhg6njdhqeg6roy7
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 5996638
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/xqfRlb6I/2a36Z2SJRgyMvdbEDafFbTE=
X-HE-Tag: 1768236889-694394
X-HE-Meta: U2FsdGVkX19qWfTHJ2XXWhhB/EIyMdyPSb5uPGk5R5CB6/liUJ7vEi5wSeztjz931bytiEc8XNliZYbVowBhvFn5dhzJaEZnOP5FjK3gLO5x6FMt/9qjPVz2oZ3s82jWziSVyyKXryY5De4MGWloL61wB87H6UsDQvHWzVVWumCuBdeJ+Or+260xsmH29MDsfiH6ojSEt6SJPBjbl+cU6zI0+mM21m2gKtWW0PQMHaqEdlNLm2AMOTssoMO44SJgQ66f9ns4npJYPXPbqXzzdwBG458JWLXQDCsgnrgmtdpXvo/QmhXzithsgse/XP2ZblnHZIh8z8MfFBQRNwiYutEMJX0YRFOq

On Mon, 12 Jan 2026 16:11:40 +0100
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:

> There are several ways subsystems have gone about it:
> 
>   - Sometimes they may just add the people to the existing entry.
> 
>   - Sometimes they create sub-entries like you suggest (usually with
> square brackets like " [RUST]" but there is also a " - RUST" used),
> e.g.
> 
>         BLOCK LAYER DEVICE DRIVER API [RUST]
>         MEMORY MANAGEMENT - RUST
> 
>   - Sometimes they add them into the existing entry but with an added
> "(RUST)" after their names, e.g. Boqun in LOCKING PRIMITIVES:
> 
>         M:    Boqun Feng <boqun.feng@gmail.com> (LOCKDEP & RUST)

OK, add "[RUST]" instead ;-)

-- Steve
