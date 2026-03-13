Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E5A2F5485;
	Fri, 13 Mar 2026 02:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773367806; cv=none; b=QVZZYeakRWCpfdQgG6S5HdEZqoPahmUxXPKGUy9fLRLFlXGR8PsC0XtSXWmpY5UDCeXgfBtsokNBuMP1r01THbjV94Xca70VJs+re2uOf5fsliD6YQkqq2/Zdkcvq568jvcfS1lUDa1mD5m1e2fh2vYQlBRFDbtQ9g0uFKd7568=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773367806; c=relaxed/simple;
	bh=3LFFiQmcDjHIlO+Jbk/cyVGUOfdnYrv+zjDgtwVLJjE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=I/sG5t2EQH4LUgCg9O1tNxxXQerM4Pw9FaepVyHMmvJIbmys3M11S2uHgsJMzxFcSU2J0lBHaKt15qnn/5sLef+qhw9xmBKIrNJuaIB696KsoJEoNwA5SslGhW/Kj7zc5Qhr3IZoYdR9B+dX1uDqsUmyYxFAvsEvu/Hg1CRJV8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pErochix; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pErochix"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37ACC4CEF7;
	Fri, 13 Mar 2026 02:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773367806;
	bh=3LFFiQmcDjHIlO+Jbk/cyVGUOfdnYrv+zjDgtwVLJjE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pErochix+B7ZrpESOagQfa1KjizyPxaNsbL9GuLjxU9w7gj6M41O/Hr7THGO/eAtY
	 agNhjvTq14AtO0Seh/Z53yEsFoXigJKFsoFEB9TqmihhbMKbOt9XpXdQjrv5yXv7vU
	 6nfCK8YG1iU19vf+gBzG8g9pIz7dPGCSA6K5LuIGpgyH9ZSrkFWrLeh4lnZb48Mf8P
	 MYOJn6vzLizO/KQNoyk+3ouzlSoP4WghGtR0Qwg7AEYDHOPCblaEx8t7Yj66jt0yFt
	 oW1qdHCNa54PZ2lP9x/KG8aaBZp7KudWL9NtbEeYUtKFcBAzT7zYbDaLv+qIniNbno
	 84ixOaA6E7kRQ==
Date: Fri, 13 Mar 2026 11:10:02 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Josh Law <hlcj1234567@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Josh Law
 <objecting@objecting.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] lib/bootconfig: check bounds before writing in
 __xbc_open_brace()
Message-Id: <20260313111002.ff8f22fc02da8b6bedcf5218@kernel.org>
In-Reply-To: <20260312191143.28719-3-objecting@objecting.org>
References: <20260312191143.28719-1-objecting@objecting.org>
	<20260312191143.28719-3-objecting@objecting.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Mar 2026 19:11:42 +0000
Josh Law <hlcj1234567@gmail.com> wrote:

> From: Josh Law <objecting@objecting.org>
> 
> The bounds check for brace_index happens after the array write.
> While the current call pattern prevents an actual out-of-bounds
> access (the previous call would have returned an error), the
> write-before-check pattern is fragile and would become a real
> out-of-bounds write if the error return were ever not propagated.
> 
> Move the bounds check before the array write so the function is
> self-contained and safe regardless of caller behavior.
> 

Hmm good catch. This is a kind of specification mistake.
If we pass below to the bootconfig tool, currently it fails.
----
key1 {
key2 {
key3 {
key4 {
key5 {
key6 {
key7 {
key8 {
key9 {
key10 {
key11 {
key12 {
key13 {
key14 {
key15 {
key16 {
}}}}}}}}}}}}}}}}
----
But since "open_brace[]" array has 16 entries, it should
accept the 16th brace.

Let me add a good and a bad example for this case too.

Thanks,

> Signed-off-by: Josh Law <objecting@objecting.org>
> ---
>  lib/bootconfig.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/bootconfig.c b/lib/bootconfig.c
> index a1e6a2e14b01..62b4ed7a0ba6 100644
> --- a/lib/bootconfig.c
> +++ b/lib/bootconfig.c
> @@ -532,9 +532,9 @@ static char *skip_spaces_until_newline(char *p)
>  static int __init __xbc_open_brace(char *p)
>  {
>  	/* Push the last key as open brace */
> -	open_brace[brace_index++] = xbc_node_index(last_parent);
>  	if (brace_index >= XBC_DEPTH_MAX)
>  		return xbc_parse_error("Exceed max depth of braces", p);
> +	open_brace[brace_index++] = xbc_node_index(last_parent);
>  
>  	return 0;
>  }
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
