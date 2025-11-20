Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103A02D2497
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Nov 2025 11:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763638583; cv=none; b=aBgdXCdvHxxQpagqnXLupuQlaI6Ll4ap+Lxe5GBsvc1zaRk28szDb71Rx/HRCNiunMcE2G2VO2yc7mGb7okxdapv6HluX0Oz2qmCI/IgnkEYnasQpNH05eEcdI4RvKxDZV8tAyneC1fTj81ynrei9Tw6QLE3t9MhhVvr2j+64PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763638583; c=relaxed/simple;
	bh=F+0N4wMzGmWADzwl/vFuA6k8UEcvJMDKp1Ep/I+CU2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GwowaKah6WQN0NoJ7VGWR2r0EglqtpP3NcwSjJ0G69TccERwoX1qdxbZVYWHg6FwyywkGzYa4LxJ9rO866rsxNRrZ22GmxDwYpXRQKGm5DeaU8mUyMMD+viHnqQSlDYhJI9wKd8CgwRjt3YXy4QhPlkYSHvpvY7xiEUC79IwT80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j/xlzzHw; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j/xlzzHw"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477b5e0323bso9757645e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Nov 2025 03:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763638580; x=1764243380; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TPlzmXt4DNVBdqLVvxiBIWu8Rl4FZ4bDuiyypGx7MuQ=;
        b=j/xlzzHwOB9rBb9sb/z155Frmjy58E48WgNJlGSxtBSCUN5E616mxCcGmhwnb/0hkp
         VZzSS1giFVpXwV0ObmekZjU4wrzbiqplWTVn6yD6tIsy6qWPKsvGcl7tXxbkl69HykAm
         DEmB+cV9h4CWNIambnMzS8bPKLKG3JURMRt8oaSZcFXMYu32wfUWXhgcoqk6okfOwTKY
         k7r2bQSHENsKretZkk19WddvE3zc+riDB+W/b1oTIGdpUYCQ6CiAjnCTRThfgkeoCSR/
         jEjhZxJ22hcma1vTrXsoSOvyDVemaNOJ+BpGvMDAdO2tTWrt34ep/cO7oPMRw3GUTevI
         eObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763638580; x=1764243380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TPlzmXt4DNVBdqLVvxiBIWu8Rl4FZ4bDuiyypGx7MuQ=;
        b=Uuga7BLLWrRm1KUYIfRLMmDkzD8GS1qzJsW+985I2JrwyKwcT9wq0+r6KFaEN8zofP
         GpzL3h0mYlMU/q6x/hCoYpz/Ha2/lpogLuQ7b/6nmCAjdGaeeJjc9fyuStkoNOECN6y3
         RDkHG4TTgTU6ZLKH8qVRUTuHKKhJuv0qIg9ZsmjqnkvmCt7YHOtcwNYrHU18DAyOSfRh
         e8vfjv5ON/SsFFX5VwVd3PyQ9cl/xQql+dP8KpUue8xnDkL+TV/9aa8OLpfrpU0tGSEh
         GZOqMHKU82uIYOHyQrHFKyBP0baL9BUfcURC1a/Tq0k+CRUBiCWs27qoynT2IID+2XwK
         RoRg==
X-Forwarded-Encrypted: i=1; AJvYcCUiScz0yqAGvw/45ukx2n3rlAaneYZom/zJ7mJc+VllKhgvavC+Fpo3AproQabDHNZapew8tMnxG3J2ehmliNuzOQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxva3acpfmIvlk8kDLUxugisPgp/mkW7eEPrap92QxDESg6/+jE
	wTrwDSBRPJf9C4e9enAKu+6wh3afPt04Qy5kC/6gqL8EDeiSy197WLgzSBcmptH4Kg==
X-Gm-Gg: ASbGnct+zUwjkcDLsjH/XqwUsdCw4OqApSkHvRbMT/+kwq7DMW4k5zi29H39pE9Cwaa
	U1lVBTktk+1HraNNhUd4NcNOx9vCV5KnE3b1I7QJZcxugKAI8p/X595u9SfRRFzJ9Bu5WM2WZBR
	BevUKanjj0nNIfjV+U4ORTgl01AImI8JpCsj6S9Ud28qbyMMm2K8rfjUCR3wyOv+HSPTQ7GLab/
	e3BXOZwmypPEx/zl/mdA473iR/1KSExBIiHQfn4t1DG1UoTnJcqdzKmLnciDSohA/fBXwtCkTC3
	cfE1aUgJLVH6AOmzoif2C2h8vkeG5NzpuGII6Pj3jOOygNOpaYl+4vEac9XOlx21drVMe3Vi+Dk
	5n7zAoQVw92SPVLDisR5ExVfPCLafonaRhJxXyJeYy880ghYWpsyBn6DprgLLDwS5klgNOJ4led
	bCtZnJ5eA10ISqfDs66x0S4Pz3CWnDkAx6kQ/pX6kqT09GS2oSCQ==
X-Google-Smtp-Source: AGHT+IGcOCRDUWPkVUZ7ncQTNFf+q64GbtuEHTlJs5oKc83ztKfhHnrQKRpzLVqerrPSrM7dBJtv3A==
X-Received: by 2002:a05:600c:2e4c:b0:477:9890:4528 with SMTP id 5b1f17b1804b1-477b9ea31e9mr14670485e9.2.1763638580134;
        Thu, 20 Nov 2025 03:36:20 -0800 (PST)
Received: from google.com (120.54.38.34.bc.googleusercontent.com. [34.38.54.120])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9e1b657sm60238005e9.17.2025.11.20.03.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 03:36:19 -0800 (PST)
Date: Thu, 20 Nov 2025 11:36:16 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Marc Zyngier <maz@kernel.org>, g@google.com
Cc: rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, jstultz@google.com,
	qperret@google.com, will@kernel.org, aneesh.kumar@kernel.org,
	kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 20/28] KVM: arm64: Add clock support for the pKVM hyp
Message-ID: <aR79MCNlAKP1H-PQ@google.com>
References: <20251107093840.3779150-1-vdonnefort@google.com>
 <20251107093840.3779150-21-vdonnefort@google.com>
 <86cy5erprc.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86cy5erprc.wl-maz@kernel.org>

[...]

> > +/* Using host provided data. Do not use for anything else than debugging. */
> > +u64 trace_clock(void)
> > +{
> > +	struct clock_data *clock = &trace_clock_data;
> > +	u64 bank = smp_load_acquire(&clock->cur);
> > +	u64 cyc, ns;
> > +
> > +	cyc = __arch_counter_get_cntpct() - clock->data[bank].epoch_cyc;
> 
> I can only imagine that you don't care about the broken systems that
> do not have a monotonic counter, and that will happily have their
> counter swing back and forth?

I haven't used the _stable() variant for the affected devices... Hum this will
not be trivial from the hypervisor. I'll see what I can do.

> 
> Also, you may want to document why you are using the physical counter
> instead of the virtual one. I guess that you don't want CNTVOFF_EL2 to
> apply when HCR_EL2.E2H==0, but given that you never allow anything
> else for pKVM, this is slightly odd.

You mean I might as well use __arch_counter_get_cntvct() as CNTVOFF_EL2 will
always be ignored in the pKVM case?

> 
> Thanks,
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.
