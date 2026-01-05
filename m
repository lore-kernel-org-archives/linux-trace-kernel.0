Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56512DECD2;
	Mon,  5 Jan 2026 18:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767636169; cv=none; b=NGqck6HzQm8CI64nQMO0wvTRvMJxmrPJEZpZobQBKSht26g1eUwxIlgJ2FT1XaBkRwfLMAPQQAzm8tq+e1rLmLiV4z8m5RIE+/tYG8WYo+N31sf3ZE4AFyTmBfzzVKzjc6ZcGf4QKBYPI7OlXPcw4QQx5A+jjd2k6EnzhyR01BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767636169; c=relaxed/simple;
	bh=xzQ8MUiL4/i58dgc2OFqW8yINRnyW/ofpF9LycfoB+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PiO/fFZXpNrVGPeT+Pav1dpEwiuY01WEtmhfkIfOXHfBkcAAg25ePUz8uh9WbImlJBDsRYhmi5icb1gT1X265ABFB/cbbR85FfIF9FsGX2IqvlEt7+fbM0Ik7OvZHJ2pFOiRLr7K8kL3LpA8ga1fxw1/I5aIMAqweW5iG6zLX7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tn8YePyT; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tn8YePyT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767636168; x=1799172168;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xzQ8MUiL4/i58dgc2OFqW8yINRnyW/ofpF9LycfoB+A=;
  b=Tn8YePyTkgU4zGR9f4/wmpgzgUp04o03Limf0U79CYohCFLSIaEZ8WWr
   IiKBtPQi37xVc/iqgi+jNS6Zotz7Db6Q0K+srGJkcVHBMvmnFwTRZNQNS
   fn5z5ybEOkv7N/+v3sbmkTDb1FnBG1lmmjhHFJBixWjEjmfhMpvpus7GY
   cmDqX7B1waxSLZ3q4946yBAUzjAfSc0nAoGE3zRp/fKiJKSuGHI9Rqy1J
   SuiHiP5wSR8glA9IDQyuTSqN6znc3pstZH819Q+8o0C/MPL1r39oJnUkl
   Im64/g4JtEOpL4tJ130QIsgliBQqFLAq6C3nQYod4kIzKGMlVex69YCcp
   Q==;
X-CSE-ConnectionGUID: BWw7k9fbRgyp+wh70FscRA==
X-CSE-MsgGUID: 3SN/oTmLTAy2SrItLAlQzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="91656770"
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; 
   d="scan'208";a="91656770"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 10:02:47 -0800
X-CSE-ConnectionGUID: /TjlNcLXSdy8SIKayOYZSQ==
X-CSE-MsgGUID: XkFOy6bMRhmkEcHEuTh5lg==
X-ExtLoop1: 1
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.215])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 10:02:41 -0800
Date: Mon, 5 Jan 2026 20:02:39 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yury Norov <yury.norov@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	David Laight <david.laight@runbox.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Vivi Rodrigo <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Daniel Gomez <da.gomez@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 7/7] kernel.h: drop trace_printk.h
Message-ID: <aVv8vwtGFhssitxG@smile.fi.intel.com>
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
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105113902.6bdfcfa8@gandalf.local.home>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 05, 2026 at 11:39:02AM -0500, Steven Rostedt wrote:
> On Sun, 4 Jan 2026 02:20:55 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > > I do not think it is necessary to move it.  
> > 
> > I'm not talking about move, I'm talking about the C 101 thingy. Any custom API
> > should be included before use, otherwise compiler won't see it. Which header do
> > you want to include to have this API being provided? Note, it's really bad
> > situation right now with the header to be included implicitly via non-obvious
> > or obscure path. The discussion moved as far as I see it towards the finding a
> > good place for the trace_printk.h.
> 
> It's not a normal API. It's for debugging the kernel. Thus it should be
> available everywhere without having to add a header. Hence, the best place
> to include trace_printk.h, is in kernel.h.

With the above it sounds like you rather want to see it being included as
kconfig.h (to every single file). But I disagree on that approach, why do
we need this header to pollute every file even if I do not debug the thing?

But since the current state is kernel.h, the status quo is to keep it there
for now.

> I'm thinking that my proposed config option is the best solution now. For
> those that do not care about debugging the kernel, you enable the
> "HIDE_TRACE_PRINTK" config so that your builds will be "quicker". But for
> everyone else, it will not slow down their workflow when they need to debug
> code.

Maybe, to keep a status quo.

Seems for now the compromise is to have it split and be included back to
kernel.h and later we can decide if the option or other variants can give a
better granularity for people who are not lazy to remember and add a header if
they need to debug stuff.

Yury, I think in v5 you need to drop this patch, otherwise we won't move further.

-- 
With Best Regards,
Andy Shevchenko


