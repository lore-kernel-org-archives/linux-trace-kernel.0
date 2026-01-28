Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93F636F403
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Jan 2026 17:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769622650; cv=pass; b=bsq1zFowY9fYkvYo3ac8L9WKWLcqFMENjS/e1mu3smv1j4ZLVTL3/RePUDIXA9fIW0PbEQA3Y8KIzXCQnUBhwnnPlUlW3MQ8DdZduUMKvLBuCRTMGtunFQt7Tj1S5hWpiBi04XzaGE1H8TykKljNAlOq0OAu/3kfB49E2OfKQE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769622650; c=relaxed/simple;
	bh=CNqWkOyueD1v7WuaKUDdc+x4jRQ5s6ulmoL4RqUerEM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uDn5tv+6NurGcqU1EOqvYb7QTSZTlN7/3JrLOQIWsDYqF2tQEi9X1PYKUCEZIBv8bnO717L2SkkNqdX8RGqIE/lnWCaJ8y/NuwbKNbDIatkhAZ8cbTKh9dTNliBUmTYrN+REw/z7+VbM90K0Wfsil+tz/1UaJVjHSdg9pp+jB4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bHT6jDVr; arc=pass smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bHT6jDVr"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5f53505f012so107172137.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Jan 2026 09:50:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769622648; cv=none;
        d=google.com; s=arc-20240605;
        b=DboIVv5eecDSpIEI3+CvWE+X4xZWRQXnowRtZaXvySKGhw45ld4aBn4Rfk80lHlAH2
         Arb/JKf2I6TMwhWTlZ/ApfndxOlAVPcXafIrer5g8Ky6DNSqhbySAi6jaFF56zu0Fw7y
         uACJ6Uj18K74aHx2QmFWb4FfbTnV3c6KAdFuTYH1hJLDdnE7KO1wtEBGKe6gTakvkZW+
         mvWVpdiNCPyOtHzi+78dbUl7jCtqtZocUe4sdpnBXfSgGBksaiGcjxZkFjmybhIr1vmi
         Fghd+oLzCAi8c/n4E5qw6zJcpn3ILwo5jJ5Fx3K0ErUOx3E5mOuI07cQIAXgl5WaEX5+
         sHcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=CNqWkOyueD1v7WuaKUDdc+x4jRQ5s6ulmoL4RqUerEM=;
        fh=4FDdFQVcj1VhL5umQ6W8EDtxKxIv03DD+61gLpFR0ec=;
        b=EXTGzzF3nsH61bgRmRbSWm+t6QPssN4tQCYDw+HhKfry9timVCeIldg2VHrcKPbs6A
         CamuG35QF0sI0q3YwfRHk7oC40CWGRi/9jhpysqP0adStVHAGreKGenbpZZ9Q2lfEgek
         /4cxFP98j87PwNyXoYMnC0VlNz2Kq5FtF8H+GaNhcwtPGX8DHYEjH7MV8Fh290tqSITi
         XQhtB57sJ+jJDqhecB6XimNEy93dawPxlirtEH5VSdkMaWTsELpUduXXvqgwHxGhhPfm
         4ZgAZg+KeMxsIMe/D86wfyfi+Ac1tzvOZshuEVsf0KQKe/jgNyOqqduYxHNHntZF9i5j
         gMGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769622648; x=1770227448; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CNqWkOyueD1v7WuaKUDdc+x4jRQ5s6ulmoL4RqUerEM=;
        b=bHT6jDVrWJ3mgE3zOdEbPbOXVylCYhJBKidSCHid9ahabufnkQjUDopdWEfUqt8bcF
         lg0R+SYljdK33OM6QbmD4IhWOpcBNORKLrkG/r3rwpBjibP+7XSbTyhpPWf/Fn5tZoXG
         8iXgSC9hofYXikgaLaloBdRIqBSk7PoXv8JMfHLccDyPyNZL1MmlvTj9jVtKoXD1qDdr
         wGJ+WPgGFHT1cBh2DDqw7vc9Y6e98IyTzsVBo90UqQBLxExjeR3YeBxx4KvuntNjJPy/
         oooOPZS5Ffb5yQ3ok1gMnfZO5miSxDmK11nKDNg0N79NN8NPBkqtA39yLQ4KYC7ZycF7
         5tOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769622648; x=1770227448;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CNqWkOyueD1v7WuaKUDdc+x4jRQ5s6ulmoL4RqUerEM=;
        b=G/8o7Mk5keCA0fgeCW8bEqW2gjLRA2IfH9y4+rddKbCmR4YoVJcnNHiE0dfmKQgcTC
         D8WVQBpNT7EoknzZ8pf/AEppUR8YX1FxKC1WYs44ueCe9ybccEQBTxp/rqZAUVXBzlTY
         R6PrsRFies328smhO7QRa/329YmJGEQAzRzYcniY/d7TUQkB8ohaxLdq+OcNB0hV4MaY
         Wb0zEiAYeemnWBYwaKDK5kkvz8sEkS7y7Za0cu/SST2I5pjjqnkusFEEE6LesDYRIPmL
         AxLrIyCQ28urBCLy7sRHhaE5dpfjXhojJ+FnyxOcEQiwYqzs1RS58bb1MyOaDNpTc/QK
         Ywxw==
