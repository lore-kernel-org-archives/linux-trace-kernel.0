Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F9C30100E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Jun 2026 16:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782320227; cv=none; b=hDJ32Ysf0xIJJW7YmU2DUm41rKXMT297zZnTYxsqD8E9B1tF5Du1ClPioeURzJKZwYpeEQbe9QDlqFs65mcduo2c5I1S+PEBt3RrefpcNE2CVVMOgL95OrSYC0BUfmBvYDJfhIBTczBw1eJmKWq2ve98rqCLi7UQVkEuEXAw0Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782320227; c=relaxed/simple;
	bh=sFclBlGuLlklutyWalxOxdLRxtPJWxF7xb2dfh79PCc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q9qW3TpZN3Qb4rzKoLac6BfGYu6D8Kws+14cKYD3+cHiik3av6VhtmiywmeLnkqV8ealhGcaxxn9+4MTWX5XKogNDtsbHWdub8n9rMDt/GKzc6/FxcGlU/iz4vZpEeOFPFK0aLsENS/IWd7r+WL0QGnqKVSeaeZdUzROC/viChA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bvJxEX3r; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bvJxEX3r"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c0d0516ad7so8395745ad.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Jun 2026 09:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782320226; x=1782925026; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bTiRAq90VFPvdthoswICGCbbk82NFtmBH/qctXPK1uM=;
        b=bvJxEX3rsk8IBE8FBs+jN29a+YeGR3JEDndKlMnuwYxHyJeTAO5qxR4Z1TjsSyaM2Y
         baknumWOVQBnwfnzwfeNHNIOdr2/J/ZcfMzNU+XOEXx0rThPrSQ00W5DDfd7iLom7fx8
         zq7udvudFJ7BGPqnbxkZg4rFq49YCYlLtfWY+NKZxUpTaU34XLaMPxThLQQ1r4e/isJQ
         UOox1nyS7dd8DycpoKRIPGOYhZR/y1jutm52zreGNncrofsIVzvOmJATEmaWKgrR8yWX
         Qpj9AfGMyziKgSfVeRBzsGnaH4uWKTxus/U/EC62RdpksdCAlG8Vo14jIymdxbnYN3e4
         W2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782320226; x=1782925026;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bTiRAq90VFPvdthoswICGCbbk82NFtmBH/qctXPK1uM=;
        b=a1dMPU6EwCrKlx8AzP3i0sw0ak05CJZ8TePMixyrFrggfmMWkep7V2fMwFSHJVF8pH
         q6YKcauMVBzHZf5B12kUUtyHN1h+4dsRQBtfO4BuS3sbhYvI9OL+viAUzyKS74d+ywRK
         BuW+jqXtjtQBypJFUhXUwVqFSUcgHNMMqv8NWPXR+B3peq1qrNrVDVWi4Ud5n2mk2Iio
         LnfYYsIxRQK/gLGQ+nk4h39P4n1RluHf7Vpwh4hlP7DQdVuCViOvkq8S4KNfti4CVO/U
         eG7kjCIkFgQkH52pOZLpoasimP2KG26QBhTfwvFdfBpsBl8/KCjdjudkildv5VB5hiOm
         l7FQ==
X-Forwarded-Encrypted: i=1; AHgh+RqlrM72ATUuzbpn3l6hLsHMz9PGxrVcjoRgXuhCUkhOwGcqpYyLNbYSyk7r/GNC+S3Cl/v6Rte+eVILdTWxPB02BmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxriuiW7LZdAP/0Mh7fgmA0VywtyqcDMdS848aJ2ZkhjB20aK4R
	OivkjWok9gc03MyR/lhhKnFdJOmFG2AYeEh7V4ql9Ok22V9tCTaK6tGkjm5fetbGXxXdPf2B/E/
	/64Nu/g==
X-Received: from plpn21.prod.google.com ([2002:a17:902:9695:b0:2c6:b814:535b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fd47:b0:2c0:b081:84b1
 with SMTP id d9443c01a7336-2c7e1464d1amr26763135ad.10.1782320224855; Wed, 24
 Jun 2026 09:57:04 -0700 (PDT)
Date: Wed, 24 Jun 2026 09:57:04 -0700
In-Reply-To: <20260618-gmem-inplace-conversion-v8-18-9d2959357853@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com> <20260618-gmem-inplace-conversion-v8-18-9d2959357853@google.com>
Message-ID: <ajwMYCSrPlxg-Fok@google.com>
Subject: Re: [PATCH v8 18/46] KVM: guest_memfd: Handle lru_add fbatch
 refcounts during conversion safety check
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 18, 2026, Ackerley Tng wrote:
> When checking if a guest_memfd folio is safe for conversion, its refcount
> is examined. A folio may be present in a per-CPU lru_add fbatch, which
> temporarily increases its refcount. 

Under what circumstances does this happen, and what alternatives are there for
userspace to work around the issue?
