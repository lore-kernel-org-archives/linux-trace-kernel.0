Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F12221F24;
	Sun, 10 Aug 2025 21:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754860345; cv=none; b=Hjmlh1x8CmLj0f7sISzEp5r3XIydO+0yCTD4P2bSMUmeX+9JQc1lY93qnUumcCITz5Tk1pNfJKhlRw+5ofYN5ZEapYkGONt68n1tNDWgbbPQsJGTK7q3UpIO7Lzxjz57kfZJ/nv0uTWXECyipuvB87Ut3HC10nVMSRj+PDFpx44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754860345; c=relaxed/simple;
	bh=xViFvDPQc1cyLyFxFjlh0Pd2JS6XyL/kGzPxiW6LrnY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ot78PsKCdybJed9E0Gm2g5vRcWgITi3O2sh4wikouRNg7f4eTC7mwm/Kc6nnFdVyyFPqQo0427B8ngEsvQROlHKuP6Z6KT+vNUkqM1befnS0H8ZtZZjjYJOwL4l/3XQqo90A9RFnWXd6zGDMXxw08mUiblFdPwK8VLi7Nx6jlt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qb9avz3T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qb9avz3T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51578C4CEEB;
	Sun, 10 Aug 2025 21:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754860345;
	bh=xViFvDPQc1cyLyFxFjlh0Pd2JS6XyL/kGzPxiW6LrnY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Qb9avz3T8nhcxxOzyZ5dZfHWwvEPJqQa5COovnRKRZPOm7d94jIfh7nWDVYnT2j6I
	 fzeOi40lOQz6w3U7TRiS0JBezpPlGv/FonX2w2kF1IBqMcyJkTPG6ZrZVCUbKw/iVb
	 L+nDJ5s01P9/LfLIHMjn+PKSUYHatPrSjP9bSt+YRmUOEgXkgd/yZESB/L+WkdK6UW
	 AyZteBHDWYI8dss2mv6G4xdNbv+jdrOBlFuInQYbyLMttKFyEs1aFS/QcjJZlT5O+U
	 s7gSjsYYOsgBDUOV/HzZG0sRUOkln3An15YbiNRYW3jXIiONIyYpNy4zN9sAU62/tq
	 2jWggxKDCj0ng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BBC39D0C2B;
	Sun, 10 Aug 2025 21:12:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v8 00/22] RV: Linear temporal logic monitors for RT
 application
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175486035774.1221929.10309183570543138134.git-patchwork-notify@kernel.org>
Date: Sun, 10 Aug 2025 21:12:37 +0000
References: <cover.1747046848.git.namcao@linutronix.de>
In-Reply-To: <cover.1747046848.git.namcao@linutronix.de>
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

On Mon, 12 May 2025 12:50:43 +0200 you wrote:
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
  - [v8,18/22] riscv: mm: Add page fault trace points
    https://git.kernel.org/riscv/c/a37c71ca412d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


