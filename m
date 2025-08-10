Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0030F27604E;
	Sun, 10 Aug 2025 21:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754860343; cv=none; b=uVNz6VvzXklDUup+yzpWCPtGTNFA6UogpRffGM7eE/bp0KGm8EuyyQ1fMNF93NspifRWD439SCEd2IcQ4tClx/pdkMikDmXoQllWzwaOTT20zvS4boncXrMRO8i1DLxqQntNRmF2d1zdb/d3RQei1Ls1S08Gmm/E2bdr+Se3bGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754860343; c=relaxed/simple;
	bh=TpZL3AcXPmyv/k3MtGxAsY7Rjx/rL1aPCdabb8/uY6o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=luWTSWF1XqWATtitFMfiLwSGHHWN86NPIp0WWIKKvEDQ+xDtxLMZiSYctJ/tuOU5BKTvWFcQmvQA91/myX6p749E8YSaWauDFGn2oo8djF+qrNP/VpB2bguFdXyT61LyaRArp1dAhwOM/UWpdVchXmMr66UTn7/nAUMlJxxpuzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTS5TYzE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTS5TYzE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC32C4CEEB;
	Sun, 10 Aug 2025 21:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754860342;
	bh=TpZL3AcXPmyv/k3MtGxAsY7Rjx/rL1aPCdabb8/uY6o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pTS5TYzExZlSe4Ia4SJ5Ji5trT801OfzUS5fyuw1JHoDtyMISoC59GkMVDZRTW/jE
	 vUGTN6tabeS/ymliRBPyeFpo1wxHwKHg2cyied70C6IdCg9MBXd1kB0e8rAzdfVolz
	 B9qdEVcdNDmdXgqbZ0zWYQxP/qKo2C1yO1M/lc8AvuxbwyYAvqwXZE7setGJv98Kr1
	 rJa2B5aIp7Bog9Y0S3BmHY2vNU+VfXTAIEQiHaqFOuRKHEgU+g0cthS48HiQckPdAP
	 VET8IBlSmE4xOnLd1zmxP/qD09hNIC/krrZgeRVC/5AdIwovZ77hz8vEnEbIGZLdi/
	 MO5JJaQHVpS0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BEC39D0C2B;
	Sun, 10 Aug 2025 21:12:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 00/22] RV: Linear temporal logic monitors for RT
 application
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175486035499.1221929.1151596162296259392.git-patchwork-notify@kernel.org>
Date: Sun, 10 Aug 2025 21:12:34 +0000
References: <cover.1745999587.git.namcao@linutronix.de>
In-Reply-To: <cover.1745999587.git.namcao@linutronix.de>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-riscv@lists.infradead.org, rostedt@goodmis.org, gmonaco@redhat.com,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 john.ogness@linutronix.de, pmladek@suse.com, senozhatsky@chromium.org,
 mingo@redhat.com, tglx@linutronix.de, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, luto@kernel.org,
 peterz@infradead.org, catalin.marinas@arm.com,
 linux-arm-kernel@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr

Hello:

This patch was applied to riscv/linux.git (fixes)
by Steven Rostedt (Google) <rostedt@goodmis.org>:

On Wed, 30 Apr 2025 13:02:15 +0200 you wrote:
> Real-time applications may have design flaws causing them to have
> unexpected latency. For example, the applications may raise page faults, or
> may be blocked trying to take a mutex without priority inheritance.
> 
> However, while attempting to implement DA monitors for these real-time
> rules, deterministic automaton is found to be inappropriate as the
> specification language. The automaton is complicated, hard to understand,
> and error-prone.
> 
> [...]

Here is the summary with links:
  - [v6,18/22] riscv: mm: Add page fault trace points
    https://git.kernel.org/riscv/c/a37c71ca412d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


