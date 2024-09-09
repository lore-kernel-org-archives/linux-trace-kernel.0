Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC41728DBC
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Sep 2024 19:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725909490; cv=none; b=VrL0k/HmSB9+m7hKV28sDwLynw4k3v9sjbuTZiY3Oo6M0VUsu71xKaXXJzILJxZuiaiqqT5YeEKyMXhtpYi/OFaKJPtWs56CGMc1BBXN3soY06IY7eMnw+1FFBHr1szIxRGsXMPeNPzlb6Pibe2RGX6xo3/p4SYtsS3iyZtO7RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725909490; c=relaxed/simple;
	bh=PBb6BJJBUlYmCN8NF08UNc/AQ2Nw8vfA7qUECcb+NG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QzjEgxejluUrtdmMnpnD/XqJlNlSydPb9qwsrwrjcC6vqmBT7eEPXdjmxlkbdrGUMDZdSvnbbHDWlHCYSqPJC3fNvYPRLiCWBuMERQ2d7YZnoma6TQp3ogLm6CdNoxnRgb5fe+Usww9LcrPCxleWnfygpNrL1ZWcjxIbFBIDtWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZIzpEtiP; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZIzpEtiP"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2056aa5cefcso34405ad.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 09 Sep 2024 12:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725909488; x=1726514288; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=awDdYcH4Ol2E9MEir9p+xrgurPHbJyf1tah8ZLECos8=;
        b=ZIzpEtiPcBCZsO45mK25ZpLwIWlYZjR21vlGJ8R1Khn2+6n/jjFKdolTkQyq2s6bsa
         5BCJzykA566x5H4dcSZTiDM2IqnNXz/19RMf69j1UvzGrhMKBXC+O0snhLhwjx4sKucW
         lynGOAeDrc99JNjUBB8zU7ZDloAPbTZD6E9p0KfKKuQsXxxLLNjIafLktMguV7qtnwOK
         u+kJksX2Xm1C0JHD6I737spYG8S3KQ5fBjHv0tVPIxY4SGndaYkrVgK4IxDAkyZJB0KV
         FJ9F7zgUhTj0g1zBzGwpb1qF5bp8tn0GH75cYnEtaQTpEg68iNojuh27mtTittCTlWeU
         HXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725909488; x=1726514288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awDdYcH4Ol2E9MEir9p+xrgurPHbJyf1tah8ZLECos8=;
        b=PL2pNLgX3FAxOaBAuYRSlJf5Y2DyimzUgkqCN9zH6cSYMsKFQTHx5S1SuiVZiXWhoj
         h1k4L0ycLmeS2sv7V9C+Hl4dy3YYhB3+cbZqnUdSXxyHb42xLIUvaihdfCfVgfm7WTxZ
         Vww/n7jvrKPGdqU/0xHPdPC9h/GIDAhbz2aOcWWvHVBjSkYYm5+LKu4Gerexjm82j0tD
         0XqFCjTpkb/g73WoRW+zRVUS11QXfOQqdyHlGl9XZwg/qrK/8gZAJENl9RH1bgvgJAFc
         o0f5esW+atqtoyiNLGJHzHmeIdEQq8cTdKmQmbLoSwSOXna4gAVjkrxALjbnrw56WK0+
         pazw==
X-Forwarded-Encrypted: i=1; AJvYcCXV183x5dzvi9GqYJp85PBQxh0/N4I6/FKwE5o+et1k+B/EB74rxfro5rqVnBShY54mXGe6p+hqid595Br0JBF4akw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX+aMzmISngcneEEntlv/ukg+oDJoU5kEP5ErNgRtk5vea3Cvl
	yg/fF7kcdvpSO9KhGWHr8svqzRUi4Wq21H2ySDoHrRHQxbNebshec/xg4tvdijwrnDMqawiWZZF
	lkw==
