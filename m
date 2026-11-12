Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794508422;
	b=BMPmyPdqtnqwbhrZY4Z4sjmG8GMZgkyYtMLbRu/aUUWlDaxKF4N5tIN93iRiWCwX/ecB
	 mhfXpNCslp1tGT2u5nb91uhlZUHM7qiuUWCDC/c3qYO4bvUwYNDpnnBLJJJhwpdS/+L7r
	 kUHJ5LCcg34GBInoKs0BigQrYF28SmvvVqfJC8g+i+tilnahaP3AkwF3DRcRJn5aLDDGB
	 IOBNQ1+trmpiicG934YZC33ccuOgpGXTHSQdnVt1rHg/m7+KfAiUD2i4IBfwWXaNg7CqP
	 x465HXrkVzWjBt3uxy/fe/YKFZTzWwMzGYdOW+pJgB6xDNtDoo86I8mR69eE0usktLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794508422;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=DNGGwn1SK0IengpfAdulGXi2EREsmRQVRNzPVdbrwBU=;
	b=YINpPeez1ldg7Bk+/ENmynVnpj4QJAp4fgpJl7O/hZsKY3WkWIOkuV7upVAaCkoWD3JL
	 GEm3cEmxECXHu5vtKu1trYeZpyHZ/uuhPbz2Rhqd3ire1lK7btL35eua4nWDm8OYz1Z1H
	 vlFQ7RAqxu5c+AvY8p5etMHj8wYYXEb2VBuY4PXx6ZofcH+GGyYPwIdUdmaTJX8K8FLQ/
	 pfB5TlC6OKubq+7jhdkyHsNCLfzxIG9VJANmAdMOTBpa3BC1fWVPAgQRsGsss/Rcc6SQZ
	 FqXpy04mg+qxfoCg8sNsKTBg4vtdccZmhDz3+d0Myh6yQ+AwuNAKLUSaEzMYqGK3qLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lf1JKZNb;
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3194060A2639
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 18:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3194060A2639
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lf1JKZNb
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c4d427836e9so6000866b.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 10:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794508421; x=1795113221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DNGGwn1SK0IengpfAdulGXi2EREsmRQVRNzPVdbrwBU=;
        b=Lf1JKZNbNbgUdMM2i2KIGIbtGN+MfqkwJ0BEbEAtwCtfxBUZOVH7reJ2S/aMnwpOHD
         t6ZIFrykOHl7gg2biAw87iqG5ymmiq5LRXRC/yiMl7ci6ZyYM07zEiDrNLUPVybHx+G8
         jR1P0st04yQMJU7CTIGAxQZYeJYA0Y8+IQjFUafrMgZ2Uz3+pXRVO78f3Nt1eSViDuCd
         7Fi8zK2myMJvHtIwPXUG1lDcf+s3BohEwCwYiqmKk9B4YxLHgBv0zcwvJWieh4xupz8R
         HxHCdtxbDr53eFZceqn4Qc4XXrpE9b7aTT8o3NfOxXwi1hyLhLcoBcoar/CocEGbaeMD
         I1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794508421; x=1795113221;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DNGGwn1SK0IengpfAdulGXi2EREsmRQVRNzPVdbrwBU=;
        b=w3Osdcmem83OUnIXiRu4ltQeUbS48YiEHR//JGc9PdCxusO/1JvwHVNznyjQmDhL/p
         O+MWrzz1FqKtku3pJKb7V958nv1IM9Bfd6RpTkKz8vQ80evg8IJ2ppdx1JmoJ4vNDzY+
         FcG0d+7G6b7/vuahBuV/YUl3hNFYGC8epLVSP491RlPkQLv1ywdHLGO5ITqKyz03sfQq
         vem883piq8gwvA1h1HlZvz3sSoErsst2i46l+67xxipZWaSlezq5gyRcTAGXqPP1/tzI
         XaQl/RTl1l6WjiIhQ5GU6QY41ZevYu4IsOBlhhld2+XqMS5e7xzmj42p0LKEN5RVYrMk
         6lwQ==
