Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294D214D283;
	Wed, 22 May 2024 23:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716421908; cv=none; b=kBX7x633QyWe5WKJlfQVNy/Sb2Mn0TikYd6+3jF1uyjMvg8cn30Ldr3Q+gLsINCfAyXbligt1kknMHIO/ctte8OUBqtA7JfCHgzk7CDgnwg7LP6d6ttU1XmnmLjb6dVuh4IIeNb4eg6t0lbTllZOfaQQnPqkYBT3FVytLUY8vLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716421908; c=relaxed/simple;
	bh=crYCel4T6v30YoWlgBUMmOcR90sSWioAG7Sjj6wBSyA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CyIkU1b1K4sKRHclUcd3SyPfbJTjJljfh1S6BYwSC+owq4aWz3K0y5ZD/IS18CffDKV+26ENEZckbK5cd5ZTZSiWGHUL6W8kqX7XSnZx1LpMZDJU9vJiM+Vg0fq5CssniMkSKQ8VO4jtt85Iw22qzkgGH1jTEasC5uqE+biRHPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rY+EvH/v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rY+EvH/v"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 036FEC4AF13;
	Wed, 22 May 2024 23:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716421908;
	bh=crYCel4T6v30YoWlgBUMmOcR90sSWioAG7Sjj6wBSyA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rY+EvH/vLojwdYlLZD3p+/oCLF1WAVA778rZPE9k37JyisSH/9qkiM3+mBvJBiPwY
	 yeWsAwUqfvBosNWRaQL0fZDd721/pw8N5NuC1Y4eq7Vl2/ZqMWRFOAoz2KCdJnK1LN
	 JHLJQf5tfxcR7UGHA8mR7G1ccY5mSPhF9TXjdMesCgQIYoi22+X6yld9BiMSYIXmaA
	 eu9c1ws2tbV5Yxwkr0gSqPtHk5aIgIQqviqV/Dq7iV0LsAVNs864QUlxoY8HkRLG74
	 8J6WcVcjKPvVY3R7SflQmkQ6j4n3i5e1UHGDOn3hOnhqHhm9p0dcLLZxtuPI0KW7eH
	 8rHeHRnzS9wvQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EA49FC43618;
	Wed, 22 May 2024 23:51:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ftrace: riscv: move from REGS to ARGS
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171642190795.9409.3531878731027938184.git-patchwork-notify@kernel.org>
Date: Wed, 22 May 2024 23:51:47 +0000
References: <20240405142453.4187-1-puranjay@kernel.org>
In-Reply-To: <20240405142453.4187-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: linux-riscv@lists.infradead.org, alexghiti@rivosinc.com,
 andy.chiu@sifive.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, rostedt@goodmis.org, mhiramat@kernel.org,
 mark.rutland@arm.com, samitolvanen@google.com, guoren@kernel.org,
 leyfoon.tan@starfivetech.com, debug@rivosinc.com,
 jeeheng.sia@starfivetech.com, suagrfillet@gmail.com, bjorn@rivosinc.com,
 cleger@rivosinc.com, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, puranjay12@gmail.com

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Fri,  5 Apr 2024 14:24:53 +0000 you wrote:
> This commit replaces riscv's support for FTRACE_WITH_REGS with support
> for FTRACE_WITH_ARGS. This is required for the ongoing effort to stop
> relying on stop_machine() for RISCV's implementation of ftrace.
> 
> The main relevant benefit that this change will bring for the above
> use-case is that now we don't have separate ftrace_caller and
> ftrace_regs_caller trampolines. This will allow the callsite to call
> ftrace_caller by modifying a single instruction. Now the callsite can
> do something similar to:
> 
> [...]

Here is the summary with links:
  - ftrace: riscv: move from REGS to ARGS
    https://git.kernel.org/riscv/c/aa4cc1761cca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


