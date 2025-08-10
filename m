Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FDA279DCF;
	Sun, 10 Aug 2025 21:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754860348; cv=none; b=m0lSIyfjFK9pY3fauZjY6w+7n7XMFgS6dghzCu6QPIq+Cc5baLgy/ZJxk6p4NmajqircrRM+LeLSzPaalW2eJkgNb1wszLRF7K6H+Lc8sds/JP019aUL1C/ffTnEDlbyms6Duq6MxcxWkyCpqdjhmfa/mpxtlQvORB2EnKu6KM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754860348; c=relaxed/simple;
	bh=/9zHP8ZRwUfoUYob9oFo9xt+P+QecvgYDAFnr1bk4hE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Bfp31U14dFt73iIktN/K8r4Tkx15vInih9lgpL1IvBFjLf9faFMgS6ucRgQT+SNCsLfR2DTwtR1gBt207BPGvUTpp78ovE5aO38JeZHDrvjlnJgzoOj6Kj1oxFd2O4qk8mGKThC8HRmxm86xPM9CSu5kVvQN0Cb19eRmmqnAQFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HwPDZj2+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HwPDZj2+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E76C4AF09;
	Sun, 10 Aug 2025 21:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754860348;
	bh=/9zHP8ZRwUfoUYob9oFo9xt+P+QecvgYDAFnr1bk4hE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HwPDZj2+Ia99T8kRgPWLoW5qVwonv3sSQzk/I8QIggOPL0L2UI1c9GrrWUys96Fpe
	 Ef3COe4fMnaNZkaDF667XWU1um5Sia/fdA00XHW5gQspbvt2QEQhCDyfElRXMPaTlD
	 eYxCSfa2oCTjGg9cSw+1831aRTeDpgW71PSRO8VjUG9zdYyw3I1vyQjmRgPycSofdu
	 /Noh/hN1K0hzCTQ8eQEiV8VJtzF10t+IOI2hfcXgKLM8tGqLtohL46ikeWVSW0Xr7E
	 YVLU7l5GU7y6B30/6BxnVvSVHET1VNB2LighyWk0hWcw+UOWMcar/7QoWfqm0KuWbU
	 715PBI7JsfYew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33AD039D0C2B;
	Sun, 10 Aug 2025 21:12:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v12 00/12] RV: Linear temporal logic monitors for RT
 application
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175486036073.1221929.15867064164483505773.git-patchwork-notify@kernel.org>
Date: Sun, 10 Aug 2025 21:12:40 +0000
References: <cover.1752082806.git.namcao@linutronix.de>
In-Reply-To: <cover.1752082806.git.namcao@linutronix.de>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-riscv@lists.infradead.org, rostedt@goodmis.org,
 john.ogness@linutronix.de, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, gmonaco@redhat.com,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 pmladek@suse.com, senozhatsky@chromium.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr

Hello:

This patch was applied to riscv/linux.git (fixes)
by Steven Rostedt (Google) <rostedt@goodmis.org>:

On Wed,  9 Jul 2025 19:56:17 +0200 you wrote:
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
  - [v12,08/12] riscv: mm: Add page fault trace points
    https://git.kernel.org/riscv/c/a37c71ca412d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


