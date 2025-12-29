Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8404E23535E;
	Mon, 29 Dec 2025 16:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767026505; cv=none; b=sCXdqDUrTfwgzgj3ERP7MQKdUJZs1jIzH8tpiZ8wTTI+IOI67jVkKjJ/2Gdn9K5tINqVSKy3ho0IFsjHXXFS/0pWzV8urdTahbMY9og+eWyjE/ZeDnKy9YCegN6+WrLqTTyXqXmmutpW6v/rAx+qA8z7pd2MKjwiJy49hFCUDv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767026505; c=relaxed/simple;
	bh=fcoV0QeqQ+GG4ebz8LT6JHQhUB85r9DPN/+bdPdWAaI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=BgxCvHyc4MaHOpGniLBvvCN/4pBMUfZ+WTmDt4wd1vCFtXlE+SXsoEIUhj96T+q6sfgxQFBF5IMWERf7VJKq2hB/ifVb8V91NlAEmo9z3hOZxrE74n+m64+ns4yBilFsZOuZ7U6Lbj4cEa+mJJluGKzFTsn1St8fiedKCSvJC3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIDPe0Hw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIDPe0Hw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E71C4CEF7;
	Mon, 29 Dec 2025 16:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767026505;
	bh=fcoV0QeqQ+GG4ebz8LT6JHQhUB85r9DPN/+bdPdWAaI=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=BIDPe0HwRNB5xB8QtYWNvfu0UyoqcIfsl5zQ05a3OTWPhdpXGd3ivMoz6kF2NDx/6
	 P9tVlWKLNp9/Cw3/fg+WDuU+W+kkDsHZuweSVmiYrlDe1ENVxzSRO5xKMYvmpKXOZe
	 +sblb1DuN7gHVp3oCu79PF58avpDtHPWfqC0hdVSPxLviLAYb6xBrSdrIvh7Eh3yve
	 w/2XkvYhGVJR0hruy0WOBclsZbZFYHw3xy+zNKIH0a56l7yDWrDWTBFkcU4jhmadP+
	 UOpXp82He2BRbNdRkQ4B4LlRA6skEUxVF9xordWGW0qHYKaXPmVQjfMFYIFXKXP7VH
	 OWCp64owuie9Q==
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Dec 2025 17:41:38 +0100
Message-Id: <DFAUM72AR4OG.1CHGTHZK2CZ4@kernel.org>
Subject: Re: [PATCH v4 7/7] kernel.h: drop trace_printk.h
Cc: "Andrew Morton" <akpm@linux-foundation.org>, "Yury Norov (NVIDIA)"
 <yury.norov@gmail.com>, "Masami Hiramatsu" <mhiramat@kernel.org>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>, "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>, "Christophe Leroy"
 <chleroy@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Ingo Molnar"
 <mingo@kernel.org>, "Jani Nikula" <jani.nikula@linux.intel.com>, "Joonas
 Lahtinen" <joonas.lahtinen@linux.intel.com>, "David Laight"
 <david.laight@runbox.com>, "Petr Pavlu" <petr.pavlu@suse.com>, "Andi Shyti"
 <andi.shyti@kernel.org>, "Rodrigo Vivi" <rodrigo.vivi@intel.com>, "Tvrtko
 Ursulin" <tursulin@ursulin.net>, "Daniel Gomez" <da.gomez@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, <linux-kernel@vger.kernel.org>,
 <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-modules@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
To: "Steven Rostedt" <rostedt@goodmis.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251225170930.1151781-1-yury.norov@gmail.com>
 <20251225170930.1151781-8-yury.norov@gmail.com>
 <20251226115848.298465d4@gandalf.local.home>
 <20251228133150.1d5731d04bc1b685b0fe81c1@linux-foundation.org>
 <20251229111748.3ba66311@gandalf.local.home>
In-Reply-To: <20251229111748.3ba66311@gandalf.local.home>

On Mon Dec 29, 2025 at 5:17 PM CET, Steven Rostedt wrote:
> It will waste a lot of kernel developers time. Go to conferences and talk
> with developers. trace_printk() is now one of the most common ways to deb=
ug
> your code. Having to add "#include <linux/trace_printk.h>" in every file
> that you use trace_printk() (and after your build fails because you forgo=
t
> to include that file **WILL** slow down kernel debugging for hundreds of
> developers! It *is* used more than printk() for debugging today. Because
> it's fast and can be used in any context (NMI, interrupt handlers, etc).

I strongly agree with this. I heavly use trace_printk() for debugging for a=
 long
time and have recommended it to dozens of people that all have been very
thankful for it -- especially when it comes to debugging race conditions on=
 a
tough timing, where a normal printk() simply "fixes" the race.

Having to include additional headers would be very painful, especially when
debugging large code bases with lots of files. For instance, one of the
components I maintain is the nouveau driver with 773 C files and 1390 files
overall.

I suppose it would be fair to argue that such codebases usually have their =
own
common header files that could be reused, but even in that case, I=E2=80=99=
d consider
the ergonomic cost too high.

- Danilo
