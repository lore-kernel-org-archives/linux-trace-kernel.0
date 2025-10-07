Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFAE8248B;
	Tue,  7 Oct 2025 00:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759797315; cv=none; b=ERV0v7rxUCvrj491fc93D62uHXrJp7sRLtIS1XK5acLs93sb4p9kIph5rPc4ifFhVM4n+jE6DDACqyWdx3TZpEd8ZBiOZwWtkEYSS68zYK1QC5SG6byzeA7ZTaOdjIDUd9/oiiR6colFBVfTGgyfUw+5wO4zCqiqqgbMGmpUxXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759797315; c=relaxed/simple;
	bh=vPBLz9y0U9NU1R72nibPOqgifDbjxcRAI1SAVUvvp0k=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tiGAO8haxIhvFEvyHDi2v1pGF5oros7b3SOzM28+WNBIDeCuK5WP+2COF2gY/zlMOGWlu8YJTWGC9Qkahm3K5TqRRxP0UhSkJEC4ukGZXzgulIdkkgIbTZUDLjcUq9TnfIodb3xPaX8QqzcHGPszwy/v7mO9VsYoIanjWjE0qwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qt3Ltmmp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qt3Ltmmp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B26C4CEF5;
	Tue,  7 Oct 2025 00:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759797315;
	bh=vPBLz9y0U9NU1R72nibPOqgifDbjxcRAI1SAVUvvp0k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qt3Ltmmp02snbA8gVYBJuXPbQK6xPTQRPmnpoYNqSfRDF5kPs91S1GACuAV0Ld5Cx
	 vX0oPh/Vkoa7+B+r75E9FwLOyX9N6ZZdyuD8zbRnOUNsyhLBPhIB+ETd2h6etRwJl+
	 uGsm1aNJNFRL4rmSOq+GtF+CFQIUU3/zbhssf5R3Bu7cU8n3sRzwov3OXKblhza7c9
	 yvtMHWCU7n+1P/MhmHzutf5BLGZbQ4fGdXCRA5Y59J5eJf9ovqohEskadTgxzMWufH
	 rMoGD9G7qeHIv/3lpoRA5cOFNOJY4O6KJ/5y5zn0f5clfOf64s05H7DomgyL9svGSW
	 sO9MKEnGt4YHA==
Date: Tue, 7 Oct 2025 09:35:10 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mark Brown <broonie@kernel.org>,
 Menglong Dong <menglong8.dong@gmail.com>, Thorsten Blum
 <thorsten.blum@linux.dev>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: wprobe: Fix to use IS_ERR_PCPU() for per-cpu
 pointer
Message-Id: <20251007093510.bbc8b59c21195973e740ea7a@kernel.org>
In-Reply-To: <CAHk-=whv_JYJCh48wj7vOZmAB2aLdeCXQQHeKqZKuS1+Dunbhg@mail.gmail.com>
References: <175974403177.1372080.12078001360837326466.stgit@devnote2>
	<CAHk-=whv_JYJCh48wj7vOZmAB2aLdeCXQQHeKqZKuS1+Dunbhg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 Oct 2025 11:06:31 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, 6 Oct 2025 at 02:47, Masami Hiramatsu (Google)
> <mhiramat@kernel.org> wrote:
> >
> >         tw->bp_event = register_wide_hw_breakpoint(&attr, wprobe_perf_handler, tw);
> > -       if (IS_ERR((void * __force)tw->bp_event)) {
> > +       if (IS_ERR_PCPU((void * __force)tw->bp_event)) {
> >                 int ret = PTR_ERR((void * __force)tw->bp_event);
> 
> No, this is still entirely wrong.
> 
> That casts are *WRONG*. They should not exist. And they will cause
> compiler errors, because you are casting fundamentally different
> pointer types.

Ah, got it!

> 
> They don't just point to different types, they aren't even in the same
> address space!
> 
> Stop adding random casts. They are a sign of type errors, and as long
> as they are there, the code is buggy.

OK.

> 
> And no, it's not just that IS_ERR() that was wrong. That PTR_ERR()
> won't work on a percpu pointer either.
> 
> No more of this randomness, please.

OK, let me fix that.

Thank you!


> 
>                Linus


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
