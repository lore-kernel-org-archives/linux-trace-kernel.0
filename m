Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF5919AD97;
	Tue, 13 Aug 2024 12:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723553977; cv=none; b=Q00B2uhoPp8wAgNKh87x18fbUPQX2EsJaRlulqBPJQtrGUIAV/BwcHaR9fEVFZiooiEVxM9nZYpUbnAqDw1JP0OqgFnJHglcxIu6vVQwvNSTvI9azoSBYbBhJSo7L9uJLysnn5CxNOg7JPpiwnbFgFug9vHLYo3mC8oxuZ+dLF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723553977; c=relaxed/simple;
	bh=FBnPKp/Sfb0dMuen8B5ZicK/kINmYY9a4pZ7ojCdmUs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j+qLBXv9qEiZqKzEco2agNNgCjWtP+t0J0nolMlMwZSJoPFAY16Qf1YwrzYMet6v6kljnCnr/HeCxNrpCRVLAPqyflWtI9JjU4Ebb7ZDKRCdDPT0MXGTKU7/VsuyVgSi5SMEGq0xp8OmWc4yLuEylt10HrhhrdjiWdDu0zPFjrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pg57j4bH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pg57j4bH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 602EFC4AF0B;
	Tue, 13 Aug 2024 12:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723553977;
	bh=FBnPKp/Sfb0dMuen8B5ZicK/kINmYY9a4pZ7ojCdmUs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=pg57j4bHDYZnvfDOpaB+yXdwGdeZYEXBLkiU5UIR3WYMyq5UsWNp8ej62eEm3RwOT
	 4fCQr96XJ20UquGkBggvppDZgNEL6lfGVLNTkFFFln/ZurL8WvJwjcyFPCXmLVyA4z
	 whibcX/j58SvV7z8mBHeEGukxGDtbVTBFqxTNxLWW4rmtTbl+g7xbut8TWpv+FW6Zn
	 3jYMKITa5TDAYYIyQDtk9pEyfDnMswDEw4GRm68j4opLh73LVVTFouuteMmnf3JPKZ
	 Nk0jX/ORLyfpq4v7npU3hd8yn7LrDI4Jvi/znzIov/upnHhmUyo/Q9wyezsO1eI7i+
	 MbB6LF+seiY0g==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Andy Chiu <andy.chiu@sifive.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alexghiti@rivosinc.com>, Zong Li
 <zong.li@sifive.com>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
 <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt
 <justinstitt@google.com>, Puranjay Mohan <puranjay@kernel.org>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 llvm@lists.linux.dev, Andy Chiu <andy.chiu@sifive.com>
Subject: Re: [PATCH v2 3/6] riscv: ftrace: prepare ftrace for atomic code
 patching
In-Reply-To: <20240628-dev-andyc-dyn-ftrace-v4-v2-3-1e5f4cb1f049@sifive.com>
References: <20240628-dev-andyc-dyn-ftrace-v4-v2-0-1e5f4cb1f049@sifive.com>
 <20240628-dev-andyc-dyn-ftrace-v4-v2-3-1e5f4cb1f049@sifive.com>
Date: Tue, 13 Aug 2024 14:59:33 +0200
Message-ID: <87wmkk8toq.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andy Chiu <andy.chiu@sifive.com> writes:

> We use an AUIPC+JALR pair to jump into a ftrace trampoline. Since
> instruction fetch can break down to 4 byte at a time, it is impossible
> to update two instructions without a race. In order to mitigate it, we
> initialize the patchable entry to AUIPC + NOP4. Then, the run-time code
> patching can change NOP4 to JALR to eable/disable ftrcae from a
                                      enable        ftrace

> function. This limits the reach of each ftrace entry to +-2KB displacing
> from ftrace_caller.
>
> Starting from the trampoline, we add a level of indirection for it to
> reach ftrace caller target. Now, it loads the target address from a
> memory location, then perform the jump. This enable the kernel to update
> the target atomically.

The +-2K limit is for direct calls, right?

...and this I would say breaks DIRECT_CALLS (which should be implemented
using call_ops later)?


Bj=C3=B6rn
