Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FBC30BB83;
	Wed,  3 Dec 2025 17:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764781272; cv=none; b=GCeErl6ZdkgK/A9Hnw/67k+UqIlQHMJlIFYWyMI7aM2ScxG7hewAvVBe+GAWtHQ00lsI9yrD3EYY/J0MIC/Mesb0xQqKqLMgP4DDEGiU4zX69bSQEeevyab1h+uwcS/DOXP4MHISciR/Im18oE5pZ2PkVzDwQ8TyVwWplPaQh3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764781272; c=relaxed/simple;
	bh=EOXn1ynSH/t9im4rCIUdywcb+MTfre1eFRENecT/JJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNUVxtag472GXRX1yW+oRAWjbl0FhGraEmSVTyfP/LnMZ/SIRlkbeMSQ1kaizkNZoY3ANc1fGNdqpUV1Sr0SHImRRF2yZPFNwT4R/xcFVe7Hf22XxIjJikjfOLM8KtDuDe9N81Htr1j3Q75qG2/HejV1bOiIguNa7ZFny5rkW08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dKBj892Y; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dKBj892Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764781270; x=1796317270;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EOXn1ynSH/t9im4rCIUdywcb+MTfre1eFRENecT/JJA=;
  b=dKBj892YT89xfzUuecgGI97BDHl1mao709N3T3p4ZxTXdwYV2P2sRh1p
   JHTESCJHceUnJLinI8mBvrcuHOncs/nYlScHu3iIoPiK/Bre2nc0be3VZ
   jKlDCPr/QRQzKcoE3S3DPHKYgsyvpRRIKdX9mV9fRmjhlXclx11rDO49z
   +Wtt96G/kIXVNrBiomOnAYifIw0Epcg3bNJRKchR1ZdOOkQEZZS68SGyg
   NOzSldxQJdJEY5j3Yx6n0PKqQhq2g2aMrOZTvIykk7zKKuDATIP9W4nrh
   QYsv+ccGnGEyOnL1WbO9XiOIuDiKRG76sIS5NHDvQsvpdNNRVYGWI1m9t
   g==;
X-CSE-ConnectionGUID: LcZWTZdZRumPOnvii+SNTg==
X-CSE-MsgGUID: jLUP9gAXTOS5BJd2PDxApQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="84383131"
X-IronPort-AV: E=Sophos;i="6.20,246,1758610800"; 
   d="scan'208";a="84383131"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 09:00:59 -0800
X-CSE-ConnectionGUID: NTtfOUV+RX2LKbgRk4ZKXA==
X-CSE-MsgGUID: BXPJ0dYnSKGRVRGViN4WTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,246,1758610800"; 
   d="scan'208";a="194979524"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.81])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 09:00:50 -0800
Date: Wed, 3 Dec 2025 19:00:45 +0200
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
Subject: Re: [PATCH v2 2/4] moduleparam: include required headers explicitly
Message-ID: <aTBsvbWVfZrVJo2M@smile.fi.intel.com>
References: <20251203162329.280182-1-yury.norov@gmail.com>
 <20251203162329.280182-3-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203162329.280182-3-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Dec 03, 2025 at 11:23:23AM -0500, Yury Norov (NVIDIA) wrote:
> The following patch drops moduleparam.h dependency on kernel.h. In
> preparation to it, list all the required headers explicitly.

> Suggested-by: Petr Pavlu <petr.pavlu@suse.com>

> CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

You can move this line after --- or use --cc when formatting patch,
no need to pollute the commit message with it.

In any case, the change LGTM and you can just replace the above with

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


