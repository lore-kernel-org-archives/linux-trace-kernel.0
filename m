Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9469F1F03F2;
	Tue,  7 Jan 2025 11:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736248962; cv=none; b=mk38O0qdPFpiqGespXpGIWXmt6Vindc+N5QlCgTvLiT6lWkdrG2O6XrneZ6U+taT2beJWbTYBj3/GQVYT7xQXz5vKxDAieuBT/PBq06Xfx+IP3YEmcsASVtvvu5UVGOs/iPaDj6kZhEM4eO9e6HIbx2Yf+1Kxq5Ogw1rQ73s8Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736248962; c=relaxed/simple;
	bh=Okr1BPbiXrV1iuvByzgwvFa043Rr20prjpsfQ65PMNE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XgcjMt0JCyGQE/xl2cSg1T30t7zX5iZxD40vS0gLtPwSpUkr9xivoUYkbUmlnqfrjvDvxwvFQqGpE5ZMnBNMQ47eRnrimJFk28pNUtX4+MPx/7A1RvEQ0dQQqfsfD4O8/WG/WbqZfdHaiylVJ4aWasGQYI7lK1Pq1NyZOtVtGxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klfiAlYm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klfiAlYm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC970C4CEE1;
	Tue,  7 Jan 2025 11:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736248962;
	bh=Okr1BPbiXrV1iuvByzgwvFa043Rr20prjpsfQ65PMNE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=klfiAlYm6jv7rH2bSgwHn0qq0eoeMT/ANmyS5VG5/EtNJpI0qHJ+Rb25oJxYvt+1J
	 CVxYq0OB3uCHPKLL5h1evUWaAndMzBGhG48PY+zyMIShEvgbJ8LccDAnbtrx1Mfg48
	 dQce93yJg1E9hXU42a65CfLHpIWz7GNF+9GUBXSiKwJoDR9SHlIc9f4lDCHlTOIXGv
	 TLaUwXF+z93U4EUrvOhc3HD2j1cSqIemQXKr+GxJdFFem0AiqusuzKAWPFaNrokK24
	 3iBbrwBPUaXNCkeLS47KujZ0yjYF5DK7ohYv2UdO+p2sIEJosXSI1ToYxBCi+0+KP5
	 jZdD6sW9jhGZQ==
Date: Tue, 7 Jan 2025 20:22:36 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra
 <peterz@infradead.org>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Oleg Nesterov
 <oleg@redhat.com>, Tzvetomir Stoyanov <tz.stoyanov@gmail.com>, Naveen N Rao
 <naveen@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron
 <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] tracing: Use __free() for argv in dynevent
Message-Id: <20250107202236.6fbb4ad2a93e18f2db8e862f@kernel.org>
In-Reply-To: <173617940696.1366315.9993763922773507683.stgit@devnote2>
References: <173617937395.1366315.17590944219163017504.stgit@devnote2>
	<173617940696.1366315.9993763922773507683.stgit@devnote2>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  7 Jan 2025 01:03:27 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Use __free() for the args allocated by argv_split() in dynevent.

Lol, the same one has already done by Steve.

https://lore.kernel.org/linux-trace-kernel/20241220103313.4a74ec8e@gandalf.local.home/

Let me drop it.

> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Changes in v3:
>   - Rename to __free(argv_free).
>  Changes in v2:
>   - Rebased on probes/for-next, which reverts previous dynevent guard patch.
> ---
>  kernel/trace/trace_dynevent.c |   23 ++++++++---------------
>  1 file changed, 8 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
> index 4376887e0d8a..78242ea6fb30 100644
> --- a/kernel/trace/trace_dynevent.c
> +++ b/kernel/trace/trace_dynevent.c
> @@ -74,24 +74,20 @@ int dyn_event_release(const char *raw_command, struct dyn_event_operations *type
>  	struct dyn_event *pos, *n;
>  	char *system = NULL, *event, *p;
>  	int argc, ret = -ENOENT;
> -	char **argv;
> +	char **argv __free(argv_free) = NULL;
>  
>  	argv = argv_split(GFP_KERNEL, raw_command, &argc);
>  	if (!argv)
>  		return -ENOMEM;
>  
>  	if (argv[0][0] == '-') {
> -		if (argv[0][1] != ':') {
> -			ret = -EINVAL;
> -			goto out;
> -		}
> +		if (argv[0][1] != ':')
> +			return -EINVAL;
>  		event = &argv[0][2];
>  	} else {
>  		event = strchr(argv[0], ':');
> -		if (!event) {
> -			ret = -EINVAL;
> -			goto out;
> -		}
> +		if (!event)
> +			return -EINVAL;
>  		event++;
>  	}
>  
> @@ -101,10 +97,8 @@ int dyn_event_release(const char *raw_command, struct dyn_event_operations *type
>  		event = p + 1;
>  		*p = '\0';
>  	}
> -	if (!system && event[0] == '\0') {
> -		ret = -EINVAL;
> -		goto out;
> -	}
> +	if (!system && event[0] == '\0')
> +		return -EINVAL;
>  
>  	mutex_lock(&event_mutex);
>  	for_each_dyn_event_safe(pos, n) {
> @@ -120,8 +114,7 @@ int dyn_event_release(const char *raw_command, struct dyn_event_operations *type
>  	}
>  	tracing_reset_all_online_cpus();
>  	mutex_unlock(&event_mutex);
> -out:
> -	argv_free(argv);
> +
>  	return ret;
>  }
>  
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
