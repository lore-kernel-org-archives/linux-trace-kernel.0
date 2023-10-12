Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50AA3D96B
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Oct 2023 20:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pyRZmD9r"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2979DC433C9;
	Thu, 12 Oct 2023 20:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697143225;
	bh=Fauph9JoaEidptKpc+WMZmrBs887AnYOmzORE7FONmU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pyRZmD9ryji+iaTLJKK9DSKujCHuv7xdFnJEiv62kt1C8/qUq+96w3IzZ487U8BBU
	 vzOcEmd/wm2QYW7jRUUxjMpjeWrefBJ7JcvD2kTq3y0NZXQr6zIC9NLs5lGcOj0C/C
	 ziLlwQllZ9LiulhOPo2v/Sd6OM3AzBjqxJm1a7IEeRyD9PfHUhQAwLIae8s9WBCwu6
	 l3oyx4rNGkU14UHdP3Cgr325sFUC1s2hNiM3T2z8iHyYzm1aLq8f7CrzVCv10RKkPF
	 QVwx8ds9MtD1RAk0Vnv7voBiEAlwUAZ4p0iFXc3QvqbY1B+GtlirYbPzjZ+jXYb/TS
	 4cXSa0f34fR6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0B6E2E21EC0;
	Thu, 12 Oct 2023 20:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -fixes] riscv: Fix ftrace syscall handling which are now
 prefixed with __riscv_
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <169714322504.23371.7333099870836142544.git-patchwork-notify@kernel.org>
Date: Thu, 12 Oct 2023 20:40:25 +0000
References: <20231003182407.32198-1-alexghiti@rivosinc.com>
In-Reply-To: <20231003182407.32198-1-alexghiti@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, rostedt@goodmis.org, mhiramat@kernel.org,
 mark.rutland@arm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, samitolvanen@google.com, keescook@chromium.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue,  3 Oct 2023 20:24:07 +0200 you wrote:
> ftrace creates entries for each syscall in the tracefs but has failed
> since commit 08d0ce30e0e4 ("riscv: Implement syscall wrappers") which
> prefixes all riscv syscalls with __riscv_.
> 
> So fix this by implementing arch_syscall_match_sym_name() which allows us
> to ignore this prefix.
> 
> [...]

Here is the summary with links:
  - [-fixes] riscv: Fix ftrace syscall handling which are now prefixed with __riscv_
    https://git.kernel.org/riscv/c/a87e7d3e8832

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


