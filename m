Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92E943147;
	Mon,  1 Dec 2025 02:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764557452; cv=none; b=IZ5slWk4R49GCCgd+gNaIlwgTA8rgV6ECo+qTx5hjmEUQRKYn67gYSDQiYega2aoqj6rPOBCntwEhoZLHePxhWJ7EbuKLM5PVrPVQaDVX6DN2pE9F7rQzzwS35ZYVPx8FtfrferveWCtXQuv9CkeuxK73xF+HA2m8ZBCL9yAAMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764557452; c=relaxed/simple;
	bh=rKOvDeIyiyRW4pFdZUPEt3azuNBykMjjiaAtloiTHqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MsOTKaWIq8wwVa+Zc7JG9iYjWzQ5piR23krO+t8KCRmYcFns3DnvHwOvbblct08ezdQJz+4EvMtXU/z9/g1yO064zGH47pmhpmp4nUVUW8AnAlrzkBhB3ErHeq9SMjWxYc3SrRfsoAwmJti1nIQ6x6b/D5YaGhR/xLyscDVyzHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L2B2o/V2; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L2B2o/V2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764557450; x=1796093450;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rKOvDeIyiyRW4pFdZUPEt3azuNBykMjjiaAtloiTHqg=;
  b=L2B2o/V2nRu4XHbLuKytjN/XJx6sAveYGpN4yXH3zTLvee05lSOF8icA
   E/zvU71ixtxsgbgQXN/JUcTLkoYZ278kwHUuTPcEFELLfJWOqy96DyAuv
   aeXijHY30Bij7KpVZ/psNo5UzMofaeXcmvBPY28xd0JeG+gUHVhO4wJV5
   zmlaHYwZOXDRl6fCpYLRl8uDMy9/4RGSLl2m4iaMPhH09ADQ5kPZyaDeJ
   cYurXg8Z+G9Anxp2ixon30PUr86T+tphhHmkDCilUn79bcIEW1hPDWZvv
   Vr9HuGZn/PPbLc1BjIb1nUntdqvlP+7oHCD/+eYIZFpIkICIBBXccLPpn
   w==;
X-CSE-ConnectionGUID: mWQr+tfFSQ+kiARJH+nBdw==
X-CSE-MsgGUID: q4fvIHP/TQSm2GDTyDLzFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11629"; a="66377197"
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; 
   d="scan'208";a="66377197"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2025 18:50:49 -0800
X-CSE-ConnectionGUID: YAbpDgaQSW6OVR+KExldcw==
X-CSE-MsgGUID: jGsuMvD2QQ2EBRDrcIx6Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; 
   d="scan'208";a="224916572"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2025 18:50:45 -0800
Date: Mon, 1 Dec 2025 04:50:42 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: david laight <david.laight@runbox.com>
Cc: Yury Norov <yury.norov@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
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
Subject: Re: [PATCH 3/3] tracing: move tracing declarations from kernel.h to
 a dedicated header
Message-ID: <aS0CgnvRfQtam0uU@smile.fi.intel.com>
References: <20251129195304.204082-1-yury.norov@gmail.com>
 <20251129195304.204082-4-yury.norov@gmail.com>
 <aStX3242e3mo5H05@smile.fi.intel.com>
 <aSyJ83v7EEAPHXeU@yury>
 <aSyertuRRX9Czvyz@smile.fi.intel.com>
 <20251130230925.376b5377@pumpkin>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251130230925.376b5377@pumpkin>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Nov 30, 2025 at 11:09:25PM +0000, david laight wrote:
> On Sun, 30 Nov 2025 21:44:46 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

...

> It is worth checking whether the files get included anyway, and whether it
> really makes that much difference.
> 
> Fiddling with kernel.h and extracting small 'leaf' headers from it is also
> unlikely to make a big difference.

It makes a big difference for the kernel.h and its (ab)users.
Especially when we have cyclic dependencies and "include everything"
cases due to other _headers_ including kernel.h.

> Try adding a syntax error to (say) sys/ioctl.h and see where it is included
> from the first time - I suspect you'll be surprised.
> Working on that include list might be more fruitful (in reducing build times).

kernel.h elimination (in the form it exists right now) is very fruitful.
However, you may help with the (say) ioctl.h or whatever you consider
really fruitful, we all will thank you (no jokes).

-- 
With Best Regards,
Andy Shevchenko


