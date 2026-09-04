Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36F74F30D9;
	Fri,  4 Sep 2026 18:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788545414; cv=none; b=Zf7v2e5vFPQMDIqLbrnJMlvzh7z7pHvhj4IgNzHK2fYNilUJ1X7jHWG6U3zNIj1eXaG3uOnljyPfEN9xJbd7/GuXqkjkI7OsoATtx7sPVM6BK67zifFF4J/gKUeCeZpTCS97R8plrWWxJRCsT2wRVJE5NQQ9TWvbLBhQlVgexHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788545414; c=relaxed/simple;
	bh=1BW3bwgOiRNceiGoe+qvTekIVM9YcjPMsg4n6XnpGY0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uqzqvgu0agzD8Wpkm454Nf4Kfn86WED9+qdk79lbsPbYClFeRbhb3KO1urTPEf9nq5DiAl11l74824sXuGgFM9t/eME+tHTgmzdeYh2W70ASn2Ran5bojtBIN2nj77KjJehLjWEh4Z6fHvbwDLQsmHWPripyusBiOBnIa9H4JBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=1A8ZjVWR; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="1A8ZjVWR"
Received: from omf16.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 758B214015C;
	Fri,  4 Sep 2026 18:09:57 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 504002000F;
	Fri,  4 Sep 2026 18:09:55 +0000 (UTC)
Date: Fri, 4 Sep 2026 14:11:00 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 0/4] ring-buffer: Fixes for subbuf resizing and
 persistent buffers
Message-ID: <20260904141100.5225139b@gandalf.local.home>
In-Reply-To: <20260904164450.1345852-1-vdonnefort@google.com>
References: <20260904164450.1345852-1-vdonnefort@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 504002000F
X-Stat-Signature: xnmuhmfb7wwwtz87b75cz9jhoqxwkpwo
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/ZPjNKu2cDWfqPMcRFu1VWHE4gAwL9WLQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=Sd0iZ2CuqVCZCR3NALUu9JKEU/SwN38Oj+GHyZkLxWE=; b=1A8ZjVWRJMRWlHQjN9+0CqgCt1MqxsXft/0QlG01NxvDcTJDZJewP9vWq1H97rDuvjxpV+9AHblrpIg/Q6bT++wha5fgd9hYDeLggnLu/J3GIds7+yZR/IfSfrkZh+rs7LSFwmopCYQgo3iBAiqcZQWMfTum7JJ3R/AZbkYGi7Q=
X-HE-Tag: 1788545395-127414
X-HE-Meta: U2FsdGVkX1971Db5IyBVmS8H7Rdu0fN9lBBBEexQgwf63T3gXtAZcFmhI/N7xe+rqaKIS5xo3gFq2QbgEks4wbaQJqo6QW3a3nFwtLOPneHJy+v1nguQ3nEz/nKo0RHpmF+Q4BD6cxPMxOsfozAvv6dJ+0qBdGPh0GBJLcJCZJwDLfVcUvCH3b/POtL6UK2xzV7YAiytwm22jOsVnK1my3q02EZeL3uP3E3OvAhHuHtEt+y0T5aARXecexHEbsS9YDEKIrM6sMTn1SIIDDA7kEHhuwXQNFjh9ypKBmtgclD1yxxS2GQ2JORjPpJxK/0cwA+1dUnADqAEtDWAzLvhwuA0D27BLXjz

On Fri,  4 Sep 2026 17:44:46 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> I have managed to reproduce a ring_buffer_read_page() race with
> 
>  $ trace-cmd record -e sched &

FYI, running "trace-cmd record" as a background process is "awkward".
Instead I would use the --daemonize option:

  ~# trace-cmd record -e sched --daemonize 
  Send SIGINT/SIGTERM to pid 4633 to stop recording

-- Steve

>  $ while true; do for i in 8 16 32; do echo $i > /sys/kernel/tracing/buffer_subbuf_size_kb; sleep 0.1; done; done

