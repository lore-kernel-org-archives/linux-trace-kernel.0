Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A82C36F432
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Mar 2026 06:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382394; cv=none; b=Ad8QpHmkdaXwHZmRL4Ybq9t046UzNORmxp7tvlkk36c35uunYcNcIFImXNRT7A/m2QYCzQuI8/WWE8K65oXRQFIhtP7FCvuZx7EF2/O2zEY295eZvYRybUGBqo9xY8+VLDlZzmwCD7W60jVuufgeZT5ufrH9CpwakRO3EYUOL50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382394; c=relaxed/simple;
	bh=lEnML6fk8+WAkIxMuWVBhCw0MzMHDX4CUEoAyGmBO/o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mGOJpJWKdGBTy/YQeR9NwMTBaBfI63qZLARLUsDIJfrAX5GwKL7Ph6rvp7BilYrHcDVewdCBYj2dpR3c9BAhk4HD2mNDz2g/XlUzAbqb+xqzJGUTXdTUi0sMMBeVTo4VD7wFRXQLzv/UNCjUfX5JHp95irn6E7Zdhbpncd+e/3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q4WNTF/6; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q4WNTF/6"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35a1e725a8fso6008017a91.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 23:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773382392; x=1773987192; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uT/wLR5Jn4iFTGZ6y1IwwIViRXwEzg+e1s6zn05HggY=;
        b=q4WNTF/6GOE/ZdyKaY/XgZJHVsaG/sqwMViEy3dSG3pN6NA+6V4ODs6bY/8PntlTcM
         Rb4AyduUAvOshlqza/r3aqtYEOqZc4nX+HTCGjg2uPal0WyRSvFeipBpke9unIhT8oGd
         JPZffmTHli6OYxs42SV6r6ashjzpv+lJdAinbXEVasTAaNBQv6ZXGeJVpB4Xbs8cJjFI
         aN4gKHdWT2e6DWezTcguQ6c8e5G+8SXE6zL7aC9itEeLqdZq5FlvFDS3jAd9TtyCX20p
         5VoTSU3X9XB+ZSkjTwoEW9xTSeYxzyXya6RHGwExPinh5fkGpSYc7c+G45/Np04DtU++
         Bn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773382392; x=1773987192;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uT/wLR5Jn4iFTGZ6y1IwwIViRXwEzg+e1s6zn05HggY=;
        b=IpCfLPm+/i1VnXFVkRpwq6sJPwVwnx1Xs51qneBc7UppcVszkhMbi4GTPZ7Yyz+v2q
         S8ln3KNssLz+2GdG7ZDosQ5L/8fP6F5Tf469RwTgb28kzLIJIPlnz3v4/W5mGivRWiIh
         0W/uFmoYfqhdHEnvbmypSuTnR6qXgnxt3VlkEIc94usd54BrvyjTECjAkoWNNhXXM+Xx
         kXoPmBtBE88TylCpFu+BiMlvEP1Lsv2dO0T7aFcJjI5JL1ZqRrgl1sCV+G//2Q+y3FTF
         c2DniiMSVuc8LaSJkFhSFbpWM/DluWKXsI2qyUHsBYvx2CxAyLQfBkTlexfQYKn6RnkF
         6Rmw==
X-Forwarded-Encrypted: i=1; AJvYcCVNFuAvNGmkq+26ztYQEZ6OKhS2tXRg/26qyzrOPkQLD0L2z6DJ611cAnhcdT18oEy5m7LWd4S6fzKBFnyazO2gOGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6AvMrX195JzzQO91S0YisezQ2XhHqGAbwdKZs7zt7JAnx0Y/p
	jyQ4UnCYSB17u3/qDcjcTIOCR+NyMs5tacxSBoIhJnaj9ywmxwFUpmq7WyXd3+/cXLINIAMb6R1
	jGfTEZCExokzhDi1OoY2zlh7MjA==
X-Received: from pjbqo12.prod.google.com ([2002:a17:90b:3dcc:b0:359:7bbc:ec98])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:528e:b0:354:bf10:e6a5 with SMTP id 98e67ed59e1d1-35a21f064eemr2022217a91.10.1773382391422;
 Thu, 12 Mar 2026 23:13:11 -0700 (PDT)
Date: Fri, 13 Mar 2026 06:12:53 +0000
In-Reply-To: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773382364; l=3719;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=knPXn7cTEnE32qPaGovYRbheax1spbV5ScE3bJAhH3I=; b=av3R7r+Shr8bLUoixCjc0bCw3zOPZcyvF7XPQxV5ePTYJuRhwxvUgvJsHygoTOMmqbwNxir0X
 z6vTB/yifbyB+UjlgUW4cgJeERFLeJ0hVlahLsfOMA2I+baOvyO3BsZ
