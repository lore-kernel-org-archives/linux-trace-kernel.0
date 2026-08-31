Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0664956D2DF;
	Mon, 31 Aug 2026 13:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184111; cv=none; b=nDyi3sFwU8VUwW4dgJK7F2oIDY9h22w0RgybSNk3dJ+cYUvZvM4ELtwjrHWUOWPRBZkHPXVqbIGHszHAapUpM8QACW/gQbdUkWmy1DdH0rGbPtQVAK/F4dIOrnoOJRrDkNKkX2uru2um427kkT50Am5i9tdycBfFxTgdZBf9CWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184111; c=relaxed/simple;
	bh=dLuGJIqkqlXvNS87G/gqHKQ/t9ob90ZWAvEEOjTShz0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cMN5RbftHMTG3Ctknp+E2xYJrM2t+oDsikTvMLocmCfd5piClgHDLI1UjEK61radqC/AVFOvqdquKV0f4giPqrRIVG89DVE7jgwn7fpdJJCCeq61G5wURdwg3rf48eYD0Dc94OsTIXBe213wX/rD2RIA+b4//MzyWoNb7lqcKZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=RHU4u0fp; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="RHU4u0fp"
Received: from omf18.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 4A84C1A004B;
	Mon, 31 Aug 2026 13:48:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 937372E;
	Mon, 31 Aug 2026 13:48:18 +0000 (UTC)
Date: Mon, 31 Aug 2026 09:49:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: <hu.shengming@zte.com.cn>
Cc: <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>,
 <mark.rutland@arm.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
 <rdunlap@infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <ran.xiaokai@zte.com.cn>, <xu.xin16@zte.com.cn>, <zhang.run@zte.com.cn>
Subject: Re: [RFC PATCH 0/4] ftrace: Add task comm filtering for function
 tracing
Message-ID: <20260831094914.50eb26b7@gandalf.local.home>
In-Reply-To: <20260830190743637MhXoixrAPc1rfm-G8eIcg@zte.com.cn>
References: <20260830190743637MhXoixrAPc1rfm-G8eIcg@zte.com.cn>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: tud16fhzi6brbx93myp93kikhrxpq3bd
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 937372E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19m1r7tgd841rNC4J2OH1/70xyKy2342XQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=E7Qwo5ePLec5bmxtjfAHfjkKZHuxg+C6AMNIWgLe5KI=; b=RHU4u0fpgatLeLSAH37hIJSRqCFHTCKmiAkwD6qMIODaMVkzOCWiMVfs/fh8EzrVH8QS23BUZNhBuL5gDoownsxrbLgMPW+Kp9vnxGkuPIn37Hjrnj2DhezRxgPIJ417WDb3pCRUg0XglmCtdMFFkCF53q+oXpJBW+HF4ttZeJg=
X-HE-Tag: 1788184098-707634
X-HE-Meta: U2FsdGVkX1+L0ovwgTB7cgBGTkCClslMXs9MLZL1qW3cbWRDpbY+dJhdw10R0fUCdmO9CJds/HjKZ4DCODLabSim6dPps53+D5CQtPhYRSwUnjeoQ7PIqAfwJMOds1W9ADJ7LgHNlWaPup6zNEkx+b5dknOBlfVXk5iHNq25NyNfrJw/jNFpZ+8bGkAPG7ZHSCV3HGs1pj7oN+gv9WDf7B+rhbT2zyN27GpQs3ig24vmw+O/T9lv16Dl1IE1me7DsORc+SluhD7UIqQgH/4kr2UDELuLIPrZz1BHBsdkpYrXg2QkWyZD1ruXPfNgjidwdY1X6yCTRkwZIZPwcvw7t97Q2mZNuOl4DmQok059l9JfNUO3rAgdCKVwFL+oTjLk

On Sun, 30 Aug 2026 19:07:43 +0800 (CST)
<hu.shengming@zte.com.cn> wrote:

> Hi Steven and Masami,
> 
> This series adds two comm-based task filters for the function and
> function_graph tracers:
> 
>   set_ftrace_comm
>   set_ftrace_notrace_comm

I'd like to avoid adding more files like this. If anything, I would love to
add triggers to the function tracers.

> 
> Function tracing currently supports selecting tasks by PID. This makes
> it difficult to configure tracing before a service starts, because it
> does not have a PID yet. It is also inconvenient to keep tracing the
> same service across restarts, as its PID may change. This use case was
> suggested by Xuxin, a KSM reviewer.

I've always recommended a simple wrapper script for applications:

echo '#! /bin/bash
  echo $$ > /sys/kernel/tracing/set_ftrace_pid
  echo $$ > /sys/kernel/tracing/set_event_pid
  exec "$@"' > trace-me.sh

chmod +x trace-me.sh

  ./trace-me.sh command to be traced

The above will do what you want.

But if we really do want to add more filters to function tracing, then
adding triggers to it would be the way to go.

-- Steve
