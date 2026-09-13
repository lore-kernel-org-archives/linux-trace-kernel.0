Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D2F28726E
	for <linux-trace-kernel@vger.kernel.org>; Sun, 13 Sep 2026 20:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789330390; cv=none; b=K1hFKdTKVikFm6NgREDpTXvIGJkRQQ6hmzBWQb2cgKlaE6BGIMcAHorM6NjdXT1mUlxWCjeO01kb7gis7Sp7+cr1zu7YOKyhr9nqHqD5jmKN3D6sOCv1qonj8hwkBKbCNTBYlbiSrFM1JWzS/nlR2bgkFrpU6kf28BRsUchceYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789330390; c=relaxed/simple;
	bh=aHBF4LPvg2Zd3w4oaY7s8UbFfrBRImr+0PKCbkJaXE4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qgakw5dX6UMP9AeWdrFb114+Alv/9NBQEUEFCEOpa2dcFnWb2HHTuDWEu5CMAfWI6JEJ+hEOnNVgMiaC9U4Y4Hms296XIHY7xwtiyLp3NhrVjeHx79JbeyyuuIGoqAe1rgR20NHJDxEajAFCMsuePHLdospiOz7ieZqpOz28v8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mV8K5Odd; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mV8K5Odd"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd6185db7so7516945e9.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 13 Sep 2026 13:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789330387; x=1789935187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S5P6uH54234ueGuk+BCRhOiLjgsTrePIHYW1areU63o=;
        b=mV8K5OddZLBzCJXQFLtdPDe2bjlVk8m0OcH3RDqSCG+PDqiTmyOfEy3VMdk2pzo121
         pkbLlRtp6RnfGkz+C+KlUjcDD1A6J/E5153b1zPfMTNK0qtNdOFgcNnUo7qMu5+TDuy1
         spgeKxvtQi4R3o0j0F4sp8dkeUyeTAvKWDiTJsN7RGx/YEP2wyWbRNOa1D5CNROfteMz
         LZkKGF3Vw+Vq/RXwejD+hPCyKRlIe3uvA7yWtwdVZEtq08q2dpY7++BtxcTnsw5W9c/f
         sOoY1yY3HYxtWkJquJ0qlna555xzyAjO/DZxM2Hufg1LsZ81s7OU7zFWqSe6mhrMM7RR
         9M7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789330387; x=1789935187;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S5P6uH54234ueGuk+BCRhOiLjgsTrePIHYW1areU63o=;
        b=ncim6/pUDkEYNVHKnQk69iaaGna59elbCT7mcsURZH7Rjd7oCJeIRrhgxCu58DcB8k
         8nauQI/n84fs8BnCq0hcQDimPT2ceQBVaRlOSkirNCtT9SpkZdMi7tBvc6FWdz0yh+q1
         AlKJHHphTv9YaxNkWVwlio/yssLjWMT9lP1U64ANjiwO8520eEsT3IUV2wz8tYHfKval
         NPgmK+OmAdhJEEQlPzuaZKlc0wn+r8acY8DJVwBxCu9qIM7Tz9x/sAb0F97AiLqQGcZk
         HKb/obwrVdvP0Tavg+pEYFZHN72TnzJ6ytXhL06MI7TIHx53hPWrypskJ3wzDbx73MFN
         qx2w==
X-Forwarded-Encrypted: i=1; AKwUvByKz0hSUP8rsyhp7TyvMDR4mQ5hmaqUy7dvU+dxLz0885v1VMizu8QEsHOA7KnGabKDXSi+++KU/J0/lioLU/5jTp8=@vger.kernel.org
X-Gm-Message-State: AFuF++l2/ya6niXDlXpnVxbCaqVawD7pr4l5z125zka8h0LlCmGvirsU
	DoX6FrmSpVtcW1zRA1L0UwBst9WkwpOP+wyDMn/5hfBtecpLzCLW6FqH
X-Gm-Gg: AYBFou3Caj1gcygy0XytE1lXgs1bt1z8EytoKh5LdhgQtE5spF6mfn2j3xwyfWw/7Bk
	lXHU8/PnJ/gmgEDvhEXFancR5PnsuWDdkTKCQC8mLBjv8+ZXEJp3TJVsDPh3H2p8dIK24WoJ6X7
	pjY9/fQGngeDUYEMeD3gDB4Cz9Whqy9c9Uv0eJ2hoM8Nqq2YCZLw9hO2LPWwEbvh9QLNk70pSDG
	BQ0nR9Raoq1tUDQLs8Z+PG2wCwq8Y84HX8sIcrm0WHBzjmZm8qlR6e0W11t82kJLZ+Mv6U4rEzD
	bYrgwt6MIpgvUaVGqhs13TAr4u2FMiOSrd1p/KPuzmku4+R8ilx1oeK4tJFMGI1ZvwM3gw8uPmp
	nDuLYbjmls5LtHC5QIJ/g3XvQpE6RYuSqDTye+cep+Y+RdyF8MHsFKz5ooUXBOu62X1kgato5Em
	MEUBHZcBEm1DuSGCVo6k0NVCQWk87cXnHeoFWyJTPN/AAE9htheiWxOj5x1w==
X-Received: by 2002:a05:600c:4f84:b0:49e:715d:95ca with SMTP id 5b1f17b1804b1-49e760727e4mr37982455e9.13.1789330387007;
        Sun, 13 Sep 2026 13:13:07 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60ad0614sm277930945e9.10.2026.09.13.13.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 13:13:06 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 13 Sep 2026 22:13:04 +0200
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] ftrace: Use rcu_assign_pointer() for tmp_ops filter hash
Message-ID: <aqcD0FsrqV7gkNCD@krava>
References: <20260911142512.19344-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911142512.19344-1-leon.hwang@linux.dev>

On Fri, Sep 11, 2026 at 10:25:12PM +0800, Leon Hwang wrote:
> tmp_ops.func_hash->filter_hash is annotated __rcu, but
> update_ftrace_direct_mod() assigns hash to it directly. Sparse reports an
> address-space mismatch.
> 
> Use rcu_assign_pointer() for the assignment.
> 
> Fixes: 50b35c9e50a8 ("ftrace: Use hash argument for tmp_ops in update_ftrace_direct_mod")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202609110704.Q3M5vCDV-lkp@intel.com/
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  kernel/trace/ftrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 53d5db60bfa5..673a54fdf392 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -6675,7 +6675,7 @@ int update_ftrace_direct_mod(struct ftrace_ops *ops, struct ftrace_hash *hash, b
>  
>  	/* Enable the tmp_ops to have the same functions as the hash object. */
>  	ftrace_ops_init(&tmp_ops);
> -	tmp_ops.func_hash->filter_hash = hash;
> +	rcu_assign_pointer(tmp_ops.func_hash->filter_hash, hash);
>  
>  	err = register_ftrace_function_nolock(&tmp_ops);
>  	if (err)
> -- 
> 2.55.0
> 
