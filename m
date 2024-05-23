Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F1FA94C;
	Thu, 23 May 2024 18:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716487233; cv=none; b=A5haF7f1LBWKj6J+geHbXhRIHXlsdJclXmuIaZss9n5lOIVHxbalY6uWs8eV2U7u/88wVKHoEHvtIu1Br2NEp6q5QPP2a9vkCSvgcH2HzBdr81NDwDskXE0Y6I3jEo+PRYmgrp0GI0GsyM/TcvbepwpUEAKp/5rHyTz8kPU0fe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716487233; c=relaxed/simple;
	bh=LPuvBxy3iF5eqbTEUy7UQgJ9ro1OJVRiXbhQTYzW4BU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nLVn7ykYg2ZHYn/ADzSmOoQKadgEASnumoPthstTLQ53gcyYKuu3ZUPlGiEFM9L29hel10kiq/w7WwPcxf0XGgr4lH74pSeOs4PA6RR4feDk19D7vGGWjUfxKAZMp9uUSrDyRfpMhd0NunM/TrXVvkU3PLaluN3y/BM698XURfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWyACaHv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWyACaHv"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 375C1C3277B;
	Thu, 23 May 2024 18:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716487233;
	bh=LPuvBxy3iF5eqbTEUy7UQgJ9ro1OJVRiXbhQTYzW4BU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WWyACaHvCcfSiW7Ac4wmfxxD63inDTSeTQasgttg15eqpjaWjoMX6sBR/bwKGnUWT
	 9DbS8DwB3QAPriD2RywSRG3igxM1Mzp0ZFVmkeHC3fW2RXfY18ckiOqXod//4SHPux
	 vGR42czNI55h8SOJRlBYh8KGUIPuOdO6Abvz91OiNVh4nSCblRzHFFpVxkIHxx3rrq
	 fjbB4cwCRjPkab6E23zz0cKyYBbtS+bafbJ58ZZrvqqOjtNAQIy4K8QV48bLeBpAvx
	 ZOlicjpQ/6gklqHRbGbqaR1q0Wl7cnhOQqrMs2CFXIavIKjDcqxUa6VgXfhI+iRwrg
	 m/RUeAf0PAHvQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 16D73C43617;
	Thu, 23 May 2024 18:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: Fix early ftrace nop patching
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171648723308.17418.17188308425434687140.git-patchwork-notify@kernel.org>
Date: Thu, 23 May 2024 18:00:33 +0000
References: <20240523115134.70380-1-alexghiti@rivosinc.com>
In-Reply-To: <20240523115134.70380-1-alexghiti@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, rostedt@goodmis.org,
 mhiramat@kernel.org, mark.rutland@arm.com, parri.andrea@gmail.com,
 bjorn@rivosinc.com, conor.dooley@microchip.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 23 May 2024 13:51:34 +0200 you wrote:
> Commit c97bf629963e ("riscv: Fix text patching when IPI are used")
> converted ftrace_make_nop() to use patch_insn_write() which does not
> emit any icache flush relying entirely on __ftrace_modify_code() to do
> that.
> 
> But we missed that ftrace_make_nop() was called very early directly when
> converting mcount calls into nops (actually on riscv it converts 2B nops
> emitted by the compiler into 4B nops).
> 
> [...]

Here is the summary with links:
  - riscv: Fix early ftrace nop patching
    https://git.kernel.org/riscv/c/6ca445d8af0e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


