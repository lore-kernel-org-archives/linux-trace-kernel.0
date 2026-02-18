Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D4733A9F0;
	Wed, 18 Feb 2026 15:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771429928; cv=none; b=Xzdskr1dRa/HRRRSilUGxQP8ILOUox9NcJX2eWsri448coU6SxVADYVPk4H2xE3OfehSFZeK0XeFGzSjDdDPBXXWVKjZiM6P/pXKsjoN5GQPOOmF0lacyaJ2MhD7xhIrmkcjeiyUPflHD7UjqECc1qvpiWRiKAvaxfWqDOtUW2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771429928; c=relaxed/simple;
	bh=WKAvu6RlvuF1KVdQ3QhwB0adRkAvgC6u6EuMAqehqpM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IQSlbbUPBWzPkEU1ndGMikiifiL4gekKWu8xM6NmAL7SiQsf4MnTRnGL58EYQhgLLzz+b0FbHtwhEV3bJcAtfB6PeO1jHRGUnRYPy7c7CGMc9b47Ctwvj7PEWp+Bhx/LHPEVJAI260+MNdqiy4YAUuY1G/bfGF62BMYwoLlbp9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 463BA1B4628;
	Wed, 18 Feb 2026 15:52:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 3C74220030;
	Wed, 18 Feb 2026 15:52:01 +0000 (UTC)
Date: Wed, 18 Feb 2026 10:52:04 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Elly I. Esparza" <ellyesparza8@gmail.com>,
 linux-kernel@vger.kernel.org, luto@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, Naveen N Rao <naveen@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH 1/2] x86: Prevent syscall hooking
Message-ID: <20260218105204.3af7251e@gandalf.local.home>
In-Reply-To: <0c5396b5-f084-4ade-adc9-029037031eea@intel.com>
References: <20260218144735.24307-1-ellyesparza8@gmail.com>
	<0c5396b5-f084-4ade-adc9-029037031eea@intel.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: dkydre4usgmiq8owzigtchikt93qgd76
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 3C74220030
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19lyEoQY8ggbXx0oMRFiRhUgvSgutFGIvc=
X-HE-Tag: 1771429921-422889
X-HE-Meta: U2FsdGVkX1+ufD2WDVJu2D/nA8GIDEaeOPOC/VOTbnc8TJpfgBr/++6HflqjfIWPYCW7u/fNYtsROLsWvR44OlDbMndFDigM3TmiwAus82py012qYhN4WWnNEr300qV5WmK49MBs2+7aY/sG2M1cFFcJi0/JUFKK2urVsO5ysb+faVfY+7LpuJ5FWjW/7hLcjUnOmZbnL91Dp+/50E5scrZ9FOWgHAJK9ZgRC2ap/CjhlO7gfpPoMhVUrl8Pvo9GsL/G13ZG//L3EAjX0/fO8I24jed8597LCchztOnkHW61dxjBLvXSdxqKlnS0HIcTac5YarHOnZKoDgC5lMDrjD1Nq9ide0jZ

On Wed, 18 Feb 2026 07:18:25 -0800
Dave Hansen <dave.hansen@intel.com> wrote:

> ... adding kprobes folks and Kees to cc
> 
> On 2/18/26 06:47, Elly I. Esparza wrote:
> > Kprobes can be used by rootkits to find the address of x64_sys_call(),
> > x32_sys_call() and ia32_sys_call(). This in turn allows for the rootkits
> > to find an specific syscall handler and hook it.
> > 
> > Add x64_sys_call(), x32_sys_call() and ia32_sys_call() to the kprobes
> > blacklist.  
> I'm an occasional, but not super regular kprobes user. Is this going to
> hurt folks who are legitimately probing the syscall dispatch functions?
> 
> I'm a bit worried that the rootkits will just move on to something else
> and this will become a never ending game of whack-a-mole where half the
> kernel needs NOKPROBE_SYMBOL(). ;)

Honesty, if you are worried about this, just run LOCKDOWN on tracing, and
prevent *ALL* kprobes. Because yes, there's a 1000 ways to get this
information once you have kprobes enabled and have root access. This patch
is hurting legitimate debugging of running systems more than it is limiting
rootkits from hacking the kernel.

In other words, this is causing more harm than good.

Because, I do hook these functions a lot, and this will definitely put a
cramp into my debugging of running systems if this gets applied.

noinstr has already hurt debugging NO_HZ_FULL to track when userspace goes
into the kernel. Because now it's much more difficult to trace the latency
the kernel causes a task.

-- Steve
