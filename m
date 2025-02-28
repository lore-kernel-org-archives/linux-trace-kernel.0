Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F0138B;
	Fri, 28 Feb 2025 01:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740704749; cv=none; b=ZVCF8bMGtZai26aPXnhm8C1kDC9WL6NGWmO8wlKIw3ZUeLDnTk56X7TWb5MBZiJMC/d4qH9J123EoYp+tVFJtz9B0Fd0xCfoMbBZX9Xwl0W6n3xUY/MIuH2yOhUzNCXzVqrg06da2kiXAkTxt2ULTPuzEClDPgrNczxejmk7rAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740704749; c=relaxed/simple;
	bh=polPD8VaEKf+veiscNjndlyOpxGIQ7eRxcTUeyf9umU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LlxcR7rsnzs6lXCk3O9OATH5zN0/40fp/+pMoR74x1jexavfkoUA9W64gcq8Vsbz16mn9WQA/T293pfXRZzcsTxvS/KFt0HmD/3zoDxeEOorjrHFLId5+d7YBa4x/181Pv0+JCd99HSjgSFS7baaFHbd+uGneZGgI7qtV+dJe+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C815DC4CEDD;
	Fri, 28 Feb 2025 01:05:47 +0000 (UTC)
Date: Thu, 27 Feb 2025 20:06:31 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: John Kacur <jkacur@redhat.com>, Tomas Glozar <tglozar@redhat.com>, "Luis
 Claudio R. Goncalves" <lgoncalv@redhat.com>, Eder Zulian
 <ezulian@redhat.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] rtla: Save trace when option `--trace` is specified
Message-ID: <20250227200623.60f20571@gandalf.local.home>
In-Reply-To: <20250127170251.744751-1-costa.shul@redhat.com>
References: <20250127170251.744751-1-costa.shul@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jan 2025 19:02:40 +0200
Costa Shulyupin <costa.shul@redhat.com> wrote:

> +++ b/tools/tracing/rtla/src/osnoise_hist.c
> @@ -981,12 +981,11 @@ int osnoise_hist_main(int argc, char *argv[])
>  
>  	return_value = 0;
>  
> -	if (osnoise_trace_is_off(tool, record)) {
> +	if (osnoise_trace_is_off(tool, record))
>  		printf("rtla osnoise hit stop tracing\n");
> -		if (params->trace_output) {
> -			printf("  Saving trace to %s\n", params->trace_output);
> -			save_trace_to_file(record->trace.inst, params->trace_output);
> -		}
> +	if (params->trace_output) {
> +		printf("  Saving trace to %s\n", params->trace_output);
> +		save_trace_to_file(record->trace.inst, params->trace_output);
>  	}

Without tracing being off, this can run forever if the events come in
faster than it can be recorded. And save trace uses the "trace" file, which
is slow to read.

Are you sure you want that?

-- Steve
