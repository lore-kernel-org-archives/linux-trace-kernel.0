Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7F061FF4;
	Thu,  6 Jun 2024 19:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717702206; cv=none; b=BBnkgzwuFzUlPwISyRJrqHztK93D06sLvVmNJOBylNcCjjiQhNtbfEtlph2Ed8IwQZqLcR6SP/cRs/Fv0wxSFYrlvVB0BPAA2My56FxOUsFj+ZEw0VFA4dBXk6zvraaoFVI75NN7nQNLk37uSNchgU+lLlrGQEEvDeQK2dTjl+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717702206; c=relaxed/simple;
	bh=wy1/27O4ST7Jy9JP64TpBdbyH6AK9ftFJSVxc2OSFec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=so+DLevSqtkDNykD5kdHrmhTAa7KsEp77TtJHNp4hfogFFWXcIU8HKRpEfHXDsU4Mk4D63fwuNT3lDw4D/ZUOjrXe6sF7hzlwZuAjIFMY1kKvq5pMbXsS9tYRFN2cwbNTpGm8RZS+qS2ItYgzTqOsJ9bz5Kw5zcNIOWcUOsRBHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TLvnw+LZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TLvnw+LZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qA4o5RhLhxxQQJ4V/KaMjw8f4e84B0lZhKxN3jROpVo=; b=TLvnw+LZ/wnjwjqGrMD54EPGyO
	rgreJpieJ2i9XPHAxvnGKfIFioZJaBmMsgu2sIWt+gIcxYNrIveD2M/w+WaoSfL7ENWKtetioczN2
	+LKxTvWHnsLHFGYJwblc7gG5KAlkNMO6EiO5rG9uAgh8xW6AAh0ToSFOaEwY4nl4jY2QzEebSu2dk
	ZozKxf5huJ22QzBCQ0Gm8SlPywrSABPalEQJVF9HLFecs8hKlcna5AkSfp0tSDHxdmQeUdSlu9gRq
	r+ob5Ofa2vq30q5z00FVbZKtkT6T7vK8wvyRHagYOFFHHnfINEnW5JJRyDDdcO7MjRFnwGO92iZlB
	FB35iSmA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFIo5-00000004ApV-28S9;
	Thu, 06 Jun 2024 19:29:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5BEAA30047C; Thu,  6 Jun 2024 21:29:51 +0200 (CEST)
Date: Thu, 6 Jun 2024 21:29:51 +0200
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
Message-ID: <20240606192951.GJ8774@noisy.programming.kicks-ass.net>
References: <20240606-tracepoint-v1-0-6551627bf51b@google.com>
 <20240606-tracepoint-v1-3-6551627bf51b@google.com>
 <389a8c55-a169-47ef-99c0-48f58003b40c@efficios.com>
 <ZmHacqvRwBj7OvWm@boqun-archlinux>
 <20240606173544.GI8774@noisy.programming.kicks-ass.net>
 <ZmIHVIqEukWWRMgd@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmIHVIqEukWWRMgd@boqun-archlinux>

On Thu, Jun 06, 2024 at 12:00:36PM -0700, Boqun Feng wrote:
> On Thu, Jun 06, 2024 at 07:35:44PM +0200, Peter Zijlstra wrote:
> > On Thu, Jun 06, 2024 at 08:49:06AM -0700, Boqun Feng wrote:
> > 
> > > Long-term plan is to 1) compile the C helpers in some IR and 2) inline
> > > the helpers with Rust in IR-level, as what Gary has:
> > > 
> > > 	https://lore.kernel.org/rust-for-linux/20240529202817.3641974-1-gary@garyguo.net/
> > 
> > Urgh, that still needs us to maintain that silly list of helpers :-/
> > 
> 
> But it's an improvement from the current stage, right? ;-)

Somewhat, but only marginal.

> > Can't we pretty please have clang parse the actual header files into IR
> > and munge that into rust? So that we don't get to manually duplicate
> > everything+dog.
> 
> That won't always work, because some of our kernel APIs are defined as
> macros, and I don't think it's a trivial job to generate a macro
> definition to a function definition so that it can be translated to
> something in IR. We will have to do the macro -> function mapping
> ourselves somewhere, if we want to inline the API across languages.

We can try and see how far we can get with moving a bunch of stuff into
inlines. There's quite a bit of simple CPP that could be inlines or
const objects I suppose.

Things like the tracepoints are of course glorious CPP abuse and are
never going to work.

But perhaps you can have an explicit 'eval-CPP on this here' construct
or whatnot. If I squit I see this paste! thingy (WTF's up with that !
operator?) to munge function names in the static_call thing. So
something like apply CPP from over there on this here can also be done
:-)
