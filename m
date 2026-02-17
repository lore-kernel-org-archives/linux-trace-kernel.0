Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267CE2C158D
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Feb 2026 23:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771369502; cv=none; b=u3xl6rCqiniGCDHTMymQ6GeW73b+QCL85tUd5RMYlCvfVKDjsajk3KcXc7WefnSpnADSNmjSuWIXad3UIx5O9Ic+4b772D4vPoCJQsRlYWDhkLI6w0xOYmbkE1Mu8tH0Dgzk+gz/XJZ2ri3XoJjrda610lmLg5MVHTxqj/X0U4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771369502; c=relaxed/simple;
	bh=Nb9uO6XAB2riMcSXkiGPR3StBCYmptBJJoYo8dSh3k4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ORmbOsapxtsn/sAznVrqOfeocUkktW6B6cKBIBp0N8Kwtgsb3qnaIXnS1FnLv0SD7ISy23yVVQ/cZ3R6iXHrpXRfa4yxn36dFXfZV9ugQaajwS77pvHc6D3FM1Ptxvcov6+aKaQksMj8YOvn+zx7bPvYcy3WTImycfyovxMUl/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FWiOH1KI; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FWiOH1KI"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35620e2faf0so3832331a91.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Feb 2026 15:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771369500; x=1771974300; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nb9uO6XAB2riMcSXkiGPR3StBCYmptBJJoYo8dSh3k4=;
        b=FWiOH1KIv/HDNKDK2kDyZ7eTMCtCghzcmD587SyjpT0XwzYQNMFW0uRyVQSo/E5Ohb
         EjnZfIkgMiOCqyl5rbFPcvyjMs0w/XKVDY/+9jFMhXlsYgcnxFoU/FmNzo810+EE/AuE
         9ppIJiGgLlDUDFRu/Yr1e4NiJ/cMfMPxnJiliHIf6ZeMCQcYdJrvWicOjS9rn2HsrLyz
         Dpcp+yoLV65pEptfykKB3/857KdYbMsVvaHvpvMZs5GOe1vHXyFzxEV2ynLXhQk89X9h
         PDW0V3Ha6PrnLflhd9dD0jJuOAvxAEuB6L7r6h+hyrFGp9JuA1FzslIKF8P73vL85sUX
         aJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771369500; x=1771974300;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nb9uO6XAB2riMcSXkiGPR3StBCYmptBJJoYo8dSh3k4=;
        b=nogCsrXvyfu0AWBRPSBr4XQnFsdVHHmltnqAiB7VyIP/JhvYfC89rVY1xtw5KOBE0g
         SZCq5vaS+wFkvGJ1FsL5+CNFrF/WKGqmRkTvPr/uhpTIIchTmzigANjwfrPZA3pfVb9S
         zKhFEVbRiciCzJ00MVp2WEfR2urVWEZqlQnMEGTk4yXINiqa38EQOk5ysJdIVTA9jFV2
         xfZbco5TDbisjbf9Qohz3dm0y/YY4xLJcA0oVI8Dij/tTiK1HFASlaPA3S82GOxjWYiM
         flAz8Ke1+ZrOTg8hX/qYWdpDDmFz8YcSOykiczNZbdAwETj3jYYPolrRAbxFQjpUKnzV
         J49g==
X-Forwarded-Encrypted: i=1; AJvYcCVG2zEFbDpl4lxpSKg3V1rPxYcXnQwlpsn0e91DjOuV3tyK5stxnGKawUZVpbc1KsjJ2eZJEaRfJb10U/b2xMbLNlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsQsc6LuLlJtkbeD/NSsebSvHtYYmoIJodhBHzG+IJkEjBlvFT
	bQ6EjkvlfSfq589WPU0/oCXT2UMg+u5kQD+phKou9zgnZTepjbcyhWEfGYT+GsHXAljzkcQqyAn
	VLVnnhw==
X-Received: from pjpt8.prod.google.com ([2002:a17:90a:a188:b0:34b:fe89:512c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2c90:b0:34a:b8e0:dd64
 with SMTP id 98e67ed59e1d1-356aaa9bb34mr11781376a91.1.1771369500107; Tue, 17
 Feb 2026 15:05:00 -0800 (PST)
Date: Tue, 17 Feb 2026 15:04:58 -0800
In-Reply-To: <CAEvNRgFMNywpDRr+WeNsVj=MnsbhZp9H3j0QRDo_eOP+kGCNJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1770071243.git.ackerleytng@google.com> <86ad28b767524e1e654b9c960e39ca8bfb24c114.1770071243.git.ackerleytng@google.com>
 <CAEvNRgFMNywpDRr+WeNsVj=MnsbhZp9H3j0QRDo_eOP+kGCNJw@mail.gmail.com>
Message-ID: <aZT0GmwJ-pm93ojg@google.com>
Subject: Re: [RFC PATCH v2 09/37] KVM: guest_memfd: Add support for KVM_SET_MEMORY_ATTRIBUTES2
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, aik@amd.com, 
	andrew.jones@linux.dev, binbin.wu@linux.intel.com, bp@alien8.de, 
	brauner@kernel.org, chao.p.peng@intel.com, chao.p.peng@linux.intel.com, 
	chenhuacai@kernel.org, corbet@lwn.net, dave.hansen@linux.intel.com, 
	david@kernel.org, hpa@zytor.com, ira.weiny@intel.com, jgg@nvidia.com, 
	jmattson@google.com, jroedel@suse.de, jthoughton@google.com, 
	maobibo@loongson.cn, mathieu.desnoyers@efficios.com, maz@kernel.org, 
	mhiramat@kernel.org, michael.roth@amd.com, mingo@redhat.com, 
	mlevitsk@redhat.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	pbonzini@redhat.com, prsampat@amd.com, qperret@google.com, 
	ricarkol@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, shivankg@amd.com, shuah@kernel.org, steven.price@arm.com, 
	tabba@google.com, tglx@linutronix.de, vannapurve@google.com, vbabka@suse.cz, 
	willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com
Content-Type: text/plain; charset="us-ascii"

On Sat, Feb 14, 2026, Ackerley Tng wrote:
> Sean is against deferring whether to preserve memory to the underlying
> hardware because that is letting (effectively) micro-architectural
> behavior to define KVM's ABI. KVM's uAPI cannot let behavior be
> undefined, or be based on vendor, and maybe even on firmware version.

Concretely, we'll end up with a giant mess if TDX and/or SNP adds support for
preserving contents on conversion.
