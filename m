Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D1D27A928;
	Sun, 10 Aug 2025 21:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754860350; cv=none; b=JvBnm+YMmUQE+FOMkkWH2AFr723pilgnDpHDzOpoEkWfMnE8kuELAVPc7oA6zEQysChfjLT1ox4hio5ndIgO3MOOO1D84V+SVwcCKMxEaySU02P4IYJ9OWgOLhPyNkR5Ou46gsJq+BKqC3JZrlwH35uXhpuu5XvuG3cm5WjRdGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754860350; c=relaxed/simple;
	bh=XKg0OOdGfYmfRvgFY++OfMPEYLIqzmAx6qO3n65+FpA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W7E/y1NJ8zpHKs08O+am2Ie+nWLgfqIOBvEleDxUhdFnIRLblupBixeXtrMcrrGou6ku5i5prUn6Od/hG6Mf+jCd0gpZWaJemRM0INYB7x3adNEKnwtWCt0gsm0yhlHHXJeZRdr8byQ5p8vx7O8usTyND6df9olIjgplnRTEvDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndoOyPc5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndoOyPc5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE96FC4CEEB;
	Sun, 10 Aug 2025 21:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754860349;
	bh=XKg0OOdGfYmfRvgFY++OfMPEYLIqzmAx6qO3n65+FpA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ndoOyPc5k/u2Udft58BjOOdq7dfODMIIZLy98gwIilKxY9Ab9vUVj1GVyMP56qHoH
	 GGacwykIoGRAZpVCi/IrsJ3Xe74SonkHwe36CrDMhF1PduTKRyhYr+uTiqt0KuhmeI
	 ztOn0S+khk+h1ZNfqlbzXgrN/lHqtjzuvhOftptDizE0pTPudenDkJNG67101MVUzU
	 9TtHufTGZcvFEWZe2OVp6AGq2SFkgqG54p9sjyggL4MXeftLr1uN4C4H3+XbfPnJnw
	 L3maKn7HvkxcOZ3NCnhmqufFxzM7foxGf+heDkKXDC2Hq7SGeZ4nnQbGpEftIN4KnA
	 Vld8vIMLQfFRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDC339D0C2B;
	Sun, 10 Aug 2025 21:12:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v13 00/12] RV: Linear temporal logic monitors for RT
 application
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175486036223.1221929.9747032102829878365.git-patchwork-notify@kernel.org>
Date: Sun, 10 Aug 2025 21:12:42 +0000
References: <cover.1752088709.git.namcao@linutronix.de>
In-Reply-To: <cover.1752088709.git.namcao@linutronix.de>
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

On Wed,  9 Jul 2025 21:21:11 +0200 you wrote:
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
  - [v13,08/12] riscv: mm: Add page fault trace points
    https://git.kernel.org/riscv/c/a37c71ca412d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


