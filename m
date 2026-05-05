Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6500E407587
	for <linux-trace-kernel@vger.kernel.org>; Tue,  5 May 2026 12:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777983888; cv=none; b=IiNqIUxlcZxwSL50Y+FSNCNlnVNBN2s26BYt9Htu8yOsyY+sV03ejdgltqe7r6+1kTuj4JT6pemb5pqacjwjThaVyDORlVrw4t7VRkzEOGHPkwnnVfryFk8VwOUxSKNfewKlX1H+6PM6lYlKx7DXFuSny4gPPgiGxASPGfPVR6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777983888; c=relaxed/simple;
	bh=T60HQbL8qDyAg5IiNgQTk8uqdsTOZsHn/TzRE3z1AbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mra/jiP1jvRBWTLxJmjuVMKJuwNvPYEOnzn2aGGhf19vjWkZLMaVTGeBZL7Pm/jgvu/Unp10M79tXguuAQM3qawS5iBkZDgil9BfNn4wUR6ryWErLjzkD6qFUAVT8alM9DROVfx/PBcp7iMUfH/hEMAguDifd4WAuec33FcrpgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cnj/gdL+; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cnj/gdL+"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-44a74032ff8so2772736f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 05 May 2026 05:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777983885; x=1778588685; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7yiH2TZpywbFVEglbVYA5/bUDfLfXjzVUSCKuxkRreU=;
        b=cnj/gdL+YLBQrX4yDlj3bwHxc/BaimJFIo/LT+2ZeTyz9TR58jX2qTFdWtuSSJAF6M
         3QO13kQmzU/zQRVbpSQE42Xx+QpQnmFvy0u6v1fsXCOEO22UJTRkms9ohm01t/FaOW3G
         jaX8kF3sbydz1tge4OXh4RbMtBf/oj9UWUbesg0rYY9M4bcgxpYEqueaLR4YQ/SlVtb2
         vjOXnAFZg4un5ydx78MWCwcWGiqtc5+sWF0W93aDgh9pb7o+Vicczk7DC7Cz05GkzGIo
         iociAN9JrOKFcfRrG5owf3NGebyoiYxQK+gB9T4fa4d2j9EpbvmSpMmpl0eG28mDDJer
         taMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777983885; x=1778588685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7yiH2TZpywbFVEglbVYA5/bUDfLfXjzVUSCKuxkRreU=;
        b=dGS5qcGPrbAwng/WakyFRHaViH9O5pXCtPrYreb85vPRhjHnYeuADhz72NWLKju8vu
         ZBB5P2REJC4qHGruAKc3889eW75xcPsbiSJgNjSM3AZTvnoMObKtX/dECRPDMgCQY6jv
         Ee1zTUVZqXmAa6tfk3Ud06dFkrXs26vHSwpJFMSqOzEoqVZtJmP5eFSJ5pyP/+5MPfx3
         3v80gBOqh1UEzolY7UlZhxzaO9+z4UZVQbBh3vqIo4j3gBpzt9OoU4u+m8f+SAinKibr
         PVhzCTU14ZmgLCzlHT9fzGVLokTmPX/OeyE5VyGqSrSv1M4I4dShvSzzWUg/7io20mfk
         ZbqA==
X-Forwarded-Encrypted: i=1; AFNElJ/jUrC6BhDrVAsz2ooxOZzzBRRAd1mRfKTLRtXZ8D2tBYRkm61qD5449xQNs65gdUSQmvd1gRRutX/vyDwlire4t4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YweyGU254hShsMx2i1SYTsJze1rlUH4Pv+o23iCzfHL66JhQ6SS
	3KzfIWh8OBj17FZ+Yr9UGpUatd055xClGsrYYILL5JyFfXrwtQLem3usoB9iLeyiW2k=
X-Gm-Gg: AeBDiesJSJjetFCxyqrdS+IjPHZKrmbLdZse6kyj9Cb3dsS9Ju3IdZk3R2KC2LH4wgq
	ygrFIcCJr/P3ghhq8hYrNaiFeOrEDDwK9fQopJxBjpYpAdAcZZ11yJ2EbLxzn8bExqirV0tWobt
	lIT6RSzFy2AmR5Wa0hRxAswjMfar2ZROplsW89V8FH78p+ZTb0rGCg9UusYrGbgsPqOJGR8z/uM
	xE+06Re5Op2Bu9He4y2ij3UPaNWZv0ASbe47PzLX6C81q1dBr16CzsZ0ZOyO9N9/WY/GFbhc/si
	/3d2g2+3Acv/gxcXfXnFgRvGFhpWz6/zCllsrNba0G876CqR1cDMLzor0E//MAiXIfrUVPD9WVm
	w5jinY8mQJG2x9JhMYnCPirUhK71hljtPl0rssAI3ao1sWQnPy5vTtJKKt/9Bw6s6OIHBrfGlyG
	NWmuzbTLM764/+T8rU5YYxroOfGIrPZzu+PYKYbxTGXMTX2DI=
