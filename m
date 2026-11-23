Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795438017;
	b=k1vUclp4FJsiNXnsZ/elIoGRAj09aVwVTf1IB+qE5gMhMxqu0y2qlxNNtqgWm+lbutyS
	 m2yPsc8KS2EJVBm3nFHb02Krxxfl/HWYKmqTAuyhyw8n/GBVfr19kZOXcKM7CesLYtAyH
	 9UZBXUc7KKhDy/idH8haRGNjpgpLIUVuKx30yTvhaLm+zsRGq0KjN/H+n+p+QpDFh3btG
	 wpAS5V8UcOoQP0dALsiL42YbvsSBE/19xJs/JxAXFyyMiN50ybR2LIPz9yUAOOoR/ciDw
	 811mqTZJGVffwxDAoKrUOBPdpMdGOa550U1jIi/lERJqCTFQ+xlCnUDWxcILi7rHdaA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795438017;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=KDkZDqK4FJQoP/w58gPsz+MrboHrJj/4Mpu9CUS1Qq4=;
	b=3tulTbA0r/ALDo0Qv2lKV+YcPS0tJFMvWpgstI2pjI4HAQptIOIW1Uad1YDl/TLmUr0Q
	 SVeJTA50HPdo4HNRmAylcwJ4dJlqh+ZtIhfRcxQQgf6KQk8H2bmvLLTHAYzLdcpK9N5hx
	 UI5P+zllMZevg6oJ77bdxyhVdcVSfG2MJJbY78GAsyxule+STWG10+peP3l8+YQg/s3UG
	 Q/xD/elLTNb9unzzlxwOi1Ak/fGmVhk9w6w3h4780VGPoFFHxuMeWiijjUYVHOjq2OSu3
	 hPJJEzPPXv/hiPIbnG6skU35rIzXKBd5chwtxMzdcnfyreZltZwyha2IxvyPfdCewaQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sentinelone.com;
	spf=pass smtp.mailfrom=sentinelone.com;
	dkim=pass header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b=pXRgNTbM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F124606A31A
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Nov 2026 12:46:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F124606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b=pXRgNTbM
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3b48847e58bso111844a91.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Nov 2026 04:46:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795438017; cv=none;
        d=google.com; s=arc-20260327;
        b=cCzPBXEI7UT2UyMW9hb9l+1Xf6s5jr6qVu4c+DV2V1vXGBJU3yU6RKJJl+A2YHYfKk
         6E5c2k8IMuchTvhWWCbhrWMENpyX91wu8c4mXyp8YAoPml/keRvZmW+sEIim3rYUmK5i
         +iXEQryY0dQuaGBSxX84575lXousLvz4sKMDcMpG5ymz81EVVmcclKNHDvuwC3MCpgXh
         uxC/ownwme2cfJj7mx1WdjL2t1DqhVP+1rp9UiD4y23v0sRxLAamRhiNCXBnUnqZbOZy
         9v5kvj3S2wtf1oi181WGvRwDKhzXgkSSWXWptXz0Bg8hPfDNR7KpsKfQqYxAXjsLjrUs
         NpqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KDkZDqK4FJQoP/w58gPsz+MrboHrJj/4Mpu9CUS1Qq4=;
        fh=Kh+Y/6JJgJkxg9cosL+fApgUnADrSNSVdoOwdiJQoJ0=;
        b=oLfT4Autt0aKvaFl9HMG4xCFtqz8244OeIsksYIeZzenx3HoVCTj+hm4eY8h3vuLx8
         7u37PyUZQHVZVjNkV67uTXSiI2Hzq9APVGjlEXWqtV6ToKCqoMqNGViIJ/Kni2Y8auJ+
         /ZCqsH2wFOu73Wz1kehigbI2cbJ/RUzS1gplNg4qcdONXJoLkxGZa9ErVfyJbyES6uN6
         X3uD9Wihg52WeLXIFkJkTnshiIR8mAmy1161cd34XefijljOGY//PfNVIMrb5+M9GV2h
         lDjIhdLHgaHQPN+V1AxgavLrNUakxSTSwbhTna5abXTlEsGTjaM7MBUGDlyErVfziZXq
         Ea2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sentinelone.com; s=google; t=1795438017; x=1796042817; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KDkZDqK4FJQoP/w58gPsz+MrboHrJj/4Mpu9CUS1Qq4=;
        b=pXRgNTbMkIXjMzPbu17WG0l8GOiu3EuIwmuf+7ud7ElnfnYfbsWUT2RU3cBhoqc+Eo
         bPFK6qFLclLuIIC2qPTWHHWgmZZc+SbwdqrzmoLmuBtwv/Iht3ZwAUYgH+427EUwKdTK
         o6qvchedkYZ51RSKw1no5KmHPSRDyIGHlka7H0VBYETPlwEmN2WlLbtuLivJfxlYA2H7
         ++524aGwTcmBv1zCW/4QY0SP1fL+PHgNqCL/2z3yPH3TnhcgortPr/5cG6OXrsSFPfWD
         iuaobfvQheHH36CQ4jUyTfxB7iNoiwQdk0PKfN18G51O9AZh0f5egpBN3lq7KgqYcEzj
         BcHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795438017; x=1796042817;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KDkZDqK4FJQoP/w58gPsz+MrboHrJj/4Mpu9CUS1Qq4=;
        b=PclMh9LbJMBzFZTj7+LhEcJFPFjOuxulAPxAS0JadtigJG30xVa1DG3BgKXr+QdcTs
         QmHS6xwY3nsjBZuIw6TuFhkSulWL57C31hSha8/nSzwi//IFylvHw9GBUevALBp891dd
         A7ClvQk2gvL7Jn+TFbMNclhvDhLM/SxFA/1tjzp5RyJ3n8Jp+rlYkVfk+eW5YEr6NaON
         O4k6P7fKHRCnQ/YZIS6IvA5k+B66gpOXsoytdKhGQcVwui0dm+v0K2+RGkIVnoWQ79a2
         cb7nvM8QZUULL7zfYqSVvsZVghGpQDMzzzqQkxSvrN8F+E1bvs+5oyAUUi62hJZ/93p4
         y6tg==
