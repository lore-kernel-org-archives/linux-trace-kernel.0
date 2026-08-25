Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23776446829;
	Tue, 25 Aug 2026 12:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787662430; cv=none; b=VFS8WZVU6VZ35TraFYD9G6wg17apoPuoAdOMVPrwQdaH0/aAwgO+uFVgtO48roBSAUJvClG8VbMXG5uDHrIe6sDxdwzY0tn69NBZrb1/DKaDrWd4djzxhmdwXd2uJhivYznZ+38QXFEjWiaEtMlDsIN0LPjyjqs6f/aaak5zbOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787662430; c=relaxed/simple;
	bh=QdtlAY3UhlE2oZRhlysca0phXot5BXcM95JauW3Do9U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qkaZG0Lav3JGCmCCsafE0KmUHE+VedANdBfB7skmDavLyxwl4HKhczxbds8ORap+IO5WkV6iqiaV2fgsmLy3Av5pjMIbR8F0dbyQmlCe6tsQvMom6xGlHBRIiAxuB06x+pxlJFY/hDj4cO9zn0Sq58LfSPTx8/KD60bjY0Gn7iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=tDdN1L9f; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="tDdN1L9f"
Received: from omf16.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 899291403C2;
	Tue, 25 Aug 2026 12:53:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id CF1CF20019;
	Tue, 25 Aug 2026 12:53:38 +0000 (UTC)
Date: Tue, 25 Aug 2026 08:54:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: mhiramat@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] samples/ftrace: Fix kthread_stop() on ERR_PTR in
 ftrace-direct-modify
Message-ID: <20260825085421.1d87b98a@gandalf.local.home>
In-Reply-To: <20260825093441.7394-1-vulab@iscas.ac.cn>
References: <20260825093441.7394-1-vulab@iscas.ac.cn>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: m8ieu33jaah45mbkgnjbsgbpouh5iee3
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: CF1CF20019
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/k66wQRoJjt2HX+43ws2FGd3kbSdIwpkY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=/WZI+xAxk/aaiZUe7Z0p0Rb276ErbTz8Db0Iw2kQyjg=; b=tDdN1L9fZHLyvAS3Zv/O7XG9fZxf82IlmEAgwtoJmQASN7pMC4eEXPS4X9uYeYWQ7G2GEojZ8VqTOuKK8fpcqtdPt/javWexE4zCqRmFoFr7zco4DrtCIWRz3VIgInDhgIZd5/wqeDQUv7BqtXmn+6BqBPUsmg+8BPGr8HFMuro=
X-HE-Tag: 1787662418-227215
X-HE-Meta: U2FsdGVkX19tmFOLn7IzX+ohj6zGaON8j4LulW48L4Ukz8uyF8AAHssuDd/E9fDakgq/T9SppiiZWOjRZu9Ny2vja5jn3XHyc0zOoI/vD21+1RvtzkdGWZXje0uESY/8XqL3K9bXZa8291tbdRpSGt7Oo+ClICwrAXlPiBorTY3Yl1+OK0uK7SkUD46hWZLFsH4iZiZ7Apnw3nJblAmDN9I7VqVVfY6jC2p4xtu+h/OzUpaOBytRwcSk+18PMqB3J6JC3IISoAish6fq76hC9886vvqUPVlm6Ctws5matz1LX9yjoB2Y6TXO1bfN0q1A

On Tue, 25 Aug 2026 17:34:41 +0800
Haotian Zhang <vulab@iscas.ac.cn> wrote:

> ftrace_direct_init() assigns kthread_run()'s return value to simple_tsk
> without an IS_ERR() check. When kthread_run() fails it returns
> ERR_PTR(-ENOMEM), but init still returns 0, so the module loads with
> simple_tsk holding an error pointer. On unload, ftrace_direct_exit()
> then passes that ERR_PTR to kthread_stop(), leading to a
> null-pointer-dereference.
> 
> Check the return value of kthread_run() with IS_ERR(); on failure,
> unregister the ftrace direct call and propagate the error code.
> 
> Fixes: ae0cc3b7e7f5 ("ftrace/samples: Add a sample module that implements modify_ftrace_direct()")
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> ---
>  samples/ftrace/ftrace-direct-modify.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrace-direct-modify.c
> index da3a9f2091f5..2795ea12cdf9 100644
> --- a/samples/ftrace/ftrace-direct-modify.c
> +++ b/samples/ftrace/ftrace-direct-modify.c
> @@ -320,8 +320,13 @@ static int __init ftrace_direct_init(void)
>  	ftrace_set_filter_ip(&direct, (unsigned long) my_ip, 0, 0);
>  	ret = register_ftrace_direct(&direct, my_tramp);
>  
> -	if (!ret)
> +	if (!ret) {
>  		simple_tsk = kthread_run(simple_thread, NULL, "event-sample-fn");
> +		if (IS_ERR(simple_tsk)) {
> +			unregister_ftrace_direct(&direct, my_tramp, true);
> +			ret = PTR_ERR(simple_tsk);
> +		}
> +	}
>  	return ret;
>  }
>  

Please simplify the code to:

  	ftrace_set_filter_ip(&direct, (unsigned long) my_ip, 0, 0);
  	ret = register_ftrace_direct(&direct, my_tramp);
  
	if (ret)
		return ret;

	simple_tsk = kthread_run(simple_thread, NULL, "event-sample-fn");
	if (IS_ERR(simple_tsk)) {
		unregister_ftrace_direct(&direct, my_tramp, true);
		return PTR_ERR(simple_tsk);
	}

  	return 0;
  }


