Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757B333DEC2
	for <linux-trace-kernel@vger.kernel.org>; Sun,  2 Aug 2026 20:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785703474; cv=none; b=VTzEyvrbUSfcJzjiqclWuvBCOo1cjMgs0/oRiQcZcDpE5j8wagLaA2oEgxpKJNWug0grWuf3CaO2YC8aP0LGskTa1nxSLOt6DB2nPxHG62HkxUsQHRE4K1VYkZq1YSag/d22kUWLzIVXJI7a6/s9OIdUD0lEZ/WO2NoOGHxPWHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785703474; c=relaxed/simple;
	bh=XoF2yLF3AcvHIdTsY8+5xQfUf5rqYNg3g91Py3R48nM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=us0nNQXBO3NEcZhdc1gZJ7fDUXmRUnaXdl6McvdVGphA9PJGt5RNvtBvOMjWLnpyW6JPsB6uz5KH2NJyicrwsWUT4ANraCyfwlVl56wPTrpjEhRBMn0nP/e/57JnGEfCxBGGQXbf3aDzc4OzgBV2lDfSNPg8psmYVRaCTGJCCAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYQqho85; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYQqho85"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47c6e9a694bso1741498f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 02 Aug 2026 13:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785703471; x=1786308271; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J0Po6SXhfV2vXQAkV6y/NPCPoeX6dz+V1IoPOu929LY=;
        b=CYQqho85vIYW54C7T/LuNZF+XP6kEz6GqinVZd1K45OrdACOK4fgJjVPvVO9V/TLu+
         m5pzpiGV/TT81y2lwNF1tE1gvBLvRi8pfB/TeJtePmAma7/nUFgWzswVXoVH39GROu20
         hWLe5PVSruXssnNjOS0qPqI4Fy2+SG6Cqs4/FAHqpS+a5S7sPzEPvYmbNfaKczaNow5+
         m8UgU3VvNGlj5t2NRX0l+o7yaC2JLHk4Z2luVhn7c9PFQim8qf492rpDwas2Z76XPoFz
         HcrnR7n4R0YLzFJzxC0k8l3b4MbRPKpR2MS36dL5ADVdngCYazpAb+bDmVxFnl81Sebs
         cePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785703471; x=1786308271;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J0Po6SXhfV2vXQAkV6y/NPCPoeX6dz+V1IoPOu929LY=;
        b=PQCyJjIbf4AuCOdJs3RMzADN3grYpPbeeNSASmz8Ui94O46R+vYjCWxkMLfkgvPr0k
         tzfTU2znpaG7UBe3B2EDDu3XVA6vHJN/IWTJD+iMk75iAShtfmlAJNxuP1gUGV+NmYDH
         9HrygUWhDhFgJv2aWxp/oSaObyNUYoax2E9TNODfgBMBsIYr8j3KFbC5+jTCGSJ6KN0U
         IDdTMCHq9/y4lIlnop8mvPRxDlmfyR+oac+cedtIINzMOeA7sKDGhUtxBlFdD81G9dau
         ZCt3gLo3UjobFxviw1JoiPLuhILMzlKznqeHoaygaGpgSRpcIj1DtxWkWsEhgy+H95PQ
         9kSg==
X-Forwarded-Encrypted: i=1; AHgh+RrYJq1paMlpw7PrmLLeoQV1KSvnUi43mgLHZ+vhNb9Gr3yGeJXmOSP2G3rIl7Pec/gOIsmxBfBIfA0p2slrq2ykHsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI3R5HSy8wDACVs2CMNqGYkVTQEvbe0oIz6S4cmcSUDyk9NroR
	JU3oR5a6xDTODo7nQsYe7tvGmRgXUJOx0YRaNbEFCNwBTQgB5jq/Xmd5
X-Gm-Gg: AR+sD12FZs9XObm1bQnl9crHqJEinyTkAMdfV8M9ry32ha7c2fRrVGxKTwLqWcUAnSH
	vPfWe0NqBuD9aHrxmoaJIBkcP0D7wT6G8EYitC11/FDh9jZ6NDXQ1w7VEa1R3JHezrL/OtWdt4i
	no7kYN1BlXey9xvprHN8d/Wn0AtP4cn5ckfa/UufGk0HJt321GmTb06d7oI8Ynqm5vMyB3/oULA
	AKb8/KjS8GKEk8HyZbv9mzhHZRZ3UMjcCmGG0SAmcUiUNRMS/G7kqq7lzKGQ8tyVPfIPZofgrVO
	sAZ2DcLa5q5ASHb4DntxewdIFWCCSsk2FxWP4SjpbdyINkSYcSdZ2jo/w2IIJv6nKRyiVfH0vLi
	uLmEoat9/Z82WJ3AFgJqK0sPfP3ia0bd/xPKkULjBm0DMIf6cTo/zsu970I7YqGPfAXhyXrwjj9
	+SK1cHzERYtjwVEFVeIQCiiIKjvSxrNAgCT7vF6iAr1cy+zTxY
