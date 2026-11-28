Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795853045;
	b=UdU2qB+zovYYMPqT2ty82hOeYE40wW5t27q73/bbP5A2p++fUAfGESpGXGuhgMsqe5OT
	 0BeloT0EAeKmqEcVGO64gOXCCcqqobag+Avpfx34F9nSyO8glSWcvX1W3+ya4fif7SGcC
	 M347Dsy7lN4qIdjwNlw67cJ2lgS3rae8FdilsBfym2pcpgQtAWr1F/rycP/7Fh3/AuVGl
	 WxlpGrmTmbMKvPVUzOC+q/TjTN+RB4ODj/F0Ugkj05O3PB7kz3Hk8se/tch/1dG9TSAW+
	 hl5COry+l/6tnpNnfr8ui7376hSvuwEX0OriNjCrHzPUEXYOiDPY/x9Zm1XtPVcH1xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795853045;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ln9OYJXGaH2pYepM+2l2e7RDytV9KomXjhzq9mUaLF0=;
	b=uTEIFC/GgikrVU9G78uGDuo3PijSdKbS3/rOG9KucV5WpqN6mPfS7rjtuf5wLbp7EJSm
	 I+kvLgoYEpw3KDEkfIzco/E3joyZRyqRDBEgMhP9eP1DM3sPjU1sdNmbea9wXeBf5ZEqN
	 UKeQxAqD5DXqOkMaOI9XZd1bB4YyH0dAGE9sEnd4TyfIFeCh58Q1LlHYdwYUKX7EL6Acb
	 W2MXmXAgGMs7GBwCDGH36afcnkTI2pJd/dNX6U0Yx3lSe6dWDfvQ3aV4FKQ723Ugo2o0E
	 BQg8aW+Xrkgi63ubbrddH+N5ApqaifMR1FFyGd0CoCkt+sVVtn6JB2HMBtsDDu6G6hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eC1ubHRY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DA1606A31C;
	Sat, 28 Nov 2026 08:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eC1ubHRY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A86AB1F00897;
	Sat, 28 Nov 2026 08:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795853045;
	bh=ln9OYJXGaH2pYepM+2l2e7RDytV9KomXjhzq9mUaLF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eC1ubHRYpGTbwjEEoOoHnXIZzZTxDpAnMlRx9TUtMGFz1/XpNPxxBQ3MeqB3fgGwy
	 ypSU4wHW0kItZeZCx2D7VWmQ6KZRqNTvs7XoNqKCV2PJJw4v6HOL4FiWQ+nlaAkREs
	 6R+a6PpgXYXGY7/fAl04j0bHx9BxtNHgKG7Aw9b/0kapwFqWF55jObAokJ1xlku0EH
	 mLx8Jxb/nh6R3gXUfxkBJOrhSNEBPekbya4Rw1NarMeaPKdwtd4h1fukZKypznf1ud
	 U6eIhyu20ovxdMiGRlSRGJhStQdy9YRsFLJVwc+gJRcRGUaJGVNt85tY+CBNYrINqB
	 8qyRXxYljtDNQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3] riscv: kprobes: free insn slot in arch_remove_kprobe() to avoid memory leak
Date: Sat, 28 Nov 2026 17:04:01 +0900
Message-ID: <undine-1795853041979314460-9f1047ec8f874a5d@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261120070849.1239-1-yuanxiaofeng@eswincomputing.com>
References: <20261120070849.1239-1-yuanxiaofeng@eswincomputing.com>
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

Hi RISC-V maintainers,

Can you pick this fix?

Thank you,

On Fri, 20 Nov 2026 15:08:49 +0800, Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com> wrote:
> When a kprobe is removed, arch_remove_kprobe() does not free the
> instruction slot allocated by arch_prepare_kprobe(). This causes
> a memory leak every time a kprobe is unregistered.
>
> Other architectures such as arm64, x86, and powerpc all free the
> slot in their arch_remove_kprobe() implementations. Add the
> missing free_insn_slot() call for RISC-V.
>
> Registered and unregistered a kprobe on kernel_clone in a loop
> inside a QEMU (RISC-V virt) guest: before the fix the number of
> kprobe_insn_page entries in /proc/kallsyms grew by one every 512
> iterations (each insn-slot page holds 512 eight-byte slots), and
> after the fix it stays at 1.
>
> Fixes: c22b0bcb1dd0 ("riscv: Add kprobes supported")
> Cc: stable@vger.kernel.org
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com>
> ---
> Changes in v3:
>  - Add Fixes tag and Cc stable (Masami Hiramatsu).
>  - Add Reviewed-by from Masami Hiramatsu. No code change.
>
>  arch/riscv/kernel/probes/kprobes.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
> index 9e2afabf9..a76eab297 100644
> --- a/arch/riscv/kernel/probes/kprobes.c
> +++ b/arch/riscv/kernel/probes/kprobes.c
> @@ -128,6 +128,10 @@ void __kprobes arch_disarm_kprobe(struct kprobe *p)
>  
>  void __kprobes arch_remove_kprobe(struct kprobe *p)
>  {
> +	if (p->ainsn.api.insn) {
> +		free_insn_slot(p->ainsn.api.insn, 0);
> +		p->ainsn.api.insn = NULL;
> +	}
>  }
>  
>  static void __kprobes save_previous_kprobe(struct kprobe_ctlblk *kcb)
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