X-Forwarded-Encrypted: i=1; AL+hErGeFC8ERbmpAY/sRIy6q+cBAn8XA8/VLPnmzBFiRqC/YINYz5OpclH4I+o4y41Q4E3vi+p2cpzyHcndAvOJbEUyQYY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+LZcNPXivz+Po0vBzpZZ0o890j7ZmowT6QdNkVQ3rRklWO+iAD
	EJwVgLGBwfL+CgoGenaKUlz8er278W+8vDc+Q7Zzogd4wRSmSawomn1I/4TXf4LhhwxvygnIFNd
	1rjzpDQx9jWTmqUOxzBLMK50JBN86hTpu9yUCg8Vexw==
X-Gm-Gg: AZFdTZdGGLC3mrrnPAAcQTha7lR/XjrAntzW6ITzzi8ientBwwgJfOdLD6alXoXmVFc
	3XJT3pvPv11qsf8uOGdedSIfJVuTZP0TaNpsgnFLqMZi6PFFKVe1lBftkoG/koRyIA0IkH4lUkU
	osdvw/ppcmmf1nmFskNkwQkoPPUmLs+3RkgKgCLXPdBFlOId/tCmNRckWhwrw3kzP0MXHgV0ulr
	iDM0eNIm3JZIFW9TBbTUy8xSwgrvDYXwkgU/vaM/kxT7qA2wBX40OcaTJBCDxCIH99w5MH0SnVY
	Iz1uTurL99lM9mav6Z9HcUKBoehgmXkBbUKksrSCtWWMyx9A5SJRcoS1pqH0MJGqwwvuOm9LaVT
	xhtea9kwu4Y1+DDpCXgrLgdR2FpdPd8YQE2EOo8mslUfMx0v4zwYeS8k0
X-Received: by 2002:a17:90a:e705:b0:3b0:9e2c:9b55 with SMTP id
 98e67ed59e1d1-3b41c803ae0mr16166809a91.2.1795438016707; Mon, 23 Nov 2026
 04:46:56 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117-bpf-preempt-v2-r2-v3-0-5687f2b53b57@sentinelone.com>
In-Reply-To: <20261117-bpf-preempt-v2-r2-v3-0-5687f2b53b57@sentinelone.com>
From: Mike Bazov <mikeba@sentinelone.com>
Date: Mon, 23 Nov 2026 14:46:59 +0200
X-Gm-Features: Aa3M54p4sO9o8A2kmO51dBuRGf5c0KYrhMd-49WQIyuTD5aiNinuGhI6siMAx_M
Message-ID: <CAPnbwjpJ6z9SQPGS-hOezBeE6fRjD_bo2aCFAnKT0N0en=WPaA@mail.gmail.com>
Subject: Re: [EXT.MSG] [PATCH bpf-next v3 0/4] bpf: Check recursion per task
 for preemptible programs
To: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	JP Kobryn <jp.kobryn@linux.dev>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

A friendly ping on this series.

One update: I measured the per-task array from the v2 review
against walking the chain. It is not faster. The numbers are in the
3/4 thread.

The question from the cover letter is still open:

> One question: the marking is automatic. A flag that the program's
> author sets would avoid the second trade-off, but existing programs
> would keep losing runs until they are rebuilt. Which do you prefer?

Either way the program marks can be reduced later. Each has one reason:

- Timed may_goto: its count and timestamp are per-CPU memory that
  every entry resets. Possibel solution would be to keep them per
  invocation, in the stack of the main prog.
- Per-CPU maps: a run keeps data in this CPU's slot until it ends.
  Turn preemption off from the first per-CPU access to the end of the
  run, as Alexei suggested on v2.
- Tail calls and freplace: the target may use a per-CPU map. With the
  access itself protected, they need no mark.

Thanks,
Mike
