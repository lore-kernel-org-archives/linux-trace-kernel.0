Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892E319ADBF;
	Thu, 25 Jul 2024 13:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721913639; cv=none; b=ckctShC0KNx/5+RwGcZzPkVtRpTzmRPxl6OfRNXGmgMko5vn2f3PtO8W6lHtSEPRE9ScUdx65wnMRUWhb3NrCp6oHjaX+6b1NTH4EhmflOPK5LZjg7NiKX4bQWtouDrTY95HAFvRr+JgUvjTvEp44zwf8mf3t3qrykT1oPRgA4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721913639; c=relaxed/simple;
	bh=NCWZaF607AaCtMMQUTzysFKr43p3JyTYHA2mzCn9qm8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MKWyIsXl6nRqy7Tq3SjCn2XADsGiWK9tJF2DRaJkJM7P8pKrNecB5KU+ziA5c6bC9AgeNQv/YkdMMVUX4WM2ESWJWzNECM55zQfp2HMCOnZ1e71s18k+BJYsTbZfylYubYGTEgPhSOAEcCTMExokyixfKzWreZqNzPvMKOKWhN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cV7owqwd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cV7owqwd"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46BD9C4AF0F;
	Thu, 25 Jul 2024 13:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721913639;
	bh=NCWZaF607AaCtMMQUTzysFKr43p3JyTYHA2mzCn9qm8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cV7owqwdoy9b4gB8ouBMUoMXi/mwjXvOd+XdZPNbbtncJnfno4eDiTANcALBKI8Q2
	 2Q6s3QJADPkEz1pBYJtRy4YeE0/69ueCZHDiAWuSXQYl7H4c+AaTE92mZXqYLocNxB
	 Ay6iQpRi7Ni1M3Rv3DoVmmRAJotJ+o6O/OR99cipbrZpn7EcCVw6gALU/Djp8rtqcm
	 syDWXkuV3D0jRhvpwl2PuQj3HL+3I6QWaQvPb/VOjJuJYbI6cxPBkoJY62hkGeJBVC
	 p8hEGFti9qQgmzHXznBFo0qfm7PnMpgVgIhCYirQZfOddfsL+C10FqD/r/Op9w83xj
	 on5YRSEXfOp6Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 37A39C54BB2;
	Thu, 25 Jul 2024 13:20:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] trace: riscv: Remove deprecated kprobe on ftrace support
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172191363922.6240.436902680893546478.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jul 2024 13:20:39 +0000
References: <20240613111347.1745379-1-ruanjinjie@huawei.com>
In-Reply-To: <20240613111347.1745379-1-ruanjinjie@huawei.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, rostedt@goodmis.org,
 mhiramat@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 13 Jun 2024 19:13:47 +0800 you wrote:
> Since commit 7caa9765465f60 ("ftrace: riscv: move from REGS to ARGS"),
> kprobe on ftrace is not supported by riscv, because riscv's support for
> FTRACE_WITH_REGS has been replaced with support for FTRACE_WITH_ARGS, and
> KPROBES_ON_FTRACE will be supplanted by FPROBES. So remove the deprecated
> kprobe on ftrace support, which is misunderstood.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> [...]

Here is the summary with links:
  - trace: riscv: Remove deprecated kprobe on ftrace support
    https://git.kernel.org/riscv/c/3308172276db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


