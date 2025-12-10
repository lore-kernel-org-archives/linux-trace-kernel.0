Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D679114A4F9;
	Wed, 10 Dec 2025 01:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765329969; cv=none; b=WIVaEmhpDeDujiZy1fsAhQeoK1GqoZgIkLQzAMgKbwYgTRq0/FPShxIQVohjXDJEGolR27LYahXjMDhpg2JgsgSFMc019tOCdkHvXw4TBsI6Ld/ig7VyhiocuUcXZktkp0OFK67f83V85VEhY4fNNB6lA4ZDM1CD+0P/0eYbwwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765329969; c=relaxed/simple;
	bh=cT+MGRexX9S417EEvbz6eG6leJnlsRPIf6J8wWNbN/w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Be7tDoLl8vaKOcXMFfGDcBTANiSfnyVWNO7e2PiQAhDAjR6nyMzX8K9+0h3PmHsDLd7rvjUU03Sw3tGMjhuYu5SXROg4ibqnXHQYJuRvJaaQ5r9ryeKQ02ksqHeFr/EaLCEPGqGF5L9dycmGs7bODU9X5BuZhWW6uts4AELG0AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 16FCF13A477;
	Wed, 10 Dec 2025 01:25:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 68B4331;
	Wed, 10 Dec 2025 01:25:56 +0000 (UTC)
Date: Tue, 9 Dec 2025 20:25:51 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: PATCH] tracing: Fix unused tracepoints when module uses only
 exported ones
Message-ID: <20251209202551.055c0f1b@fedora>
In-Reply-To: <3612840f-0c05-4797-8e75-872a306da45c@efficios.com>
References: <20251208085336.6658743c@debian>
	<3612840f-0c05-4797-8e75-872a306da45c@efficios.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 68B4331
X-Stat-Signature: feowwf83pswrpwex1qhebx8yb1p4o8ym
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+/NCx67wwgeWzfOgtSMQIdoFc/5zF1yZw=
X-HE-Tag: 1765329956-728652
X-HE-Meta: U2FsdGVkX1+VdT/G03/9qy/ILLz5/LGzWEb1/HZq7owFRsMNUo97NYv5oe1y4rP2Q6S8FYUnu0Bz4mnlLd9Sp3BLojodXWhEnfO9GiUsv160vKE/x/liKwMDMFZ2eCf4LMQA37Q8jSBY+5NMMi130h29lgc8O45Imds+Xeu0Zg+E8/0zFSSNogCpwPz6XifYvnRgdIMV9ZpNEJgfokuBIweQrBtgd6Kg/4XrY/whZ6NxPkcrD/vX2k3SHcw6fj/v6Gw8AJ97mFoJ5bG4ArPM3x63CVbiFpoGUwEp2NQ2PNcqjUuZ4/SzMSs2itVFAAGM6nF84MC19ERBt+u2HEQE0ofdmT8GX2o1fMawcfe4Z8yFNx0QGLVb1AsnC4kAVtWbsVSYKY0WdBiziiiFggwK1pvDbKofaZqpE9iij+aETfz2+oNC5Wmdkydrks2JvKd1

On Mon, 8 Dec 2025 09:22:48 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> On 2025-12-08 08:53, Steven Rostedt wrote:
> > From: Steven Rostedt <rostedt@goodmis.org>  
> 
> Missing bracket for [PATCH] in subject.
> 
> > 
> > Building the KVM intel module failed to build with UT=1:  
> 
> failed -> fails (present ?)

After the patch is applied it will be in the past ;-)
> 
> > 
> > no __tracepoint_strings in file: arch/x86/kvm/kvm-intel.o
> > make[3]: *** [/work/git/test-linux.git/scripts/Makefile.modfinal:62: arch/x86/kvm/kvm-intel.ko] Error 1
> > 
> > The reason is that the module only uses the tracepoints defined and
> > exported by the main kvm module. The tracepoint-udpate.c code fails the  
> 
> I guess you mean "tracepoint-update.c" ?

Oops

> 
> > build if a tracepoint is used, but there's no tracepoints defined. But  
> 
> tracepoint

Actually, plural is fine here. Because it means one or more here.


> 
> > this is acceptable in modules if the tracepoints is defined in the vmlinux  
> 
> tracepoint

Actually, it should stay plural (as it is more than one), but needs s/is/are/

> 
> > proper or another module and exported.
> > 
> > Do not fail to build if a tracepoint is used but no tracepoints are  
> 
> tracepoint .. is
> 

Again, plural is OK here, but the other fixes can be done.

Although I see this right after I send a pull request to Linus, but
because I'm currently at the Maintainers Summit with Linus, and I don't
need to test this to fix it, I'll set up another pull request and tell
him to take the second one.

Thanks,

-- Steve


But, because it's just a change log fix and 
