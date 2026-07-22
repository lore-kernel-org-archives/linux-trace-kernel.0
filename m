Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267272E7657;
	Wed, 22 Jul 2026 00:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784680710; cv=none; b=YnYhTTiVyv2ptkFRklMXmu47deuFSG4g7a/g9/2PD/czdx+37St2rgZpqu1wlmYEgYck9zEubYOAjJN8ZSopBtwEZWjitqTDCfUSCIvmzYd6D0KT2H+xvLXZE2rOWnffss2+p/K2/UKJFv2ugpf/tBHs/PGl5uuc3Ib97him0Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784680710; c=relaxed/simple;
	bh=fmsCm0zbXlV99y01YVhqqI2OO2lG34WJO2ByvwJo5To=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IFoJQM9b66tXWpuLgRPXXetCDY5YVc9hsu0mPky/yayaKhcLZFAv1rM9dMEj7dpUA7ZPOFDBlz5rRRX2+uWML03seuwPI/+uDYeFp7cuf99m8y9WPvk6PbggoQQgWR2P+qP9jT/7+m8rPnV76KlyfIoCJ6b+Mp5UM9Az9L6XO4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id AE4E2C0210;
	Wed, 22 Jul 2026 00:38:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id CF0432000F;
	Wed, 22 Jul 2026 00:38:24 +0000 (UTC)
Date: Tue, 21 Jul 2026 20:38:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: deepakraog <gaikwad.dcg@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Pekka Paalanen
 <ppaalanen@gmail.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/mmiotrace: fix resource leak on trace_pipe
 close
Message-ID: <20260721203843.65d06a69@gandalf.local.home>
In-Reply-To: <20260715143604.14481-1-gaikwad.dcg@gmail.com>
References: <20260715143604.14481-1-gaikwad.dcg@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CF0432000F
X-Stat-Signature: tzgaoodpiywcy7suk3oj5zh1pomkugd6
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18LevLbhgbI1GVSjSGxOxREKAy8FfMl4jc=
X-HE-Tag: 1784680704-557893
X-HE-Meta: U2FsdGVkX18qsG8OY0Cam/g13cNxjAGZ/TUK9+JgEp4sXRiL2RRe2CfSwsA+jXxVHGQ/y/+jh1LwhW7PeRQySgY2Xjjc933ToFli1SCA5bHuBgUzU4iZdcRxMG6iOtMNCwt+NNQ1ibMG8rJFkb/yu9WK5ty2OFsJN38Op8tCNJd1niqqonUGoEAMchOcoR5Csv/8E2lsq8IrdlcbGt7HH3kWykvzUV4MGWYWNaHfa0OhnzTtOAVpAtlioDdcM4ZQ+E/vSRtfNWnpjvS/MU+mlU58mRcwn3SCcK5BE0gB2L92KKs4ZGAFjl2wf1+/INvwjekBqnUu1/GW5enrpnHL6QaBXQpHDKGs

On Wed, 15 Jul 2026 20:06:04 +0530
deepakraog <gaikwad.dcg@gmail.com> wrote:

> mmio_pipe_open() allocates a header_iter and takes a pci_dev reference
> when trace_pipe is opened. mmio_close() frees them, but it was only
> wired to the tracer's .close callback.

Were you able to trigger a kmemleak?

> 
> tracing_release_pipe() invokes .pipe_close, not .close, when the
> trace_pipe file is released. As a result, closing trace_pipe with the
> mmiotrace tracer active leaked the header_iter allocation and left a
> stale pci_dev reference.

It would be good if you showed how a leak can happen, as the mmio_read()
does clean up the descriptor, making the above statement incorrect.

> 
> Set .pipe_close to mmio_close, matching how function_graph wires both
> callbacks to the same handler.
> 


The mmio_read() will free up the descriptor if you read the trace_pipe file
until it blocks. But reading part of it may trigger the leak. Such as:

  # head -n 1 /sys/kernel/tracing/trace_pipe 
 head: /sys/kernel/tracing/trace_pipe: cannot seek to relative offset 0: Illegal seek
 VERSION 20070824

and running that over and over again will produce a leak caught by kmemleak.

I'll update the change log.

-- Steve
