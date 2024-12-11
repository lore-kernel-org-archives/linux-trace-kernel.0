Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B9F1F63D3;
	Wed, 11 Dec 2024 22:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956343; cv=none; b=K81YtVj9MqpVmGplv9ObSp7f63Q0eJh2wa9mN9jpMh7LYmFvyqKT+mHmQBjpYdEsn1e+eOulQTPh1RpxkdavziGEob2iig1PAhPXtCT93RdDHzQHk4bxGZ1yeCg0FVOcWjgZypVu2KqaXcvdxz84wa5csrwphckTTB/cKhUx2xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956343; c=relaxed/simple;
	bh=ZHc33Xj1xn1ChAMYLEESG0l2ZDeoWzJJwfaFTxgV2l8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UVFVyUMHniZgcsy7zjkgzR+uZC5SX2IZucNO3CIEAT4eT/24uTI9hiTyZjAocbeqWYEQZKzAL31L9yf9Vj2qkc7xUimnwnTlHkchCIR4hN9l8p1awjUsjr3aXjrgE8+OvHaEBSRFb8E9WcWckRLAaXYpNYRmVd8wtOt3clFWaCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/aQI+38; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/aQI+38"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E240FC4CED2;
	Wed, 11 Dec 2024 22:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733956342;
	bh=ZHc33Xj1xn1ChAMYLEESG0l2ZDeoWzJJwfaFTxgV2l8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c/aQI+38D2hza9d6Ks1OqGLKc9KbpNAUef6OEYU/62ulv2kHC5BSTZeklBMEWjOTw
	 nblyMMYmiGazoSWclR7yURKnOC/TM7ck4sMmgnE7L1gyW+sfTN2VHy6GL6FPxXVOnx
	 ZdlWPXMFMEREGrioiEW1D9/GbRqvhcSfH3r7nbDRxSa+qE++UrVUIB6jPycRQeOxR3
	 q8vFTa3Bo0Av+rTj74Fhkuv+QwosaGpaFUbit2UsMuQbmXp55TEQxlmPdhIkIp7Z4s
	 w0fi37WNzROYx11OqcwM1sa6VHrBd6jtFn6430wR6kbMEoD7NpFgATGH3mR2wL3K2g
	 JN/oZu0Ij/aqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CE4380A965;
	Wed, 11 Dec 2024 22:32:40 +0000 (UTC)
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
 <173395635900.1729195.10810340550765834430.git-patchwork-notify@kernel.org>
Date: Wed, 11 Dec 2024 22:32:39 +0000
References: <20241021151257.102296-4-bigeasy@linutronix.de>
In-Reply-To: <20241021151257.102296-4-bigeasy@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-riscv@lists.infradead.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, peterz@infradead.org, tglx@linutronix.de,
 mingo@kernel.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, ankur.a.arora@oracle.com,
 efault@gmx.de, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 jszhang@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, palmer@rivosinc.com

Hello:

This patch was applied to riscv/linux.git (fixes)
by Peter Zijlstra <peterz@infradead.org>:

On Mon, 21 Oct 2024 17:08:42 +0200 you wrote:
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


