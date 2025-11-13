Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E1728504F;
	Thu, 13 Nov 2025 02:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762999847; cv=none; b=FQIOoZRROCAntKyN7xnTbQy0G5YxpH5UYNM2h0i8Mc/0ZV/fp0NIOrpNCdeyL/0sN+gIwWCJN3tZqSBr2Hn2TYoE9j4vWiM8EafXy8keA/e0059xFYiJfqud3sDBlZeDBkmldG9o2bi0QuJtEkGwm1WAmqjz+/WV3uv+6gCa8eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762999847; c=relaxed/simple;
	bh=VBrEopDNIBwQYsx4i37s+SDCIK7dIUbD4bEkZf+eZdM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mtS1RjtIDQyUvDCjYITc75M00FLL61wTKXuulFLyAP1anZO1POYft73hRmXZYxGRszyGixnWldU9CGCnspmi8dSbxSN4IwtfxB9Tqn/upGZMy834VzM9jvuFSAmE48dzFJNgHNtxAJaTnPohxnBXWsaduTKNRrTdjdDlVvwowUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id F35D41A073E;
	Thu, 13 Nov 2025 02:02:25 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 1A46920026;
	Thu, 13 Nov 2025 02:02:24 +0000 (UTC)
Date: Wed, 12 Nov 2025 21:02:36 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Donglin
 Peng <pengdonglin@xiaomi.com>, Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v3 RESEND] function_graph: Enable funcgraph-args and
 funcgraph-retaddr to work simultaneously
Message-ID: <20251112210236.07deb6b2@gandalf.local.home>
In-Reply-To: <CAErzpmt8Dsq3f6ZUvtmc25hvy0NH6uRxBHPSxeZhkFfzkdJ04g@mail.gmail.com>
References: <20251112034333.2901601-1-dolinux.peng@gmail.com>
	<CAErzpms8oRkqJhxk1R6LMUq1GeZT3TqkPOm2yRAfY1ph_F2YNw@mail.gmail.com>
	<20251112103804.4a43591a@gandalf.local.home>
	<CAErzpmt8Dsq3f6ZUvtmc25hvy0NH6uRxBHPSxeZhkFfzkdJ04g@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: n5j36kx71zgrie3i81w33y4b3tu8athy
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 1A46920026
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19E6X09XA3WmabYEla670Mw8y/Ncr+0Y1s=
X-HE-Tag: 1762999344-863275
X-HE-Meta: U2FsdGVkX18UtEhs58ZhZSIXNCOA3Ru+WiqzVvBpnNuCCjYIlGWVNAoMQa8ouFKOG56hZDNWeGHwm1oDpSUiMydkFmea6WchGKTY7D9uXwuc5FyjieB2Ac4ibi6voJoZB4BY9Fj2WQ2yhH3uZyD1fwghCdRf4dndmqTEQoNdy8NEKL/QK8mGK1d8k6irjqsb1Cz3sI9ifibaJXX+T46zP+tbi6NCVyH11XgQlfk0ucnvKt/jBibUvlifSUaVMRhoxb7fNrak7m+6jb9cJDLa5+hKCxrs7+XHXY2UDt60j0fL+lGXKT21ldpT+y3GysgqFzn7AtqI7EXPUfAlp8g0NNE5xkYyZ1Mr

On Thu, 13 Nov 2025 09:48:52 +0800
Donglin Peng <dolinux.peng@gmail.com> wrote:

> I noticed that when funcgraph-args is enabled, it registers
> trace_graph_entry_args
> to replace trace_graph_entry. The only difference is whether a valid
> fregs pointer
> is passed.
> 
> To reduce overhead, I propose consolidating the two entry functions. We could
> maintain only trace_graph_entry and pass the fregs parameter to graph_entry.
> Within __graph_entry, we can then conditionally record arguments based on
> 'TRACE_GRAPH_ARGS && !!fregs'.

What overhead are you reducing?  Why add a branch statement in a critical path?

The graph_entry() should not be looking at the flags argument. It's called
by *every function*. Also note, I recently fixed the flags to be per
instance and not global. Which means testing the flags would require
indirection lookups.

-- Steve