X-Google-Smtp-Source: AGHT+IFiqhv94a49uNV65SWQ5CrccldabBJ8sCfPd+OEvTlINNx3Cz5NI/CVd33bMbroPnYlOMGPtA==
X-Received: by 2002:a17:903:1112:b0:1f9:dc74:6c2b with SMTP id d9443c01a7336-20744b7a78cmr297215ad.29.1725909487544;
        Mon, 09 Sep 2024 12:18:07 -0700 (PDT)
Received: from google.com (201.215.168.34.bc.googleusercontent.com. [34.168.215.201])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc10fa99sm6986538a91.39.2024.09.09.12.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 12:18:06 -0700 (PDT)
Date: Mon, 9 Sep 2024 19:18:01 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Kris Van Hees <kris.van.hees@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Jiri Olsa <olsajiri@gmail.com>,
	Elena Zannoni <elena.zannoni@oracle.com>
Subject: Re: [PATCH v9 0/4] Generate address range data for built-in modules
Message-ID: <20240909191801.GA398180@google.com>
References: <20240906144506.1151789-1-kris.van.hees@oracle.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906144506.1151789-1-kris.van.hees@oracle.com>

Hi Kris,

On Fri, Sep 06, 2024 at 10:45:01AM -0400, Kris Van Hees wrote:
> At build time, create the file modules.builtin.ranges that will hold
> address range data of the built-in modules that can be used by tracers.
> 
> Especially for tracing applications, it is convenient to be able to
> refer to a symbol using a <module name, symbol name> pair and to be able
> to translate an address into a <nodule mname, symbol name> pair.  But
> that does not work if the module is built into the kernel because the
> object files that comprise the built-in module implementation are simply
> linked into the kernel image along with all other kernel object files.
> 
> This is especially visible when providing tracing scripts for support
> purposes, where the developer of the script targets a particular kernel
> version, but does not have control over whether the target system has
> a particular module as loadable module or built-in module.  When tracing
> symbols within a module, referring them by <module name, symbol name>
> pairs is both convenient and aids symbol lookup.  But that naming will
> not work if the module name information is lost if the module is built
> into the kernel on the target system.
> 
> Earlier work addressing this loss of information for built-in modules
> involved adding module name information to the kallsyms data, but that
> required more invasive code in the kernel proper.  This work never did
> get merged into the kernel tree.
> 
> All that is really needed is knowing whether a given address belongs to
> a particular module (or multiple modules if they share an object file).
> Or in other words, whether that address falls within an address range
> that is associated with one or more modules.
> 
> Objects can be identified as belonging to a particular module (or
> modules) based on defines that are passed as flags to their respective
> compilation commands.  The data found in modules.builtin is used to
> determine what modules are built into the kernel proper.  Then,
> vmlinux.o.map and vmlinux.map can be parsed in a single pass to generate
> a modules.buitin.ranges file with offset range information (relative to
> the base address of the associated section) for built-in modules.  This
> file gets installed along with the other modules.builtin.* files.
> 
> The impact on the kernel build is minimal because everything is done
> using a single-pass AWK script.  The generated data size is minimal as
> well, (depending on the exact kernel configuration) usually in the range
> of 500-700 lines, with a file size of 20-40KB (if all modules are built
> in, the file contains about 8000 lines, with a file size of about 285KB).
> 
> Changes since v9:
>  - Reverted support for optional 4th arg to generator script.
>  - Reverted support for optional 6th arg to verifier script.
>  - Added modules.builtin.ranges ad vmlinux.o.map to CLEAN_FILES.
>  - Fixed support for sparc64.
>  - Fixed support for LLVM's lld linker map format.
>  - Updated error message when .*.cmd.o cannot be read by verifier script.
>  - Added syntax output for verifier script when not enough args are given.
>  - Return 1 from verifier if verification fails.

v10 looks good to me. I tested x86_64 and arm64 builds with both
GNU and LLVM toolchains, and confirmed that built-in Rust modules
are handled correctly. The code looks reasonable too. For the
series:

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Tested-by: Sami Tolvanen <samitolvanen@google.com>

Sami
