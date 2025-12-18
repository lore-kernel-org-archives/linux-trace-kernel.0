Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E723A1E66;
	Thu, 18 Dec 2025 21:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766093059; cv=none; b=fxt/u4UPObAjt08jS1gAX0kBCTt5FBEzzdCQVpv60fAzxE6s7eNNgSTCUT5uEr1G9HLuhZCQdilT8LB6Ed5Lv7VjGxDR9+Z1fiw/0e6Y6uV7dXnjNBRH2xd8LlcCXpTE4+IPoFYo8QhWehJHPMtkHsIDKSVOSKRGhHvel7VZb7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766093059; c=relaxed/simple;
	bh=iFfYbgmtRjgpgrAzFYyyp2p9g0mErMix04hrGKLaXIY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aCXvPwL/ExqOxe3tVfYkheXQKPtNv+xVHyulViQXsyEQlohHHElwe3gVPzXctvJbWHz/W3ZVGmi0HuGceeyAEUmJu5ZpbQ+YmDmB6yD43t9FLfyR1/yjUOHJtjww523wGeQGwG2ZmQXIHU+Kh3oubUlmTl7zphIF+iji6D28dSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 6F808B82A6;
	Thu, 18 Dec 2025 21:24:08 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 744942F;
	Thu, 18 Dec 2025 21:24:03 +0000 (UTC)
Date: Thu, 18 Dec 2025 16:25:42 -0500
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
Message-ID: <20251218162542.476009db@gandalf.local.home>
In-Reply-To: <aURlK1gpCrfLEKN9@yury>
References: <20251205175237.242022-1-yury.norov@gmail.com>
	<20251205175237.242022-5-yury.norov@gmail.com>
	<20251216161316.45b3f19ff0ad482018137189@linux-foundation.org>
	<55ceb7bf-0fe9-4edc-81c2-d51366847eec@infradead.org>
	<aUN8Hm377C5A0ILX@yury>
	<20251218123349.35339242@gandalf.local.home>
	<20251218124326.22334325@gandalf.local.home>
	<aURlK1gpCrfLEKN9@yury>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 5wwf9gob3j94aeuxi6eiyod9cjcjs5gu
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 744942F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+qadkGPvrEw+WnOGTOA3qaSmf6dajjukE=
X-HE-Tag: 1766093043-108761
X-HE-Meta: U2FsdGVkX1+Xw1uaVtgMkJj+Zet6YRpVC3/38BOj1xfE3N4PX1Nmv+XXFMI+J9u5wvpIClJspVH2v7b5HlXNj6KKyu7uhp3y/HAasEZW4kqrOU9FGz+pAWr8HgF5KcgmC3MBhGDdKWsc3fyDLxMGmOfriowcq+34XtUOEv8llhRHmwVbhdbrQjpO/+46rFPCqQFi8t0J4es7oXaHOUbOGwh6YD32UqbgzlYruriqS8H9Ws7zxaqY4jtWs7W4IPS7HZ3cCZejPOnZenb2jdtZw8F60/CUvXfDPCS10GVN+aRrjUIGfaCDvm+k/kqhwZesKGkj5Av9d/XRlSO/ab8whwEI9JxBZWFe

On Thu, 18 Dec 2025 15:33:47 -0500
Yury Norov <yury.norov@gmail.com> wrote:

> > I don't actually remember why I had __trace_puts() pass in the size. I
> > could change it to:  
> 
> This is the best approach. I'll schedule it for v4. Would you like me to
> take it as-is, or you'd send a patch?
>  

Let me send an official patch.

-- Steve
