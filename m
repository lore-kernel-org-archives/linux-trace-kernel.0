Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA62253F11;
	Tue, 27 Jan 2026 08:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769502264; cv=none; b=b0vaP1WgfNPOSmhT9gbhUWprdl4tBx0qaacknAH/Oz5Jq25SIvASlpyglXh62npgdi89tZZD8CVaomcvpdEjOHimNStyfWd3zI1wbmsAbtimmcNWWBtmnsFUhSUOgvRnaeff4JXhAbutm50kGo/Lq0VjhRGCzSZ2zMBN1BNM3+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769502264; c=relaxed/simple;
	bh=mTk3WN/Uapqw5qb8nzigiW1t1qb46svUXLxTZo0A5oY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bR0k63NFY2BlLlDsdN9i25rbebwfB2GYP9OkQZY0ei8wIhpJneB0Owo16ChuZoxRRKqh+s/Ef2OsIp+96helq1gIDraDMHsmotde+vOkmIL4Bf2nce9wI2UEtjRRxk3sT/x3fCA3svsrn4q6UFS+N1qfiV1Yx858rA3f1uuNwF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pRE033Xv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pRE033Xv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ed+EVF/abhGcOZrlOIpqvXS9Qd8z7RBWk0Fwad600F8=; b=pRE033XvWKmUmM9ww9oK3wooDk
	JT7rtAZXUFkQpf4Kcj5qwy7T5KusZYDS3mRVDM5O7ncfVC47xnse6AYt8Jvkm35ZmYf1LdUZWPzpq
	q60t3IlxzX+BjF3Ttmfkv3yqMLT3Yh3emyafy9Bt7AOGNbcwWSMHPEXs5TxCPwgej5pprkzGHUtXt
	Zke/P04qOlfjkYrbwyQYTs1LA31hHwbxnfHgAzsMdW/7oov8HTY8wHOy8QPcA6gjTmNZiv0X+/F0k
	ikqufAkmTbJ7KIDfOe6LgHQqye1jIpWED8vVkCSdEYngYaBA5mRdYPKDS+nFt1/B745lgG7JDfhvO
	Ju2+QdTg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkeMq-00000007954-0Gzi;
	Tue, 27 Jan 2026 08:24:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B8589300756; Tue, 27 Jan 2026 09:24:01 +0100 (CET)
Date: Tue, 27 Jan 2026 09:24:01 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add Rust files to STATIC BRANCH/CALL and
 TRACING
Message-ID: <20260127082401.GS171111@noisy.programming.kicks-ass.net>
References: <20260107-jump-label-rust-maintainers-v1-1-702b03482f2e@google.com>
 <CANiq72nV0Z_UjdAwT=41TjjfmKnT6WL4hVNcxg_QCe7TAEYK_Q@mail.gmail.com>
 <20260112100006.7db6d31d@gandalf.local.home>
 <aWUO59edshSRit-Y@google.com>
 <20260112115408.48ed4d35@gandalf.local.home>
 <aXddnjiHCX-XS5S9@google.com>
 <20260126213748.GR171111@noisy.programming.kicks-ass.net>
 <CAH5fLggpBodWYv2EQy5sgg5eSp9=7PM9ZqXcKaTuozNKN1eGGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH5fLggpBodWYv2EQy5sgg5eSp9=7PM9ZqXcKaTuozNKN1eGGg@mail.gmail.com>

On Mon, Jan 26, 2026 at 10:58:24PM +0100, Alice Ryhl wrote:

> > > What about the STATIC BRANCH/CALL subsystem? Should I also leave you or
> > > someone else as 'M:' there? It's unclear to me who usually picks up
> > > patches for STATIC BRANCH/CALL when they are not a dependency to a patch
> > > for somewhere else.
> >
> > I think that'd be me -- I typically do the static branch/call bits.
> 
> Ah, thanks for the clarification.
> 
> Are you ok with using the approach Steven suggested for STATIC
> BRANCH/CALL subsystem too? That is, add a [RUST] entry below the
> current one, list you and me as M:, and anyone else in the main entry
> as R:, and patches land through the same tree as where they would have
> landed if they were a C patch.
> 
> I'm open to whichever setup you prefer, but I think it'd be nice to
> get these files into MAINTAINERS somewhere.

Yeah, I suppose that'll work. That [RUST] entry seems to be the
predominant style in MAINTAINERS.

My only concern is that most of the [RUST] entries don't actually
include the F entries for the !rust part, which means that if the C bits
change the Rust people aren't notified.

So I would suggest having all F duplicated from the main entry and then
add the rust files. Or, like we did with ATOMIC, just add you as M to
the main entry, along with a few rust files.

Some day I might actually learn enough to not see it as line noise :/

See 2387fb2a9b84 ("rust: sync: Add basic atomic operation mapping framework")

