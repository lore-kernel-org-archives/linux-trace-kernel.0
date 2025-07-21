Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0ACA2BEFFA;
	Mon, 21 Jul 2025 17:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753118359; cv=none; b=H5rEPun9EBvQ/QkofVr8LJwdwyDvoUWvZdYVn3adTr8A+2lYOkcbHAwm046ZZS8BMO+p9YAVfNUZo4MfAuyDfOyN6yiUDheDLdGkmNJ8w0od1VbNNUY/0CMPVjQjwmXF7YWk6exY4kCGvIykSHuh1hbNErSqia0wIKzRQ9pGjgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753118359; c=relaxed/simple;
	bh=BDHEDgvNTuUAwisfO0Izl/rtPuwl6wDFXP2gf5sz93Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gxjm1n0YIeYYbXh5adnrPbOi1wN2SvWngAl8grkOUAtZvnKaiZL0Dh79bXwlrC0lVxz94+HbaCkQavCz/191GQltRyKqToc7jOu9a+qixGGhsUHXifSQyQ3ClSF1lOQDA5NeoZJXLuWaMzo5rg7p4iBc45Cl912HRA4QdEKuZF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id F23D41D46BA;
	Mon, 21 Jul 2025 17:19:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 3770320010;
	Mon, 21 Jul 2025 17:19:08 +0000 (UTC)
Date: Mon, 21 Jul 2025 13:19:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] tracing: probe: Allocate
 traceprobe_parse_context from heap
Message-ID: <20250721131907.436c0671@batman.local.home>
In-Reply-To: <175299250735.418723.6298873768702875564.stgit@devnote2>
References: <175299249728.418723.17799706394466693180.stgit@devnote2>
	<175299250735.418723.6298873768702875564.stgit@devnote2>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3770320010
X-Stat-Signature: icjik38k7d491969s1msng6jjkhurcha
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19YpGSgtdbI4iAIM55khibc4g8sgY5aXlY=
X-HE-Tag: 1753118348-87711
X-HE-Meta: U2FsdGVkX18ctSOfRDgNRlL4eZtAlSgDBBwfdegIdKMKqzjUupEVP4XtU9rqHe+M4FXq9xtBF3Twkk8wrT99ZYwnkfjId2yzfmJjs9Y2oX6eSUk/DGzH49p/oWH694JP6GvO4GRJBIZZjHOdUJ9E0idqhqRcAKQbQj9ehW3xUHmFR/DY5o8rD7GZKI1VI+7bAzjRQTgaxSpq+BX3IEtJ58XLONF+FCcOtxXahsSb4Bf/ed/0UOJ4hopBIyRd3sR2AhJdWfXjDPNK6r5IsKeTqjmDxRDgJ6uR+3Rgx4pozt4hGMNvn7qM3uCzt2k4m0IP0IJd7jVYNsTViRSBvfAz5j0AggJ9iUbF

On Sun, 20 Jul 2025 15:21:47 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

>  
> +#include <linux/bitops.h>
> +#include <linux/btf.h>
> +#include <linux/cleanup.h>
> +#include <linux/kprobes.h>
> +#include <linux/limits.h>
> +#include <linux/perf_event.h>
> +#include <linux/ptrace.h>
>  #include <linux/seq_file.h>
>  #include <linux/slab.h>
>  #include <linux/smp.h>
> -#include <linux/tracefs.h>
> -#include <linux/types.h>
>  #include <linux/string.h>
> -#include <linux/ptrace.h>
> -#include <linux/perf_event.h>
> -#include <linux/kprobes.h>
>  #include <linux/stringify.h>
> -#include <linux/limits.h>
> +#include <linux/tracefs.h>
> +#include <linux/types.h>
>  #include <linux/uaccess.h>
> -#include <linux/bitops.h>
> -#include <linux/btf.h>
> +

A re-sort should be a separate patch, as I can't tell what changed in
the header for this patch.

-- Steve
