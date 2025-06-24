Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D13C1946DF;
	Tue, 24 Jun 2025 19:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750792683; cv=none; b=ohU3pRwZg3vO4XAr6Grrp6ehjhXDJLlPpc37NPWhuU5C7SMwS230WHd9JOFwVOE1JaFGNW9RuHfCSHNzKylQQAddnyA3Q2JBvYEG47GaRXxtCLrYX2aJAnQuUxQivaqMKOuyOgcOQT/CgS9fLmzmBF7cGuTKkFadmKVNNbegRbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750792683; c=relaxed/simple;
	bh=kZA5lKAdVilY05q/LztHGQnTYuZbYLC88LIVV0JhcX8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vGUzxwFHyb4/WnogLewGcP7PSFWX1qvdhtzMjIHj5Gz0g+K/v0NvjlbQIdLneTfk+26scfxTHWaaFnKtKWDIA6/h2VUpRFRYL0e7r2wgx8J/RElcW2p2aUVupUxSBWVKJ6pclCmglCQP+FPcnc2S0UdSieKZzdrpyB2UGplEnKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 5B80D1A0F5E;
	Tue, 24 Jun 2025 19:17:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 83BF21A;
	Tue, 24 Jun 2025 19:17:57 +0000 (UTC)
Date: Tue, 24 Jun 2025 15:17:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+daba72c4af9915e9c894@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
 syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] tracing: Fix filter logic error
Message-ID: <20250624151756.47f03db9@batman.local.home>
In-Reply-To: <tencent_4EF87A626D702F816CD0951CE956EC32CD0A@qq.com>
References: <6859ea24.a00a0220.2e5631.0044.GAE@google.com>
	<tencent_4EF87A626D702F816CD0951CE956EC32CD0A@qq.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 83BF21A
X-Rspamd-Server: rspamout08
X-Stat-Signature: dai31syqxb7wd6whabpgzy6tgo5njzkm
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+jx2MUeNqHQdJNzrMHAe+nb8YxAiZZBa0=
X-HE-Tag: 1750792677-896582
X-HE-Meta: U2FsdGVkX1/pLr/kp0PrxXqtgeJK3g734I5M3c1C8xcSgM2wdSe7q4xfGbMWDQMUfPocOx6HBDt7tYa07cFrjX/TyJfxmQix3kipf0SqA5z0ayHL0hoRjdA5+HZx6AK/ojEf5aenT/og3X8y/Gze9IBUTNLzIHC3Pz6oyKbAXgYj7iaQ9izk7WYp+CXuW9sS7LWsY4XZwgVNEXz3hWDTkQhAaCLhh9xmhFHsmUthgU13rSF0sJqKJQMLXVqyQ250rITuuBTp4P07OqtBOSLEdcKkggyTi2K7TeMGrrLEX/v7UiDdKQGIEHDNclFaemxKhigvSYMz9qjhM7WIWrjzcOlhNtKQHSLoAhKxkB2UIimtHQF7xLlHdQ==

On Tue, 24 Jun 2025 14:38:46 +0800
Edward Adam Davis <eadavis@qq.com> wrote:

> If the processing of the tr->events loop fails, the filter that has been
> added to filter_head will be released twice in free_filter_list(&head->rcu)
> and __free_filter(filter).
> 
> After adding the filter of tr->events, add the filter to the filter_head
> process to avoid triggering uaf.

Ah that was the kmalloc that failed.

Thanks,

-- Steve
