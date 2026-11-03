Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793719119;
	b=hQnLWMrzPQH6dJxub/PbjFpfTRMt0OAI/ICkY+UWvJNFYZznFQImJBk19hEO/0XxIn4o
	 pqh+/E3sFgbHLHY0QrV+1Bsosubhb1Qg6TCtIE/OO01zh4HgUEyMnkioqdupWOsmEhNEa
	 M8bxwEDCC/LdgKrdj0V5oxz842QdemIg1mwABAQcS7kf3As6kT1WnPRveItBbOZczeTrj
	 pCz5JOhsYO2A1HM2aOZkIMY58pDqhel6th0Xpto0UEGMX7Ip/WpBsdSNg7flKymT4Klei
	 aoHeS/+hLtNuEUm8YK8KEj8lC0nyoZ7/L4Nk7ZdEMMkSWwBeOvYsu3jr5xy2co16iJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793719119;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=wslCY1XSUoR3v4P9N4tk1erDlQSR29c2WrcvV4W33z8=;
	b=nymvb07QnH85EH8q5eqvqjP9OCxMdpPbW+od5HYNcJlcbwAiYWDCgQ/2vhAmi1p+rzRH
	 o2k3xKEZuIuL7oq3DLSNo7+2qaS7LmqsBDg0IeQd9Ez4Ets+B1DKZH+d0CIeg5GhnUmuq
	 3rRK3RSRmahUfT8UaQVycoluw44wh4XW3nDYu8+scAgE96lZ83I91DbxgrX/J1xMRLwTV
	 f8UxvcIzScMqR/Lw/5+A9onUHTm5wuWtWCENa2w9lW7vM2jz3ym9xvBI+/fiZgo38Yt4a
	 da7RUyN6WWDZVn2VKOwerMkFodawSCo9O872G3iDVxQCAFFO4dDUZ9y/oiBs74lF02g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=NzH9v5uE;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CBF606FCE5
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Nov 2026 15:18:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33CBF606FCE5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=NzH9v5uE
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8a064dcfcfdso1544411b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 03 Nov 2026 07:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1793719118; x=1794323918; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=wslCY1XSUoR3v4P9N4tk1erDlQSR29c2WrcvV4W33z8=;
        b=NzH9v5uEH+MPtdumNErHcLU8TI7esovID+0FCTg4cq4Ny7OB6Jbv2iuLnSDCRB39Vh
         z1jm9WbnlKgC0FM/ImPLdCDbfHy1wPtGKCnh7nLr66I2ZWRMh6r61Gw1Myi8kqqxygS/
         MP+GB+led6l0lrR+WCQZnEEeUcd7JizQOJMcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793719118; x=1794323918;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wslCY1XSUoR3v4P9N4tk1erDlQSR29c2WrcvV4W33z8=;
        b=qs+iSuORpdn/fkH5XL7E/4QbEwed0TCnquAtY8w0BBi/exou5PLVVcuqOjA5V1mtyA
         aob1dDv/ycg9veMkv8D2vFdvO9Bs8g9KV85GlP2LviRhMNQNkPPcRt701ScdHeGwhiHk
         ZKuJJtQGrWcWMdF6sp4GhHQ1swDgeW+O2Q3nZ+2EID3bdEDbJE5zd5ja7x9+xXgw3rBr
         GWPt0haASj1eBhfY5O7CMZ0fnp0W8M3yAU5bT1X4gHwQGj6ql8U2Z+1RmukARFqfPwsa
         3BI19oKKHMtRdqMP8eP8dT7MKVsVG4RJBEoN3hS28+E9ydezW76IpO6Q5mDF7ZwgNBu+
         yDWg==
X-Forwarded-Encrypted: i=1; AKwUvBxGvXmBdd1M71HsKOSzA8y2I54kPfgYVZxRC+fu12zCGSLLPEYmL2s4+3852MpGQZjM0Lrb6tv5MGAvsYkPYq5sZ9k=@vger.kernel.org
X-Gm-Message-State: APuU4Z9SR26buh69YAjowctTXiQ7SIsWGW+C53OS3uba4zZ2yoWS7/a+
	wTrcCyYxq2xo6iLWXtEs1jmBNJSZaI0HoseVpQUjJEltQiyotavVi2iT0HAVqiiHqPk=