X-Received: by 2002:a05:600c:a4d:b0:493:e46e:157d with SMTP id 5b1f17b1804b1-4980c693eaemr164544645e9.19.1785703470644;
        Sun, 02 Aug 2026 13:44:30 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b8d04fsm218215135e9.3.2026.08.02.13.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 13:44:29 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 2 Aug 2026 22:44:27 +0200
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Jiri Olsa <olsajiri@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: ftrace: enable single ftrace_ops for direct
 calls
Message-ID: <am-sK_buCVI3khJv@krava>
References: <20260727142844.21212-1-leon.hwang@linux.dev>
 <20260727142844.21212-2-leon.hwang@linux.dev>
 <amnqXeC6D4mjcAe_@krava>
 <d745ca80-6516-4c61-8107-88c6a2d9cea4@linux.dev>
 <amsuU7eXuoziObdh@krava>
 <3f8e64b4-e60a-4eba-afb6-5af668ac1f85@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f8e64b4-e60a-4eba-afb6-5af668ac1f85@linux.dev>

On Fri, Jul 31, 2026 at 10:30:37AM +0800, Leon Hwang wrote:
> On 30/7/26 18:58, Jiri Olsa wrote:
> > On Thu, Jul 30, 2026 at 11:05:42AM +0800, Leon Hwang wrote:
> >> On 29/7/26 19:56, Jiri Olsa wrote:
> >>> On Mon, Jul 27, 2026 at 10:28:43PM +0800, Leon Hwang wrote:
> >>>> The BPF tracing multi link updates several direct-call sites through one
> >>>> ftrace_ops. Its implementation is therefore gated by
> >>>> HAVE_SINGLE_FTRACE_DIRECT_OPS in addition to
> >>>> DYNAMIC_FTRACE_WITH_DIRECT_CALLS.
> >>>>
> >>>> Select HAVE_SINGLE_FTRACE_DIRECT_OPS whenever arm64 enables dynamic ftrace
> >>>> direct calls. This enables BPF tracing multi links on arm64. Also
> >>>> generalize the unreachable-trampoline comment because the single-ops path
> >>>> does not use ops->direct_call.
> >>>
> >>> hi,
> >>> iirc arm needs ops->direct_call for trampolines to work properly,
> >>> that's the reason we enabled single ftrace_ops on x86 only:
> >>>
> >>>   424f6a361096 bpf,x86: Use single ftrace_ops for direct calls
> >>>
> >>> I don't understand the arm usage of op->direct_call, but it looks like
> >>> (codex thinks) that the fast path won't always work without op->direct_call
> >>> being set
> >>
> >>
> >> In theory, op->direct_call is the fallback for the case:
> >> HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS=y, out-of-range target, and non-BPF
> >> direct ops. This is what Codex thinks about.
> >>
> >> However, after searching the call sites of
> >> register_ftrace_direct()/__modify_ftrace_direct() in kernel, which would
> >> set ops->direct_call, the actual callers are in bpf/trampoline.c, which
> >> have been gated with HAVE_SINGLE_FTRACE_DIRECT_OPS. That said, for
> >> normal usage of HAVE_SINGLE_FTRACE_DIRECT_OPS=y, op->direct_call is unused.
> >>
> >> If someone uses register_ftrace_direct() or
> >> modify_ftrace_direct/_nolock() outside BPF in the future,
> >> op->direct_call will be used.
> > 
> > so any 2nd user on the same function triggers the slow path,
> > and that's fine, the single_ops handles slow path correctly
> > 
> > but IIUC the out-of-range target will now always go through slow path,
> > which in current code it doesn't, right?
> > 
> 
> Right.
> 
> Pls see the sibling thread with Ihor. With in-range BPF trampoline
> allocation, the slow-path regression should mostly disappear.
> 
> Let's continue the discussion in that thread.

please paste the link/subject for that thread

thanks,
jirka
