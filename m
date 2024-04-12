Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B192538F84
	for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Apr 2024 20:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712954687; cv=none; b=XgkLdItM2E93tJr7rI8096DgsoOeWdeC6qBUXYYlfa4injJJNahbaeUg5gx2iDazlTrxtTcJwXdlli+EHsxjVNbu9xJxBVNKI5QK9rHoAYS/7FTiWAGRctUEMpe19t1UelAgbckTHbENUpV+VLWGQO23JdpUKU4ViWv8j4Xe3AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712954687; c=relaxed/simple;
	bh=4vp5qyEZGAMwuOagLnJKbRJSa5AiEMRLbDSwvkWArmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2kVj+qJjkeYEFO8A6a3hVERmor1Vq3AOJFBMNFKqfSvzmRMp5JLApcebHR+4N2qu2JHIv4BjTr4B7yiF/KdvxcsOe/hXJubWFkzpZizcex+jaVEqDdw0p3ifSOyX/GCbzkQRPaMNBNeG+Yv0aW2IQV3EwsWbQGbUxeJbRY9z8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yQMQuYjb; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yQMQuYjb"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6eced6fd98aso1229354b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Apr 2024 13:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712954686; x=1713559486; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7z+VKNpPRufGEfzC58h5hLq5eFFz0DWRzzztXBo7m7o=;
        b=yQMQuYjbhFOlCQ8Gzdl9Xv5QCd08u8VB0kdTakIKfGcmTWPifX2DN5q+K6tDaZxH5n
         m0uANjkHLbhn93+7D+MspsP2TiTCGrWh2pgaVNYTymjZJ7oJlrywjfqzqFltxdVqmtfh
         spHaY02+TzoAG1rLUD/1xA9suQ5zVPpGahp9VJZJtU/l5QUI1o5+9kCdwblBN83wvfV9
         +jxcKb5OHNiycfISJkgopR8+IlK+6wBMXciW4G3ZDW9yIKMYq6pF8aijFTZdYtmHndsm
         gzF/VTejqERQC//+ZuY+46rEx90KZm0iyYcmg+cdGUZtdRwJ3JFFVuO1SrmWoAoH00Od
         00Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712954686; x=1713559486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7z+VKNpPRufGEfzC58h5hLq5eFFz0DWRzzztXBo7m7o=;
        b=h5dzkfdmKj7LxraJKgIpkxRWozPLInnNySxhJWb/2E3bIxfpCPm/L1tHmbv1xZo99F
         KgLhhHbxPgaAM2gb76QNEvJqKhPlGx2t6mcXTif2GY8n9UHV1GJrbfo7/rstENZd8VU2
         ibeAmKToOWozIjP0TvvXoZUes+8Yh/EXnb/DbLEH9JJwwCgTrYU1G1hNnHTZMkM+5KsU
         5yiopsXwVLdOJX+UZ1RRK8Hc8i4SkJ8ww+LfAPgoWDfJ+gJAjMOtw0WXWvrqTrAoiwzO
         0Aox53m0RYvLzSAdT5gkYQZ0RD6PF6PMBU2+ATu/QpujWCqeUJpiVOOZziv/VDPOVxdu
         yQSA==
X-Forwarded-Encrypted: i=1; AJvYcCVHPyP2DHp0hMfOkedv6W0U/aw2LC9hu4s6vNXLCGfGO56c3MxWjpkghsSGomC+swvbu2KXUHCSi9jxjE5Y9yZ43noqR6D1TPhBteZek1H7nBu+
X-Gm-Message-State: AOJu0YzK+FXmh7CWgS+zh8HQFfMS6rj2VO+2Fn14f0fJWoCvXEriD+xv
	WhCijsA40Ypwp6tNR3hsYSSwrEJp2egBtR2MfRzoJE1AELLapazPHpWHZc6TSQ==
X-Google-Smtp-Source: AGHT+IFZFKdCRdPaL3Vb0XTMjnUQNtJVoruOo48GxoyfTAhTrJOnmmO+jVgRuAaY5z2jRsVdxr03aw==
X-Received: by 2002:a05:6a20:8428:b0:1a9:6c42:77f5 with SMTP id c40-20020a056a20842800b001a96c4277f5mr4669546pzd.59.1712954685790;
        Fri, 12 Apr 2024 13:44:45 -0700 (PDT)
Received: from google.com (210.73.125.34.bc.googleusercontent.com. [34.125.73.210])
        by smtp.gmail.com with ESMTPSA id lr31-20020a056a00739f00b006ecfe1c9630sm3368108pfb.92.2024.04.12.13.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 13:44:45 -0700 (PDT)
Date: Fri, 12 Apr 2024 13:44:41 -0700
From: David Matlack <dmatlack@google.com>
To: James Houghton <jthoughton@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Yu Zhao <yuzhao@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Sean Christopherson <seanjc@google.com>,
	Jonathan Corbet <corbet@lwn.net>, James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Shaoqin Huang <shahuang@redhat.com>, Gavin Shan <gshan@redhat.com>,
	Ricardo Koller <ricarkol@google.com>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	David Rientjes <rientjes@google.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/7] KVM: x86: Participate in bitmap-based PTE aging
Message-ID: <ZhmdOb7lAd3DM5Tq@google.com>
References: <20240401232946.1837665-1-jthoughton@google.com>
 <20240401232946.1837665-6-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401232946.1837665-6-jthoughton@google.com>

On 2024-04-01 11:29 PM, James Houghton wrote:
> Only handle the TDP MMU case for now. In other cases, if a bitmap was
> not provided, fallback to the slowpath that takes mmu_lock, or, if a
> bitmap was provided, inform the caller that the bitmap is unreliable.

I think this patch will trigger a lockdep assert in

  kvm_tdp_mmu_age_gfn_range
    kvm_tdp_mmu_handle_gfn
      for_each_tdp_mmu_root
        __for_each_tdp_mmu_root
          kvm_lockdep_assert_mmu_lock_held

... because it walks tdp_mmu_roots without holding mmu_lock.

Yu's patch[1] added a lockless walk to the TDP MMU. We'd need something
similar here and also update the comment above tdp_mmu_roots describing
how tdp_mmu_roots can be read locklessly.

[1] https://lore.kernel.org/kvmarm/ZItX64Bbx5vdjo9M@google.com/
