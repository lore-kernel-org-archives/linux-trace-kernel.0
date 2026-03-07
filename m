Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D04165F1A;
	Sat,  7 Mar 2026 02:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772851056; cv=none; b=a1CwP4GyxOQgszGSlKzNQJCinQmjYTKYNfczhJRg7H/bNFuBWIbnJ85C8jIFt9ma/T+6gdAwfwZE9O2JGBGnZpXRmB65/TnQbt1MS3gTgW4k+xUj7w4jKuvuwBUBqgN11LcsPlcm9sf8uMGP8Kd2a6ULJIeOUp8QybgpIUgUvbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772851056; c=relaxed/simple;
	bh=OE9TghJvn66gfXVGUQqDzjAc3l6PmutysFc3MrajkqM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XNCeVPeksb3cSCg3wU2+jMmkc8hNfhmgjVBAM3WEY96AMISq2UOylSDQGiMTtewMa33Ohb7gC9+2u1wEJEie5IrAIgzcp08ts3ORbAmFOWsmG8PodFpTL5zmMK5UwXZDvK72NZq2NJn0HPGJ0iu5Z4lEgSNQHLQq+rgfG5u/bY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id E39AB58F14;
	Sat,  7 Mar 2026 02:37:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 2CCF320031;
	Sat,  7 Mar 2026 02:37:32 +0000 (UTC)
Date: Fri, 6 Mar 2026 21:37:30 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Calvin Owens <calvin@wbinvd.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Fix trace_buf_size= cmdline parameter with
 sizes >= 2G
Message-ID: <20260306213730.566b9511@robin>
In-Reply-To: <9a65e27b0394069040c9b8f8684525687dc15d6b.1772820006.git.calvin@wbinvd.org>
References: <9a65e27b0394069040c9b8f8684525687dc15d6b.1772820006.git.calvin@wbinvd.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2CCF320031
X-Stat-Signature: k7yd7f6dy4sc311p8qzeb8qsh9toca9e
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19VZrydS+cN3ONQ/ywYdlxTc1D7pgenfKM=
X-HE-Tag: 1772851052-247153
X-HE-Meta: U2FsdGVkX1/82Auf9s5edclQSDuIK0A9+0wW7QiH081mAkDb9pXImhC54U3J2UNMgPsjN6VFwLQiF5W8JnkfCeuPrrZ1vvQuMllz1/X2aWFuZ8Yj8c55sUS+4hFhBVAFV1EQtV+r7Hfx4R5u7hM31b2BIoY0eUmLwQtFn6iL45TEdXadifW/qzFN95Xk7t6eXcSROG3mc3HNDyriH0EZlKSM47lwe91c7M1tf6K0yGeHycFHT4HcALFzcrBQkoOsNDnrcrgIARp7wl2ybhNQ+MH5efQBM9uio+xADG5UMyD3nHQoUesi/hWAnEVMwaMKc7pqUGUarnCwPTE8iNGOF0YHS++060xH5v5sR1u73kUzRolUMj5kAoF98U8S28af

On Fri,  6 Mar 2026 18:28:38 -0800
Calvin Owens <calvin@wbinvd.org> wrote:

> Some of the sizing logic through tracer_alloc_buffers() uses int
> internally, causing unexpected behavior if the user passes a value that
> does not fit in an int (on my x86 machine, the result is uselessly tiny
> buffers).
> 
> Fix by plumbing the parameter's real type (unsigned long) through to the
> ring buffer allocation functions, which already use unsigned long. Also,
> tweak ring_buffer_meta_scratch() to avoid void pointer arithmetic.

Let's make this only fix the problem at hand and leave scratch alone.
Scratch is seldom more than a page size and int should be plenty.

> 
> It has always been possible to create larger ring buffers via the sysfs
> interface: this only affects the cmdline parameter.
> 
> Fixes: 73c5162aa362 ("tracing: keep ring buffer to minimum size till used")

Another reason not to touch scratch, is because it's a very new
feature, and this fix goes back to 2009. If you want this to hit stable
trees, only fix what is needed.

Generally, you should only fix the problem anyway in one patch, and use
other patches to make other updates.

-- Steve


> Signed-off-by: Calvin Owens <calvin@wbinvd.org>
