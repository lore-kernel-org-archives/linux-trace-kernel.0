Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2300330E0F8
	for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366171; cv=none; b=HEqYh0i119COSHWZybcIBQu4hSjROyJLXHgukhEZO/fw+HDiGvdfcdszf8Fnj3lnObrsIlAl5vv9ZGfkWcsXWhuw4XqSePL20XpQClG35hQlGICVmm2uDLmP9qjr7hEiJA9SqMFlB02m3BfbJM1f0RioOLsjYlFibPIzGRB+IN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366171; c=relaxed/simple;
	bh=x5cR/bWZX4q4NmLZideyvdFIjgN6iJuAET2ETwNeMGk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1y5uhXg4DFJxznjEAEJOt/SgkwZCFQfwlTbs/oyq9DVKfyKvAzi+csT/WmLVBk32/Q2WGQYCaXuGpXhnsfs7kKdyK5Z+GvcNP9+8hI6vo9NJ+7E+892y+pCzAr2lPYm+xSpcBK7Xy0ygkfyacZLsOXHLx6ZDo8SIVbQI86P648=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FwCcQnEN; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwCcQnEN"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b2e0513433bso163365566b.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760366168; x=1760970968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L8bp7JJD4tNO45pMRU9GuVCvWfU7WngDRput1R9LznU=;
        b=FwCcQnENF8wnyyhYNqZVDpyXcSDcU8niCWrlvWkNPePEieXpRYly3z0cWbSvyBIQzP
         1v8js7Ftd/gVKl0+/XODpF+5U5CrEvoIC6Ldxrd27DpHSjE4AFCBcimzeyFXEVGhmJM5
         87ZYh2AN8Yx9bpxbzzJIlS1hCNsU39QPsSjffV81q/66xbgho/PPqrJgwB81mcRD3m0F
         fY/1MdZllluAc3J83SJxzICrwd/i61Q9on63hIshSh9dAohYJX3rJQfuFf3nOSkRSH/F
         uyqK9+ZmTK80MUV8sar+L3hna97j/s/+JeqDFntYWcV0rHfeUzEqzo9dvtviByg+mqKS
         iaig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760366168; x=1760970968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8bp7JJD4tNO45pMRU9GuVCvWfU7WngDRput1R9LznU=;
        b=GkTnNrywpYEkbLfD+soowZKmEFCF84ANLlkfShX3QvR9RH30zyI0qKN9Vibh8S7zt+
         /NdPp+yAG4iK8KVPXug4oCH9lqLvK5sVgcJwHs61zAIOMH0c1j0Jl/iaIOHLm3nUdFOX
         tD7VHcZWKxhsvXPpmQteUQ4knoHSGEHS7xhnorKgj9fHeh7AAGv5836ppUr+HN1xHSJN
         d4vGPQ6s4jtG7XYc87cuOnCjkqF+Jtt2In8ezP8Kf8Fx2pDvudI2WitbDTIaF4vjHkGX
         PgUJPUOxja5v6vjCtLvhrn1l1YpH7VRtbtgO0wJWImFCZtpcWVJq8KakM+LmdbL6hQUh
         UCVw==
X-Forwarded-Encrypted: i=1; AJvYcCUJAZdxJqfuSgJUy80OjHESI86jaj3Wsxr9pE216Iqysp2nV6+9x1XQNwc9cBhndF7YHSUxdk9IbmSx0rrXjZ2S2eY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0NvMz8Q0CWEHvgPT123GXHt4t8NxTvcu9cOAgCSJ7L4Ioqu6m
	KrAGxkdlk5QTxWpCsSGbVpU1Ml7+vIlsUgms4eYwq/1IygdUzdFbDC7V
X-Gm-Gg: ASbGnctj5dADy8bB54IboctxKz15CwzYqXm/YkFVkTXXpk9u66ihQRNZSJ0MyTp+Epp
	U4+E70ToqUaSzobYH71Ewq81X8es67FH+nTXmn+KHXDuvEudjrKAohTANL4fiW0mdXRI4JekvPA
	qlc5N1HJThVH9P5d7Yxdu3bn80qxVp+XXDbsGltBLam+sxlZKf0qXojynSMEmPOPJdXuTntr4e3
	GG5v+UT+9CYELr0Yvpfc67rwv4RPLlaAvogAGpZX48aNhdI02BZU4DKtQ0+IFb7o+KDmUFgCAyG
	mWYuwPfPlyXrv2h/BrXUyzwNlfZyZ8bviJlQCeP+d1efmEeZ8yd1Z3QLhrafMk5Uh/lggA2Jlyr
	MhdF+/0LSJZNCJaWh+MPNqFWw84qFHRVRgqSBTSkl
X-Google-Smtp-Source: AGHT+IHkgr8MUe7DN7d82dgADvSgzkYPwDabRlFEQQq/C/tyKiLifrmlOII1t+fib5ZHhhZ6qnmJhw==
X-Received: by 2002:a17:906:ef04:b0:b3c:8b25:ab74 with SMTP id a640c23a62f3a-b50aa393c32mr2417040266b.10.1760366168174;
        Mon, 13 Oct 2025 07:36:08 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d5cad8adsm955648966b.7.2025.10.13.07.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:36:07 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 13 Oct 2025 16:36:06 +0200
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	Yonghong Song <yhs@fb.com>
Subject: Re: [BUG] no ORC stacktrace from kretprobe.multi bpf program
Message-ID: <aO0OVlfH-wVQvy0c@krava>
References: <aObSyt3qOnS_BMcy@krava>
 <20251012130931.f2ffee08b23b6c1b17dc7af5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251012130931.f2ffee08b23b6c1b17dc7af5@kernel.org>

On Sun, Oct 12, 2025 at 01:09:31PM +0900, Masami Hiramatsu wrote:
> On Wed, 8 Oct 2025 23:08:26 +0200
> Jiri Olsa <olsajiri@gmail.com> wrote:
> 
> > hi,
> > I'm getting no stacktrace from bpf program attached on kretprobe.multi probe
> > (which means on top of return fprobe) on x86.
> > 
> > I think we need some kind of treatment we do for rethook, AFAICS the ORC unwind
> > stops on return_to_handler, because the stack and the function itself are not
> > adjusted for unwind_recover_ret_addr call
> > 
> > If it's any help I pushed the bpf/selftest for that in here:
> >   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/log/?h=stacktrace_test
> > 
> > just execute:
> >   # test_progs -t stacktrace_map/kretprobe_multi
> 
> Hmm, curious. as far as we are using fgraph, stacktrace should work.
> May this happen if function-graph tracer is enabled too?

that tests is just simple kretprobe so there should be no function-graph
tracer in the way.. I plan to check on this again later this week

jirka
