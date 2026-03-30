Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81527377015;
	Mon, 30 Mar 2026 16:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774886665; cv=none; b=gVpdeCmzDgr1cFG0kwSKtzlgbYeaO+UpJjd7R0WkqgnsUe3UzI0Vubr+g++3VInqjoKTzMUgBo+RRb/NAbSxMsU11Aimf1TP41ZYlvk1g/Tj+cFN/55InTT3IRAFIBiHabH5B/7KgcKnh95PmAEEKpZslZw1FUO2kzEKkwjUU/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774886665; c=relaxed/simple;
	bh=ELf21Y5f7587GI8SKKaMOH/3cFn9GWaccoGl2rrnoac=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tpPWqwDoK0qMQCPwQbeIBdET0IAvQFgQvI8yPivSItuQLYyVHQdtU8AWdBfxJHbFTUgZsU/OR02Y33uxvVkqGOEl8yPWc4FVbny5QtBF19VAaUs67VLwu1bvFONM0l0hel5CkWWvu0ssJ4nxWb8nydXDp1ex9/3gHVNzZcrwtP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id C1D2E59133;
	Mon, 30 Mar 2026 16:04:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id A68C818;
	Mon, 30 Mar 2026 16:04:20 +0000 (UTC)
Date: Mon, 30 Mar 2026 12:05:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "kernel test robot" <lkp@intel.com>, LKML
 <linux-kernel@vger.kernel.org>, "Linux trace kernel"
 <linux-trace-kernel@vger.kernel.org>, llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev, "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Move snapshot code out of trace.c and into
 trace_snapshot.c
Message-ID: <20260330120516.73aede9b@gandalf.local.home>
In-Reply-To: <8580f943-4c37-4c66-937d-adee13b72201@app.fastmail.com>
References: <20260305211810.3f48aa07@robin>
	<202603070230.Zz4BBLtb-lkp@intel.com>
	<8580f943-4c37-4c66-937d-adee13b72201@app.fastmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 39uojos57saj6potqt3mjjtm3xytrezz
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: A68C818
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19o0Dr7UWd35wr6cMG8+TAaj7KnT9PlbX8=
X-HE-Tag: 1774886660-238916
X-HE-Meta: U2FsdGVkX18otMBCyLY8DhR+ef/nR9LxqbeVPNSRgt2kG8G8jiM6jMmGaxrtVFYm3T2RrHE27368MwnXOX6wYiiYvnKQzDJERF+znI8Clwraj36qvrn+8efoFP7m0ZRpv7ZBrjiDXk3yJNzwQ3wuoW6eNND0YSZZTr9wzZ3HA6JWdc2QKB1I2ZJ+GwpWS6bnmJzIt8v65/SNDCOjJbS7iPnS0NsLA1MVmrSgiyKa8wW7uWVkqJznIsS4Vml0WTrvbkdSThULBO/OcvufSbyIZiRCk39dAKmHNpH0fLYbB5EqNGyqp1JcXgdopoWxH7Ff

On Mon, 30 Mar 2026 16:06:44 +0200
"Arnd Bergmann" <arnd@arndb.de> wrote:

> I saw the same thing and worked around it by removing the function.
> I then noticed that a bunch of code surrounding it is also unused
> and I removed that as well (see below). This version passes
> my randconfig build tests, but I suspect it is still wrong,
> since the code never had any callers and I don't understand
> why.

Note, this code is in include/linux/tracing_printk.h, and is for debugging
purposes (just like trace_printk() is). Hence, it shouldn't be removed.

The purpose is to call tracing_snapshot() when your code detects something
isn't right (but it doesn't crash), and this will take a snapshot of the
current trace that lead up to the anomaly.

If anything, I should add more to Documentation/trace/debugging.rst about it.

-- Steve
