Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1DD1990D0;
	Thu,  6 Jun 2024 17:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717694613; cv=none; b=q5tMCMJwWh1Szx+UCv3FB9ul4FuKMvv9k4xY1d/lf2TYCTFDWwwRG2/+/pqAO8s9E4qgLuHpqT0cpMfuMTkUHc+46MirAWLXNlUxCyZfUgxeAArxUEEyn+ukbjeXFHqdPzZCK6BbSvrM3oroieZIMqmSBGajqyX1spQe+jQUMvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717694613; c=relaxed/simple;
	bh=BkVdSWcMaP4bKZNlsAFZLTjHS7oS0wOPey3hYl53ABs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEmUdb5t3kEIAHj9mcuM5tnd3NbGhNlKZHnqHlObbpoqSfdEumvc67ysYwlfrziSa89ih/IdB+3UFxA/4TWPUdqORZDYdyZEBQHT1ZprYD2+CU3BVHnLQiYJoEFIaUHOBgrg918mlYvJPiQp8YtUU5hhF6Mg+Fww0HJduKzN3UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oR5ddJOH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oR5ddJOH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BkVdSWcMaP4bKZNlsAFZLTjHS7oS0wOPey3hYl53ABs=; b=oR5ddJOHerSiDYJ+gd3K0Xg9W1
	A7Yzel/1bd6ANztTCSYuEOrAovXm6W6rgEuyFz1Dt7KgnOTGXWIIzn55zwHpWYL7Sr80vAclaZXjG
	dNKW4z04IU1ib9Au0ZpHjuXSIc/B6+zmwJn86dZrm9MH+MzvA7923gTHiFow+ZPEF+PzIL+Q1UziG
	JXrKefgZ140gJOWPKy4AF6chUEjSbhmRX9S4c3og4ZMOTUAKuhXElsxK8kXsf5Jx/Jrp7/+chHw1I
	QDbJ/D/Gu7hn+jgr93F/Xc8h7Uj/0WmeJCIcEIWKWpeuOKwpN9ZzlSXhNPCjHiDJkHR/90hFQJddD
	onp7ZQLQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFGpg-00000001fhM-1BiE;
	Thu, 06 Jun 2024 17:23:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F042C30047C; Thu,  6 Jun 2024 19:23:20 +0200 (CEST)
Date: Thu, 6 Jun 2024 19:23:20 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] rust: add static_key_false
Message-ID: <20240606172320.GF8774@noisy.programming.kicks-ass.net>
References: <20240606-tracepoint-v1-0-6551627bf51b@google.com>
 <20240606-tracepoint-v1-2-6551627bf51b@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606-tracepoint-v1-2-6551627bf51b@google.com>

On Thu, Jun 06, 2024 at 03:05:25PM +0000, Alice Ryhl wrote:
> Add just enough support for static key so that we can use it from
> tracepoints. Tracepoints rely on `static_key_false` even though it is
> deprecated, so we add the same functionality to Rust.

Urgh, more unreadable gibberish :-(

Can we please get bindgen to translate asm/jump_table.h instead of
randomly duplicating random bits.

I really think that whoever created rust was an esoteric language freak.
Hideous crap :-(.
