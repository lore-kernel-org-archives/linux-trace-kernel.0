Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261E91F3D36;
	Wed, 11 Dec 2024 22:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956342; cv=none; b=W9Py2FCi94gLM+HKiN+H2umG8v4FeI/Mc/iyZfSfycKhIKLHNTnTpfv8eUKSRaae/f6FA5agiR3uOnZaiC6osgj91zGKAVZcJk0UydlGH5oi6Chj3+r594HAs4eR6fMOQimaijha/ubHwMmtUHwLM29vKEwp2gUUykmXKoN+2EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956342; c=relaxed/simple;
	bh=4jV9okJoQ2ZRLdjtsTKHiCVBI+vSPd5zBDLlSBJliVE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iOam6B4OG0bHybkfBzpQeIyV+Ewc340qyl/MN4vc4+1rw8I8yZlms1fXeKdamfT1uFceatMx+VFN8o0PAjHL/0vgZlYTT3l940YsOWGaExZT9wvdN5MyeZk5yGTByTZJ+0f2p9VuaqqIBijEYrQQbDrGvmmNSABJP9PwRyUUAnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWkkb8Ok; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWkkb8Ok"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3EE4C4CEE0;
	Wed, 11 Dec 2024 22:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733956341;
	bh=4jV9okJoQ2ZRLdjtsTKHiCVBI+vSPd5zBDLlSBJliVE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TWkkb8OkrqubtnJxHvbNT9WqC99iA6rKzDtPnVl91aKhFXFwU+tgMsgZ400K1BjJz
	 +4puyHviFEvtYfbj+9HEgo48qJotV594GhqUnj+pt8xeUw/ePZqqTc1Hgkwps2jCti
	 AdFgkN9qS8r82/bczZaq6QPx+97vQlZ6O0rK9KYp788k7YgPrVY5Op39OsnsQAZPtf
	 p04pypWM0aZHSfULdERX4WAFpioBtOzAA8uqAYGLz+pbAKkMy89ObaA/3ERR+nyph8
	 Wd8rQ/3yIj5wAjCmw3cXGy0z3N3roSmsozd7vUZVH7jp+xsfIuUfWH+41uWwI0DhDp
	 mCt7VMeUraHfw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB048380A965;
	Wed, 11 Dec 2024 22:32:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 3/3] riscv: add PREEMPT_LAZY support
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173395635753.1729195.5240376576405200812.git-patchwork-notify@kernel.org>
Date: Wed, 11 Dec 2024 22:32:37 +0000
References: <20241010122545.7N_x3GuX@linutronix.de>
In-Reply-To: <20241010122545.7N_x3GuX@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-riscv@lists.infradead.org, peterz@infradead.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 tglx@linutronix.de, mingo@kernel.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 ankur.a.arora@oracle.com, efault@gmx.de, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, jszhang@kernel.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu

Hello:

This patch was applied to riscv/linux.git (fixes)
by Peter Zijlstra <peterz@infradead.org>:

On Thu, 10 Oct 2024 14:25:45 +0200 you wrote:
> From: Jisheng Zhang <jszhang@kernel.org>
> 
> riscv has switched to GENERIC_ENTRY, so adding PREEMPT_LAZY is as simple
> as adding TIF_NEED_RESCHED_LAZY related definitions and enabling
> ARCH_HAS_PREEMPT_LAZY.
> 
> [bigeasy: Replace old PREEMPT_AUTO bits with new PREEMPT_LAZY ]
> 
> [...]

Here is the summary with links:
  - [v2,3/3] riscv: add PREEMPT_LAZY support
    https://git.kernel.org/riscv/c/22aaec357c1f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