X-Forwarded-Encrypted: i=1; AL+hErFVzXKDX8yDGZA4QiE9jMa7I64eGnh9Ag7t/Ch1eBYvmVafx94AXePiiY9LT6FCpsP+Fnf1Ocr7qTn5i4Rf5zj1Bx0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/QaImSkQrcTPbW6zs8h03pSsp+yG9+8J8K5NhgllXR6aUqkuvE
	6QcXuk5OD4F/A0LCrCewj0qXqhmuNiyRd+2mNssaMTqx8QX12MT1M0lT
X-Gm-Gg: AYBFou0rhpebfRv/eWowpDp0M1tIOLMtJwovSrfnJhCWfsuNtVVFfCX+/M0HIt0Wj7O
	pKddq96+zAXKYNMM5vU0AU4dsMSLMSTk6S1VGepNT2Datun9Z85VcgkEMx4RhByn/jYqbXcTmi9
	Dnxn6hAVsRL92jCmA1Grlal28hYAvQwYLCSC50NOfq4X+S0BLnTMNx8CYXJ8N08H5H4JPbSLL/f
	9pTHw3XzUZJGgrK4zULsCb7lgTOkkgqS8XI5kXCco1dRykZGT294JkrpqlW7lTD9nVDfYGiIQhV
	i5ji2sg9xKEHprCMu5GSUylFEpRBDM/OAR6I++YSnnznaHAxQwHuEa5kKegOfD6UpzVkxDv6i+l
	UwoK2G1o+vKQQzj9IaqA3hkBWxxYJX7GbkI6CL1Sgo4+AEYqjUkrHOUOrYMOvUtreQvb+2iR98n
	Wm9UjY05q8WufIu7LznrdsnK2qooACQGM576UtF6pbF7Onyi9fAisLIY22a4UkwFaYbOMPZ/r10
	wiG2OTbdEHKQT7lKx9DfENHBb2Ay0zN7/w6gx/LJ61Gd6k09DUFB9dWyQIDWao2cf2YL4erlE5a
	J+gvonUPnQYOcnCd
X-Received: by 2002:a17:907:72c8:b0:c50:73bd:ed25 with SMTP id a640c23a62f3a-c50964287eemr9546666b.49.1794508420573;
        Thu, 12 Nov 2026 10:33:40 -0800 (PST)
Received: from krava ([173.38.220.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b40918sm6171366b.39.2026.11.12.10.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 10:33:39 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 12 Nov 2026 19:33:37 +0100
To: Peter Zijlstra <peterz@infradead.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>, Alice Ryhl <aliceryhl@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Alan Maguire <almagui@kernel.org>,
	x86@kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 02/13] jump_label: Index text reservation lookups
Message-ID: <avYGgU3bp5KEF0ql@krava>
References: <20261109194916.1089703-1-jolsa@kernel.org>
 <20261109194916.1089703-3-jolsa@kernel.org>
 <20261112083305.GD2668804@noisy.programming.kicks-ass.net>
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
In-Reply-To: <20261112083305.GD2668804@noisy.programming.kicks-ass.net>

On Thu, Nov 12, 2026 at 09:33:05AM +0100, Peter Zijlstra wrote:
> On Mon, Nov 09, 2026 at 08:49:05PM +0100, Jiri Olsa wrote:
> > Text reservation checks scan every jump entry. Build an index sorted by
> > code address for core entries and use binary search to find the starting
> > point near the requested range. Keep the original table sorted by
> > static-key address for updates.
> > 
> > Module reservation checks continue to use a linear scan, avoiding
> > per-module index allocation and teardown complexity.
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> This is the *exact* same code as the last patch; seriously? You
> couldn't share?

I think we could share the search for the lower bound,
but then the overlap check is different

perhaps if we keep the index generic we could share the
allocation and setup, I'll check

jirka
