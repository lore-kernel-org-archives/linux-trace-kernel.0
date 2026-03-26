Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D42D346E57
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 22:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563911; cv=none; b=loyX7VjacLkMosdvsExmtLSfFcPcBugWab2dgQYsyfyqbIBDCjOgbBQlE1n37fIJPQqirB7fGepvbTuM8iN4PdVs0XRQA27wzbQ/mBtHcI4giMRkNjOgq5cTJ1bj2hS+twN8icMl3B/mF33ZlgnG7QMdzCiLIVIGawPxvJknyak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563911; c=relaxed/simple;
	bh=keOumRETk/gmfETxrp2mpR7R5rvo3p/7A7+F96j8jbs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h7UJNY4ZBnn0P5FdPakcIkFBmaCEDjAetYHSYIsT0P0K/tuf/G9RSWdzsTj9/mFn9KiSOm2XgcIoMwOTWsMNPKn8e270rI+wP4ZXdf+1sEPTKivFybNqpQK/p3990uJ1bMTXc+HEsR81EHlRUOlfCqLvbB5w2DncPe8P+OkX5GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EjvRVFiT; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EjvRVFiT"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c741a9ef5f0so1036126a12.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 15:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774563910; x=1775168710; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BKAErh/ctHw4bBFHVNVYhm/xs3KUEiqQAb+NxvlWO48=;
        b=EjvRVFiTsNPRfXEZqaHCXV2rLd1aDQ3il6HJCo+vVig/NdGpkgIoQZFxzdYVRUmsAc
         pS7LDDT/ERhVBuzS8wfYGaMFkTq8P+VfnpiBi+v1qpSmTNSkq1wzhdTeG9ARHUL4Oxq5
         3s9hlSj4hzcQiO3y+cmfYc8OLrewbYVYHqeWVd4RSJ0IXXyJbN0J0XVgGHgojDBoqW+A
         6hvQxy2uSeWaKu0vT/CiZdHggdMBUl6TIBUKKyyX58DN62/7veyHCridj2xD5wu7qXCI
         RDBqY5YmJ0jH+ymueQYV5mY/X+/ewia6d81fY/9moEA5TE6W9/3dJfivob8hzZIXvlj1
         C4GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774563910; x=1775168710;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BKAErh/ctHw4bBFHVNVYhm/xs3KUEiqQAb+NxvlWO48=;
        b=WwsdL+c8Aa/KXQOb80JMIwNZd43E2f0m110q76x8SIXQ5iudWW+K/k0YQN252mpp8M
         3wBNg+HjWYOSqgi3nJiYapEp43xJa7WYcsA0qT3h4dTCH4rEMz+dTYd6jBX01LALocV5
         hq9YidbdOa7wUgoHxslpx/NqM4bdYxJNd7EdixrYG1kFJk1NX3s1ZHNTFFGn4Uu0uStp
         5DPeb5TsJzKbqynUnYJFf5JY1fO3wI+jw1PSUiScygErJbH387QX9BQL2+tUnM246SD7
         gym3tjDkI1+V0cdWb96Jl1+M8n9OESEo8Zx07Qx2ZQCZ9Vd0lK4D+fr/DT6UZnP9vTas
         6RNw==
X-Forwarded-Encrypted: i=1; AJvYcCWcJ9sT6TIT8p4UxpblMtXoxTtFGdlLe1yqGVPHrX5vDq6EE09akbvdIIQvyfZHHGdQ3rQ+Dl10Dx1B/5icjIUCh3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YymvBnlb5f6Xfi7gZxNvuelBgKff1/mkTbhnJMXe6kXBx5VKPvg
	1FayYGhV2VybY+YMMvM/We8JcXo5ume0fj4/4lri26XP3g5saSZetNAvsfBWhrlNrLrjIoTdqZX
	YvzU5BaT9KzpSabaLh1hG9ab3lQ==
X-Received: from pfvf6.prod.google.com ([2002:a05:6a00:1ac6:b0:82c:63f8:59dd])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1bcd:b0:829:7b30:92f4 with SMTP id d2e1a72fcca58-82c9696ee44mr32265b3a.16.1774563909447;
 Thu, 26 Mar 2026 15:25:09 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:24:31 -0700
In-Reply-To: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774563861; l=1678;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=keOumRETk/gmfETxrp2mpR7R5rvo3p/7A7+F96j8jbs=; b=NE1rni1CgJtrAphsc7U2X9T0bOxF0e+UOsyULzNujOmZouX64/8+6HJYWpj4MdSaexkYeIq1A
 gHippqmvpB1CC16FucD2+hckjbybeObuIuqg4FlEecf9ENkHDM8/f5e
X-Mailer: b4 0.14.3
Message-ID: <20260326-gmem-inplace-conversion-v4-22-e202fe950ffd@google.com>
Subject: [PATCH RFC v4 22/44] KVM: selftests: Update framework to use KVM_SET_MEMORY_ATTRIBUTES2
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

Update KVM selftest framework to use KVM_SET_MEMORY_ATTRIBUTES2 and the
accompanying struct kvm_memory_attributes2.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 4e06724cd2935..1e00bfa59dcd5 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -420,7 +420,7 @@ static inline void vm_enable_cap(struct kvm_vm *vm, uint32_t cap, uint64_t arg0)
 static inline void vm_set_memory_attributes(struct kvm_vm *vm, uint64_t gpa,
 					    uint64_t size, uint64_t attributes)
 {
-	struct kvm_memory_attributes attr = {
+	struct kvm_memory_attributes2 attr = {
 		.attributes = attributes,
 		.address = gpa,
 		.size = size,
@@ -428,13 +428,16 @@ static inline void vm_set_memory_attributes(struct kvm_vm *vm, uint64_t gpa,
 	};
 
 	/*
-	 * KVM_SET_MEMORY_ATTRIBUTES overwrites _all_ attributes.  These flows
+	 * KVM_SET_MEMORY_ATTRIBUTES2 overwrites _all_ attributes.  These flows
 	 * need significant enhancements to support multiple attributes.
 	 */
 	TEST_ASSERT(!attributes || attributes == KVM_MEMORY_ATTRIBUTE_PRIVATE,
 		    "Update me to support multiple attributes!");
 
-	vm_ioctl(vm, KVM_SET_MEMORY_ATTRIBUTES, &attr);
+	__TEST_REQUIRE(kvm_check_cap(KVM_CAP_MEMORY_ATTRIBUTES2) > 0,
+		       "No valid attributes for VM fd ioctl!");
+
+	vm_ioctl(vm, KVM_SET_MEMORY_ATTRIBUTES2, &attr);
 }
 
 

-- 
2.53.0.1018.g2bb0e51243-goog

