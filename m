Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AACB1A267;
	Sat, 29 Nov 2025 20:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764447898; cv=none; b=H11iqSHj5iOqFYOe+DZ+OWQWh3DPHQxdEwqTp01M6Lpkw0y3Y40GJTKA/AbCiSIenEy3VJ0yvvRMGkFW9NmAqyu9c2bbK2Ntbh5Qf3NhZCF/r6uVAz0QhC1eBH9SFaC8Wl3HHQXCMYqgKvtUj+azQTNy/ctKPdGJpt1xXkVnewo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764447898; c=relaxed/simple;
	bh=sdn+MzGbEmVaYHT98ZOg2A3k4qzpAI1WUmt0djB2qNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AwFGSyeBIfOs+NzSlgj3t9y2zweV2gYBnOj4GaJKpT83fzjPfQMHYKrPNLFri2AshSP7TiJ/0tsy5tR6DFeNuRb1oqEruN5jWYtTsIzgDRfP/GM+vIuOSEWr/k1v6aBzx1xS9oXG5JgJnUF/KyHUtrOQvtRTiYgkm1eI5xfOqOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QMW3X2Nb; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QMW3X2Nb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764447896; x=1795983896;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sdn+MzGbEmVaYHT98ZOg2A3k4qzpAI1WUmt0djB2qNo=;
  b=QMW3X2NbjRRJKmMtdEEkz/wOpe/zMeMdA4N8GyM/4dAGaRwfayGtsb3p
   Rd5Hg5tjzw8q6yJ1DHxFX1QW420q0R5QFCoLpuvXL+X/DxH0zZPgwqRRb
   kKc7rQibl8Sj4xC4XDHwQFjxbu0VCEZPhMM6iCjC+Swpuz4VQ/UxKbpaC
   zWwSfnODASq3fvqZpyv7Xkg/J4HK2DiF6FYP8aSX+aZJkBmxVUu2Q20j6
   1z80MuoCutY4Us4HOo2mGPMOrdq+5Ipe4nZG+Hqpg8l2conO8+CpcQm6E
   MyJ05C651r5JWPHlqJPsMmGl0qtbrvcBFnZk+2CSO8efFwFu1Pk8ctWVJ
   w==;
X-CSE-ConnectionGUID: k0thNW5ORy6YSWtOP/B4AQ==
X-CSE-MsgGUID: CTyNTEKATGmWZWyLTKYEWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11628"; a="66326333"
X-IronPort-AV: E=Sophos;i="6.20,237,1758610800"; 
   d="scan'208";a="66326333"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2025 12:24:55 -0800
X-CSE-ConnectionGUID: 39+J8ChYRMiA/q/LClSCvA==
X-CSE-MsgGUID: qibyBYVaSeuJAG8+XijhtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,237,1758610800"; 
   d="scan'208";a="194137825"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.50])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2025 12:24:51 -0800
Date: Sat, 29 Nov 2025 22:24:48 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
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
Message-ID: <aStWkK6exUj9YEC1@smile.fi.intel.com>
References: <20251129195304.204082-1-yury.norov@gmail.com>
 <20251129195304.204082-3-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251129195304.204082-3-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Nov 29, 2025 at 02:53:01PM -0500, Yury Norov (NVIDIA) wrote:
> The macro is related to sysfs, but is defined in kernel.h. Move it to
> the proper header, and unload the generic kernel.h.

Tough guy :-)
I hope it builds well in your case.

FWIW,
https://lore.kernel.org/lkml/20220603172101.49950-1-andriy.shevchenko@linux.intel.com/
https://lore.kernel.org/lkml/20240212115500.2078463-1-max.kellermann@ionos.com/
https://lore.kernel.org/lkml/20240215093646.3265823-1-max.kellermann@ionos.com/

Assuming it builds in allmodconfig, allyesconfig on x86_32/64 and arm/64
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


