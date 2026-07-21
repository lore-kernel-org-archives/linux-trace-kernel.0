Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104591EDA0F
	for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Jul 2026 12:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784637375; cv=none; b=pa05+r8jGlXcAbANVMO+aCMReEamh0crjrglhbqht5fFqzr/FLEIdx2RrfXVvy1/vb/06c62DhaKpwR+CDhz2016vBSrvA712IV2q3Wv4/0TBWlPVN4XERDWoLtdBVUs5Q0qbhVUBz36ya943uEOXYNrv5cUFMkEkBnMeEa5GFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784637375; c=relaxed/simple;
	bh=jDLW790EM1fyBuBh9mKBqaQkQC6X+ZdRp9/0gz4O5YU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HUpQsDrDBsIEQkE9HCbvgblC0bJfJ1Ub10LzPW9EQq/xD8FWkVc0DIWC31SHdKv/Eyl/q1QKUrTEFiYM7BK8g+Yadnm0VyTIoW+oGoD9bA/rBODvM3Dd6NsQikuEXzsMNnyBDf6nAMzjMnZ7MC5du1C6NC1/pds1lsvNTDcK07Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddjrkhSN; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddjrkhSN"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7eb29ed2bbdso3467674a34.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Jul 2026 05:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784637373; x=1785242173; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fXKZ+mCy8htaHCjZ0GyevgxuuwSsosaOIhPAQIQtoX4=;
        b=ddjrkhSNfoardY4ZWr5nM8ZHpjbZbbDmZrKyBMmVrjQa1RGu2ZkqWbucM8/50Ap5Wr
         b4pyWIv+Do40N23o+xaRSmyvTjNgEVQO12J6Eq5b6HFuaGwqhgrmGLhZ/c+M6+tnWrdB
         SffMcbxiBMWlZxGMTsZYHmGPLJWhHrcmw7rjymKVuhkcRgMOiwsxHCDe/+rbxD6wTXHF
         rCJfSgWgdv2lT98yaUvzzDJkBR5sNS6obcoiSYaKE1sIy3RCXmcbciZG/rjCXmaz6Lbm
         eHPKBtev0VihQbjDXJ3zCMRwk9NTyXVlpMwgMJlWhIYRmiQo+FUAMb3al7g8vNROBxYb
         4/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784637373; x=1785242173;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fXKZ+mCy8htaHCjZ0GyevgxuuwSsosaOIhPAQIQtoX4=;
        b=hTA/UPldJ7WGvUSU0M98r3bV1UXvYcK9Dw7pAcIMgGYXpFvJkwDBnoEEorFEDH3Irl
         Epk9WBqns0DrOu1OYICcZz5Waurgp37gx52tw/nmOIqjMNtstoiv2V6eGQCbqz0EX7VT
         0I+JrMUCgw9aIRX0qTW56xCGYWoostMdpy9LUS0APqtp3hKcCtjDBvSiZtrQRrhUTisi
         nfWn+xRsbasTFCUnP4haXilWrl/Y1MLK58MSJ9Ff5RGt/GcKWN2RPBoMGK1nrjmX7ebR
         x9ID87Dnnr2qKKOOioLnFLVDUfPItHK10jPt/haw6UV5ZH71YjzSi9A4HiJfQzCMpi0J
         nhLA==
X-Forwarded-Encrypted: i=1; AHgh+RoK1gO79jUaLt/NI4fD2RnpkuW16cqDKQA2pxipRwatO4uxSpKuH0we21VzLSNMOt3txzvRx33LyXzAhsV8/+ji46Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJWK+f4eWWqwyMR9PZsYq474jM0FQjr9OSRFWCRmn68A3yrVha
	4b86eIaVLSWRY31G0EpDEVnFrobjKFjNQ7yxa7GkAom80TvX3+gnniPf
