Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B0B246BC6;
	Mon,  5 Jan 2026 20:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767643488; cv=none; b=tvuGuqTy3E2t0CoGqZu6cf8ClAf9NajVndBogsBosSisCU9MIvGD7VivaDQG0GJK+MTHoCiEW5/IQ3zKS42WdHyx6A6beZXTeCsyLoZ4Skz60sdTqJhcn9m+VWxi9t0MbX9dLVUbq4oYL6nOhml1NaBYi8RE9/oCm59EDtUFq8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767643488; c=relaxed/simple;
	bh=/zVCS2FWox6hrsmOrfaeGWD9CyVd7OTH4mU9wndmpS8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j/1pnnj2JsyghqEBeJ2GYQnrnAkX3VR7g/ScBxlvPdU4qTcs2xygJZofG2bIMh6isktnIReJU+xmiOOSSlqqgpt+w0umkGrgeixJOpsHr5NMzkftrZxT/CA/8c71mw5gypcS/pgSyKb91jppTVTxH7+GIviX3e1c5da7Y/i+Riw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 695841A9488;
	Mon,  5 Jan 2026 20:04:36 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 697E260009;
	Mon,  5 Jan 2026 20:04:31 +0000 (UTC)
Date: Mon, 5 Jan 2026 15:04:53 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Andrew Morton
 <akpm@linux-foundation.org>, Yury Norov <yury.norov@gmail.com>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Randy Dunlap <rdunlap@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, David Laight
 <david.laight@runbox.com>, Petr Pavlu <petr.pavlu@suse.com>, Andi Shyti
 <andi.shyti@kernel.org>, Vivi Rodrigo <rodrigo.vivi@intel.com>, Tvrtko
 Ursulin <tursulin@ursulin.net>, Daniel Gomez <da.gomez@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 7/7] kernel.h: drop trace_printk.h
Message-ID: <20260105150453.127927c9@gandalf.local.home>
In-Reply-To: <e171f94d-060b-448c-aab5-bafc01fea7fe@nvidia.com>
References: <20251225170930.1151781-1-yury.norov@gmail.com>
	<20251225170930.1151781-8-yury.norov@gmail.com>
	<20251226115848.298465d4@gandalf.local.home>
	<20251228133150.1d5731d04bc1b685b0fe81c1@linux-foundation.org>
	<20251229111748.3ba66311@gandalf.local.home>
	<20260103005059.GA11015@joelbox2>
	<aVkSVk2L6VH9MYGz@smile.fi.intel.com>
	<937926D0-00DC-499B-9FD8-D921C903882D@nvidia.com>
	<aVmyZ0iXzTkNU86y@smile.fi.intel.com>
	<20260105113902.6bdfcfa8@gandalf.local.home>
	<d642ef4c-145c-4b16-818d-153c8f2e3485@nvidia.com>
	<63a00906-a5c6-43de-82ce-328c8eaa7d3f@kernel.org>
	<e171f94d-060b-448c-aab5-bafc01fea7fe@nvidia.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 697E260009
X-Stat-Signature: mqe6c1hdp69dzosg5uxafmqe4phk6i8o
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX192B6yEerA1ErOTHvQIemRcasxp90OK3v8=
X-HE-Tag: 1767643471-745037
X-HE-Meta: U2FsdGVkX19/j10HauqXmj2qtPoS/VPLmpwH5wGoptlD5qvVpr1f5cJgRml0I9J0bMjB0oZqw2uZ6CQjl8EmYUScq76QFj0/u9UYfAvhZc3TX2eFLdFOAHIqQNUjBMWSAjg+U7HEKrF7okgDNXKbtZn3loWaAFKg11HgeTOXmM5WA0IponuwXBQ/YXJK3ZhYXiAF/UbbN1fAs5aGCh39KQQsWlmRgRZLSyyBYzt+KfZMuXbrnpgVERacOOn2FThBMKimJ1MVn2m6fApOuiUHk+k8gbqqNDl0VeDd9Vedougf6afTFV6G9pPkmpvzT3xMccm2hok2Uk4laE1iWav52XRAgAt8vfcv

On Mon, 5 Jan 2026 14:33:35 -0500
Joel Fernandes <joelagnelf@nvidia.com> wrote:

> >>> I'm thinking that my proposed config option is the best solution now. For
> >>> those that do not care about debugging the kernel, you enable the
> >>> "HIDE_TRACE_PRINTK" config so that your builds will be "quicker". But for
> >>> everyone else, it will not slow down their workflow when they need to debug
> >>> code.  
> >>
> >> 100% agree. We do have people running custom configs for faster builds, so this
> >> hide thing could be enabled there assuming those don't care about debug.
> >>
> >> In other words, "If it aint broke, don't fix it".  
> > 
> > But if I understand correctly, it would save 2% build time. That means 12
> > secondes on a 10 minutes build. Is it really worth it ?
> >   
> 99% of my kernel builds are usually 90 seconds. I throw a lot of cores at it and
> with ccache. I care more about trace_printk not being available than saving 2%.
> But YMMV. I am sure there are people who care a lot about build time, but for me
> it has not (yet) been a problem.

I can see Linus enabling this. I don't think he uses trace_printk() to
debug the kernel, so improving his build times may be useful.

-- Steve
