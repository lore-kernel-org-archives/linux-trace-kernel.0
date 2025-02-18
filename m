Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A1226AAAF;
	Tue, 18 Feb 2025 14:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739889603; cv=none; b=dTmAotCT8ZNHAYgZSieuz3kqH9anuxJOpBeI4eGzq53atVvO6IJDT/gU8mJB3PlGYcUw5NSXYxR7hRqlgGfE8+sWdvsRyE9wyjJkzB6kPz3ZOsMUzzt4oZ67Wg2DZjmIbKaeVoMRGvchW75DHAE8BCEVOHPNP+TR+eoiSmm90UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739889603; c=relaxed/simple;
	bh=NMy4Gw6L5rQhTIwdvCQIzp6p8eCeHC82U8qXljvChfs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=c6H+LGHsZv2D5zLwU43HiwIFrEGfD92O5SitSJa9PehTab25B2OsS3/fY0pYeoHUrye6O2zXTCCsoCdnpkiTcFats5NEk7BYLHF98s0fIwx1TrstJyBbqtAcLoo870hRd1SyN/QLtFqdsvfoU6HFs3VPVMQPhbPZeDW9iTlOC/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjlXTsY/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjlXTsY/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84454C19425;
	Tue, 18 Feb 2025 14:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739889602;
	bh=NMy4Gw6L5rQhTIwdvCQIzp6p8eCeHC82U8qXljvChfs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EjlXTsY/f75fOFP1F1VMK1N60yLPerLAdq/bSx6B4+T26Er7+a2dw2tZgHGsjphI/
	 IQJm+jZDlXXd0jSwrZDWyTa3wPBNAIolbsgty8u2NGktD6fJ0D6f/czJlgmBO7R4NG
	 XkQFR+fCyigzjppM0tbsWx3YGM/oAdBGSes9DIVAwbz6/uz3VJLeKorFHWmz9mLTQb
	 xC8jfiboBYf6LvsHOaiaLZ8lFiTCl/Imr/B46JSuod193mnVcTkrHhPzIo+1CSugS6
	 9c0+ObQUukvYbu3wjS0bYjK6j/W7X4vLQ9R6pPELm0YFyMWPpzlqZRzcYxNfBAjvRw
	 0CkuQUl6QHWDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB979380AAE9;
	Tue, 18 Feb 2025 14:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] trace: tcp: Add tracepoint for
 tcp_cwnd_reduction()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173988963251.4107754.12885780180593326493.git-patchwork-notify@kernel.org>
Date: Tue, 18 Feb 2025 14:40:32 +0000
References: <20250214-cwnd_tracepoint-v2-1-ef8d15162d95@debian.org>
In-Reply-To: <20250214-cwnd_tracepoint-v2-1-ef8d15162d95@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: edumazet@google.com, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, davem@davemloft.net, dsahern@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ncardwell@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kernel-team@meta.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 14 Feb 2025 09:07:11 -0800 you wrote:
> Add a lightweight tracepoint to monitor TCP congestion window
> adjustments via tcp_cwnd_reduction(). This tracepoint enables tracking
> of:
> - TCP window size fluctuations
> - Active socket behavior
> - Congestion window reduction events
> 
> [...]

Here is the summary with links:
  - [net-next,v2] trace: tcp: Add tracepoint for tcp_cwnd_reduction()
    https://git.kernel.org/netdev/net-next/c/8e677a466145

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


