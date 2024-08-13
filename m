Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F06918A6C0;
	Tue, 13 Aug 2024 11:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723547377; cv=none; b=CWTUg7W+/yvwY3oydgdLM/7uZZgbCakcWNXISGl90aNiPu2BeWikz6RWlZ9ESf1a0XuiV8RbHBLmlOfARoPsi6z5sWA6yjn14LjYByijIohbUUWZLTFsAQETafddvZfIu63injp9ZI7TIv25phVokNHcJ7cjF9hp0UQwt2t4Fwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723547377; c=relaxed/simple;
	bh=zkJLZ7VjTb7wgnBp77VJwEmObtRXOZseCR4dITrA6V8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HzznNql5XmS+rZF7dk43seoUWdAnLUelLfHKG3cSwfruSgbCK3T1kmaMsvpavdIuGOX8sDnWaGBn4WjLgerMi2qRZ/4ZI8JLhf2SjyA1IqYFXxyGmV/YwFgxQuTxogZf5nCYwe5mconOAix48TTszPc8uGw1BV6WJNR1mL0NyTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/mcHPF+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/mcHPF+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D44C4AF0B;
	Tue, 13 Aug 2024 11:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723547376;
	bh=zkJLZ7VjTb7wgnBp77VJwEmObtRXOZseCR4dITrA6V8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=f/mcHPF+5RYZiEZd9vNqQsJn+Xtz5yWPP7xHyAnJ1Dp4vYPJSUZ4kbLJLH5ZS/FZx
	 27tzilxo/Ue5lnIOjr/Kdo2sPTelDpv55EaYonQZlAhDRr3kEyB1x3Y7fmLXIirTr5
	 sD4sYucSq7NQjDvezvUpG/qLz9FkeKig1ZgUb8EdZ1/Z6oPlSaqM8s7mtek9GmemBz
	 hUQrLX+AeCm0OFr1L3wHzfw/gBzR/wXEcw7vD8UapEog3SeWGKgwNlQbOMb2JqV0gy
	 Yy/jKU9vesvsi1NvFQ7vf3JDXfMaHz5lh49jBzm8qsfRv2634mVuoL/lHskb3gLJIF
	 pKzLERsOB1uMw==
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
Subject: Re: [PATCH v2 1/6] riscv: ftrace: support fastcc in Clang for
 WITH_ARGS
In-Reply-To: <20240628-dev-andyc-dyn-ftrace-v4-v2-1-1e5f4cb1f049@sifive.com>
References: <20240628-dev-andyc-dyn-ftrace-v4-v2-0-1e5f4cb1f049@sifive.com>
 <20240628-dev-andyc-dyn-ftrace-v4-v2-1-1e5f4cb1f049@sifive.com>
Date: Tue, 13 Aug 2024 13:09:33 +0200
Message-ID: <877cckadci.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andy Chiu <andy.chiu@sifive.com> writes:

> Some caller-saved registers which are not defined as function arguments
> in the ABI can still be passed as arguments when the kernel is compiled
> with Clang. As a result, we must save and restore those registers to
> prevent ftrace from clobbering them.
>
> - [1]: https://reviews.llvm.org/D68559
>
> Reported-by: Evgenii Shatokhin <e.shatokhin@yadro.com>
> Closes: https://lore.kernel.org/linux-riscv/7e7c7914-445d-426d-89a0-59a91=
99c45b1@yadro.com/
> Acked-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Andy Chiu <andy.chiu@sifive.com>

Shouldn't this be a separate fix? Still reading the details, but it
smells like something what should be disabled when building w/ LLVM, no?


Bj=C3=B6rn
