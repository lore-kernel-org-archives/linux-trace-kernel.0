Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7352D3EF6
	for <linux-trace-kernel@vger.kernel.org>; Fri,  7 Nov 2025 13:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762521305; cv=none; b=NbGJHQF2t/ewEwRQNEGio3uoTS3WHwS/VYaSBFNPsULD/x4VtUxuocOdSEBwtqglzepHtGmH+ZWj8d5CAAFE6+UpQtj52trKI0NMdgsXq5vsB9KUH3nbCDJgnHovJi+6Gu1WQHLFTV7pqaEmlnVevskPV6+Yx3lGvH+PlFtCa9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762521305; c=relaxed/simple;
	bh=0mPhFFV27EI4HWkCT/K0CutZwM23pABS/zg6xhegD68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDZUUj7GyQsFCrI1Dgn9Q2wbLpd/nWsoRz9PDaX0s+DZGOltrFRzU+EDr0bvw5tGze9PYjZ+RhDEKgQvQPDdZ9h3GLeIRfc8O1722ht4OTonO1lrjxjps0Ofx0KFzbA35t54Isqw6sMrYm0cDOiLbKMjzo/8A5KfuvVteh6Zu74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BlHoPCu3; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BlHoPCu3"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-64088c6b309so1273106a12.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 07 Nov 2025 05:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762521300; x=1763126100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8HZ8kO1EbOdno/Z6LWKvw9cCt6xKTq52Mcwxm+AjrMQ=;
        b=BlHoPCu3NqtLtozYF0ZyHTBdobJJ/cANVGnsDwuY6T8dx2F6BpG8CLWuG2V1KWCPn9
         rJqzhFhR33ZMV++LnBz96/RuLoQJElQKD/XgdMcwXWV7h9QKhE6GKnV5S15pYGxSNGqu
         KqaXf2ahPz1ifbkNBO7u8j2yiZH6M0K6PrgMzHi6k6ovXdGBxghrOCwCc/pEwIl/Eo01
         Pk2HH4fQOf3Bw6VYHGk0nxbI0DXzJSh5ufcLRQ9l6RwgF98tgxr22FjT0cjpknUAGNCF
         BA2TawykZDjdpivWUQQk7vyA0EjOpZxziWhEOwjmij06OkYHzpG2iI9J48haI79hsRab
         cxqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762521300; x=1763126100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8HZ8kO1EbOdno/Z6LWKvw9cCt6xKTq52Mcwxm+AjrMQ=;
        b=VwWiTHU7hCD/6wN9X7VpL/AVXJBlkPbXuJ4E5f4N2R9FqvL/n2MdRJ/wWPqAvpPTDi
         llQpxLGyDvpyHSFB4jub1ULlW8nU1sp8EbwFm6jla4cXVO/3RYlCSEZjYqZ+ndVKL1Jy
         xs+jqoFfD02UiMHtzThG0lDUaIkiaQ6gXAsE7t7jGFsj/aWnBPXWdmtjMXUUt5b8Xlic
         1c01EV3GLK9udOOTw92deCvNBnSCj6RYmzqOBFNmGKb7E6JG3OXizNsCSfhOpTkFni3m
         CdW1C8AEvQjTnNz39/ATkOpgyzQXQoz0ZAovziLz/WzCRkzp6aagmopI/PV8yD2vwBhT
         0jYw==
X-Forwarded-Encrypted: i=1; AJvYcCX7ifyWq7fnuGJQnGW+Lur8H8ptXpo3y56GxAa6b7Hy1MENkeGzLvh2rtvNLL2uHykpWo3JC3y7WAJ2/86JKNUKP+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Ryppng4rQEPbr0Cgk4x4lZLGjbFMZDftdpv+2PO9qo0ApqPq
	iGfRM7nL3Nwf0am6EfidHOVKW446VmnUygQqMqENmt9VhsL10bVluhuFq5TKQvFxPVw=
