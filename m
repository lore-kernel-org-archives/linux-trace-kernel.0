Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F392036FC;
	Thu, 10 Apr 2025 19:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744311875; cv=none; b=mtUmuBLkaqdF/RmblzrwTX+PV25DMqqGFmGhQw7NGSRVPupte/RdRibL6RQnBAVuG7VogpLuKXu5i4ppVu9uwjftEK9XJ44Ju7AHlwMo6tjxJKaEjlhfCsJP8d/hpUHvi8OyQFalnFNkuo7KzRdVttilb8uZZlOu69IzrOIpPA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744311875; c=relaxed/simple;
	bh=Yog2RfnAyRbPBuzoF8N2afa2JsSfh2SHMybzueIYiDg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kdbY+umJoghrEyWQ9DjP0aEY10SG2Jzr8+aqajq5xzkBNFibe8PPqZ94LWogpquUHiHsWBL1XdKKtCQNAE/Cu1aoXB3C3tIcbmYjOpwFpGpyNpoQaJXlzfy85Pgpk+TjH3z0Peunlc2lSx/rOu3ZikorEF21C6u3Y2djPuHykWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170C9C4CEDD;
	Thu, 10 Apr 2025 19:04:33 +0000 (UTC)
Date: Thu, 10 Apr 2025 15:05:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Junxuan Liao <ljx@cs.wisc.edu>
Cc: Frederic Weisbecker <frederic@kernel.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Interface for enabling context tracking
Message-ID: <20250410150555.7797d195@gandalf.local.home>
In-Reply-To: <9e2ac1e3-d07d-4f17-970e-6b7a5248a5bb@cs.wisc.edu>
References: <9e2ac1e3-d07d-4f17-970e-6b7a5248a5bb@cs.wisc.edu>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Apr 2025 13:51:39 -0500
Junxuan Liao <ljx@cs.wisc.edu> wrote:

> Hi all,
> 
>  From what I can tell, tracepoints context_tracking:user_enter and
> user_exit might be useful for performance analysis. e.g. Figuring out how
> much time is spent handling page faults or in system calls. However
> context tracking is by default inactive and the only way to enable it is
> to turn on nohz_full for some CPUs.
> 
> Is it a good idea to support turning on and off context tracking through
> some interface accessible from the userspace?
>

I think the best thing to do is to add trace events in all areas that enter
and exit the kernel normally (where noinstr is turned off). There's already
one for page faults on entry. It's been on my todo list to add one for page
fault exit (as I do care for how long they last.

I believe the irq vectors also have entry and exits trace events.

What else is missing?

-- Steve