X-Gm-Gg: AfdE7cm8fmr01l1Iqrirn8pl7+U6twUrlkuk6/vRGFqam1vBcY1yR/XYYjSrVJH3Zrh
	C2iqm5LybfMcRelHH924Q7dGt1eF6xW1iks2qBuwsYcrgjb0pz+7QF/Yw9yFCFkSeO2SP1avvMP
	zCvMF/i/UAyh1O8vgAEQxodBcg3swZy0AjKTNjYJuF6iF6i57jy52lAlPGeIJv+rZsXoEklDyLD
	YxkMAKrUfhWva5k4sbOP1pQHVm3e1QclCUd2nesTOgbmfDx+S43QoGEDKsun5vw+AX9qTDZ05Q1
	iwVx8JvUJcuve8v5uvx/C2kZjcjtgXYeuWsFSx5gv1/BcrTcx9mJbjzTvoLTT4K8NS30tSJvTij
	aejf5I8bqvDwZYE2PPICjn+1658w9c9+VKEypuIUsSTqQlR8lj7kccCOYqJ/qRnNVbyY7OBaIM4
	l3+STVUg==
X-Received: by 2002:a05:6830:82e3:b0:7e9:b946:e1bb with SMTP id 46e09a7af769-7eda153266amr9848253a34.23.1784637372781;
        Tue, 21 Jul 2026 05:36:12 -0700 (PDT)
Received: from [198.18.0.1] ([144.24.58.22])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7edaf94a494sm10332132a34.13.2026.07.21.05.36.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 05:36:12 -0700 (PDT)
Message-ID: <0565e7d4-fb0f-4b84-a20c-0c73ac964b51@gmail.com>
Date: Tue, 21 Jul 2026 08:36:01 -0400
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 00/13] mm/kwatch: dynamic hardware watchpoints for
 hunting memory corruption
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
 <hpa@zytor.com>, x86@kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 David Hildenbrand <david@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Matthew Wilcox <willy@infradead.org>, Alan Stern
 <stern@rowland.harvard.edu>, Randy Dunlap <rdunlap@infradead.org>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260717125023.1895892-1-wangjinchao600@gmail.com>
 <91f3486b-3b85-4b43-b099-0a5325643352@intel.com>
 <20260717181004.GBalpv_MOaAflgFxgh@fat_crate.local>
 <20260720232442.3e6b0e70c6939541b8362e05@kernel.org>
Content-Language: en-US
From: Jinchao Wang <wangjinchao600@gmail.com>
In-Reply-To: <20260720232442.3e6b0e70c6939541b8362e05@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/20/2026 10:24 AM, Masami Hiramatsu (Google) wrote:
> On Fri, 17 Jul 2026 11:10:04 -0700
> Borislav Petkov <bp@alien8.de> wrote:

>> Looks to me like folks need to sit down and agree on strategy first.
> 
> Yeah, I need to talk with Jinchao.
> 
> Like kprobe, wprobe itself integrates watchpoint functionality into
> the tracing subsystem. Jinchao, I would like to ask you to redesign
> the kwatch tool based on fprobe and wprobe events in user space?
> I think that could reduce redundant efforts on the similar feature.
> 
> Using fprobe entry and exit event trigger, we can make a Function-
> scoped watch window. Also, since fprobe and wprobe are having BTF
> typecast support, you can access to the members of data structures
> more naturally.
> 
> If you are interested, I would be open to having you handle the
> development of the necessary features for wprobe.
> 
> Thank you,
> 
Thank you, Boris and Masami.

Boris is right that we should agree on the overall strategy before
moving either series forward, especially since they share the low-level
HWBP work. Masami is also right that fprobe and wprobe provide a more
appropriate foundation than introducing KWatch as another standalone
debugging tool.

After reconsidering the design, I will stop the standalone KWatch
series. Instead, I would like to work with Masami on extending wprobe
to support the function-scoped dynamic-watchpoint use cases that
motivated KWatch.

Masami, thank you for being open to having me develop the necessary
wprobe features. I am interested in taking that direction.
---
Thanks,
Jinchao
