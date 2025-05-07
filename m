Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05661F462D;
	Wed,  7 May 2025 21:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746653508; cv=none; b=fGCMpS5/uxidhMNQhjJ62eCEjoOa0bJvrIygsuTHzmlqWbinhr8rrzHzt5hfgnSOCeuc4YI5gm2LU3UumySsEz2C13z8G9f+N4PiEcvTPaIKK90b/rntbo6PwZblfgsER40oZheNCjQcvtVtOeh8lpagEmfb8c8uql/Z20oJxnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746653508; c=relaxed/simple;
	bh=xH5gLeeiUR+suOJsrCfXAIHsH03sVcHK/BgckNSY/VM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W3VmnU8QsbsM6P8luwouO+rc1AshYTWrsrfnnRCsjnyllwKLpLmgZieruUDj7EbvwArTkdH3+L3MKYWITXbXaViYR+YNAzoyB+lal9hQRDFfTD5DK764wHJTJZGOa6ZO0xMyjd0j89B7npsKy6wFEvEXazPa1PLTj5OoGjv07v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE97C4CEE2;
	Wed,  7 May 2025 21:31:47 +0000 (UTC)
Date: Wed, 7 May 2025 17:31:58 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Paul Cacheux via B4 Relay <devnull+paulcacheux.gmail.com@kernel.org>
Cc: paulcacheux@gmail.com, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Namhyung Kim
 <namhyung@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] tracing: add missing trace_probe_log_clear for
 eprobes
Message-ID: <20250507173158.254b6188@gandalf.local.home>
In-Reply-To: <20250504-fix-trace-probe-log-race-v3-1-9e99fec7eddc@gmail.com>
References: <20250504-fix-trace-probe-log-race-v3-0-9e99fec7eddc@gmail.com>
	<20250504-fix-trace-probe-log-race-v3-1-9e99fec7eddc@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 04 May 2025 20:27:52 +0200
Paul Cacheux via B4 Relay <devnull+paulcacheux.gmail.com@kernel.org> wrote:

> From: Paul Cacheux <paulcacheux@gmail.com>
> 
> Make sure trace_probe_log_clear is called in the tracing
> eprobe code path, matching the trace_probe_log_init call.
> 
> Signed-off-by: Paul Cacheux <paulcacheux@gmail.com>
> ---
>  kernel/trace/trace_eprobe.c | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