X-Mailer: b4 0.14.3
Message-ID: <20260313-gmem-inplace-conversion-v3-14-5fc12a70ec89@google.com>
Subject: [PATCH RFC v3 14/43] KVM: selftests: Rename guest_memfd{,_offset} to gmem_{fd,offset}
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

From: Sean Christopherson <seanjc@google.com>

Rename local variables and function parameters for the guest memory file
descriptor and its offset to use a "gmem_" prefix instead of
"guest_memfd_".

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 610cb32ff207e..3b64fbadcd88d 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -947,7 +947,7 @@ void vm_set_user_memory_region(struct kvm_vm *vm, uint32_t slot, uint32_t flags,
 
 int __vm_set_user_memory_region2(struct kvm_vm *vm, uint32_t slot, uint32_t flags,
 				 uint64_t gpa, uint64_t size, void *hva,
-				 uint32_t guest_memfd, uint64_t guest_memfd_offset)
+				 uint32_t gmem_fd, uint64_t gmem_offset)
 {
 	struct kvm_userspace_memory_region2 region = {
 		.slot = slot,
@@ -955,8 +955,8 @@ int __vm_set_user_memory_region2(struct kvm_vm *vm, uint32_t slot, uint32_t flag
 		.guest_phys_addr = gpa,
 		.memory_size = size,
 		.userspace_addr = (uintptr_t)hva,
-		.guest_memfd = guest_memfd,
-		.guest_memfd_offset = guest_memfd_offset,
+		.guest_memfd = gmem_fd,
+		.guest_memfd_offset = gmem_offset,
 	};
 
 	TEST_REQUIRE_SET_USER_MEMORY_REGION2();
@@ -966,10 +966,10 @@ int __vm_set_user_memory_region2(struct kvm_vm *vm, uint32_t slot, uint32_t flag
 
 void vm_set_user_memory_region2(struct kvm_vm *vm, uint32_t slot, uint32_t flags,
 				uint64_t gpa, uint64_t size, void *hva,
-				uint32_t guest_memfd, uint64_t guest_memfd_offset)
+				uint32_t gmem_fd, uint64_t gmem_offset)
 {
 	int ret = __vm_set_user_memory_region2(vm, slot, flags, gpa, size, hva,
-					       guest_memfd, guest_memfd_offset);
+					       gmem_fd, gmem_offset);
 
 	TEST_ASSERT(!ret, "KVM_SET_USER_MEMORY_REGION2 failed, errno = %d (%s)",
 		    errno, strerror(errno));
@@ -979,7 +979,7 @@ void vm_set_user_memory_region2(struct kvm_vm *vm, uint32_t slot, uint32_t flags
 /* FIXME: This thing needs to be ripped apart and rewritten. */
 void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 		uint64_t gpa, uint32_t slot, uint64_t npages, uint32_t flags,
-		int guest_memfd, uint64_t guest_memfd_offset)
+		int gmem_fd, uint64_t gmem_offset)
 {
 	int ret;
 	struct userspace_mem_region *region;
@@ -1062,12 +1062,12 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 		region->mmap_size += alignment;
 
 	if (flags & KVM_MEM_GUEST_MEMFD) {
-		if (guest_memfd < 0) {
-			uint32_t guest_memfd_flags = 0;
+		if (gmem_fd < 0) {
+			uint32_t gmem_flags = 0;
 
-			TEST_ASSERT(!guest_memfd_offset,
+			TEST_ASSERT(!gmem_offset,
 				    "Offset must be zero when creating new guest_memfd");
-			guest_memfd = vm_create_guest_memfd(vm, mem_size, guest_memfd_flags);
+			gmem_fd = vm_create_guest_memfd(vm, mem_size, gmem_flags);
 		} else {
 			/*
 			 * Install a unique fd for each memslot so that the fd
@@ -1075,11 +1075,11 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 			 * needing to track if the fd is owned by the framework
 			 * or by the caller.
 			 */
-			guest_memfd = kvm_dup(guest_memfd);
+			gmem_fd = kvm_dup(gmem_fd);
 		}
 
-		region->region.guest_memfd = guest_memfd;
-		region->region.guest_memfd_offset = guest_memfd_offset;
+		region->region.guest_memfd = gmem_fd;
+		region->region.guest_memfd_offset = gmem_offset;
 	} else {
 		region->region.guest_memfd = -1;
 	}

-- 
2.53.0.851.ga537e3e6e9-goog

