Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1988A2FE056
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Apr 2026 09:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776246446; cv=none; b=JdLap64pjH3QAl7C5d35aiOD7B4M12PBD+huAvwHU/w8ExjpRCDnDXJuZqTPMfguA+SYQZkd7T+tlyTZNWTFGI+TSpzXQ641Unjo+i/VEQBCcmhRN3BrqlPr+xiVP2BZxaALQR80aEF20jcQ3P22kTXKhINpbAqWSzIa+ffOxYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776246446; c=relaxed/simple;
	bh=kxkYX65oty5ZJyyR0uLChjjifebitlwlvDs+iCCd+uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mS4niBQ05yBAPSphTeHJ3dbiBZNqMMZ4i/xiUuuWA6XIljs9WzdJH3gynJKqQNtLY/Aqnguw9IS9ltuUDbQ+BrT1hC20Pvw09KEWxY/5dl0SMSK9kaDnv80QEJDFhB6JT63nolnGqADKDH3ICFY3IVBSgxhHbCFJ1I0xzi7v14c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tb0IW+9w; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tb0IW+9w"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776246443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HB6zRRlrlYrPWRP9aSTwtdoAU/y3NBjU7G2J51q5r6E=;
	b=tb0IW+9wrk7aagT11guOhZ0C2h2gw7216OISwvKSLgfKIEXzuA8rDAIx3vSpM/z3KmYMAb
	hZK/d5IP/SU85gnEEiZlDfevhSfVDbP1DCAtPzU5gdVEdKtRyMmVvoCwZANKGIumGIyCeF
	1YWH/lhSLuaLx2/cu3XRC1vsW5pfk80=
From: Menglong Dong <menglong.dong@linux.dev>
To: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, jiang.biao@linux.dev,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject:
 Re: [PATCH v6 2/5] tracing/fprobe: Remove fprobe from hash in failure path
Date: Wed, 15 Apr 2026 17:47:11 +0800
Message-ID: <2405872.ElGaqSPkdT@7940hx>
In-Reply-To:
 <177615809677.1165997.619922394559783590.stgit@mhiramat.tok.corp.google.com>
References:
 <177615807787.1165997.921227352050738693.stgit@mhiramat.tok.corp.google.com>
 <177615809677.1165997.619922394559783590.stgit@mhiramat.tok.corp.google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/4/14 17:14 Masami Hiramatsu (Google) <mhiramat@kernel.org> write:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> When register_fprobe_ips() fails, it tries to remove a list of
