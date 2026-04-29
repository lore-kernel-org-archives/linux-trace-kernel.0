Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CF836C580
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Apr 2026 15:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777475194; cv=none; b=AgymRjMzrOTLNtTI7zF2w7jJhzoUrgLCe2sQzfXiwMU78wrFwKzVgi+T/vfUEaCMmgKeA3gAJCV4gXqJV2F/1Qg7hiAguZmdX0zF0t8hcRmhHp5p2nUN6cfdq6ahYsebRvfRsT0uOaylQcPfBzHI5dec4L5kc6yj2ejduVnLTz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777475194; c=relaxed/simple;
	bh=GFPg5URtggyFPwX/baYrE/ie3WRq/hgfVjdW68qBQaY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aV5WBV45IkEIIRi+9QLZdxikQU5o/lX8Iu8rYGt3MPPmYRz+ZBLnFr3jxmDk/1dELrofF6GNYfE1ej7Gs+2vEHo05xIJ6iDctq5qKNhSSK2nG3pk72VYFf5wPLSRt12q7UL22AeOi/01bji0fTduIFJPFIY47tG+zQmEISKI38Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=shhJcXpc; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="shhJcXpc"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35d9f68d00fso16663940a91.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Apr 2026 08:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777475192; x=1778079992; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xWWhH3tU6Hs8N8nztl0MRExY7a1xORY3xqlQgty50GI=;
        b=shhJcXpcNN9M5iqmV3StYS51K9e0dRy/Nm5YNPFZ+dqmqMZtxi3vmwDZtuyuIHaneW
         3JBt2G2ti1KwI9jdexvdRnMFF3O/OK0Tv6c4XqAg+ytabLHWoksEzfkofqDN5A6qpTpm
         zwQRHyKaWLRMqXrcCFzvKd62/vEnX6M72/AFY6MIUwdnHFmCinETyu0oF05IFfZfkm9+
         UvnNfy4EHA12iOUS9V6ausHVcnXdomWx24NGV86z0k3BM/hkhEqHxU8pglVyFBlcdj+j
         Ndzz00U/sIZJiPtU+G8CPOEJC13op5osrZ8V5ZrYcBEQ+7nq/sP4wS1JTF86r5wcpo26
         mwvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777475192; x=1778079992;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xWWhH3tU6Hs8N8nztl0MRExY7a1xORY3xqlQgty50GI=;
        b=IK6/IesB3cSHMW3B//IKnRo+fkTETixsOHgs41m3hDJTQeqbM4/F9I/DkUwerPWiaC
         ey1KRc19e4eVmdy4O5X7frSxIOAdQ6+Qbfrcd2YYlVupdgjqPxMsbJkstIJ2RgzSROpN
         Ik9eDQTVrB1F5RI4V8WQ+/uNTLWdWmcJXmoQA3arjaSkhg0u++QxiNVS41b9FZEIsCFZ
         UfTUHvDlaonBUu4Zwaq8DBl9LnonXZ1oW9DbOzn94wPf/QmZWGjIYgBSBNg4tQPuohyP
         sq+fMyWg+wWMkXWiMnDItiTTsbgFbTw9UV4RVR6+3FwMXprkQ62IyDa3cxcoVKxWKHwW
         B4fA==
X-Forwarded-Encrypted: i=1; AFNElJ963/dAaszxexqCE5Y556CxVAbS0g2oqoqlmQBmuySOJTScoN8VIpuK71Fo5aj3jzMS8KAc9YJsmVISZc/TS91BIUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoGNDnULX8VvNnGGyhSf1gL6vAtOq5syuidZhJV8gtW7RLOwot
	cjroMge8FtJq/3T+K/tUf1CiWSoDRK8QUxl212t9kJp7dzV6vic0yB+r7OTDJrqTdi3xIXl6osB
	8nsQDEw==
X-Received: from pgac22.prod.google.com ([2002:a05:6a02:2956:b0:c74:42:899a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:e081:b0:39b:862e:634d
 with SMTP id adf61e73a8af0-3a3af6802cfmr4445875637.39.1777475191266; Wed, 29
 Apr 2026 08:06:31 -0700 (PDT)
Date: Wed, 29 Apr 2026 08:06:30 -0700
In-Reply-To: <20260428-gmem-inplace-conversion-v5-0-d8608ccfca22@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428-gmem-inplace-conversion-v5-0-d8608ccfca22@google.com>
Message-ID: <afIedjYxPBrit2dX@google.com>
Subject: Re: [PATCH RFC v5 00/53] guest_memfd: In-place conversion support
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 28, 2026, Ackerley Tng wrote:
> This is RFC v5 of guest_memfd in-place conversion support.

...

> TODOs
> 
> + Perhaps further clarify PRESERVE flag: [8]
> + Resolve issue where guest_memfd_conversions_test, which uses the
>   kselftest framework, doesn't perform teardown on assertion
>   failure. Please see proposal at [9]
> + Test with TDX selftests. We're in the process of rebasing TDX selftests
>   on this series and will post updates when that's tested.

Why exactly is this still RFC?  The TODOs here don't strike me as things that
would make this RFC.  Blockers for merge, yes/maybe/probably, but at a glance,
it feels like we've moved beyond RFC for the code itself.
