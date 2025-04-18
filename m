Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD8A1C84CB;
	Fri, 18 Apr 2025 14:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744987524; cv=none; b=cpIn06ugJE8nMrSNVNeG/54LBipwd3h/src//vWBwHdxWrLs3Vl3me53p+uVSWrM5o0A0Bskp1iqUSsVX7w6dlYR7ot7J/bdyARZseIHUskBmzEP1G638am78RG4TKdDVo8DKlGZ5HYBlPbb8T28QKpIO571gtk3kb9120zVEPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744987524; c=relaxed/simple;
	bh=FB/U/R7R6GT7G0H496FK8vYkq7dVTMAXpO4+ZqEwsVA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E14XQuBoED+RwaepNzIiRWpsoVm46N/hEaqCDBA6B8ETWY1acxH8/9OMCV/8AOsLj1i+9eqLkBf6iBg3+o9UOF1sBMf6cPaC7XSLvX3B6xjmUbq2SDz7Be1i0VUIdJ4BGxFUPyrdkDhtbgK9YdLN6SaUSwBAZIjP4P/dxj/+S+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA7BC4CEE2;
	Fri, 18 Apr 2025 14:45:21 +0000 (UTC)
Date: Fri, 18 Apr 2025 10:47:02 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: David Ahern <dsahern@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, kuniyu@amazon.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 yonghong.song@linux.dev, song@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next] udp: Add tracepoint for udp_sendmsg()
Message-ID: <20250418104702.52f3afb3@gandalf.local.home>
In-Reply-To: <20250418083351.20a60e64@gandalf.local.home>
References: <20250416-udp_sendmsg-v1-1-1a886b8733c2@debian.org>
	<4dd9504c-4bce-4acd-874c-8eed8c311a2f@kernel.org>
	<aADpIftw30HBT8pq@gmail.com>
	<8dc4d1a8-184b-4d0d-9b38-d5b65ce7e2a6@kernel.org>
	<aAElmpUWd6D7UBZY@gmail.com>
	<1b17ce33-015f-4a10-9a98-ebea586c3ce4@kernel.org>
	<20250418083351.20a60e64@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Apr 2025 08:33:51 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> In fact, if there is a clean up, it should be adding "_tp" to all
> tracepoints that do not have a corresponding trace event attached to them.
> As they are in kernel only, that change should not cause any ABI breakage.

Actually, I think I'll make it where tracepoints created via
DECLARE_TRACE() will automatically get the "_tp" ending. That would help
enforce this API.

-- Steve
