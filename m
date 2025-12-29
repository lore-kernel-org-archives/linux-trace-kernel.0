Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A3423D2B2;
	Mon, 29 Dec 2025 17:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767028818; cv=none; b=rTAKhX5imbwKx2g5aCLNHgeVkRz44paj97QITFxA4L8o/ffhlOeF+piEI2DKxjgXM46pf6GAubOOcLIaspPu2onvIeean0Zg+JRJiuSnZjcN/02zSHUcNYCfgJEdPhL3Sq7cV+v69bSu59BQ4yO4XsRfZgZn6w9od2XHl2IcoMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767028818; c=relaxed/simple;
	bh=/qrNbEbjFc9NdLyVqOrV5H0AlMj7b/V+ptpRGyqcQXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8r599UzGVxxlGcD8y+FLrHnnhwbOoojHDQf0PO4lZiG7GXqVrEoTRQq2gRK85nk/PXcSEhDJaG+b/TA5SS0WRQBwYQtSQhTdtRUqe4/XL2+bD/ZXFO/lcFN8aQT2Mp4+MXQUJ0LkS0rmamzmo41cmxYmD065XP7Yry/m+E895M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Hf4UYv3k; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Hf4UYv3k"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 700B340E0140;
	Mon, 29 Dec 2025 17:20:10 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id NsfawIvqeB37; Mon, 29 Dec 2025 17:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1767028804; bh=wTpw5X0jkCJFQekDC0i+aMLcse9YU/tWDQEWS+Bf48U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hf4UYv3kaB9sD0JRw/+OnQnNZPNr0uULUayFeYqM6gONEArXNfIURfcUhq+wqrkNB
	 Cyg3F949oCK8dfkffw7lU1zHOPJrrbAjF7wbCXFMPWCNy4PEiPkuxmemet+DVHYogt
	 ysL11maghgY7Azr6xPmbcWFevaYbS2Z0LEr/W5F2z1AhEXpcsX7YMbdB4DJwMJZ1St
	 4pVgKbzQEpKztKQe9VLK6gjlwN6sDdcNRkKK3xzcsbPLzeIfOuG0i9jPXvXKsAxj5V
	 uM+vR1tjHJDez0UX+BirkhBGSNSorJ7daHwkuXISG54akH89jXnQtPzgUHhV0B4JHd
	 2LY7okjh45FhlRMkTGEgtZyQkoHmzghx85T9y00fK3ibD2QBigv1qKaTUuaXTOTo97
	 4c/Di4EeuXJFvyb11Edx73UJGvhtDSEK9HDxbiIYKcdvJiVZg4aYQZyHv3l1wArWaa
	 iz4djPPD7kQDepu3DyZlOxAnKdGEmTBu2fQm9weJaYyEoY4GUAHT4eyrZO36De7HY9
	 6CZbw6bGU4OVbVlij9OffabH/t4GvAR23YcqOu9aJz/Muo0bOsluwjEzrybdMdQwgb
	 oqFTY/y2O9iIUS7HZIkvYn/8bhUiYJ9lJoZpMO9C5wLf9m2GdRqFaWPR+lPXYs2tra
	 fhaUTxP4EvmSf8Yqamq2M/ME=
Received: from zn.tnic (pd953023b.dip0.t-ipconnect.de [217.83.2.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 1812840E00DA;
	Mon, 29 Dec 2025 17:19:39 +0000 (UTC)
Date: Mon, 29 Dec 2025 18:19:29 +0100
From: Borislav Petkov <bp@alien8.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	David Laight <david.laight@runbox.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Daniel Gomez <da.gomez@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 7/7] kernel.h: drop trace_printk.h
Message-ID: <20251229171929.GAaVK4IX5Wxq3rRf0Z@fat_crate.local>
References: <20251225170930.1151781-1-yury.norov@gmail.com>
 <20251225170930.1151781-8-yury.norov@gmail.com>
 <20251226115848.298465d4@gandalf.local.home>
 <20251228133150.1d5731d04bc1b685b0fe81c1@linux-foundation.org>
 <20251229111748.3ba66311@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251229111748.3ba66311@gandalf.local.home>

On Mon, Dec 29, 2025 at 11:17:48AM -0500, Steven Rostedt wrote:
> But sure, if you want to save the few minutes that is added to "make
> allyesconfig"

Nah, it is

"Removing trace_printk.h saves 1.5-2% of compilation time on my
Ubuntu-derived x86_64/localyesconfig"

which is:

  localyesconfig  - Update current config converting local mods to core

and which makes me wonder - who does that?

What are we actually optimizing here?

And 1-2% at that.

I don't see how this outweighs the goodness of using trace_printk()
everywhere.

So that's a NO on that patch from me too.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
