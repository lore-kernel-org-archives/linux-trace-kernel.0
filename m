Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E935B15575C;
	Mon, 14 Apr 2025 20:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744664112; cv=none; b=q+1VEJLnEuG6D3aY5PB9wzySdNyKE1vtFAw/5w+rJxKb6VZAicT4ILsg31BCQV0XXxK7e484QjfLF1+uJBKbSRkA0ISlRPv+5i8UvhCqmQM5mj0q8UjmLqO0R6OAuFkX6InKsh+jPFaCPXcxwqgRAmqqK7jI7bksW6otQfh8b/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744664112; c=relaxed/simple;
	bh=3kUU8YtbjPXnwBlW+tAdT8q0eeBsQEL8ShCgumc3NDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EV3ImLkfggOTrjHUfpCGsKjnMKZWZOLd3xyaCb+sNb5101slvoL5gkjF5SwW6f0UHvxhTPsgiejF9yeQmpYHLUMHSY9cdn9ZCBcxlPsOkCYkPIbC13PsGl9CTB6f9iQEpfxwvAgu0fUYYAbp9xOCLtgAvVlFMAPwcNs5BtX8RcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=gc5iXbJ/; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gc5iXbJ/"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EF25A40E0196;
	Mon, 14 Apr 2025 20:55:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id p3Zu_QwglktO; Mon, 14 Apr 2025 20:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1744664101; bh=q5JltgrwsNhCkaAtJ0CNWLQYOy+taipMYwM8YT7rOBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gc5iXbJ/eAL1OtIY5Hl7Z5SyPKOCwZ5PGerPQ4CH6RMdeET8zZPRNSJDztPHP06eV
	 gx1cOmIXJgDTUlCEBqxh8jPpI1BhaerhWdSrwqgJv67KjblKxjpyOkLAmUaW43+NiY
	 87QadS9ky4HAjXZmEvBcDcozHUTnGFUSdyww8hSe87kEYL37dhf1+pu/bgPwDDakhW
	 tVvkF9Ke07+qywJwFnUomlSOLLc7z/cE0K5d8upiUfwTdWGdn0pquj0X/ryJy7YgOE
	 lLhrwkzTq1bfyPuf++uElbn2x0NvYtn3Pt78YE1oTACFQGYrKQh5ch8r7gcRPkMfW0
	 fAo6bPMAXEVHUOnpWW+pLMWaLkO5vMpHHcgIf7DVFU1Qe1Z5aQ5baLB0681lsWsnWc
	 Br4dtQC4flrgx6VReYOCyQnsB2QwsJYCP1Nr7pkVELCGFxcMIUYOV0DcI8Qlrf1WeK
	 IDWp5yCdA0RwgNV54Y3l9OmScTJSbCDI/lITAxbOJd0GsiY2mcWeUlfMLw/GvF4xxn
	 Ue2EzAPmpkxSmZrR/XGsg6ducs9/TtpMNeljileO7O0KH598GIUz39IbO0kzs96YBD
	 9JAjwy8Dhh+DuB3DBYzkYRk2LVj31VCwK0h7LmBKZF2UKzG6N/fK1tuaJonNwn/2jN
	 0KGszMnhikvmH6LkafDaaUBA=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D8A1F40E0200;
	Mon, 14 Apr 2025 20:54:48 +0000 (UTC)
Date: Mon, 14 Apr 2025 22:54:41 +0200
From: Borislav Petkov <bp@alien8.de>
To: Junxuan Liao <ljx@cs.wisc.edu>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] x86/tracing: introduce enter/exit tracepoint pairs for
 page faults
Message-ID: <20250414205441.GGZ_12Eew18bGcPTG0@fat_crate.local>
References: <e7d4cd81-c0a5-446c-95d2-6142d660c15b@cs.wisc.edu>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e7d4cd81-c0a5-446c-95d2-6142d660c15b@cs.wisc.edu>

On Mon, Apr 14, 2025 at 03:35:41PM -0500, Junxuan Liao wrote:
> Rename page_fault_{user,kernel} to page_fault_{user,kernel}_enter, and
> add the exit counterparts. This might be useful for measuring page fault
				  ^^^^^^^^^^^^^^^^

Well, come back when it really becomes useful.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
