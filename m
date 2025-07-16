Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE311531E8;
	Wed, 16 Jul 2025 19:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752695988; cv=none; b=JpeOt8de9mVR7mS67HW2Atc8qrhcISEp36uDllA46diEm0L1OeZtp9R7uA4K4+UaoS//e4w2dhMm4UOnEulwxhyJfxDRT6IuawtZZN/VmwV1PlTjRBUr/53zwp7bLVqkLia88nhrG1HsIcnA92vn8oabOTlyw7bZHyGkmR58ztA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752695988; c=relaxed/simple;
	bh=Qon3/JcrgcY707eTNDRNZp6SK/UyyLEnsHTNMdoXAgo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dfiJ8nhjx/DE9IKRuT7xBFYRqFl2i7IOQQ8Jt0skjZcOEfjYnZzhLO/WNekv17KJvSQ5nLb6s0nadAO8ucEaa3AQXRS+yTK/S+ltm+nT1Nvll5hgYlwGUF1cuuXgT7lN8LeU90yiW/UB0NuhBgOM0Br6FazYWL4e5nHeb9kSMr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TaTedlCN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TaTedlCN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA57BC4CEE7;
	Wed, 16 Jul 2025 19:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752695987;
	bh=Qon3/JcrgcY707eTNDRNZp6SK/UyyLEnsHTNMdoXAgo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TaTedlCNJd5gRZa4PoSkQqTIF/m80DrjDrbhcFv2BA1Wj4inrgv+nb0EWEIEwyZwx
	 ljnJFFWGQ2M8zCHsYhvPwE/9DXi3sIvqdyi28YPnKWBHFr319FRqYHd4ChKQ7LwQOP
	 RJdVbUnvIZ6Trl6XvGpi4JvZZN4j0Beu/AVyPzJw+mvPgH2ZY7LsAtuHB4puRKMA25
	 CYxVcpw1HOQvuFQW4dSC7MsY/Hsm08gcHJ3syrjT2cQ5cYOStbEoYHhxxia7dhjtCv
	 4nK+ev/BIP7ql2+PIoSLTKD+PgfEs/qOJA2+GeW3AmNBes3nrsMUOkDyQs+7MqLcV2
	 sxd+ATEH/BRBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4BFAA383BA3A;
	Wed, 16 Jul 2025 20:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] riscv: ftrace: Properly acquire text_mutex to fix a
 race condition
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175269600801.1308944.13355512366921305547.git-patchwork-notify@kernel.org>
Date: Wed, 16 Jul 2025 20:00:08 +0000
References: <20250711-alex-fixes-v2-1-d85a5438da6c@rivosinc.com>
In-Reply-To: <20250711-alex-fixes-v2-1-d85a5438da6c@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, rostedt@goodmis.org, mhiramat@kernel.org,
 mark.rutland@arm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, rabenda.cn@gmail.com,
 wangruikang@iscas.ac.cn, ziyao@disroot.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@dabbelt.com>:

On Fri, 11 Jul 2025 07:38:38 +0000 you wrote:
> As reported by lockdep, some patching was done without acquiring
> text_mutex, so there could be a race when mapping the page to patch
> since we use the same fixmap entry.
> 
> Reported-by: Han Gao <rabenda.cn@gmail.com>
> Reported-by: Vivian Wang <wangruikang@iscas.ac.cn>
> Reported-by: Yao Zi <ziyao@disroot.org>
> Closes: https://lore.kernel.org/linux-riscv/aGODMpq7TGINddzM@pie.lan/
> Tested-by: Yao Zi <ziyao@disroot.org>
> Tested-by: Han Gao <rabenda.cn@gmail.com>
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> 
> [...]

Here is the summary with links:
  - [v2] riscv: ftrace: Properly acquire text_mutex to fix a race condition
    https://git.kernel.org/riscv/c/e3f16d63d54e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


