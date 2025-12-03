Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293682253EF
	for <linux-trace-kernel@vger.kernel.org>; Wed,  3 Dec 2025 20:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764793517; cv=none; b=PL1NH9eNgIKehWyGAmFpWA6N5CPX0FcoiOrbOyzFHl03M+NHtC+uM1OE8R0J6xAJ5I3kujBt6FK8WzVHSTQAvTlwDQDVdfLaWQJNGDsaRckd3ik4fCoGpUDcAHdAPExiQlE2g+tkh1VkFGaUKhSLGAL1M1msp8Gjz09K0XeEAy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764793517; c=relaxed/simple;
	bh=JY0naZR5hs+Ypa48czG5r5Oxmp2geERTBHXqXeRyCL0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=if6dsMaXaQPUIHDPUOJxwUn/qhJ8OldZVDUAL5PeqmrfBfA3mUp0zJl+GVQDTgsdlS80TF33GFEhEcoKpLBpUtUliDuse7EY0XK2o3Pl1YQ9z1zLCnKLN2KnofAqOyD63RdAXXEiBA8A1Idh6u7OlAqOCW44pPzcmD3SlH4mtPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdAqfKOy; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdAqfKOy"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-429ce7e79f8so160851f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 Dec 2025 12:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764793514; x=1765398314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oizhgXioNHlMsxU7fpUazMHWzQeHiexW1qEA1YQTP5s=;
        b=bdAqfKOybA+Het2v8h+Nm4OUKi5tdHElg/SWYdj8gzX9hxn6P9glojzb1ts3dWZP3M
         8QZUNHvFAVyQ6k5Bm3g6fUGVvY3xmJJQMrQ5oVZuyq5FXa2XC1rshwiztt3WsAUic/p8
         5W5hKBvnfEy4EOZsnVJTCHiUvM5Vo+coeRha/o036SOVDoSGNuqzjZxavECvwOHh4hxJ
         UCDKe8YdAraieexZmFZfGBUvntGvUUZQSPpFDCZRnzpBSlBgE8MMh124qwP80dBDQJge
         4Qb1MhNGVxhCaVVaqEONyaCJwHn/QQ6YP2ingP+mNvBEoGKJN030dlwMJG88l7JBUJ3I
         21jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764793514; x=1765398314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oizhgXioNHlMsxU7fpUazMHWzQeHiexW1qEA1YQTP5s=;
        b=t2l9vFj2wIBdbPeYvChr2NDM4aNIpfUeddAgQQPTaD8yMJxIVQmXAGuYbIkkSPVfbW
         TAQDkbno1AXr9IhtcMX1UsTevoDUyOqyvrRTIYILrs2NMESwClJ8+BxDJIewxIKWxsSr
         PCxIKBLqNqba668zPfJUQQHUC/NpQEdhvJm3ILc0zUEBm1OGYzegJCrCj6xOWjvIYqzz
         Rg3/fR/sr/Pc8V3DIYAL5trrsMbRE/2/bL3gAHMkKmwIDeGkOBSyaaqyBQrEVR8FKf58
         YtIOt1mxp47sNyTMD14IREure7JakrQeb7KSpdOZ/FTX5zVJR/KjXHaXftcOve9gv50O
         IZ0A==
X-Forwarded-Encrypted: i=1; AJvYcCXR8Qrur0kgKP5HNWjjGqP1u7WL0JWjco+/i77gFdlShsQLsNBHnRjjumLEs4iBZI64/tW5I9loJg3ukpNsksWY1jM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFYE0Eu+vC/RPVA+9Y7JZ+4/XJicKRq7/uOk2TFTxD722G1lKw
	0HlnvgReUDCLhGb8wbAJfStGWdYdqB3lDAblaGGMDiDoUicY0JkuxRHQ
X-Gm-Gg: ASbGncvdBC8l5LQSzYBt9dKTq3XQVLB7Lp0hyUfqNOn34eSV57qJjsgDaJJ/Yu2qrg9
	J3FTGcKEaWtOIUjeKheWegKILv0dAI6dgmpMaKklZEUMQDshO77/7lf5gCVdQnRpXAe3XkMIsSR
	KUUYY+JO6QtIQD2n2A+IIsAyOmux2/RsM7c07b51GcH00NblLQ3oYxd0fmslUJ88KVkBskEtW38
	eyfKBjqsHIYbTmsCqCu58wqx09NVYrtPEMs09HxMdJf3/0oPT8K5J7jkLPZ0njj+BxcEW8pJCGY
	TU+LlQkY17DNG5W63gqjTxp0t4dCtOCq/yPXzYbw3TPHVB2QF/2boUyqUcMxHQXJi5FezEaicUW
	sKpHnKXM++edmNG5uQpRJRozaFUZ6CkuY1FIJE/uykaUG3mohSx4OBTKENLAC120VcJaQFdKno5
	g=
X-Google-Smtp-Source: AGHT+IFB0dXhJUy1H3c/C1Xkph6gjV5AO8hAVflW07n8nwfxgbiBQcjbDHqUFViroxpKvd/enGc4Jg==
X-Received: by 2002:a05:6000:430e:b0:42b:2a41:f3d with SMTP id ffacd0b85a97d-42f797fdfe9mr305634f8f.19.1764793514432;
        Wed, 03 Dec 2025 12:25:14 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5d614asm40905162f8f.12.2025.12.03.12.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 12:25:13 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 3 Dec 2025 21:25:12 +0100