X-Forwarded-Encrypted: i=1; AJvYcCUe8QkYE0W2qnDUuGRmEmQ9riESJNLkX0wXn7BFhkm4YbOIhY+2v7o85KsLw1bJoCs95zxKFVz8UyXNudhOLmtfMNU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk1DA1ips5IkZagBa3itS5CTTTnBz+DcVJtkqCF6go4dm+gO2I
	K55JYw1/XhqSEaxQx90O1arJYb3P5ljRwnAUw+8orUAVthG+1AbHbaf2csAvomDiyddjJGB+dXd
	rSHOmCFwk7aGtxV7zVNWlrB7g1vRhqg9vxIOAI4th
X-Gm-Gg: AZuq6aIOrmbJjDEmZI84NN6UcqU1MDrm1z4YU012Zo4Shcwl7g5rg0tuWxFOOrz3kCn
	nGBkgIfrRIc2qcTiuHcIV0a6kCHZkaAUZm5IkLFbDm3eNCqSbmnpQcFZrSLSWEZfXpkD6IhxThi
	VhVKO4HRJStzchEHrpiBcn53dRFGGWZju18PCvsXqOIVKxrkFZObBlW2ntkYv4k/Rfan2GgkD0W
	GT8TBa5YxV07QA8YRMRiR65zW+fNii00nmQLq+PwOTAGm9onxB0IsFG8HsCISzYgOkeOEh78diz
	JNO6DJma8mGSm/U+nPqtP8BByg==
X-Received: by 2002:a05:6102:390c:b0:5db:e2c2:81a1 with SMTP id
 ada2fe7eead31-5f723765badmr2717805137.14.1769622647325; Wed, 28 Jan 2026
 09:50:47 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Jan 2026 09:50:46 -0800
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Jan 2026 09:50:46 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <aW3kOgKL7TjpW4AT@yzhao56-desk.sh.intel.com>
References: <cover.1760731772.git.ackerleytng@google.com> <638600e19c6e23959bad60cf61582f387dff6445.1760731772.git.ackerleytng@google.com>
 <aW3kOgKL7TjpW4AT@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 28 Jan 2026 09:50:46 -0800
X-Gm-Features: AZwV_QifG6FXcq-qNYCcE_MoQgt6DAo9uPq6fzN3xKHneI_AD0mm_Yxu6BjCe84
Message-ID: <CAEvNRgEjo5idG7OtMqHt+kCRCQnWjzWzQN7nwNGDExwmf4fyvA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 01/37] KVM: guest_memfd: Introduce per-gmem
 attributes, use to guard user mappings
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: cgroups@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, akpm@linux-foundation.org, 
	binbin.wu@linux.intel.com, bp@alien8.de, brauner@kernel.org, 
	chao.p.peng@intel.com, chenhuacai@kernel.org, corbet@lwn.net, 
	dave.hansen@intel.com, dave.hansen@linux.intel.com, david@redhat.com, 
	dmatlack@google.com, erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, 
	haibo1.xu@intel.com, hannes@cmpxchg.org, hch@infradead.org, hpa@zytor.com, 
	hughd@google.com, ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz, 
	james.morse@arm.com, jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, 
	jhubbard@nvidia.com, jroedel@suse.de, jthoughton@google.com, 
	jun.miao@intel.com, kai.huang@intel.com, keirf@google.com, 
	kent.overstreet@linux.dev, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, 
	maobibo@loongson.cn, mathieu.desnoyers@efficios.com, maz@kernel.org, 
	mhiramat@kernel.org, mhocko@kernel.org, mic@digikod.net, michael.roth@amd.com, 
	mingo@redhat.com, mlevitsk@redhat.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, peterx@redhat.com, 
	pgonda@google.com, prsampat@amd.com, pvorel@suse.cz, qperret@google.com, 
	richard.weiyang@gmail.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, roypat@amazon.co.uk, rppt@kernel.org, seanjc@google.com, 
	shakeel.butt@linux.dev, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	tglx@linutronix.de, thomas.lendacky@amd.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, wyihan@google.com, 
	xiaoyao.li@intel.com, yilun.xu@intel.com, yuzenghui@huawei.com, 
	zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

Yan Zhao <yan.y.zhao@intel.com> writes:

>
> [...snip...]
>
>
> So, it's possible for kvm_mem_is_private() to access invalid mtree data and hit
> the WARN_ON_ONCE() in kvm_gmem_get_attributes().
>
> I reported a similar error in [*].
>
> [*] https://lore.kernel.org/all/aIwD5kGbMibV7ksk@yzhao56-desk.sh.intel.com
>

Will add locking in the next revision. Thanks!