X-Received: by 2002:a5d:64c9:0:b0:43d:7d24:b4ff with SMTP id ffacd0b85a97d-44bb772f856mr22057200f8f.40.1777983884553;
        Tue, 05 May 2026 05:24:44 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4505285e765sm4159009f8f.10.2026.05.05.05.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 05:24:43 -0700 (PDT)
Date: Tue, 5 May 2026 14:24:41 +0200
From: Petr Mladek <pmladek@suse.com>
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-modules@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, live-patching@vger.kernel.org,
	Daniel Gomez <da.gomez@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jordan Rome <linux@jordanrome.com>,
	Viktor Malik <vmalik@redhat.com>, Miroslav Benes <mbenes@suse.cz>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH v2 2/2] module/kallsyms: sort function symbols and use
 binary search
Message-ID: <afnhidn7K7dZ_cPh@pathway.suse.cz>
References: <20260327110005.16499-1-stf_xl@wp.pl>
 <20260327110005.16499-2-stf_xl@wp.pl>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327110005.16499-2-stf_xl@wp.pl>

On Fri 2026-03-27 12:00:05, Stanislaw Gruszka wrote:
> Module symbol lookup via find_kallsyms_symbol() performs a linear scan
> over the entire symtab when resolving an address. The number of symbols
> in module symtabs has grown over the years, largely due to additional
> metadata in non-standard sections, making this lookup very slow.
> 
> Improve this by separating function symbols during module load, placing
> them at the beginning of the symtab, sorting them by address, and using
> binary search when resolving addresses in module text.
> 
> This also should improve times for linear symbol name lookups, as valid
> function symbols are now located at the beginning of the symtab.
> 
> The cost of sorting is small relative to module load time. In repeated
> module load tests [1], depending on .config options, this change
> increases load time between 2% and 4%. With cold caches, the difference
> is not measurable, as memory access latency dominates.
> 
> The sorting theoretically could be done in compile time, but much more
> complicated as we would have to simulate kernel addresses resolution
> for symbols, and then correct relocation entries. That would be risky
> if get out of sync.
> 
> The improvement can be observed when listing ftrace filter functions.
> 
> Before:
> 
> root@nano:~# time cat /sys/kernel/tracing/available_filter_functions | wc -l
> 74908
> 
> real	0m1.315s
> user	0m0.000s
> sys	0m1.312s
> 
> After:
> 
> root@nano:~# time cat /sys/kernel/tracing/available_filter_functions | wc -l
> 74911
> 
> real	0m0.167s
> user	0m0.004s
> sys	0m0.175s
> 
> (there are three more symbols introduced by the patch)
> 
> For livepatch modules, the symtab layout is preserved and the existing
> linear search is used. For this case, it should be possible to keep
> the original ELF symtab instead of copying it 1:1, but that is outside
> the scope of this patch.

What is the exact motivation for the special handling of livepatch modules,
please?

Honestly, I am always a bit lost in the various symbol tables. It is
possile that I have got something wrong.

Anyway, my understanding is that there are two aspects which are important
for livepatches:

1. Livepatches need to preserve special symbols which are used to
   relocate symbols which were local in the original code, see
   Documentation/livepatch/module-elf-format.rst

   IMHO, this is why layout_symtab() computes space for all core
   symbols in livepatch modules and copies them in add_kallsyms().

   The symtab is normally released when the module is loaded.
   But livepatch modules make its own copy of the important
   parts, see copy_module_elf().

   IMHO, the sorting of function symbols vs other symbols does
   not matter here. I believe that the special relocation
   symbols are not affected by this.


2. Livepatches _rely on the sorting_ of symbols in the module.
   The special relocation symbols might define a symbol position,
   see

	.klp.sym.objname.symbol_name,sympos

   in the documentation. It defines the position of the symbol
   when there are more symbols of the same name, see
   klp_match_callback() in kernel/livepatch/core.c.

   I am afraid that _this patch might break_ this when it moves
   function symbols before non-funciton ones. I guess that
   the symbols of the same name will not longer be groupped.

Idea: Is the shufling really important for the performance, please?

   I would expect that binary search would have a good performance
   even without the shuffling. It puts aside half of the symbols in
   one cycle.


Note that the binary search in find_kallsyms_symbol() is perfectly
fine. The livepatch code explicitly iterates over all symbols using
module_kallsyms_on_each_symbol(), see klp_find_object_symbol().

Best Regards,
Petr
