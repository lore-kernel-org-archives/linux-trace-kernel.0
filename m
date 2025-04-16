Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344CD202C30;
	Wed, 16 Apr 2025 15:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744816352; cv=none; b=DT62DUZDh6W9ZYWB8WK0DDXa7TcdrkNJr2xd2kNv2GANm/RapVJrngBxTsaFVUuDbMwUlfA7bZPNWT2Da9lmB5pH+7tubAkWOvcoInBvMeiz1AboN4WLhgyV5lGS2o1FHA11RjmphclSmM2L0XEJCF78919he06HiAVt7zO0h/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744816352; c=relaxed/simple;
	bh=VK5lrtpEit1Cv8gTiR5vDDBJq2339IdvRuBmyJNMw3I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lx3KIY1qZiELNJTASbTaF8s2dHCEimYYByKQzgy/aMqkDLbFIiaddgNxGPHQGufTwL5gw13CYMq4hxyvHbVl8Kj9XTG6VQj4Wn/WisVC5wug2kS9D7bdHOxX3BppXJZ0D6wM1NwTB5GE92HdyRhea18wZaaVztouBr5uWYhDCI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6766C4CEE2;
	Wed, 16 Apr 2025 15:12:29 +0000 (UTC)
Date: Wed, 16 Apr 2025 11:12:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Record trace_clock in last_boot_info
Message-ID: <20250416111227.34299b4e@batman.local.home>
In-Reply-To: <174481479787.2426861.10924329074660376176.stgit@mhiramat.tok.corp.google.com>
References: <174481479787.2426861.10924329074660376176.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Apr 2025 23:46:38 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> Record trace_clock information in the trace_scratch area and show
> it via `last_boot_info` so that reader can docode the timestamp
> correctly.
> With this change, the first line of the last_boot_info becomes
> trace_clock which is used when the trace was recorded. E.g.
> 
> /sys/kernel/tracing/instances/boot_mapped # cat last_boot_info
> trace_clock: mono
> ffffffff81000000        [kernel]
> 

As this will not go in this cycle, which means tools may be built
around this.

Either we put it at the end, or we make it:

# trace_clock: mono
ffffffff81000000        [kernel]

Where "info" like "trace_clock" will be in the comment section, and all
non comments will be addresses.

Tooling can then just ignore the comment section, or read it for more
information.

-- Steve
