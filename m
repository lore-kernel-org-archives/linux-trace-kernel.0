Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE03314B6E
	for <linux-trace-kernel@vger.kernel.org>; Sun,  2 Aug 2026 20:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785703045; cv=none; b=r8jQYudFDPeylexgwXAivxqlvVi+juZ8Egzufy6hkREJU6jOMvfhBqbzlX6PAmi1IkHXzI3TrfCS/YxdYwRS/kfmaShTgIcj+beeGVuDEDNblGLZ5w128bXKH9WmX7MIbypvwYLLGDoIdWtAxjPXSvPWtUEEjgUJvNPJrMuEQzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785703045; c=relaxed/simple;
	bh=ldF+UbraNXlHSOqdvVdh4p7PoFDh0vzpVHMBItD1STk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brsQakdcsJVPLvFt1UQeeZjRLhutM5eBPUR0fOpYfvfsfMTKaKHcuMpMNTJaMBAnZ+pdik91P+KA5ZBQwn3Jr03pnu82+uQC7jrrikY528lJk/Sg/y3BmVxn+kv7gyJzbJB5QrTqYsOVkeAAleVL//yJvSPHf+3j/cR+jI6HAjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/gyV0up; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/gyV0up"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4953de5be0aso8815945e9.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 02 Aug 2026 13:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785703042; x=1786307842; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ynYXUbu+blqOm+Mc68ys84owwuXaWpVn9busZ0wxVA4=;
        b=V/gyV0upFucOgvTNrCnIDIlr8QFOH2TVc+GXZtAbKeg6A0Qex4a4lKuk7feRS8i3Om
         IUEQ6euqtPpKNPGbWe+RmHDSuXSU2lZI1BQRQNzj8hJ6gO9dIlJodoQ+anuRhdn8nLpF
         SOIHcKTCzfRxZv94XwWYR1Z/bjQ0dk6cRkn/Wz2EOF5rpUNDwBl+kWHuwrHOyGppYvTy
         CoBdGrX8mOeUIgXIm7yMl/jmAnsSJbBnaP8J30K5XNH4TzeHpqePsqHVJjbj17ecsl29
         6vd+s0T75Q0ejvTSW+lm6WUR2P8vrduiksrKd7ls/Rnb8sz7x+JyQ1oKCr0IBcyGAG3T
         RBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785703042; x=1786307842;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ynYXUbu+blqOm+Mc68ys84owwuXaWpVn9busZ0wxVA4=;
        b=mwCmBs3C6rFfAY8HpPhIZq9uLbxX9mOCXVY3fs+kY84BEVL01FRW+qMNGSiQycLmGR
         tS4iaNieZCPQIZWciF/2KzckC9brM4PMP5yDqATLHHkiEnpzsTz/p2MuRk2DEMgGtMGg
         970n/tzXlG2ANVjC+dsvCaRluQzcweHJs9LU6/Mj1H++0pEOJGbDI90CWg6gfIRXuNjx
         EImDDd4NDI6ZPNpd9CfiieH+OpgqGRU7QXI+BLSnd6dnTyANN/n/g4AF4RNDyCKqe48P
         2p5bG7WAcO21Shn5HAqGIyJS2XnGfhGkF1FCJg7l62AkIBt4mmMqexHALEkenYszwOGo
         fwSA==
X-Forwarded-Encrypted: i=1; AHgh+RqdfC9fcy++WFNC6LWcGGipwCOcLE2pA+AczCnughtMdBSkj4iiQsGwE/rUIhyJ3pjYJcfaEpvKJXll8A5p6VUc4l8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRlm4Jig4sOapJ5RYB2RvbWAV0A+FDX84Q+8PtZipKLpSnr4gM
	MHNqPbgR1Qn0rH76xhPWrrDRvscTdFer3ecPRJrOaQ4jwR5POMoa2yVg
X-Gm-Gg: AR+sD12PCoOGhqH5uBQjlTf30cjVmQ2LF1yzJEBIv1x5Rii3HPbVkncomkW4vil+6Rk
	Q/dDQmcFDQbMvZrr+W/DJYMTje5r6Bbt+HAJaSeG96tjJM4Lh9x3IfOQLuEywoMevnvtsUrNS2t
	8vL28+BO7KPpwbmzcyHNeQNP3dGBXib8pTkSR1GKSaTL+r5V6tD+aLUiktQ7lNMOj0wG3sk+O74
	F1L2w0HVc92nJdvcaEKePJq+xgkGw4PfL21Ktp/1x7fP+8j3rpyaSZD02UmnCe9dRoVA0ugPx9L
	RsctNsBIjkt2+r6+Rjm9dMDfCPcwvXaHlJml2oZ2vaYj7QF5D8INM2SfEPTtwb3RA+u2PPr9fTY
	iY67r0KyoEOvQmjJ2uFq4/qGt+5dX5WHkiz8uy1vrI64UNG3ODMvPvy+ZznEl/f3vEMXrhiqoCl
	v/+rvMPGBxoiHExbcl9Kg5bWv4XDMugPJ5GLCf90VeJ2cmslgD
X-Received: by 2002:a05:600d:8492:b0:496:c2fd:1731 with SMTP id 5b1f17b1804b1-4980c64b96dmr109881885e9.1.1785703042352;
        Sun, 02 Aug 2026 13:37:22 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b916e1sm138645485e9.9.2026.08.02.13.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 13:37:21 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 2 Aug 2026 22:37:20 +0200
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] ftrace: Protect RCU accesses to direct_functions
Message-ID: <am-qgJG8rB9Y5-W8@krava>
References: <20260730150411.88667-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730150411.88667-1-leon.hwang@linux.dev>

On Thu, Jul 30, 2026 at 11:04:07PM +0800, Leon Hwang wrote:
> Sashiko reported a potential issue of directly accessing
> direct_functions [1], which will be addressed by patch #1.
> 
> The patch #2 and #3 protect accesses to the RCU-managed direct_functions
> hash in its delete, and modify paths.
> 
> The final patch removes an unnecessary empty argument from a
> scoped_guard() invocation.
> 
> [1] https://lore.kernel.org/all/20260727145217.72B9C1F000E9@smtp.kernel.org/
> 
> Leon Hwang (4):
>   ftrace: Protect direct_functions in ftrace_find_rec_direct
>   ftrace: Protect direct_functions in update_ftrace_direct_del
>   ftrace: Protect direct_functions in update_ftrace_direct_mod
>   ftrace: Drop extra comma in trace_buffered_event_enable

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> 
>  kernel/trace/ftrace.c | 27 ++++++++++++++++++---------
>  kernel/trace/trace.c  |  2 +-
>  2 files changed, 19 insertions(+), 10 deletions(-)
> 
> -- 
> 2.55.0
> 