X-Gm-Gg: ASbGncuUSQsq+A4VoHTwx2iTVMVlcCYoViOht1Whh1nYTcsQHlza6GO/NLdH50FpZ5u
	TcZ4MPIqiW4phOyTmG+r5glyBBpL3VP1QEIquaZVpZ4eG6TLbpqLBQVN48xnf6mOL4qD9ROQb61
	3m9XMXPo2SoD4RHSoz1XTq5Wt23wXHvgkXMYjYIoeSiozQv4HUzg9RwvP4AddLk+jHr28+MzXNK
	K5WaUf73a979wg2BrIVU24vTUvTGF/gSg7XWgFuu9HAkZVZw/VYjfWvpJ/XcZQ9Dk+10ChlWA4w
	mod5XHFQ9RCtSNGQeaINYD5/6Mm8Vag/GTKgdkzH1/lErxSaW+q88Yg0jqRjVFVir2HDwx3Bqmv
	75QjDSPkncNEv9vUYkR5tCiFxP9GB5BN6d2uQgRfyf+43Kj8P7V5546Dpca4iqdQBzRytQHGaBN
	Q2opQ=
X-Google-Smtp-Source: AGHT+IFE2eYy0+Px5WausE/jRL0XZhUzH9bbFk8nsiudCpX/vMQhbSO5rZNKcgvz0+P/IDwF6D5asw==
X-Received: by 2002:a17:907:2da2:b0:b6d:5914:30c with SMTP id a640c23a62f3a-b72c090e4b7mr299535266b.34.1762521300369;
        Fri, 07 Nov 2025 05:15:00 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bfa24d1fsm233492666b.73.2025.11.07.05.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 05:14:59 -0800 (PST)
Date: Fri, 7 Nov 2025 14:14:57 +0100
From: Petr Mladek <pmladek@suse.com>
To: bot+bpf-ci@kernel.org
Cc: petr.pavlu@suse.com, rostedt@goodmis.org, ast@kernel.org,
	akpm@linux-foundation.org, kees@kernel.org, daniel@iogearbox.net,
	john.fastabend@gmail.com, mhiramat@kernel.org, mark.rutland@arm.com,
	mcgrof@kernel.org, da.gomez@kernel.org, samitolvanen@google.com,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	andrii@kernel.org, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH 2/6] kallsyms: Cleanup code for appending the module
 buildid
Message-ID: <aQ3w0awU61mrS_AF@pathway.suse.cz>
References: <20251105142319.1139183-3-pmladek@suse.com>
 <451acb410ee1ce42f7fb2da9f3b8162708f40788cb849cc0f50851ad16813349@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <451acb410ee1ce42f7fb2da9f3b8162708f40788cb849cc0f50851ad16813349@mail.kernel.org>

On Wed 2025-11-05 14:59:53, bot+bpf-ci@kernel.org wrote:
> > diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> > index 1e7635864..9455e3bb0 100644
> > --- a/kernel/kallsyms.c
> > +++ b/kernel/kallsyms.c
> > @@ -423,6 +423,37 @@ int lookup_symbol_name(unsigned long addr, char *symname)
> >  	return lookup_module_symbol_name(addr, symname);
> >  }
> >
> > +#ifdef CONFIG_STACKTRACE_BUILD_ID
> > +
> > +static int append_buildid(char *buffer,  const char *modname,
> > +			  const unsigned char *buildid)
> > +{
> > +	if (!modname)
> > +		return 0;
> > +
> > +	if (!buildid) {
> > +		pr_warn_once("Undefined buildid for the module %s\n", modname);
> > +		return 0;
> > +	}
> 
> When ftrace_mod_address_lookup() succeeds in kallsyms_lookup_buildid(),
> it sets *modname but doesn't initialize *modbuildid. This leaves the
> buildid variable uninitialized when __sprint_symbol() calls
> append_buildid().

Just for record. This is a great analyze. This patchset is fixing
this bug in a later patch. ;-)

> Can the check above read uninitialized memory?> 
> Looking at kallsyms_lookup_buildid():
> - module_address_lookup() properly initializes both modname and
>   modbuildid
> - bpf_address_lookup() sets modname=NULL (so append_buildid isn't
>   called)
> - ftrace_mod_address_lookup() sets modname=mod_map->mod->name but has
>   no modbuildid parameter
> 
> The commit message mentions wanting to catch when lookup functions don't
> handle buildid, but shouldn't kallsyms_lookup_buildid() initialize
> *modbuildid=NULL before calling the lookup functions to avoid undefined
> behavior?

It seems that we are going this way, see
https://lore.kernel.org/all/aQ3vWIqG31BgE4YD@pathway.suse.cz/

Best Regards,
Petr
