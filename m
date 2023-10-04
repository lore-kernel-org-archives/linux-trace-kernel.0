Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1B1539D
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Oct 2023 05:51:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC103C433C7;
	Wed,  4 Oct 2023 05:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696398671;
	bh=iCuHgBPuubAVdQm7QbXMcIphSaPSVtN9vw7j0BuXv7Y=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=IQ62F9x+o5F1qpPjc+2LK5/Fg0/iJgbyPXCKKIl99oGB6E3h+13uStR+cNVVZnfXM
	 KdEmOw2g6DSf+N+fDSoaaeneEi6YRUhXYSGrf1PwjCV6n8B7jVxSg0PxZvJioqluyH
	 BYfAxdT2czzbOymGEzK7X7GVk4MVAMaDn+fiCAGqaXRKZUsZhG4SmtKYigFperCNZk
	 oZuL6QEwFMi7MgGNAblLveIwaKbKTgV35pDd+IHV1YfGRKxywaXpA51QkYLPwe+UGm
	 femEYGr4Q/Eek+3iHho1E00g0+7E4UOEeMWbevRE6AZ6lx2tbcEeJWYTlgOvZZ/tks
	 kcJVAHD3D/Ctw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Sami Tolvanen <samitolvanen@google.com>, Kees Cook
 <keescook@chromium.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, Conor
 Dooley <conor@kernel.org>, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH -fixes] riscv: Fix ftrace syscall handling which are now
 prefixed with __riscv_
In-Reply-To: <CAHVXubgTkoWYEybsbXVbCMO4JaMAChaSq4BgqZZO9ih7OxwUyA@mail.gmail.com>
References: <20231003182407.32198-1-alexghiti@rivosinc.com>
 <CAHVXubgTkoWYEybsbXVbCMO4JaMAChaSq4BgqZZO9ih7OxwUyA@mail.gmail.com>
Date: Wed, 04 Oct 2023 07:51:08 +0200
Message-ID: <87v8bn3pgz.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexandre Ghiti <alexghiti@rivosinc.com> writes:

> @Conor Dooley This fails checkpatch but the documentation here states
> that this is how to do:
> https://elixir.bootlin.com/linux/latest/source/Documentation/trace/ftrace-design.rst#L246

FWIW, I'll relax the PW CI checkpatch test going forward. It's way too
strict...
