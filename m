Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7006F2F1FE7;
	Mon,  5 Jan 2026 16:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767631133; cv=none; b=a0YJTa1/0gQjozUcRo4dYpNpfAw8F0vqSS21X+yVgDnizhbhbc5A9d75IdK7480CnClDdZZnXIXlkffyHpbpNcdB83X4auf1toZa3zINMCV6bo3wN61Y4JGNFOalyTSHsXSNJB9zrukgdtquuXKeTduCQXDEl6F6+otKNAKGTY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767631133; c=relaxed/simple;
	bh=wXbadJNSWlxQN7elyxY2q066pwk9XzvuoBl2RZaKjuM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cq5ezmyL5BG0HJArEV1yAAoXUjYvnTmZ/bf8l71JYmsdLsBhmg5kMan7/LxsSrMBToBhg13AiyRtxJCKgWm+hdEfIgMwJ72pmlyI5aliWna0ih9hpdGJqIfdp0kFcOWsFpNDrvRk98Opfku9+aGd1fQ0KJRDYaPEfipp8lMr5tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 3DBD91401F4;
	Mon,  5 Jan 2026 16:38:45 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 332146000F;
	Mon,  5 Jan 2026 16:38:40 +0000 (UTC)
Date: Mon, 5 Jan 2026 11:39:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, Andrew Morton
 <akpm@linux-foundation.org>, Yury Norov <yury.norov@gmail.com>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Christophe Leroy <chleroy@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jani
 Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, David Laight <david.laight@runbox.com>,
 Petr Pavlu <petr.pavlu@suse.com>, Andi Shyti <andi.shyti@kernel.org>, Vivi
 Rodrigo <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Daniel Gomez <da.gomez@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "intel-gfx@lists.freedesktop.org"
 <intel-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-modules@vger.kernel.org"
 <linux-modules@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 7/7] kernel.h: drop trace_printk.h
Message-ID: <20260105113902.6bdfcfa8@gandalf.local.home>
In-Reply-To: <aVmyZ0iXzTkNU86y@smile.fi.intel.com>
References: <20251225170930.1151781-1-yury.norov@gmail.com>
	<20251225170930.1151781-8-yury.norov@gmail.com>
	<20251226115848.298465d4@gandalf.local.home>
	<20251228133150.1d5731d04bc1b685b0fe81c1@linux-foundation.org>
	<20251229111748.3ba66311@gandalf.local.home>
	<20260103005059.GA11015@joelbox2>
	<aVkSVk2L6VH9MYGz@smile.fi.intel.com>
	<937926D0-00DC-499B-9FD8-D921C903882D@nvidia.com>
	<aVmyZ0iXzTkNU86y@smile.fi.intel.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 332146000F
X-Stat-Signature: hxafjg4ncmsykt4dmwkuqhja4ftxwj3q
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX199ZWLWJbelqoMLbQ2B2b7gz7EOu9A69rc=
X-HE-Tag: 1767631120-776187
X-HE-Meta: U2FsdGVkX18TUKraAk9eDUTCBhjaAdWPFKNooHz+bfcqdqTcVxbKlaESTN1xHRIB6bXyrScasXjrWy/3tM0ZrDxQAGqCLVLwVKm57gBsEwoFaSvbPuFa6ZF8p7ypWmVVtEWieJ8iVXsWD8ppbKOLCHHgXRfQ9b66RDkuS+8eywo/mwhrWIWOkEjGSMxpYfhS2nRw+EBRkEfuP7BPrD741gQX5GUPCRv7D+Pp6rItqZxb74QWi4UN23XLFzBZIQRSFV7Pg0YPuoCqqJaJ+BLy9AgN/m9GtU1Y9fq/d0BeFZJIPKrjt5fce/GLegTG7kC3mQkO8pLLW+MOKZ/tPWybZKagezHVMnXP

On Sun, 4 Jan 2026 02:20:55 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> > 
> > I do not think it is necessary to move it.  
> 
> I'm not talking about move, I'm talking about the C 101 thingy. Any custom API
> should be included before use, otherwise compiler won't see it. Which header do
> you want to include to have this API being provided? Note, it's really bad
> situation right now with the header to be included implicitly via non-obvious
> or obscure path. The discussion moved as far as I see it towards the finding a
> good place for the trace_printk.h.

It's not a normal API. It's for debugging the kernel. Thus it should be
available everywhere without having to add a header. Hence, the best place
to include trace_printk.h, is in kernel.h.

I'm thinking that my proposed config option is the best solution now. For
those that do not care about debugging the kernel, you enable the
"HIDE_TRACE_PRINTK" config so that your builds will be "quicker". But for
everyone else, it will not slow down their workflow when they need to debug
code.

-- Steve
