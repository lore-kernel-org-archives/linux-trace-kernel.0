Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016A2279791;
	Sun, 10 Aug 2025 21:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754860347; cv=none; b=NB8e4NALgcHVJjynloPN+fGcw5eL0GmTMtdCuqtkb+Z9n0YdmYNsqwFxnd/+9ZThMVkRuAlPmg6Wc0w36BcFu4JVdRQ5ZgrezZ1JuQGLQF9O20vUeihFkO4QIaPauwOCBaWmibPSO16e5DmGcNJErpsEvjNwThDyrbACIb+mBmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754860347; c=relaxed/simple;
	bh=O1kZXURGOmtyyxsHhriJ95yieEZ3eBnv/EWQAjiQF7o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AmC8ARrUnudNbi9MkC7vR9hY9tI1KpD3Twwu28xLME40MJKj5/QbPOjPve3NjrtXjkIM51frQZXGebjQj3ld0uFqgpmbzPHF5an6WX+cCBn36xdwnNqHonxKgvorOXPVSxil/3zsT13DN9YXI7VeYIyNyox9pOraxZ3kFm1WtoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrGbRrf9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrGbRrf9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE972C4CEEB;
	Sun, 10 Aug 2025 21:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754860346;
	bh=O1kZXURGOmtyyxsHhriJ95yieEZ3eBnv/EWQAjiQF7o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DrGbRrf95ZFILwdpK6hYgQB5HzXOiWAkxA1NmLyY52qfyUbgDHEoxjwKc5aAnmGJB
	 Zagnu+OlyksR3JHcQS3OrpJk32sFdAPnAWAh3o6dPC11iUrqW4RCphhzNl3pfvjc+l
	 n5URwaI5RxQPNILn/UInUssIvoUafeNM1X3kA41DRdFK2f6Z0NpudpwSs9dC/hdXNo
	 aEy2qRw8hVZDfb7Tz1xHS1PEvb1QwWCTvEZ/MiJZfiKkkutTYxWOp+yTTqNJHO36r7
	 tAgpl1yZ7CPqXfuwnqRxYW9iKlZwOtIfrkGXOZwUyCoCrPQ1kDQixq1NcH9z6X/MAp
	 MW158JLNioO9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADBE639D0C2B;
	Sun, 10 Aug 2025 21:12:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v11 00/21] RV: Linear temporal logic monitors for RT
 application
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175486035924.1221929.13550140016096885653.git-patchwork-notify@kernel.org>
Date: Sun, 10 Aug 2025 21:12:39 +0000
References: <cover.1751634289.git.namcao@linutronix.de>
In-Reply-To: <cover.1751634289.git.namcao@linutronix.de>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-riscv@lists.infradead.org, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, gmonaco@redhat.com, john.ogness@linutronix.de,
 pmladek@suse.com, senozhatsky@chromium.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr

Hello:

This patch was applied to riscv/linux.git (fixes)
by Steven Rostedt (Google) <rostedt@goodmis.org>:

On Fri,  4 Jul 2025 15:19:52 +0200 you wrote:
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
  - [v11,17/21] riscv: mm: Add page fault trace points
    https://git.kernel.org/riscv/c/a37c71ca412d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


