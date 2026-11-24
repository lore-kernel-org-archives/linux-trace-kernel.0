Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795491498;
	b=X/TqPf1tT+j0nLuKggYTAQGlI0OmWMbMCVE624g8RoDOlDgPG0BrMfCEKUUJYoMJS4uA
	 Ozc30yfUMgIsuaNj7CmjuyCWACnUw+o1wAzYFoUXq6J2L6KosqtMPszz74BTlSz4xo91p
	 8BWIy24umWe/ez81cHhtHy5JGdQSyNzhQ9Y+3vWyU+rWYd32ZYOD5W+4j5zRv2lM8r17D
	 wGCEJRbSbDHuXgxz+/mnBBDkO+kRinsPv3KoZrZwnxTXl48P+MdmFhMRUxVJRlZ6C0YwA
	 T5FKiNUaqZnIdzNa7+GGp4lI9IuCoBPWKJZWVCZRyXqxZfSC5EiYWJEp/Qx45+OAGXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795491498;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=23WFpbkk9+U88u4Kg5/nJhlO5TeXk427D7xW5ikMlQs=;
	b=psZaz0CWzjQC7Y+FOiXfJo3OP/z1z4Xc5Gh3GVmXL8u5zf9dCVQDz4DO+7ZFR9r8rpfg
	 9c/mmcPOuXuNXxj6T5UChnlG8cP6WjPOZMwiFZvEC/kLRF/kfZFhSWsQGW/6M3Ush3VVv
	 99HVqfmj1JZ6RbX46id9lobVI5b3raPoSescMLZp1+LIvNRlbKUzgIdt/lnnFtd5PcbVW
	 OqasYsrtL7GsQv4BwdM6x9s1TzeEfDRx+bvL8IGXu/iDp3/bXBImCgv7EXTz53fnTbnFt
	 4/w67s9gwklmIhr+cVYQEm7v+JMToT/8hO0oquX+ZwXLI0U+82HgERY4jNL/kaHycrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ku5aLrvP;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1980606A31E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 03:38:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1980606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ku5aLrvP
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3b49a6e8212so934533a91.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Nov 2026 19:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795491497; x=1796096297; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=23WFpbkk9+U88u4Kg5/nJhlO5TeXk427D7xW5ikMlQs=;
        b=Ku5aLrvP9phrP9bXjiBFMawcdxtMoArwVagFmynW5E4mJSWbBEnhdZXn54Kiard5Mu
         VNZQZgUUtN30jCOBppPq56jGX2vK520+FokqWXFIy8/8RySf6ftZ33UNQfuSfIQ3BfFJ
         TYh+RoASYZq5APEodgI5gH3sv1Mv0gic9KQ8GMSDjuUJQEcv+JNRWtx7FP6R+ZOJ96sG
         QB/5rwMVBpxLLexg4oczTrH/Bj7YuM4sPO2Hxf5fdNA6ftkwFwF85ACievajeGcMABbf
         7jgRs2QnGWZGot/++6ChC+6CZ6iidKQjqhQUeFzzi9+2Yu/3PZ1Sjhc54CDyFu1SP/SA
         yq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795491497; x=1796096297;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=23WFpbkk9+U88u4Kg5/nJhlO5TeXk427D7xW5ikMlQs=;
        b=OvpiK+YRBGdzcr4iFGCP0w1fvG1WOwiyz9JXbu/DfqYR2wuKdhrSC0WUwFYWBU3ODL
         qAQW8bRdS3JFKmGH3Jc0fVj9JKHD6M42scMLzb9V5VEikDIwBNaVBxDl2rMjB6y4i453
         D+dGEjJqNoR9sKEMNfWDoeeTfslFCZvzNgr20lc7H4sko5d/sbuJdDF62hY6+GPwhs9w
         g6Mabxvhw24yfYxPYryOhoNlv+i97jaDVpdA7w6lMXDWCo0eT6ejkldmTCvorrpXvK6i
         RHtsDMMuEB9KobWz6rE0biacA5VykViPii0iPBbDL7/ocA3EXUcqzaiq3X91n04HUmbQ
         XQ5g==
