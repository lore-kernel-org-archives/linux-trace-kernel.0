Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199DE18A6DB
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Dec 2025 02:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764643835; cv=none; b=gkBaUIEYkuiGCtc4bFsnOnp2b2zuzDe+Mt4t7KWCiAn0oghDlpByVt31XHg5zexG9fC7B+SEYmsEKISow3tIYnE3KYHl5RPWfRh1AeP4mmZifdwzoOdvph1mAMLAEY5aZcPDV7DYbUJ0Zhbp/qNRQxidLd+smyG9M7Sz/eOyr4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764643835; c=relaxed/simple;
	bh=d2nnb4UTXFIkbAdN29yEdBrzizD88vkgBJQyyjX28+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MvlthWpd4chIRtfaDy5a5HT/lBrOyAOUd2dMa9EaWHNt9sV8gHWvHqOJJOxXg4hmkSoBMUFJnb44Y5hlU5xN1IEfoYTPflD+W4uDbyedyb9uW0stjDh49bLkd9054Nui7iQES4OJwQVpQYtD4TClyh5kV9xO57taEGRuT7WdNHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFwCF64F; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFwCF64F"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-640f88b8613so3609894d50.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 01 Dec 2025 18:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764643833; x=1765248633; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u4fZQuQJ65AJK2A7tpNQAB3pVThD3W5ngX9pcfsdMkk=;
        b=dFwCF64F5ApKy/c7oic3DFCfhlxY79ZJFYL1RYNJly2kyEgfdezaX5AymvXHWNSkiD
         n4IIC2Vl7ILl9zpc8RBfXPMtN1f0G873VSMEG51A7i35P+I24BWTtRoxzE08iLfxVXiA
         WBVv6qTs8na5DhlUoR34hGDJCf6103kIjo+q0QuTnT2+KzXzOT1vpLPpyhL31wlOqMw9
         BC6Q+wWzUMxd9wYxQbrJWYmYTCFGFKERT3Yc4Yo872wWZo7xLRQJXRWMd7uyhIQYLhpy
         Yz0/fF+2jertz9DGPgc/4hEmujAzs07sWKk5ggzCcvSvPVzPwfH7L+VLm8zTVNrFmB0Q
         nT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764643833; x=1765248633;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u4fZQuQJ65AJK2A7tpNQAB3pVThD3W5ngX9pcfsdMkk=;
        b=BH/OQRs5hGyjIkzhAMKQ/gR7HygGq+HJskJlXZouNhj9qboarD45VWSI0ZYDQx4+bF
         7FTdgB39y6JVP0WAJ4oweSv5n7FHpvZ9QVNgNbaIzN0oR4daWdwy6qb0h9U5GJ+8StkS
         ORYcBcgsFJKVHVnubz2mwG/uP1qrQNEe1zyqncjo7tjJDtQBV9+RUdodQIWK9WWXd/kC
         MQ9H22UaQNqnNkNMEmG5uSgJ/+ydzKdY+7eVMxBy2cEmP7ligaBZRmeGQL5RMsaw0BIE
         sxGRWF9LNoGx3zxXl0hfHlT+Xts4IzjgPka2bW3Oi9934xakpIFTx2iY4c2nVMTPxPxb
         Tpaw==
X-Forwarded-Encrypted: i=1; AJvYcCXAlxBoMC8IvptWT5ZKUNf7BZMUoajAE2U8mrY9t9M6m5wEqC3/7TP6L6sgLaG1m3enSLDNNevH4aOsRTPQimBq4m4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+gMVK+/Z0NXM0ntkEO3P9WpgJqEt4FAYlirdGePlbzLVaMIQh
	vgGVNCerrRG5PYgNyMbnlUND1taJLr18unUoyQzRo3u2Sz0Sis1nU5dc
X-Gm-Gg: ASbGnct1xf3teNbrMazpFCsfm827fAnYfl0OgdSspULnOEmZko4MGAtisO31RW3TyT1
	62oyFMn7zOq03QuZXRDoe5iPvu+WOEeRraFrIj7GyLy74qGG573S4nPJ+eje+RIKTuILs1k1usu
	AfzAFghb61ICeKNVsoQY9xsXmh41HfUJYWwzSpsm/clm15V1oUDBEjC/Fj/cZ5VkWpK/QU9uGX5
	w1RSf/4YAQQeHeQ3sUw0Q6PAzv4uRaz9TqsSCNxTxFzO6VzkZWvNmfs1SV4xyAw4407cM5cTJvg
	D66Mb8FDuCV+SHnvWXNudCo7pT29QPVChlTYGfs+BdZlRYvdMdlWJdxmbLD43N4z0ejm11n1kTB
	kGr6CNUhm/d0DAcDjpxoRh2z+74yWItSKPHQ+y+YQ760uXgT3I8bWDk8aeFOwuC6zZ3fbaXqb53
	vaIlxrXO8=
X-Google-Smtp-Source: AGHT+IFvjnC2S/Jp93rH0uVWc/73vRFOoYQepG4E9Ug5xxnCcXms6vpoqWinBuFed3GkRDU5HYh1CQ==
X-Received: by 2002:a05:690c:2781:b0:787:e9bc:fa1f with SMTP id 00721157ae682-78a8b54d8cemr340242637b3.46.1764643833002;
        Mon, 01 Dec 2025 18:50:33 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:8738:665d:bba8:afd0])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78ad1043a08sm58083027b3.52.2025.12.01.18.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 18:50:32 -0800 (PST)
Date: Mon, 1 Dec 2025 21:50:31 -0500
From: Yury Norov <yury.norov@gmail.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] kernel.h: drop STACK_MAGIC macro
Message-ID: <aS5T9-1z7PK32q9R@yury>
References: <20251129195304.204082-1-yury.norov@gmail.com>
 <20251129195304.204082-2-yury.norov@gmail.com>
 <3e7ddbea-978f-44f7-abdd-7319908fd83c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3e7ddbea-978f-44f7-abdd-7319908fd83c@kernel.org>

On Mon, Dec 01, 2025 at 10:38:01AM +0100, Christophe Leroy (CS GROUP) wrote:
> 
> 
> Le 29/11/2025 à 20:53, Yury Norov (NVIDIA) a écrit :
> > The macro is only used by i915. Move it to a local header and drop from
> > the kernel.h.
> 
> At the begining of the git history we have:
> 
> $ git grep STACK_MAGIC 1da177e4c3f41
> 1da177e4c3f41:arch/h8300/kernel/traps.c:        if (STACK_MAGIC !=
> *(unsigned long *)((unsigned long)current+PAGE_SIZE))
> 1da177e4c3f41:arch/m68k/mac/macints.c:          if (STACK_MAGIC !=
> *(unsigned long *)current->kernel_stack_page)
> 1da177e4c3f41:include/linux/kernel.h:#define STACK_MAGIC        0xdeadbeef
> 
> Would be good to know the history of its usage over time.
> 
> I see:
> - Removed from m68k by 3cd53b14e7c4 ("m68k/mac: Improve NMI handler")
> - Removed from h8300 by 1c4b5ecb7ea1 ("remove the h8300 architecture")
> - Started being used in i915 selftest by 250f8c8140ac ("drm/i915/gtt:
> Read-only pages for insert_entries on bdw+")

STACK_MAGIC was added in 1994 in 1.0.2.  It was indeed used in a couple
of places in core subsystems back then to detect stack corruption. But
since that people invented better ways to guard stacks.

You can check commit 4914d770dec4 in this project:

https://archive.org/details/git-history-of-linux
