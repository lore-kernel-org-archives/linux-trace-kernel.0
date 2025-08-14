Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0311A1E7C1C;
	Thu, 14 Aug 2025 19:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755198375; cv=none; b=LSXP79TWF/RUb4u0oAEFXPP5Waf/hQY13nJ91kNMfp8Qli70tBkEjMOFqK1aqo1Iu7PQH+Oi3wJzbNniKk5vX9uEuECdOJ98bOrjKN2fAmxcOEkl5NtlaUDQ5HRbGJGQwI5NayILs0hkc1lR7I9Ny137PAZIzqIhIU/aifgKd6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755198375; c=relaxed/simple;
	bh=ig3F3xjacmV2NjQ6zHG/d6qziwoJ3hFrrzx8oorqmiI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sIiSAbntmODDaJg2NhPPAmketaWm2xalzKckXVX/6kvYIvCZJlcmjSEIhBXB2c0Z5uAzo91VgAwHqBroicg7fpvMPrDcRYWeultA5bt1beGeqG69sG9BzoE/whp2iCO0ejIdzBo5IO+LY4QcTMvVgeG8mh+sREVibQJlwuwnnnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id AFC0F160711;
	Thu, 14 Aug 2025 19:06:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id E3A628000E;
	Thu, 14 Aug 2025 19:06:03 +0000 (UTC)
Date: Thu, 14 Aug 2025 15:06:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Fushuai Wang <wangfushuai@baidu.com>
Cc: <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] trace/hwlat: Add WARN_ON in move_to_next_cpu()
Message-ID: <20250814150654.28b0d04c@gandalf.local.home>
In-Reply-To: <20250811080109.8417-1-wangfushuai@baidu.com>
References: <20250811080109.8417-1-wangfushuai@baidu.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E3A628000E
X-Stat-Signature: z4kttf1hu497yxi3z838jwbf6at13c35
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+NC6D8VIu8lwM58A8gumXaY8ExBwkLLnA=
X-HE-Tag: 1755198363-154944
X-HE-Meta: U2FsdGVkX19w1Qt/ceIVSdm7xYR8TL/VJngTeSc14Q5Iy7vBKev4ulx9v6fY3JmPouBIP8cNtR4Zhiz9L6zJT6Iqtv0jY2Y5DDolkfDNx8oyvQbum3fYkbXVmw6UqhpZ1Vi1I7iqsMg0HiJkU8frPKpUK8F7BKtSlvpz3miQrlRWm4o0WwdMDlxSnLftWAhbjVDZUgPrGAQ9aZIWi4E66a3dJxjGtKr4SkMeiOe5VIBy3F4fS/bGcoC1mZ6qW//zGi0uBDXYR82DBQ8X5tz9ZozKoxzT6yo2doknDhlRwOjJcFw65gqpR9CTyahDYtXTi7fFnWhFXNMBryZExPJTNHuVxERYLZ/T

On Mon, 11 Aug 2025 16:01:09 +0800
Fushuai Wang <wangfushuai@baidu.com> wrote:

> Add a WARN_ON check in move_to_next_cpu(). Next_cpu should
> never be greater than or equal to nr_cpu_ids.
> 
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
> ---
>  kernel/trace/trace_hwlat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
> index 2f7b94e98317..5024b0dcdbba 100644
> --- a/kernel/trace/trace_hwlat.c
> +++ b/kernel/trace/trace_hwlat.c
> @@ -328,7 +328,7 @@ static void move_to_next_cpu(void)
>  	next_cpu = cpumask_next_wrap(raw_smp_processor_id(), current_mask);
>  	cpus_read_unlock();
>  
> -	if (next_cpu >= nr_cpu_ids) /* Shouldn't happen! */
> +	if (WARN_ON(next_cpu >= nr_cpu_ids)) /* Shouldn't happen! */
>  		goto change_mode;

Yeah, it shouldn't happen but it doesn't mean we need to add a WARN_ON().
It might even happen if user space is messing with the tracing_cpumask at
the same time. It shouldn't happen but it doesn't mean it will not happen.

We do not add WARN_ON() for things that could be trigger by user space.

-- Steve

