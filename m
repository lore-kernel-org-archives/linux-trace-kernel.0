Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169573101B2;
	Wed, 11 Feb 2026 17:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770832319; cv=none; b=DP4uktaVaH0HpCoKdXq61Hh8ZGiQGG3P44wEGCHkoc51FOLpO9OiT+m1HcedHLyBYV+CsF8K8ldQj1JxjwfPCdKbwtExpeWkkEboFtlgczi1Rf/CNXDPCLZkBCVNstfD32Sp9bAjCZB/vpedei+74LCSTayvSaDi9ftzlmbp+As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770832319; c=relaxed/simple;
	bh=xYME3Z5GQxv0iPTN2BPEgiM3McXm1DAIOCT/iNkJGRM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=spQ6UDF4VZ+JyarK3djFBXV9zAUh25rYtY7e89iG9bZMj2TpywazD8Dm4RR2Ao25Jx1BkcH7ilcRHTETtQvK7PJMKlaxZS45P5ZSgUdC/S58Rz5q5yEP1erjyytxaif94S+ydnn7P2M/qKXvjT52KLgKs2YxwiJFVFb2HL08Lgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 6988AD6A5D;
	Wed, 11 Feb 2026 17:51:56 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 5E16A20029;
	Wed, 11 Feb 2026 17:51:54 +0000 (UTC)
Date: Wed, 11 Feb 2026 12:51:52 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Tom Zanussi
 <zanussi@kernel.org>, pengdonglin <pengdonglin@xiaomi.com>, Shengming Hu
 <hu.shengming@zte.com.cn>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: make tr->d_max_latency accessible without
 CONFIG_FSNOTIFY
Message-ID: <20260211125152.3afe6e4f@fedora>
In-Reply-To: <20260210141310.1605322-1-arnd@kernel.org>
References: <20260210141310.1605322-1-arnd@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: jgyewzorknnd5fs39g63ey8tjf1ofqer
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 5E16A20029
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+1ZX3eoNvMFGDdxRzDCOXtARdJcSZV8fA=
X-HE-Tag: 1770832314-420280
X-HE-Meta: U2FsdGVkX18/F5D6/SXxQ183LzG7dRgGkHYXkQp68hUD+j/3OK+kCgLgfJ6qObqiDIhyBidTEMztHn9nc+Tm6sCclcnjMuInrvt00jDvH4rZvQNdAHsAfzyWx+LNDEGZwSfwWr4EAYutC44wceLa/L+b9emyhfhjLWHYmSyEk6j52F4XypPQDvreI7bWdb/OEysWEc23e6S574s6zNZAkoi+/cI/0gu/EDnh3l3vmCMPAxS42WAomsCURMdddmpJ6WSTWBqynhAWr2WV3ZZVTGWkRkvdloP4iZ8S5JF6SzyLgBmWcW/XucCUyqcZUe1GtOl2xRh6lubb1Sr09oxmrZpcBg1Gl+ra

On Tue, 10 Feb 2026 15:13:06 +0100
Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> A recent change attempted to make the tracing_max_latency file visible
> unconditionally, but this lead to a build failure:
> 
> kernel/trace/trace.c: In function 'trace_create_maxlat_file':
> kernel/trace/trace.c:1543:13: error: 'struct trace_array' has no member named 'd_max_latency'; did you mean 'max_latency'?
>  1543 |         tr->d_max_latency = trace_create_file("tracing_max_latency",
>       |             ^~~~~~~~~~~~~
> 
> Make the corresponding change in the header file.
> 
> Fixes: ba73713da50e ("tracing: Clean up use of trace_create_maxlat_file()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Beat you to it ;-)

 https://lore.kernel.org/linux-trace-kernel/20260209194631.788bfc85@fedora/

-- Steve
