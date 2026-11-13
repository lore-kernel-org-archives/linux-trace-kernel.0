Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794575730;
	b=C9kTA2ukID5eb2k/nW0lQyOFty6wTdkFVku7cd7ENFVHtQtfrql8E2MiwoKMNXAX37T3
	 rN6noR2PcTxEYBtpRXssq4s8CBhbOUNh2xXbFe7vI+d1MiA2yAbsFn3iZf+yah+n5uGkr
	 y5wmFisxb7aL/Q8CLXMcBXHTPYvf1ZsCO5hPHEKYUKC2pz394FyJupL3s9GrZrmDG0qE2
	 7nWOvjgiQAJBqfBUIrOUDsjIRHtIT5xyNuCVFXLJE5Qe6/1xyTJ69G8xJP5A7h2VXhTCB
	 xE8vr0YQo+gjlCBBKxqGSi7BMaxfhjppWT9XekLVeRE+rx6UDlOojj6ZTm+S0ahjauQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575730;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Ov3eL+Et/ov+O0Hl/xByme7JtYRj7vSS7D9mWSeeDmA=;
	b=ElMzqkRf2an+ebG8aDsZoKPdISsXuZLtliTMup6qCzgrtGa7Yv0XJuqt/9UwBiBIfG4n
	 FJCWu+Me2iss93jX97+oNzkV4+ztRc3L8HFtp9zcEzCPUrJCZEUEM4fyTNCYlvFajbGkQ
	 +hOyqCU6EU/a5xAjKqa25LvtwHhNDVZSMdGPFlpy8pVwq3is4Vj5J4EOI1U1gasnG1Fzj
	 owM7DtQE9cD8sVT+jNVaddmrxLUe8JyDk18jzcz6WXpQtuGYwcypmPvaaNh4TmDDKjqfq
	 UIMPOMHXK19zC+GL2s8eYkSkKuleUHBPyCf9foz8oUf5O1jDOR/wVNDxhBE8rEXo0MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="lz8/bc9f";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E790606A331
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 13:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lz8/bc9f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8777C1F000C6;
	Fri, 13 Nov 2026 13:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794575730;
	bh=Ov3eL+Et/ov+O0Hl/xByme7JtYRj7vSS7D9mWSeeDmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lz8/bc9fB8UTBPNuZUXdjiPagd1KVyluh9KLFbknckOiGIKVGdI1JkpLTv5Pghqld
	 9nNV85R5wnPtV/laqwum934UStlhG3Z4X9U4nv44TgUM5am7RmFEGhP+gGVYmIW2ur
	 I1B/kIE4ODoD+g9i2zM/INNbfLPDEpRQMvkrBb0lkOxNGFiQA8aKuQ+Wu7mmFAe+3/
	 T9aDKZyKjQuuOyveGPNWWKG7ReXikAw5FMuO397yjzma0S6Agl5hWTyGUpZLeJxVhR
	 zTfCmZm/Falzb42LqyZ/zID6OHtwEjD37FAQKtfcR+jPXdGEyf833b6HypvBXp8BlB
	 bBGQXlwI2sUNg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: sashiko-bot@kernel.org
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 10/13] tracing/probes: Allow symstr type for function entry arguments in return probes
Date: Fri, 13 Nov 2026 22:15:27 +0900
Message-ID: <undine-1794575727580751187-e4a7ce5a5f04f1c3@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <sashiko-outbox-212435@kernel.org>
References: <179455847934.403392.15146485751358774349.stgit@devnote2> <179455857080.403392.10171666250083335438.stgit@devnote2> <sashiko-outbox-212435@kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Fri, 13 Nov 2026 08:39:42 +0000, sashiko-bot@kernel.org <sashiko-bot@kernel.org> wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] tracing/probes: missing Fixes trailer for FETCH_OP_EDATA symstr
>   fix

Note that this is not a fix, but extending ability.
Let me pick this to probes/core (and then for-next)

Thank you,

> --
> 
> commit 48b9066b7edfcc25acab7912c4c55cf34cf5c88d
> Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> > tracing/probes: Allow symstr type for function entry arguments in return probes
> >
> > Function entry arguments accessed in return probes ($argN or BTF entry
> > arguments) are fetched from the entry data buffer via FETCH_OP_EDATA,
> > which was omitted from the allowed operations for the "symstr" type and
> > rejected with BAD_SYMSTRING.
> >
> > Allow FETCH_OP_EDATA to be formatted as "symstr".
> >
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> [Severity: Low]
> FETCH_OP_EDATA was introduced after the symstr type check in
> finalize_fetch_insn() already existed.  Should this include:
> 
>   Fixes: 25f00e40ce79 ("tracing/probes: Support $argN in return probe (kprobe and fprobe)")
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/179455847934.403392.15146485751358774349.stgit@devnote2?part=10
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
