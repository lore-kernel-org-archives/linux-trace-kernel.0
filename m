Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095FD38423A
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Mar 2026 06:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382440; cv=none; b=N9yorBJ8rIlOjO7jN9Sg25225DJBeA47440g+CwzKvPgxEDRNTYQ1AmIl9mOu8k+Ng0QpDgH1Je2ohaV5K/2xDw6T5TPPPQ4qxUym6hAT9wHCpK1RwIF3FOct1QVF8WhPMZmGz/7q7OLD+cxu02MLNtvBLzXbIfyWJULqp2Ne5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382440; c=relaxed/simple;
	bh=2KjVqTEvpnhVeQDF6oSpdJZ5plfD9T0yEmClN5nA0FM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qUNvxqrIPW9kHOHvQzK632eSDu3EayMcfcgF2BfD+/ZG67z9fkVfmrJ6FCbqN04ygQhKmWDAooZd+//+PxPUWn8E1kkRTteuYZWPwVMopBhpJ/W6xX7AVAo4RSy/XKjmVauh+LztfldmafsgB9LLi5x1wSVB6QEntri5WA/QeEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DHCHkamt; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DHCHkamt"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3568090851aso13926306a91.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 23:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773382431; x=1773987231; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Y9+LBtNIwUBlImIv/NS8s6X1brjmBLxK4e6zepb28A=;
        b=DHCHkamtm+AkFQG5llBTd+O5p4u2bUYiqHONFRdA90XYZjP+W7n3CyK/FuAGoJwKfm
         Vjzd4faIJc0lzBTpl9vTP7DDA6H2w3y2gJgSWfS0QIpWnP1jAFDezHtStAct1f2agJqM
         aSBPPSPC6jsawndRnZWBz2/9id6TCAUcFpyi3gPoYEWLTJby7FQmbuzb2dHA+CmBE9PP
         zbN32dNC26IDk6kNw9r0PH6lkwf7F035aYQTK6qTKzhTk59XyRryw+BsuzGY5mXkH0MO
         XpMvamb6uoEy593JVedA5z2dgO4172yPwnlviEcx6uaRlqEkbJUlIM/hCFMAszdNnTd8
         mHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773382431; x=1773987231;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Y9+LBtNIwUBlImIv/NS8s6X1brjmBLxK4e6zepb28A=;
        b=TI+AofwhQtDvSmRB7yM24wld3gpxIAp8rlgjhhu0ylVdRtfPxL3/LL3v8SjYM21yKE
         DYXimDTkb0tP68iAykyFMiCUt7G2ZSZT2kCkVSvh51nGOYFcjGPBkiY4EKIrfcduS1gx
         4pr+HSMedInV3+DxXUToYFUI4OfkY8cDpncPZl6YbVDdjqp6OI2fa5INx0fzqVqaVzPr
         OX8vu37h7tKp63p1KggQIMCYyZ1OEqqf4ylJYmOBUJM+/21o7XmUaxxvLxKERPi9g+Hf
         Bu3PhslXFVfsXRsLTBlYl7PswWwUHEJhpACfi7+p/UBGs0IhtuYXDQrG+IhYx6xaCSGt
         BX0g==
X-Forwarded-Encrypted: i=1; AJvYcCUd/mXD5QZG2EMaEcbvs9KrEqQCOrYfhfN0MxzCA9tNp253GYxtKKq45hRGpp+aaUEbzmRJracCQwajB8zRiurbAjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxinnCgijkKn99GWN/0yvWolXcXF33O1n7BjSSZfzPxYkzhxnqN
	N7lzdGbBbFVsTydpE0RVz5qA+i2oS5YNsGJgA/pKOiaZ/lR7JRDb7TunC2u/D1sv7Sfpe2PiplH
	smX1+KoEF/2T+g6qRselYCvTb9w==
