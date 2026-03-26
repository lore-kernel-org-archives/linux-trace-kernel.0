Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F53388377
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 22:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563897; cv=none; b=RCc6WyF+LImcfs13cISbS5g9jwob3lN00m/2eRt+CYDSQ6FfPE+WIHaL4uxK3HqdRHIp2wQ+tpDL6w5OTtMP0ur8KiLLYuh+yVDRX/hgArEFOjpJilGmrzOKzJin2kx+JnF5jyUeljqAte2ltYQ2K9Sd02EHxLzZRuvKzMchFjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563897; c=relaxed/simple;
	bh=k0rIEhQmrf2G34ijeqLeCvTfDWOQ9le3qaLEQJYYHBc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jNQPFQbBk9AwWO9yC0tBNf5r/qsgHjw89qYtj7yk3WmvjcqCt6ZtdUViXEvJ4QXG7pSqdbqNYAz9lcJ2Ex2BBrBi6s8DjRGYaV3vAk2VBI0VbLqBQ8doBTWyA40+WxXwrkkOs+2+fHENswVCS08BMkwNcrSj590xVvTgy/OVcG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G17Hsqxw; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G17Hsqxw"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c7656dba76aso933097a12.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 15:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774563895; x=1775168695; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t5sAlrGE9K54t1wVa5MW/TMmXMtzYRZrp4A2ve/Zymo=;
        b=G17Hsqxw4Welb4eIipTrOiBxBnawR+K+OsYRJc5tAoM1O8BhURhYiQQUWanO6U558J
         B9JeGjE9QMCjV3Y3/FmMpNOl/ICRzsw4V8LIv6PU9tvKi6An8qlaFadQTzR0BnsyGZqN
         YuoV8avgJnTx1clx3oiq1upetHygk7BNqQvN/r5a8YY6JW+kees/j5GzFKwKKgaDEG32
         r6SfTLV30K9aNDE6aqMsRiJbMLsy/MDY87OyF8LeSA5Mlx2iX5DAJI8ByT+CJeLZKZXG
         XS4ezdLP2Z/KPFliOo1USAi9DG9U6o4TthYLjaMSk21++8p6SnEaR5eL89h7Gs+4P0ZU
         Ks+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774563895; x=1775168695;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t5sAlrGE9K54t1wVa5MW/TMmXMtzYRZrp4A2ve/Zymo=;
        b=bM/mI7DmEgYYziqsKz4zX6RTVG96od2uAV62o8p/6GIN+DtgIO0SBgllhcVy7eWByG
         esvFdyKMNgWbYNIl/3zcxnnZ29g+AT3LaSNCs65xDDT69guSsPe06Juuo1A5DpNPk4b6
         XTZFcctUYSbWn5EwpvcCXTG/YsQnO4YES8DjB/nUS/6pkHLtdCdn+Nh/yzuEc5IQ8Cj/
         40cNudBvwqvKYs9a93Vx8i8K5OnpGQtpkDMm5qdtL4b15gRbTEvRgeTDEpgORaME69Wr
         CV6peXIunJtfMfKZKJHJO8j7/lARExFjLxKFgCXuZv7C3e1YFMhjAo/+7uOJSS3Dzx19
         JoJw==
X-Forwarded-Encrypted: i=1; AJvYcCWPZUmhNNjCkBOQxROtsZ1mYJ03Iut4i4hea8Yo/zarE+N5hJm0soc1vNfox4sCow63JAM3Hiwrn+CUPzxrdM8r9Rk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ+rDH053F4eFMXMVtu0DA5XVRkUlUbLipn8gEGmzUW40KrpDp
	OzIsJKjtWAftBN4GNXevjdfH+2aaEbdNlAgx9UUvoH+93IyNodqDslZ6XY6R7jeu8LgebJR0WQP
	WgeF1SNwUODkmlRT0GVYg314nuw==
