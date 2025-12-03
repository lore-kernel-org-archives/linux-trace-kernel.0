Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE44338598;
	Wed,  3 Dec 2025 17:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764781980; cv=none; b=X084CvoXBJiYkBnbg1/qe2MOvQQFs7NrsL6KwEr38CD/ulufGDLBy/glWLAPACmns7a8xzv0ns5Wc97wMDxubswT9JFEGHdaUOmNNktyNnfpLqEEchd0ua1z7w/7faHtgzfhIEMytfw5PyYLW4gOxmGWrG+chUTImfG8c6T+ax4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764781980; c=relaxed/simple;
	bh=+Np+rdth2n0BXySDCBD2ekap4SNTZcCx3ChiDEozi8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXmpvLaroWJDNs2606FMFwbC20A8duJEKCRp8KKuKMe6rYtjlMKnDrX+5jHMz0p4RbangPQc0bVHIpgRVEo2OMIzMjnzvzgRZIi7xnlgNPgyMgIpFIIsFsuhlW7rCw/lBklZ09CP9WRCN9ZTGgHtvUuqcCvRncIMPR0UmdJCFpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e32CVAxJ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e32CVAxJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764781979; x=1796317979;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+Np+rdth2n0BXySDCBD2ekap4SNTZcCx3ChiDEozi8w=;
  b=e32CVAxJyveEI3Lc//vkt9JWS0HQMG6vgiR7JDun1nX6Ngn6FdPDJ8jq
   r4P4ftkQ+eqYlwCp8LKmutPfYefi+AyzYtxTT9aHzCOoAG4Tn65Tbh8aO
   p5wjrojVtSFNKmAg9qAUOC6pXo6q32HrcwCvQfUKLr2kPiyHKh+3vZa7W
   /B4CJKBtMkS9kOUjcp73/4fEqQehcUMNEQQSFfyzYvAcK+nIfb8quLiAM
   LJJ77pC5BNi0dd/BDMrM3l+z/qqnexjAAZO6kg1OF3iJHmhYS3Se74/Dr
   r4+VIKftJwL36s/K6Wr9JdmYEkYKd03DCMzybvyRrO+uZwqafyY9bFGzq
   w==;
X-CSE-ConnectionGUID: FfgjYMyXQTmFZG1WBJ4Fsg==
X-CSE-MsgGUID: fpBBJr2YQ9yQCrYJWK1vHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="69380506"
X-IronPort-AV: E=Sophos;i="6.20,246,1758610800"; 
   d="scan'208";a="69380506"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 09:12:58 -0800
X-CSE-ConnectionGUID: P+yCIrBnRmGNhQVtXETb+w==
X-CSE-MsgGUID: gazCu8PbQGC1Ktbu8bL9hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,246,1758610800"; 
   d="scan'208";a="199208118"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.81])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 09:12:49 -0800
Date: Wed, 3 Dec 2025 19:12:47 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <aTBvj8zcVKj8hBJK@smile.fi.intel.com>
References: <20251203162329.280182-1-yury.norov@gmail.com>
 <20251203162329.280182-5-yury.norov@gmail.com>
 <aTBvE_Arj16yB83I@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTBvE_Arj16yB83I@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Dec 03, 2025 at 07:10:53PM +0200, Andy Shevchenko wrote:
> On Wed, Dec 03, 2025 at 11:23:25AM -0500, Yury Norov (NVIDIA) wrote:

...

> > +#ifndef _LINUX_TRACING_H
> > +#define _LINUX_TRACING_H
> > +
> > +#include <linux/compiler_attributes.h>
> > +#include <linux/instruction_pointer.h>
> 
> + stddef.h // you use NULL
> 
> + string.h // use of strlen()

Why it should not conflict, it might be worth to research more and perhaps even
use intrinsic instead of strlen(). Just a thought spoken loudly.

> > +#include <linux/stringify.h>

-- 
With Best Regards,
Andy Shevchenko


