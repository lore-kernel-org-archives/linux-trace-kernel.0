Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A24522FE0F;
	Mon, 30 Jun 2025 23:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751327933; cv=none; b=namP88O8+bWL4fPAlzu/aumvZrVW8MFVi9QGxFfy/5z+0/WquTLWfZ8ICJ7g0DmVqJuLdJn+ooZ9SfZxjYfx9r+WhKEwagcqBJ0C69c1g8Bv4aUi5v3Rn5e3Y1kTtRkXc++kVTE2c0E3L0o1hoDvd9lT1aXhxgmg8ujnxIhbDIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751327933; c=relaxed/simple;
	bh=EFKWwAsqHtgNNC7H7vLCiaxTi/dl8QrR7K3iRlbLFLM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nE/BrP9h5OiVhx8WeRbvPRFwEOqRRsPwDKOKoJWVzF8ReVzrezZNpkT5mjNFEzUomYPFdwn/F+G/R8m7bD7D21j+oB7jetknJ3eSsuQ8075XfEBQzrWpu4EIkToY/20OpffPbzZr3TaGKI9/V8KxbclOYZ+T2b4AsElrq3uJoLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id D67AB1223F0;
	Mon, 30 Jun 2025 23:58:42 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 23C0020024;
	Mon, 30 Jun 2025 23:58:41 +0000 (UTC)
Date: Mon, 30 Jun 2025 19:59:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Gabriele Monaco <gmonaco@redhat.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 john.ogness@linutronix.de
Subject: Re: [PATCH v10 16/19] rv: Add rtapp_pagefault monitor
Message-ID: <20250630195917.71ee42de@gandalf.local.home>
In-Reply-To: <9abb399b0d941cb034211b2201fb1a90d976f4ec.1749547399.git.namcao@linutronix.de>
References: <cover.1749547399.git.namcao@linutronix.de>
	<9abb399b0d941cb034211b2201fb1a90d976f4ec.1749547399.git.namcao@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: sftt7soxw9oi4juygwoqu7we7jruu8x6
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 23C0020024
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/j175ivwz98ldK3xHtd+pXFRiyHnzW3mM=
X-HE-Tag: 1751327921-268915
X-HE-Meta: U2FsdGVkX1+A/5sxdzsQaqsrQ7huA7gxIPRwEaDNLq/jSaDu7yOhiC5hVP7nPf+bKIPhU8IksUvo1sGV9yam/z/NkDd5hZ/UbP2DhWyhWfi7l7dDsrgj6cRvFAoAu/8XPjEWxRY4eAxzH3g/Y0dFxfMTLg577K7CaDXZEsHJYOEcB4CX/qf4NUbvDf7vlJ0MCYZ972FcKLzmt7pospYXmKfPzZPO/6wbJXXQGS7589o+8MWCYBu0VzvN+uOw+JI0YG7IbUKGjdoFDiAr6FKex1T/+YH8Rj3o3iTLpKKhp36MkKxRFcvKHJ9sNasFHc+/

On Tue, 10 Jun 2025 11:43:41 +0200
Nam Cao <namcao@linutronix.de> wrote:

> +static void ltl_atoms_fetch(struct task_struct *task, struct ltl_monitor *mon)
> +{
> +	/*
> +	 * This includes "actual" real-time tasks and also PI-boosted tasks. A task being PI-boosted
> +	 * means it is blocking an "actual" real-task, therefore it should also obey the monitor's

Let's keep the comments below 80 columns.

Thanks,

-- Steve

> +	 * rule, otherwise the "actual" real-task may be delayed.
> +	 */
> +	ltl_atom_set(mon, LTL_RT, rt_or_dl_task(task));
> +}
> +
