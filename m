Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E0E42A94
	for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Mar 2025 15:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742572495; cv=none; b=k54BZ+nXGVwAhca1gYx0l/9Rc5N4wZf9dbtTZoKV9Ks7VoacClVBo/jLLPlWt1nycjTuYf4bb8INRrxEaFiOu4ogLDMzHHJKVDvjvyFug/E2DeGIOWWYh5WQWDVIO+oA9qS4OIniKOHseNsZWnv3u1QuXQwZ80nwSsg/lLX2Zzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742572495; c=relaxed/simple;
	bh=BRL8wFwo0jgpoLuMwse8M24+0n4BJHvyald8yqArMyc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kUCUQMZeFrd54zdY0k7alPCxxJRMjPseXJ6mxI7xZ4HF1RrbCWGz9Y4KnJo8F4FmeFV//etG5Xxx/yYOYq0Hl0kg1rgCikFNa0J6zOkKSgWqAyUIyGAtAR3zyM4qkff7LCPZAqVZD2L0xkyHRBHABgCsqoPexgc+GrkJlzPtQ5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-112-29.bstnma.fios.verizon.net [173.48.112.29])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52LFsMPZ013546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 11:54:22 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 0DFDC2E010B; Fri, 21 Mar 2025 11:54:22 -0400 (EDT)
Date: Fri, 21 Mar 2025 11:54:22 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Have persistent trace instances save module
 addresses
Message-ID: <20250321155422.GA1290637@mit.edu>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 05, 2025 at 11:45:45AM -0500, Steven Rostedt wrote:
> For trace instances that are mapped to persistent memory, have them use
> the scratch area to save the currently loaded modules. This will allow
> where the modules have been loaded on the next boot so that their
> addresses can be deciphered by using where they were loaded previously.

Hi,

When building against linux-next today, I found that this commit
breaks builds when the kernel hasn't enabled CONFIG_MODULES.  Could
you please take a look?

Many thanks!!

					- Ted
