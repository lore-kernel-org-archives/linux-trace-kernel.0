Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B1C26A1C4;
	Wed,  9 Apr 2025 16:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744216055; cv=none; b=BY2Kjtvr9TdSIdT0da6mZg140XcC0vJxFvDLn1rfFVAIJVpbtnDvBO3yKYEGuNyTkXfAbbZ2HbJvtqTeMGyHbcNHcRMIPxbfEqT2z+o1dxk4grtPOC3EiqMrPwMjYEZvS/PH99eJ9uhE68ky6S7Ln1I+0Z3QeNuu+WniuDAuS8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744216055; c=relaxed/simple;
	bh=Y+GL7LA0QIAIS1xC03B1KxjQD58LQz5juvhWin5MPio=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=diRknS9EIFElHIkNFb2egRWtVmeihkwnewKVwo4f4dVEiMPMk3/H4FHap5cJ84sbOtK+TP+2CKwcf2PBVqYdiekYxeicF1mkXROvoILS7EIbSStXZNqd0DhflcPmc/7h5iMxYrQM6RGwF16B8Q3ItvM+xtPL4RMWhBmhdmvPuKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB568C4CEE2;
	Wed,  9 Apr 2025 16:27:33 +0000 (UTC)
Date: Wed, 9 Apr 2025 12:28:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>
Subject: Re: [PATCH] tracing: Allow the top level trace_marker to write into
 another instance
Message-ID: <20250409122853.7e5a29e6@gandalf.local.home>
In-Reply-To: <1516bba1-15ea-4b8a-ac83-e7db98b37397@efficios.com>
References: <20250408112714.403a4368@gandalf.local.home>
	<1516bba1-15ea-4b8a-ac83-e7db98b37397@efficios.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Apr 2025 12:18:22 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> > The top level instance can set this option but it can not clear it, and
> > it will bring the writing of the trace_marker back to its buffer.  
> 
> Why choose to redirect the top level trace marker from the global
> buffer to the specific one rather than allow it to iterate on a
> set of "interested" buffers ?

Hmm, interesting idea. I guess we could do it that way instead, although it
may cause a bit more overhead needing to keep track of the buffers that are
interested and also make sure they do not disappear.

I guess this could be done only in the write system call and the open
doesn't get affected. I guess the list of "interested buffers" can be
maintained by RCU, so that when a write happens, it writes to each
interested buffer via a list_for_each_entry_rcu(), under a RCU read lock so
that the buffers do not disappear when writing to them.

Masami, what do you think?

-- Steve
