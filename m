Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DE62BE656;
	Sat,  8 Aug 2026 00:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786150475; cv=none; b=fY0GH054AOsexkzjWF4e/+MmAzXEpVq5Kk+yVyHjIbdkhUzNgQ4v6rctyXj3y9636yXkHFDQw155ii3A0lSmmoxb7WlaAGeORZPRV0yE5j4f5BYJ5qkkgAlXkg1baqAdBGv58z6HNkyuKeF5l6dqvXBdcngVj9+y4680SLWd/xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786150475; c=relaxed/simple;
	bh=QeXnfTckAMxxhgi69Z2SP2PZsDscW4xu1NMF7oTBv8g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qxyyPJFplqF4Rns5dU9Ei5jtqDfVK7NTex4ziYfj0VMUgpLTYJPViBsVNJgncgGQ/faAXEDg5hXhm0w6nkp13rogWKhJgZZGA0lT/o5N01cw7jzxsq0eIQkEj/Na62xqdHrb2BK9BJdTrH1ddJ88oXWA6SCQDZweP1zdf+SZNYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 008FC140280;
	Sat,  8 Aug 2026 00:54:25 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 5BA7C6000B;
	Sat,  8 Aug 2026 00:54:24 +0000 (UTC)
Date: Fri, 7 Aug 2026 20:54:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] fprobe: Simplify fprobe_remove_ips() by reusing
 existing helpers
Message-ID: <20260807205428.06b2a6ee@gandalf.local.home>
In-Reply-To: <178528139798.102586.5349128066643420018.stgit@devnote2>
References: <178528139798.102586.5349128066643420018.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: dgnarpseu9zf36r87jta6kdshacz1pd5
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 5BA7C6000B
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19v7DQTwFbOE3ALWwwqhA9bXFSDhjv9VJ0=
X-HE-Tag: 1786150464-521109
X-HE-Meta: U2FsdGVkX18Jdg9BH/Ri7OQHu9973oiWmdkXxVXCu/ayUDTOpt5rCo89YZ3Aysrg/jM5ByFcgPtHYY0Y6Ll7xPg3UyNhtB7xmDSG8w8Wjxxcz05j+BNUhVpj4rlFAo2kIviFXN1ePnyz0dzMlCgxAd/Q4H3EujO6Qy8/Q+LymJFr76LfBhjExQ5Sgsjyn8wL+q62/yQubnqy28Xf7peb2yqZq1ZrZNnBgWZPe9m3Ar9piOR4lcauSjnFIRQFNQAULtstXteSjmORxy2cRxFVdCf9amoy5t8vbbxUnT4KUukBlmCftj/Z31eusi9jOV+Th4dGcEIzDSuO3og3dDuiXEpnsD5IazIduCfeVdZ+ei2auf4LRGsEs9hV75yQtXg+INWScqoydoJBo/lYGLfc/Q==

On Wed, 29 Jul 2026 08:29:58 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> fprobe_remove_ips() manually duplicates the unregister and filter-removal
> logic for both graph and ftrace ops. Simplify it by delegating to the
> existing fprobe_graph_remove_ips() and fprobe_ftrace_remove_ips() helpers.
> 
> Assisted-by: Antigravity:gemini-3.6-flash
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---

Reviewed-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve
