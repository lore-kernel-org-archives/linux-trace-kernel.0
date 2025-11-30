Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB521F12E9;
	Sun, 30 Nov 2025 19:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764531537; cv=none; b=eKDta3ebprYmLgWRfZRPVhGV0Dl5uGaXbk1UxNZuQvDsCBNJ7IaLqDcEPqXeYPl9C6UKqr9rrWertTj21d8hoGj8itAKklNNz917trcLjc0SFxLSHeCRoWyFjR5U4jIInpHAfM38sPmYW6vBhpbJZGYctlBZiJhIjDs/y3uNqzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764531537; c=relaxed/simple;
	bh=ylCdixgggpG3AQDuxOsE/FrAIGyeW0LSRVjCqHLfqQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXenvQh/KG+O4pcvF07O6DQpuaHCaNGMgBwIOCPJ5BAORzinY8iB6fdymnZ2luajtwIAjrdrGYcn6sX/1JmchEgovoKJgX5ebwmM/pc60OJxj91ltgKQ1K1oQ4g2SnQqJ7t8hgyWdzjsHWjWK7+ZTmYjRK0aLpWunWK8qHldNT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IPCsWh+W; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IPCsWh+W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764531536; x=1796067536;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ylCdixgggpG3AQDuxOsE/FrAIGyeW0LSRVjCqHLfqQ4=;
  b=IPCsWh+WRJu2cg4bYy6JTpmMhx474VcOYhFX/dbzlSQSUhhSM3pTRqE0
   47NhmZnJ+vRkdK66ydTPBlTpanuEFltKmQ/z1nSqdaEVzJgKVlGnHNb5m
   7iq8oDIqsn/cOAfC9M0ZNoa5L1adafHuvUnVRrFM051tanqrY3oGSEKjl
   42jxE0FXVG9lW8lFJTnq8CZLuPx2o/RVFwYw7YkuMukwt6hHcOfqsaifh
   JzUixGSb+MooziCxA+uXm6i08e6/TnxvoK1eRaWlgPaLDeCfZWTwHhoBb
   f3eDYsq1aJkMClKmFqEWxTY47y0X5lGDSyLc95U3Mz2XjMqXpJgOuUQ9h
   g==;
X-CSE-ConnectionGUID: EDSyj1g8T525loAL/3hTEw==
X-CSE-MsgGUID: TfoU3RugTwq5eOyJ3ep7dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11629"; a="77826722"
X-IronPort-AV: E=Sophos;i="6.20,239,1758610800"; 
   d="scan'208";a="77826722"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2025 11:38:55 -0800
X-CSE-ConnectionGUID: tWRx5yiZS4+dTWtqmN92sQ==
X-CSE-MsgGUID: QnBLYUfTQ3OLBKYeE0lYsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,239,1758610800"; 
   d="scan'208";a="198827111"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.125])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2025 11:38:50 -0800
Date: Sun, 30 Nov 2025 21:38:48 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <aSydSI-h3KZiYBn6@smile.fi.intel.com>
References: <20251129195304.204082-1-yury.norov@gmail.com>
 <20251129195304.204082-3-yury.norov@gmail.com>
 <aStWkK6exUj9YEC1@smile.fi.intel.com>
 <e0d34a20-7547-4788-8449-95fcd5588434@infradead.org>
 <aSyCC7TQoGgTn2rT@yury>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSyCC7TQoGgTn2rT@yury>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Nov 30, 2025 at 12:42:35PM -0500, Yury Norov wrote:
> On Sat, Nov 29, 2025 at 10:19:29PM -0800, Randy Dunlap wrote:
> > 
> > 
> > On 11/29/25 12:24 PM, Andy Shevchenko wrote:
> > > On Sat, Nov 29, 2025 at 02:53:01PM -0500, Yury Norov (NVIDIA) wrote:
> > >> The macro is related to sysfs, but is defined in kernel.h. Move it to
> > >> the proper header, and unload the generic kernel.h.
> > > 
> > > Tough guy :-)
> > > I hope it builds well in your case.
> > > 
> > > FWIW,
> > > https://lore.kernel.org/lkml/20220603172101.49950-1-andriy.shevchenko@linux.intel.com/
> > > https://lore.kernel.org/lkml/20240212115500.2078463-1-max.kellermann@ionos.com/
> > > https://lore.kernel.org/lkml/20240215093646.3265823-1-max.kellermann@ionos.com/
> > > 
> > > Assuming it builds in allmodconfig, allyesconfig on x86_32/64 and arm/64
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > I don't build allyesconfigs any more (final? linking takes too long).
> > It builds successfully for arm64 allmodconfig, arm allmodconfig,
> > i386 allmodconfig, and x86_64 allmodconfig.
> > 
> > And the source files that use VERIFY_OCTAL_PERMISSIONS() all build successfully
> > (which means that they possibly include <linux/sysfs.h> indirectly, i.e.,
> > by luck). There aren't many of them, so I checked:
> > 
> > arch/arc/kernel/perf_event.c:	arc_pmu->attr[j].attr.attr.mode = VERIFY_OCTAL_PERMISSIONS(0444);
> > INDIRECT
> > drivers/edac/thunderx_edac.c:	.mode = VERIFY_OCTAL_PERMISSIONS(_mode),		    \
> > INDIRECT
> > drivers/media/platform/amphion/vpu_dbg.c:		    VERIFY_OCTAL_PERMISSIONS(0644),
> > INDIRECT
> > drivers/soc/aspeed/aspeed-uart-routing.c:	 .mode = VERIFY_OCTAL_PERMISSIONS(0644) },	\
> > INDIRECT
> > fs/xfs/xfs_error.c:		 .mode = VERIFY_OCTAL_PERMISSIONS(S_IWUSR | S_IRUGO) },	\
> > INDIRECT
> > include/linux/moduleparam.h:	    VERIFY_OCTAL_PERMISSIONS(perm), level, flags, { arg } }
> > INDIRECT
> > 
> > so all of them got lucky. :)
> > 
> > Acked-by: Randy Dunlap <rdunlap@infradead.org>
> > Tested-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Thanks, Randy.
> 
> This series was tested by 0-day and LKP. 0-day runs allyesconfig,

AFAICS in the below no configuration had been tested against allYESconfig.
All of them are allNOconfig.

> as far as I know. It only sends email in case of errors. LKP is OK, find the
> report below.

> All but XFS include it via linux/module.h -> linux/moduleparam.h path.
> XFS has a linkage layer: xfs.h -> xfs_linux.h-> linux/module.h, so
> it's pretty much the same.
> 
> I think, module.h inclusion path is OK for this macro and definitely
> better than kernel.h. Notice, none of them, except for vgpu_dbg,
> include kernel.h directly.

Ideally those (especially and in the first place headers) should follow IWYU
principle and avoid indirect (non-guaranteed) inclusions.

-- 
With Best Regards,
Andy Shevchenko