To: bot+bpf-ci@kernel.org
Cc: rostedt@kernel.org, revest@google.com, mark.rutland@arm.com,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, menglong8.dong@gmail.com,
	song@kernel.org, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv4 bpf-next 4/9] ftrace: Add update_ftrace_direct_add
 function
Message-ID: <aTCcqGiWnEmGGuRI@krava>
References: <20251203082402.78816-5-jolsa@kernel.org>
 <d0d8e0d78f614eb8b443772b50fb36093d48c7f43374316246ad3ad836b5c9ce@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0d8e0d78f614eb8b443772b50fb36093d48c7f43374316246ad3ad836b5c9ce@mail.kernel.org>

On Wed, Dec 03, 2025 at 08:47:45AM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > index 8c034b028..eb60d971e 100644
> > --- a/include/linux/ftrace.h
> > +++ b/include/linux/ftrace.h
> 
> [ ... ]
> 
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index 84aee9096..1660a8754 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> 
> [ ... ]
> 
> > +int update_ftrace_direct_add(struct ftrace_ops *ops, struct ftrace_hash *hash)
> > +{
> > +	struct ftrace_hash *old_direct_functions = NULL, *new_direct_functions = NULL;
> > +	struct ftrace_hash *old_filter_hash = NULL, *new_filter_hash = NULL;
> > +	struct ftrace_func_entry *entry;
> > +	int i, size, err = -EINVAL;
> > +	bool reg;
> > +
> > +	if (!hash_count(hash))
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&direct_mutex);
> > +
> > +	/* Make sure requested entries are not already registered. */
> > +	size = 1 << hash->size_bits;
> > +	for (i = 0; i < size; i++) {
> > +		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
> > +			if (__ftrace_lookup_ip(direct_functions, entry->ip))
> > +				goto out_unlock;
> > +		}
> > +	}
> > +
> > +	old_filter_hash = ops->func_hash ? ops->func_hash->filter_hash : NULL;
> > +	old_direct_functions = direct_functions;
> > +
> > +	/* If there's nothing in filter_hash we need to register the ops. */
> > +	reg = hash_count(old_filter_hash) == 0;
> > +	if (reg) {
> > +		if (ops->func || ops->trampoline)
> > +			goto out_unlock;
> > +		if (ops->flags & FTRACE_OPS_FL_ENABLED)
> > +			goto out_unlock;
> > +	}
> > +
> > +	err = -ENOMEM;
> > +	new_filter_hash = hash_add(old_filter_hash, hash);
> > +	if (!new_filter_hash)
> > +		goto out_unlock;
> > +
> > +	new_direct_functions = hash_add(old_direct_functions, hash);
> > +	if (!new_direct_functions)
> > +		goto out_unlock;
> 
> Can new_filter_hash leak here?  If the second hash_add() fails but the
> first one succeeds, update_ftrace_direct_add() will goto out_unlock
> with new_filter_hash pointing to allocated memory.  At out_unlock, only
> old_filter_hash gets freed, not new_filter_hash.

mamma mia, can't get this right apparently.. yea, will fix in next
version, thanks

jirka


> 
> register_ftrace_direct() handles this by freeing new_hash on error:
> 
>     out_unlock:
>         mutex_unlock(&direct_mutex);
> 
>         if (free_hash && free_hash != EMPTY_HASH)
>             call_rcu_tasks(&free_hash->rcu, register_ftrace_direct_cb);
> 
>         if (new_hash)
>             free_ftrace_hash(new_hash);
> 
>         return err;
> 
> > +
> > +	rcu_assign_pointer(direct_functions, new_direct_functions);
> > +
> > +	if (reg) {
> > +		ops->func = call_direct_funcs;
> > +		ops->flags |= MULTI_FLAGS;
> > +		ops->trampoline = FTRACE_REGS_ADDR;
> > +		ops->local_hash.filter_hash = new_filter_hash;
> > +
> > +		err = register_ftrace_function_nolock(ops);
> > +		if (err) {
> > +			/* restore old filter on error */
> > +			ops->local_hash.filter_hash = old_filter_hash;
> > +			old_filter_hash = new_filter_hash;
> > +
> > +			/* cleanup for possible another register call */
> > +			ops->func = NULL;
> > +			ops->trampoline = 0;
> > +		}
> > +	} else {
> > +		err = ftrace_update_ops(ops, new_filter_hash, EMPTY_HASH);
> > +		/*
> > +		 * new_filter_hash is dup-ed, so we need to release it anyway,
> > +		 * old_filter_hash either stays on error or is released already
> > +		 */
> > +		old_filter_hash = new_filter_hash;
> > +	}
> > +
> > +	if (err) {
> > +		/* reset direct_functions and free the new one */
> > +		rcu_assign_pointer(direct_functions, old_direct_functions);
> > +		old_direct_functions = new_direct_functions;
> > +	}
> > +
> > + out_unlock:
> > +	mutex_unlock(&direct_mutex);
> > +
> > +	if (old_direct_functions && old_direct_functions != EMPTY_HASH)
> > +		call_rcu_tasks(&old_direct_functions->rcu, register_ftrace_direct_cb);
> > +	if (old_filter_hash)
> > +		free_ftrace_hash(old_filter_hash);
> > +
> > +	return err;
> > +}
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19887401362

