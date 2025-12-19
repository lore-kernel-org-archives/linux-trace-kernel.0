Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0F122A1D4
	for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Dec 2025 09:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766136470; cv=none; b=dBrFsCGsNYOToWd3hjTQJxuoeB+5QcDV7LKnsC+52IK+TqoakWCFuLDl4etsDLbp6hjD5idn4sdCUOlCJtG6zS1QlGNFK6t+EJsH48WR3KhRMA7JiAQ//nMkE27l/1+oMuZ6vuzo/Ry66wB5ryEidaNmsfW3W11rLivRaD+B2o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766136470; c=relaxed/simple;
	bh=AWCb9Zlk3X/yQ+3/BM0yomxMF6ZXBp57Sea52ZPFdrk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJR2dC4qiR5zr2CL8DtbPGhuQ8QsO7n69odIq4pFlE9sifYSqTQPske0vKOOUxCxx6pDz2pjT9cTytkfp/kKe8wh1XUrgQP50DyxHzrG27rE1VBK6NfLZWg9xhQNIV9RyKaQ5PRQabB6RpMQKCw8mGbz9RU/+UIaSWdUlCPinZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a46tb6SV; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a46tb6SV"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477ba2c1ca2so15620265e9.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Dec 2025 01:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766136467; x=1766741267; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qmnXlxHoWq0NbG8Ccw5YQt/6uSNtB/ujN6Gu6zmgr7g=;
        b=a46tb6SVG4+Va3N/aQFdClrZMP12l4SGTA8d/Kk4HrWnXkBJZP0a65WHnIIBFKWr71
         QeB+wOzChmzWs0/CpRhFQ/15KUt4aNs0QSim+4E8q3tqTv2uQ11+/i+k3AKuj8KciiPZ
         LvC7Di5FP2pTLALZqTrSFN9oWIAb4nDhqwtiOnAANEJPlL0Y8scD/d7i3zR13zsEL+ll
         91sdx+twkF4Fu2i86jLLHlgl5Hz0a//y65xfoTNNWrdn3Vau4mpug8R5zB7Gt1tYuQxj
         ArYY27NaxfBNqu0RBkiT/xDHohiuBfA6M3Xr5HJMoktbCmGzorBMHMOJALF7zq45uTA6
         H9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766136467; x=1766741267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qmnXlxHoWq0NbG8Ccw5YQt/6uSNtB/ujN6Gu6zmgr7g=;
        b=eLzWiOVS/G0C228Xx5VDSH2a2Q4EbyTFqm6EsST721JZJvV8IgT+/waH5DFz+txLko
         cSgrjZyHqDJnnlpd7S57+vyLandlw0AAZYCZjAUzabgvPphXD66DFyyUQnl2RZEeW78/
         X3/X2bL6GTW1d6AWzriy37RrAb654AfmSLgqUVYtcwIrCU0NBd5TKB2JpSkmYfFmRoWI
         2E5+ef0BBpPl+BbP0SAgDQN3nuO3pkiMfploS7FASi81lEfXokZsRrBVZOj3vHiaR7Ed
         NGeRo98ixrmvO0Oj6sIkItAz+Nqgbmxe1XPkSQZ23VHyALaadcBiVqYEyTXM6lS7y6Hd
         I6Ng==
X-Forwarded-Encrypted: i=1; AJvYcCWEIU45LiyWQUwT62+0wWWkwLwCzLIPUtCj+brH0/0pYVdSjAA7Ydj2O2bAawIdRWuwPF5jQQON+Hn50SP+y9hz7H4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRaUi3yw2CjrRS7L5RKl6OEjoVXKVsc43f1+sJeOHhb1SKz46Y
	m//x/CghOkQ6w0dGSnFkT8P5ZinP9wbdYSPGFsTy66hpABQ4NZMv7y3w
X-Gm-Gg: AY/fxX49y7g4tD8LQst5KEGrM0a0oEU5FRnIepivOeHSRRZnHixp1wcbi5ZpSueUZSA
	RMAUta14vNuXAp3zQuAaV0SZc/nyGn5MCvh0k1YKtXrydkOH9ZrAYQHjn29nd52YVJoHVcYSlUz
	Co75ajJfSZJGuxjuANg848KwzjX3lfEhhVQmBmIv6EU783Q44Usv1LDjNYRkILoG7b543DAnJ43
	+JbhCyE2pbGvzDeDKUoV7wnueeScDM016ie2T/04XDS0iNMAdmt5DuMIU5AzVsHor6xkUjnTONg
	v9VlSOUOF40/PztEnxCPYn7ZZaV0dNPBK9h7yPjH9Iwc1herHH8TVnQi7+3xSWKn5ooKIFQ+dkA
	wI6EQvY8A+Aw+7VUgssG8UZGkcDzx+OrbuxTs+DprFeQ3DfNlOTyWSFc71c4M
