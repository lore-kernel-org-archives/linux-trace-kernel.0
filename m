Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0299C342CB2
	for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Jun 2026 13:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782394760; cv=none; b=tmP3eIx+8/r3HBj/Ee0HQjtv0VaODP+59wETLVKsj5GZt4FPvH3tEV9VTYYhkT4zXCp1YVAfv9w6KWCsdRX6qet8VUpKb8Xc7kULrjGw8jpCUYOmKzvdvP4sreq4DsXEU8V4XW4/JOud0z/zsKfkdRLekcjn5/VoDECiDbGF0DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782394760; c=relaxed/simple;
	bh=+kdBpGeCCh3VUHhZsZ/4EJAxob800T1QKFGk864OpTQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1WahNxP4ITF+91mpnVve3b4a5FAGjJnJQ4fXNKUKX5OXAEOFZ1FCfwpHZxKkWOSmqwHbmpsou5ViTxxjtaARRDa2Kn7pM5U6U5CaBY+cfTFRpbPxMIohrrFidcu1EYK2gyeur9dH265n6lDw89ufhGYHS+jt04zCFA+UR4625s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fzucqzwi; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fzucqzwi"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490b9318997so13105765e9.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Jun 2026 06:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782394757; x=1782999557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f4pR9K1dxaeISN5nLk9a9H7V77qeKeERtll7p7KH46E=;
        b=FzucqzwivK8xmREkSS/Z/KLx4t7ifE8Tob6iXKXyzgvOnJThNRrxV1ajtiD6mwZO1O
         Av672lmi+JIOZrwsCFWPlIALcvzzM69WH+Hlhr2P0X7kmZNWdLfzxTcpGzQD/j63ykGX
         v3WcdVF8eRfvEAq+tNUxm3iUhw6zaaqFfXKdn/sUH5XdrmWBPHidvIJg6OGGWcyOv/QH
         ac9bU4BVmEb6qVOkJkNas1Trzy+D+Rd8XQGr12rqZgJNcLHzVqpx0GZy8A3pbRWaDvAf
         cYsHpFz/Gg5xr8bJl0Lo9ejJ3qpnngKUPBU9zAve0Ia/xVNSLR4s5o5doDxrtgStpJ1I
         1yGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782394757; x=1782999557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f4pR9K1dxaeISN5nLk9a9H7V77qeKeERtll7p7KH46E=;
        b=lC9zFN0rz8yzmDhGQbA8gV7a8JI8mg3onMOdNwQRWM77Xy5ALESZd18K/9haxI6oDR
         odUehV8DgT3UGsmpAeApV+zVq+MPi/Ge+Qh0Gs9wJoWvcTJc+IjiSrcZk7HnzvZe7+JC
         EDcwBIisKu8XDlEmHJU22PJQ9OGsAxfD6LxlTUSwd1Ot5AElrpUcqcT7CKNa02m9Otd3
         JC+1T8fQoONAdDdQYJTD/52cCrtQFc7ZmhSSPiByddyRa6uwzWldhafaq5vsOQ0tV1h/
         bM5pA+So1GgdHIT0mxXFm/LBjn3piOTWJ9frXDy8D1uioU8LavI62gagMAte0QE0qNcd
         ZxoA==
X-Forwarded-Encrypted: i=1; AFNElJ/4uuu/HlJPLI1HwgyNwG3XO+YxvGE0cEp+sV8xbLt98t6WyDEW+L7xPyrEb9zFsBo9c6zD0icZpFwSb1LDGCVNiuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVBIHw0vvcPaLbO5/JUa6MXGn28rEvJiKKAYQGS4c3NFe5gcX5
	bczUGsqK/+/+DELweCs7yzjz/FD1WL2nHloOMaDDfCG5U1alpIVSoar8
X-Gm-Gg: AfdE7cmJzgOJjF9QfA7+mp49tBo/lKG32zuYC/aIaBG1voSGsOhuOk8M3d/7nGFPFnN
	jb8s6Jgh006M1rS8Ti+rW7rPLARhbtdpsT0OjCx+vmOICqh834fRpgTIP1m6kiOM0LmeidyljR/
	2MjAYvmh81pq0gif0ivL20y0bQt9+xq5432f7XitgwW/ozIZATiUXLW1/PiV86lJzQUKPt8IUNE
	n6Dx4R52T+V+lIs2v4XWgoIYqGEmN1Wc5kzGeZMwiN6R/HDMvG+4/P3Tko44nGZ3zTad4xuNtC0
	cZ1CHlXlQk+kAQs0HurKvjYek2UfserJ2K0nj3t9V3vBM9wTIwOXVPFwaW1GWFPhqsc8ALrP7ye
	9zICqbb9hm/OzVvu9agqThLMd6nyb5nq8vN5nC8KpgGk/nSFiMTWgrXRX213KuIp9NUn8QQ68Nc
	XhNYmc
X-Received: by 2002:a05:600c:a403:b0:492:4e1c:120 with SMTP id 5b1f17b1804b1-4926689988fmr31107965e9.32.1782394757186;
        Thu, 25 Jun 2026 06:39:17 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492660addddsm63819605e9.6.2026.06.25.06.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 06:39:16 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 25 Jun 2026 15:39:14 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv4 04/13] uprobes/x86: Unmap trampoline vma object in case
 it's unused
Message-ID: <aj0vgiPpnmwrfL3H@krava>
References: <20260526205840.173790-1-jolsa@kernel.org>
 <20260526205840.173790-5-jolsa@kernel.org>
 <ajv5lxWjNHBAUa9r@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajv5lxWjNHBAUa9r@redhat.com>

On Wed, Jun 24, 2026 at 05:36:55PM +0200, Oleg Nesterov wrote:
> On 05/26, Jiri Olsa wrote:
> >
> > In case the optimization fails, we leak new-ly created trampoline
> > vma mapping (in case we just created it), let's unmap it.
> >
> > Fixes: ba2bfc97b462 ("uprobes/x86: Add support to optimize uprobes")
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> 
> 
> but I am a bit confused... It seems that this change doesn't depend on
> the previous 03/13 which removed VM_DONTCOPY ? So I think this patch
> could come as 3/13 after "Remove struct uprobe_trampoline object".

ok, will move it

> 
> And the subject looks misleading to me. A tramp vma may become "unused"
> if (say) we remove some optimized breakpoint, afaics it will be never
> unmapped. Perhaps it should say something like "don't leak on failure".
> 
> But this all is really minor, please ignore.

np, will change

thanks,
jirka

