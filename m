Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97EC29CE9;
	Thu, 18 Dec 2025 17:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766079140; cv=none; b=aKUkLwVd1VG3IAsmtY8RpMRyLjhb+y0YjVppdme6FZyKijcihGgQKXoalrKxdL97CV87oH+y2/8zsvr0KA62A522BkoxCfuDCB4cw7mQefjnDmu55VGKJqY5VUA+S89uYGkcCroprXW8cRKQ93YV8cg7JlCMUy5x2unxCiYp36M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766079140; c=relaxed/simple;
	bh=cccgTe8Nws3IyH9tApyvnrXtg5pbgNdgHc6uiSZMtf8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Azbs0RYIPewcIC4Dz71dswrtFh4GoBN6S67ykyKTu9gq6O5U6ao7GnqrUdPuI5II5/hAtR6xbjlwRa7MyIvSlsBTaGMf/pd5DQdrYdFxAnpy9XXkRVkbcKzlFt+D2CoOwrOrQWMD86nISlD2IUTRQdxx5YVXI+shP013ND8ugew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id B8DBF57DCF;
	Thu, 18 Dec 2025 17:32:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id A5CBC20010;
	Thu, 18 Dec 2025 17:32:10 +0000 (UTC)
Date: Thu, 18 Dec 2025 12:33:49 -0500
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
Message-ID: <20251218123349.35339242@gandalf.local.home>
In-Reply-To: <aUN8Hm377C5A0ILX@yury>
References: <20251205175237.242022-1-yury.norov@gmail.com>
	<20251205175237.242022-5-yury.norov@gmail.com>
	<20251216161316.45b3f19ff0ad482018137189@linux-foundation.org>
	<55ceb7bf-0fe9-4edc-81c2-d51366847eec@infradead.org>
	<aUN8Hm377C5A0ILX@yury>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: hstzp6jteuufahd8q6tbcbnu46w15qog
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: A5CBC20010
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX193iJQpA7vys13S/A00XWgKxgoic14KwFA=
X-HE-Tag: 1766079130-761500
X-HE-Meta: U2FsdGVkX1+MDvlruJ4hCiAq6JyjhNVuoOt/+vTnkbslcBiVQppXeci/OrgDqKbYzMF2OqLIRn5OzKrFPJjXdCPPn385+D1s67gmpvpgMoaxesaBMAzxSmVtxhanBJ3Yx5s7XDyGfjDyBTSACg89xFOD+5lI/QFm82ei4hCrgFakIlR8FIUCuzsYjVTZJD/T2716BWYF32eM4b6OQS6B/v1pgsVJFfhZNFkX1PmbrZdi59lkqFxW7KXY2RqvP3PwdgnVokOheLDjJcRcCAh/3zq6Ry16+SXHUCwgtga7pPtvXvAMWgV97192jRHneaB6ZEpWph+zCEajWm+gfc1KRlwp/CG0UD+N

On Wed, 17 Dec 2025 22:59:33 -0500
Yury Norov <yury.norov@gmail.com> wrote:

> I deem to drop trace_printk.h from kernel.h - it is more aligned with
> the idea of unloading the header. The original motivation to keep
> trace_printk.h in kernel.h was just because a similar printk.h is living
> there. But after all, this is a purely debugging header, so no need for
> almost every C file to bear debugging stuff.

It is a big deal for debugging stuff. A lot of developers debug their code
with trace_printk(), and do the "shotgun approach", where they cut and
paste trace_printk()s all over their code in several files. Having to now add:

  #include <linux/trace_printk.h>

whenever a trace_printk() is added is going to be a big PITA and slow down
all debugging efforts.

-- Steve