X-Google-Smtp-Source: AGHT+IEyiXP2r+UagAVyzsxyVSYES1j9aAQG6eYvB7U3MJyHwiFSEqfhleLuOyMaRGuuYSwfofjO1g==
X-Received: by 2002:a05:600c:4e90:b0:46e:3d41:6001 with SMTP id 5b1f17b1804b1-47d1959440dmr18983345e9.34.1766136467150;
        Fri, 19 Dec 2025 01:27:47 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be27b28a7sm90595515e9.12.2025.12.19.01.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 01:27:46 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 19 Dec 2025 10:27:45 +0100
To: Steven Rostedt <rostedt@kernel.org>
Cc: Florent Revest <revest@google.com>, Mark Rutland <mark.rutland@arm.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Song Liu <song@kernel.org>
Subject: Re: [PATCHv5 bpf-next 5/9] ftrace: Add update_ftrace_direct_del
 function
Message-ID: <aUUakb_Bv1sDfJUR@krava>
References: <20251215211402.353056-1-jolsa@kernel.org>
 <20251215211402.353056-6-jolsa@kernel.org>
 <20251217204814.38756224@robin>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217204814.38756224@robin>

On Wed, Dec 17, 2025 at 08:48:14PM -0500, Steven Rostedt wrote:
> On Mon, 15 Dec 2025 22:13:58 +0100
> Jiri Olsa <jolsa@kernel.org> wrote:
> > +/**
> > + * hash_sub - substracts @b from @a and returns the result
> > + * @a: struct ftrace_hash object
> > + * @b: struct ftrace_hash object
> > + *
> > + * Returns struct ftrace_hash object on success, NULL on error.
> > + */
> > +static struct ftrace_hash *hash_sub(struct ftrace_hash *a, struct ftrace_hash *b)
> > +{
> > +	struct ftrace_func_entry *entry, *del;
> > +	struct ftrace_hash *sub;
> > +	int size, i;
> > +
> > +	sub = alloc_and_copy_ftrace_hash(a->size_bits, a);
> > +	if (!sub)
> > +		goto error;
> 
> Again, this can be just return NULL;

ok

> 
> > +
> > +	size = 1 << b->size_bits;
> > +	for (i = 0; i < size; i++) {
> 
> You can make this for (int i = 0; ...) too.

ok

> 
> > +		hlist_for_each_entry(entry, &b->buckets[i], hlist) {
> > +			del = __ftrace_lookup_ip(sub, entry->ip);
> > +			if (WARN_ON_ONCE(!del))
> > +				goto error;
> 
> And you can remove the error label here too:

ok

> 
> 			if (WARN_ON_ONCE(!del)) {
> 				free_ftrace_hash(sub);
> 				return NULL;
> 			}
> 
> 
> > +			remove_hash_entry(sub, del);
> > +			kfree(del);
> > +		}
> > +	}
> > +	return sub;
> > +
> > + error:
> > +	free_ftrace_hash(sub);
> > +	return NULL;
> > +}
> > +
> > +int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash)
> > +{
> > +	struct ftrace_hash *old_direct_functions = NULL, *new_direct_functions;
> > +	struct ftrace_hash *old_filter_hash, *new_filter_hash = NULL;
> > +	struct ftrace_func_entry *del, *entry;
> 
> One variable per line.

ok

> 
> > +	unsigned long size, i;
> > +	int err = -EINVAL;
> > +
> > +	if (!hash_count(hash))
> > +		return -EINVAL;
> > +	if (check_direct_multi(ops))
> > +		return -EINVAL;
> > +	if (!(ops->flags & FTRACE_OPS_FL_ENABLED))
> > +		return -EINVAL;
> > +	if (direct_functions == EMPTY_HASH)
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&direct_mutex);
> > +
> > +	old_filter_hash = ops->func_hash ? ops->func_hash->filter_hash : NULL;
> > +
> > +	if (!hash_count(old_filter_hash))
> > +		goto out_unlock;
> > +
> > +	/* Make sure requested entries are already registered. */
> > +	size = 1 << hash->size_bits;
> > +	for (i = 0; i < size; i++) {
> 
> 	for (int i = 0; ...) 

ack

thanks,
jirka
