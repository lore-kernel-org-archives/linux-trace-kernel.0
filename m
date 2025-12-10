Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DB43B186;
	Wed, 10 Dec 2025 02:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765333913; cv=none; b=ubzqp+U7r/SDd6Ugc7TAgDSFsS7g/32+S44fCfGva3AmSd3MJl5Zwg4TM8/gkmcC+M+1axQQ9qjavwySgZVvXOxc1DI1F/Y2Y6H8zlkSz0kBDZ0GR1HKfUIC1EbRDQuoLR6bKDzNm2psAVQ1wSgaOh9Rlt0ItVtMbG9qOWM9aMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765333913; c=relaxed/simple;
	bh=DjJ0vRTFNfl83UOiQ37+26XH5fITraYWTX+raL+nxwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nX/kz4iOfhISprKy+edwnHhOsqghUL3UPf9X9PlWeA2ZlD+tLhClky1w57hIddTvS54NUJwYcyXWa5Mk1s48rd2jUSdEUNkryT2F2c/k5HDfylf3hCqhf3ILJfDg7AEpHy/LI9klviPfEdvIeVAlH/60PnGxcxoZjDknoXCrDr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 81AB113A9A2;
	Wed, 10 Dec 2025 02:31:42 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id A9BF66000A;
	Wed, 10 Dec 2025 02:31:39 +0000 (UTC)
Date: Tue, 9 Dec 2025 21:31:35 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Ian Rogers <irogers@google.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v1] tracing: Avoid possible signed 64-bit truncation
Message-ID: <20251209213135.13eb68f4@fedora>
In-Reply-To: <20251209224024.2322124-1-irogers@google.com>
References: <20251209224024.2322124-1-irogers@google.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: A9BF66000A
X-Stat-Signature: b1qagdz6zx68sypowzb9k9igd9675ncq
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/lJb0kn+aJkFBa8AUOpvBTin1PwRFA8Bo=
X-HE-Tag: 1765333899-389943
X-HE-Meta: U2FsdGVkX19v8ImmsxZJLKhBzvON6LiB2rc+xZ16tuAo3D6avJ/pBMky2rxXJIvrMZnj+lCDvcbMooCU25r/I7iPLuIkXgvL0AiMlwMbXtqkoFCtPw0H+W33mQfDi2A/O8PbcyIvYxIrbA8aFAW7BOuqJbCwXZxJP2yhEWr4OTBfq5cErD56VuDwcr8J6e4ck4V3B8f1S7MRydtyaqSc/DBcS0QDG/Q0QnZaw1JWGjkp2viEypE4e0g8zsVC3FYJoXtIiNrovbqs3oAspmUb+Pjj0RFxcnElMt1UIJP1BL9Gbi5fEj5GTBPS/N8XGMITP1umCAg59wtbUbPm/0aPnPxZ6XMx/jmw

On Tue,  9 Dec 2025 14:40:24 -0800
Ian Rogers <irogers@google.com> wrote:

> 64-bit truncation to 32-bit can result in the sign of the truncated
> value changing. The cmp_mod_entry is used in bsearch and so the
> truncation could result in an invalid search order. This would only
> happen were the addresses more than 2GB apart and so unlikely, but
> let's fix the potentially broken compare anyway.

I'm fine with fixing this but I believe if the addresses are more than
2GB apart there could be other issues elsewhere ;-)

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  kernel/trace/trace.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index d1e527cf2aae..e6a80cbe9326 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -6057,8 +6057,10 @@ static int cmp_mod_entry(const void *key, const void *pivot)
>  
>  	if (addr >= ent[0].mod_addr && addr < ent[1].mod_addr)
>  		return 0;
> +	else if (addr > ent->mod_addr)
> +		return 1;
>  	else
> -		return addr - ent->mod_addr;
> +		return -1;

Could we still keep this down to a single if check?

	if (addr < ent->mod_addr)
		return -1;

	return addr >= ent[1].mod_addr;

-- Steve




>  }
>  
>  /**

