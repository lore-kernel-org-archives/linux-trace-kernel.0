Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90A71CAA78;
	Mon,  6 Jul 2026 17:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783358138; cv=none; b=tFgnwSINBDK2yDzqjcuWRPjS+1llfgDyh/mAuK44ktl0vFCETS1ov/5Z9EAYjHpJwvxJlVp0fQD1nQ8qIKqLyIX/afU4dunpkPQY4Y0SS7QEXlXuwUFFRZwiSlzj1DkFNXIRxHzRM1k4D9Mdq4UI8c0mIili+IO5scWXmsAsY8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783358138; c=relaxed/simple;
	bh=JVwFr2kGA3h+tzeDHjrCglcB1Mr08Qzx5u7yyhyYk2g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XRZtlrSQ8oHyndbvvDDer6f3imnxTHtq3eqHXM0H6afMaxBwpu9OHVYx1zmAQdEn1/HOKD0Zthv32hDkxsq9WPs3y4VZYwpB6lCYx+TEjySOpuVDTRefDp3SD1JvACRmDcHX4gW5oRXKYZVb5VTFmP1RP2OwpEW0IQLTet0lt94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 8D480401B3;
	Mon,  6 Jul 2026 17:15:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id DC65C17;
	Mon,  6 Jul 2026 17:15:33 +0000 (UTC)
Date: Mon, 6 Jul 2026 13:15:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Yu Peng <pengyu@kylinos.cn>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] tracing/synthetic: Free type string on error path
Message-ID: <20260706131534.70e602ef@gandalf.local.home>
In-Reply-To: <20260603062533.1096320-2-pengyu@kylinos.cn>
References: <20260603062533.1096320-1-pengyu@kylinos.cn>
	<20260603062533.1096320-2-pengyu@kylinos.cn>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: sut9xebi1mhffbge9z7tpnztowak4k9u
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: DC65C17
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/+6WPttl1sNsyg81OQeiCztfWtLQML+GU=
X-HE-Tag: 1783358133-541007
X-HE-Meta: U2FsdGVkX19xumJVg3GGNHTpJ06Atd0Dot5cGW/MrAuq1URqAksw5lcoyjzXWeKdvkCldbS7FV8+3ZYzW/r9IPAmdlvf8OOAIk3zZGSS3c9H4RYJlselVDFZXt3L2MWW9c2iTpd6YLsu/LAuboyDvjg1/uP3S2NrBE9o5kf0JJgLFro0jBVT+rRKySSCnGr+CeZlWuJrxISjybSwIyLxAWbHIFkkz65UoaXMYLrd+doyXqTtdZTh6LhA00gJy8n8LH1UB3yGlenysL6B1UR1kah5SnBM8EaI5upwM+IF147WWnoZRFggN5agGkB3+K2i

On Wed,  3 Jun 2026 14:25:33 +0800
Yu Peng <pengyu@kylinos.cn> wrote:

> parse_synth_field() builds a "__data_loc ..." type string before
> assigning it to field->type. If the seq_buf check fails, the common
> cleanup cannot free the temporary string. Free it before leaving.
> 
> Signed-off-by: Yu Peng <pengyu@kylinos.cn>
> ---
>  kernel/trace/trace_events_synth.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
> index cdd5b93328358..dc15658a887cb 100644
> --- a/kernel/trace/trace_events_synth.c
> +++ b/kernel/trace/trace_events_synth.c
> @@ -839,8 +839,10 @@ static struct synth_field *parse_synth_field(int argc, char **argv,
>  			seq_buf_puts(&s, "__data_loc ");
>  			seq_buf_puts(&s, field->type);
>  
> -			if (WARN_ON_ONCE(!seq_buf_buffer_left(&s)))
> +			if (WARN_ON_ONCE(!seq_buf_buffer_left(&s))) {
> +				kfree(type);
>  				goto free;
> +			}
>  			s.buffer[s.len] = '\0';
>  
>  			kfree(field->type);

Can you do this instead?

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index cdd5b9332835..7ff0f00edbdd 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -828,7 +828,7 @@ static struct synth_field *parse_synth_field(int argc, char **argv,
 	} else if (size == 0) {
 		if (synth_field_is_string(field->type) ||
 		    synth_field_is_stack(field->type)) {
-			char *type;
+			char *type __free(kfree) = NULL;
 
 			len = sizeof("__data_loc ") + strlen(field->type) + 1;
 			type = kzalloc(len, GFP_KERNEL);
@@ -844,7 +844,7 @@ static struct synth_field *parse_synth_field(int argc, char **argv,
 			s.buffer[s.len] = '\0';
 
 			kfree(field->type);
-			field->type = type;
+			field->type = no_free_ptr(type);
 
 			field->is_dynamic = true;
 			size = sizeof(u64);

-- Steve
