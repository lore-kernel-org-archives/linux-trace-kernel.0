Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D7729D281;
	Mon, 30 Mar 2026 20:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774902079; cv=none; b=qQL9kMwr6dW0oFSVbu8IfvkUx6lFBPNCTE38M2NFopXOtXwLjlGPTxVHb1bc8r6+5zDKaGaeLUPb5fXOrKU67cOATHnDGCtIYBg9c9jN1jOcfAIgtohcD+dFMBAxO0xXLvbpRXIH9TKXgYrINOLLYe6eEY2rHZiNMRGdo6zqIUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774902079; c=relaxed/simple;
	bh=P/R67gyECQL54AhA4YTYU6DUiotToG3KlJuihXQpxM4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a6aO1IM/07MhE5NXfh01XH3rgYYpNzaGJj6IPByzZaccsPrjEy50Se9P5YDYE37FOKUtrDgU9O5s7eH2sB0v++cv/LO+WIRi+2BhmUXQkm7+SBjvVrWOvDjAr7fQgn8q0UoM7bz81oU6Fbi7kzOWd6+mzKAoWITl4PQZ0usG8lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 4E20CE051B;
	Mon, 30 Mar 2026 20:21:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 622176000F;
	Mon, 30 Mar 2026 20:21:14 +0000 (UTC)
Date: Mon, 30 Mar 2026 16:22:10 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Ian
 Rogers <irogers@google.com>
Subject: Re: [PATCH v14 2/5] ring-buffer: Skip invalid sub-buffers when
 validating persistent ring buffer
Message-ID: <20260330162210.5e37b0c3@gandalf.local.home>
In-Reply-To: <177487500432.3463592.13753720277119177967.stgit@mhiramat.tok.corp.google.com>
References: <177487498530.3463592.12715592581212799257.stgit@mhiramat.tok.corp.google.com>
	<177487500432.3463592.13753720277119177967.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: fuwnrcm4rky961ewdqzsiku6zn7k6hap
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 622176000F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19Vt7wfvacDCK2oqsgNpGE7spLUUxPymuo=
X-HE-Tag: 1774902074-261682
X-HE-Meta: U2FsdGVkX18+DU32duZ6ZLZHGsCBEZSVsBPFA0FZRrkZr5RWzjEWXYSNINjTyOb8RmyBcZNEWMMWJ62vyWShcdai/IgtwS3RM8qQjZsG9aB93P1YoCf0tSmnzfwOJsUR5jkOd+4tQ20OuMBif2vJwQOHJSxi+Ok8ohCtkwwP0o60z9MGtPKi+GnmYWYP8VRyIy5Rhg5HjV/7Nzj3rx8+S4cQ26cNa464N7hoyw3mDibSdTbI7/Y4CtwGGfbkmEN2e+fvTasRIkqD8Za+PIhErMX7w3mPWuFO95ZIHPi5KljHnF9rrzom9p1LIQr8bms7eqnjNkN7GFNzcElCXT1ReV3URz3scaaP

On Mon, 30 Mar 2026 21:50:04 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> @@ -2042,7 +2065,8 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
>  	local_set(&cpu_buffer->entries, entries);
>  	local_set(&cpu_buffer->entries_bytes, entry_bytes);
>  
> -	pr_info("Ring buffer meta [%d] is from previous boot!\n", cpu_buffer->cpu);
> +	pr_info("Ring buffer meta [%d] is from previous boot! (%d pages discarded)\n",
> +		cpu_buffer->cpu, discarded);

As pages should never be discarded unless something went wrong, let's only
print that if there were discarded pages.

	if (discarded) {
		pr_info("Ring buffer meta [%d] is from previous boot! (%d pages discarded)\n",
			cpu_buffer->cpu, discarded);
	} else {
		pr_info("Ring buffer meta [%d] is from previous boot!\n", cpu_buffer->cpu);
	}

-- Steve




>  	return;
>  
>   invalid:
