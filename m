Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6119474
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3349C4AF74;
	Thu, 21 Sep 2023 10:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695293424;
	bh=yzRcHLbR5HG/J4cNCXnrVt/lngYoOjtJirNRF+1vitY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ssVvpTD2Nabr/adKevwcFm2K7fPZgBABoPce84Zyj0FQcMHdgii9A5tprQiCB4+RC
	 doQSNBxrBzeuytOICCS3G7sYH7VHvEfqTG3u0LRw2qFb8vghozBtCCDluv0XLAnNiE
	 RHtpAEUE8jKJbemL60YbLuun0y3gFnxzIZJQNCY0w+vkROHI6BhS02oOqr80ewPer/
	 PLk6jODyacBUc6WhYBCx7QZhBN8oixTNJLTz8gwUhlVkqKrKa+esgESHIS0E2mS8gb
	 lhUAWDOFHAxG7Kny4pHGlS+KU5tbwYd3xyD2pS5HIL7N5ewfagQzpHBXpvj7Tr4984
	 KPPSfujLwwJIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DFDECC43170;
	Thu, 21 Sep 2023 10:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] riscv: Only consider swbp/ss handlers for correct
 privileged mode
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <169529342391.31237.16052864619241534837.git-patchwork-notify@kernel.org>
Date: Thu, 21 Sep 2023 10:50:23 +0000
References: <20230912065619.62020-1-bjorn@kernel.org>
In-Reply-To: <20230912065619.62020-1-bjorn@kernel.org>
To: =?utf-8?b?QmrDtnJuIFTDtnBlbCA8Ympvcm5Aa2VybmVsLm9yZz4=?=@ci.codeaurora.org
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, guoren@kernel.org,
 bjorn@rivosinc.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, namcaov@gmail.com, puranjay12@gmail.com

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 12 Sep 2023 08:56:19 +0200 you wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> RISC-V software breakpoint trap handlers are used for {k,u}probes.
> 
> When trapping from kernelmode, only the kernelmode handlers should be
> considered. Vice versa, only usermode handlers for usermode
> traps. This is not the case on RISC-V, which can trigger a bug if a
> userspace process uses uprobes, and a WARN() is triggered from
> kernelmode (which is implemented via {c.,}ebreak).
> 
> [...]

Here is the summary with links:
  - [v3] riscv: Only consider swbp/ss handlers for correct privileged mode
    https://git.kernel.org/riscv/c/9f564b92cf6d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


