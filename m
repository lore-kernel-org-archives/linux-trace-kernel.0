Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD91283C9D;
	Tue, 11 Aug 2026 14:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786457310; cv=none; b=EB4tsiiqKckYe5qHycCJdFOk3Rjl+1zbgTaqAY20d+qEc/4P4jF4RYzwb/f7f98mDZ010J4gRGY/i8mYZ/kEkmB/6WaCWaD5PLtq+FMlxB4aA6+j+y3eiJJSPjMX6CGNaSN0XlGiOxioXKjKRiyweDYWe/vB6cdZe/xYGog22UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786457310; c=relaxed/simple;
	bh=yX0gXrmmVPtMOiT9f8nAgFiWeyAdXvpyrPOb9b+fvuk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K3Zeol2KL3pc9cKpSv3UZy7SH11KbhfXzIv+0s8najMvFhPk929ssR78B2D44beXiPB0KbPubi/oxhmr3Rb4yW7qKcrsDd6lrcrbra0pjwTUMtFN3HtK10q8ev/uD5YbeJe80mBhdGIIQngB09HaYXhO4SGZ3jOiWGSkWjw+u0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id A81D7120478;
	Tue, 11 Aug 2026 14:08:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 5ADB720026;
	Tue, 11 Aug 2026 14:08:19 +0000 (UTC)
Date: Tue, 11 Aug 2026 10:08:30 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Xiang Gao <gxxa03070307@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lorenzo Stoakes <ljs@kernel.org>, gao xu
 <gaoxu2@honor.com>, yinchuang1@xiaomi.com,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Xiang Gao <gaoxiang17@xiaomi.com>
Subject: Re: [RFC] tracing: aggregate ring-buffer usage statistics
Message-ID: <20260811100830.7976bbe8@gandalf.local.home>
In-Reply-To: <20260811114818.1449933-1-gaoxiang17@xiaomi.com>
References: <20260811114818.1449933-1-gaoxiang17@xiaomi.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 5ADB720026
X-Stat-Signature: 1uwzqw5mnwmh3u8qo41mkaefgh791rd1
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19zyPRC4beHFmE52u3seDFJGcDmTtLkMT8=
X-HE-Tag: 1786457299-268855
X-HE-Meta: U2FsdGVkX1+qeOzVfeecE03pKVIZMZL/LY3tB5U71jzeeyt6L3MZ1zr6w/hrbWhiABmgTwFrlALMrYYr/G3aZrM/G5u03tBo8oV8UdJsNXKu5MbZYPTFm4lewncdptWOdMcCvmPCT3C4NukIe2aLr6DFeNWoXPGeuqtoumc4xw5rVLe/EURLRuUdb7OEjcQZCKkoPSZ8dJ3e+DSdKqJp2x8sSjXTeqsx2C4IUgvf5buHEQyO6ZISV1yIaBHxO35Gvii5Rf9wQWCh5Qw9+AwzHZx0wd6e7rIjCwnc/2e+2dJfPTGtoZzUXFmDQn1zYlcBUkiDIcOXkKKobzUhRU4aJvi6jRqM7p24

On Tue, 11 Aug 2026 19:48:18 +0800
Xiang Gao <gxxa03070307@gmail.com> wrote:

> One possible interface would be under:
> 
>   /sys/kernel/tracing/trace_stats/
> 
> It could provide an aggregate buffer value together with a breakdown
> for main and snapshot buffers. Per-CPU statistics could also be added
> if useful.

As I previous said. I'm OK with adding a file there.

-- Steve
