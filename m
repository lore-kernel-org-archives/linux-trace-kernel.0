Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DE821E098;
	Sun, 30 Nov 2025 20:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764535022; cv=none; b=gVeJvMdgVCifmvYZckYtwfKA6fByXv33x9r7f9ywsSY80yQ6aTisKh0kfg90weekOeclF7hFSNxr1dfJufB938aCMGsveidqzW1IuJJ1zjA+KLgSzmXLnfwIDIKZvKmq4teYQMpthOb20UI6T554sosGugKYngc6TvdEJVK/vUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764535022; c=relaxed/simple;
	bh=yR97Y+XU1RC+xYvEtdyYRH9LYkU935Agtji3Ul23Wq4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mn3ExM3Ox2hSMXMXPpX9G32AuVxhTuenzQK218wsEGd545y4xMrkK3TPTant63M9MWt26W3NcgLy3StEZcwODH6yOd9UU/pAlilyZB2SHME+25j7YjsWL7TcAzwWQ6WDQGC6QNu8rgsiA+H8KFKEJxUkm7d3n5vRmtWI4gO3yaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 5F44D885EE;
	Sun, 30 Nov 2025 20:36:52 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id D93152002E;
	Sun, 30 Nov 2025 20:36:47 +0000 (UTC)
Date: Sun, 30 Nov 2025 15:36:46 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Yury Norov <yury.norov@gmail.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Randy Dunlap <rdunlap@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jani
 Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] tracing: move tracing declarations from kernel.h to
 a dedicated header
Message-ID: <20251130153646.37c0f206@robin>
In-Reply-To: <aSyertuRRX9Czvyz@smile.fi.intel.com>
References: <20251129195304.204082-1-yury.norov@gmail.com>
	<20251129195304.204082-4-yury.norov@gmail.com>
	<aStX3242e3mo5H05@smile.fi.intel.com>
	<aSyJ83v7EEAPHXeU@yury>
	<aSyertuRRX9Czvyz@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: D93152002E
X-Stat-Signature: emoy5i7jyturr38iswa7m8iegunpfw4y
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19VbNQ8aaUl89ew+dcEFHzm3JZ+fR+fLt0=
X-HE-Tag: 1764535007-409658
X-HE-Meta: U2FsdGVkX1+mHN6v5qz698KSTLFJ4ss46awhzMue1opGr3sX3KNrOdJ3ETfjwJ0xNflGGEq7OgoBZdGyMwRG6C6iaV4ze0Jzty/JptVlt2S2HFbM7oSa0ErI73HYvbbXSWoo7MgdOQ8T2jL5dCkLXTHvE7ZV+Ex4pk+cJhRs+1Tbov99LCHBd7rChvXhFfvnUODQwadfLYVFS3fvLMBk9BkPMm+KXgUY+TpGjE40GuAqJZRCpKaSoYrp9iCG/ZMz6D5s1xp9Ml7QdIJWMAezHX008pc9EIqJEUkuSjgk6ypsvu5OrjVfRFd3bwMb/deirlj9HboFRsEmuxjpfkeKB4BQhHxVpkcF

On Sun, 30 Nov 2025 21:44:46 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sun, Nov 30, 2025 at 01:16:19PM -0500, Yury Norov wrote:
> > On Sat, Nov 29, 2025 at 10:30:23PM +0200, Andy Shevchenko wrote:  
> > > On Sat, Nov 29, 2025 at 02:53:02PM -0500, Yury Norov (NVIDIA) wrote:  
> > > > Tracing is a half of the kernel.h in terms of LOCs, although it's a
> > > > self-consistent part. Move it to a separate header.
> > > > 
> > > > This is a pure move, except for removing a few 'extern's.  
> > > 
> > > Yeah, I also have something similar (but half-baked) locally, the Q I wanted to
> > > ask is why a separate header? We have already some of tracing headers. Doesn't
> > > suit well?  
> > 
> > Just as said in the commit message - this part is more or less
> > self-consistent and debugging-oriented. If someone needs to just
> > throw trace_printk() in their driver, they will not have to pull
> > all the heavy tracing machinery.  
> 
> Please, add a summary of this to it. It will be much clearer and based on it
> I agree with your judgement.

Agreed. Please update the change log stating that the tracing code in
kernel.h is only used for quick debugging purposes and is not used for
the normal tracing utilities.

-- Steve
