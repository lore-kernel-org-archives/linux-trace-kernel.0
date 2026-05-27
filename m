Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A422C027B;
	Wed, 27 May 2026 02:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779848781; cv=none; b=g6JOBhxzrgHTM20KFhYupXNAtck9munhrqpQV189GGeSaPlDWWiJGcXXtGiDegkogPn3rxFz94mU9bXUF5YTbWe6KSYohlTUGsSGBC7FnyGMgvm5WhViVIYHJuld9tjIOGueYWScEGvZjUThyM4n+uALTrq+gsxFJ7Q693n3qew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779848781; c=relaxed/simple;
	bh=QIVq3Y6U/LwZWEB62Ep5N+G48B+/DxSQJDV9/zyktXE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gSEBxvf3q0KfuEvdzNXG0NbrkqkLXzFdBuflQAbekvZ/UEQSa5L7GijWHQaL/E3T4poIGIe609gfUP5s88Q57OxevZhWOxeBSsEWWavh73qkekVyjtsgVdjPsr2odbwkksE3hLyYD0F8cI+ceFa6kM9bYDcBUT5OdatmKjz8oTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id BC3EF120394;
	Wed, 27 May 2026 02:26:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 032C420026;
	Wed, 27 May 2026 02:26:15 +0000 (UTC)
Date: Tue, 26 May 2026 22:26:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Yu Peng <pengyu@kylinos.cn>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org
Subject: Re: [PATCH v2] tracing: Point constant hist field type to string
 literal
Message-ID: <20260526222614.0c3f7061@fedora>
In-Reply-To: <20260527021827.2123529-1-pengyu@kylinos.cn>
References: <20260526215033.78fdac7f@fedora>
	<20260527021827.2123529-1-pengyu@kylinos.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: qohheztukybkd5qjn4niaubttt6ss41n
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 032C420026
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18P4t672dtVd1xMUCqVIuNz1M6Ww5pl9Pc=
X-HE-Tag: 1779848775-386910
X-HE-Meta: U2FsdGVkX197pcdezwAKSVRFY0BYGP/EwjBJ1wm28zhWmiehZV9IOKljVPBb7GMEEXuWQOz3aulx9xDyjuOVfXaPjqo/TrQWzvj4Ak22qTFJWdJb1+k2rJeRcUBk0bZhuT7dcGqgB8QHWmt/q/mag50rdwCpTPZ1K4NohMp6Yr0xw/aL3VYi7njpP/xSV4cZTJLHZlqFKIoyM7Q4FtEFvRSPqiQ+MyDwRKcZPMCIEbl60x/JCOLQcTa8+lFI7EYCo1jREYY5G3SCqEosdnX3P10LtjvaKWsoup5quzCJntUJMCIRAVNZIHUpN+c4TyWN

On Wed, 27 May 2026 10:18:27 +0800
Yu Peng <pengyu@kylinos.cn> wrote:

> The HIST_FIELD_FL_CONST path uses the fixed "u64" type string.
> 
> Point hist_field->type directly to the string literal, matching the
> HIST_FIELD_FL_HITCOUNT path. The release path already uses kfree_const(),
> so no duplication is needed.
> 
> Signed-off-by: Yu Peng <pengyu@kylinos.cn>
> ---
> Changes in v2:
> - Point hist_field->type directly to "u64" as suggested

All new versions of a patch need to start a new thread. Please resend
this as a new thread and not a reply.

-- Steve


> 
>  kernel/trace/trace_events_hist.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index eb2c2bc8bc3d5..b50f2bd5ff771 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -1992,9 +1992,7 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
>  	if (flags & HIST_FIELD_FL_CONST) {
>  		hist_field->fn_num = HIST_FIELD_FN_CONST;
>  		hist_field->size = sizeof(u64);
> -		hist_field->type = kstrdup("u64", GFP_KERNEL);
> -		if (!hist_field->type)
> -			goto free;
> +		hist_field->type = "u64";
>  		goto out;
>  	}
>  