> fprobe_hash_node from fprobe_ip_table, but it missed to remove
> fprobe itself from fprobe_table. Moreover, when removing
> the fprobe_hash_node which is added to rhltable once, it must
> use kfree_rcu() after removing from rhltable.
> 
> To fix these issues, this reuses unregister_fprobe() internal
> code to rollback the half-way registered fprobe.
> 
> Fixes: 4346ba160409 ("fprobe: Rewrite fprobe on function-graph tracer")
> Cc: stable@vger.kernel.org
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
[...]
>  
> +static int unregister_fprobe_nolock(struct fprobe *fp, bool force);
> +
>  /**
>   * register_fprobe_ips() - Register fprobe to ftrace by address.
>   * @fp: A fprobe data structure to be registered.
> @@ -847,29 +855,26 @@ int register_fprobe_ips(struct fprobe *fp, unsigned long *addrs, int num)
>  	if (ret)
>  		return ret;

Hi, Masami. The logic of unregister_fprobe_nolock() looks a little
messy. How about we make the logic here like this:

for (i = 0; i < hlist_array->size; i++) {
    // The node->fp is NULL, so it's safe to add the node before
    // fprobe_ftrace_add_ips(), right?
    ret = insert_fprobe_node(&hlist_array->array[i], fp);
    if (ret)
        goto fallback_err;
}

if (fprobe_is_ftrace(fp))
    ret = fprobe_ftrace_add_ips(addrs, num);
else
    ret = fprobe_graph_add_ips(addrs, num);
if (ret)
    goto fallback_err;

add_fprobe_hash(fp);
for (i = 0; i < hlist_array->size; i++)
    WRITE_ONCE(hlist_array->array[i].fp, fp);

return 0;

fallback_err:
for (i--; i >= 0; i--)
    delete_fprobe_node(&hlist_array->array[i]);
fprobe_fail_cleanup(fp);
return ret;

Then, we don't need to change unregister_fprobe_nolock and
insert_fprobe_node.

Thanks!
Menglong Dong

>  
> -	hlist_array = fp->hlist_array;
>  	if (fprobe_is_ftrace(fp))
>  		ret = fprobe_ftrace_add_ips(addrs, num);
>  	else
>  		ret = fprobe_graph_add_ips(addrs, num);
> +	if (ret) {
> +		fprobe_fail_cleanup(fp);
> +		return ret;
> +	}
>  
> -	if (!ret) {
> -		add_fprobe_hash(fp);
> -		for (i = 0; i < hlist_array->size; i++) {
> -			ret = insert_fprobe_node(&hlist_array->array[i]);
> -			if (ret)
> -				break;
> -		}
> -		/* fallback on insert error */
> +	hlist_array = fp->hlist_array;
> +	add_fprobe_hash(fp);
> +	for (i = 0; i < hlist_array->size; i++) {
> +		ret = insert_fprobe_node(&hlist_array->array[i], fp);
>  		if (ret) {
> -			for (i--; i >= 0; i--)
> -				delete_fprobe_node(&hlist_array->array[i]);
> +			if (unregister_fprobe_nolock(fp, true))
> +				pr_warn("Failed to cleanup fprobe after insertion failure.\n");
> +			break;
>  		}
>  	}
>  
> -	if (ret)
> -		fprobe_fail_cleanup(fp);
> -
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(register_fprobe_ips);
> @@ -912,37 +917,29 @@ bool fprobe_is_registered(struct fprobe *fp)
>  	return true;
>  }
>  
> -/**
> - * unregister_fprobe() - Unregister fprobe.
> - * @fp: A fprobe data structure to be unregistered.
> - *
> - * Unregister fprobe (and remove ftrace hooks from the function entries).
> - *
> - * Return 0 if @fp is unregistered successfully, -errno if not.
> - */
> -int unregister_fprobe(struct fprobe *fp)
> +static int unregister_fprobe_nolock(struct fprobe *fp, bool force)
>  {
> -	struct fprobe_hlist *hlist_array;
> +	struct fprobe_hlist *hlist_array = fp->hlist_array;
>  	unsigned long *addrs = NULL;
> -	int ret = 0, i, count;
> +	int i, count;
>  
> -	mutex_lock(&fprobe_mutex);
> -	if (!fp || !fprobe_registered(fp)) {
> -		ret = -EINVAL;
> -		goto out;
> -	}
> -
> -	hlist_array = fp->hlist_array;
>  	addrs = kcalloc(hlist_array->size, sizeof(unsigned long), GFP_KERNEL);
> -	if (!addrs) {
> -		ret = -ENOMEM;	/* TODO: Fallback to one-by-one loop */
> -		goto out;
> -	}
> +	if (!addrs && !force)
> +		return -ENOMEM;
> +	/*
> +	 * If @force is set, this function will remove fprobe_hash_node
> +	 * from the hash table even if memory allocation fails. However,
> +	 * ftrace_ops will not be updated. Anyway, when the last fprobe
> +	 * is unregistered, ftrace_ops is also unregistered.
> +	 */
>  
>  	/* Remove non-synonim ips from table and hash */
>  	count = 0;
>  	for (i = 0; i < hlist_array->size; i++) {
> -		if (!delete_fprobe_node(&hlist_array->array[i]))
> +		if (delete_fprobe_node(&hlist_array->array[i]))
> +			continue;
> +
> +		if (addrs)
>  			addrs[count++] = hlist_array->array[i].addr;
>  	}
>  	del_fprobe_hash(fp);
> @@ -951,15 +948,35 @@ int unregister_fprobe(struct fprobe *fp)
>  		fprobe_ftrace_remove_ips(addrs, count);
>  	else
>  		fprobe_graph_remove_ips(addrs, count);
> +	/*
> +	 * If count == 0, instead of calling ftrace_set_filter_ips(),
> +	 * we must wait for RCU grace period to finish del_fprobe_hash().
> +	 */
> +	if (!count)
> +		synchronize_rcu();
>  
>  	kfree_rcu(hlist_array, rcu);
>  	fp->hlist_array = NULL;
> +	kfree(addrs);
>  
> -out:
> -	mutex_unlock(&fprobe_mutex);
> +	return !addrs ? -ENOMEM : 0;
> +}
>  
> -	kfree(addrs);
> -	return ret;
> +/**
> + * unregister_fprobe() - Unregister fprobe.
> + * @fp: A fprobe data structure to be unregistered.
> + *
> + * Unregister fprobe (and remove ftrace hooks from the function entries).
> + *
> + * Return 0 if @fp is unregistered successfully, -errno if not.
> + */
> +int unregister_fprobe(struct fprobe *fp)
> +{
> +	guard(mutex)(&fprobe_mutex);
> +	if (!fp || !fprobe_registered(fp))
> +		return -EINVAL;
> +
> +	return unregister_fprobe_nolock(fp, false);
>  }
>  EXPORT_SYMBOL_GPL(unregister_fprobe);
>  
> 
> 
> 




