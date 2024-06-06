Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50861991BD;
	Thu,  6 Jun 2024 17:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717695358; cv=none; b=jlwh9MiF5OJfPl1KR1Y6TvPTzOkkvwI7qUxgvMuaSx5pSsV4iE5l3f35WQJFij1st3AW9xOXqRd0V72xRmeSwjeE+iFZJ7X/PWLs9L7YN2yLnoUnw+IBvNwiISyCMCl7xr16VoW3p5NZT1h0OwQ+V4frl5/Z8NDTIGEL21EvEsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717695358; c=relaxed/simple;
	bh=K95UY5fmgibcQQ6sthv1S5/PdLYNFoyPKt9sEpSCbeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WwqQIxUWXBQ3eeitP4IqhMunjStPnSqSgZefic71HNvFxu+P1+P+Tl8ynbYa06b5CP3SkbnIqHNYWVHUqaaxXilw0+qfGy15ub4DHCoRukPExjGoLXuVKzVApxU25XUffNmq5Pcj8Ir+6Pa14ojrMcLXE0nRYUXHchBMdOtOMv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=l0DHKAp9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l0DHKAp9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Rey5qJ7BY13ky3bigo4MWBL8ulxyTtDItl78FrbFPQE=; b=l0DHKAp9pgwOYJGy6q17IxAKYk
	InZ8CQSKwrYAb46Fg4KCTzN0hqcA6Dse+Q+x9G57PSijSP0134gUjHRdPavJ79WSIX7dEMkbz93QU
	Ak/4eVkq9cFudul86GtuBwn5f6BsMhNAi3HHmYdDU67cgiROZ0a3SOWbF8OmAPX7eBCh4sXDTBHeL
	mm9e72L3F2C0zI7Kz+v54fJUrG//TSU1Oqpp7LPaZany+XqCeWqqoO0omgFXfKSZxVZXFVu+Qvk1b
	OLlXB5X7JmZ4xv/eEK+EON/AXSs9gCkVe21PhVDJssmS+P9//zSPOLxhNuK798NJXn+tjo2u6HBEk
	XR4zCXiQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFH1g-00000001g1c-19xi;
	Thu, 06 Jun 2024 17:35:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BBAD930047C; Thu,  6 Jun 2024 19:35:44 +0200 (CEST)
Date: Thu, 6 Jun 2024 19:35:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] rust: add tracepoint support
Message-ID: <20240606173544.GI8774@noisy.programming.kicks-ass.net>
References: <20240606-tracepoint-v1-0-6551627bf51b@google.com>
 <20240606-tracepoint-v1-3-6551627bf51b@google.com>
 <389a8c55-a169-47ef-99c0-48f58003b40c@efficios.com>
 <ZmHacqvRwBj7OvWm@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmHacqvRwBj7OvWm@boqun-archlinux>

On Thu, Jun 06, 2024 at 08:49:06AM -0700, Boqun Feng wrote:

> Long-term plan is to 1) compile the C helpers in some IR and 2) inline
> the helpers with Rust in IR-level, as what Gary has:
> 
> 	https://lore.kernel.org/rust-for-linux/20240529202817.3641974-1-gary@garyguo.net/

Urgh, that still needs us to maintain that silly list of helpers :-/

Can't we pretty please have clang parse the actual header files into IR
and munge that into rust? So that we don't get to manually duplicate
everything+dog.
