Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE80288D2;
	Tue,  8 Apr 2025 18:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744135328; cv=none; b=vAGo8TI55rdFZNSacyvWqf8KAyN1srnS7xMLe/LW5wH3l/pWPPCWy1cavolcOvd4WPmnnxdVWNhqU7E69qdAFaPuv+4vWE4jMdgpfXgmyqXYnL/JTgReMYOSpavOy0gicmaovakfi6bYbWY5nK+bwa8XGxQ5zUSVqyZ1O5XX0bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744135328; c=relaxed/simple;
	bh=AnMuNAXRJ6PssuK8E/Dq7+QGz8NbAkTSQsd1cr65ErA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HOlFRUZHe7tWG2r7XpVTSKVFLITGxuYW+9cHiPYs9DNyhUxf6B5Jxk7qdWF9Mscp9byhC6tS7S8R9Grk27QezpaaV0H+/Jzf0hZ/9/X2ZK+Ld2+VDQr/YJubsTIP/hxopvk+YcStFt7Im+IfBxtcw59nFQIfXJc+509EQ5dH70k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B553FC4CEE5;
	Tue,  8 Apr 2025 18:02:05 +0000 (UTC)
Date: Tue, 8 Apr 2025 14:03:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andy Chiu <andybnac@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mark.rutland@arm.com, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 bjorn@rivosinc.com, puranjay12@gmail.com, alexghiti@rivosinc.com,
 paul.walmsley@sifive.com, greentime.hu@sifive.com, nick.hu@sifive.com,
 nylon.chen@sifive.com, eric.lin@sifive.com, vincent.chen@sifive.com,
 zong.li@sifive.com, yongxuan.wang@sifive.com, samuel.holland@sifive.com,
 olivia.chu@sifive.com, c2232430@gmail.com
Subject: Re: [PATCH v2] ftrace: properly merge notrace hash
Message-ID: <20250408140322.64318648@gandalf.local.home>
In-Reply-To: <20250408160258.48563-1-andybnac@gmail.com>
References: <20250408160258.48563-1-andybnac@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Apr 2025 00:02:57 +0800
Andy Chiu <andybnac@gmail.com> wrote:

> The global notrace hash should be jointly decided by the intersection of
> each subops's notrace hash, but not the filter hash.
> 
> Fixes: 5fccc7552ccb ("ftrace: Add subops logic to allow one ops to manage many")
> Signed-off-by: Andy Chiu <andybnac@gmail.com>
> ---
> Changelog v2:
> - free both filter and notrace hash when intersect_hash() fails
> ---
>  kernel/trace/ftrace.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 1a48aedb5255..bb9e1bf4fe86 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -3526,16 +3526,16 @@ int ftrace_startup_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, int
>  	    ftrace_hash_empty(subops->func_hash->notrace_hash)) {
>  		notrace_hash = EMPTY_HASH;
>  	} else {
> -		size_bits = max(ops->func_hash->filter_hash->size_bits,
> -				subops->func_hash->filter_hash->size_bits);
> +		size_bits = max(ops->func_hash->notrace_hash->size_bits,
> +				subops->func_hash->notrace_hash->size_bits);
>  		notrace_hash = alloc_ftrace_hash(size_bits);
>  		if (!notrace_hash) {
> -			free_ftrace_hash(filter_hash);
> +			free_ftrace_hash(notrace_hash);

Um, this should have stayed filter_hash.

-- Steve


>  			return -ENOMEM;
>  		}
>  
> -		ret = intersect_hash(&notrace_hash, ops->func_hash->filter_hash,
> -				     subops->func_hash->filter_hash);
> +		ret = intersect_hash(&notrace_hash, ops->func_hash->notrace_hash,
> +				     subops->func_hash->notrace_hash);
>  		if (ret < 0) {
>  			free_ftrace_hash(filter_hash);
>  			free_ftrace_hash(notrace_hash);

