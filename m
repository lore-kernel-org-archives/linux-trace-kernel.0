Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C9D271448;
	Thu, 10 Jul 2025 13:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752155239; cv=none; b=ayH2+DTc8zvOSvUabDfNsWm2xn21uH697ZzvIEAP5LjMpBxIDR5u0tS5lYjmQVKz0XqbVg3FR0RQ9uDX3xkEfZN3DEKMEgvUvrh1BkQoQdqX1iVyL2j5YdWeKsyGurYiGSyKTbMAsnKTSSirbVmxnk5de1UmNKyXQCu1DVsCOSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752155239; c=relaxed/simple;
	bh=09ZFdpxBaxLL3lmWu7TOf/6PS9TLU7EdPzlPT/Us4ng=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MMxaGjY94PuCK4Ku0ZKsOpYBhtx/ADqUMUI3bKch5nh2X+57bMKyEZPvD4HNmfoL2gXuSP9MN2/jgPBLaFLZAGXJvdeWdHwhX2JALymH8SVS+9ecyQZ3zwlqUd11bRFQnDPx/hJaTatD+L4Z/hBVr0xEqz1YhjH4a/59eExg/wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjotCYx/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjotCYx/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B438C4CEE3;
	Thu, 10 Jul 2025 13:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752155238;
	bh=09ZFdpxBaxLL3lmWu7TOf/6PS9TLU7EdPzlPT/Us4ng=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DjotCYx/maGi3/D1nn6XhzIdMV+xrldh75b1lrXnq1MCrm6nJk2mGKJNCGUTbogPH
	 r6MB+hGcnOIABqt4pXsbHXDSiPxGfrSp1OuPmd1BzEeJvuu9ktCCyrxn91lpVyRRHs
	 14Tbc9ddnjLBV+fE6uTh2InkXFZ+EB/qykKNjYkF0tbrHZTEUxWx68hAmHzwCdPt2/
	 07yrEqm26qjx5EIatam4SkCg0CEi1PB7FQ9y8O5mB/1f0kIOXdAmEVjjxgFmbNPnYr
	 PDZ1vu5ctLgJDctRPMrQTpe18Y7q39+zYxmgCQ6mBOxgosmChNMFHYgz1wHP8JiUvz
	 BEqENLdV2zuvA==
Date: Thu, 10 Jul 2025 22:47:11 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: kernel test robot <lkp@intel.com>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, <oe-kbuild-all@lists.linux.dev>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] tracing: Remove "__attribute__()" from the type
 field of event format
Message-Id: <20250710224711.8c5fd7b4510db3c4e9f5e787@kernel.org>
In-Reply-To: <20250709125118.3caad8b6@batman.local.home>
References: <175197568917.977073.2201559708302320631.stgit@mhiramat.tok.corp.google.com>
	<aG3AghTb49v6BBYn@rli9-mobl>
	<20250709125118.3caad8b6@batman.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Jul 2025 12:51:18 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 9 Jul 2025 09:06:10 +0800
> kernel test robot <lkp@intel.com> wrote:
> 
> >    kernel/trace/trace_events.c: In function 'sanitize_field_type':
> > >> kernel/trace/trace_events.c:120:30: error: initializer element is not constant  
> >      static const int attr_len = strlen(ATTRIBUTE_STR);
> >                                  ^~~~~~
> 
> I guess this could be fixed by making the above:
> 
> 	static const int attr_len = sizeof(ATTRIBUTE_STR) - 1;

OK, let me fix it.

Thanks!

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
