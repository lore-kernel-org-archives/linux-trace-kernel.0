Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5D32222B4;
	Mon,  7 Apr 2025 20:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744056492; cv=none; b=bUJO64/w7BJtzH4RpgnCSa69Bwg26wFu2cn305xpp4C4v4rvjQFr536KBOgCYRsEG6p88tWqWCkTEDR0K5UJ3Z9YHL93eOOz/b6EVIkDJbYvdvx47BPMElaKGRIdPDWgutVJD+g++5wx2uEhDa5Lrg2eAYE/DCk/K6y2yjATcHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744056492; c=relaxed/simple;
	bh=20stuSGvYmMIDzBJ1uUogt6bLz0H4E+TAVS8IFvSFEs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NhsLNiRObdnHF357Pt07NfOjNxq1vIverf9RLWc/g98nVyyiXdGfD55dJX8mKNfYl7IH7ptsyZ46EkQgVXoM3eql6Cd4wznDyloXl7HEgHSCl6EgroxsmkI/U3iKWzGsGbDaFPVz2lQYKlaOoeDBYvdV4dqME5n6KZ/VAc1bMg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67CF1C4CEE9;
	Mon,  7 Apr 2025 20:08:09 +0000 (UTC)
Date: Mon, 7 Apr 2025 16:09:24 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andy Chiu <andybnac@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mark.rutland@arm.com, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 bjorn@rivosinc.com, puranjay12@gmail.com, alexghiti@rivosinc.com,
 paul.walmsley@sifive.com, greentime.hu@sifive.com, nick.hu@sifive.com,
 nylon.chen@sifive.com, eric.lin@sifive.com, vicent.chen@sifive.com,
 zong.li@sifive.com, yongxuan.wang@sifive.com, samuel.holland@sifive.com,
 olivia.chu@sifive.com, c2232430@gmail.com
Subject: Re: [PATCH] ftrace: properly merge notrace hash
Message-ID: <20250407160924.7c28fffd@gandalf.local.home>
In-Reply-To: <20250407180745.42848-1-andybnac@gmail.com>
References: <20250407180745.42848-1-andybnac@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  8 Apr 2025 02:07:44 +0800
Andy Chiu <andybnac@gmail.com> wrote:

> The global notrace hash should be jointly decided by the intersection of
> each subops's notrace hash, but not the filter hash.
> 
> Fixes: 5fccc7552ccb ("ftrace: Add subops logic to allow one ops to manage many")
> Signed-off-by: Andy Chiu <andybnac@gmail.com>
> ---
>  kernel/trace/ftrace.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 1a48aedb5255..ee662f380b61 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -3526,18 +3526,17 @@ int ftrace_startup_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, int
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
>  			return -ENOMEM;
>  		}
>  
> -		ret = intersect_hash(&notrace_hash, ops->func_hash->filter_hash,
> -				     subops->func_hash->filter_hash);
> +		ret = intersect_hash(&notrace_hash, ops->func_hash->notrace_hash,
> +				     subops->func_hash->notrace_hash);

Thanks for catching this.


>  		if (ret < 0) {
> -			free_ftrace_hash(filter_hash);

The filter_hash still needs to be freed, as it could have been allocated in
the previous if statement and never used (both the filter_hash and
notrace_hash get used at the end of the function via ftrace_update_ops().

Care to send a v2?

-- Steve


>  			free_ftrace_hash(notrace_hash);
>  			return ret;
>  		}