X-Forwarded-Encrypted: i=1; AL+hErGp8vUvUGBdL/hx4Eb5Ax0KlEaKE7EwlVKVGd50bi6XVU1XV7F6EU2GqmS4aP6tpg/jabkG9Pu9MV9nWscj4lFvyWo=@vger.kernel.org
X-Gm-Message-State: APuU4Z82Yu6MQq7f7GiYSaLjbpF/Dc4iInJ+lEINisUOPx3JLt7Q1Qvx
	us47/4J7Nwzu5jrfjlGKFBYW0KkN0OfrM9jKWhMdBFQCxhucJCl1p1Um
X-Gm-Gg: AZFdTZdTjs+FSHs4HGNtwAMB5+9HEcMGl8oWDcjnavQVGHlWLu8UmkrVyEIJblHfSE7
	fe9YYI/ACjf+veXk1NCkd3A76nl701++JZ1KpgSuiOe83RaUWYU6EHLVmF8Jy+QjS/xtZlBhBl6
	jx3lfK7UcaM+5s2A3qhU7WjFLL+z7oIvhgCA91IBwz3EgAWAj41HyBzLnKDK5CiLHCAiW3wl2e0
	tD2pEQ73swSyN7PYDb0+L0/HOkewzDAQGfhE36G8O4bzevjLkm6Fg5BAwcKwQgx770HG+P2wRyx
	q5I/9MsYgR6Vh0LSoOGvVWZQLRv4bL/V6XYELeUnERm8B/au4bZGqMLxddF8g/RuRT7BEntKozg
	2QzQ8PakZV3NInd0E34F78d/UvXA4m5ZGj5wkLnI1GQ/1IJxH+cYSlhh0HGVbbetwSEHOib+OcC
	Y0xmxQ4xnVE5CVZKamzfGiTsHHHyxR9rwwBnq9hxinlKnwCj2zQOp6b9O8X/8/QosOFkiMZx+d2
	uYQMSVtZ+RssMAwhQTWKAGRYjkazwFm0wHfcIWN7DgykK8k6ji2zjrdVzef7uEoPQuU8OMR/2vd
	h0/xZMP1nTuKX/wMhDvklHJegeTPzP4I3VpH4IezLST3rTDooH+4q4eM8BfbJuMW9xOA0TkQav3
	LlH83iNtwUCtWS0TQS816x/eyAQsoTziLCCw=
X-Received: by 2002:a17:90b:442d:b0:3b3:fc9e:561f with SMTP id 98e67ed59e1d1-3b41c852ce6mr13016956a91.8.1795491497124;
        Mon, 23 Nov 2026 19:38:17 -0800 (PST)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b48b41928esm10165247a91.9.2026.11.23.19.38.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 19:38:16 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 03:38:16 +0000
Message-Id: <DN34M6EHQVZC.3ON9G7JB6VVGQ@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <song@kernel.org>, <jolsa@kernel.org>,
 <rostedt@goodmis.org>, <mhiramat@kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf: reject override_return programs on
 uprobe_multi links
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Sechang Lim" <rhkrqnwk98@gmail.com>, <bpf@vger.kernel.org>
In-Reply-To: <20261119164152.3678373-1-rhkrqnwk98@gmail.com>
References: <20261119164152.3678373-1-rhkrqnwk98@gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Thu, Nov 19, 2026 at 08:41 AM Sechang Lim <rhkrqnwk98@gmail.com> wrote:
> bpf_override_return() changes pt_regs->ip to the kernel's
> just_return_func for kprobe error injection. Perf uprobes reject
> programs using this helper, but uprobe_multi links accept them even
> though their pt_regs belong to a user task. When the probe runs, the
> task returns to user mode with a kernel address as its instruction
> pointer, faults, and exposes that address in its signal frame.

That's not a bug. The prog needs CAP_BPF + CAP_PERFMON.

pw-bot: cr
