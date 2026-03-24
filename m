Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16E12459ED;
	Tue, 24 Mar 2026 21:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774387520; cv=none; b=ed0lQG5OrIvG8r919ay3kXGbRLPU9M2Y5mZuBeeg0xYvmD8AuLyPAgeyfCcfiIutauM6xja+/v23Vth35U2im5jIMdEMjzbNNG/K9F4Yh9Ll51q/cyw8y6gn8hUcf3Qx2qPsqL8iyPakccn06z6MXfGgXwDzlhY/l2yHI6VVD3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774387520; c=relaxed/simple;
	bh=fzShhY+ttYjc+tQTjWjiCVZuWrXKNIcDk5g28UUUx9o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CamfKJBWZaHjdUgfu5dVMn/LkZMp5kfsuod3Y2IpHQE9XDyKyv1BUjUK4SVsYvjHTt9axS0BZ/4nd2dbRGlEA0dQHPF/JgnZISKTca9RNQhW7J5MWbTTYw4XcwkJlnLfkHNGeluYpmSF2Bhmig1UH3ID4fahavUnNCueAMIeSa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 8B4B4B96DD;
	Tue, 24 Mar 2026 21:25:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 727F12002C;
	Tue, 24 Mar 2026 21:25:15 +0000 (UTC)
Date: Tue, 24 Mar 2026 17:25:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Ian
 Rogers <irogers@google.com>
Subject: Re: [PATCH v12 0/4] ring-buffer: Making persistent ring buffers
 robust
Message-ID: <20260324172557.04cfc2a9@gandalf.local.home>
In-Reply-To: <177431040276.3708637.10277850418341653677.stgit@mhiramat.tok.corp.google.com>
References: <177431040276.3708637.10277850418341653677.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 727F12002C
X-Stat-Signature: hrseg7pmfk93bpszh8xubhfyhrkhwqkh
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18D+kqrlQ+/xg5Xm5XQUC/CFxvhBRxru1Y=
X-HE-Tag: 1774387515-60840
X-HE-Meta: U2FsdGVkX1+O+0vqnyCdO8rg0aEHtup/+snJWlyMULXUruo+Cs5HpLsB5jM5yJ30jyT0QUOrvjbw1ZBy9ZFd9TAKedtIPwDvO0+ReF4taAlZxyNbGxB4T4JVtcGvL+6dmgZgS3o8veb5MqqkaYYzOUGbd3lnfM99+9OClea1LelgFG97NMqywjXtrt6oSHT9Zs100KVRunK2ZZcTfsLy/xjfF0CVUh7P+r4CPsmQCSz7dvumOazf1f5D3NPdzwg/PJ3e+gXr2ShJk8IJB963OtdL7pwEHSA3cziQDFa0WhzHEPzkKiDMNIgUZ/6rvYdZ6vlktu4QDjLFvNOC76kM1S0J7RNnTbdtZcNoLeUGIeKEkvYWjrBT0w==

On Tue, 24 Mar 2026 09:00:03 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> Hi,
> 
> Here is the 12th version of improvement patches for making persistent
> ring buffers robust to failures.
> The previous version is here:
> 
> https://lore.kernel.org/all/177391152793.193994.8986943289250629418.stgit@mhiramat.tok.corp.google.com/
> 
> 
> In this version, I rebased it on tracing/fixes branch (thus
> the first fix patch has been removed) and fixed
> a build error which came from a copy-paste mistake.
> 

Hi Masami,

Can you rebase this on the ring-buffer/for-next branch?

It has the remote updates for pkvm tracing, and there's some conflicts.
That branch is also used by the ARM tree so it can't be rebased.

Thanks,

-- Steve
