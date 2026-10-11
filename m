Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3807154705F;
	Sun, 11 Oct 2026 01:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791681856; cv=none; b=Uxg9XdR04rPngbknZsSllsmavgG55kFdP45vSOXobvqzD/w0M4latQl2fP9ytjGHCtTRS8dHsogCv5iqoJUvGGT6A9G7xQ9yA0kptpvxeLqN6yc/bU49xvjrrNW2g+Q77biPUyNC1NZNEw7e21m5WBdaX+18beYwWCo0ISWPWIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791681856; c=relaxed/simple;
	bh=vUsYNcB8ae0YhaozGtIMgaefuQwTpAbUax+4L9rJbSs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hOQiYjOlFZTB0QDwUXCQZV0Z+ECnA8Y3asV80KjW4B7RCe+FNX4zhInBQuU38kST3I68/NEkicKYuGnmp9uzn3WPcRLcawnzPyT7DF56ivvH7MJqSnoDNLbx0SZ/fB7mfTaPSRYv+GKfJ773Wyzehc46fM2GoRlDJH93voHkJ7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=MCUK7dVI; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="MCUK7dVI"
Received: from omf01.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 665111A0544;
	Sun, 11 Oct 2026 01:24:12 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id A0D106000C;
	Sun, 11 Oct 2026 01:24:10 +0000 (UTC)
Date: Sat, 10 Oct 2026 21:24:09 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jeff Barnes <jeffbarnes@linux.microsoft.com>
Cc: linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, kees@kernel.org
Subject: Re: [PATCH] tracing/user_events: Fail fork when event state
 duplication fails
Message-ID: <20261010212409.1db6bfd0@226.227.38.69.naturalwireless.com>
In-Reply-To: <20261008142054.89783-1-jeffbarnes@linux.microsoft.com>
References: <20261002222639.1964370-1-jeffbarnes@linux.microsoft.com>
	<20261008142054.89783-1-jeffbarnes@linux.microsoft.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: c96h9u331j36y5bukep4zca79n97oqbz
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: A0D106000C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+wqFs2MQDJdL3ylJlkZHGC2MAOb/NfeZM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=FdBG3gkHDcFBk9gV69/rmpvTGRIaSVfg5pxb1RCrOOU=; b=MCUK7dVIK/Jxm52V/tVark2wHdCF1g2VeE3xOJqc5CCdukjdrAwfR1VPOG0iBa7/hZPlUxm4ow7/6ya6erQC2WJ0wAbZ7aLG8c2i2eg3Oq2w3vXrufC2iM4iGv+YK1RPW5kakVS+Hd56t0MQTWjOTjuIy/5Xp89Mfl56bhVC0Ng=
X-HE-Tag: 1791681850-67614
X-HE-Meta: U2FsdGVkX194fcGMF6/nOhM2kZomAnpTU1b6DZXTUwxb98M0g6dUBOXN6GRga3u5p1Xxx/FLmSIqrNo6rWURYiyx/0FO9iUR76N+CF0ikpT2fHBajGXzOgkkGRygqAAGuq491zMkA5Dkw3MsZZcEuHWLxDmUyBz/ANUPKJJ8lGMYtghIYO5UL0fFfn3nfCYkFZj3VuvfQ4hrW0igk24QKfzjZnQkx+YFge8U/Cjieqe93Wx8UYJcJr3Z1B7yjbbwfoiOZdDzznahS2D5FXa0Aw+CHRglCH5PJkRiR3U9YAzV3UHv3HHKMfJjpUjdFD9njmjJnVmyzzsr4G28bU9lnMVQJTIPb3CkxY9Qu6Tobzwb9e5S3kC6+w==

On Thu,  8 Oct 2026 10:20:54 -0400
Jeff Barnes <jeffbarnes@linux.microsoft.com> wrote:

> Hi,
> 
> Gentle ping on this fix for the user_events fork error path. Please let
> me know if there are concerns with failing fork when user_event_mm
> duplication fails, or if additional testing would be helpful.

Sorry, due to my traveling (from Sept 15th) I have not been doing *any*
kernel patches. I'll be spending the next week catching up on all my
patches (including this one) for inclusion.

-- Steve

