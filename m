Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFA035971;
	Wed, 20 Aug 2025 00:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755650835; cv=none; b=FVIbjqubFb7NnSILgb9A6Ac5iJEhmK2DnRPvdh0r87R+Y0m62DrYB/xpyx1p68K/RYhTY+bUyMmGJSFkVPkD8H9NwD/DcosQvWkizxZrJvahu51xWHsv5zqQd5DM1wMjDBu2LQD9E7oHXLfrqV1nGY5iiJlvljUDPkiTFOkAdHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755650835; c=relaxed/simple;
	bh=IQmASp3N/F8h3Axbr4MB9z1anegAvAeJrpyq23BuNjs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tLSIUBoTeANEIGRUX3HG3zAkpZ6G049MlDdFrAhFwn5XoUzjVhOewkl8gNKNc6gaQN4EUe425GMUsolkgE5/qv5yBvFPjMAsliI8KGMKB+GUzYMjzHBiwo+w/NDCLWVF29fgbF9z4XD6e+PQCxXSBrZcRFnzqMngTF1LJiW7khs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 21EC71171CE;
	Wed, 20 Aug 2025 00:47:11 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 3BA6420032;
	Wed, 20 Aug 2025 00:47:09 +0000 (UTC)
Date: Tue, 19 Aug 2025 20:47:09 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 1/2] ftrace: Remove unnecessary free_ftrace_hash
 in ftrace_regex_open
Message-ID: <20250819204709.556e9f54@gandalf.local.home>
In-Reply-To: <20250813023044.2121943-2-wutengda@huaweicloud.com>
References: <20250813023044.2121943-1-wutengda@huaweicloud.com>
	<20250813023044.2121943-2-wutengda@huaweicloud.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 37op1hqiuhy5543ionanp38tw5m1detd
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 3BA6420032
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19viNZR85Ya7yN1IjL5s1h8/4tIWsrJMA8=
X-HE-Tag: 1755650829-605998
X-HE-Meta: U2FsdGVkX18qqcIZnnPlB7RbiqhvWEmjHuKFegSoKSEsyjGSrv4I+smyZaMsyTo2ljkhFgOjAH3+8Ocl0XDeFhu0h0VFeI0RJSNQqWWzLJD2b/6RGdChBkP5VTh4f65O7kzcKAQywUL/FrJHqlmemVWjPtxLgN0agbby/vs3CU0/tpFIyRmeVsbqCdC8ekyeptq6ZDmqBiWyntIP0RJYIWTyCq3dVTplSgJfgjzNTxgtv1NQGfuA2FTkSUvKIFfAwoTMxa1qdWhhCsRO+v9d/0jVy0+6r9KkyJEf+B3NeK33kVdbmTFqgaSpCns7/D7E9iTkQ5/9lQmcufkmcbKuQHSQv7cYP00m

On Wed, 13 Aug 2025 02:30:43 +0000
Tengda Wu <wutengda@huaweicloud.com> wrote:


> The free_ftrace_hash call is just unnecessary in this context since
> we shouldn't free the global hash that we don't own. Remove this call
> to fix the issue.

This is incorrect as it is only unnecessary if it's a read.

The code above is:

	if (file->f_mode & FMODE_WRITE) {
		const int size_bits = FTRACE_HASH_DEFAULT_BITS;

		if (file->f_flags & O_TRUNC) {
			iter->hash = alloc_ftrace_hash(size_bits);
			clear_ftrace_mod_list(mod_head);
	        } else {
			iter->hash = alloc_and_copy_ftrace_hash(size_bits, hash);
		}

		if (!iter->hash) {
			trace_parser_put(&iter->parser);
			goto out_unlock;
		}
	} else
		iter->hash = hash;

Where if the file was open for write, the hash must be freed.


> 
> Fixes: c20489dad156 ("ftrace: Assign iter->hash to filter or notrace hashes on seq read")


> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> ---
>  kernel/trace/ftrace.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 00b76d450a89..cade13595b08 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -4680,7 +4680,6 @@ ftrace_regex_open(struct ftrace_ops *ops, int flag,
>  			m->private = iter;
>  		} else {
>  			/* Failed */
> -			free_ftrace_hash(iter->hash);

The real fix is:

			if (file->f_mode & FMODE_WRITE)
				free_ftrace_hash(iter->hash);

-- Steve



>  			trace_parser_put(&iter->parser);
>  		}
>  	} else

