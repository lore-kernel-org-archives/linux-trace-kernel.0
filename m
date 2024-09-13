Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C410514EC6E
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Sep 2024 19:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726254702; cv=none; b=kUQpSGyOLs6b9KU+TnQmxDidqN40sfU4DHPc2suJOET8U3TuoMxjeGV6JFdTgXrKzlk06s9q0QJiC5U1gp5K3L+HN4b+BBD+AABoH31cWXsrzVcR2CT1Rv+Y9K1o3cvnZ3o+S7V2FjBGCunbc4almVlmTCs4/g23Vr6lDHkUJeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726254702; c=relaxed/simple;
	bh=df/OdVQzmZ9IIzivyT0nVwAaqNoCrQVBqFQJsmOtcdo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cQnsCmTmj9+6nHErXOoXFlAy5p6CjMQVHC8+Ub0SzbSCPbn+7CduxguGHuaW2qbvfiSN6wCUMCqzLHApI1X+yJV8+BblK5TJpHgaeBTaCPJROFH5vRFXHw46i8bQsgu9VyamiuBGKoBEWSTLaM0kYTad5t0xPqn0c6dRYado7ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wroRNBrX; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wroRNBrX"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e165fc5d94fso4290765276.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Sep 2024 12:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726254700; x=1726859500; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=df/OdVQzmZ9IIzivyT0nVwAaqNoCrQVBqFQJsmOtcdo=;
        b=wroRNBrXifviZNzryntxniZPn+arxL0Nh4JCbHM6SqVsnPfMvchzAZ17PLO6xruIfR
         U9tl6oIAONK7yKRTz4Yufr4XW74eNNVuoMKP7wYgyOgvSEDMoShIlNGM0yjF/w4HHGCw
         BK1PYUd2/5DL4gzJ8NW1Dn3TtLMq7rXyNSKD3o3AE1U85mk661wLL6tYANSrRbvgWpH6
         uTt0ZBJBFBL0oWqayKB4Fi3h2V9atHVfw15s/zesi8mtX+h0u3LtacD4Ow2svhk+fAma
         fsDnYrRAdEwLB2U5IxpW5GRrN1Z4MhgBbpISNQ3V66RVMM+2QtKkRpOBG8A/ZUTtkOEA
         JmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726254700; x=1726859500;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=df/OdVQzmZ9IIzivyT0nVwAaqNoCrQVBqFQJsmOtcdo=;
        b=Mv2rTLNrpkJ/kxUy736CSgN23u24OcAe3uOFp99hIoaEzX3hd6n1jKBcUdruipawxG
         MLH8ZAJJTVh63me9SsN8teWdh5reJ44MjbfeUx4SG1Gu5jaJ/MbRX+DOY8JbK62pcjP2
         F4hztPHQtb6zGpG+zCRPp/M8e9CWWR8ZmAH0doa+uplIowbvTYC2oiN64GGIHQcOQ1r6
         XRJcd+upJ3CINjOG9nJb7hE2LIRwCb2CvMFev+FmfReJRMXruHE1Nazfz9uRe5jHSr+T
         FOjwoGhbhRsKaRPP8juMeUvBoHX70ouGAZEXj18UXyl+UshWc20hldsboi4LW5kG2ruQ
         KROg==
X-Forwarded-Encrypted: i=1; AJvYcCXFBxRSS3vbdO1FaFClAZb0o7PtprXz0gE7PhHaCkE+Zw1qKpO8NYYVc6/IcHUoDHA+eELVJufLBsuQmGnHIOFclR4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0u/maWwE6+bkX+J46PrVXc5hkGL7pH3fnyiqcxb5edfncjafk
	3dmqpwF3UjKrBUOQ3c8EH3T1wfrRS7ryGB7FKw6qgfgLU4aDi7xRbdQJ12dy/oHxJvKE4FGLEvm
	omw==
X-Google-Smtp-Source: AGHT+IHWKdvpTgRToeIjzP7LiLbwdIQd0DfavHeMBa0nhxmMEncC0lsKplD9gP28OszQ1s0UsOTgeX3hi0E=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:86c9:0:b0:e11:5a3c:26c7 with SMTP id
 3f1490d57ef6-e1d9dc4275fmr12810276.9.1726254699289; Fri, 13 Sep 2024 12:11:39
 -0700 (PDT)
Date: Fri, 13 Sep 2024 12:11:37 -0700
In-Reply-To: <20240609154945.55332-12-nsaenz@amazon.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240609154945.55332-1-nsaenz@amazon.com> <20240609154945.55332-12-nsaenz@amazon.com>
Message-ID: <ZuSOaTw1vgwquqTE@google.com>
Subject: Re: [PATCH 11/18] KVM: x86: Pass the instruction length on memory
 fault user-space exits
From: Sean Christopherson <seanjc@google.com>
To: Nicolas Saenz Julienne <nsaenz@amazon.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, pbonzini@redhat.com, 
	vkuznets@redhat.com, linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	graf@amazon.de, dwmw2@infradead.org, paul@amazon.com, mlevitsk@redhat.com, 
	jgowans@amazon.com, corbet@lwn.net, decui@microsoft.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	amoorthy@google.com
Content-Type: text/plain; charset="us-ascii"

On Sun, Jun 09, 2024, Nicolas Saenz Julienne wrote:
> In order to simplify Hyper-V VSM secure memory intercept generation in
> user-space (it avoids the need of implementing an x86 instruction
> decoder and the actual decoding). Pass the instruction length being run
> at the time of the guest exit as part of the memory fault exit
> information.

Why does userspace need the instruction length, but not the associated code stream?