X-Gm-Gg: AYBFou1VsdMiBsnNzMaltWrEHNGbiz0m7ZPBERrF10HhOUcKzK9H6NuHvAJYNs1gwzU
	xDHsGIR+oGn2ZLywrIKyK1V/wInHHVH8zQ1pK7IJcT25dWl3FMI+jYgYIQnk11UXWL9RvxbHHA/
	IRtAIF8f3HC6XAmfGgffhl1H1xYnB8hJqjhKlaNxYDiashNhmNVFVHit7iB3onwHtMZvcMlPas+
	Co/4mU5uXfZn6F0JOY6c3aR1scbn/jaxNz0b4vOcG6NQva2qXk7lgo4i5cGxKw0eH3t3Rt6H5PU
	bfDo+g6fJWNy3sfJAw7rijnueocAkAUvVznyqxP3o+d4gRjbq/X4CiK6XWA2ryfuQgj8DNTfAJW
	l1nOZBWuhdAwSH3BY6jKFJm72ckkTznnHvp80y6NDAgWJIdA/d77wZvbsxplFiVxJ2rG2lv5VQH
	RdcFowanvp0LanrFJ6KQP3cq8J0KESenkVDfoNOxFbDfPnVkziRY1SSUZpeighd/7UTC4u6JTYq
	eR4pOCCvjRKnHb/6K4LWCIt//aFh0NeWnmGJvdcMdjV7uo/FBfU4zkhq/mwHTFCxXvxOKPJXIpy
	NE+jqPdiaSBLOQVxLOCVlXdus1GV6F1kuqH9U4usO77KQRUy3IqQrZoX/B+uCxeR6xuZcxP6vB+
	qJsu6Z/anA7fK/k/8ZpcoJEOXZuvgIP1beHz20zjPNnMvkSKtWi1aUoPpc5AmkRM2+7vhSVx0Ax
	C3wyQpleyQVvZZ4BGCTg==
X-Received: by 2002:a05:6a20:914a:b0:3dd:a009:3182 with SMTP id adf61e73a8af0-3e928e2909amr12529216637.42.1793719118513;
        Tue, 03 Nov 2026 07:18:38 -0800 (PST)
Received: from localhost ([116.86.153.182])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb362ab313sm1592131a12.0.2026.11.03.07.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 07:18:35 -0800 (PST)
Date: Tue, 3 Nov 2026 23:18:33 +0800
From: Chris Down <chris@chrisdown.name>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>
Cc: Jeff Xu <jeffxu@google.com>, David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>,
	Andrey Vagin <avagin@gmail.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Shuah Khan <shuah@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <jolsa@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [PATCH v2 5/8] uprobes/x86: Leave sealed trampolines in place on
 optimisation failure
Message-ID: <eafd3da2cd2c3e2c4d137a46f50351dc6290c5ea.1793718940.git.chris@chrisdown.name>
References: <cover.1793718940.git.chris@chrisdown.name>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793718940.git.chris@chrisdown.name>
User-Agent: Mutt/2.3.3 (9073d26d) (2026-06-12)

If swbp_optimize() fails, __arch_uprobe_optimize() unmaps the
trampoline it has just created. The next patch seals all special
mappings when CONFIG_MSEAL_SYSTEM_MAPPINGS is enabled, which includes
uprobe trampolines, and then this do_munmap() would fail with -EPERM
and warn a second time.

Nothing is really leaked if we leave the trampoline mapped in that
case, since get_uprobe_trampoline() reuses any existing trampoline
which is in reach of the probe. So let's just leave it in place when
it's sealed.

Signed-off-by: Chris Down <chris@chrisdown.name>
---
 arch/x86/kernel/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 0f60c0d076b6..fb895bfc09e0 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -1183,7 +1183,7 @@ static int __arch_uprobe_optimize(struct arch_uprobe *auprobe, struct mm_struct
 	if (IS_ERR(tramp))
 		return PTR_ERR(tramp);
 	ret = swbp_optimize(auprobe, vma, vaddr, tramp->vm_start);
-	if (WARN_ON_ONCE(ret) && new_mapping)
+	if (WARN_ON_ONCE(ret) && new_mapping && !vma_test(tramp, VMA_SEALED_BIT))
 		WARN_ON_ONCE(do_munmap(mm, tramp->vm_start, PAGE_SIZE, NULL));
 	return ret;
 }
-- 
2.54.0

