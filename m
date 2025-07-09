Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE448228C9D;
	Wed,  9 Jul 2025 19:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752087901; cv=none; b=k9B1G4IbHzfPhSVkcB46+W62wlHM27CzNFNgn1oBYsiRCb2aGkYRQXYS+WxduhPuAqfD+gWfYOnUGima46+kwXgXpHO9rgwxnjjfJCvUEcIpsdlq99sZb9sLm0daSmVk78s44vq+vv/WVpLPSo1JS9G9MKTdzfLTw2+AOeKnyXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752087901; c=relaxed/simple;
	bh=r0lOyUbpWc0rtlhYz5PnfIZ1AmjEqv5KoTd7rH9rLSk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TIrkL3XpoNVpFUgTTLnFPzwRkYjDqSc2lIdVzrBLlIRwAw+4PKmoJWznzqxNmXlAtC6duvO9cUr4qHGaeYsrX7U5LhDiAkuoVCDtzd0jMm0gdT4W79QKpss7dvtwmbUZRyl7i6NU31X1eCwPq4DxQCZXjc6m67X6qnoCMEQIueA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 4E7761A0224;
	Wed,  9 Jul 2025 19:04:56 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 1851E80012;
	Wed,  9 Jul 2025 19:04:54 +0000 (UTC)
Date: Wed, 9 Jul 2025 15:04:52 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Nam Cao <namcao@linutronix.de>
Cc: John Ogness <john.ogness@linutronix.de>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Gabriele Monaco <gmonaco@redhat.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>, Sergey
 Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v12 02/12] printk: Make vprintk_deferred() public
Message-ID: <20250709150452.6646c168@batman.local.home>
In-Reply-To: <20250709185334.uFpAU2mC@linutronix.de>
References: <cover.1752082806.git.namcao@linutronix.de>
	<25d52fcad6d1ce8f8ac262199d3e8474e029961f.1752082806.git.namcao@linutronix.de>
	<20250709144914.6ee7199b@batman.local.home>
	<20250709185334.uFpAU2mC@linutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1851E80012
X-Rspamd-Server: rspamout02
X-Stat-Signature: xkf5qr1durkkqug3hp3is8e56txxwxyo
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18lQA5kkoza9HJF80AqtAcSY7AqKgPtBts=
X-HE-Tag: 1752087894-5445
X-HE-Meta: U2FsdGVkX18CW1+bT/y1f9Xqz57uIRkzD3Np354PYqbiAvan7exEMOEeZenKpJgbdk0uIWZFgyUvnca0V0DXFZ3naqzUG+9uTamIMZpGFKbHB09dOTMYEswcBxsWUi3Uh4cZDqf4BVkdL3F+/a81hCpZf803kQJrCX9+P3n/mgkSPJdtzEvJzTi/rGdkr2H1rBabZHEdTWZbh9Umex33j+HR0W8Mw2JOLRvorL9JENxVEghRxvDnJaScMkNM4KCUf5K3aKBvI6oergydx7gwVurQ4TEwMKTV4mpMOwLBE1L50ib2y+KILKIbwPqxwMxK

On Wed, 9 Jul 2025 20:53:34 +0200
Nam Cao <namcao@linutronix.de> wrote:

> It is possible that you make this amendment when/if you apply the patch, or
> do you prefer me sending a new version?

I could do it, but if you send a new version, it will keep patchwork
automated. When I edit a patch, the status doesn't automatically get
updated due to the change.

I know it's minor, but could you send a v13? Then when the patch gets
accepted in mainline, it should automatically turn to Accept in
patchwork.

Thanks,

-- Steve
