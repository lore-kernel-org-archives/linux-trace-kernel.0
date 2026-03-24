Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5338B27AC4C;
	Tue, 24 Mar 2026 21:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774388868; cv=none; b=RH7rsX9nAtofXZj8L3Y6iWlwKFiUN5iyebd34daXwWqDmhPmCjplA3t35+sCVdDM3l3bEMqbnx/l+bW+UC7lJpYH86cBxMl/T/AEJmeOEtF0OG5xu1Tm650xvX+piTxhyHJHgat9IgAWNZnDcB9a10kaeRbyFOTrZJOzM8l8Efw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774388868; c=relaxed/simple;
	bh=aiuCWPg9ARED4td7YLzY2gBeU/W9v8JoXAB5Hft53eM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ernZnjl+R4zWw2V3/u3ZOxJlS1F7mJLJXugOw56MxJ7mmFbxmBEfd6IcMU6no+q2fAlBpINmdhSEcORqIYWGACKR5lFwcy+bZaxRJU6S1txgdSdoP82OT8qFTDJGirXm4+KFw1jM1poYvlCO48bbgYg4MxgV7YMOvkrT4MMYJ/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 2C1B858FB2;
	Tue, 24 Mar 2026 21:40:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id ED6EC20011;
	Tue, 24 Mar 2026 21:40:21 +0000 (UTC)
Date: Tue, 24 Mar 2026 17:41:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>
Subject: Re: [PATCH] tracing: Allow perf to read synthetic events
Message-ID: <20260324174104.59aa31bd@gandalf.local.home>
In-Reply-To: <20251229183632.7b518b8d@gandalf.local.home>
References: <20251217113920.50b56246@gandalf.local.home>
	<aVG2VoBpFoEEE1gG@krava>
	<20251229174901.0e62eab0@gandalf.local.home>
	<20251229183632.7b518b8d@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 8rrj5zenbm9993nswca6uuqwowszpq8a
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: ED6EC20011
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+QbNAZio76NEbN3pyPGbLDCjeXJBY8LdQ=
X-HE-Tag: 1774388421-118011
X-HE-Meta: U2FsdGVkX180S6/jARLFSO0cHGNV+5MKp3CcrZmVRUH0fcxHJyE/qpIJgqI+YcjuFzfd86qvIawYqUTQIqiShX60f7V/xae1uWQ1rTfp71gIrIonxCXY7vx8Zb5D7NfIxdLgrov9JQL3AaljOb98iWAqcGr0F3eHJfXMJZkaIBPCqClVjlNRfNv4OrSLsRAYNFx4lqPiePJ8ugHwZ/p+ww1ZdyQhqY87g1UUPQjmqgRguHW02MZhtziMp+AXVo11jDz0QSQbVJQR02lEgfGDiOzRE6Ti8Cd6ocku9Z6NnblBY6d22W3ZzipSdnFQp3W97zlQR1VOf2kCUcvOiPyeuuk8JPx5gB7QFwT2nQvsn/Wm4U/UX/5ObdIxxUcDnvkL

On Mon, 29 Dec 2025 18:36:32 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> diff --git a/include/traceevent/event-parse.h b/include/traceevent/event-parse.h
> index ebfc2c7..9c1abfa 100644
> --- a/include/traceevent/event-parse.h
> +++ b/include/traceevent/event-parse.h
> @@ -138,6 +138,11 @@ struct tep_print_arg_bitmask {
>  	struct tep_format_field	*field;
>  };
>  
> +struct tep_print_arg_stacktrace {
> +	char			*stacktrace;
> +	struct tep_format_field	*field;
> +};
> +

[..]

So this has been already applied to libtraceevent 1.9. I'll get the kernel
side patch ready for the next merge window.

-- Steve
