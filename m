Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBCD37FF76;
	Thu, 15 Oct 2026 11:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792065465; cv=none; b=K0GCobnglQHWB2yKhGMWbZSn0PFl2tEIh2muQgmPkrLOt9jws9ZZWIp/t5Mp//MIdGCQwzF3FIu+3oPqlbCAY4ICWH0RH8PcOGcDWAChrMjcNXALmTlivOH+A9wx5qmLgNH+nJ9/rBT+3NWsXQ3XOCH8m/tUHFrWP8SSx8OCajA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792065465; c=relaxed/simple;
	bh=JvXuenLF+b4xhhHq/Bj6Qgdd2Ert0xvkhcOU/N1WslE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PcXmnvpHeLiZJgzryxqS/dnTfgg91LCHhOZ7/CS/ppWLckpYsdkz5HVYsHlKIFz8erzaxdFZ9Jn5MGIJT7K+VZHwbOTUWg9Qs3X1GqA0fuOjeTN/2pJiwRieXrM1yYdwgEnSQD4qnbfX09yVh9OzMAUhF+MQh+T5+v2tiHlNuZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=xca9RJb7; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="xca9RJb7"
Received: from omf19.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id ED9694096A;
	Thu, 15 Oct 2026 11:57:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 3034B20028;
	Thu, 15 Oct 2026 11:57:34 +0000 (UTC)
Date: Thu, 15 Oct 2026 07:57:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Haoran Wang <haoranwangsec@gmail.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH] tracing: guard trace_event_get_offsets() against an
 empty fields list
Message-ID: <20261015075732.1a0e9bc6@226.227.38.69.naturalwireless.com>
In-Reply-To: <6ad09433.a938ce27.3282d8.5f98@mx.google.com>
References: <6ad09433.a938ce27.3282d8.5f98@mx.google.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3034B20028
X-Stat-Signature: ejoof7f6f8oqzac41io641x48esrfp15
X-Rspamd-Server: rspamout01
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19OUN7WkzHlOs53F9zVA40E+/55SaVuZtI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=j7W61aF5OzwBAsCJAucTc4mWUWmR61vJ7Wwj6/Y+xpk=; b=xca9RJb7FGXBzPM2xn+iE6xX7RM2QDkKZ5B0/i0+06Wh/UabElyQl4jdo3xoQ+P/GAxVZLH6DIgCaHLoxA8+nzUH3bT149qF15LouOSFEnt9G3p8pNWA7XBNCElhoOPUfZ0V39vIzbQDp99aJV/KgP/IVONpcRVwXebNaW9lMcQ=
X-HE-Tag: 1792065454-742779
X-HE-Meta: U2FsdGVkX1+k4SgGr+Hy7+Z4GV43WpU5PzMjsKwYWvsKIwanR3dadvwKMQy02EaV7sDkY9E6YWdIatGTWBvQ9pPTlFXzjgSqTVui/Af8e4UYTQjy5vfQ4YfSt9XDioUkqW1WUgBF/sdttays6ZmYRY+788RHMCpZaX8o0ah9GFr9Ow0NTt09aVaFoav+GpUJ24poPRogaN+iOm2NnG9beNqvGZ+K4ZTgHmo2xPQRW2QPu896iuPUDyRWGXkwpjJN2hiLIZ4ULdJPbxUwHpNIji+iE1wnm7TrbQlHMOlKOwLbu2RsDLU5fucyfFr4kd3ZICYZojp2oBLoh0aaBNph1Efl71eoehUH

On Thu, 15 Oct 2026 16:51:58 +0800
Haoran Wang <haoranwangsec@gmail.com> wrote:

> 6. Proof of Concept
> 
> The reproduction runs on 7.2.10 kernel. A custom-tracepoint module
> (zerofield_mod) registers a zero-field tracepoint (empty TP_STRUCT__entry)

The real fix is to reject any event with an empty TP_STRUCT__entry.

-- Steve


> and places an inert 64-byte 0x53 sentinel in .ref.data right after the
> 72-byte event_class global (GCC lays out same-section statics by
> descending size), so the kernel's OOB read of class+84/class+88 picks up
> 0x53535353 instead of zero section padding. The sentinel is inert data --
> it does not change kernel control flow or inject a bug; it only makes the
> pre-existing OOB read's effect observable (off becomes non-zero instead of
> silently zero, the latter being indistinguishable from a fixed kernel
> returning 0).

