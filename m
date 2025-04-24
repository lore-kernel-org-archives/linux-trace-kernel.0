Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C99F1DFD96;
	Thu, 24 Apr 2025 20:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745526710; cv=none; b=mVpQsqf8zLPZxEf4sx9lJ88pU64QWOgJfLC7ZW06aeihN4ryAU0p4D7+zHGh17uJxDlXdBWGEpgN+44CVGsuZRMAQfvJzK+kB291bW5VzI7btqVavQiFT6mfM4DnUNUd8pIY565k6JyoOeYkJLGLBg8PvgG4Puf81+A/V+xwdyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745526710; c=relaxed/simple;
	bh=GXdHlncMv9ouLPoqZADiAiq08DWlsnhc23MqsSVZFRI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Qsf6hWIZVvDimBSnRBspSc8ffv7AFAHr53wTefgNBls+/CF6mAO/vYNMenP574y4s+0waB15cwaSNR6f6+mlhgP5mkvEb/wUwmDviBtV6XRuOPDc7/rFrXJaiGZ9WA6fBv09+Rd6jeDAngdPZk+WpRlq07Qv1o9r+8WUM2wHsxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2SRC5+c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2SRC5+c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D533C4CEE3;
	Thu, 24 Apr 2025 20:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745526709;
	bh=GXdHlncMv9ouLPoqZADiAiq08DWlsnhc23MqsSVZFRI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n2SRC5+cvy7e4ZPJlFpABzK8SzX2aAEI90mF5TgRUE2Nud989eLk8M4QBgjq8IsXQ
	 YDQYlRbr7tTmdc5GQqhfXut+EYlLUkOGlQTvJLN/sgKSeQe8cuMMVh1CNHI/jpc47S
	 mTscIsPNF+4s85AqSm3nIVmV7qkSlDkVweINy1bqUsffH6FxxVHJ75EnBSD5UtNyaw
	 geFWrH9tQRLf/LAoKr4m7c80dEaeUTC0R9x1143ofRgl4lcW/T4ruFvgmn8luJ/5VJ
	 Y8NEI96BLd8vFPOCrQs5I3TpoQcxT6DKNsjJn7mgLfWlvJM7m4fdXwIASBzLRMKKJ7
	 1C3ZE2HcfGNpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E40380CFD9;
	Thu, 24 Apr 2025 20:32:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH fixes v2 1/2] riscv: Replace function-like macro by static
 inline function
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <174552674825.3483225.10896050334929236993.git-patchwork-notify@kernel.org>
Date: Thu, 24 Apr 2025 20:32:28 +0000
References: <20250419111402.1660267-1-bjorn@kernel.org>
In-Reply-To: <20250419111402.1660267-1-bjorn@kernel.org>
To: =?utf-8?b?QmrDtnJuIFTDtnBlbCA8Ympvcm5Aa2VybmVsLm9yZz4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, alex@ghiti.fr, guoren@kernel.org,
 samuel.holland@sifive.com, bjorn@rivosinc.com, mhiramat@kernel.org,
 oleg@redhat.com, peterz@infradead.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Sat, 19 Apr 2025 13:13:59 +0200 you wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> The flush_icache_range() function is implemented as a "function-like
> macro with unused parameters", which can result in "unused variables"
> warnings.
> 
> Replace the macro with a static inline function, as advised by
> Documentation/process/coding-style.rst.
> 
> [...]

Here is the summary with links:
  - [fixes,v2,1/2] riscv: Replace function-like macro by static inline function
    https://git.kernel.org/riscv/c/121f34341d39
  - [fixes,v2,2/2] riscv: uprobes: Add missing fence.i after building the XOL buffer
    https://git.kernel.org/riscv/c/7d1d19a11cfb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


