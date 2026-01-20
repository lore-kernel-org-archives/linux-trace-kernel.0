Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DFC33F8B4;
	Tue, 20 Jan 2026 20:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768942254; cv=none; b=CpG0kxmMqciOeOMvy25boFDMsGXcwRXpljmNykw8PshpUaxIdCSuURVQQUI06ZPouG1aaSEDyr0lliUovtZBn18Z94t4yu/vCCpqVddVicDVRV+wkqlMNAP9qha1mEuFA859wSb2+4TrMeCDnlRh8uMD+cV6DC021mwEnvIzSCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768942254; c=relaxed/simple;
	bh=CFySwJUA4tqXXg1Y2KHtd6mTyXdWwAZbIsuR2D6NVAg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L4EhIzLK3AqKgZwSBxKpU3i06BjNJZzDWE9Z7nQ6H4fyfOIqNo0yPxvzIf0ImOec81rnZlf3wnFON7WQthpXKiO81B4W9lbeBRe//HcMqiEiDqU/A5hTYKhbhG4zAAq91ZkNTGUqj3Gm3pvRGEbx8LxQ5AWfqzU6O9hdZeBW4iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 5DB59BAE21;
	Tue, 20 Jan 2026 20:50:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 4A0C320028;
	Tue, 20 Jan 2026 20:50:48 +0000 (UTC)
Date: Tue, 20 Jan 2026 15:51:10 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Seokwoo Chung (Ryan)" <seokwoo.chung130@gmail.com>
Cc: mhiramat@kernel.org, corbet@lwn.net, shuah@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 2/3] docs: tracing/fprobe: Document list filters and
 :entry/:exit
Message-ID: <20260120155110.1dbb54a6@gandalf.local.home>
In-Reply-To: <20260114221341.128038-3-seokwoo.chung130@gmail.com>
References: <20251126184110.72241-1-seokwoo.chung130@gmail.com>
	<20260114221341.128038-1-seokwoo.chung130@gmail.com>
	<20260114221341.128038-3-seokwoo.chung130@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 4A0C320028
X-Stat-Signature: 7cpps1mfnyp53qyugyzdcm98mrgoc5at
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+15p65K6mJHQrFZ5eUKagT7AcjEFjhbj8=
X-HE-Tag: 1768942248-573104
X-HE-Meta: U2FsdGVkX19NlXH0iHlYALCBXlSewc9RQQUjPf11BnAgauOn5CAM7Ow6D9iebEI1PdF4lBiLDlYyjJGPMpRw+IKz+YTTAh1L7wKtlhB51EMhli1JLpaW8hOBrCeCCGtd4Qb5YLbK1fYiMjri0CLSdHukG34QrHcgad0JFhcEF7IsKv7sOtQa7gaW9UK/5ThhM+8f4ZQCBEML6Q9dzxQnY7mPbWYlahUzu94SB6p+TsYFMn2QSiMKo1pXJRNj/Nw3Ft+hpwSI0GfyPXR9ncaPGJ2erSixTz74sz+NuZ3WLvdfvEocsrsIBkPBLg6TrZPVOlAHY7CZy+Z4lVc+bo0BMHI9pMA4HLEl

On Wed, 14 Jan 2026 17:13:39 -0500
"Seokwoo Chung (Ryan)" <seokwoo.chung130@gmail.com> wrote:


Again, no change log :-(

-- Steve


> Signed-off-by: Seokwoo Chung (Ryan) <seokwoo.chung130@gmail.com>
> ---
>  Documentation/trace/fprobetrace.rst | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/trace/fprobetrace.rst b/Documentation/trace/fprobetrace.rst
> index b4c2ca3d02c1..5efd9c374365 100644
> --- a/Documentation/trace/fprobetrace.rst
> +++ b/Documentation/trace/fprobetrace.rst
> @@ -25,14 +25,19 @@ Synopsis of fprobe-events
>  -------------------------
>  ::
>  
> -  f[:[GRP1/][EVENT1]] SYM [FETCHARGS]                       : Probe on function entry
> -  f[MAXACTIVE][:[GRP1/][EVENT1]] SYM%return [FETCHARGS]     : Probe on function exit
> +  f[:[GRP1/][EVENT1]] SYM [FETCHARGS]			: Probe on function entry
> +  f[MAXACTIVE][:[GRP1/][EVENT1]] SYM%return [FETCHARGS] : Probe on function exit
> +  f[:[GRP1/][EVENT1] SYM[,[!]SYM[,...][:entry|:exit] [FETCHARGS] : Probe on
> +  list/wildcard
>    t[:[GRP2/][EVENT2]] TRACEPOINT [FETCHARGS]                : Probe on tracepoint
>  
>   GRP1           : Group name for fprobe. If omitted, use "fprobes" for it.
>   GRP2           : Group name for tprobe. If omitted, use "tracepoints" for it.
>   EVENT1         : Event name for fprobe. If omitted, the event name is
> -                  "SYM__entry" or "SYM__exit".
> +          - For a single literal symbol, the event name is
> +            "SYM__entry" or "SYM__exit".
> +          - For a *list or any wildcard*, an explicit [GRP1/][EVENT1] is
> +            required.
>   EVENT2         : Event name for tprobe. If omitted, the event name is
>                    the same as "TRACEPOINT", but if the "TRACEPOINT" starts
>                    with a digit character, "_TRACEPOINT" is used.
> @@ -40,6 +45,13 @@ Synopsis of fprobe-events
>                    can be probed simultaneously, or 0 for the default value
>                    as defined in Documentation/trace/fprobe.rst
>  
> + SYM        : Function name or comma-separated list of symbols.
> +          - SYM prefixed with "!" are exclusions.
> +          - ":entry" suffix means it probes entry of given symbols
> +            (default)
> +          - ":exit" suffix means it probes exit of given symbols.
> +          - "%return" suffix means it probes exit of SYM (single
> +            symbol).
>   FETCHARGS      : Arguments. Each probe can have up to 128 args.
>    ARG           : Fetch "ARG" function argument using BTF (only for function
>                    entry or tracepoint.) (\*1)

