Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8D02AD2C;
	Wed,  3 Dec 2025 17:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764781756; cv=none; b=pxuW6SoiuMp9UXpfGD5On8jsnj8WjE6ILIS71m0l1iTYyKchKEp9zgrfF96iZ+3ZT38KUiIdLGqqdraRCebd2MZXiYLYdtCbzA9vmfeRQiFJ1qpDyuG9vnejwUGaI15xn9D2Gvj7ndupKkL9jkOTbr+87fQTLKmcVPa7s2XrEK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764781756; c=relaxed/simple;
	bh=XpLk8sXJQhyXdXDDTd7njG2fLJJtRfpoEiyEWsc7Xx8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wq8mc2MFfDMFop0Gcng/Cfwo6I/tuhsRodmWljilrjFkK7e6WKnvexRzSaemGixCQsKRBKIfoIZA4kwxukXniv1I2quCRre+48GqGB75EiQwHUarZZcgY1FPeZN0XdrVQKP9DhmGxLzMSYlhDlOkAu3Ifhg8LRnfaXriw5hK6OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 72462140519;
	Wed,  3 Dec 2025 17:09:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 93E4018;
	Wed,  3 Dec 2025 17:09:05 +0000 (UTC)
Date: Wed, 3 Dec 2025 12:10:07 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Christophe Leroy <chleroy@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jani
 Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, David Laight <david.laight@runbox.com>,
 Petr Pavlu <petr.pavlu@suse.com>, Andi Shyti <andi.shyti@kernel.org>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, Daniel Gomez <da.gomez@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] tracing: move tracing declarations from kernel.h
 to a dedicated header
Message-ID: <20251203121007.407eaf3d@gandalf.local.home>
In-Reply-To: <20251203162329.280182-5-yury.norov@gmail.com>
References: <20251203162329.280182-1-yury.norov@gmail.com>
	<20251203162329.280182-5-yury.norov@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: bfoxbzpxzdq8jon7akde1scnztbu78sk
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 93E4018
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19gXV7TQ6NhwQAK7ZtvT2NLFhQv7LzULPg=
X-HE-Tag: 1764781745-34022
X-HE-Meta: U2FsdGVkX1/kCbKazY8VszPJ7JXODZoJOgsY2CVbAQx2K4CPT10Ax1IrQrugEMEC2ImEfsZztkwf08BEUgTbXiPI5kx+vafN5UNeHQqv5I6aeXYJK5gDjL5HigBnvFI6Dkv2c8BysEKh/KTwwVdWVLVqXi3YuJ8kemXDMOfD7+DoTB2RwrK8if702kKeq9nCTTwmpZhRlCJfxk5yXbJ0ItDMiIdyjzpQmANDGYhC0cjkMSGaWmLzNpnRs5plTZn0OFShzG0Wvs9VUKw6A4+oRpCgamo0MLlRzCSgIGI05I37SvlHzZNRJO7MvJmrzdxz055uFeAt5frZQFaCTrLlIqWYDrw6PwRG

On Wed,  3 Dec 2025 11:23:25 -0500
"Yury Norov (NVIDIA)" <yury.norov@gmail.com> wrote:

> diff --git a/include/linux/tracing.h b/include/linux/tracing.h
> new file mode 100644
> index 000000000000..1989e6328c59
> --- /dev/null
> +++ b/include/linux/tracing.h

Sorry, and I hope this isn't too much bike shedding, but I'm thinking we
should call it trace_printk.h. It's mostly about using trace_printk() and
other similar debugging aspects. Calling it "tracing.h" makes it sound like
it is part of the generic tracing infrastructure.

Thanks,

-- Steve
