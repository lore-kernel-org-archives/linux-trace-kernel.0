Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B88C221FD4;
	Wed, 23 Jul 2025 22:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753310029; cv=none; b=IoSB3HucjhBIhF3LHdZihZEvWtkxcSf7rqseyKMuS/Uk3tKDL4u0SJX66yKvooEM4XBSw0KCTbN6jSWGceWF0t6tJ+5WmqUAbfs2oF5gipw2Qanvm0++FUYA/zlzQI3c08kJuD7HgFI0LMvi5bBHyJU2VsPNAHOUyuoozGCC704=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753310029; c=relaxed/simple;
	bh=Hhdxk2dYlO/fRPdjUxQG2S0jF6UY5lXWrbYZDd6EZnY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tWO6Q+CFdTE8cx2IDedXBCL4bVwyZbyqUtkwnzhdjOEuTB3qMds9WwcG1vaBLN4XrovLUvDWX1lU85Wcm5evZhjrHSlHXV843I/UNDfzLKc8iROZs9KJLhtilWzauENeQhcW2HUAJBqKgxtgc7Co2C2roA5ugWz4kGC9lGjoCcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 8E10F1A020C;
	Wed, 23 Jul 2025 22:33:45 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 5D42520029;
	Wed, 23 Jul 2025 22:33:42 +0000 (UTC)
Date: Wed, 23 Jul 2025 18:33:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
 llvm@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
 Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, Nick
 Desaulniers <nick.desaulniers+lkml@gmail.com>, Catalin Marinas
 <catalin.marinas@arm.com>
Subject: Re: [PATCH v4 1/4] tracing: sorttable: Add a tracepoint
 verification check at build time
Message-ID: <20250723183343.77489168@gandalf.local.home>
In-Reply-To: <20250723182701.195a5ddf@gandalf.local.home>
References: <20250723194141.617125835@kernel.org>
	<20250723194211.768813368@kernel.org>
	<CAHk-=wgbAruRX=xFVGevggtRpHNYyMVwgNYYJgYg5hMuU6ASGQ@mail.gmail.com>
	<20250723182701.195a5ddf@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: b1nyfsaoqor73ht3h7w1xxgfxnwwoiai
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 5D42520029
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19cbgRMjbz8+EWrWftR/LllI4yOJ84c6TY=
X-HE-Tag: 1753310022-440924
X-HE-Meta: U2FsdGVkX18xZOH9rFV8xOE4USRgrV+hMRHlfZgXsRgMqjeCuNg/R/QOgOocfkEzMgBNBo/7zP6J3rU0jN3ih8MKMCqly523T3UZMpXeTruEZZBMEPOjHLmAAkeWLeEtC/ejF8Zb8OLPgZc+rzcW7ySXvWwaOxkj2vs7pih8lfgjbAjjSugMnVvcd+KENpLTaWTnMCpPY5zfsn45yycLHLRIXmtGRqRZ8QxWTXgJloSxX2t9qJqj+wcJs/z+fR9VJxw2JwFGKngIROdFjb09iZL+RYA2JdnKInO8Skla1XQhR3VmQ0/grPQutiErPs9uZaSSP2qRVX7UCJIKcAnf1tvvwLU3NwRvww77gIN5azePFP0LtuhzXAT0gWPTN9p9

On Wed, 23 Jul 2025 18:27:01 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Looks like it will require a separate application to search the vmlinux.o
> instead of the vmlinux (which sorttable does).
> 
> I could probably take some of the sorttable.c elf parsing and move that
> into a header that would share the code.

Anyway, I'll just drop these patches for now as I don't have time to
rewrite it. I'll at least put together the unused events that I've already
removed and send that out for the next merge window.

-- Steve

