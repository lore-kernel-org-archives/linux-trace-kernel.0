Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F218670818;
	Thu, 18 Dec 2025 21:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766093980; cv=none; b=KpiAgk+CcEfVhJzyPFF69rAJpA+hacjdruUlN8XuahslRsPYFL/nI+5OW84yL86RoSriUNvcEga9ji2HIeGhm78csBUSg4/Dk3N1yrRvXw3UNZ/xQIZoRtRM2AysX9PRo30z6MbSzFOrJODcIaGfCb5UklfJTLKBFo4s9v/HiQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766093980; c=relaxed/simple;
	bh=KeWOdRFoHLXJeubeT4fUbjF/Gfpxx9FBjPbFfU0kXlo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EkJKWLP1Ehiat+iX8sBXrDhYuI3sQQYZPRiYJuoGVlftpXY6+qbdGhA6SiLEm1yUg0HVS/IYKjwuPe2v0bkX2tScYlmBuBzsSFER/qXO5Vka8uGYR/GSXvLy8l/rWVXiObnKEVr4sEUlLO30X9eMHLZiNcNt3kOzHwSNSpa709Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 4D166C0238;
	Thu, 18 Dec 2025 21:39:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 69B6920010;
	Thu, 18 Dec 2025 21:39:24 +0000 (UTC)
Date: Thu, 18 Dec 2025 16:41:03 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, Andrew Morton
 <akpm@linux-foundation.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Christophe Leroy <chleroy@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, David Laight
 <david.laight@runbox.com>, Petr Pavlu <petr.pavlu@suse.com>, Andi Shyti
 <andi.shyti@kernel.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko
 Ursulin <tursulin@ursulin.net>, Daniel Gomez <da.gomez@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 4/4] tracing: move tracing declarations from kernel.h
 to a dedicated header
Message-ID: <20251218164103.3c535de3@gandalf.local.home>
In-Reply-To: <20251218162542.476009db@gandalf.local.home>
References: <20251205175237.242022-1-yury.norov@gmail.com>
	<20251205175237.242022-5-yury.norov@gmail.com>
	<20251216161316.45b3f19ff0ad482018137189@linux-foundation.org>
	<55ceb7bf-0fe9-4edc-81c2-d51366847eec@infradead.org>
	<aUN8Hm377C5A0ILX@yury>
	<20251218123349.35339242@gandalf.local.home>
	<20251218124326.22334325@gandalf.local.home>
	<aURlK1gpCrfLEKN9@yury>
	<20251218162542.476009db@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: tucg1obnxkk3goxmuy9er1r3r36qzzsu
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 69B6920010
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18B86cGPb08cptxY3+KVwk33lWSnIPoAGY=
X-HE-Tag: 1766093964-707832
X-HE-Meta: U2FsdGVkX19EX+Z/QVvYQw9Z4xkff1tHvEmxQhnLdAzj1Rw7grjHCcRPAlzRvYJPpd2AuMDp0GHH9py6PtaqJqqOqnmtGa1tqXf8rdJ9C0PrNlROFMM/VXFYBcocNNhN4Fn2QkK/LZ+iTa0DEUez+2znCNmmlXgWKJa7Wsspl6ypqaGUUFTkf7gIUZ7//638Q3KOB/AB8nO7fcLevQWbHa5+G3bPSQLL+JjGMHCu31EhtiYauZ9Q3uQJMUqlPCrG0paHaN0sEgBotvbSFdWk8CXqOIJQybSMS/i+t0Xukwehz3UZd6ihyfAAEwp+AG3NQsb/e3wliSdoQV03CLH79rs7LvFic1lnwHwTIoMPP/UVD6hYmByEpYPbe7YLKdvgVIkObMuPt/bKW+PKuEGjdlYN4yNMXZREAh//Kf/RchI=

On Thu, 18 Dec 2025 16:25:42 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 18 Dec 2025 15:33:47 -0500
> Yury Norov <yury.norov@gmail.com> wrote:
> 
> > > I don't actually remember why I had __trace_puts() pass in the size. I
> > > could change it to:    
> > 
> > This is the best approach. I'll schedule it for v4. Would you like me to
> > take it as-is, or you'd send a patch?
> >    
> 
> Let me send an official patch.
> 

You can find it here (I Cc'd you too). Feel free to add it to your patch set.

  https://lore.kernel.org/all/20251218163739.5605f9ea@gandalf.local.home/

-- Steve
