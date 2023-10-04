Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99972525E
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Oct 2023 05:55:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F41C433C7;
	Wed,  4 Oct 2023 05:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696398953;
	bh=ssPARn68NgZDptbx2mvFf6HZm3RGCbrKiLLObwEzL6k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=cfb7ppcDmUlLaFFSKE4IQKv/be6tMpKFfECXmye5RC4kDTwlvkn4oIqiX6iAVNIxn
	 yEfyicZRlqC3jadXNqUBaTa4HiaqekF2w/VI6dWbCCmaB3/Z/ymmAY7PwDb+8FGr3P
	 V0xNYXYja95n/PyMqGZrkwiGJ0EJ1aGes4ewYNYR3SESSpnsPmR74609h2uwIwYq6h
	 9GmlBsUOtLVAwVGBnGMskAvIUuPw1ixj6mDkFmHDlpfcarITey7MZXJale6rKGYvjt
	 EZs8Uz2gjGlI+UjcK1Pz4Z9o7xTzSSG7EyAHnKwk1Z0USVLpmQGDwLTbDyvqzSoN+C
	 3NVQ1KnszEb+w==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Sami Tolvanen <samitolvanen@google.com>, Kees Cook
 <keescook@chromium.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH -fixes] riscv: Fix ftrace syscall handling which are now
 prefixed with __riscv_
In-Reply-To: <20231003182407.32198-1-alexghiti@rivosinc.com>
References: <20231003182407.32198-1-alexghiti@rivosinc.com>
Date: Wed, 04 Oct 2023 07:55:50 +0200
Message-ID: <87r0mb3p95.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexandre Ghiti <alexghiti@rivosinc.com> writes:

> ftrace creates entries for each syscall in the tracefs but has failed
> since commit 08d0ce30e0e4 ("riscv: Implement syscall wrappers") which
> prefixes all riscv syscalls with __riscv_.
>
> So fix this by implementing arch_syscall_match_sym_name() which allows us
> to ignore this prefix.
>
> And also ignore compat syscalls like x86/arm64 by implementing
> arch_trace_is_compat_syscall().
>
> Fixes: 08d0ce30e0e4 ("riscv: Implement syscall wrappers")
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

This fix does the BPF test suite happier!

Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
