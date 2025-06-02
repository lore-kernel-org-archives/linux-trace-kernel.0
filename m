Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228C225487A;
	Mon,  2 Jun 2025 22:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748902331; cv=none; b=QBCLwhxeAVMzFSiFNlnIATJcGD/PnnOlW+yOxYOEYmr8VpoUN+xI5ZAf5NWhAz9fU0JzPVYylxOGNV9Rz05WxZCMgILQGOhRwjsGqaJmCNzo+ASsi1tEVGKI/5AUJ6XGDmyQdyWvVC6KOqKeyIu+AmLRbIIsAB1wjaNksFQsgrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748902331; c=relaxed/simple;
	bh=aBzjsMEEhXVIe1zVGvGDXk9sXhqzdXCVIPE36+jRrbQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TkRFXvGQAI6xqThiCNBO5CLOvX8WGhgUrurUGgaKDtZRunzlHfSoCYu5PNjJk3ZJTo8ZfK+ALAw+acqZwu51peGIMCigKKu9EvA+qDz7IlYGgRBoNblkVKPjQsBWVkZxCGZ2zU+xzKcN+CrpwOnKDC+o3pv+8PrDvLOI3UaWdH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RaIxgnmY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RaIxgnmY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 951DBC4CEEB;
	Mon,  2 Jun 2025 22:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748902330;
	bh=aBzjsMEEhXVIe1zVGvGDXk9sXhqzdXCVIPE36+jRrbQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RaIxgnmYx+7sNvyNz2IzcnpY39HOM+PAHCo0MTt+d318KLoaxtOwfO3dWMQB1SGuY
	 8txcIQm8bYZIcSSdQGkcPP9GqXMUhsCm5PpV9FTRrVhHSzvGke+qCuLTqu7dXeOovw
	 7nAlh+Iz8wjYWyq7xv2TWeWprir2BXqST761RayqIvZ0PjdI3nGyvmLN4hOSs8uFnL
	 00R1KU56O21XsYY/3fGbN4u45YZc3oeoJZ7YlT9CCF9pSIrvT2IV5YojWuzndq9B1Q
	 vEBXl9soSu5nujHVR8jb1BzIt7FrN6f7ammbVJNI11LIoC96AYl+5FLg8RV+6EfToF
	 +15LBv/4dVxwg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CA8380AAD0;
	Mon,  2 Jun 2025 22:12:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 01/12] riscv: ftrace: support fastcc in Clang for
 WITH_ARGS
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <174890236299.925497.5731685320676689356.git-patchwork-notify@kernel.org>
Date: Mon, 02 Jun 2025 22:12:42 +0000
References: <20250407180838.42877-1-andybnac@gmail.com>
In-Reply-To: <20250407180838.42877-1-andybnac@gmail.com>
To: Andy Chiu <andybnac@gmail.com>
Cc: linux-riscv@lists.infradead.org, alexghiti@rivosinc.com,
 palmer@dabbelt.com, andy.chiu@sifive.com, e.shatokhin@yadro.com,
 nathan@kernel.org, bjorn@rivosinc.com, palmer@rivosinc.com,
 puranjay@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, llvm@lists.linux.dev,
 mark.rutland@arm.com, alex@ghiti.fr, nick.desaulniers+lkml@gmail.com,
 morbo@google.com, justinstitt@google.com, puranjay12@gmail.com,
 paul.walmsley@sifive.com, greentime.hu@sifive.com, nick.hu@sifive.com,
 nylon.chen@sifive.com, eric.lin@sifive.com, vicent.chen@sifive.com,
 zong.li@sifive.com, yongxuan.wang@sifive.com, samuel.holland@sifive.com,
 olivia.chu@sifive.com, c2232430@gmail.com

Hello:

This series was applied to riscv/linux.git (for-next)
by Alexandre Ghiti <alexghiti@rivosinc.com>:

On Tue,  8 Apr 2025 02:08:25 +0800 you wrote:
> From: Andy Chiu <andy.chiu@sifive.com>
> 
> Some caller-saved registers which are not defined as function arguments
> in the ABI can still be passed as arguments when the kernel is compiled
> with Clang. As a result, we must save and restore those registers to
> prevent ftrace from clobbering them.
> 
> [...]

Here is the summary with links:
  - [v4,01/12] riscv: ftrace: support fastcc in Clang for WITH_ARGS
    https://git.kernel.org/riscv/c/7cecf4f30c33
  - [v4,02/12] riscv: ftrace factor out code defined by !WITH_ARG
    https://git.kernel.org/riscv/c/2efa234f5e0c
  - [v4,03/12] riscv: ftrace: align patchable functions to 4 Byte boundary
    https://git.kernel.org/riscv/c/cced570c2c0c
  - [v4,04/12] kernel: ftrace: export ftrace_sync_ipi
    (no matching commit)
  - [v4,05/12] riscv: ftrace: prepare ftrace for atomic code patching
    (no matching commit)
  - [v4,06/12] riscv: ftrace: do not use stop_machine to update code
    (no matching commit)
  - [v4,07/12] riscv: vector: Support calling schedule() for preemptible Vector
    https://git.kernel.org/riscv/c/e2a8cbdbe932
  - [v4,08/12] riscv: add a data fence for CMODX in the kernel mode
    https://git.kernel.org/riscv/c/29b59e3bbb6e
  - [v4,09/12] riscv: ftrace: support PREEMPT
    https://git.kernel.org/riscv/c/f48ba55bb8a8
  - [v4,10/12] riscv: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS
    (no matching commit)
  - [v4,11/12] riscv: ftrace: support direct call using call_ops
    https://git.kernel.org/riscv/c/7ef9ae7457c0
  - [v4,12/12] riscv: Documentation: add a description about dynamic ftrace
    https://git.kernel.org/riscv/c/0e07200b2af6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


