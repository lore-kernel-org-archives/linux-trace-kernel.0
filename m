Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A9A4A0C;
	Mon, 16 Jun 2025 22:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750111808; cv=none; b=ORLQvWktjeMdaqWzN82DaRbKguOHrjtycB+O8zCCwbvBAhepHlvzfuZKfO8m5gJG6H+u//HqQdiSfRWoEkpWrTM19bbdWpOiofVdwHbt86vh9wWs4XLzmrLJiZg2PYB8IhYb93GnwrXswne1VShEs8AZM8Xn1rDhNBTihqZDlOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750111808; c=relaxed/simple;
	bh=OPxmYCFXXROUzhejBnVBLCe5VD2s5fkbuoEc+N9ZWBA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZdN6sy9KAsvVr+0aHDSx7ng6G/3WnrnzymjUivbnup5IDCc2xMUi4UU8mp4S8+0mRXduF4YjTvO5ngBAasPgJSRyFakn3cwwGB/EyYgOzVjrSl7RPn4CyjlWjYpgs5dPrd/1j8kOUvrTI2KGulE6BkHSiWAT4MrxXKc0ZKwwwpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKyKFsSO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKyKFsSO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35813C4CEEA;
	Mon, 16 Jun 2025 22:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750111808;
	bh=OPxmYCFXXROUzhejBnVBLCe5VD2s5fkbuoEc+N9ZWBA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gKyKFsSOYdC6PUzcjI3a4xboBv8AHU2cvVveqPaKIVu93S9B+pTHpEvkly0oUWyAH
	 qnmyRm8iNpKSn0XhqFoiJ6LDyubb03xFMPBw2YGUeljO/fE7+FE4/GotlZxJyiy42K
	 FKhh3VxAL5t3f/SKW/eSd/7IQzaXYzNEz6nAqfvLjoudnZmP6LKwY2fvtxWuWPHxNo
	 P4UB5rCZyAL/1xtUkyl49eEMhsfm37eatZmKzJ01BIqG8VLqp8GG1769Rgz0JbnBAm
	 Z2ParFcz44Kz9T2ukoHiGYQlAhrwMeOAm253m40cPGdW+DucB4L/LLHajQq2PZ7A/F
	 6AQ5k161guvKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E1838111D8;
	Mon, 16 Jun 2025 22:10:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/tcp_ao: tracing: Hide tcp_ao events under
 CONFIG_TCP_AO
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175011183700.2530350.11672479574209344326.git-patchwork-notify@kernel.org>
Date: Mon, 16 Jun 2025 22:10:37 +0000
References: <20250612094616.4222daf0@batman.local.home>
In-Reply-To: <20250612094616.4222daf0@batman.local.home>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 netdev@vger.kernel.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 edumazet@google.com, ncardwell@google.com, kuniyu@amazon.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Jun 2025 09:46:16 -0400 you wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Several of the tcp_ao events are only called when CONFIG_TCP_AO is
> defined. As each event can take up to 5K regardless if they are used or
> not, it's best not to define them when they are not used. Add #ifdef
> around these events when they are not used.
> 
> [...]

Here is the summary with links:
  - net/tcp_ao: tracing: Hide tcp_ao events under CONFIG_TCP_AO
    https://git.kernel.org/netdev/net-next/c/3cfbde048b1c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


