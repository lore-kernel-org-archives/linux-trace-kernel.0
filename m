Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0F33C17;
	Sun, 30 Nov 2025 19:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764531352; cv=none; b=ifMxPhizFkshgaOLuculilokm485FStHv1adDrEIjXR1DzWGbL+UeCeJgRPMshCLnrXqw+Kzd5JSXM5m4vvcvrIsc3TquZUhXJF0mUgRufr9jpZtd8tYqsHiM4RQYZsB2qT3MOxOBz4MZG60QP5pOZeALCci4hv4PXuFmLb8tGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764531352; c=relaxed/simple;
	bh=v/MI6kLlmGwE12FmWCb72yhLGZ2pXfiaLSMVHtPu4Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ss4wkswHcNdsvW6/oNexr13PUffs2a8NG6Uyl6CebMIdXYdEqDC01aDtBdTIOdv7vL5hvkCCvvmFqLzDlIr7vS4mLrd5dFnDPJLkiLF3dk9U9XrZGhQctQi6u68Arug8I3tSQCtQ5Bf1iWZUDE24GkDg+SPfAXngRqAFaft3EAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I3NNJMy2; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I3NNJMy2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764531350; x=1796067350;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v/MI6kLlmGwE12FmWCb72yhLGZ2pXfiaLSMVHtPu4Qs=;
  b=I3NNJMy2LF9FNyn/FlRnflFEw74fP7nUkS3L8s779mtHNMmJn2sbZ/aD
   evt+ntWJmC2JN/Z6UzrHgA6PQuPNKLfy8f4rBR2MrnjIXGb+DD4YER3l4
   8B6QJH1G+/aM0MNrU82Ds1piWIHS7sRYnsePsFPNiojopdS5B8DonllCj
   b6MDgvuVQjrTqH8JI7pt/rY8uy3j7qvJMecRxAQN3g2ajbKMGSXlZfhTO
   uOHq41gXJBm0ytCxXEQlhSCVvkysIjaxo78jEMqdxdQFPh+1eZhh6A0gD
   ugVInzgiaDis8jPetbUKMx++RlWf6Ssy9hwzLfhQB1p/9WFarrPIvIE3/
   g==;
X-CSE-ConnectionGUID: JPe5/aDrTC6A+4y4Nc+VGg==
X-CSE-MsgGUID: 8S6wHMWlSXCgut/nUVdLfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11629"; a="66364219"
X-IronPort-AV: E=Sophos;i="6.20,239,1758610800"; 
   d="scan'208";a="66364219"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2025 11:35:48 -0800
X-CSE-ConnectionGUID: ZbEoJsGDT2KT5QF14rLIGQ==
X-CSE-MsgGUID: NF4JUzJjR/mDO5fMXIcBZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,239,1758610800"; 
   d="scan'208";a="193778551"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.125])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2025 11:35:43 -0800
Date: Sun, 30 Nov 2025 21:35:41 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Randy Dunlap <rdunlap@infradead.org>,
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
Message-ID: <aSycjR2Iq4iCOa7k@smile.fi.intel.com>
References: <20251129195304.204082-1-yury.norov@gmail.com>
 <20251129195304.204082-3-yury.norov@gmail.com>
 <aStWkK6exUj9YEC1@smile.fi.intel.com>
 <aStYs-LDKbJe6zvW@smile.fi.intel.com>
 <aStZKktOEWliXWT1@smile.fi.intel.com>
 <aSyFNSqWv_A7JNpI@yury>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSyFNSqWv_A7JNpI@yury>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Nov 30, 2025 at 12:56:05PM -0500, Yury Norov wrote:
> On Sat, Nov 29, 2025 at 10:35:54PM +0200, Andy Shevchenko wrote:
> > On Sat, Nov 29, 2025 at 10:34:02PM +0200, Andy Shevchenko wrote:
> > > On Sat, Nov 29, 2025 at 10:24:55PM +0200, Andy Shevchenko wrote:
> > > > On Sat, Nov 29, 2025 at 02:53:01PM -0500, Yury Norov (NVIDIA) wrote:
> > > > > The macro is related to sysfs, but is defined in kernel.h. Move it to
> > > > > the proper header, and unload the generic kernel.h.
> > > > 
> > > > Tough guy :-)
> > > > I hope it builds well in your case.
> > > > 
> > > > FWIW,
> > > > https://lore.kernel.org/lkml/20220603172101.49950-1-andriy.shevchenko@linux.intel.com/
> > > > https://lore.kernel.org/lkml/20240212115500.2078463-1-max.kellermann@ionos.com/
> > > > https://lore.kernel.org/lkml/20240215093646.3265823-1-max.kellermann@ionos.com/
> > > > 
> > > > Assuming it builds in allmodconfig, allyesconfig on x86_32/64 and arm/64
> > > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > 
> > > Actually, one thing should be fixed, i.e.
> > > Documentation/filesystems/sysfs.rst:123:Note as stated in include/linux/kernel.h "OTHER_WRITABLE? ...
> > 
> > And just in case, look into
> > https://lore.kernel.org/r/20251126214709.2322314-1-andriy.shevchenko@linux.intel.com
> 
> Sure. Please find attached.

Just fold this into your patch.

Thanks!

-- 
With Best Regards,
Andy Shevchenko


