Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0764E285041;
	Tue,  9 Jun 2026 01:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780966996; cv=none; b=AUsiItqEQzJU3GjXqouuhy9kh1bIx5enEQe4YNgLicnQWAee/mXwOH8FqBQdZoZe8Gig8/9rTM2gAiPNdijD+XTiG2m6W3s6k2Bl9Qw94yPM/kSlzyJA1N+dsdos3P63j+pVjr31NnU8VEe9C48O+/qMRHT+2EQfNZRu+0nMIEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780966996; c=relaxed/simple;
	bh=RpdMb+iDB0M1eq/WD/ujxRwSSDI1HpZ+EWHuWe9IBJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TQv7E3WWRM28fFeSTEgP58Jz4M1i1CnAakb0DRULRymTOnPxHPhcouOKoKbExprYhOlgypFfJZu65rIxupktzrx+asJUkdFk+IGxZDtBgpMQuaTpATPDOWFV1lQhB6q7vu0vhBy92yR2GjRuvUMHcgsVVjjVBAWKYA/IYHKthnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id D90A51203A7;
	Tue,  9 Jun 2026 01:03:13 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 272BE20010;
	Tue,  9 Jun 2026 01:03:12 +0000 (UTC)
Date: Mon, 8 Jun 2026 21:03:24 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, linux-kernel@vger.kernel.org (open list:FUNCTION
 HOOKS (FTRACE)), linux-trace-kernel@vger.kernel.org (open list:FUNCTION
 HOOKS (FTRACE))
Subject: Re: [PATCH] samples/ftrace: reject zero ftrace-ops call count
Message-ID: <20260608210324.6af37e65@gandalf.local.home>
In-Reply-To: <20260609004422.1239735.f6c06011af32.ftrace-ops-zero-function-calls-div0@trailofbits.com>
References: <20260609004422.1239735.f6c06011af32.ftrace-ops-zero-function-calls-div0@trailofbits.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 272BE20010
X-Stat-Signature: gmfbug3jmxph479m7psxfpcexfa3r51j
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX194P2UJhffN29Z5zL7p9gQw4TJxME9TiIc=
X-HE-Tag: 1780966992-323129
X-HE-Meta: U2FsdGVkX18Kxd1cqiU3WjimGaES0ZPrSSyISCxqbcs/niWj2J+6IFChsEjrdLL9mQvjlaIEgSUiaLBAv/gmeUbpPMD3du+P+pZYsui2HkfuJTNkbik3v0JRsmee4ypPg+kFrZyudcCNAKWE9k8LDbBEEgBLkUzBN2HX7uBfQo8dQIAyd+azJw2GlgOhDvPZyIKI0vQkiVeM1tEY3b0jShWT2tD1iD4npxruiHiEXgyRDE66WgNNQtqtTVES2pstua8uJUjuZCwBQQX63RhsTHrHQFSkivALiSIea/GfWNjV2JJfRTTSRWVJb/d0VHMcQmUeEX8IW3CFqVxyWbD9fLTTxuf2PfAbRU5QiceZ3oIR1Se2xjLoqfvawEV9FPs8

On Tue,  9 Jun 2026 00:44:23 +0000
Samuel Moelius <sam.moelius@trailofbits.com> wrote:

> The ftrace-ops sample exposes nr_function_calls as a module parameter
> and uses it as the divisor when printing the measured time per call.
> Loading the module with nr_function_calls=0 skips the benchmark loop and
> then divides the elapsed time by zero, crashing the kernel during sample
> module initialization.

This change is rather pointless, but whatever.

> 
> Reject a zero call count before registering any ftrace ops.
> 
> Assisted-by: Codex:gpt-5.5-cyber-preview
> Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
> ---
>  samples/ftrace/ftrace-ops.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/samples/ftrace/ftrace-ops.c b/samples/ftrace/ftrace-ops.c
> index 68d6685c80bd..d5adaa61484f 100644
> --- a/samples/ftrace/ftrace-ops.c
> +++ b/samples/ftrace/ftrace-ops.c
> @@ -190,6 +190,11 @@ static int __init ftrace_ops_sample_init(void)
>  		tracer_irrelevant = ops_func_count;
>  	}
>  
> +	if (!nr_function_calls) {
> +		pr_err("nr_function_calls must be non-zero\n");
> +		return -EINVAL;

No need to print that the admin did something stupid.

> +	}
> +
>  	pr_info("registering:\n"
>  		"  relevant ops: %u\n"
>  		"    tracee: %ps\n"

In fact, I would just change the output to be:

        pr_info("Attempted %u calls to %ps in %lluns (%lluns / call)\n",
                nr_function_calls, tracee_relevant,
                period, nr_function_calls ? div_u64(period, nr_function_calls) : -1LL);

and have garbage in, garbage out.

-- Steve



