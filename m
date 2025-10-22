Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F6B35B121;
	Wed, 22 Oct 2025 16:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761150762; cv=none; b=HVaAD1DLjVFpKubYTly/kM2B+GBwZon7XqJk2KK23Gh3rfArSCWjqDmpYH5GUUsOQqOI0XSUCItILE7diXjhW/6rxECmIMieapPj2/W0Ixt69Xd0Z3mmgItdOLUg/zJ9c5kIeOmrE1A0yyrcqlW0HNcrDxyk7DjRoVRuxLziUKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761150762; c=relaxed/simple;
	bh=Rabe9jUuVL6lmA4d/LYRw8joJ8siQMuCn73qAvRcDYg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VGHPpEnO07TcPZU0f/7NWpzfxhHT3C9P2nlGIZnM8hLfLPi7Z0U9VdntP6/wjG7tip1tjc6EbcLVtOPcNrW9+jHO3QdLiESy2csUiuNGxzr4iG6zK6Bmc74LcsfJiK1EyhHOR9zo86tX5QFsox9daMAWaLvQZ6bMmdk+sy3ZUg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 2080788C98;
	Wed, 22 Oct 2025 16:32:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 5A59F17;
	Wed, 22 Oct 2025 16:32:35 +0000 (UTC)
Date: Wed, 22 Oct 2025 12:32:59 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] tracing: Add an option to show symbols in
 _text+offset for function profiler
Message-ID: <20251022123259.59ada139@gandalf.local.home>
In-Reply-To: <176114749146.315239.7968358300215825393.stgit@devnote2>
References: <176114747153.315239.6863821259073466010.stgit@devnote2>
	<176114749146.315239.7968358300215825393.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: u5mptu14riymcqi7hzzpmo9o19uinth3
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 5A59F17
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18uuuJWouDJhM0SKC4/KiNJCN4drf9VQ3I=
X-HE-Tag: 1761150755-921461
X-HE-Meta: U2FsdGVkX1//Qbs0RgUySDwaAPXDS8SNn6repQBp8bBiFvuHJIprS8dMO6gsOD6z4yPHWo+6moSoPK6AzhdRXffXUj337KLEuLvh6XQKB9oQ/aqyChoVy1iLbTR2jZJ0z1F+f3zhdCllygrmdwzxMqL8iFfr9GQVU4C+7nizWCV+jY0soaotXOBNV6qgW5+6KAlHM77DC71+T7rB5Dsjt4WkahZy99lkpkNnHOv+exfZi4fSvmIq+RAaLiPShi9TzUcEz7FPbFChP8Mbqc0jCzZOaD7/JMAhE8QFa/t41EmrMY2Kue4fWUSyeZ/Uevgalv3JDtNa2zVGgjWBn8iQiEa3qEvDejSf

On Thu, 23 Oct 2025 00:38:11 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> @@ -554,7 +556,29 @@ static int function_stat_show(struct seq_file *m, void *v)
>  		return 0;
>  #endif
>  
> -	kallsyms_lookup(rec->ip, NULL, NULL, NULL, str);
> +	if (tr->trace_flags & TRACE_ITER(PROF_TEXT_OFFSET)) {
> +		long offset;
> +
> +		if (core_kernel_text(rec->ip)) {
> +			refsymbol = "_text";
> +			offset = rec->ip - (unsigned long)_text;
> +		} else {
> +			struct module *mod;
> +
> +			guard(rcu)();
> +			mod = __module_text_address(rec->ip);
> +			if (mod) {
> +				refsymbol = mod->name;
> +				/* Calculate offset from module's text entry address. */
> +				offset = rec->ip - (unsigned long)mod->mem[MOD_TEXT].base;
> +			}
> +		}
> +		if (refsymbol)
> +			snprintf(str, sizeof(str), "  %s%+ld", refsymbol, offset);

Let's be consistent as offsets are printed as hex every place else:

			snprintf(str, sizeof(str), "  %s+%#lx", refsymbol, offset);

Also, did you mean to add the '+' after the '%'?

-- Steve


> +	}
> +	if (!refsymbol)
> +		kallsyms_lookup(rec->ip, NULL, NULL, NULL, str);
> +
>  	seq_printf(m, "  %-30.30s  %10lu", str, rec->counter);
>  
>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
