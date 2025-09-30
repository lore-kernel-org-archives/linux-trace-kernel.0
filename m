Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33FD1A5B92
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Sep 2025 08:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759221226; cv=none; b=dhMfadMXZui/YFvK+jgQbCddapDTWf5X8yoTgcOPCpwKeJaRH8e2MjzocAPo58opCzkWP+VF0ox7Kx3qvOmOMF0gb9u78zmOcr53bUIyS5czSG0tr4fR7GqapoIR7MX7GJQDGZ23L/L+I9mlel5OYXDcT/V9erV4gmO8T6jgE7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759221226; c=relaxed/simple;
	bh=b84z4sLj6OipiU/LDADQxD4tH4RaTd5fv3amUZ6N038=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=H9NbOVlDp0DZESQH1uXchY05/CFip/b5aPQWgRPECExJJ7G1ffhnmvV9WUudpeXB+sXoByFHhIhI+CHUHFXqIZ823NGpxZReOcv9BMZb3HB8Hm/ArKs487/qgwaJWjfH17/TORxfiA90MVh9G1chzcDxUFBl0Vz4v628g1LzPa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jH0BfA7p; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jH0BfA7p"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6352a77add0so4844577d50.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Sep 2025 01:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759221223; x=1759826023; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bBOPU6N+QlAarzu9LlqnD6xE/6f1CWCmb96507SlQ5Q=;
        b=jH0BfA7pDo+pX7Z+tkcD8+wAy9cVudilMudXZukkQ2bgWYdPTHjDwiE0aFeVDWeXuy
         OsIfUnhzVXpL+wZUYsn6bTKdYAOJOrH5b/TP4fGJWmcL/URvY1RxlixYIKxAd0dz+JmJ
         V/svmB8CJAtAnFGFxcdoo9SEJLdW5eyTaPqP+yCEuweVPs+ZvXGrMJLDfYvj1WsqiT8P
         X6Vf1esS5qkzi7kgvV5OFGboqEyVQImNjLMIk1EojLiJl2DOjpvXo44WbXdgPL9d9I67
         REA9W9K2suAWQqA4wwMxhUM/JY+/h1M5SKMKB94tZ4FypM5+Xg895Jw0VqQicGHGNwDB
         fmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759221223; x=1759826023;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bBOPU6N+QlAarzu9LlqnD6xE/6f1CWCmb96507SlQ5Q=;
        b=X/Sx4lVux9ejyA6UHlE99ksATrmSLdJPWzQrM0ozwrwqoMPJQz9V4+gQVwr4Xb4SYe
         LWHlFN+QRDBkWPKJCgp8jorFAOP/GzALSckIFT5uIyDP3xIMLwwaiTonTust4qGFB9+V
         9iA/JjN3Ynieeaz7cv2Rz8btb0rpDK8XqzpWucJcmXENLB5LUErLu/0Fh55l4byDk+YU
         5oGH+0LlIoR3JgmqHXTbXFBDzDWW9F4KpB8c3sGtHxr3UnrP3uvObxLhztlILfSfDGHm
         BnGrBRnHXN7yvXCIZHowL+/9w1b+57suTW78WdlqTQQ4CpGMLgcPAhmcUehYkSWynowi
         eTHA==
X-Forwarded-Encrypted: i=1; AJvYcCUMrYnx1CFNnIUafcWxXPkwfZkGJp0A/C6q2UfGK9keR8yBiuDqQxzHrghESkeNJNsNhMZ/J0sOK2CEkGeyHAV6UMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxDUphmDj9XHCTZUcuttWgbPR9qv5R+XgW9DG/7IhY8wQGnMGA
	arKiH2aI8rMGB+eeWWDqZJT4zbtgu4zK7nodFuVkuEbeJrPDCtacrKZM
X-Gm-Gg: ASbGnctsG8jFeIp4u0ZhVd8KrJ1Lz/sw/Y5yIymS15ZehEoJoCinkh0xlMwR4xEsWIF
	qBK9rcs13lRdtBwAKTSPpTCA7sVx9zOvzusJN8b79ZS/LdZJxyGl7FFe/qAa1WyEQ5bWZZdLA7C
	zW/2MBbxjbbdKXHU0TNqsLlFDxAeq8GeyRvFS3wkn4o8lyW1l/YMU93KC4TWCQVwL0Q8fmgDN2X
	5pP/fkjiPb9kHkhxhsGg90259szta+gtryyzyJmA/FL5uoNc8O4g1bYIOTRcHJKVfDSkveQQz0f
	gVZDONBz1RfqWq0pygCZNTNjul4qg0Bi/UqyFMjhTOxIwSAiScPhrGfEHPox+F27dvFgykyLXcx
	fpuQk0NRU/dxSUbCnvU5PqF+dBWxMRb0JY0qMBUEa6HL4ol0kHGw0fP3EPwHpG+5lcQfg
X-Google-Smtp-Source: AGHT+IGdR0AHEeCd0GI8ArsMTXFyr2HmyKLRFM1XYpy12MOYMkBlzY/X5jDZtYeuuUkt/8DMB9hqmQ==
X-Received: by 2002:a53:d015:0:b0:635:4ecf:bdd1 with SMTP id 956f58d0204a3-6361a8d4824mr21581008d50.51.1759221222864;
        Tue, 30 Sep 2025 01:33:42 -0700 (PDT)
Received: from [127.0.0.1] ([45.142.167.196])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-636d5b1d875sm3280311d50.10.2025.09.30.01.33.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 01:33:42 -0700 (PDT)
Message-ID: <7530d25c-f4ef-40bc-9ac8-40de4abe3960@gmail.com>
Date: Tue, 30 Sep 2025 16:33:14 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 21/23] tools/ksw: add test script
To: David Hildenbrand <david@redhat.com>,
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
 <3ed8a6a5-9983-4b9e-bae1-4c433568de16@redhat.com>
Content-Language: en-CA
From: Jinchao Wang <wangjinchao600@gmail.com>
In-Reply-To: <3ed8a6a5-9983-4b9e-bae1-4c433568de16@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/25 14:49, David Hildenbrand wrote:
> On 30.09.25 04:43, Jinchao Wang wrote:
>> Provide a shell script to trigger test cases.
>>
>> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
>> ---
> 
> Do you think there could be a way to convert this into an automated 
> selftests, living in tool/testing/selftests/TBD ?
> 
kstackwatch_test includes 6 cases. Because KStackWatch is aimed at
debugging stack corruption, several of the cases intentionally trigger
kernel panic. kselftest is designed for tests that exit cleanly with a
status code, so these panic cases do not map well to it.

-- 
Jinchao
