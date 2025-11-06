Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24B823507C;
	Thu,  6 Nov 2025 17:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762449582; cv=none; b=MBPihq3JlRCXh8SfJSbbjczEWJCMK5fyBP72mKBF83MxWzXjH9aMPkl05O3lgauFBeXVIXarVlfKYsnSqhK3PC4KawzIkn22WhPssJmbhEG6f/fcX6TOmLWkAn4t7V5uhSQoCebmfKU9QvygAPrpn4QSaDjNpQ4X3OEDsXBIdR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762449582; c=relaxed/simple;
	bh=d3/7MWMIPt2qklFTqM8v59G1zedbNsNB/RD8Zl6VbQE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kFDA8lcbfmn/1W9TpdT6cMG5kFY+tYtErtMbKliXJ/pMGC3hzdLRWGv2fZq1BBb++fRvsSJkoGtCynfkwM0roF5cdEYYDE2698giJYS2B3ud1F4aqU/gUQi2OtF2UZpsljKu5enTOc4lrOZHwpE4Rx1Rko4EHVny0Q8cph5CzQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id CF9D91DFA6C;
	Thu,  6 Nov 2025 17:19:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id A4EF22000F;
	Thu,  6 Nov 2025 17:19:36 +0000 (UTC)
Date: Thu, 6 Nov 2025 12:19:35 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: kernel test robot <lkp@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 oe-kbuild-all@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Linux Memory Management List
 <linux-mm@kvack.org>
Subject: Re: [PATCH 3/5] tracing: Have tracer option be instance specific
Message-ID: <20251106121935.3efdb61c@gandalf.local.home>
In-Reply-To: <202511062223.ocoUvCBI-lkp@intel.com>
References: <20251105161935.545400234@kernel.org>
	<202511062223.ocoUvCBI-lkp@intel.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: fk9grwiihqoq53jhdokau8byn1wkbaed
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: A4EF22000F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18uWTdcXlyyoR3VMGpvOa0DxYvE6ud2xdM=
X-HE-Tag: 1762449576-625784
X-HE-Meta: U2FsdGVkX19ic/j+PnEM6rRsH3Typqk/8ymi/MDdxNp8zsI3g+yMWgsZVaBQhf/K8fSYw2rd+yY0fFCTOxTViutoUoQtmMoFHS7xQU4XtqKWPFcx2W/HTggJMu4c6XaVdg3YbK/6OskY/q/vONW0/S6wJKPHMatZH4c9kj0fjQIutME7kacdU+xjve0cNnl4RLuSurolzS0Wq63NEyQe1Aunq9N2OWWFaIxqf5IkEzpkXOlsNS7u6CLxxVWILPwPmkep0PwEq4Xk4vmXV30cJ0rwrLpkDSXhq2n0ooWXOIDLt5y9cc2SpwUIBNgPM6o4JeQsLrz7RkmVe02ZJy52EsXr7rXvkwhI

On Thu, 6 Nov 2025 22:38:04 +0800
kernel test robot <lkp@intel.com> wrote:

> All error/warnings (new ones prefixed by >>):
> 
>    kernel/trace/trace.c: In function 'run_tracer_selftest':
> >> kernel/trace/trace.c:2174:30: error: 'type' redeclared as different kind of symbol  
>     2174 |         struct trace_tracer *type = tracers->trace;
>          |                              ^~~~
>    kernel/trace/trace.c:2171:47: note: previous definition of '

Yeah, I caught this last night during my more thorough tests. Silly me
turned off selftests to make a bisect go faster and never turned it back
on. :-p

-- Steve
