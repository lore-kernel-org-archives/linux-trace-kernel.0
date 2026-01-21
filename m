Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1EC30EF8E;
	Wed, 21 Jan 2026 14:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769007224; cv=none; b=n8i7j7GgdgSqQdE2BsM9chNEnL4D7xdeIQlj7TetcSaZDWFFqqDCDp8cYF8jHdrwCNHgnWmeU9FrCDpvTSyY3CRS5lQrsaUafpA91Cv3o8UJi/NSLXmLDP/grgCD+H2UvHW1uJOV5Zb949rZ7He6669eBmJO2sJrVy2ccdnw44A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769007224; c=relaxed/simple;
	bh=rGnr3IaClsAviexlx2psE8oibYD3ZJKjpZ+iDoFLnxg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DgGHfwXPrbwr0pa4Oyw3918vyBC0DXEZfJaCQK6Io7I/PRjD5kwElgRE1AokZWxLN8tV6WgKeaaQNX2TmF6AWKBYqlfLFx+CDRxLyYVlteC+7SEXOe3VR0XqxdX5/Lwoxfcp0Zax3sjlsg57DmNzazPMUXdiXZuira/448+eEU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id AF48513B056;
	Wed, 21 Jan 2026 14:53:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 753B320012;
	Wed, 21 Jan 2026 14:53:33 +0000 (UTC)
Date: Wed, 21 Jan 2026 09:53:56 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Yury Norov <ynorov@nvidia.com>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Christophe Leroy <chleroy@kernel.org>, Randy Dunlap
 <rdunlap@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jani Nikula
 <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, David Laight <david.laight@runbox.com>,
 Petr Pavlu <petr.pavlu@suse.com>, Andi Shyti <andi.shyti@kernel.org>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, Daniel Gomez <da.gomez@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Joel Fernandes
 <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org, "Yury
 Norov (NVIDIA)" <yury.norov@gmail.com>
Subject: Re: [PATCH v5 0/6] Unload linux/kernel.h
Message-ID: <20260121095356.5b90b1ad@gandalf.local.home>
In-Reply-To: <aWpwHbrvQ2MMGgH-@yury>
References: <20260116042510.241009-1-ynorov@nvidia.com>
	<aWoVRlm1GFux-Z-9@smile.fi.intel.com>
	<aWpwHbrvQ2MMGgH-@yury>
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
X-Rspamd-Queue-Id: 753B320012
X-Stat-Signature: 7hndaqh4hbjwzuwg6rf9q9e8akwt1g1d
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+CBSYa8KCvUhwdLmHjFWraz0AOAVFSDEI=
X-HE-Tag: 1769007213-216120
X-HE-Meta: U2FsdGVkX1/EE2lFftZ6F21i0EqRoDcSVTjbX2oqW5/7OP38ayT8yTN4YkVkKSQf0zMYGzeBHy8gpS5qYvvt9xlAuOqkBmGcCmTJG7MTudhVj+V2SrKmaaxzuz5NcKCHxlf4JFeEv0BDDHQxUNEisro+vEDfU7EuSiyw+D1AWo+4ZwH877vmvdOCb4/O9u22SXDVzqDAzj2YYfKJsuEdXY/wKY0wMaBevSDCPebyFZbe4tpdledMCmT4+0Sb+1kP/zs7I6IT0gSVEJCU/DrLz1WZbU/FlBWhcLAsHDYNNgVw+/2V3uSuUrS3rt3tr8D4Yw1bNVwqox2qF4QdbVswXbpuSis4mK2ScucIIDTJQELTzYLFMk03sg==

On Fri, 16 Jan 2026 12:06:37 -0500
Yury Norov <ynorov@nvidia.com> wrote:

> > Thanks! Which tree should it go through?  
> 
> Andrew or Steven maybe? As a last resort, I can move it myself.

I think it makes the most sense for Andrew to take it.

Thanks,

-- Steve
