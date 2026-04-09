Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11E730F547;
	Thu,  9 Apr 2026 08:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775723398; cv=none; b=fzQPi4pOhKzmjQH/WlMbJGC6oAioedMVR1FqP2Tnsvz3n/gZk0w9HcaGw/bKJDZyMY3ucDrmpvSo5Nkz7T61guOi7n64Ozy1kKF6m52XBhNLRzdETL60tB3wbiIKzWgnAOr4TCKCN40uHMgdYmIan7DVGGXdKaO88RuMoW8Z6jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775723398; c=relaxed/simple;
	bh=90J5dcfEqJG4NnUKBW+CcbW1udft49rP02t6iqdqqMA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DYo7yRlcNgXZOxtyzuVv39Nty6B5neZZX5s4FwCXLa/BNR1CL3efp3XoP9BcOUjgFw/8kW+g3y9U+USzP8vx88x+fom1nXU5A0N1u65s2ugtElMyHWIDTyCXT0bin+Tw2SPOwr+yCoijbYxIi6PDH+VAjrqhm16vo4Rp1LOKKZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Td+xSAcb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Td+xSAcb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA41C4CEF7;
	Thu,  9 Apr 2026 08:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775723398;
	bh=90J5dcfEqJG4NnUKBW+CcbW1udft49rP02t6iqdqqMA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Td+xSAcb0HzHDfuaJow2c9iq30FYW8xG98M8Jas8AAvcLrBe2iMcNDeOWmsnrLa96
	 ApNFD9C3W5dMhN0RNmajj865lSI32ldRvRo1O9OV6SdM4kHeMhat3LV7xU1jxVvP8R
	 6QSoXl29YCDlBuTEZ0f5QXqgSENsm3WjJPeu3UpKBWHfGXG2p1soJK99si+2b4Cmc7
	 BlJMg9Zp0WFsVTGQmrpehjYwp6aLOn7nr53b+y4Hg7mX54rAKGZX8RviJnOcXysBe/
	 IyyRgJrbuGyHtTnTIYKaV8bT9waqYb+S8Ml/kyU4dha6HmK3tkJvgZLRaezNPe2xwD
	 QajDQ0EJYVjfA==
Date: Thu, 9 Apr 2026 17:29:55 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Cao Ruichuang <create0818@163.com>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: Account for fprobe attachment at
 creation
Message-Id: <20260409172955.98e2d20a7f7736a1a9834816@kernel.org>
In-Reply-To: <177571189990.17594.14983613605049028604@163.com>
References: <20260407115751.96184-1-create0818@163.com>
	<20260408094920.417cbb5e64220afc2bf1b2aa@kernel.org>
	<177571189990.17594.14983613605049028604@163.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 09 Apr 2026 13:18:19 +0800
Cao Ruichuang <create0818@163.com> wrote:

> Hi Masami,
> 
> I reran this in a clean QEMU boot environment with only the minimal
> tracefs setup and the add_remove_fprobe sequence.
> 
> I saw the same behavior there: after creating myevent1/2/3,
> enabled_functions went from 2 to 4 before any event was enabled, and
> enabling myevent1/2/3 did not increase the count further. After cleanup,
> it returned to the original baseline again.

Hmm, that does not mean test failure but could be a bug.
Can you dump the enabled_functions and share it when the
test failed?

> So this does not look like a dirty tracing environment issue. The
> failing testcase assumption appears to be that the attachment happens on
> enable, while on the current kernel it is already visible after create.

What kernel are you using? I need to check why this happens.
I guess there is a change which introduces this issue.

Thank you,

> 
> Thanks,
> Cao Ruichuang
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
