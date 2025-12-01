Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0353E21D3C5;
	Mon,  1 Dec 2025 20:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764619271; cv=none; b=dm41oFQQLgoAVTsosUKqSmfbh17C2w0ilBJXjbLxvH6IhiO5KHlv9N4P9AS63lqqOsk66sYBCcyNaqiS9VRaTyKA81lGyBAEpmNzi4wQ3rFYaB/u5zSiB8dce7o8fv6Lv5TLHRd+5KUh8uwHkT7JgeiWuSAJRgbM2Z+4r49Tt4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764619271; c=relaxed/simple;
	bh=+TgvRRUr5TNRd2YLYbo2DA4tr+0rMwB4Er77xu1gMz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgDFwbtSUBUhrrbDVpk4gy/j1qSafCky9K4fYkTutxYsx6F9nGsmaHyoG2249i9a10FWry3xTGDHtT7bAqxH9TaE4NpyrTfevZklGFP9TrrICjgtosxTO0jMeveW2G/ejVxsaTdtJKE7ZyM6eNEnH6/D2SH0AyCLbvIdP47rDaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nZMJlDbD; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nZMJlDbD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764619269; x=1796155269;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+TgvRRUr5TNRd2YLYbo2DA4tr+0rMwB4Er77xu1gMz8=;
  b=nZMJlDbD/nT7Ln5xHt//aBNePXK8ubuuZyLYffeFb9uMatmwmpKgBYC/
   VUR53IzeYCK72QAfdeOyspQVyFWlH+QKwOhrtUC9CvmvFOtkDvJN8M65P
   IDQbTcS/nL/dbuylDYC73YEs0f2jeHD1Gz3UHQxwd8Axssy7vUIE2EHnN
   hPooH9xQzeKZMcLc+42AadWnnI7FV/oTTh9BB736z7Bb0eGaFeSpvEF3O
   V/jDN3eZ+CGx1SkqVIdjsDwVUQK2VCSlhUGXuGvBNM50//K08T1zxVCPT
   8u19KJl99O1aLIu5cSXhwSPPdyIp8Vi7n+c/IufErPWIdofvlyeY3TcFa
   Q==;
X-CSE-ConnectionGUID: A9lRkYlrSamLK0H5sVT8LA==
X-CSE-MsgGUID: oet+IG3hT5KlSiIqOxXtug==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="70187148"
X-IronPort-AV: E=Sophos;i="6.20,241,1758610800"; 
   d="scan'208";a="70187148"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 12:01:06 -0800
X-CSE-ConnectionGUID: EjpiwClITieJFTWJ9dAclQ==
X-CSE-MsgGUID: C0xVISk/SeazZkz+Op1EoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,241,1758610800"; 
   d="scan'208";a="224863515"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.4])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 12:01:02 -0800
Date: Mon, 1 Dec 2025 22:00:59 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Yury Norov <yury.norov@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ingo Molnar <mingo@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] kernel.h: move VERIFY_OCTAL_PERMISSIONS() to sysfs.h
Message-ID: <aS3z-4Gq3rCmFIdD@smile.fi.intel.com>
References: <20251129195304.204082-1-yury.norov@gmail.com>
 <20251129195304.204082-3-yury.norov@gmail.com>
 <aStWkK6exUj9YEC1@smile.fi.intel.com>
 <e0d34a20-7547-4788-8449-95fcd5588434@infradead.org>
 <aSyCC7TQoGgTn2rT@yury>
 <aSydSI-h3KZiYBn6@smile.fi.intel.com>
 <fd755bbf-50a8-46f7-bff1-61cc625118a9@infradead.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd755bbf-50a8-46f7-bff1-61cc625118a9@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Dec 01, 2025 at 11:51:24AM -0800, Randy Dunlap wrote:
> On 11/30/25 11:38 AM, Andy Shevchenko wrote:
> > On Sun, Nov 30, 2025 at 12:42:35PM -0500, Yury Norov wrote:
> 
> >> This series was tested by 0-day and LKP. 0-day runs allyesconfig,
> > 
> > AFAICS in the below no configuration had been tested against allYESconfig.
> > All of them are allNOconfig.
> > 
> >> as far as I know. It only sends email in case of errors. LKP is OK, find the
> >> report below.
> > 
> >> All but XFS include it via linux/module.h -> linux/moduleparam.h path.
> >> XFS has a linkage layer: xfs.h -> xfs_linux.h-> linux/module.h, so
> >> it's pretty much the same.
> >>
> >> I think, module.h inclusion path is OK for this macro and definitely
> >> better than kernel.h. Notice, none of them, except for vgpu_dbg,
> >> include kernel.h directly.
> > 
> > Ideally those (especially and in the first place headers) should follow IWYU
> > principle and avoid indirect (non-guaranteed) inclusions.
> 
> Can you (or anyone) get IWYU (software) to work?
> I tried it a few months ago but didn't have the correct magic
> incantation for it.
> (no specifics at the moment)

You should talk to Jonathan Cameron (Cc'ed), he was able to run it to some
extent. AFAIR the state of affairs is that it gives a lot of low-level headers
that we should not really go too deep to (at least for now). That means the
carefully crafted map of guarantees needs to be provided (e.g., if we include
bitmap.h, bitops.h and/or bits.h are guaranteed, so no need to be included).

-- 
With Best Regards,
Andy Shevchenko


