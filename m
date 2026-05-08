Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16BA3EFD05;
	Fri,  8 May 2026 17:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778261390; cv=none; b=j2OosbI1fzg021bdLt/W0W910kK7E01Tro3jUh+YSILjyrCGu5pZdVbDISxwxUOMbm4NrO2QIQzqUo4otymA5PPZyvWeXYLmTwUI6clZ7eeSVCnNszFLwZS6CIK8C7jvziioqUCY3Q7H35LV1Cn9DtfYjCELW+588P+DqQnc4fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778261390; c=relaxed/simple;
	bh=WImkrdfZDvCww9DRBeXh2LQGC9Ksn9raoEsYh8zM9y4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HdoiCPnaZyyrwObFiRxZIJMw98oMmiEvGI14DTG6WQoMO7R0O2ZjFXMKirMxgnCIIttEQi0m5LCRu7qAof26DJ/qMzqcA7WvyYsP1H6y0iUt4YXMlQhX1SW4A0X+A6jatLZBMpbwu9KBzIYBNUvQwLoXIR6FLAL9XUVR0IyrEMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Fn8xnnaC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Fn8xnnaC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27E9C2BCB0;
	Fri,  8 May 2026 17:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1778261389;
	bh=WImkrdfZDvCww9DRBeXh2LQGC9Ksn9raoEsYh8zM9y4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Fn8xnnaCWaF0vyPtBMo2X4/gXck247qHSFTKsAYHkaVbw0FUqJrs7SKseePgrdVcW
	 4v7BaTGoqZG05LRaPKk+Fzer0c4BuQMx9wfQ1lnjGp9PlyPpcZS6kvU1ff/Jo2ECj/
	 Wr+L1i/SDWv9cDbNP+2TI7WWnqmusfdrW2LgNd9g=
Date: Fri, 8 May 2026 10:29:48 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: hawk@kernel.org
Cc: linux-mm@kvack.org, Vlastimil Babka <vbabka@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>, David Hildenbrand
 <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Shuah Khan
 <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH 1/2] mm/page_alloc: add tracepoints for zone->lock
 acquisitions
Message-Id: <20260508102948.b1c687e623fabec65580f258@linux-foundation.org>
In-Reply-To: <20260508162207.3315781-1-hawk@kernel.org>
References: <20260508162207.3315781-1-hawk@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

e .configOn Fri,  8 May 2026 18:22:06 +0200 hawk@kernel.org wrote:

> Add tracepoints to the page allocator fast paths that acquire
> zone->lock, allowing diagnosis of lock contention in production.

Thanks, I'm surprised we haven't done this yet.

Unfortunately "mm: use spinlock guards for zone lock" messed this up
(https://lore.kernel.org/all/cover.1777462630.git.d@ilvokhin.com/).

So please let's give it a few days for reviewers to comment then redo
against mm.git's mm-unstable branch?
