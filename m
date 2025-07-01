Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28BE1465A1;
	Tue,  1 Jul 2025 22:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751408905; cv=none; b=YbtNhxtde+Cq83FDbcr406OhI4ZXvZnfvEmMCI2kjnvVhBsrUb0A1RPBGlbAFUVWD5o800Y8maPc2r4zgKTYhqpVWbEMcCY+oCJVaQVR24TEuFzjQErKiV6UsUKj2HY7RlAZ4MkOas3MdQtdqLoCMsc40Xf9klilVYPDSubBunE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751408905; c=relaxed/simple;
	bh=6m40uuFXuECUFjNGnHWLCNawqNvtelIL01134V3d3nY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qV7Vt4iUIhgDwr4QzNf79lTT7GNQN8gWV8Aj1BfySAtHg7nsUF0oYLI5EeLiGu7i0aeY09CGZLwlYAa4g10btWjbp4rx7v7VfblDtvniZJlAtYU3ch2vwEwIqEqr46XyaYvCP6XxV4dE+RQhcy3fUgBc3EDihkcYKg41MI2gGZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 439D11245B0;
	Tue,  1 Jul 2025 22:28:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 8141B2002D;
	Tue,  1 Jul 2025 22:28:20 +0000 (UTC)
Date: Tue, 1 Jul 2025 18:28:19 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] fgraph: Keep track of when fgraph_ops are registered or
 not
Message-ID: <20250701182819.013930b9@batman.local.home>
In-Reply-To: <20250619124517.3e6665439e1794918e83f1b6@kernel.org>
References: <20250618073117.024efb2e@gandalf.local.home>
	<20250619124517.3e6665439e1794918e83f1b6@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8141B2002D
X-Stat-Signature: nudduy5hks48ttm4hxq8oyccfc9sub9d
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX199qXpGcKeT+9wwjDFBHg9lQOTtdEz+TX8=
X-HE-Tag: 1751408900-982203
X-HE-Meta: U2FsdGVkX19SfiMwKydI+wt7xzs3tPPYx30X1243+pG16a3q7jb09ZEo8JNdzaFxyuKIAp2oH+Da/kdQUbHjz+AKU0zSe6xiFd433Q3J5TxEIX8sfU8zAreLxi5OHqJ579Tl/7MPO3u6TugvPcXjGPNEr7U9n3SjNHKuWqyceb2YCmYagFCHiyauWBpOZrGmnVT44oWFRYwEIqRS5sFC4ti44VuLs4JA3dqeo/Cx1cr52x+FsnRYjfM8Ehw/Fs9VaSLJh0WDvohTdpcSC1Snd++2++PYJxYYEKxY83ot09c46aY0EUblsO0l+wGw4AuD++GbrjakX+CX/Rpgv19SXLZ3WzQfwyJIohCBNT24ppT6bqTgReJxrg==

On Thu, 19 Jun 2025 12:45:17 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > + out:
> > +	gops->ops.flags = 0;  
> 
> Can we make it cleaning only FTRACE_OPS_FL_GRAPH flag here?
> Or, ops.flags should be set again before registering it?

At first I thought it shouldn't matter, as there shouldn't be any flags
set, but just in case, I'll just clear this one flag.

Thanks,

-- Steve
