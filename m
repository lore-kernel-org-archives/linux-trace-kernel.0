Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAE160EC4;
	Tue, 13 Aug 2024 11:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723547480; cv=none; b=JFg4ITJAcre6DU5iB899JiDwySsCIipb2/Kdoi6WWfFyxKCg6M4ifnuG3bdfLryHLPye7WPRNMZmg0Y5BQAk8IcMeNSLy+xUzHRYbL4dB9sTHtNdpJn5eQLvyf0/bGSnNbx5Lg5A9hkGSNQ+VAc7c3g25Sczaw23ZMe3BlXvpCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723547480; c=relaxed/simple;
	bh=7vMHxHM8TbnXx+CW98SMeo13Ag/I/2RdZ+PSHBbBZcI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BfMD1SksDT/etx+sxGgUTeVQ0g2wgcR1PoKXNkR4LsEmCnzEBIOaJZaV/dIvuvxq6Qj6+SlNBg3U70NZ+UgwmqE8Qisw10P6hwvSZfTkp4hwrnFs483Bhxxy1B1cN68rzFchk3XUVysVZyqne0dfZ5mXMudHxVDkTgQcUbExngQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjCvZe0x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjCvZe0x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50EACC4AF0B;
	Tue, 13 Aug 2024 11:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723547479;
	bh=7vMHxHM8TbnXx+CW98SMeo13Ag/I/2RdZ+PSHBbBZcI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=OjCvZe0xH8EUIyX5H9zqZY2xV/EjiUon2wi6mGqbET0G465tITzVLs0SXkhMz+Ylh
	 hJqCx8/i9EtDCNb0GGgy+OFOsGk6W8elpacVMFYpr0Il+Emw0DDzJ8cBnA4M2I9Wxy
	 15M0FjO6wYzyGVymwnNy2PxtuvnZk5N/HCSh3Ubz6xn3pABNmdOoV61uiUU+lGqb3U
	 VU71eAge68VeHKcqu/66h50rdxu2wp/DOdKvWxpom5TM7gtavnZuZIZO6iMrr/2vij
	 JhvvFf1udeeMFBIyjj+eGyCB9ZUhUY6oYRf8EqhYwHMntAf0fa0PXbeoJv31NYVH4C
	 THdmz7rCl7yQA==
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
 llvm@lists.linux.dev, Evgenii Shatokhin <e.shatokhin@yadro.com>, Andy Chiu
 <andy.chiu@sifive.com>
Subject: Re: [PATCH v2 2/6] riscv: ftrace: align patchable functions to 4
 Byte boundary
In-Reply-To: <20240628-dev-andyc-dyn-ftrace-v4-v2-2-1e5f4cb1f049@sifive.com>
References: <20240628-dev-andyc-dyn-ftrace-v4-v2-0-1e5f4cb1f049@sifive.com>
 <20240628-dev-andyc-dyn-ftrace-v4-v2-2-1e5f4cb1f049@sifive.com>
Date: Tue, 13 Aug 2024 13:11:16 +0200
Message-ID: <8734n8ad9n.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andy Chiu <andy.chiu@sifive.com> writes:

> We are changing ftrace code patching in order to remove dependency from
> stop_machine() and enable kernel preemption. This requires us to align
> functions entry at a 4-B align address.
>
> However, -falign-functions on older versions of GCC alone was not strong
> enoungh to align all functions. In fact, cold functions are not aligned
> after turning on optimizations. We consider this is a bug in GCC and
> turn off guess-branch-probility as a workaround to align all functions.
>
> GCC bug id: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D88345
>
> The option -fmin-function-alignment is able to align all functions
> properly on newer versions of gcc. So, we add a cc-option to test if
> the toolchain supports it.
>
> Suggested-by: Evgenii Shatokhin <e.shatokhin@yadro.com>
> Signed-off-by: Andy Chiu <andy.chiu@sifive.com>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
