Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457DA2673AF;
	Mon, 17 Nov 2025 17:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763400167; cv=none; b=fDA9hSS3a2uz9eYt4SIdvbUXE3mjDpPIJpKfSspEYHAhO0zl7774bMZa+yT7ctvSIKb5Tv1v/0rC7+zK+VHNNpv8+epURIeM0EarKexZGYStNgGVdKs4qTJzaDrQQPXs2Th8vWEiQb8cZesuKIqD4RSk/b2OWMqhpd7QZvQow3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763400167; c=relaxed/simple;
	bh=B1t58Otc4cDW71gTgWrBk8K8gGYASS2yKO7Ldgw2rY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+EZjiwRwbk0QEz2xvg0ibWo4OESXEU0IOZ+XejcYX1gvqqdndJfC0Ut34CO3kOrQVPfNcSofOiuuOkAciNhn02gJcN03YgovBtWs8egYIbSIOv51wJAxk9onjX/BNgrpwminuB1ymqSUBEyG/15ga11lsOSD+HVjbKjN7PBE3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XyroqlHI; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XyroqlHI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763400166; x=1794936166;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B1t58Otc4cDW71gTgWrBk8K8gGYASS2yKO7Ldgw2rY4=;
  b=XyroqlHIvFdSLnTlldR3HJS1hhnk3woFnJy17PLDIn1Sa7jOOB0P8kcO
   KxUpkhGW8dUTsxkxKZfwtghbS0BZrouZnesjfITfZPjzf530/OYbk6rQu
   k75+sYB9X2/4MW6RNPIPk/iRkkFwSR4qUOsK87zVXzaKrRP+W/1bOJf7i
   oKKMwA+XfCHWM1QW3Fgs1qcLTieUebLL+v6fIzgpkssyfRzfludWc6Hs8
   ZKEcg9s1SI/or+eIrFcM3XWfVr3BL5S6d4up6KdUX9uSoOKxR+bPiMcvl
   bVwJysdrBDN1ZlXdAxN2vLOL0ITr8OSgZMmWVfH35kTIYyqqCNLVR8Tdu
   Q==;
X-CSE-ConnectionGUID: gxzzzMORTLazekKhhHm8QQ==
X-CSE-MsgGUID: 0w8mq54yThOJ6hqjyMDH1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="76085686"
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="76085686"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 09:22:45 -0800
X-CSE-ConnectionGUID: 2b5VHv5mSWe5EO803RONyA==
X-CSE-MsgGUID: G3hDGjWATai74ohgr+adWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="189766215"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 17 Nov 2025 09:22:44 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 385D396; Mon, 17 Nov 2025 18:22:43 +0100 (CET)
Date: Mon, 17 Nov 2025 18:22:43 +0100
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Remove unused variable in
 tracing_trace_options_show()
Message-ID: <aRtZ4-BdixI-it-o@black.igk.intel.com>
References: <20251117120637.43ef995d@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117120637.43ef995d@gandalf.local.home>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Nov 17, 2025 at 12:06:37PM -0500, Steven Rostedt wrote:

> The flags and opts used in tracing_trace_options_show() now come directly
> from the trace array "current_trace_flags" and not the current_trace. The
> variable "trace" was still being assigned to tr->current_trace but never
> used. This caused a warning in clang.

Tested-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


