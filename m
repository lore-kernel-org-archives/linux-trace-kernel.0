Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5A513B5B0;
	Thu, 23 May 2024 12:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716468539; cv=none; b=aMCL7lLMccKSneskja0/KbFebVobYxFtsweDhJCbNHH/rOJ0+K5atREbQ3oPZhdqv3mqGIcRMUmuGl+4W5iTUK5kEv/1mM+GeK7867HOanmmr6umrpXudfR77bqTzLJ5XqHtjLCU3BtRfgcq7s7e443RDkCjDoFtiqBuhGW3Ofg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716468539; c=relaxed/simple;
	bh=0LnqLKPO3oHw4EJVIibzy2VTLh33HjinRBhfOHkwyqo=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=orBmyz+xwM2SwqK00qtIhowRSE3jy+Qc0kKZDs84nu3aUu+DELh/6sVijGQS5y/4ywjNBYxPzdDAtyL3ym4WVo/ubWulRmfyhIaI74wEwnNl8nrOMlFOsDykdzQzYDCcSqbOC1GM9fT0AabZMPxNTvIvJlps2Y5unf/sad1U7UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmIwD+NW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmIwD+NW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B52C2BD10;
	Thu, 23 May 2024 12:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716468539;
	bh=0LnqLKPO3oHw4EJVIibzy2VTLh33HjinRBhfOHkwyqo=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=gmIwD+NWWG8uf8vz7oJxu92yCfnO5F7AHKAYts7hJ3i7MjyDadHiy9lzsJ6u8U4mI
	 oYCcZSPKX1+Mx6oRo3u1ATvbTWd2gsQZxBuu1wYMeVa1//6i3BYkZJvjVAv8COnPfc
	 UgGMD/d2ScHrcYNYsj02hBwhLrTrXjvfp1y+aI3yAhbktDkDf4MMCEdU1pnGsJ3pNL
	 6ODypG/qGkAdFHLyFRh826sp0Jy7qvGN+SoZNPcwGOYZw8I6JwcpVxJ/b2J/aaE4JC
	 fEM/kpy8wItlOJWXQBUzcGyLb2xGZQcm3X6KlLvkvun89tmccNqmesex35PqRqk6ET
	 Y9yV1AO9U188Q==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>, Andrea Parri
 <parri.andrea@gmail.com>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, Conor Dooley
 <conor.dooley@microchip.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Fix early ftrace nop patching
In-Reply-To: <20240523115134.70380-1-alexghiti@rivosinc.com>
References: <20240523115134.70380-1-alexghiti@rivosinc.com>
Date: Thu, 23 May 2024 14:48:55 +0200
Message-ID: <87y1803d8o.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexandre Ghiti <alexghiti@rivosinc.com> writes:

> Commit c97bf629963e ("riscv: Fix text patching when IPI are used")
> converted ftrace_make_nop() to use patch_insn_write() which does not
> emit any icache flush relying entirely on __ftrace_modify_code() to do
> that.
>
> But we missed that ftrace_make_nop() was called very early directly when
> converting mcount calls into nops (actually on riscv it converts 2B nops
> emitted by the compiler into 4B nops).
>
> This caused crashes on multiple HW as reported by Conor and Bj=C3=B6rn si=
nce
> the booting core could have half-patched instructions in its icache
> which would trigger an illegal instruction trap: fix this by emitting a
> local flush icache when early patching nops.
>
> Fixes: c97bf629963e ("riscv: Fix text patching when IPI are used")
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Nice!

I've manged to reproduce the crash on the VisionFive2 board (however
only triggered when CONFIG_RELOCATABLE=3Dy), and can verify that this fix
solves the issue.

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

