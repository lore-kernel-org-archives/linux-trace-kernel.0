Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3591B6A33B;
	Sun, 18 Jan 2026 15:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768751709; cv=none; b=mfVYTmVWUULcHWpJBAHNdgXYaxPlANCauEHfyKC/RYirWKi6HDov+xFIbUIFxCIgP2iAwWDTrNtW7ZRGaDkRn6unoSEgg7kRyPJEfDZdxcaQmNTTh6HdWSZEbRufwGvbS4NpnZZVTuAoLBgMlVtvYVVrjf+RL1hyY82IqTV6sDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768751709; c=relaxed/simple;
	bh=16mXeuF1zmW+jJ569QBbwtT5iwHy+Q2LYpnxx1vTDnU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FwTAcuUDSXIZdL0hwBPpd3D/FNHz9GyRGJkNVWLPU+fYovU735KoatvCd8V0TJz3uWvb6g/aK1Mt8eWDnSsZUDdW8FmX9qFoAilrYYI4YAYOAtpjOLCh2nkoddJKC7uhy4ochNZuC/SoJpcIZH9SWJs9PIqYLGLbBoPv9RRo11A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 4A7BB1A0593;
	Sun, 18 Jan 2026 15:55:01 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 6C2912002D;
	Sun, 18 Jan 2026 15:54:59 +0000 (UTC)
Date: Sun, 18 Jan 2026 10:54:57 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Weigang He <geoffreyhe2@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Tuo Li <islituo@gmail.com>
Subject: Re: [PATCH] scripts/tracepoint-update: fix memory leak in
 make_trace_array()
Message-ID: <20260118105457.755291a5@robin>
In-Reply-To: <20260118130247.1003369-1-geoffreyhe2@gmail.com>
References: <20260118130247.1003369-1-geoffreyhe2@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: azgjo958mqq4de1jkd86o19x1kzwfgwz
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 6C2912002D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/IrboNvfouy6+b92m077zKwEjQ6NgU9tk=
X-HE-Tag: 1768751699-721712
X-HE-Meta: U2FsdGVkX1+bNs3lGcIUPRVgm3e58wQFdSYdxCyH8et44RGkfkXRRuaqqyfVziPAprErWF9KPcy6zV0P+36uuRejEN6g8GP/m43GeaFXPoAQ4aNSKD/G+al4oKRDOKwl+OgWt4+jS3Ag7vzUQk6jpxBxpyYlZv3KtddgfHB9nLEcdLYfJTYyEb38cQE+PXOLygDKv9KH9roIJ1rtPXaAXKiioNSYcG5jaRC435tpsE3+m1EKTBvHUkq7mmZn7JpOZqgaS+Sx1wqNhFgz1OIMYyk8JhoIuwYvFvDXe4rK9BbRUvb6bp5NRo2y8tcEXltIHhXs4TsFwSYAx3Ae+WHhGbWOmJ9UAJdj

On Sun, 18 Jan 2026 13:02:47 +0000
Weigang He <geoffreyhe2@gmail.com> wrote:

> In make_trace_array(), if add_string() fails after some successful
> iterations, the function returns without freeing the 'vals' array that
> was allocated by previous add_string() calls.
> 
> The add_string() function uses realloc() internally with a local
> temporary variable, which means the original pointer is preserved on
> allocation failure. When make_trace_array() returns early on error,
> the previously allocated memory is leaked.
> 
> Fix this by freeing 'vals' before returning on the error path.
> 
> This bug is found by my static analysis tool and my code review.
> 
> Signed-off-by: Tuo Li <islituo@gmail.com>
> ---
>  scripts/tracepoint-update.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/tracepoint-update.c b/scripts/tracepoint-update.c
> index 90046aedc97b9..7bc9d66229ddf 100644
> --- a/scripts/tracepoint-update.c
> +++ b/scripts/tracepoint-update.c
> @@ -93,8 +93,10 @@ static void make_trace_array(struct elf_tracepoint *etrace)
>  	for_each_shdr_str(len, ehdr, check_data_sec) {
>  		if (!len)
>  			continue;
> -		if (add_string(str, &vals, &count) < 0)
> +		if (add_string(str, &vals, &count) < 0) {
> +			free(vals);
>  			return;
> +		}
>  	}

It would make much more sense to have add_string() free vals, and set
vals to NULL on error.

-- Steve


>  
>  	/* If CONFIG_TRACEPOINT_VERIFY_USED is not set, there's nothing to do */

