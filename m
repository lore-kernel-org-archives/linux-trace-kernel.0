Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB932E091E
	for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Dec 2025 09:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766136464; cv=none; b=qpNYytKXfIDHQu8vROW+0S0vG6CrDIEhk3F88cenCgaL/Wf6Oc2FB/F2w2OiX7bRPAn1/uoO4iMLdjxK2FexDSjF04a2eVEJZ+Y33NwJ4ZU2nPRfJWvomDg/cXhHgzqVuioO5RKiqMVC501NqWwLmFZ4ngh78XqVsJ4Qk3rwT+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766136464; c=relaxed/simple;
	bh=/Uh5/0uVYB5Mde+NWjpZ+Op18cNz2TMpFHw4AqCywEE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZp5v6VsJwsHYiVXYr20s/YckqZIuRZX7MEeaOvLCT6BYR3PliIDWg7lMPAVccZvJoFUSZy6fXsSxuG+resDFHYCVMhYeCgLBWK+m9/GQlIpCQYreVzH0x3FTLFjjRzwD5tcvuRv4YsS6fjxnFTsvGgZnAMVXcBEya9ncJjuGJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvB2haNo; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvB2haNo"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477aa218f20so9796135e9.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Dec 2025 01:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766136461; x=1766741261; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l4nPSaxdkYRmJvc/bAjl6gt7fyBjx03ifV8lSbnPKMU=;
        b=lvB2haNoJ6rJGO5tuJZsnHm7qG6ftihuwZq2NmKG84UNPt4FW92aMHVTkG263IUmql
         bUxkoG30RRQiID7ANr4jdJdSQPn0qCM6KaABBuw3szVaWlptDEta0nDbcG/yGcLNjyl3
         8qBsxxgI/73dmFmoULoCffOmD2t+FoxSHUpbQOXbZtszoe/ow6AiyGuVBeI2wiqq4Rdl
         4LBuQACsQQW3T/OPeWMwbnnbYJBdQoWIh8A3bFhNx1kdIULjkox2AJlZx+H/JYw5XGKy
         fMR/6ukPVlpRA+cFWtBJUfRFUUKLOC2QNP2ve+FRmlk9vRRfpxWQCQmGuJz0d8NDaTbk
         6bsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766136461; x=1766741261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l4nPSaxdkYRmJvc/bAjl6gt7fyBjx03ifV8lSbnPKMU=;
        b=W3YwGMUn9HL9BTbTsT8eyUIvSkpjqaNAT47e3Z+wqYQlEIc0hn5WAnQaelm2CWz+8Z
         +nEwLqZgnVZEle4lSK2+1c1WSButjhGb4Qh/y09h+kGriz+XijhSW7jBF7vJlOqAsjYf
         j/6ZBDpO92ZucLXJy5M7yX3Ref+DZ6yMOv577NYq/Pk2+SDwTJbD2Vo6ufXr3Z3LtW5f
         TXeVbqWe4aiMUSMFqcpStWpNuGjLl9xrnFv3sVMlBC8xxcOlhmtX4esPnG3a9p8+bngx
         O9ebClzfdVEjgaFXE6VP2dSVK4L7HHNtCzOtQQcVL4u7Co7OD0ldXcdNLzQpVBhv4h32
         OtHA==
X-Forwarded-Encrypted: i=1; AJvYcCXLKKR3vc3VXGyy77e9dtJmzRr48KZww8geTY7dUwD+QcHDFS3wTMnBT58VM7ybeD36uPGygfybs6whwwwhSYJ/XJk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj3veaKIrdXfPLik/J/X/ZYjDhOu2p/MuJSbyDMd63dsvaY3xl
	HGy+orKaDwa16bPjoEmc67ZZnlRTZRsOg75tZBL+LjpstLS0DnU7dYzt
