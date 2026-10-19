Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C33597F5D;
	Mon, 19 Oct 2026 14:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792420808; cv=none; b=PmKYNkyybf4BgunQYWUbUTrdOxSD762yGT+DrcUPvsRbWVwqND8A3Z0/2ZdDKJ3vxOxWBmKUnSNckMmMK5OISXfUBMH8ZwM7dMy2bWtZcYpr8xhaw/NR0sI7xBzcz7z+P1m2YrY8hMW1YavqHULixQ07pnwfijPVxy+Xj4bAt7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792420808; c=relaxed/simple;
	bh=nIb72tWQZM/gVIvuxEnHHOxnOfLXr/hkpBhRlLRlsqY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iuiW2FgSm/fBKavaE6UwjFDz4NHrwDH3BGk3FiGPYKw1JC8o81btabrriAQbezPMZDoa+x77n9hi+mXaTWm94UgkS2XQjIdJu4XKrPudhk/98mThI+Atow7MPXzvSu7T6ulYQamUunBzTSEIwl6iaxF9rngUva6uL6auHiKv34g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=yKS71ieX; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="yKS71ieX"
Received: from omf05.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 06E88A071B;
	Mon, 19 Oct 2026 14:40:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id E89D92000E;
	Mon, 19 Oct 2026 14:40:01 +0000 (UTC)
Date: Mon, 19 Oct 2026 10:39:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jeff Barnes <jeffbarnes@linux.microsoft.com>
Cc: mhiramat@kernel.org, shuah@kernel.org, beaub@linux.microsoft.com,
 mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] tracing/user_events: Share state with existing
 threads
Message-ID: <20261019103957.69759ee3@gandalf.local.home>
In-Reply-To: <20261019142301.2084882-1-jeffbarnes@linux.microsoft.com>
References: <20261006164720.3940272-1-jeffbarnes@linux.microsoft.com>
 <20261019142301.2084882-1-jeffbarnes@linux.microsoft.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: E89D92000E
X-Stat-Signature: 8tjo8czkkxtce98zqpygfg65hak6hnha
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18l97dNhDQNr/m/gbgR4Aa1qmemmMHzTcs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=TgvEG1bdMe8lKkcr4Dz3rJBRTT/4j1TEWGKmyyDzNQU=; b=yKS71ieXeJYDjSUUSyVRtUr6bZTnRYt5oirI94eZCb9PaR4EQXpRum9Nj00UPZYDXkLvvp4oL8/nCXDtaY9WWBTz1W1y3jS4io7hXw6cANo1bhev6Ec5W7KNibHWuWbiJCmBhXxdntfuUZoAfPd5eVIemk3OMNmcxSYVegklPT8=
X-HE-Tag: 1792420801-279918
X-HE-Meta: U2FsdGVkX1+Zl43l3YKIvN4ejUDl4dQDf8EA41H1S605DoC5Oa3QVXOnRhq6kuAxSO23FdWbkFpPVLkfsXQzRTIZ/Z7nOISU20NRLquuczR8Dg4HvP8vm9YW2y4CFIcSsYnAEUvaf0IACRsOh4n1azXsMGoOHmfcHLzkcXe7v8OlZAVfnow4zlcXuyAjqBUHMgltp2As6e//CsZRkt2kwolItLB+5Dsshccd77UwOUpT56gbfg1wOU9H71ezrfHlwUu/h9dzsPr5E31Gp1ZETJxN7aXNsU4CQSCYseku9/gaAzBPuxfw7YU72gzg+j8TQJMnfhL2qYLtLN2S9FSWEjI/7J96EaIm

On Mon, 19 Oct 2026 10:23:01 -0400
Jeff Barnes <jeffbarnes@linux.microsoft.com> wrote:

> Gentle ping on this series.
> 
> Please let me know if there are any further comments or changes you'd like me to make.

Hi Jeff,

FYI, always start a new thread when sending out a new series. Don't make it
a reply to an old one. That makes it confusing to know which series to look
at.

Also, I've was traveling between September 14th and October 10th and my
backlog built up quite a bit.

If Beau can review this series, that would be great. I'm currently putting
together several branches for the merge window. Unfortunately, due to my
backlog, there's patches that have been sent this month that will need to
be postponed to the next window.

As user_events are agnostic to other changes, there's still a chance your
changes can get added this window.

-- Steve

