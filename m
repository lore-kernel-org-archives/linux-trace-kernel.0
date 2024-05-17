Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1FA182D2;
	Fri, 17 May 2024 07:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715929740; cv=none; b=DH3pzesOcPd6qH3JlMumGCdUg6t+8jKRzfsPe2ypIzyCCqfLLUQXhDGoX57wqufGxs4KXgcZWy1uRv6E9IGYKm+P6aU2kgHQAIl9OkjR/MI50//ENE9Vw/1B6MXwLkGqtUbpw4r8qloB6Td0UhcsSAwR4IoOndwbTCMuGu+Btg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715929740; c=relaxed/simple;
	bh=4jzPqLE03YaaobboDAOp2dTTKo+Dv0gOxstOpT6a3Yk=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Sba9kOsxj6vlU1rdO7ZXszoQCp+lOuwGi2TwFmO4njWyp0ybnZuUoKpeQ4AmzoJsTq2TCdNdJaBGQTYX2bI5z0/czeabbQktfj6OxZQHyIcm1gJwnDdecNwUmpIQ/3GA0KiSqw4ryX+f3Ft3l+EK4fvszWpgU3FqALaTAYxr87A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QVJKtj7i; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QVJKtj7i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715929738; x=1747465738;
  h=from:to:subject:in-reply-to:references:date:message-id:
   mime-version;
  bh=4jzPqLE03YaaobboDAOp2dTTKo+Dv0gOxstOpT6a3Yk=;
  b=QVJKtj7izjOEd+uFnQI99k7bGnjNwv0tHkpJ17rK6gxw7lp8vlWdviRm
   fd1EB2ZpuDdkpWPIJt/FTqWbjPdah83H62bt2r5BhYgv9nWlvJBwU2mii
   V5fLgfpP8rUDSAHqdTkRefvOCDmz6DH+EgUP/cUJl3v0pjhrDXziquhVE
   jHOKNU6eTYAQU19fGi/jUUB5aFKkJDSmM5TgQLfkCVkmrUTUg03fvhUA2
   cF98n/wgCbScfcFihS5MIU3orChgPK5sVEBmL+UlHX3nLfqxMJlJqJAn9
   2ycKW1yoxG3SXSiN6akU7Puf3qZ/yfcC7LjpSG3CtiyknrWbiz7fJEEzW
   g==;
X-CSE-ConnectionGUID: nGV4/y9wRcSvj0sSJwq3LA==
X-CSE-MsgGUID: C1jgGfKGQvKnnFuMPXcbmQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="15874362"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="15874362"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 00:08:57 -0700
X-CSE-ConnectionGUID: JMEU4XzbSSu2JbTzsqsv5Q==
X-CSE-MsgGUID: +SmkfxHOSDugv0gdQkR9pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="31837613"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.246.7])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 00:08:56 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing/treewide: Remove second parameter of
 __assign_str()
In-Reply-To: <20240516133454.681ba6a0@rorschach.local.home>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240516133454.681ba6a0@rorschach.local.home>
Date: Fri, 17 May 2024 10:08:51 +0300
Message-ID: <87eda0c3uk.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 16 May 2024, Steven Rostedt <rostedt@goodmis.org> wrote:
> There's over 700 users of __assign_str() and because coccinelle does not
> handle the TRACE_EVENT() macro I ended up using the following sed script:
>
>   git grep -l __assign_str | while read a ; do
>       sed -e 's/\(__assign_str([^,]*[^ ,]\) *,[^;]*/\1)/' $a > /tmp/test-file;
>       mv /tmp/test-file $a;
>   done

Try 'sed -i' ;)

>  .../drm/i915/display/intel_display_trace.h    |  56 ++++-----

On i915,

Acked-by: Jani Nikula <jani.nikula@intel.com>

-- 
Jani Nikula, Intel
