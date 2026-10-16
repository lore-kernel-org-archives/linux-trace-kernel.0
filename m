Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04B94E323C;
	Fri, 16 Oct 2026 14:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792160045; cv=none; b=ICaOhJZ7xrwhRfXS7NVMZi19n6VNa4jsekZUKC/+jFM0UzHHiB+aY287+ljHTfLkkp8wBGkZdAr2rgld+aCfaB3zMGBZTNJfcN2Hr+Qf2wCymnDgBbiUh8jDJ1qVReKx7o70b4kCcXRkwB3V1yG7fMW2Nl/ONeaehoWDeroQ5kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792160045; c=relaxed/simple;
	bh=b1kiO+OT+f67PGuMMnO46zAAzj5T0SNAahxE8VuMRgE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B9R7A9cfO33uU/Po5MqHWcpVpf77CSJLHQKuUtXnGjYhx381/v98YBMO7xtO2swWw0T6gazVEFZHVbFd/LpfKcdFIl5frNLMfJEJ2rI2w1WU9qKKyj7eYolXiWvhqkMs7uzaZSDzndTIsaJzgyosz5sLjPgiNXbToESiImsZLl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=wgANTwKl; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="wgANTwKl"
Received: from omf05.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 07EAC12046C;
	Fri, 16 Oct 2026 14:13:58 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 3D1DB2000E;
	Fri, 16 Oct 2026 14:13:57 +0000 (UTC)
Date: Fri, 16 Oct 2026 10:13:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Haoran Wang <haoranwangsec@gmail.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH] tracing: reject trace events with an empty
 TP_STRUCT__entry
Message-ID: <20261016101356.6b9f2a82@gandalf.local.home>
In-Reply-To: <6ad1cad5.856c1b21.18f9b7.a2c3@mx.google.com>
References: <6ad1cad5.856c1b21.18f9b7.a2c3@mx.google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: oukdzmp7p3puep55eih4y1ka1dnnx9gm
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 3D1DB2000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+TBVl4n+IEBA3U5ER0P/p0SW0ap0Wn0SU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=lI5DjuexGRZN1Av8GqHxjbE1/reoZ/RPViBWT9P2oDs=; b=wgANTwKlk1Nhx7myUF/B/0A4ZFy0O6LBy0hqWYBOInP7WYxPNqfNC1tOKLmsoSkNEbzKYTnkQYatQ9Ab5pPQt2Lu/Qp6J6tq2HZrMJvY1+vjexoTaF0NLWXVuV3tU9VUJHKnndgLqGXGsS+m8k1siVndzwVkrq/v0fHDpECrzFE=
X-HE-Tag: 1792160037-230736
X-HE-Meta: U2FsdGVkX18EBA7KiuKVGMa9HxEionb+URtUGmeJg28dERRXoFTEhchAR1h/IxG4SKSWo2ZTdP1CAaWWOuUJPoqj/UBtGjZ+x8tTRl1bIYOiV3LqyA3XvAMjnIy/PNEh3QVpdlL9885IXpeIckT9ENUzjvzI+lGpz3+0cWRtqqU4sleM97f+mV1JvnC1l9VrrF9jhdvTXmm4Dcz0UlyqaKrY10cEof2SCd2vW7Ca7SChwe/Vqd2qyM5i83JGaXaxJouvVD3FOCdhCBXzSjKR/XzLki+cglDXI3SWBk1NvczI0ZdOgk6k2E+w0qkMSETe3azQN+L9sO+3/1FZArqTt8x0GpmSt/de

On Fri, 16 Oct 2026 14:57:22 +0800
Haoran Wang <haoranwangsec@gmail.com> wrote:

> From 0000000000000000000000000000000000000000 Mon Sep 17 00:00:00 2001
> From: Haoran Wang <haoranwangsec@gmail.com>
> Date: Fri, 16 Oct 2026 15:10:00 +0800
> Subject: [PATCH] tracing: reject trace events with an empty TP_STRUCT__entry
> 
> trace_event_get_offsets() unconditionally dereferences the first entry of
> an event class's fields list through list_first_entry().  A tracepoint
> that declares an empty TP_STRUCT__entry never populates that list. Its
> fields_array holds only the terminating sentinel, so list_first_entry()
> returns the list head itself and the following tail->offset + tail->size
> reads memory past struct trace_event_class.  The corrupted result is
> then used as the BPF context-size bound in __perf_event_set_bpf_prog(),
> which lets context-reading BPF programs attach to a zero-field tracepoint
> when they should be rejected with -EACCES.
> 
> Reject such events at registration to fix this bug. event_init() is the
> universal chokepoint invoked for both early-boot and module events, and
> its return is enforced by __register_event(), which refuses to add the call
> to ftrace_events.  An event whose fields_array[0].type is NULL (the
> empty-TP_STRUCT__entry sentinel) is rejected with -EINVAL before
> trace_event_get_offsets() can be reached.
> 

BTW, what bug are you trying to solve? Just some theoretical bug you found
from a static analyzer or AI?

-- Steve