X-Gm-Gg: AY/fxX5z8EVpQpPmv71AL+Q/ZtFm8ym4iDaMX/YKnwYIgeORSDdND1TxneEkCFS8SLb
	gBC4U5J4/3Z7RbaEoH668Ff9pfEBectAAlDNlXEb9N4X0SQ/n1HGomOAAj5/izEDSXX1PtKxiJe
	oo7VRcVX9SJSBJLgw4pTxWjutl8dwHioaL94hVENG36aFT8p6BfFHORJOpEhkxM0B5p2hF6arK1
	GMh8v+iPKTP5Zet8dzV31EzBccutcoH9Bs3WW17wm8WVmD0SwihwUh5Id6Wvf+WCtl2nku4skbA
	ny3Mq+lDHRxXGSvKpbBuJBUS8Q81c49tN3G/KoMPfC+qoKPFUAPjdYMtA5UOFq1yAnfAE3zdUPq
	TfyJ3EHnR2RtJcDrsHkkdQZ1dwfBfLIthozXF0mrvbHkaTCDi27BUoeTihzYO
X-Google-Smtp-Source: AGHT+IFlqi3iHxkGvauVr0NGTT2g6Itjhn/GDO0PNuIXTX1fYZewz4dI/OFWH3DrEPm2JlrPjHWWLw==
X-Received: by 2002:a05:600c:820d:b0:477:7c7d:d9b7 with SMTP id 5b1f17b1804b1-47d1958e475mr18862055e9.33.1766136460836;
        Fri, 19 Dec 2025 01:27:40 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be273f147sm88493555e9.7.2025.12.19.01.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 01:27:40 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 19 Dec 2025 10:27:38 +0100
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
Subject: Re: [PATCHv5 bpf-next 4/9] ftrace: Add update_ftrace_direct_add
 function
Message-ID: <aUUaiqP4kjGwlUMG@krava>
References: <20251215211402.353056-1-jolsa@kernel.org>
 <20251215211402.353056-5-jolsa@kernel.org>
 <20251217203909.474ae959@robin>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217203909.474ae959@robin>

On Wed, Dec 17, 2025 at 08:39:09PM -0500, Steven Rostedt wrote:
> On Mon, 15 Dec 2025 22:13:57 +0100
> Jiri Olsa <jolsa@kernel.org> wrote:
> 
> 
> > +/**
> > + * hash_add - adds two struct ftrace_hash and returns the result
> > + * @a: struct ftrace_hash object
> > + * @b: struct ftrace_hash object
> > + *
> > + * Returns struct ftrace_hash object on success, NULL on error.
> > + */
> > +static struct ftrace_hash *hash_add(struct ftrace_hash *a, struct ftrace_hash *b)
> > +{
> > +	struct ftrace_func_entry *entry;
> > +	struct ftrace_hash *add;
> > +	int size, i;
> > +
> > +	size = hash_count(a) + hash_count(b);
> > +	if (size > 32)
> > +		size = 32;
> > +
> > +	add = alloc_and_copy_ftrace_hash(fls(size), a);
> > +	if (!add)
> > +		goto error;
> 
> You can just return NULL here, as add is NULL.

ok

> 
> > +
> > +	size = 1 << b->size_bits;
> > +	for (i = 0; i < size; i++) {
> > +		hlist_for_each_entry(entry, &b->buckets[i], hlist) {
> > +			if (add_hash_entry_direct(add, entry->ip, entry->direct) == NULL)
> > +				goto error;
> 
> Could remove the error and have:
> 
> 			if (add_hash_entry_direct(add, entry->ip, entry->direct) == NULL) {
> 				free_ftrace_hash(add);
> 				return NULL;
> 			}

ok

> 
> 
> > +		}
> > +	}
> > +	return add;
> > +
> > + error:
> > +	free_ftrace_hash(add);
> > +	return NULL;
> > +}
> > +
> 
> Non static functions require a kerneldoc header.

ah right, will add

> 
> > +int update_ftrace_direct_add(struct ftrace_ops *ops, struct ftrace_hash *hash)
> > +{
> > +	struct ftrace_hash *old_direct_functions = NULL, *new_direct_functions;
> > +	struct ftrace_hash *old_filter_hash, *new_filter_hash = NULL;
> 
> BTW, I prefer to not double up on variables. That is to have each on
> their own lines. Makes it easier to read for me.
> 
> > +	struct ftrace_func_entry *entry;
> > +	int i, size, err = -EINVAL;
> 
> Even here.

ok, will split

> 
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
> 
> If you want, you can remove the i declaration and use for(int i = 0; ... here.

ok

SNIP

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
> > +	if (new_filter_hash)
> 
> free_ftrace_hash() checks for NULL, so you don't need the above if statement.

ok

thanks,
jirka
