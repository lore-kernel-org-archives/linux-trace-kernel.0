Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EDF5592E1;
	Fri, 16 Oct 2026 17:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792170779; cv=none; b=JVmC7fsmJSnZo79IxsV+5/nxjzK5AtcKjQirdSOt/iBQU1wLlNtj0/QZ5pDFoXew1b6IQN2tQTtdV0drv0yOLHKxkPnXp8aXBrkeaYOtQ/o9wgDYYHqZIYgyU1j929xXFW/lhLpO7dQFA0tXiGpyQH8sKY+gCyRRbjU2VpqjyUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792170779; c=relaxed/simple;
	bh=F8Oet/ExqJzYYDm6WgwVPVisIxQvXYyes1MkxPu0c78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IoBl3rNw7h5b+e6Ofjh4wOxJJgfXMB0rLYVmzL1Vmv3Bv8QuuQU72gY99Or55POV7p/kiU+DOGcxEChiq5gX6XqXSFERgqpwXeOen3DJn00oAjR0H2nRyV6Re/i1HWCYb3+gKIhfd8QI8SD+t8deDSfymy2uLcjWPwSOiMSBsoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCLbnFzC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCLbnFzC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E4C21F000C4;
	Fri, 16 Oct 2026 17:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792170777;
	bh=IMgXI/TbABu7wec3URDdx6TZwqifTugN5Sc24fxsnj4=;
	h=From:To:Cc:Subject:Date;
	b=gCLbnFzC9rT8CGRZLJUhyckud2XlXNlTGCB1UDJaW/iocQ3k2Y7KaUsNJNm2jT4Un
	 znLnzM4v7u4LsV999IqKwv0UHGI/IHIlxCaH5UnhkEkl0k6ac1lct5LtW2SDBHwcHr
	 cOT6Yrvi5BQwvW8g1GkQG/MlwfoEJxWAEQDKNbZ3kLKEX5voFKSZY/sLeDPnwxv6hR
	 2WdGHtlnQhWmnZNedDcHZfiXs4vpxBCgCyWSVDUaMcs87zQXvNfJ1W8X/95q4iuk9C
	 f1xzUK3XeSJS1Gw8GeFyiRYaj5TOwEbpc/TQk+CJ+4iOJS680hHtgtWApPFjFQ3Xew
	 C5WGpS5EJyykg==
From: Miguel Ojeda <ojeda@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	llvm@lists.linux.dev,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: `likely` not applied with Clang and `CONFIG_TRACE_BRANCH_PROFILING`
Date: Fri, 16 Oct 2026 19:12:42 +0200
Message-ID: <20261016171242.125850-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Nathan, Steve, Masami, Arnd, all,

I was updating my old patch to add `likely()` and friends to the Rust
side of the kernel [1] and I noticed something odd when comparing with
the C side with Clang:

  https://godbolt.org/z/6Kendxzzd

Under `CONFIG_TRACE_BRANCH_PROFILING`, the way we use `__builtin_expect`
with a temporary variable makes Clang ignore the hint (GCC is fine).

So essentially:

    #define likely(x)   __builtin_expect(!!(x), 1)
    #define unlikely(x) __builtin_expect(!!(x), 0)

is fine for both compilers, but:

    #define __branch_check__(x, expect, is_constant) ({ \
        long ______r; \
        ...
        ______r = __builtin_expect(!!(x), expect); \
        ...
        ______r; \
    })

    #define likely(x)   (__branch_check__(x, 1, __builtin_constant_p(x)))
    #define unlikely(x) (__branch_check__(x, 0, __builtin_constant_p(x)))

is not. Now, if we do move the `__builtin_expect` outside like:

    #define __branch_check__(x, expect, is_constant) ({ \
        long ______r; \
        ...
        ______r = !!(x); \
        ...
        ______r; \
    })

    #define likely(x)   __builtin_expect(__branch_check__(x, 1, __builtin_constant_p(x)), 1)
    #define unlikely(x) __builtin_expect(__branch_check__(x, 0, __builtin_constant_p(x)), 0)

then it works with Clang again.

Asking an LLM to sample a few object files to see the effect, it does
seem like it works as expected, e.g. `kernel/signal.o` goes from 1 to
125 branches carrying weights and 39 of its 355 functions change codegen
(675 of ~3800 across the dozen objects sampled).

It doesn't mean it is better of course -- I didn't benchmark it, but it
means it is passing the information to the compiler that we expected.

Cheers,
Miguel

Link: https://lore.kernel.org/rust-for-linux/20261016162446.121509-1-ojeda@kernel.org/ [1]