X-Received: from pjblw9.prod.google.com ([2002:a17:90b:1809:b0:359:9111:25a5])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3888:b0:359:f7d2:a1fa with SMTP id 98e67ed59e1d1-35a21ea67bbmr1975196a91.4.1773382430962;
 Thu, 12 Mar 2026 23:13:50 -0700 (PDT)
Date: Fri, 13 Mar 2026 06:13:17 +0000
In-Reply-To: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773382364; l=2646;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=2KjVqTEvpnhVeQDF6oSpdJZ5plfD9T0yEmClN5nA0FM=; b=zH9GavLcekczy6HMVrDu5CSJhFpAOcSOs94lLNZHgnCgfc1Lq7t2aTehE29lTD1R4gvTZS5jc
 +YtREAD0otZCIyuxlE5tS4rPxcETFLg1RUnbDV4evD2w5rYZccM8NN4
X-Mailer: b4 0.14.3
Message-ID: <20260313-gmem-inplace-conversion-v3-38-5fc12a70ec89@google.com>
Subject: [PATCH RFC v3 38/43] KVM: guest_memfd: Introduce default handlers for
 content modes
From: Ackerley Tng <ackerleytng@google.com>
To: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jroedel@suse.de, 
	jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org, 
	pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, shivankg@amd.com, steven.price@arm.com, tabba@google.com, 
	willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
	forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com, 
	aneesh.kumar@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"

Currently, when setting memory attributes, KVM provides no guarantees about
the memory contents.

Introduce default handlers for applying memory content modes, which
different architectures should override.

These handlers will be used later to apply memory content modes during set
memory attributes requests.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 include/linux/kvm_host.h |  9 +++++++++
 virt/kvm/guest_memfd.c   | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 1ea14c66fc82e..bcb81e871fd37 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -740,6 +740,15 @@ static inline u64 kvm_gmem_get_supported_flags(struct kvm *kvm)
 
 	return flags;
 }
+
+u64 kvm_arch_gmem_supported_content_modes(struct kvm *kvm);
+int kvm_gmem_apply_content_mode_zero(struct folio *folio);
+int kvm_arch_gmem_apply_content_mode_zero(struct kvm *kvm,
+					    struct folio *folio);
+int kvm_arch_gmem_apply_content_mode_preserve(struct kvm *kvm,
+						struct folio *folio);
+int kvm_arch_gmem_apply_content_mode_unspecified(struct kvm *kvm,
+					    struct folio *folio);
 #endif
 
 #ifndef kvm_arch_has_readonly_mem
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index c4f6bdad6289e..f23acbca28e54 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -638,6 +638,42 @@ static int kvm_gmem_mas_preallocate(struct ma_state *mas, u64 attributes,
 	return mas_preallocate(mas, xa_mk_value(attributes), GFP_KERNEL);
 }
 
+u64 __weak kvm_arch_gmem_supported_content_modes(struct kvm *kvm)
+{
+	/* Architectures must override with supported modes. */
+	return 0;
+}
+
+static u64 kvm_gmem_supported_content_modes(struct kvm *kvm)
+{
+	return kvm_arch_gmem_supported_content_modes(kvm);
+}
+
+int kvm_gmem_apply_content_mode_zero(struct folio *folio)
+{
+	folio_zero_segment(folio, 0, folio_size(folio));
+
+	return 0;
+}
+
+int __weak kvm_arch_gmem_apply_content_mode_unspecified(struct kvm *kvm,
+							struct folio *folio)
+{
+	return 0;
+}
+
+int __weak kvm_arch_gmem_apply_content_mode_zero(struct kvm *kvm,
+						 struct folio *folio)
+{
+	return kvm_gmem_apply_content_mode_zero(folio);
+}
+
+int __weak kvm_arch_gmem_apply_content_mode_preserve(struct kvm *kvm,
+						     struct folio *folio)
+{
+	return -EOPNOTSUPP;
+}
+
 static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
 				     size_t nr_pages, uint64_t attrs,
 				     pgoff_t *err_index)

-- 
2.53.0.851.ga537e3e6e9-goog

