Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613D81FECC1
	for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Jan 2025 12:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737982237; cv=none; b=SBtnTfaIAi3L5UfkYP+ZtJXDNDZwm80o0dcIrptYL6kmG2qpUQldJR80ZveWH4W63n2zXhL6DLnP3PbZMXOOyO1b8M1pyawoY1UnO6cXz1TaP+PNkJj1rq2oh3ix7knxU9OIM3nA6CeoEB3RnwaEAKkfWz1aIYlWVjvDByYYxWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737982237; c=relaxed/simple;
	bh=HR4noXGU7w13ZIhOM/ucls8vVM3bhmVGGYLoZmvVDTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qRlrdzlfwfp68saqf764JNo2UDyfJSc/xZKKo+0s0QlmXMH0s73au5WmGW6J/mlIvNpD4KqxDLsszGNSjP6eMDVXyypen6BP6fvr7ZT3XU2co+Co1dJnOEGnD2bT2reEzWmBFw+YAG/sAGTdgDMNLgLte1ugxp9FPLqxv+D55co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PyQZLNMp; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PyQZLNMp"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43618283d48so30801635e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Jan 2025 04:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737982234; x=1738587034; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VG6M7E++/3Ce9GXj2tezC00IBdvh1kteyj5hzR0NwA8=;
        b=PyQZLNMpcVv/C7aBWa3i52KmbAcnYmUFq8gKJojCHwVh04N4W5Jf8S5K0rmEWApHqN
         X93gpvF1GQFkJ1DFtHAoBHJckiAP3RU9fie6Xbw0vXq7ylpjHiww6RoOzN89jXFRN32x
         Q+wQXO+1zwxrvukDu9Bpe0dMNdQwux3a+D9Z7MeiiQ/3C2bb2wSSvV6EJfsbBYFcj3Ng
         vm2o+LlIeCdP/lHC7e0qSOdAB7FLP/OdrT9oyujN4J2gy6UMr7LlRiG20LsWk3jw8mJa
         cgtGJGcT5IRkhwdT7jYeDvhrlJzGBedfWqUbeGG8pNOlegM2Y/dhITi/KOJhQS2RQczD
         RWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737982234; x=1738587034;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VG6M7E++/3Ce9GXj2tezC00IBdvh1kteyj5hzR0NwA8=;
        b=o8iDZbf2shZUGT3U6HBmXx70PyOwknvTqylKEqZ/kPq6IxoMQYK9hk1mpkg0Ft1l9F
         gubHwBMIZveuAW9f2u+PFp+ovEyrhUmgQfS+nhquE7iC8+E1EcOznsfwntgklJfrNdGa
         Rpy7EINzfjxxqWBvOSOTc1N6ETy5ixkxSXRINXooM1IybWVz5tmz7NDfIvtlQeF5MnHp
         exoCFdVuCcmo4kTi7/nsI7538pun0OpL25uFL+Vadk/6grbkvCIoHR+NbDO2SQfgo6TO
         WkOltG/ZMaJhC2auHBxqLhmE84BNzqtP61+tHffhhVjtcyCylrHreTVyYKYsWXFZFUQK
         NyTA==
X-Forwarded-Encrypted: i=1; AJvYcCUjLlnp+FNpLKe9W3BitbPJuKwBk2Plg7paAtlnyTYXbDgBTkzy0MxGx1JfA+r/WGxzGzz1IRQXJwRcVOjTpGol7Y4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXVQDU3CIr1pIbAKjWJ0rDLVxlv7CGTL49zqw14J3BgxoHK96g
	0zCGMbC6gmQTb2BZxe6knHdXCcrmGygU3yzB0N5tO+oy1CSFaw5dIj78ytiXbQo=
X-Gm-Gg: ASbGncvBpLp8Bc5VdD+hzXf7JZU9sSP7DnOEKeENaOXjG3wqfVrehJQOad/rDOsOwWk
	nK/ebeN4zy/SKy5Uidq3E0ISL03r/nZ0NRj0VEyzyRFj7FuO75NK7zVLiLQgJL5TOzri2z3qH7L
	M/ksyrZ6UKvOj1ZYGf5hwFr7MJk5mb/xpT0nzp66LpR6q5RP46jNOg/wDROQwVxDKRq+vBUij4M
	O5xj8nQxA0Ldb9RaHkU50Fv/KX+cczXZ3uHk9y8x5TMSQj87N78VHHJwfrN/B6QfIqhT+9r5/86
	Uzix1BqQ
X-Google-Smtp-Source: AGHT+IHGKx5XPAjKkuM8tLdY/iEmI+lFN9vw68MEGkVKzufCkr8AVUadSDTJkGDjd3qRPKQy8gyy+g==
X-Received: by 2002:a05:600c:46ca:b0:434:a367:2bd9 with SMTP id 5b1f17b1804b1-438913dfd7fmr435221995e9.14.1737982233635;
        Mon, 27 Jan 2025 04:50:33 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd54bfb0sm128676475e9.32.2025.01.27.04.50.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 04:50:33 -0800 (PST)
Message-ID: <021665c5-b017-415f-ad2b-0131dcc81068@suse.com>
Date: Mon, 27 Jan 2025 13:50:31 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/9] module: switch to execmem API for remapping as RW
 and restoring ROX
To: Mike Rapoport <rppt@kernel.org>
Cc: x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Borislav Petkov <bp@alien8.de>, Brendan Higgins <brendan.higgins@linux.dev>,
 Daniel Gomez <da.gomez@samsung.com>, Daniel Thompson <danielt@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, David Gow <davidgow@google.com>,
 Douglas Anderson <dianders@chromium.org>, Ingo Molnar <mingo@redhat.com>,
 Jason Wessel <jason.wessel@windriver.com>, Jiri Kosina <jikos@kernel.org>,
 Joe Lawrence <joe.lawrence@redhat.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Petr Mladek <pmladek@suse.com>, Rae Moar <rmoar@google.com>,
 Richard Weinberger <richard@nod.at>, Sami Tolvanen
 <samitolvanen@google.com>, Shuah Khan <shuah@kernel.org>,
 Song Liu <song@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Thomas Gleixner <tglx@linutronix.de>, kgdb-bugreport@lists.sourceforge.net,
 kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-um@lists.infradead.org, live-patching@vger.kernel.org
References: <20250126074733.1384926-1-rppt@kernel.org>
 <20250126074733.1384926-7-rppt@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250126074733.1384926-7-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/26/25 08:47, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Instead of using writable copy for module text sections, temporarily remap
> the memory allocated from execmem's ROX cache as writable and restore its
> ROX permissions after the module is formed.
> 
> This will allow removing nasty games with writable copy in alternatives
> patching on x86.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

[...]

> +static void module_memory_restore_rox(struct module *mod)
> +{
> +	for_class_mod_mem_type(type, text) {
> +		struct module_memory *mem = &mod->mem[type];
> +
> +		if (mem->is_rox)
> +			execmem_restore_rox(mem->base, mem->size);
> +	}
> +}
> +

Can the execmem_restore_rox() call here fail? I realize that there isn't
much that the module loader can do if that happens, but should it be
perhaps logged as a warning?

-- 
Thanks,
Petr
