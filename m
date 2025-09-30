Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295352BCF45
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Sep 2025 06:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759214975; cv=none; b=rwmbLkGsdEdvBlMVWTGm0fsWpDk0srjuQbHe/FT7S5Kt9hB6XSyIiFLfmR5PBCHvQpztf9/wg6sfG3xqSa/URinFYY9nByPHGYr2igaeT3JEBNFjmPQTrC96vfMtnpnbnfbZFon+GJTIev1HdRlYYXyVf7zqs/C7T0+6vsJKUow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759214975; c=relaxed/simple;
	bh=qtCxdLAk5RxSyoau0wBFHmkETSWtB4mi0PWwaVQ2zUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PGuq319H+YnjeIpR06JF1FAwV0/MN0cK2hi4RvIVlE6w1IQoY8GN4siTM4l5fxhKcLq0P5STIOCGzCCy1oTU4CaytuCUbFjFUc7oHRBPMt4D4YLBngX9J/q1qGPYxLjM4rfbrMFREkxRNVMgI69aF0nbi5UfOIYn9Oz5tHIa8hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cWPn/YHw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cWPn/YHw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759214973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mqRlzhy6X/OCGXbjhJnXJHWuco4CEjpdGpSoiDLw9OM=;
	b=cWPn/YHwPd2B4yFiIEeGg9p+l507dxYRKoRh8m9Z2afCMhlT5iLmjLKkI9zU0i6jBK3xO1
	jTsiwSFIT6MxARK9fGgAhMyOTK7UOlB4SIRVEsG+3jeF3mcYLOPXppHovCvOZu7Wr02J8j
	BvHYWel8OO4c7H3TaGe5RTRhY+hzZpk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-Psjkp9UEM6ebAJQb28_oWA-1; Tue, 30 Sep 2025 02:49:32 -0400
X-MC-Unique: Psjkp9UEM6ebAJQb28_oWA-1
X-Mimecast-MFC-AGG-ID: Psjkp9UEM6ebAJQb28_oWA_1759214971
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ed9557f976so3626700f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Sep 2025 23:49:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759214971; x=1759819771;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mqRlzhy6X/OCGXbjhJnXJHWuco4CEjpdGpSoiDLw9OM=;
        b=mdhumQIVQv+USMaZDdBrzAA0s6FiKZCbVPUouZBPZ30Qk6hsYTSlFH7Jbdb+0HNr18
         aOkGMB2L+xtm29tk9wUEzbzEJg4mUbqxRm1YawQXxJvBsY+verXMFpIzRiQu9PyolpZ+
         cQfX0E8vM2BCkbdGYZfDQTL4lJFB0yp1zOmLrgWLupEqT3JIfmoGH8axgHMqpPFnZE53
         zud/nIU8usHB7QcP07AKEmUkKeiWITC/6DTuqlj5W8JfvhPzN2XOVcDrgAoRSvrEwqRA
         BIns8W7iNB0vKG5Z1bxnRyCU7NL6Jz5Sy4yiupuxveZg7oDLKAHMwixnJX82BP+HjJ/g
         HHJA==
X-Forwarded-Encrypted: i=1; AJvYcCX3Cj2mR8klI2cM/YR5gfzPNOLsZV15Ij0twghAguDFXjMo7HW3xSeJKCQALbAfehI/DnNqT+AR5OVdiSkrJDl85to=@vger.kernel.org
X-Gm-Message-State: AOJu0YyltETghrlFBalUmjB56+vpvnocGYEBe2rGLBtQXOaXR3dTxUsW
	2kHkBjGJoEFX/LvWpU4FyyMc4kIjhtYjCoI5TT2DKuUn17HqnHYWzvwGpIQQccpZ+5f/RSe3vCe
	lLRVPwcgmzOjEDHKaRTY+3EotoSOhTTVKr0Z4J8vCn0yn8SkLI0LKX9hgcSXcPLCUzcvkmNNOFw
	==
X-Gm-Gg: ASbGncvop08lKab/uKWpF05elR3xqx2PzJ4UIdQTzaDCjURzENIQnieM+OnBmaLZ08J
	7m1DSV+soCRfdSxJQYFP4E0xDYxDpGSzJDAu7bY0Cd+s1x8fsc5g6Hayc/BwBK3OXrLuwgLsfFR
	rGj7Bmvisjz93Jbg9g5gCluY7OYs06m9i/pzN1osLIMN5S5hfQ83kThnurYgeGuTnDrfQmy1o4b
	EVpEandCG5+kML8lbToD+zL1iKfWu6SVGYZXKrtPQzHQdp9h47F8+2ta1/spgvyt5HflJCVWTXA
	M3Wse1Wi+6kXnDJJkGY7GYnUyF5rUmx3RirxpmiSQlblD/8ro9X5QpGDdQ+VofIFV7FR2EUdhsv
	sWahj/ZXU
X-Received: by 2002:a5d:5c84:0:b0:3ea:15cd:ac3b with SMTP id ffacd0b85a97d-40e480ca367mr13436900f8f.30.1759214970674;
        Mon, 29 Sep 2025 23:49:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjJ1kh+gHGKjhm8s7ngHlJgKibrCLfy9i3c10QH8wYWazuNRp/0yTM4Ql0YUWytAaTC1Wp7w==
X-Received: by 2002:a5d:5c84:0:b0:3ea:15cd:ac3b with SMTP id ffacd0b85a97d-40e480ca367mr13436821f8f.30.1759214970148;
        Mon, 29 Sep 2025 23:49:30 -0700 (PDT)
Received: from ?IPV6:2a01:599:901:4a65:f2e2:845:f3d2:404d? ([2a01:599:901:4a65:f2e2:845:f3d2:404d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e5b5e4922sm7544255e9.1.2025.09.29.23.49.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 23:49:29 -0700 (PDT)
Message-ID: <3ed8a6a5-9983-4b9e-bae1-4c433568de16@redhat.com>
Date: Tue, 30 Sep 2025 08:49:23 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 21/23] tools/ksw: add test script
To: Jinchao Wang <wangjinchao600@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Mike Rapoport <rppt@kernel.org>,
 Alexander Potapenko <glider@google.com>, Randy Dunlap
 <rdunlap@infradead.org>, Marco Elver <elver@google.com>,
 Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Kees Cook <kees@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Sami Tolvanen <samitolvanen@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Masahiro Yamada <masahiroy@kernel.org>, Rong Xu <xur@google.com>,
 Naveen N Rao <naveen@kernel.org>, David Kaplan <david.kaplan@amd.com>,
 Andrii Nakryiko <andrii@kernel.org>, Jinjie Ruan <ruanjinjie@huawei.com>,
 Nam Cao <namcao@linutronix.de>, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-mm@kvack.org, llvm@lists.linux.dev,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, kasan-dev@googlegroups.com,
 "David S. Miller" <davem@davemloft.net>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org
References: <20250930024402.1043776-1-wangjinchao600@gmail.com>
 <20250930024402.1043776-22-wangjinchao600@gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250930024402.1043776-22-wangjinchao600@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OP_J0CBSF-VKsZgJhynsedLovsidSTe60_Cb0SHTGak_1759214971
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.09.25 04:43, Jinchao Wang wrote:
> Provide a shell script to trigger test cases.
> 
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> ---

Do you think there could be a way to convert this into an automated 
selftests, living in tool/testing/selftests/TBD ?

-- 
Cheers

David / dhildenb

