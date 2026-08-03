Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F31F3AAF69
	for <linux-trace-kernel@vger.kernel.org>; Mon,  3 Aug 2026 19:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785786537; cv=none; b=IJ5KVOTw9nJ3Cia56XXUiDD9F9FNAntUF3mMA8lon1/5a+pPao78zf+Qwx6TgIlDc0dovCQZ8/tCq5kvxDWB5n0Vpz27Z81xNU1ksuLTDYMwjjqJv3pzkTSELLum75aOuqO8O9ZUsmp3kYwYHnQVsQ7p65qOgIHr9s58qKkO8/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785786537; c=relaxed/simple;
	bh=OoOCXYnmsHcXFceRPA+Lk0L4+MHLwRINzS1Fo7C+b3c=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oAnfLAFl9fZ6TLcq+0dINU4I6r5H2Pcyi+cvBjyVZwYCd8VzIi0RjGFnEAgceVvom8+/LQvjdXZ33raHaVF4y1KWlWORyoWwd4eAIZk2rUC5WzZJjmP1/Mo4V2TX1EZ80UbsxTT00LgmKV7m+NVHuC/bj7ThEONMIkbK/dof6iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Up2JHHuI; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Up2JHHuI"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4955158f26aso17137335e9.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 03 Aug 2026 12:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785786535; x=1786391335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bWuva+yS1TaIijzyC+2mlVwhJ1Wvxg7k7qqP6DARP2A=;
        b=Up2JHHuIaKtgPgA3fKs0PHPXLDKw+OUWzQrKZGmLbZ5SbP5jF7pSrG7LHe89hums7T
         Amy3weE6odeL+B8bzsyXX0JyNwgIfnuZbJlzrzJwxRP/iOoJj2uLRWB+IQQ5QP80NRkc
         2WTp1PaZHmeVeNF8up/a/6XiwOsda3RygS1Po9Q1xTcsdImmhvh0wxIxhVSlerUq+WQL
         QmBsWh/CNa9/jckJ+5fbQfxuuaUUwWvIGseTxRSdqgsCD4bTAddazF2Rrrxoh8iWo8Ye
         bI9A8ibJKBmknW02ybU0A50LykRhAH3iJFpRdkUGJCGzSynAunhtiXux7wGWAfTErRcH
         wJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785786535; x=1786391335;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bWuva+yS1TaIijzyC+2mlVwhJ1Wvxg7k7qqP6DARP2A=;
        b=ah22iNFXYMDuZKitQ/77c943r0UxdxnQVX0nRXIx2xaLPh9jNTMJm1hVHGHMWNHejX
         qdpgQYFvjJiy+fquj6HSBrIxtsxXXSc1TEjVW8SR9zzzjAhjkRHHAhSK727U6gBTrl0B
         bBV57Ghce6pw481n8YaU9cVGpJsYeWhFggZqszLFqORfKs3BxROhb4R5QevbV+gxnM99
         ecUGldfMQ2XCRQTrLujHBEWzz2D2/VVJMBPrTL+7Kc14Z4XNHv7Earnc7LLAkktvK6Zo
         Jgde35B6ClO0WsyAiMpIaaja8byeT07UhJkedlHEN3bWqZd3NOMXWYn1mtkeycF60Hnz
         bn/g==
X-Forwarded-Encrypted: i=1; AHgh+Ro0d8D/dIaUpk+nIik59m31moQ3ppHv8abOsJE3Mpf/K9m51m3OQytkOGfWXmEkExWHiNSTQ3kD/fFvNxTYy32EoQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVVJnAH5YCAChl94XjQW/8KyWD4M0gYbs/16PCSw2mUNTjt/LS
	A3B2hEiSxQbkXJtBR13Jj9uCgOwQn31kNVwkWWfE3aPusSEu2ykhJnNw
X-Gm-Gg: AR+sD104KZxbVisOA8a21MaGZg+n0PqghTu3NQYISwupAFqA72aFknRlKDgTRcFNniZ
	xbO08+wzrsA5arGdQH3lh4sFBAJg5l4+2fEIyL3E8njCxdCZs0rYVIyuIMeiII9CXg0a01AFIJN
	I7XNgdemW4M8ykA9+E5Fznqq5rhTxFo3G/feaQQ2Zt5j63/pw6X3tSUsTJiF5DuWU+qCPonShvg
	69MvgsGyNwpWUsVaeO9DDlL7h3bZ3LKQjruY3/K3B2Pm6iZnCs88IcYJSwGcRmGPNuL8J3ciXHy
	AsXKAUaeU5KAf8BkyP5xP6sWCMrDX695BL8tHNudC2UobNcKeXpbOI7j8pR4VHcoXQQEFRmS1Z2
	N+rTO4cqx7szLqklPNDjNJeIopcwTEWJpdjv/fLgbLz+2ajh87fnYDvwi0Me/oAd6kTdKpmGUwY
	tzC+B5HVS9NaOO6m+LAwLfXdeEFNkZvQOGuEavDsyKKBzvawO5
X-Received: by 2002:a05:600c:840f:b0:497:ff73:68d5 with SMTP id 5b1f17b1804b1-4980c6071c5mr221995145e9.0.1785786534376;
        Mon, 03 Aug 2026 12:48:54 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41cfde0sm33538389f8f.3.2026.08.03.12.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 12:48:53 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 3 Aug 2026 21:48:51 +0200
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
Message-ID: <anDwo-qXH6_W0_3n@krava>
References: <20260727142844.21212-1-leon.hwang@linux.dev>
 <20260727142844.21212-2-leon.hwang@linux.dev>
 <amnqXeC6D4mjcAe_@krava>
 <d745ca80-6516-4c61-8107-88c6a2d9cea4@linux.dev>
 <amsuU7eXuoziObdh@krava>
 <3f8e64b4-e60a-4eba-afb6-5af668ac1f85@linux.dev>
 <am-sK_buCVI3khJv@krava>
 <6af761df-9abc-4854-971d-ca6e4ed7a2b7@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6af761df-9abc-4854-971d-ca6e4ed7a2b7@linux.dev>

On Mon, Aug 03, 2026 at 09:32:14AM +0800, Leon Hwang wrote:
> On 3/8/26 04:44, Jiri Olsa wrote:
> > On Fri, Jul 31, 2026 at 10:30:37AM +0800, Leon Hwang wrote:
> >> On 30/7/26 18:58, Jiri Olsa wrote:
> 
> [...]
> 
> >>
> >> Right.
> >>
> >> Pls see the sibling thread with Ihor. With in-range BPF trampoline
> >> allocation, the slow-path regression should mostly disappear.
> >>
> >> Let's continue the discussion in that thread.
> > 
> > please paste the link/subject for that thread
> > 
> 
> The link is
> https://lore.kernel.org/all/77edc25d-a521-4f65-84ed-dbb016593902@linux.dev/.

ugh I see, somehow I did not receive Ihor's email.. :\

thanks,
jirka
