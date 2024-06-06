Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DE28821;
	Thu,  6 Jun 2024 19:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717702408; cv=none; b=uKu3GpbzkSmvpEqO6Q9gDvNzHlZaow95+OVphbL/TtirOTa2U0D6hDqFUBazoKatBHVLWrPa8QTxbrr0A84/oMS70xrXJMoWGhoHqGeUcrYxKQ++sSVwm4ZLMW4c39Actp573zP9s7vWbtlipyP70rT0iG0gAvMmlCYgyrYucnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717702408; c=relaxed/simple;
	bh=Ctx/kZ0M9yiUiJM0jMFzj0gnxFswJt9u3VDPX+xIcAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZ0SU/niYooqxFvt80hloD886r2QGwRnyHJSSK/93fbfEwwEPLh0XVAUgEokaQXI4AcsBGxHVDQj/mHghYg8n44/gUSpW57vxZzpx7FT77y/r5djyNPV1YKBHqUv5/kwFpyo4ELMaNAfOpEA2wMbxbah5UQKQMFYq+pUMljl2s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MGzUYzWh; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MGzUYzWh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=JEcRCeHnL/Q8dsTYxfE+j7DlXYuQ2nwdapZBRMQRXNw=; b=MGzUYzWhPqzvDVjDHJ3F1M8xpy
	ByUX5uJmGbf2GcuVuiBr9fxO2x56c3WK/E0raKg7DkzR0O2WrgnwxbQjplFo0tsFdl0lSAm/HOwc4
	z5HvVz2zwkNqhUXWCEgi7ecLl6x0LJx0ag4sdtWKXdXM0tHEhnPvjj6yRHexu77rb/ruVeknaxO/H
	oXHQar8ok/rJumDVPOFS28uoDQWeyudR/KEFI3n3Dh3ypJAE6OwV6dxudip1xN0xifAg1XNQJE5m5
	D6KRo/EzC2C168DsLAgWpgMrqfWHaKbAr4+6eNcL6EABZymlGoMyoWK0PPR4IC7Cc06MsCf0cUXM2
	nX2vFXfQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFIrP-00000004Clw-0Jtr;
	Thu, 06 Jun 2024 19:33:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3705030047C; Thu,  6 Jun 2024 21:33:18 +0200 (CEST)
Date: Thu, 6 Jun 2024 21:33:18 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Steven Rostedt <rostedt@goodmis.org>,
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
Subject: Re: [PATCH 1/3] rust: add static_call support
Message-ID: <20240606193318.GK8774@noisy.programming.kicks-ass.net>
References: <20240606-tracepoint-v1-0-6551627bf51b@google.com>
 <20240606-tracepoint-v1-1-6551627bf51b@google.com>
 <20240606171845.GE8774@noisy.programming.kicks-ass.net>
 <CANiq72m6mc0U-Vctrnyd0WGMx9cZ04tXhJ4_tnPX2ZjX4abMsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72m6mc0U-Vctrnyd0WGMx9cZ04tXhJ4_tnPX2ZjX4abMsw@mail.gmail.com>

On Thu, Jun 06, 2024 at 09:09:00PM +0200, Miguel Ojeda wrote:
> On Thu, Jun 6, 2024 at 7:19 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > This is absolutely unreadable gibberish -- how am I supposed to keep
> > this in sync with the rest of the static_call infrastructure?
> 
> Yeah, they are macros, which look different from "normal" Rust code.

Macros like CPP ?

> Is there something we could do to help here? I think Alice and others
> would be happy to explain how it works and/or help maintain it in the
> future if you prefer.

Write a new language that looks more like C -- pretty please ? :-)

Mostly I would just really like you to just use arm/jump_label.h,
they're inline functions and should be doable with IR, no weirdo CPP
involved in this case.
