Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78B313BC31;
	Mon, 27 May 2024 12:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716813109; cv=none; b=VIg+A2riXiOQgRwltsxbdYF+qjdYcusgQr8zPY26qaG2xXM1ox9WkXGH4oM2HazriHTUH1E53aRn0NYUV9qfrYLB8duukkx2jjqd5lEnRRyTEatH5Ut1DaxuxYPS/apNngzU8wMc/6COW/eGPYIWYDGajJrTW9DOXmVDk4AEh1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716813109; c=relaxed/simple;
	bh=dEr1eVERIFIU7dLP++AfOw57CChhj5RmQUdT0i9PbpQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=l0Z1Qw9hPYtOhoTwI/kg/YzTg7UrpiTRA6B9UyToo2sM12AE84wyZ+qixoDzl/6ypn0n5Xovo+PVmJlEJQvYsKH65OEM0gPZ8WEpNAL4OID73kGxpgzu2f1f27kQ+F/tnCgc9nOnenOvE4o3vEV3tcOSmFXF9rhtQuULrZPM+jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7EbQaw3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7EbQaw3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7210C32781;
	Mon, 27 May 2024 12:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716813109;
	bh=dEr1eVERIFIU7dLP++AfOw57CChhj5RmQUdT0i9PbpQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m7EbQaw3RNWe6dTQgsJ5YgGu5nsD+jDrZXWjElKDAfKwzRLyn+UwOBJHPXIks6hE7
	 8KZszY8TvZH5L5c7Av3pJDoOsPHVvw7xtWEUGMYuyb1325vSXAt8lDfmYcIH/aEERn
	 yOdWb9rcUQCGOLPvoPrZCQ13BFfhegTFH3sgdwXKuSq1JoQzyt6vFgBl6wz4hz4wAa
	 mppR0PDSFwE0B9wUyAw7oRF5QpCQ2n3QdbqHYulZHEwlKJglSwP1FhfNBkeVEB794P
	 CaFJt+4xejgJ6yhAEvTmNpYlciJbxuDgAqVuaG2mtQMpcrIRIV/98SVyw+UCKUeeS2
	 RfuO2/uVyLyiw==
Date: Mon, 27 May 2024 21:31:44 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Carlos =?UTF-8?B?TMOzcGV6?= <clopez@suse.de>
Cc: linux-trace-kernel@vger.kernel.org, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Alan Maguire
 <alan.maguire@oracle.com>, linux-kernel@vger.kernel.org (open list:TRACING)
Subject: Re: [PATCH v2] tracing/probes: fix error check in parse_btf_field()
Message-Id: <20240527213144.1883fcdf4d97d08ea12988bd@kernel.org>
In-Reply-To: <20240527094351.15687-1-clopez@suse.de>
References: <20240527094351.15687-1-clopez@suse.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 27 May 2024 11:43:52 +0200
Carlos López <clopez@suse.de> wrote:

> btf_find_struct_member() might return NULL or an error via the
> ERR_PTR() macro. However, its caller in parse_btf_field() only checks
> for the NULL condition. Fix this by using IS_ERR() and returning the
> error up the stack.
> 

Thanks for updating! This version looks good to me.
Let me pick this to probes/fixes.

Thank you,


> Fixes: c440adfbe3025 ("tracing/probes: Support BTF based data structure field access")
> Signed-off-by: Carlos López <clopez@suse.de>
> ---
> v2: added call to trace_probe_log_err()
> 
>  kernel/trace/trace_probe.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index 5e263c141574..39877c80d6cb 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -554,6 +554,10 @@ static int parse_btf_field(char *fieldname, const struct btf_type *type,
>  			anon_offs = 0;
>  			field = btf_find_struct_member(ctx->btf, type, fieldname,
>  						       &anon_offs);
> +			if (IS_ERR(field)) {
> +				trace_probe_log_err(ctx->offset, BAD_BTF_TID);
> +				return PTR_ERR(field);
> +			}
>  			if (!field) {
>  				trace_probe_log_err(ctx->offset, NO_BTF_FIELD);
>  				return -ENOENT;
> -- 
> 2.35.3
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
