Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9581423AB8D
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Feb 2026 19:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771875775; cv=none; b=ojU3Cd1Xcqcu8aYjBprdAbwTIJOYyPbdBgihr7ys9pfwaGJ80GH82BhpnE6J5rne2P9GZc7Wv/szpIdAtT4Y8Kkm8JvEsSKUJNfhDVr1RRY41GBNGokQZhilz+WEJiWmdN35V/bN5Vp+6JxSCG7+t4MXMtPgLObhOVZVyDy+Vek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771875775; c=relaxed/simple;
	bh=rj8ye3UwqLi2W/5uJZjx0RBGN4cNIYRZ2ySzLY+wYB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4lLxUE04sa7WokC+997jrPJt5cWYRlDESkd6E1zTPBu9x5AueeZM9JtRPDTYUcp0fJ3gVEkeG8UweMHhnQfWgi01UuwyCiVyrVyUcaO3u7CulxDm/lzFuUW1kX8/aPLYgULbespZ9awgBGkaokIe0x5y9lZtxwJEKUGHch1ujg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Le2r81F4; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Le2r81F4"
Date: Mon, 23 Feb 2026 11:42:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771875771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gIQcQDyS3X7z6KDsG0mP+b5KcPKyO7L8eLyBRsu2r4g=;
	b=Le2r81F4jqCDxDLaiX4FjKljCWmKeW2G0hkga84GeWRE6RC3Q9qhm6lISEmmHcEH5pVyOV
	fwAzAP8ofyAOMoqAiK5h+Nx0cdE7fFJWsSnoTJGivZDWCKozuZem3JPsM1zw2utclFJ5aE
	rw/wJ9ewmSyd8dioXnIbBKei5QWpOoo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Thomas Ballasi <tballasi@linux.microsoft.com>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, david@kernel.org, 
	hannes@cmpxchg.org, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	lorenzo.stoakes@oracle.com, mhiramat@kernel.org, mhocko@kernel.org, rostedt@goodmis.org, 
	weixugc@google.com, yuanchu@google.com, zhengqi.arch@bytedance.com
Subject: Re: [PATCH v7 3/3] mm: vmscan: add PIDs to vmscan tracepoints
Message-ID: <aZys_tvQinYNNpOk@linux.dev>
References: <20260213181537.54350-1-tballasi@linux.microsoft.com>
 <20260223171544.4750-1-tballasi@linux.microsoft.com>
 <20260223171544.4750-4-tballasi@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223171544.4750-4-tballasi@linux.microsoft.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 23, 2026 at 09:15:44AM -0800, Thomas Ballasi wrote:
> The changes aims at adding additionnal tracepoints variables to help
> debuggers attribute them to specific processes.
> 
> The PID field uses in_task() to reliably detect when we're in process

Where is this in_task() check happening? Also this patch is changing
tracepoints for memory reclaim which never happens in any context other than
process context, so we don't need __event_in_irq() checks for these tracepoints.

