Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E711F398F8B;
	Wed,  3 Dec 2025 17:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764781898; cv=none; b=UR3KE176hczFOBV4PIyYrh/Q8a6zz15Xv7ccRqM5BARPUh8u4yId5t8EMIHX/c+kLGngskweisFNzLapGyVKAJbrGpP7m29k3+l16V4VNY4SgdQsKzNWAqH6oy5m7gtpoK2FX0SpfJgmv7nq0f6IkEwkzua/BCK3sYkP0kiAd7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764781898; c=relaxed/simple;
	bh=l8vp+F65X+Mdjb6vdkPOU7mylQvhK4z+zYyRql8ouAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tRmutybK6eG2Y6tsAY8N+Kx13oQZXcr6c7imORB3iSuyxseeG4CV7YaVJ01QNL3wugJZAqkfXyyGdOzZenoej6SuU1XMdRvzBzVfUj6mVH5Q7hwlZFjkdlZw6VqMd8hsyr8rMv68Zr0Svbzs5FndmnoENNH1saJpsM/XINaqYs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UzMnciM/; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UzMnciM/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764781897; x=1796317897;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l8vp+F65X+Mdjb6vdkPOU7mylQvhK4z+zYyRql8ouAQ=;
  b=UzMnciM/VzRNOG2nqMyvPu4NQtHLlrbM6l7WGenUZE/28BASy4tcO5LU
   ONQ3kpFm+QJ/DTT8Qk2tupcTWr0Vw9sjXd0n9sJ7ljEjKyanagzuoeEHu
   MMDATmnegjB+ypPYef2TgiqE/N7DLDoQt5qr19dpNxB0xoChpvDICnbkA
   NnsrSBNpzmctr8KUzF8DG0KQ0xVZL+I5sZWUfpzwyKwxhsDHuaZ4w6aTx
   d+i/+VA/7EMFtUvdnCicst4G4ZCltsbqc/V5gqkh7piiGCwRECET6CgiS
   p2JjuE69nrn1keosAZeVRPO6nFhl9xEg7ch66TfshSVunYXdPbwep1jdk
   w==;
X-CSE-ConnectionGUID: 3+jO69TQRCKO1LAcT/3XzA==
X-CSE-MsgGUID: RE1RpsCySguHVimEBFAMKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="66506452"
X-IronPort-AV: E=Sophos;i="6.20,246,1758610800"; 
   d="scan'208";a="66506452"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 09:11:36 -0800
X-CSE-ConnectionGUID: MfZoCywgSo25HDgY4urn+Q==
X-CSE-MsgGUID: qgiGUGzeSpmiG9xX4gxRhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,246,1758610800"; 
   d="scan'208";a="198920476"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.81])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 09:11:31 -0800
Date: Wed, 3 Dec 2025 19:11:28 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
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
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Daniel Gomez <da.gomez@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] tracing: move tracing declarations from kernel.h
 to a dedicated header
Message-ID: <aTBvQDT0feiQT77z@smile.fi.intel.com>
References: <20251203162329.280182-1-yury.norov@gmail.com>
 <20251203162329.280182-5-yury.norov@gmail.com>
 <20251203121007.407eaf3d@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203121007.407eaf3d@gandalf.local.home>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Dec 03, 2025 at 12:10:07PM -0500, Steven Rostedt wrote:
> On Wed,  3 Dec 2025 11:23:25 -0500
> "Yury Norov (NVIDIA)" <yury.norov@gmail.com> wrote:
> 
> > diff --git a/include/linux/tracing.h b/include/linux/tracing.h
> > new file mode 100644
> > index 000000000000..1989e6328c59
> > --- /dev/null
> > +++ b/include/linux/tracing.h
> 
> Sorry, and I hope this isn't too much bike shedding, but I'm thinking we
> should call it trace_printk.h. It's mostly about using trace_printk() and
> other similar debugging aspects. Calling it "tracing.h" makes it sound like
> it is part of the generic tracing infrastructure.

I am fine with the proposed name, and it makes sense to me.

-- 
With Best Regards,
Andy Shevchenko