X-Received: from pfbfb15.prod.google.com ([2002:a05:6a00:2d8f:b0:829:9082:12ca])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:bc81:b0:82a:81b6:d8a6 with SMTP id d2e1a72fcca58-82c95ed3b8amr136334b3a.25.1774563895023;
 Thu, 26 Mar 2026 15:24:55 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:24:24 -0700
In-Reply-To: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774563861; l=2976;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=k0rIEhQmrf2G34ijeqLeCvTfDWOQ9le3qaLEQJYYHBc=; b=IWLi+POwxzAv6171snEkLJVWDYN28Uuep3Son7R0IlBi2Sc94mxhcktuxdQooqH4T04aDlDmq
 +h30zn8kj/LDlT1kMmeMRqgH+wx8i80pH8UDKHg1NuB4KJ+CpPgIlNh
X-Mailer: b4 0.14.3
Message-ID: <20260326-gmem-inplace-conversion-v4-15-e202fe950ffd@google.com>
Subject: [PATCH RFC v4 15/44] KVM: Add CAP to enumerate supported
 SET_MEMORY_ATTRIBUTES2 flags
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
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"

Add CAP to enumerate supported SET_MEMORY_ATTRIBUTES2 flags, so userspace
can find out which flags are supported when sending the
KVM_SET_MEMORY_ATTRIBUTES2 ioctl to a guest_memfd.

These flags are only supported by guest_memfd, hence, if
vm_memory_attributes is enabled, return 0 - no flags are supported when
KVM_SET_MEMORY_ATTRIBUTES2 is sent to a VM fd.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 Documentation/virt/kvm/api.rst |  3 +++
 include/linux/kvm_host.h       | 12 ++++++++++++
 include/uapi/linux/kvm.h       |  1 +
 virt/kvm/kvm_main.c            |  5 +++++
 4 files changed, 21 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 90587a9c09d3f..73101d6e649b7 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6680,6 +6680,9 @@ guarantees are made on offset ranges that do not have memory allocated
 and range [0x0000, 0x3000) was set to shared, the content mode would
 apply to only to offset ranges [0x0000, 0x1000) and [0x2000, 0x3000).
 
+The supported content modes can be queried using
+``KVM_CAP_MEMORY_ATTRIBUTES2_FLAGS``.
+
 See also: :ref: `KVM_SET_MEMORY_ATTRIBUTES`.
 
 .. _kvm_run:
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 4ba3c4b303f4a..d671c9795dfce 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2536,6 +2536,18 @@ static inline u64 kvm_supported_mem_attributes(struct kvm *kvm)
 	return 0;
 }
 
+static inline u64 kvm_supported_set_mem_attributes2_flags(struct kvm *kvm)
+{
+	if (!IS_ENABLED(CONFIG_KVM_GUEST_MEMFD))
+		return 0;
+
+	if (!kvm)
+		return KVM_SET_MEMORY_ATTRIBUTES2_ZERO |
+		       KVM_SET_MEMORY_ATTRIBUTES2_PRESERVE;
+
+	return kvm_arch_gmem_supported_content_modes(kvm);
+}
+
 typedef unsigned long (kvm_get_memory_attributes_t)(struct kvm *kvm, gfn_t gfn);
 DECLARE_STATIC_CALL(__kvm_get_memory_attributes, kvm_get_memory_attributes_t);
 
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 0fc9ad4ea0d93..4d1e09d022c48 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -991,6 +991,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_S390_KEYOP 247
 #define KVM_CAP_MEMORY_ATTRIBUTES2 248
 #define KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES 249
+#define KVM_CAP_MEMORY_ATTRIBUTES2_FLAGS 250
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 85c14197587d4..6607127eaaeed 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4980,6 +4980,11 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
 			return 0;
 
 		return kvm_supported_mem_attributes(kvm);
+	case KVM_CAP_MEMORY_ATTRIBUTES2_FLAGS:
+		if (vm_memory_attributes)
+			return 0;
+
+		return kvm_supported_set_mem_attributes2_flags(kvm);
 #endif
 	default:
 		break;

-- 
2.53.0.1018.g2bb0e51243-goog

